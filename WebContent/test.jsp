<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>
<script src="js/jquery-1.10.2.min.js"></script>
<style>
html,
				body {
					height: 100%;
					margin: 0;
					padding: 0;
				}

				#container {
					min-height: 100%;
					height: auto !important;
					height: 100%;
				}
				#page {
					padding-bottom: 60px;/*高度等于footer的高度*/
				}
				#footer {
					position: relative;
					margin-top: -60px;/*等于footer的高度*/
					height: 60px;
					clear:both;
					background: #c6f;
				}
				/*==========其他div==========*/
				#header {
					padding: 10px;
					background: lime;
				
				#content{
					width: 60%;
					float: left;
					margin-right: 2%;
					background: green;
				}
				

</style>


</head>
<body>
	<div id="container">
					<div id="header">Header Section</div>
					<div id="page" class="clearfix">
						<div id="content">Main content</div>
					</div>
				</div>
				<div id="footer">Footer section</div>

</body>
</html>