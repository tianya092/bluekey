<%@ page language="java"
	import="com.bluekey.connDb,com.bluekey.Access,java.util.*,java.io.*"
	contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%  
	String email = (String)session.getAttribute("email");
	String[] accessArr = new String[]{"","general access","function access","others access"};
	/* String page = request.getParameter("page"); */
	Map<String,String> detail = null; 
	
	ArrayList<Access>  accessList = connDb.getAccessList(); //get access list
	
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
<body style="margin-top: 150px;margin-bottom: 100px;">

	<jsp:include page="top.jsp" flush="true" />
	<div class="container">
		<div >
			<ol class="breadcrumb">
				<li><a href="search.jsp">Home</a></li>
				<li><a href="access.jsp?user_id=">Setting</a></li>
				<li class="active">Access manage</li>

			</ol>
		</div>
	</div>
	<div class="container">
		Access List
		<hr>
		
		<a href="editAccess.jsp" class="btn btn-info btn"> <span
				class="glyphicon glyphicon-plus"></span> add an access
		</a>
		<div class="table-responsive">
			<table class="table table-condensed table-hover">
				<thead>
					<tr class="active">
						<th>No</th>
						<th>Access name</th>
						<th>Belong to Access</th>
						<th>operate</th>
					</tr>
				</thead>
				<tbody>
					<%
			        		int i=1;
			        		for(Access access : accessList){
			        			out.print("<tr><td>"+i+"</td><td>"+access.getShortTitle()+"</td><td>"+accessArr[access.getParentPart()]+"</td><td><a href=\"editAccess.jsp?access_id="+access.getAccessId()+"\"><span class=\"glyphicon glyphicon-pencil\"></span></a>&nbsp;&nbsp;&nbsp;&nbsp <a href=\"deleteAccess.jsp?access_id="+access.getAccessId()+"\"><span class=\"glyphicon glyphicon-trash\"></span></a></td></tr>");
			        			i++;
			        		}
			        	%>
				</tbody>
			</table>
			<ul class="pagination">
				<li><a href="#">Prev</a></li>
				<li><a href="#">1</a></li>
				<li><a href="#">2</a></li>
				<li><a href="#">3</a></li>
				<li><a href="#">4</a></li>
				<li><a href="#">5</a></li>
				<li><a href="#">Next</a></li>
			</ul>
		</div>
	</div>
	<jsp:include page="bottom.jsp" flush="true" />
</body>
</html>
