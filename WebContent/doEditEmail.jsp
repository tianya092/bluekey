<%@ page language="java" import="com.bluekey.connDb,com.bluekey.Access,com.bluekey.Mail,java.util.*" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%  
	request.setCharacterEncoding("utf-8");
	String temp_id =request.getParameter("temp_id");
	String access_id =request.getParameter("access_id");
	String subject_title =request.getParameter("email_title");
	String content =request.getParameter("content");
	
	String email = (String)session.getAttribute("email");
	Mail mail= new Mail();
	 
	
	if(access_id==null||access_id.equals("")){ 
		out.print("<script>alert(\"Please edit access detail information first! \");window.history.go(-1);</script>");
	}else{
		mail.setAccessId(Integer.parseInt(access_id));
	}
	
	if(temp_id!=null&&!temp_id.equals("")){ 
		mail.setTempId(Integer.parseInt(temp_id));
	}
	
	if(subject_title==null||subject_title.equals("")){ 
		out.print("<script>alert(\"title is empty! \");window.history.go(-1);</script>");
	}
	
	if(content==null||content.equals("")){ 
		out.print("<script>alert(\"content is empty! \");window.history.go(-1);</script>");
	}
	 
	 
	 mail.setSubjectTitle(subject_title);
	 mail.setContent(content);
	 
	 boolean flag = connDb.updateMailTemplate(mail, email);
	
    if(flag==true){
    	out.print("<script>alert(\"Submited successfully! \");window.location.href=\"accessList.jsp\";</script>");
    }else{
    	out.print("<script>alert(\"submited False! \");window.history.go(-1);</script>");
    }
	
%>
