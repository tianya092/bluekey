<%@ page language="java" import="com.bluekey.connDb,com.bluekey.Access,com.bluekey.Mail,java.util.*" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%  
	//String access_id ="1";
	String access_id =request.getParameter("access_id");
	String subject_title =request.getParameter("title");
	String content =request.getParameter("apply_step");
	
	String email = (String)session.getAttribute("email");
	
	if(access_id==null||access_id.equals("")){ 
		out.print("<script>alert(\"access id is empty! \");window.history.go(-1);</script>");
	}else
	
	if(subject_title==null||subject_title.equals("")){ 
		out.print("<script>alert(\"title is empty! \");window.history.go(-1);</script>");
	}
	
	if(content==null||content.equals("")){ 
		out.print("<script>alert(\"apply_step is empty! \");window.history.go(-1);</script>");
	}
	 Mail mail= new Mail();
	 
	 mail.setAccessId(Integer.parseInt(access_id));
	 mail.setSubjectTitle(subject_title);
	 mail.setContent(content);
	 
	 boolean flag = connDb.updateMailTemplate(mail, email);
	
    if(flag==true){
    	out.print("<script>alert(\"Submited successfully! \");window.location.href=\"accessList.jsp\";</script>");
    }else{
    	out.print("<script>alert(\"submited False! \");window.history.go(-1);</script>");
    }
	
%>
