<%@ page language="java" import="com.bluekey.connDb,java.util.*" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%  
	request.getSession().removeAttribute("email");     //destory session
	request.getSession().removeAttribute("user_id");    //destory session
	response.sendRedirect("login.jsp"); 
%>
