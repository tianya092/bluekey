<%@ page language="java" import="BlueKey.connDb,BlueKey.Role,java.util.*" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%  
    String function_str=request.getParameter("function");
	String team_str=request.getParameter("team");  
	String job_role_str=request.getParameter("job_role");
	String commodity_str=request.getParameter("commodity");  
	String remember_type_str=request.getParameter("remember_type");  
	int function = 0;
	int team = 0;
	int job_role = 0;
	int commodity = 0;
	int remember_type = 0;
	
	if(function_str.equals("")||function_str==null){
		out.println("<javascript> alter(\"function is empyt\")</javascript>");
		response.sendRedirect("error.jsp");
	}else{
		function =Integer.parseInt(function_str);
	}
	
	if(team_str.equals("")||team_str==null){
		out.println("<javascript> alter(\"team is empyt\")</javascript>");
		response.sendRedirect("error.jsp");
	}else{
		team =Integer.parseInt(team_str);
	}
	
	if(job_role_str.equals("")||job_role_str==null){
		out.println("<javascript> alter(\"commodity is empyt\")</javascript>");
		response.sendRedirect("error.jsp");
	}else{
		job_role =Integer.parseInt(job_role_str);
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
	
	if(role_id!=0){
		response.sendRedirect("result.jsp?role_id="+role_id);  
	}else{
		out.print("<script>alert(\"The role haven't created. Please connect Administrator for help! \");window.history.go(-1);</script>");
	}
	

	
	
    
%>
