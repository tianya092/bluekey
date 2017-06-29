<%@ page language="java" import="BlueKey.connDb,java.util.*" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%  
	String role_id =request.getParameter("role_id");

	if(role_id== null ||"".equals(role_id)){
		out.print("<script>alert(\"ERROR ouccued! \");window.location.href=\"accessList.jsp\";</script>");
	}
	
	boolean flag = connDb.deleteRole(role_id);
	   
    if(flag==true){
    	out.print("<script>alert(\"Deleted successfully! \");window.location.href=\"roleList.jsp\";</script>");
    }else{
    	out.print("<script>alert(\"Deleted False! \");window.history.go(-1);</script>");
    }
%>
