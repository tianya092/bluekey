<%@ page language="java"
	import="com.bluekey.connDb,com.bluekey.Access,com.bluekey.User,java.util.*,java.io.*"
	contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%
	String email = (String) session.getAttribute("email");
	String access_search = request.getParameter("access_search");
	String query_team="";
	
	if (session.getAttribute("email") == null) {
		response.sendRedirect("login.jsp");
	}
	
	
	User user = connDb.getUser(email); //get access list
	if (user.getFunction() != 1000) {
		out.println(
				"<script>alert(\"You haven't permission  to vist the page!\");window.location.href=\"query.jsp\";</script>");
	}
	
	if(access_search!=null&&!access_search.equals("")){ 
		query_team=access_search.trim();
	}

	String[] accessArr = new String[] { "", "general access", "function access", "others access" };
	/* String page = request.getParameter("page"); */
	Map<String, String> detail = null;

	ArrayList<Access> accessList = connDb.getAccessList(query_team); //get access list
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>BLUE KEY</title>

<script src="js/jquery-3.1.0.min.js"></script>
<script src="js/bootstrap.min.js"></script>

<link rel="shortcut icon" href="img/favico.ico"/>
<link href="css/bootstrap.min.css" rel="stylesheet">
<link href="css/bootstrap-theme.min.css" rel="stylesheet">
<link href="css/mystyles.css" rel="stylesheet">
<link href="css/font-awesome.css" rel="stylesheet">
<link href="css/bootstrap-social.css" rel="stylesheet">

</head>
<body style="overflow:scroll;overflow-x:hidden">
	<div class="wrapper">
		<div class="page">
		<jsp:include page="top.jsp" flush="true" />
		<div class="container" >
			
			<div class="row breadcrumb-nav" >
				<div class="col-xs-12 col-sm-12 col-sm-push-0">
					<ol class="breadcrumb">
						<li><a href="query.jsp">Home</a></li>
						<li><a href="#">Setting</a></li>
						<li class="active">Access manage</li>

					</ol>
				</div>
			</div>
			<legend>Access List</legend>
		
			<div class="page-header">
				<a href="editAccess.jsp" class="btn btn-primary" style="background: #5c7ebd; border: 0;"> 
					<span class="glyphicon glyphicon-plus"></span> add an access
				</a>
				<form  role="form" style="float:right; width:400px" method="post" action="accessList.jsp">
					<div class="row">
						<div class="col-lg-10 col-sm-5">
							<div class="input-group">
								<input type="text" class=" col-sm-10 form-control" name="access_search" value="<%= query_team%>">
								<span class="input-group-btn">
									<button class="btn btn-primary" style="background: #5c7ebd;" type="submit">Search</button>
								</span>
							</div>
						</div>
					</div>
				</form>
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
										+ " \" title=\"Edit\"><span class=\"glyphicon glyphicon-pencil\"></span></a>&nbsp;&nbsp;&nbsp;&nbsp <a onclick=\"return confirm('Are you sure to detele the access?')\" href=\"deleteAccess.jsp?access_id="+access.getAccessId()+"\" title=\"Delete\" ><span class=\"glyphicon glyphicon-trash\" ></span></a></td></tr>");
								i++;
							}
						%>
					</tbody>
				</table>
			</div>
			<div class="guide">
				<div class="guide-wrap">
					<a href="feedback.jsp" class="report" title="Feedback"><span>Feedback</span></a>
					<a href="#" class="top" title="To top"><span>To top</span></a>
				</div>
			</div>
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
