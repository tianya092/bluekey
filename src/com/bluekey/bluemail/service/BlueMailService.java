package com.bluekey.bluemail.service;

import com.fasterxml.jackson.databind.MapperFeature;
import com.fasterxml.jackson.databind.ObjectMapper;

import java.util.ArrayList;
import java.util.Arrays;
import java.util.List;

import javax.ws.rs.client.Client;
import javax.ws.rs.client.ClientBuilder;
import javax.ws.rs.client.Entity;
import javax.ws.rs.client.WebTarget;
import javax.ws.rs.core.Response;
import javax.xml.bind.DatatypeConverter;

import org.json.JSONObject;

/**
 * Java Service to send email using the BlueMail Service from Liberty on Bluemix Dedicated.
 * IBM Internal Use Only
 * 
 * @author Robert De Jager (robert.dejager@fr.ibm.com)
 * @version 1.0
 * @since 2016-07-12
 *
 */
public class BlueMailService {

	boolean emailEnabled = true;

	private String username;
	private String password;
	private String emailUrl;

	/**
	 * constructor to initiate the BlueMailService
	 */
	public BlueMailService() {

		if (System.getenv("VCAP_SERVICES") != null) {
			JSONObject blueMailJson = new JSONObject(System.getenv("VCAP_SERVICES"));
			JSONObject blueMailCredentials = blueMailJson.getJSONArray("bluemailservice")
					.getJSONObject(0).getJSONObject("credentials");
			username = blueMailCredentials.getString("username");
			password = blueMailCredentials.getString("password");
			emailUrl = blueMailCredentials.getString("emailUrl");
			System.out.println("BlueEmailService init() BlueMail initiated username: " + username);
		} else {
			// not running on Bluemix Dedicated (e.g. running in Eclipse) - use hard coded credentials
			username = "<put your bluemail username here>";
			password = "<put your bluemail password here>";
			emailUrl = "https://bluemail.w3ibm.mybluemix.net/ptf/api/emails";
			System.out.println ("Email sending has been enabled with hard coded credentials");
		}	
	}

	/**
	 * Service to send the mail
	 * @param email
	 * @return
	 */
	public BlueMailResponse sendBlueMail(BlueMail email) {

		Client client;
		WebTarget target;

		String payload = new String();
		String responseString = new String();
		String statusCode = new String();
		BlueMailResponse bmr = new BlueMailResponse();

		try {
			if (emailEnabled) {

				client = ClientBuilder.newClient().register(new Authenticator(username, password));

				ObjectMapper objectMapper = new ObjectMapper();
				objectMapper.configure(MapperFeature.USE_ANNOTATIONS, true);

				payload = objectMapper.writeValueAsString(email);

				System.out.println ("Email JSON: " + payload);

				target = client.target(emailUrl);

				Response response = target.request().post(Entity.json(payload));

				responseString = response.readEntity(String.class);

				statusCode = new Integer(response.getStatus()).toString();
								
				// example getting response from JSON string
				System.out.println("Status Code from BlueMail API Call: " + statusCode);
				// System.out.println("sendBlueMail response: " + responseString);
				
				// example getting response from Java object
				bmr = objectMapper.readValue(responseString, BlueMailResponse.class);
				// System.out.println ("sendBlueMail response bmr.getEmail(): " + bmr.getEmail());
				
				response.close();
				
			} else {
				System.out.println ("Email sending has been disabled");
			}
		} catch (Exception e) {
			e.printStackTrace();
		} 	    	
		return bmr;
	}
	
	/**
	 * Service to check the status of the sent the mail
	 * @param email
	 * @return
	 */
	public String getStatus(String statusLink) {

		Client client;
		WebTarget target;
		String responseString = new String();
		
		// if the email link is empty retrieve the status of the BlueMail service
		if (statusLink.isEmpty()) {
			statusLink = emailUrl;
		}

		try {
			client = ClientBuilder.newClient();

			target = client.target(statusLink);

			Response response = target.request().get();

			responseString = response.readEntity(String.class);
			
			response.close();
		} catch (Exception e) {
			e.printStackTrace();
		} 	    	
		return responseString;
	}	

	/**
	 * Service to check the status of the sent the mail
	 * @param email
	 * @return
	 */
	public String resendMail(String resendLink, BlueMail email) {

		Client client;
		WebTarget target;
		String payload = new String();
		String responseString = new String();

		try {
			
			client = ClientBuilder.newClient().register(new Authenticator(username, password));

			ObjectMapper objectMapper = new ObjectMapper();
			objectMapper.configure(MapperFeature.USE_ANNOTATIONS, true);

			payload = objectMapper.writeValueAsString(email);

			System.out.println ("Email JSON resendMail: " + payload);
			
			// when the lines below are enabled the first post onclick from the browswer doesn't receive a response?
			target = client.target(resendLink);

			Response response = target.request().put(Entity.json(payload));

			responseString = response.readEntity(String.class);
			
			response.close();
		} catch (Exception e) {
			e.printStackTrace();
		} 	    	
		return responseString;
	}	
	
	
	/**
	 * @param email
	 * @return true if valid IBM email address, false if no
	 */
	public boolean isValidEmailAddress(String email) {
		String EMAIL_REGEX = "^[\\w-_\\.+]*[\\w-_\\.]\\@([\\w]+\\.)+[\\w]+[\\w]$";
		if (email.endsWith("ibm.com")) {
			return email.matches(EMAIL_REGEX);
		} else {
			return false;
		}
	}

	/**
	 * Service to send a test mail
	 * @param toAddress
	 * @param ccAddress
	 * @param bccAddress
	 * @param fromAddress
	 * @param subject
	 * @param message
	 * @return
	 */
	public String sendTestEmail(String toAddresses, String ccAddresses, String bccAddresses, String fromAddress, String subject, String message, String resend) {

		ObjectMapper objectMapper = new ObjectMapper();
		objectMapper.configure(MapperFeature.USE_ANNOTATIONS, true);
		
		BlueMail email = new BlueMail();
		BlueMailResponse bmr = new BlueMailResponse();
		String responseString = new String();
		String statusResponse = new String();
		String resendResponse = new String();
		Boolean validEmail = true;
		String invalidEmail = new String();
		List<Recipient> recipientList = new ArrayList<Recipient>();
		List<Cc> ccList = new ArrayList<Cc>();
		List<Bcc> bccList = new ArrayList<Bcc>();
		List<Attachment> attachmentList = new ArrayList<Attachment>();
		Attachment_ attachment_ = new Attachment_();
		Attachment attachment = new Attachment();

		// to list
		if (!toAddresses.isEmpty()) {
			List<String> toAddress = Arrays.asList(toAddresses.split("\\s*,\\s*"));
			for (String t: toAddress) {
				if (this.isValidEmailAddress(t)) {
					Recipient recipient = new Recipient();
					recipient.setRecipient(t);
					recipientList.add(recipient);
				} else {
					validEmail = false;
					invalidEmail = "invalid to: " + t;
					System.out.println(invalidEmail);
					break;
				}
			}
		}
		email.setRecipients(recipientList);

		// cc list
		if (!ccAddresses.isEmpty() && validEmail) {
			List<String> ccAddress = Arrays.asList(ccAddresses.split("\\s*,\\s*"));
			for (String c: ccAddress) {
				if (this.isValidEmailAddress(c)) {				
					Cc cc = new Cc();
					cc.setRecipient(c);
					ccList.add(cc);
				} else {
					validEmail = false;
					invalidEmail = "invalid cc: " + c;
					System.out.println(invalidEmail);
					break;
				}
			}
		}
		email.setCc(ccList);

		// bcc list
		if (!bccAddresses.isEmpty() && validEmail) {
			List<String> bccAddress = Arrays.asList(bccAddresses.split("\\s*,\\s*"));
			for (String b: bccAddress) {
				if (this.isValidEmailAddress(b)) {	
					Bcc bcc = new Bcc();
					bcc.setRecipient(b);
					bccList.add(bcc);
				} else {
					validEmail = false;
					invalidEmail = "invalid bcc: " + b;
					System.out.println(invalidEmail);
					break;
				}
			}
		}
		email.setBcc(bccList);

		// set sender
		if (!fromAddress.isEmpty() && validEmail) {
			if (this.isValidEmailAddress(fromAddress)) {	
				email.setContact(fromAddress);
			} else {
				validEmail = false;
				invalidEmail = "invalid from: " + fromAddress;
				System.out.println(invalidEmail);				
			}
		}

		// set subject
		email.setSubject(subject);

		// set message
		email.setMessage(message);
		
		// add attachment
		attachment_.setFilename("test.txt");
		attachment_.setContentType("text/plain");
		// Data must be Base64 encoded
		String str = "This is a base64 encoded text";
		String res = DatatypeConverter.printBase64Binary(str.getBytes());
		attachment_.setData(res);
		attachment.setAttachment(attachment_);
		attachmentList.add(attachment);
		//email.setAttachments(attachmentList);

		// send the mail
		if (validEmail) {
			bmr = this.sendBlueMail(email);
			
			// convert the response object of sendBlueMail to a JSON String
			try {
				responseString = objectMapper.writeValueAsString(bmr);
			} catch (Exception e) { 
				e.printStackTrace();
			}				
			
			// resend the mail
			if (resend.equals("enabled")) {
				resendResponse = this.resendMail(bmr.getLink().get(1).getHref(), email);
			} else {
				resendResponse = "{\"resend\" : \"disabled\"}";
			}
			
			// get the status
			statusResponse = this.getStatus(bmr.getLink().get(0).getHref());			
			
			System.out.println("sendBlueMail response= " + responseString);    	
			System.out.println("resendMail response= " + resendResponse);
			System.out.println("getStatus response= " + statusResponse);
			
			responseString = "{\"sendMail\" : " + responseString + ", \"resendMail\" : " + resendResponse + ", \"getStatus\" : " + statusResponse + "}";
		} else {
			responseString = "{\"sendMail\" : {\"error\" : \"" + invalidEmail + "\"}}";
		}

		return responseString;
	}        
}