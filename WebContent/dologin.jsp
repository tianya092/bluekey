<%@ page language="java" import="com.bluekey.connDb,com.bluekey.User,com.bluekey.LDAP,java.util.*" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%  
    String email=request.getParameter("email");  
	String password = request.getParameter("password");  
	String  activedStatus = null;
    if(email!=null&&password!=null){  
    	LDAP ldap = new LDAP();
		boolean isAuthentication = ldap.authenticate(email, password);
    	if(isAuthentication){
            request.getSession().setAttribute("email",email);     //save email
            boolean status = connDb.updataUser(email);
            
			User user = connDb.getUser(email);
			request.getSession().setAttribute("user",user);     //save email
			
			int  user_id = user.getUserId();
			
			//request.getSession().setAttribute("user_id",user_id);        //save user_id
			session.setMaxInactiveInterval(12*3600);  //sessiion timeout 12h
			
			response.sendRedirect("query.jsp?user_id="+user_id);  
			
    	}else{
    		out.println("<script>alert(\"Email or password is wrong! Please try again\");window.location.href=\"login.jsp\";</script>");
			//response.sendRedirect("login.jsp");
    	}
    }else{
    	out.println("<script>alert(\"Email or password isn't empty! Please come back to try again\");window.location.href=\"login.jsp\";</script>");
    }  
%>
