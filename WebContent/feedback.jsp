<%@ page language="java"
	import="com.bluekey.connDb,com.bluekey.User,java.util.*,java.io.*"
	contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<%
	String email = (String) session.getAttribute("email");
	int user_id = (int) session.getAttribute("user_id");
	if (email == null) {
		response.sendRedirect("login.jsp");
	}
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>BLUE KEY</title>
<script src="js/jquery-1.10.2.min.js"></script>
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
<body>
	<div class="wrapper">
		<jsp:include page="top.jsp" flush="true" />
		<div class="container">
			<div class="row breadcrumb-nav">
				<div class="col-xs-12 col-sm-12 col-sm-push-0">
					<ol class="breadcrumb">
						<li><a href="query.jsp">Home</a></li>
						<li class="active">Feedback</li>
					</ol>
				</div>
			</div>

			<legend> Please feedback us the problem you meet or
				suggestion </legend>

			<div class="row clearfix">
				<div class="col-md-12 column">
					<form class="form-horizontal" id="feedback-form" role="form"
						action="doFeedback.jsp" method="post">
						<div class="form-group">
							<label for="inputTitle" class="col-sm-2 control-label"><span
								style="color: red">*</span>Subject</label>
							<div class="col-sm-8">
								<input type="text" name="subject" class="form-control"
									id="inputEmail3" placeholder="Discrip the subject" />
							</div>
						</div>
						<div class="form-group">
							<label for="inputContent" class="col-sm-2 control-label"><span
								style="color: red">*</span>Content</label>
							<div class="col-sm-8">
								<textarea class="form-control" name="content" rows="25"
									placeholder="Discrip you problem"></textarea>
							</div>
						</div>
						<div class="form-group">
							<div class="col-sm-offset-2 col-sm-10">
								<input type="hidden" name="user_id" value="<%=user_id%>">
								<button type="submit" class="btn btn-primary">submit</button>
							</div>
						</div>
					</form>
				</div>
			</div>
		</div>
	</div>
	<jsp:include page="bottom.jsp" flush="true" />
	<script type="text/javascript">
		$(document)
				.ready(
						function() {
							$('#feedback-form')
									.bootstrapValidator(
											{
												message : 'This value is not valid',
												feedbackIcons : {/*输入框不同状态，显示图片的样式*/
													valid : 'glyphicon glyphicon-ok',
													invalid : 'glyphicon glyphicon-remove',
													validating : 'glyphicon glyphicon-refresh'
												},
												fields : {/*验证*/
													subject : {
														validators : {
															notEmpty : {
																message : 'The email is required and can\'t be empty'
															},
															stringLength : {
																min : 6,
																message : 'The subject must be more than 6 characters long'
															},
														}
													},
													'content' : {
														validators : {
															notEmpty : {
																message : 'The Access Title is required and cannot be empty'
															},
															stringLength : {
																min : 6,
																message : 'The content must be more than 6 characters long'
															},
														}
													},
												}
											});
						})
	</script>
</body>
</html>
