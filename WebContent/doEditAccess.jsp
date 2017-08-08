<%@ page language="java" import="com.bluekey.connDb,com.bluekey.Access,java.util.*" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%  
	String access_id =request.getParameter("access_id");
	String email = (String)session.getAttribute("email");
	Access access = new Access();
	
	if(access_id!=null&&!access_id.equals("")){ 
		access.setAccessId(Integer.parseInt(access_id));
	}
	
	access.setParentPart(Integer.parseInt(request.getParameter("parent_part"))); 
    access.setTitle(request.getParameter("title"));  
    access.setShortTitle(request.getParameter("short_title"));  
    access.setFunction(request.getParameter("function"));  
    access.setPlatform(request.getParameter("platform"));  
    access.setUrl(request.getParameter("url"));  
    access.setOtherUrl(request.getParameter("url"));  
    access.setApplyEmail(request.getParameter("apply_email"));  
    access.setLeadTime((request.getParameter("lead_time")==null||request.getParameter("lead_time").equals(""))?0:Integer.parseInt(request.getParameter("lead_time")));  
    access.setApplyStep(request.getParameter("apply_step").trim());  
   
    boolean flag = connDb.updateAccessDetail(access,email);
   
    if(flag==true){
    	out.print("<script>alert(\"Submited successfully! \");window.location.href=\"accessList.jsp\";</script>");
    }else{
    	out.print("<script>alert(\"submited False! \");window.history.go(-1);</script>");
    }
	
%>
