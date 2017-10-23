<%@ page language="java" import="com.bluekey.connDb,java.util.*"
	contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%
	
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>BLUE KEY</title>
<script src="js/jquery-3.1.0.min.js"></script>
<script src="js/bootstrap.min.js"></script>
<script src="js/zzsc.js"></script>

<link rel="shortcut icon" href="img/favico.ico" />
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

				<div class="container" style=" padding-top: 60px;">
					<div>
						<div style="text-align: center;">
							<img src="img/wolf.png" style="width: 1100; height: 650px;" >	
						</div>
						
						<a href="query.jsp"><img src="img/gohome.png" style="width: 200px; height: 50px; margin-left: 0px; position: absolute; left: 410px; top: 490px;"></a>
					</div>

				</div>

		</div>
	</div>
	<jsp:include page="bottom.jsp" flush="true" />
</body>
</html>
