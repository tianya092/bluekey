<%@page import="org.json.JSONArray"%>
<%@ page language="java"
	import="com.bluekey.Mail,com.bluekey.connDb,com.bluekey.Access,com.bluekey.Mail,java.util.*" 
	import="com.bluekey.bluemail.service.BlueMailService"
	import ="org.json.JSONObject"
	contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"
%>
<%  
    String access_id=request.getParameter("access_id"); 
	String title=request.getParameter("email_title"); 
    String content=request.getParameter("email_content"); 
    String email = (String)session.getAttribute("email");
    int	user_id =(int) session.getAttribute("user_id");
	
	Access access = new Access();
	access = connDb.getAccessByID(access_id);
	String receive_email = access.getApplyEmail();
	
	BlueMailService bms =  new BlueMailService();
	String responseCode =bms.sendTestEmail(email,"","",email,title,content,"abled");//send mail 
	//String responseCode =bms.sendTestEmail(receive_email,"","",email,title,content,"abled");//send mail 
	JSONObject blueMailJson = new JSONObject(responseCode);
	JSONObject getStatus = blueMailJson.getJSONObject("getStatus");
	String status = getStatus.getString("status"); 
	
	//boolean flag = true;
	if(status.equals("")){
		out.println("<script>alert(\"Send error! Please contact IT for help\");window.location.href=\"detail.jsp?access_id="+access_id+"\";</script>");
	}else{
		boolean flag = connDb.sendRecord(user_id,email,receive_email,title,content,Integer.parseInt(access_id));
		out.println("<script>alert(\"Sended successfully!\");window.location.href=\"detail.jsp?access_id="+access_id+"\";</script>");
	}
    
%>
