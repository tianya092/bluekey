<%@ page language="java" import="com.bluekey.connDb,com.bluekey.Access,java.util.*" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%  
	String email = (String)session.getAttribute("email");
	if(email==null){
		response.sendRedirect("login.jsp");
	}
	
	String access_id =request.getParameter("access_id");
	if(access_id== null ||"".equals(access_id)){
		out.print("<script>window.location.href=\"error.jsp\";</script>");
	}
	
	Access access = new Access();
	access.setAccessId(Integer.parseInt(request.getParameter("access_id"))); 
	
	boolean flag = connDb.deleteAccess(access);
	//out.print(flag);   
    if(flag==true){
    	out.print("<script>alert(\"Deleted successfully! \");window.location.href=\"accessList.jsp\";</script>");
    }else{
    	out.print("<script>alert(\"Deleted False! \");window.history.go(-1);</script>");
    }
%>
