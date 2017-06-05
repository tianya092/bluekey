<%@ page language="java" import="BlueKey.connDb,java.util.*" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%  
    String email=request.getParameter("email");  
	String  activedStatus = null;
    if(email!=null){  
    	if(true){
            request.getSession().setAttribute("email",email);     //save email
            boolean status = connDb.updataUser(email);
            
			Map<String,String> user = connDb.checkUserActived(email);
			activedStatus = user.get("actived");
			String  user_id = user.get("user_id");
			
			request.getSession().setAttribute("user_id",user_id);        //save user_id
			session.setMaxInactiveInterval(12*3600);  //sessiion timeout 12h
			
			if(activedStatus.equals("1")){
				response.sendRedirect("result.jsp?user_id="+user_id);  
			}else{
				response.sendRedirect("input.jsp?user_id="+user_id);  
			}
    	}else{
			response.sendRedirect("login.jsp");
    	}
    }  
%>
