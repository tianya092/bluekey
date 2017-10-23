<%@ page language="java" import="com.bluekey.connDb,com.bluekey.User,com.bluekey.LDAP,java.util.*"  import="com.bluekey.bluemail.service.BlueMailService"
	import ="org.json.JSONObject" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%  
	request.setCharacterEncoding("utf-8");
	String email = (String)session.getAttribute("email");
	if(email==null){
		response.sendRedirect("login.jsp");
	}
	
    String subject= request.getParameter("subject");  
	String content = request.getParameter("content"); 
	
	if(subject==null||subject.equals("")){
		out.println("<javascript> alter(\"Subject is empyt\")</javascript>");
	}
	
	if(content==null||content.equals("")){
		out.println("<javascript> alter(\"Content is empyt\")</javascript>");
	}
	Map<String,String> adminMap = connDb.getAdminList();
	
	
 	BlueMailService bms =  new BlueMailService();
	String responseCode =bms.sendTestEmail(adminMap.get("superAdmin"),adminMap.get("normalAdmin"),"",email,subject,content,"abled");//send mail 
	JSONObject blueMailJson = new JSONObject(responseCode);
	JSONObject getStatus = blueMailJson.getJSONObject("getStatus");
	String status = getStatus.getString("status");
	
	//String status ="dsgsdg";
	if(status.equals("")){ 
		out.println("<script>alert(\"Submited False! Please come back to try it again\");window.location.href=\"login.jsp\";</script>");	
    }else{
    	//boolean flag = connDb.feedBackRecord(user,email);
    	out.println("<script>alert(\"Thank you! We had got you problem and suggestion ! We will answer you  soon!\");window.history.go(-1);</script>");
    }   
%>
