<%@ page language="java"
	import="com.bluekey.connDb,com.bluekey.Access,com.bluekey.User,java.util.*,java.io.*"
	contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%
	String email = (String) session.getAttribute("email");
	if (session.getAttribute("email") == null) {
		response.sendRedirect("login.jsp");
	}

	User user = connDb.getUser(email); //get access list
	if (user.getFunction() != 1000) {
		out.println(
				"<script>alert(\"You haven't permission  to vist the page!\");window.location.href=\"query.jsp\";</script>");
	}

	String[] accessArr = new String[] { "", "general access", "function access", "others access" };
	/* String page = request.getParameter("page"); */
	Map<String, String> detail = null;

	ArrayList<Access> accessList = connDb.getAccessList(); //get access list
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>BLUE KEY</title>

<script src="js/jquery-3.1.0.min.js"></script>
<script src="js/bootstrap.min.js"></script>

<link href="css/bootstrap.min.css" rel="stylesheet">
<link href="css/bootstrap-theme.min.css" rel="stylesheet">
<link href="css/mystyles.css" rel="stylesheet">
<link href="css/font-awesome.css" rel="stylesheet">
<link href="css/bootstrap-social.css" rel="stylesheet">

</head>
<body>
	<div class="wrapper">
		<jsp:include page="top.jsp" flush="true" />
		<div class="container" style=" padding-bottom: 90px;">
			
			<div class="row breadcrumb-nav" >
				<div class="col-xs-12 col-sm-12 col-sm-push-0">
					<ol class="breadcrumb">
						<li><a href="query.jsp">Home</a></li>
						<li><a href="#">Setting</a></li>
						<li class="active">Access manage</li>

					</ol>
				</div>
			</div>
			Access List
			<hr>
			<div class="page-header">
				<a href="editAccess.jsp" class="btn btn-primary btn"> <span
					class="glyphicon glyphicon-plus"></span> add an access
				</a>
			</div>
			<div class="table-responsive">
				<table class="table  table-hover">
					<thead>
						<tr class="active">
							<th>No</th>
							<th>Access name</th>
							<th>Belong to</th>
							<th>Update time</th>
							<th>Update operator</th>
							<th>Operate</th>
						</tr>
					</thead>
					<tbody>
						<%
							int i = 1;
							for (Access access : accessList) {
								out.print("<tr><td>" + i + "</td><td>" + access.getShortTitle() + "</td><td>"
										+ accessArr[access.getParentPart()] + "</td><td>" + access.getUpdateTime() + "</td><td>"
										+ access.getUpdateOperator() + "</td><td><a href=\"editAccess.jsp?access_id="
										+ access.getAccessId()
										+ " \" title=\"Edit\"><span class=\"glyphicon glyphicon-pencil\"></span></a>&nbsp;&nbsp;&nbsp;&nbsp <a href=\"deleteAccess.jsp?access_id="
										+ access.getAccessId()
										+ " \" title=\"Delete\"><span class=\"glyphicon glyphicon-trash\"></span></a></td></tr>");
								i++;
							}
						%>
					</tbody>
				</table>
			</div>
		</div>
		<jsp:include page="bottom.jsp" flush="true" />
	</div>
	
	
</body>
</html>
