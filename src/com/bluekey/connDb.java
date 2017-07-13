package com.bluekey;
import java.sql.*;
import java.text.SimpleDateFormat;
import java.util.*;
import java.util.Date;

import org.json.JSONObject;

public class connDb {
	private static String username;
	private static String password;
	
	private static String host;
	private static int port;
	private static String database;
	
	private static Connection con = null;
	private static Statement stmt = null;
	private static ResultSet rs = null;
	private static ResultSet result = null;
	
	static Map<String,String> AccessMap =  new HashMap<String,String>();
	
	//杩炴帴鏁版嵁搴撴柟娉�
	public static void startConn(){
		try{
			Class.forName("com.mysql.jdbc.Driver");
			//杩炴帴鏁版嵁搴撲腑闂翠欢
			try{
				if (System.getenv("VCAP_SERVICES") != null) {
					JSONObject blueMailJson = new JSONObject(System.getenv("VCAP_SERVICES"));
					JSONObject blueMailCredentials = blueMailJson.getJSONArray("mysql")
							.getJSONObject(0).getJSONObject("credentials");
					
					username = blueMailCredentials.getString("username");
					password = blueMailCredentials.getString("password");
					host = blueMailCredentials.getString("host");
					port = blueMailCredentials.getInt("port");
					database = blueMailCredentials.getString("name");
					con = DriverManager.getConnection("jdbc:MySQL://"+host+":"+port+"/"+database,username,password);
				} else {
					// not running on Bluemix Dedicated (e.g. running in Eclipse) - use hard coded credentials
					con = DriverManager.getConnection("jdbc:MySQL://localhost:3306/bluekey","root","root");
				}	
			}catch(SQLException e){
				e.printStackTrace();
			}
		}catch(ClassNotFoundException e){
			e.printStackTrace();
		}
	}
	
	
	//鍏抽棴杩炴帴鏁版嵁搴撴柟娉�
	public static void endConn() throws SQLException{
		if(con != null){
			con.close();
			con = null;
		}
		if(rs != null){
			rs.close();
			rs = null;
		}
		if(stmt != null){
			stmt.close();
			stmt = null;
		}
	}
/***************************************Access*********************************************/
	
	//resultList
		public static  ArrayList result(String role_id) throws SQLException{
			ArrayList<Map<String,String>> list = new ArrayList();
			String sql;
		    startConn();
		    stmt = con.createStatement();
		    rs = stmt.executeQuery("select access_id,short_title from access where deleted = 0");
		    while(rs.next()){
		    	AccessMap.put(rs.getString("access_id"),rs.getString("short_title"));
		    }
		    /*if(role_id==null||role_id.equals("")){
		    	sql = "select * from role where deleted = '0' and role_id = "+role_id;
		    }else{
		    	//sql = "select * from role where role_id = (select role_id from user where Email= '"+email+"' )";
		    	sql = "select * from role where deleted = '0' and role_id = 1";
		    }*/
		    sql = "select * from role where deleted = '0' and role_id = "+role_id;
		    rs = stmt.executeQuery(sql);
		    while(rs.next()){
		    	String[] generalArr = rs.getString("general_access").split(",");
		    	Map<String,String> generalMap = new HashMap<String,String>();
		    	for(int i=0;i<generalArr.length; i++){
		    		if(AccessMap.containsKey (generalArr[i])){
		    			generalMap.put(generalArr[i], AccessMap.get(generalArr[i]));
		    		}
			    	
		    	}
		    	
		    	String[] functionArr = rs.getString("function_access").split(",");
		    	Map<String,String> functionMap = new HashMap<String,String>();
		    	for(int i=0;i<functionArr.length; i++){
		    		if(AccessMap.containsKey (functionArr[i])){
		    			functionMap.put(functionArr[i], AccessMap.get(functionArr[i]));
		    		}
		    	}
		    	
		    	String[] othersArr = rs.getString("others_access").split(",");
		    	Map<String,String> othersMap = new HashMap<String,String>();
		    	for(int i=0;i<othersArr.length; i++){
		    		if(AccessMap.containsKey (functionArr[i])){
		    			othersMap.put(othersArr[i], AccessMap.get(othersArr[i]));
		    		}
		    	}
		    	
		    	list.add(generalMap);
		    	list.add(functionMap);
		    	list.add(othersMap);
		    }
		    endConn();
			return list;
		}
	
	//query access detail info
	public static  Access accessDetail(String access_id) throws SQLException{
		Map<String,Access> detailMap = new HashMap<>();
		Access access = new Access();
	    startConn();
	    stmt = con.createStatement();
	    rs = stmt.executeQuery("select * from access where access_id ="+access_id+" and deleted = 0");
	    while(rs.next()){
	    	access.setAccessId(rs.getInt("access_id"));
	    	access.setTitle(rs.getString("title"));
	    	access.setShortTitle(rs.getString("short_title"));
	    	access.setFunction(rs.getString("function"));
	    	access.setPlatform(rs.getString("platform"));
	    	access.setApplyEmail(rs.getString("apply_email"));
	    	access.setUrl(rs.getString("url"));
	    	access.setApplyStep(rs.getString("apply_step"));
	    	access.setLeadTime(rs.getInt("lead_time"));
	    	access.setParentPart(rs.getInt("parent_part"));
	    }
	    
	    endConn();
		return access;
	}
	
	//update access detail info
	public static  Boolean updateAccessDetail(Access access) throws SQLException{
		boolean flag = false;
		int access_id = access.getAccessId();
		String sql ;
		PreparedStatement ps;
		try{
			Date dNow = new Date( );
		    SimpleDateFormat ft =  new SimpleDateFormat ("yyyy-MM-dd hh:mm:ss");
		    startConn();
		    if(access_id!=0){
		    	//update access
		    	sql = "update access set title=?,short_title=?,function=?,platform=?,url=?,apply_email=?,lead_time=?,apply_step=?,update_time=?,parent_part=? where access_id="+access_id;
		    }else{
		    	sql = "insert into access(title,short_title,function,platform,url,apply_email,lead_time,apply_step,create_time,parent_part)values(?,?,?,?,?,?,?,?,?,?)";
		    }
		    
		    ps = con.prepareStatement(sql);
	    	ps.setString(1, access.getTitle());
	    	ps.setString(2, access.getShortTitle());
	    	ps.setString(3, access.getFunction());
	    	ps.setString(4, access.getPlatform());
	    	ps.setString(5, access.getUrl());
	    	ps.setString(6, access.getApplyEmail());
	    	ps.setInt(7, access.getLeadTime());
	    	ps.setString(8, access.getApplyStep());
	    	ps.setString(9, ft.format(dNow));
	    	ps.setInt(10, access.getParentPart());
			ps.executeUpdate();
	    	ps.close();
		    flag = true;
	    }catch(SQLException e) {   
            e.printStackTrace();   
	    }finally {
		    endConn();
		}
		return flag;
	}
	
	//delete accesss 
	public static  boolean deleteAccess(Access access) throws SQLException{
		boolean flag = false;
		PreparedStatement ps;
		int access_id = access.getAccessId();
		Date dNow = new Date( );
	    SimpleDateFormat ft =  new SimpleDateFormat ("yyyy-MM-dd hh:mm:ss");
		try{
			startConn();
		    String sql = "update access set deleted =?,update_time=? where access_id = "+access_id;
	    	ps = con.prepareStatement(sql);
	    	ps.setInt(1, 1);
	    	ps.setString(2, ft.format(dNow));
	    	ps.executeUpdate();
	    	ps.close();
		    flag = true;
    	}catch(SQLException e) {   
            e.printStackTrace();   
	    }finally {
		    endConn();
		}
		return flag;
	}
	
	
	//query accesss list
	public static  ArrayList getAccessList() throws SQLException{
		ArrayList<Access> Accesslist = new ArrayList();
		startConn();
	    stmt = con.createStatement();
	    rs = stmt.executeQuery("select * from access where deleted = 0 order by parent_part ASC");
	    while(rs.next()){
	    	Access access = new Access();
	    	access.setAccessId(rs.getInt("access_id"));
	    	access.setTitle(rs.getString("title"));
	    	access.setShortTitle(rs.getString("short_title"));
	    	access.setFunction(rs.getString("function"));
	    	access.setPlatform(rs.getString("platform"));
	    	access.setApplyEmail(rs.getString("apply_email"));
	    	access.setUrl(rs.getString("url"));
	    	access.setApplyStep(rs.getString("apply_step"));
	    	access.setLeadTime(rs.getInt("lead_time"));
	    	access.setParentPart(rs.getInt("parent_part"));
	    	
	    	Accesslist.add(access);
	    }

	    endConn();
		return Accesslist;
	}
	
	public static  Map getAccessList1() throws SQLException{
		Map<String,ArrayList<String[]>> accessMap = new HashMap();
	    startConn();
	    stmt = con.createStatement();
	    rs = stmt.executeQuery("select * from access where deleted = 0 and parent_part= 1 ");
	    ArrayList<String[]> generalList = new ArrayList();
	    while(rs.next()){
	    	String[] temp={rs.getString("access_id"),rs.getString("title"),rs.getString("short_title")};
	    	generalList.add(temp);
	    }
	    
	    rs = stmt.executeQuery("select * from access where deleted = 0 and parent_part= 2 ");
	    ArrayList<String[]> functionList = new ArrayList();
	    while(rs.next()){
	    	String[] temp={rs.getString("access_id"),rs.getString("title"),rs.getString("short_title")};
	    	functionList.add(temp);
	    }
	    
	    rs = stmt.executeQuery("select * from access where deleted = 0 and parent_part= 3 ");
	    ArrayList<String[]> otherList = new ArrayList();
	    while(rs.next()){
	    	String[] temp={rs.getString("access_id"),rs.getString("title"),rs.getString("short_title")};
	    	otherList.add(temp);
	    }
	    
    	accessMap.put("generalList",generalList);
    	accessMap.put("functionList",functionList);
    	accessMap.put("otherList",otherList);
    
	    endConn();
		return accessMap;
	}
	
	
	//check user's access list
	public static boolean checkUserAccess(String user_id,String access_id) throws SQLException{
		boolean accessRight = false;
		String[] generalArr = null ;
		String[] functionArr = null;
		String[] othersArr = null;
		
	    startConn();
	    stmt = con.createStatement();
	    rs = stmt.executeQuery("select * from role where role_id = (select role_id from user where user_id= '"+user_id+"' )");
	    if(rs.next()){
	    	generalArr = rs.getString("general_access").split(",");
	    	functionArr = rs.getString("function_access").split(",");
	    	othersArr = rs.getString("others_access").split(",");
	    }
	    
	    String[] accessArr = concat(generalArr,functionArr);
	    accessArr = concat(accessArr,othersArr);
	    Arrays.sort(accessArr);
	    
	    if(Arrays.binarySearch(accessArr, access_id)>=0){
	    	accessRight = true;
	    }
	    endConn();
		return accessRight;
	}
			
/***************************************User*********************************************/		
	//update user 
	public static  boolean updataUser(String email) throws SQLException{
		boolean flag = false;
		Date dNow = new Date( );
	    SimpleDateFormat ft = 
	    new SimpleDateFormat ("yyyy-MM-dd hh:mm:ss");
	    startConn();
	    stmt = con.createStatement();
	    result = stmt.executeQuery("select * from user where Email ='"+email+"' and deleted = 0");
	    if(result.next()==false){
	    	String sql = "insert into user(Email,w3_no,actived,create_time,role_id)values(?,?,?,?,?)";
	    	PreparedStatement ps = con.prepareStatement(sql);
	    	ps.setString(1, email);
	    	ps.setString(2, email);
	    	ps.setInt(3, 1);
	    	ps.setString(4, ft.format(dNow));
	    	ps.setInt(5, 1);
	    	ps.executeUpdate();
	    	ps.close();
	    	
	    }
	    endConn();
		return flag;
	}
	
	//query user information
	public static User getUser(String email) throws SQLException{
		User user = new User();
	    startConn();
	    stmt = con.createStatement();
	    rs = stmt.executeQuery("select * from user where Email ='"+email+"' and deleted = 0");
	    if(rs.next()){
	    	user.setUserId(rs.getInt("user_id"));
	    	user.setBelongDep(rs.getInt("actived"));
	    	user.setEmail(rs.getString("role_id"));
	    	user.setRemember(rs.getString("remember"));
	    }
	    
	    endConn();
		return user;
	}
	
	//check user_id is right or not
	public static boolean checkUserRight(String email,String user_id) throws SQLException{
		boolean userRight = false;
	    startConn();
	    stmt = con.createStatement();
	    rs = stmt.executeQuery("select user_id,actived,role_id from user where email ='"+email+"'and user_id = '"+user_id+"' and deleted = 0");
	    if(rs.next()){
	    	userRight = true;
	    }
	    
	    endConn();
		return userRight;
	}
	
	
	
	//query user list
	public static  ArrayList getUserList() throws SQLException{
		ArrayList<String[]> Userlist = new ArrayList();
		startConn();
	    stmt = con.createStatement();
	    rs = stmt.executeQuery("select * from user where deleted = 0");
	    while(rs.next()){
	    	String[] temp={rs.getString("user_id"),rs.getString("Email"),rs.getString("create_time")};
	    	Userlist.add(temp);
	    }

	    endConn();
		return Userlist;
	}
	
	
/***************************************Role*********************************************/
		
	//query role detail info
	public static  Role getRole(String role_id) throws SQLException{
		Role role = new Role();
	    startConn();
	    stmt = con.createStatement();
	    rs = stmt.executeQuery("select * from role where role_id = "+role_id);
	    while(rs.next()){
	    	role.setGeneralAccess(rs.getString("general_access"));
	    	role.setFunctionAccess(rs.getString("function_access"));
	    	role.setOthersAccess(rs.getString("others_access"));
	    	role.setFunction(rs.getInt("function"));
	    	role.setTeam(rs.getInt("team"));
	    	role.setJobRole(rs.getInt("job_role"));
	    	role.setCommodity(rs.getInt("commodity"));
	    }
	    endConn();
		return role;
	}
	
	//query role_id
	public static  int queryRole(Role role) throws SQLException{
		int role_id = 0 ;
	    int function = role.getFunction();
	    int team = role.getTeam();
	    int job_role =role.getJobRole();
	    int commodity = role.getCommodity();
	    String sql = "";
	    try{
	    	startConn();
		    stmt = con.createStatement();
		    if(commodity==0){
		    	sql = "select * from role where deleted = 0 and  function = "+function+" and team ="+team+" and job_role ="+job_role ;
		    }else{
		    	sql = "select * from role where deleted = 0 and  function = "+function+" and team ="+team+" and job_role ="+job_role +" and commodity =" +commodity;
		    }
		    
		    rs = stmt.executeQuery(sql);
		    while(rs.next()){
		    	role_id = rs.getInt("role_id");
		    	
		    }
	    }catch(SQLException e) {   
            e.printStackTrace();   
	    }finally {
		    endConn();
		}
	    
		return role_id;
	}
	
	//update role detail info
	public static  boolean updateRole(Role role) throws SQLException{
		boolean flag = false;
		int role_id = role.getRoleId();
		
		String sql ;
		PreparedStatement ps;
		try{
			Date dNow = new Date( );
		    SimpleDateFormat ft =  new SimpleDateFormat ("yyyy-MM-dd hh:mm:ss");
		    startConn();
		    if(role_id!=0){
		    	//update access
		    	sql = "update role set general_access=?,function_access=?,update_time=? where role_id="+role_id;
		    	ps = con.prepareStatement(sql);
		    	ps.setString(1, role.getGeneralAccess());
		    	ps.setString(2, role.getFunctionAccess());
		    	ps.setString(3, ft.format(dNow));
		    	ps.executeUpdate();
		    	ps.close();
		    	flag = true;
		    }else{
		    	
		    	sql = "insert into role(general_access,function_access,others_access,function,team,job_role,commodity,create_time)values(?,?,?,?,?,?,?,?)";
		    	ps = con.prepareStatement(sql);
		    	ps.setString(1, role.getGeneralAccess());
		    	ps.setString(2, role.getFunctionAccess());
		    	ps.setString(3, "");
		    	ps.setInt(4, role.getFunction());
		    	ps.setInt(5, role.getTeam());
		    	ps.setInt(6, role.getJobRole());
		    	ps.setInt(7, role.getCommodity());
		    	ps.setString(8, ft.format(dNow));
		    	ps.executeUpdate();
		    	ps.close();
		    	flag = true;
			    
		    }
	    }catch(SQLException e) {   
            e.printStackTrace();   
	    }finally {
		    endConn();
		}
		return flag;
	}
	
	
	//delete role 
	public static  boolean deleteRole(String role_id) throws SQLException{
		boolean flag = false;
		PreparedStatement ps;
		Date dNow = new Date( );
	    SimpleDateFormat ft =  new SimpleDateFormat ("yyyy-MM-dd hh:mm:ss");
		try{
			startConn();
		    String sql = "update role set deleted =?,update_time=? where role_id = "+role_id;
	    	ps = con.prepareStatement(sql);
	    	ps.setInt(1, 1);
	    	ps.setString(2, ft.format(dNow));
	    	ps.executeUpdate();
	    	ps.close();
		    flag = true;
    	}catch(SQLException e) {   
            e.printStackTrace();   
	    }finally {
		    endConn();
		}
		return flag;
	}
		
	
	
	//get accesss list
	public static  ArrayList<Role> getRoleList() throws SQLException{
		ArrayList<Role> Rolelist = new ArrayList<Role>();
		startConn();
	    stmt = con.createStatement();
	    rs = stmt.executeQuery("select * from role where deleted = 0 order by function,team,job_role,commodity ASC");
	    while(rs.next()){
	    	Role role = new Role();
	    	role.setRoleId(rs.getInt("role_id"));
	    	role.setFunction(rs.getInt("function"));
	    	role.setTeam(rs.getInt("team"));
	    	role.setJobRole(rs.getInt("job_role"));
	    	role.setCommodity(rs.getInt("commodity"));
	    	Rolelist.add(role);
	    }

	    endConn();
		return Rolelist;
	}
	
	
	
	
/***************************************email template*********************************************/	
	//query mail_template data
	public static  Map getMailTemplate(String temp_id) throws SQLException{
		Map<String,String> MailMap = new HashMap<>();
	    startConn();
	    stmt = con.createStatement();
	    rs = stmt.executeQuery("select subject_title,content from mail_template where temp_id ='"+temp_id+"' and deleted = 0");
	    while(rs.next()){
	    	MailMap.put("subject_title",rs.getString("subject_title"));
	    	MailMap.put("content",rs.getString("content"));
	    }
	    
	    endConn();
		return MailMap;
	}
	
	
	/**
	*  更新邮件模板
	* @return boolean
	* @param  mail, username
	*/
	public static boolean updateMailTemplate(Mail mail,String username) throws SQLException{
		boolean flag = false;
		int access_id = mail.getAccessId();
		String sql ;
		
		PreparedStatement ps;
		try{
			Date dNow = new Date( );
		    SimpleDateFormat ft =  new SimpleDateFormat ("yyyy-MM-dd hh:mm:ss");
		    startConn();
		    stmt = con.createStatement();
		    rs = stmt.executeQuery("select * from access where access_id ="+access_id+" and deleted = 0");
		    if(rs.next()){
		    	//update mail template
		    	sql = "update mail_template set subject_title =?,content=?,update_time=?,update_operator=? where access_id = "+access_id;
		    	ps = con.prepareStatement(sql);
		    	ps.setString(1, mail.getSubjectTitle());
		    	ps.setString(2, mail.getContent());
		    	ps.setString(3, ft.format(dNow));
		    	ps.setString(4, username);
		    	ps.executeUpdate();
		    	ps.close();
		    	flag = true;
		    }else{
		    	
		    	sql = "insert into mail_template(subject_title,content,create_time,create_operator)values(?,?,?,?)";
		    	ps = con.prepareStatement(sql);
		    	ps.setString(1, mail.getSubjectTitle());
		    	ps.setString(2, mail.getContent());
		    	ps.setString(3, ft.format(dNow));
		    	ps.setString(4, username);
		    	ps.setInt(5, access_id);
		    	
		    	ps.executeUpdate();
		    	ps.close();
		    	flag = true;
			    
		    }
	    }catch(SQLException e) {   
            e.printStackTrace();   
	    }finally {
		    endConn();
		}
		return flag;
	}
/***************************************remember*********************************************/	
	/**
	*  记住提交的job role
	* @return boolean
	* @param  mail, username
	*/
	public static  boolean remember(User user) throws SQLException{
		boolean flag = false;
		PreparedStatement ps;
		Date dNow = new Date( );
	    SimpleDateFormat ft =  new SimpleDateFormat ("yyyy-MM-dd hh:mm:ss");
		try{
			startConn();
		    String sql = "update user set remember =?,update_time=? where user_id = "+user.getUserId();
	    	ps = con.prepareStatement(sql);
	    	ps.setString(1, user.getRemember());
	    	ps.setString(2, ft.format(dNow));
	    	ps.executeUpdate();
	    	ps.close();
		    flag = true;
    	}catch(SQLException e) {   
            e.printStackTrace();   
	    }finally {
		    endConn();
		}
		return flag;
	}
	
/***************************************other*********************************************/
	//two array to be one 
	public static String[] concat(String[] a, String[] b) {  
	   String[] c= new String[a.length+b.length];  
	   System.arraycopy(a, 0, c, 0, a.length);  
	   System.arraycopy(b, 0, c, a.length, b.length);  
	   return c;  
	}  
	
}
