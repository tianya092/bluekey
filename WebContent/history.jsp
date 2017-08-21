<%@ page language="java"
	import="com.bluekey.connDb,com.bluekey.User,com.bluekey.SendRecord,java.util.*,java.io.*"
	contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<%  
	String email = (String)session.getAttribute("email");
	if(email==null||email.equals("")){
		response.sendRedirect("login.jsp");
	}
	
	User loginUser  =	(User)session.getAttribute("user");
	///out.print(loginUser.getUserId());
	ArrayList<SendRecord>  RecordList = connDb.getSendRecordList(loginUser.getUserId()); //get user Record list
	
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>BLUE KEY</title>
<script src="js/jquery-3.1.0.min.js"></script>
<script src="js/bootstrap.min.js"></script>
<script src="js/bootstrapValidator.js"></script>
<script src="js/language/zh_CN.js"></script>
<script src="js/jquery.cxselect.js"></script>

<link href="css/bootstrap.min.css" rel="stylesheet">
<link href="css/bootstrap-theme.min.css" rel="stylesheet">
<link href="css/mystyles.css" rel="stylesheet">
<link href="css/font-awesome.css" rel="stylesheet">
<link href="css/bootstrap-social.css" rel="stylesheet">
<link href="css/bootstrapValidator.css" rel="stylesheet">

</head>
<body data-spy="scroll" data-target="#myScrollspy">

	<jsp:include page="top.jsp" flush="true" />
	<div class="container">
		<div class="row breadcrumb-nav" >
			<div class="col-xs-12 col-sm-12 col-sm-push-0">
				<ol class="breadcrumb">
					<li><a href="query.jsp">Home</a></li>
					<li><a href="#">User Center</a></li>
					<li class="active">Send history</li>

				</ol>
			</div>
		</div>

		<legend>Send email history</legend>
		<div  class="history-cont">
			<%
        		for(SendRecord record : RecordList){
        			out.print("<div><h4>"+record.getAccessId()+"</h4><p>"+record.getEmailSubject()+"</p><p>"+record.getContent()+"</p><div>"+record.getCreatTime()+"</div></div></div>");
        			
        		} 
	        %>
		</div>
	</div>
	<jsp:include page="bottom.jsp" flush="true" />
	
</body>
</html>
