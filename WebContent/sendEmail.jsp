<%@page import="org.json.JSONArray"%>
<%@ page language="java"
	import="com.bluekey.Mail,com.bluekey.connDb,com.bluekey.Mail,java.util.*" 
	import="com.bluekey.bluemail.service.BlueMailService"
	import ="org.json.JSONObject"
	contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"
%>
<%  
    String access_id=request.getParameter("access_id"); 
	String title=request.getParameter("email_title"); 
    String content=request.getParameter("email_content"); 
    
	String	user_id = (String)session.getAttribute("user_id");
	String email = (String)session.getAttribute("email");
	
	boolean right = connDb.checkUserAccess(user_id, access_id); //check access_id is in user'access list or not
	/* if(right != true){
		out.println("<script>alert(\"You have't access to visit the page! Please contact Administrator\");window.location.href=\"result.jsp?user_id="+user_id+"\";</script>");
	} */
	
	BlueMailService bms =  new BlueMailService();
	String responseCode =bms.sendTestEmail(email,"","",email,title,content,"abled");//send mail 
	JSONObject blueMailJson = new JSONObject(responseCode);
	JSONObject getStatus = blueMailJson.getJSONObject("getStatus");
	String status = getStatus.getString("status");
	
	//boolean flag = true;
	if(status.equals("")){
		out.println("<script>alert(\"Send error! Please contact IT for help\");window.location.href=\"detail.jsp?access_id="+access_id+"\";</script>");
	}else{
		out.println("<script>alert(\"Sended successfully!\");window.location.href=\"detail.jsp?access_id="+access_id+"\";</script>");
	}
    
%>
