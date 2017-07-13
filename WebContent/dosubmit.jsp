<%@ page language="java" import="com.bluekey.connDb,com.bluekey.Role,com.bluekey.User,java.util.*" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%  
    String function_str=request.getParameter("function");
	String team_str=request.getParameter("team");  
	String job_role_str=request.getParameter("job_role");
	String commodity_str=request.getParameter("commodity");  
	String remember_type_str=request.getParameter("remember_type");  
	String user_id_str=request.getParameter("user_id");
	
	int function = 0;
	int team = 0;
	int job_role = 0;
	int commodity = 0;
	int user_id = 0;
	String remember ="";
			
	if(function_str==null||function_str.equals("")){
		out.println("<javascript> alter(\"function is empyt\")</javascript>");
		response.sendRedirect("error.jsp");
	}else{
		function =Integer.parseInt(function_str);
	}
	
	if(team_str==null||team_str.equals("")){
		out.println("<javascript> alter(\"team is empyt\")</javascript>");
		response.sendRedirect("error.jsp");
	}else{
		team =Integer.parseInt(team_str);
	}
	
	if(job_role_str==null||job_role_str.equals("")){
		out.println("<javascript> alter(\"commodity is empyt\")</javascript>");
		response.sendRedirect("error.jsp");
	}else{
		job_role =Integer.parseInt(job_role_str);
	}
	
	if(user_id_str==null||user_id_str.equals("")){
		out.println("<javascript> alter(\"user id is empyt\")</javascript>");
		response.sendRedirect("error.jsp");
	}else{
		user_id =Integer.parseInt(user_id_str);
	}
	
	if(commodity_str!=null&&!commodity_str.equals("")){
		commodity =Integer.parseInt(commodity_str);
	}
	
	Role role = new Role();
	role.setFunction(function);
	role.setTeam(team);
	role.setJobRole(job_role);
	role.setCommodity(commodity);
	
	int  role_id = connDb.queryRole(role); //get access list 
	
	if(remember_type_str!=null&&!remember_type_str.equals("")){
		User user = new User();
		user.setUserId(user_id);
		user.setRemember(function_str+","+team_str+","+job_role_str+","+commodity_str);
		boolean  remember_flag = connDb.remember(user); //get access list 
	}
	
	if(role_id!=0){
		response.sendRedirect("result.jsp?role_id="+role_id);  
	}else{
		out.print("<script>alert(\"The role haven't created. Please connect Administrator for help! \");window.history.go(-1);</script>");
	} 
	

	
	
    
%>
