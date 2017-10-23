<%@ page language="java" import="com.bluekey.connDb,java.util.*" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%  
	String email = (String)session.getAttribute("email");
	if(email==null){
		response.sendRedirect("login.jsp");
	}
	
	String role_id =request.getParameter("role_id");

	if(role_id== null ||"".equals(role_id)){
		out.print("<script>window.location.href=\"error.jsp\";</script>");
	}
	
	boolean flag = connDb.deleteRole(role_id);
	   
    if(flag==true){
    	out.print("<script>alert(\"Deleted successfully! \");window.location.href=\"roleList.jsp\";</script>");
    }else{
    	out.print("<script>alert(\"Deleted False! \");window.history.go(-1);</script>");
    }
%>
