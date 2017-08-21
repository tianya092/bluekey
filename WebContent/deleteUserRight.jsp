<%@ page language="java" import="com.bluekey.connDb,java.util.*" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%  
	String email = (String)session.getAttribute("email");
	if(email==null){
		response.sendRedirect("login.jsp");
	}
	
	String user_id =request.getParameter("user_id");

	if(user_id== null ||"".equals(user_id)){
		out.print("<script>alert(\"ERROR ouccued! \");window.location.href=\"userList.jsp\";</script>");
	}
	
	boolean flag = connDb.deleteUserRightByID(user_id,email);
	   
    if(flag==true){
    	out.print("<script>alert(\"Deleted successfully! \");window.location.href=\"userList.jsp\";</script>");
    }else{
    	out.print("<script>alert(\"Deleted False! \");window.history.go(-1);</script>");
    }
%>
