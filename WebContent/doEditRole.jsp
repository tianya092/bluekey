<%@ page language="java" import="com.bluekey.connDb,com.bluekey.Access,com.bluekey.User,com.bluekey.Role,java.util.*" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%  
	request.setCharacterEncoding("utf-8");
	StringBuilder access_list_SB = new StringBuilder();
	String accessList = "";
	int checkFlag =0;
	int query_function;
	int query_team;
	
	String email = (String)session.getAttribute("email");
	User user = connDb.getUser(email); 
	if(email==null){
		response.sendRedirect("login.jsp");
	}
	
	String role_id =request.getParameter("role_id");
	String[] general_access_arr = request.getParameterValues("general_access");
	String[] function_access_arr = request.getParameterValues("function_access");
	
	if((general_access_arr !=null && general_access_arr.length != 0)){
		for(String i:general_access_arr){
			access_list_SB.append(i+",");
		}
	}
	
	if((function_access_arr !=null && function_access_arr.length != 0)){
		for(String i:function_access_arr){
			access_list_SB.append(i+",");
		}
	}
	accessList =access_list_SB.substring(0,access_list_SB.length()-1);
	
	if(request.getParameter("function")!= null &&!"".equals(request.getParameter("function"))){
		 query_function = Integer.parseInt(request.getParameter("function"));
	}else{
		 query_function = user.getFunction();
	}
	
	if(request.getParameter("team")!= null &&!"".equals(request.getParameter("team"))){
		query_team = Integer.parseInt(request.getParameter("team"));
	}else{
		query_team = user.getTeam();
	}
	
	Role role = new Role();
	if(role_id== null ||"".equals(role_id)){
		//out.print(request.getParameter("function"));
    	role.setFunction(query_function);
    	role.setTeam(query_team);
    	role.setJobRole(Integer.parseInt(request.getParameter("job_role")));
    	if(request.getParameter("commodity")!= null &&!"".equals(request.getParameter("commodity"))){
    		role.setCommodity(Integer.parseInt(request.getParameter("commodity")));
    	}
	}else{
		role.setRoleId(Integer.parseInt(role_id));
	}
	
	role.setAccessList(accessList);
	
	if(role_id== null ||"".equals(role_id)){
		checkFlag = connDb.queryRole(role);
	}
	
	if(checkFlag!=0){
		out.print("<script>alert(\"The role had been created! Please come back to edite it \");window.location.href=\"roleList.jsp\";</script>");
	}else{
		boolean flag = connDb.updateRole(role,email);
		
	    if(flag==true){
	    	out.print("<script>alert(\"Submited successfully! \");window.location.href=\"roleList.jsp\";</script>");
	    }else{
	    	out.print("<script>alert(\"submited False! \");window.history.go(-1);</script>");
	    }
	}
	
%>
