<%@ page language="java"
	import="BlueKey.Mail,BlueKey.connDb,BlueKey.Mail,java.util.*" 
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
	if(right != true){
		out.println("<script>alert(\"You have't access to visit the page! Please contact Administrator\");window.location.href=\"result.jsp?user_id="+user_id+"\";</script>");
	}
	
	Mail mail = new Mail();
	mail.setSubjectTitle(title);
	mail.setContent(content);
	
	mail.setMailAccount(email);
	mail.setReceiveAccount(email);
	boolean flag = mail.sendMail(); //send mail 
	//boolean flag = true;
	if(flag==true){
		out.println("<script>alert(\"Sended successfully!\");window.location.href=\"detail.jsp?access_id="+access_id+"\";</script>");
	}else{
		out.println("<script>alert(\"Send error! Please contact IT for help\");window.location.href=\"detail.jsp?access_id="+access_id+"\";</script>");
	}
    
%>
