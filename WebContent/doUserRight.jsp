<%@ page language="java" import="com.bluekey.connDb,com.bluekey.Access,com.bluekey.User,java.util.*" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%  
	request.setCharacterEncoding("utf-8");
	String email = (String)session.getAttribute("email");
	if(email==null){
		response.sendRedirect("login.jsp");
	}
	
	String user_id =request.getParameter("user_id");
	String userEmail =request.getParameter("user_email");
	
	String function =request.getParameter("function");
	String team =request.getParameter("team");
	User user = new User();
	
	if((user_id !=null && ! user_id.equals(""))){
		user.setUserId(Integer.parseInt(user_id));
	}
	
	if((userEmail !=null && ! userEmail.equals(""))){
		user.setEmail(userEmail);
	}
	
	if((function !=null && ! function.equals(""))){
		user.setFunction(Integer.parseInt(function));
	}
	
	if((team !=null && ! team.equals(""))){
		user.setTeam(Integer.parseInt(team));
	}
	
	boolean flag = connDb.updateUserRight(user,email);
	
	
    if(flag==true){
    	out.print("<script>alert(\"Submited successfully! \");window.location.href=\"userList.jsp\";</script>");
    }else{
    	out.print("<script>alert(\"submited False! \");window.history.go(-1);</script>");
    }
	
	
%>
、、
