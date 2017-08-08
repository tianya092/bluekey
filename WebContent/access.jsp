<%@ page language="java" import="com.bluekey.connDb,java.util.*" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%  
	String role_id = request.getParameter("role_id");
	String	email =	(String)session.getAttribute("email");
	/* int role_id ;
	if(role_id_str.equals("")||role_id_str==null){
		out.println("<javascript> alter(\"function is empyt\")</javascript>");
		response.sendRedirect("error.jsp");
	}else{
		role_id =Integer.parseInt(role_id_str);
	} */
	if(session.getAttribute("email")==null){
		response.sendRedirect("login.jsp");
	}
	
	Map<String,String> general_access= null;
	Map<String,String> function_access= null;
	Map<String,String> other_access= null;
	
	/* if(session.getAttribute("email")==null){
		response.sendRedirect("login.jsp");
	}else{
		String user_id = request.getParameter("user_id");
		String	email =	(String)session.getAttribute("email");
		boolean right = connDb.checkUserRight(email, user_id); //check use-id is right or not
		if(right==false){
			out.println("<javascript> alter(\"please login yourself ID!\")</javascript>");
			response.sendRedirect("error.jsp");
		}else{
			ArrayList<Map<String,String>> list = connDb.result(user_id); //get access list 
			general_access= list.get(0);
			function_access= list.get(1);
			other_access= list.get(2);
		}
	} */
	if(role_id==null||role_id.equals("")){
		out.println("<javascript> alter(\"role id is null!\");window.history.go(-1);</javascript>");
		response.sendRedirect("error.jsp");
	}else{
		ArrayList<Map<String,String>> list = connDb.result(role_id); //get access list 
		general_access= list.get(0);
		function_access= list.get(1);
	}
	
%> 
<!DOCTYPE html>
<!-- saved from url=(0077)https://d396qusza40orc.cloudfront.net/phoenixassets/web-frameworks/index.html -->
<html lang="en">
<head>

<meta charset="utf-8">
<meta http-equiv="X-UA-Compatible" content="IE=edge">
<meta name="viewport" content="width=device-width, initial-scale=1">
<!-- The above 3 meta tags *must* come first in the head; any other head 
         content must come *after* these tags -->

<title>Blue Key</title>
<!-- Bootstrap -->
<link href="css/bootstrap.min.css" rel="stylesheet">
<link href="css/bootstrap-theme.min.css" rel="stylesheet">
<link href="css/mystyles.css" rel="stylesheet">
<link href="css/font-awesome.css" rel="stylesheet">
<link href="css/bootstrap-social.css" rel="stylesheet">

<!-- HTML5 shim and Respond.js for IE8 support of HTML5 elements and media queries -->
<!-- WARNING: Respond.js doesn't work if you view the page via file:// -->
<!--[if lt IE 9]>
      <script src="https://oss.maxcdn.com/html5shiv/3.7.2/html5shiv.min.js"></script>
      <script src="https://oss.maxcdn.com/respond/1.4.2/respond.min.js"></script>
    <![endif]-->
<style type="text/css">
 #col-xs-4 col-sm-3 access-item-detail{
    left: 26px;
    padding: 20px;
    height: 70px;
    top: 19px;

  }
</style>

</head>

<body style="margin-bottom: 100px;">
	<jsp:include page="top.jsp" flush="true" />
	<header>
		<!-- Main component for a primary marketing message or call to action -->

		<div class="jumbotron">
			<div class="container">
				<div class="row">
					<img src="img/u6.jpg" class="center-block"
						style="height: 94px; margin: 0px auto;">
				</div>
			</div>
			<!-- 
                <div class="row row-header"> -->
			<div id="mycarousel" class="carousel slide" data-ride="carousel">

				<!-- Indicators -->
				<ol class="carousel-indicators">
					<li data-target="#mycarousel" data-slide-to="0" class="active"></li>
					<li data-target="#mycarousel" data-slide-to="1"></li>
					<li data-target="#mycarousel" data-slide-to="2"></li>
					<li data-target="#mycarousel" data-slide-to="3"></li>
				</ol>

				<!-- Wrapper for slides -->
				<div class="carousel-inner" role="listbox">
					<div class="item active">
						<img class="img-responsive" src="img/u3.png" alt="u3">

						<div class="carousel-caption" style="left: 50%; top: 10%;">
							<h3>Welcome to blue key</h3>
						</div>
					</div>

					<div class="item">
						<img class="img-responsive" src="img/u1.png" alt="u1">

						<div class="carousel-caption" style="left: 50%; top: 10%;">
							<h3>You will build the future of FinTech</h3>
						</div>
					</div>
					<div class="item">
						<img class="img-responsive" src="img/u4.jpg" alt="u4"> </a>
						<div class="carousel-caption"></div>
					</div>
					<div class="item">
						<img class="img-responsive" src="img/u5.jpg" alt="u5"> </a>
						<div class="carousel-caption"></div>
					</div>
				</div>

				<!-- Controls -->
				<a class="left carousel-control" href="#mycarousel" role="button"
					data-slide="prev"> <span
					class="glyphicon glyphicon-chevron-left" aria-hidden="true"></span>
					<span class="sr-only">Previous</span>
				</a> <a class="right carousel-control" href="#mycarousel" role="button"
					data-slide="next"> <span
					class="glyphicon glyphicon-chevron-right" aria-hidden="true"></span>
					<span class="sr-only">Next</span>
				</a>

			</div>
	</header>

	<div class="container">
		<div class="row">
			<div class="col-xs-12 col-sm-12 col-sm-push-0"
				style="font-size: 16px;">
				<ol class="breadcrumb">
					<li><a href="query.jsp">Home</a></li>
					<li class="active">Access</li>
				</ol>
			</div>
		</div>

		<div class="row row-content" style="margin-top: -40px;">
			<div class="col-xs-12 col-sm-2 col-sm-push-0 ">
				<!-- <p style="padding: 10px;"></p> -->
				<div class="row">
					<div class="col-xs-12 col-sm-10 col-sm-push-1 access-item"
						id="generalAccess" style="height: 70px; text-align: center;">
						<h1 style="text-align: center; font-size: 20px;">General</h1>
					</div>
					<div class="col-xs-12 col-sm-10 col-sm-push-1 access-item"
						id="functionAccess" style="height: 70px; text-align: center;">
						<h1 style="text-align: center; font-size: 20px;">Function</h1>
					</div>
				</div>


			</div>
			<div class="col-xs-12 col-sm-10 col-sm-push-0"
				style="background-color: rgba(0, 51, 153, 0.0980392156862745); padding-bottom: 20px; font-size: 16px; color: #5C7EBD; font-family: 'Arial Normal', 'Arial'; font-weight: 600; ">
				<div class="row" id="general_access">
					<div class="row">
						<%
			             	if(general_access!=null){
				             	for(String key :general_access.keySet()){
				             		out.println("<div class=\"col-xs-4 col-sm-3 access-item\"><a href=\"detail.jsp?role_id="+role_id+"&access_id="+key+"\" title=\""+general_access.get(key)+"\">"+general_access.get(key)+"<br /></a></div>");
				             	}	
			             	}
			             %>
					</div>
				</div>

				<div class="row" id="function_access" hidden>
					<div class="row"></div>
					 <%
		            	if(function_access!=null){
		            		for(String key :function_access.keySet()){
			             		out.println("<div class=\"col-xs-4 col-sm-3 access-item\"><a href=\"detail.jsp?role_id="+role_id+"&access_id="+key+"\" title=\""+function_access.get(key)+"\">"+function_access.get(key)+"<br /></a></div>");
			             	}	
		            	}
		             %>
				</div>
			</div>
		</div>
	</div>
	

	<jsp:include page="bottom.jsp" flush="true" />

	<script src="js/jquery-3.1.0.min.js"></script>
	<script src="js/bootstrap.min.js"></script>

	<script type="text/javascript">
		var generalAccess = document.getElementById("generalAccess");
		// alert(generalAccess.id);
		
		var functionAccess = document.getElementById("functionAccess");
		
		var generalTotal = document.getElementById("general_access");
		
		var functionTotal = document.getElementById("function_access");
		
		generalAccess.onclick = function showGeneral(){
			generalAccess.style.backgroundColor="#5c7ebd";
			generalAccess.style.color="white";
			functionAccess.style.backgroundColor="";
			functionAccess.style.color="#5C7EBD";
			functionTotal.style.display="none";
			generalTotal.style.display="inline";
		}
		
		functionAccess.onclick = function showFunction(){
			generalAccess.style.backgroundColor="";
			generalAccess.style.color="#5C7EBD";
			functionAccess.style.backgroundColor="#5c7ebd";
			functionAccess.style.color="white";
			functionTotal.style.display="inline";
			generalTotal.style.display="none";
		}
		
		generalAccess.click();
</script>
</body>
</html>

