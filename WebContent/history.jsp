<%@ page language="java"
	import="com.bluekey.connDb,com.bluekey.User,com.bluekey.SendRecord,java.util.*,java.io.*"
	contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<%
	String email = (String) session.getAttribute("email");
	if (email == null || email.equals("")) {
		response.sendRedirect("login.jsp");
	}

	User loginUser = (User)request.getSession().getAttribute("user");
	
	//int user_id = (int) session.getAttribute("user_id");
	//out.print(email);
	//String user_id= (String) session.getAttribute("user_id");
	//ArrayList<SendRecord> RecordList = connDb.getSendRecordList(user_id); //get user Record list
	ArrayList<SendRecord> RecordList = connDb.getSendRecordList(loginUser.getUserId()); //get user Record list
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

<link rel="shortcut icon" href="img/favico.ico"/>
<link href="css/bootstrap.min.css" rel="stylesheet">
<link href="css/bootstrap-theme.min.css" rel="stylesheet">
<link href="css/mystyles.css" rel="stylesheet">
<link href="css/font-awesome.css" rel="stylesheet">
<link href="css/bootstrap-social.css" rel="stylesheet">
<link href="css/bootstrapValidator.css" rel="stylesheet">

</head>
<body style="overflow:scroll;overflow-x:hidden">
	<div class="wrapper">
		<div class="page">
			<jsp:include page="top.jsp" flush="true" />
			<div class="container">
				<div class="row breadcrumb-nav">
					<div class="col-xs-12 col-sm-12 col-sm-push-0">
						<ol class="breadcrumb">
							<li><a href="query.jsp">Home</a></li>
							<li class="active">Send history</li>

						</ol>
					</div>
				</div>

				<legend>Send history</legend>
				<div >
					<%
						for (SendRecord record : RecordList) {
							out.print("<div class=\"history-container\"><h4>" + record.getEmailSubject() + "</h4><p style=\"font-size: 12px;\">"
									+ record.getContent() + "</p ><div>" + record.getCreatTime() + "</div></div>");

						}
					%>
				</div>
			</div>
		</div>
		<div class="guide">
			<div class="guide-wrap">
				<a href="feedback.jsp" class="report" title="Feedback"><span>Feedback</span></a>
				<a href="#" class="top" title="To top"><span>To top</span></a>
			</div>
		</div>
	</div>
	<jsp:include page="bottom.jsp" flush="true" />
	<script type="text/javascript">
		$(document).ready(function(){
			$(".top").on("click", function() { 
	            $("body").stop().animate({  
	                scrollTop: 0  
	            });  
	        })  
		});

	</script>
</body>
</html>
