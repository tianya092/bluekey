package com.bluekey;

import javax.naming.AuthenticationException;
import javax.naming.Context;
import javax.naming.NamingEnumeration;
import javax.naming.NamingException;
import javax.naming.directory.*;
import java.io.UnsupportedEncodingException;
import java.util.Enumeration;
import java.util.Hashtable;
import java.util.Properties;
import java.util.Vector;

/* HOW GROUP SEARCHING WORKS

 Searching a 'flat' groups (depth 0)
 1) Bind to Bluepages
 2) Search Bluepages for DN of person
 3) Search Bluegroups to see if person is in group
 4) Unbind Bluepages

 Searching a group (depth n)
 1) Bind to Bluepages
 2) Search Bluepages for DN of person
 3) Search Bluegroups to see if person is in group
 4) If person in group, go to step 7
 5) if (depth-- >= 0) Search Bluegroups for all groupDN's in current group else goto step 7
 6) Goto 3
 7) Unbind Bluepages

 */

/**
 * LDAP is a class containing methods for authenticating and group querying
 *
 * @author Brian Olore
 * @version 3
 */

public class LDAP {
	private String SEARCH_BASE = "ou=bluepages,o=ibm.com";
	private String MEMBERLIST_BASE = "ou=memberlist,ou=ibmgroups,o=ibm.com";
	private String METADATA_BASE = "ou=metadata,ou=ibmgroups,o=ibm.com";
	private static final String DEFAULT_BLUEPAGES_LDAP_SERVER = "ldap://bluepages.ibm.com:636";
	private static final String DEFAULT_BLUEGROUPS_LDAP_SERVER = "ldap://bluegroups.ibm.com:636";
	private static final int DEFAULT_LDAP_VERSION = 3;
	private static final int DEFAULT_DEPTH = 0;
	private String HTTPS_BASE = "https://bluepages.ibm.com/tools/groups/protect/groups.wss";
	private int CONNTIMEOUT = 30000;
	private int SEARCHTIMELIMIT = 0;

	private String bluepages_ldap_server;
	private String bluegroups_ldap_server;
	private String ldap_version = "3";
	private boolean useThreaded = false;
	private ThreadGroup thread_group = null;

	public static final String EVERYONE = "Everyone";
	public static final String OWN_ADMIN = "Owner/Admins";
	public static final String MEMBERLIST = "members";
	public static final String FILTER = "filter";

	static {
		try {
			/*** SUN JSSE ***/
			// java.security.Security.addProvider(new
			// com.sun.net.ssl.internal.ssl.Provider());
			// System.setProperty("java.protocol.handler.pkgs","com.sun.net.ssl.internal.www.protocol");
			/***          ***/

			/*** IBM JSSE ***/
			// java.security.Security.addProvider(new
			// com.ibm.cpc.jsse.JSSEProvider());
			System.setProperty("java.protocol.handler.pkgs", "com.ibm.cpc.net.ssl.internal.www.protocol");
		} catch (Exception e) {
			System.err.println(e);
			e.printStackTrace();
		}
	}

	/**
	 * Default Constuctor
	 *
	 */
	public LDAP() {
		initialize(DEFAULT_BLUEPAGES_LDAP_SERVER, DEFAULT_BLUEGROUPS_LDAP_SERVER, DEFAULT_LDAP_VERSION, SEARCH_BASE,
				MEMBERLIST_BASE, METADATA_BASE, HTTPS_BASE);
	}

	/**
	 * Constructor which allows you to specify the Bluepages server and
	 * Bluegroups server to use
	 *
	 * @param bluepages
	 *            The hostname of the Bluepages server to use
	 * @param bluegroups
	 *            The hostname of the Bluegroups server to use
	 */
	// public LDAP(String bluepages, String bluegroups) {
	// initialize(bluepages, bluegroups, DEFAULT_LDAP_VERSION, SEARCH_BASE,
	// MEMBERLIST_BASE, METADATA_BASE, HTTPS_BASE);
	// }

	/**
	 * Constructor which allows you to specify the Bluepages server and
	 * Bluegroups server and ldap version to use
	 *
	 * @param bluepages
	 *            The hostname of the Bluepages server to use
	 * @param bluegroups
	 *            The hostname of the Bluegroups server to use
	 * @param v
	 *            The version of LDAP Server you are connecting to
	 */
	/*
	 * public LDAP(String bluepages, String bluegroups, int v) {
	 * initialize(bluepages, bluegroups, v, SEARCH_BASE, MEMBERLIST_BASE,
	 * METADATA_BASE, HTTPS_BASE); }
	 */

	/**
	 * Constructor which allows you to specify the Bluepages server and
	 * Bluegroups server and ldap version to use
	 *
	 * @param bluepages
	 *            The hostname of the Bluepages server to use
	 * @param bluegroups
	 *            The hostname of the Bluegroups server to use
	 * @param v
	 *            The version of LDAP Server you are connecting to
	 * @param bp_base
	 *            search base for people searches
	 * @param memberlist_base
	 *            search base for group member list
	 * @param metadata_base
	 *            search base for group metadata
	 * @param https_base
	 *            The HTTP URL to connect to GUI, default it
	 *            http://w3.ibm.com/tools/groups/protect/groups.wss
	 */
	public LDAP(String bluepages, String bluegroups, int v, String bp_base, String memberlist_base,
			String metadata_base, String https_base) {
		initialize(bluepages, bluegroups, v, bp_base, memberlist_base, metadata_base, https_base);
	}

	private void initialize(String bluepages, String bluegroups, int v, String bp_base, String memberlist_base,
			String metadata_base, String https_base) {
		if (bluepages.startsWith("ldaps://") == true) {
			bluepages_ldap_server = "ldap://" + bluepages.substring(8, bluepages.length());

			if (bluepages.endsWith(":636") == false) {
				bluepages_ldap_server = bluepages_ldap_server + ":636";
			}
		} else if (bluepages.startsWith("ldap://") == true) {
			if (bluepages.endsWith(":389") == false && bluepages.endsWith(":636") == false) {
				bluepages_ldap_server = bluepages + ":389";
			} else {
				bluepages_ldap_server = bluepages;
			}
		} else {
			if (bluepages.endsWith(":389") == false && bluepages.endsWith(":636") == false) {
				bluepages_ldap_server = "ldap://" + bluepages + ":389";
			} else {
				bluepages_ldap_server = "ldap://" + bluepages;
			}
		}

		if (bluegroups.startsWith("ldaps://") == true) {
			bluegroups_ldap_server = "ldap://" + bluegroups.substring(8, bluegroups.length());

			if (bluegroups.endsWith(":636") == false) {
				bluegroups_ldap_server = bluegroups_ldap_server + ":636";
			}
		} else if (bluegroups.startsWith("ldap://") == true) {
			if (bluegroups.endsWith(":389") == false && bluegroups.endsWith(":636") == false) {
				bluegroups_ldap_server = bluegroups + ":389";
			} else {
				bluegroups_ldap_server = bluegroups;
			}
		} else {
			if (bluegroups.endsWith(":389") == false && bluegroups.endsWith(":636") == false) {
				bluegroups_ldap_server = "ldap://" + bluegroups + ":389";
			} else {
				bluegroups_ldap_server = "ldap://" + bluegroups;
			}
		}

		ldap_version = new Integer(v).toString();

		if (bp_base != null) {
			SEARCH_BASE = bp_base;
		}

		if (memberlist_base != null) {
			MEMBERLIST_BASE = memberlist_base;
		}

		if (metadata_base != null) {
			METADATA_BASE = metadata_base;
		}

		if (https_base != null) {
			HTTPS_BASE = https_base;
		}
	}

	/**
	 * @deprecated No longer needed, use set methods instead
	 *
	 * @return ReturnCode based on result
	 */
	// public ReturnCode init(){return init(false, 0, 0);}

	/**
	 * @deprecated No longer needed, use set methods instead
	 *
	 * @param _useThreaded
	 *            Specify true to use multiple threads when searching nested
	 *            groups
	 *
	 * @return ReturnCode based on result
	 */
	// public ReturnCode init(boolean _useThreaded){return init(_useThreaded, 0,
	// 0);}

	/**
	 * @deprecated No longer needed, use set methods instead
	 *
	 * @param conntimeout
	 *            Connection to LDAP timeout in ms
	 * @param searchtimelimit
	 *            Search to LDAP timelimit in ms
	 *
	 * @return ReturnCode based on result
	 */
	// public ReturnCode init(int conntimeout, int searchtimelimit){return
	// init(false, conntimeout, searchtimelimit);}

	/**
	 * @deprecated No longer needed, use set methods instead
	 *
	 * @param _useThreaded
	 *            Specify true to use multiple threads when searching nested
	 *            groups
	 * @param conntimeout
	 *            Connection to LDAP timeout in ms
	 * @param searchtimelimit
	 *            Search to LDAP timelimit in ms
	 *
	 * @return ReturnCode based on result
	 */
	/*
	 * public ReturnCode init(boolean _useThreaded, int conntimeout, int
	 * searchtimelimit) { CONNTIMEOUT = conntimeout; SEARCHTIMELIMIT =
	 * searchtimelimit;
	 *
	 * useThreaded = _useThreaded; if (useThreaded) thread_group = new
	 * ThreadGroup("MyThreadGroup"); return true; }
	 */

	/**
	 * Uses threaded searches to determine if a member is in a Group
	 *
	 * @param _useThreaded
	 */
	public void setUseThreaded(boolean _useThreaded) {
		useThreaded = _useThreaded;
		if (useThreaded)
			thread_group = new ThreadGroup("MyThreadGroup");
	}

	/**
	 * Set the LDAP connection timeout
	 *
	 * @param conntimeout
	 *            Connection timeout in milliseconds
	 */
	public void setConnTimeOut(int conntimeout) {
		CONNTIMEOUT = conntimeout;
	}

	/**
	 * Set the LDAP search timeout
	 *
	 * @param searchtimelimit
	 *            Search timeout in milliseconds
	 */
	public void setSearchTimeOut(int searchtimelimit) {
		SEARCHTIMELIMIT = searchtimelimit;
	}

	/**
	 * @deprecated No longer needed since cleanup is done in every method
	 */
	public void cleanup() {
	}

	private void cleanupCtx(DirContext ctx) {
		if (ctx != null) {
			try {
				ctx.close();
			} catch (Throwable t) {
			}
			ctx = null;
		}
	}

	private void cleanupNamingEnum(NamingEnumeration ne) {
		if (ne != null) {
			try {
				// Iterate through enumeration due to JNDI bug in JRE 1.3.1
				while (ne.hasMore()) {
					SearchResult sr = (SearchResult) ne.next();
				}
			} catch (Throwable t) {
			}

			try {
				ne.close();
			} catch (Throwable t) {
			}

			ne = null;
		}
	}

	/**
	 * Autenticates a user, using the default ldap server
	 *
	 * @param email
	 *            The user's internet email address as listed in Bluepages
	 * @param pw
	 *            The user's password
	 * @return ReturnCode based on result
	 */
	public boolean authenticate(String email, String pw) {
		return authenticate(email, pw, bluepages_ldap_server);
	}

	/**
	 * Autenticates a user, using a user given ldap server
	 *
	 * @param email
	 *            The user's internet email address as listed in Bluepages
	 * @param pw
	 *            The user's password
	 * @param server
	 *            The LDAP Server to use for authentication
	 * @return ReturnCode based on result
	 */
	public boolean authenticate(String email, String pw, String server) {
		return authenticate("mail", email, pw, server);
	}

	/**
	 * Autenticates a user, using a user given ldap server
	 *
	 * @param attrval
	 *            The user's attribute to search on
	 * @param attrname
	 *            The user's value to search for
	 * @param pw
	 *            The user's password
	 * @param server
	 *            The LDAP Server to use for authentication, it should be FQDN
	 *            ldap://servername:port
	 * @return ReturnCode based on result
	 */
	public boolean authenticate(String attrname, String attrval, String pw, String server) {
		// new as of 07.25.2001 ... check for null or blanks!
		if (attrname == null || attrname.equals("") || attrval == null || attrval.equals(""))
			return false;

		if (pw == null || pw.equals(""))
			return false;

		String DN = new String();

		if (server.startsWith("ldap://") == false) {
			server = "ldap://" + server;
		}

		if (server.endsWith(":389") == false || server.endsWith(":636") == false) {
			server = server + ":636";
		}

		String sserver = server.substring(0, server.indexOf(":", 10)) + ":636";
		// server = server.substring(0, server.indexOf(":", 10)) + ":389";

		Properties env1 = new Properties();
		env1.put(Context.INITIAL_CONTEXT_FACTORY, "com.sun.jndi.ldap.LdapCtxFactory");
		env1.put("java.naming.ldap.derefAliases", "never");
		env1.put("java.naming.ldap.version", ldap_version);
		env1.put(Context.REFERRAL, "follow");
		env1.put("java.naming.ldap.referral.bind", "true");

		if (bluepages_ldap_server.endsWith("636")) {
			env1.put(Context.SECURITY_PROTOCOL, "ssl");
			env1.put(Context.PROVIDER_URL, sserver);
		} else {
			env1.put(Context.PROVIDER_URL, server);
		}

		Vector v = new Vector();
		Hashtable h = new Hashtable();

		DirContext ctx = null;
		NamingEnumeration results = null;

		try {
			String attrlist[] = { "uid" };
			String filter = "(" + attrname + "=" + attrval + ")";
			SearchControls constraints = new SearchControls();
			constraints.setSearchScope(SearchControls.SUBTREE_SCOPE);
			constraints.setTimeLimit(SEARCHTIMELIMIT);
			constraints.setReturningAttributes(attrlist);
			ctx = new InitialDirContext(env1);
			results = ctx.search(SEARCH_BASE, filter, constraints);

			SearchResult sr;
			Attributes attrs;
			Attribute attr;
			Enumeration vals;
			Object q;
			while (results.hasMore()) {
				sr = (SearchResult) results.next();
				attrs = sr.getAttributes();
				// snag the DN
				// System.out.println(attrs);
				DN = sr.getName() + "," + SEARCH_BASE;

				h = new Hashtable();
				for (NamingEnumeration ae = attrs.getAll(); ae.hasMore();) {
					attr = (Attribute) ae.next();
					vals = attr.getAll();
					q = vals.nextElement();
					try {
						h.put(attr.getID(), (String) q);
					} // put the String in the hash
					catch (ClassCastException cce) // it's not a String, so
					// "decode" it (int'l chars)
					{
						try {
							byte b[] = (byte[]) q;
							String s = new String(b, "ISO-8859-1"); // "UTF8");
							// //UTF8
							// doesn't
							// work for
							// "palmero"
							h.put(attr.getID(), s); // put the string in the
							// hash
						} catch (UnsupportedEncodingException ue) {
						}
					}
				}
				if (h.size() > 0)
					v.addElement(h); // no reason to add the hash if it is empty
			}

		} catch (NamingException ne) {
			System.err.println("[LDAP] authenticate: " + ne);
			ne.printStackTrace();
			return false;
		} finally {
			cleanupNamingEnum(results);
			cleanupCtx(ctx);
		}

		if (v.size() == 0)
			return false;
		else if (v.size() > 1)
			return false;

		Properties env = new Properties();
		env.put(Context.INITIAL_CONTEXT_FACTORY, "com.sun.jndi.ldap.LdapCtxFactory");
		env.put("java.naming.ldap.derefAliases", "never");
		env.put(Context.PROVIDER_URL, sserver);
		env.put("java.naming.ldap.version", ldap_version);
		env.put(Context.SECURITY_AUTHENTICATION, "simple");
		env.put(Context.SECURITY_PRINCIPAL, DN);
		env.put(Context.SECURITY_CREDENTIALS, pw);
		env.put(Context.REFERRAL, "follow");
		env.put("java.naming.ldap.referral.bind", "true");
		env.put(Context.SECURITY_PROTOCOL, "ssl");

		try {
			ctx = new InitialDirContext(env);
		} catch (AuthenticationException ae) {
			return false;
		} catch (NamingException ne) {
			System.err.println("[LDAP] authenticate: " + ne);
			ne.printStackTrace();
			return false;
		} finally {
			cleanupCtx(ctx);
		}

		return true;
	}

	/**
	 * Autenticates a user, using the default ldap server, throws Exceptions on
	 * failure.
	 *
	 * @param email
	 *            The user's internet email address as listed in Bluepages
	 * @param pw
	 *            The user's password
	 * @return true if the user is authenticated
	 * @exception NamingException
	 *                An error has occurred
	 * @throws NamingException
	 *             An error has occurred
	 */
	public boolean authenticate_throw(String email, String pw) throws NamingException {
		return authenticate_throw(email, pw, bluepages_ldap_server);
	}

	/**
	 * Autenticates a user, throws Exceptions on failure
	 *
	 * @param server
	 *            The LDAP Server to use for authentication
	 * @param email
	 *            The user's internet email address as listed in Bluepages
	 * @param pw
	 *            The user's password
	 * @return true If the user is authenticated
	 * @exception NamingException
	 *                An error has occurred
	 * @throws NamingException
	 *             An error has occurred
	 */
	public boolean authenticate_throw(String email, String pw, String server) throws NamingException {
		return authenticate_throw("mail", email, pw, server);
	}

	/**
	 * Autenticates a user, throws Exceptions on failure
	 *
	 * @param attrval
	 *            The user's attribute to search on
	 * @param attrname
	 *            The user's value to search for
	 * @param pw
	 *            The user's password
	 * @param server
	 *            The LDAP Server to use for authentication
	 * @return true If the user is authenticated
	 * @exception NamingException
	 *                An error has occurred
	 * @throws NamingException
	 *             An error has occurred
	 */
	public boolean authenticate_throw(String attrname, String attrval, String pw, String server)
			throws NamingException {
		// new as of 07.25.2001 ... check for null or blanks!
		if (attrname == null || attrname.equals("") || attrval == null || attrval.equals(""))
			throw new NamingException("mail is either NULL or blank");

		if (pw == null || pw.equals(""))
			throw new NamingException("password is either NULL or blank");

		String DN = new String();
		String sserver = server.substring(0, server.indexOf(":", 10)) + ":636";
		server = server.substring(0, server.indexOf(":", 10)) + ":389";

		Properties env1 = new Properties();
		env1.put(Context.INITIAL_CONTEXT_FACTORY, "com.sun.jndi.ldap.LdapCtxFactory");
		env1.put("java.naming.ldap.derefAliases", "never");
		env1.put("java.naming.ldap.version", ldap_version);
		env1.put(Context.REFERRAL, "follow");
		env1.put("java.naming.ldap.referral.bind", "true");

		if (bluepages_ldap_server.endsWith("636")) {
			env1.put(Context.SECURITY_PROTOCOL, "ssl");
			env1.put(Context.PROVIDER_URL, sserver);
		} else {
			env1.put(Context.PROVIDER_URL, server);
		}

		Vector v = new Vector();
		Hashtable h = new Hashtable();

		String attrlist[] = { "uid" };
		String filter = "(" + attrname + "=" + attrval + ")";
		SearchControls constraints = new SearchControls();
		constraints.setSearchScope(SearchControls.SUBTREE_SCOPE);
		constraints.setTimeLimit(SEARCHTIMELIMIT);
		constraints.setReturningAttributes(attrlist);

		DirContext ctx = null;
		NamingEnumeration results = null;

		try {
			ctx = new InitialDirContext(env1);
			results = ctx.search(SEARCH_BASE, filter, constraints);

			SearchResult sr;
			Attributes attrs;
			Attribute attr;
			Enumeration vals;
			Object q;
			while (results.hasMore()) {
				sr = (SearchResult) results.next();
				attrs = sr.getAttributes();
				// snag the DN
				DN = sr.getName() + "," + SEARCH_BASE;

				h = new Hashtable();
				for (NamingEnumeration ae = attrs.getAll(); ae.hasMore();) {
					attr = (Attribute) ae.next();
					vals = attr.getAll();
					q = vals.nextElement();
					try {
						h.put(attr.getID(), (String) q);
					} // put the String in the hash
					catch (ClassCastException cce) // it's not a String, so
					// "decode" it (int'l chars)
					{
						try {
							byte b[] = (byte[]) q;
							String s = new String(b, "ISO-8859-1"); // "UTF8");
							// //UTF8
							// doesn't
							// work for
							// "palmero"
							h.put(attr.getID(), s); // put the string in the
							// hash
						} catch (UnsupportedEncodingException ue) {
						}
					}
				}
				if (h.size() > 0)
					v.addElement(h); // no reason to add the hash if it is empty
			}
		} finally {
			cleanupNamingEnum(results);
			cleanupCtx(ctx);
		}

		if (v.size() == 0) {
			return false;
		} else if (v.size() > 1) {
			return false;
		}

		Properties env = new Properties();

		env.put(Context.INITIAL_CONTEXT_FACTORY, "com.sun.jndi.ldap.LdapCtxFactory");
		env.put("java.naming.ldap.derefAliases", "never");
		env.put(Context.PROVIDER_URL, sserver);
		env.put("java.naming.ldap.version", ldap_version);
		env.put(Context.SECURITY_AUTHENTICATION, "simple");
		env.put(Context.SECURITY_PRINCIPAL, DN);
		env.put(Context.SECURITY_CREDENTIALS, pw);
		env.put(Context.REFERRAL, "follow");
		env.put("java.naming.ldap.referral.bind", "true");
		env.put(Context.SECURITY_PROTOCOL, "ssl");

		try {
			ctx = new InitialDirContext(env);
		} catch (AuthenticationException ae) {
			throw new NamingException(ae.toString());
		} finally {
			cleanupCtx(ctx);
		}

		return true;
	}

}
