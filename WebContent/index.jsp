<%@ page language="java" import="com.bluekey.connDb,java.util.*" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%  
	String	email =	(String)session.getAttribute("email");
	String	user_id =	(String)session.getAttribute("user_id");
	if(session.getAttribute("email")==null){
		response.sendRedirect("login.jsp");
	}else{
		response.sendRedirect("query.jsp");
    }  
%>