<%@ page language="java" import="BlueKey.connDb,BlueKey.Access,java.util.*" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%  
	String access_id =request.getParameter("access_id");

	Access access = new Access();
	access.setAccessId(Integer.parseInt(request.getParameter("access_id"))); 
	
	boolean flag = connDb.deleteAccess(access);
	   
    if(flag==true){
    	out.print("<script>alert(\"Deleted successfully! \");window.location.href=\"accessList.jsp\";</script>");
    }else{
    	out.print("<script>alert(\"Deleted False! \");window.history.go(-1);</script>");
    }
%>
