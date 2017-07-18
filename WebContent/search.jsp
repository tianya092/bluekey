<%@ page language="java"
	import="com.bluekey.connDb,com.bluekey.Access,java.util.*,java.io.*"
	contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%  

	String search=request.getParameter("search");  
	Map<String,String> detail = null; 
	
	ArrayList<Access>  accessList = connDb.search(search); //get access list
	
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
<body data-spy="scroll" data-target="#myScrollspy">

	<jsp:include page="top.jsp" flush="true" />
	
	<div class="container">
	
		<div class="col-xs-12 col-sm-12" style="margin:20px 0 20px 0;padding-left:0 ">
				<ol class="breadcrumb">
					<li><a href="query.jsp">Home</a></li>
					<li class="active">Result</li>
				</ol>
			</div>
		<div>
			Find <%= accessList.size()%> results for you
		</div>
		<hr>
		<%
       		for(Access access : accessList){
       			int index = access.getApplyStep().indexOf(search);
   		%>
       		<div class="result-item" >
				<h3>
					<a href="detail.jsp?access_id=<%=access.getAccessId() %>">
						<%
							if(access.getTitle().indexOf(search)!=-1){
								out.print(access.getTitle().replaceAll("(?i)"+search,"<span class=\"hightlight\">"+search+"</span>"));
							}else{
								out.print(access.getTitle());
							}
						%>
						
					</a>
				</h3>
				<p >
				<% 
					String str = "";
					if(index!=-1&&index>20){
						str = access.getApplyStep().substring(index-20);
					}else{
						str = access.getApplyStep();
					}
					out.print(str.replaceAll("(?i)"+search,"<span class=\"hightlight\">"+search+"</span>"));
				%></p>
			</div>
       	<%}%>	
	</div>
	<jsp:include page="bottom.jsp" flush="true" />
</body>
</html>
