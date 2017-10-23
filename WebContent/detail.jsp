<%@ page language="java"
	import="com.bluekey.connDb,com.bluekey.Access,com.bluekey.Mail,java.util.*,java.io.*"
	contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<%
	String email = (String) session.getAttribute("email");
	if (email == null || email.equals("")) {
		response.sendRedirect("login.jsp");
	}

	String access_id = request.getParameter("access_id");
	String role_id = request.getParameter("role_id");
	Access access = new Access();
	Mail mail = new Mail();

	if (access_id == null || access_id.equals("")) {
		response.sendRedirect("error.jsp");
	} else {
		access = connDb.getAccessByID(access_id); //get access detail
		mail = connDb.getMailTemplate(access_id); //get send mail template
	}
%>
<!DOCTYPE html>
<!-- saved from url=(0077)https://d396qusza40orc.cloudfront.net/phoenixassets/web-frameworks/index.html -->
<html lang="en">
<head>

<meta charset="utf-8">
<meta http-equiv="X-UA-Compatible" content="IE=edge">
<meta name="viewport" content="width=device-width, initial-scale=1">

<title>Blue Key</title>
<script src="js/jquery-1.10.2.min.js"></script>
<script src="js/bootstrap.min.js"></script>

<link rel="shortcut icon" href="img/favico.ico"/>
<link href="css/bootstrap.min.css" rel="stylesheet">
<link href="css/bootstrap-theme.min.css" rel="stylesheet">
<link href="css/mystyles.css" rel="stylesheet">
<link href="css/font-awesome.css" rel="stylesheet">
<link href="css/bootstrap-social.css" rel="stylesheet">

<script type="text/javascript">
$(document).ready(function(){
	var applyStep=  $("#detail-apply-step").text().replace(/\n/g,'<br/>');
    $("#detail-apply-step").html(applyStep);
    
    var description=  $("#detail-function-description").text().replace(/\n/g,'<br/>');
    $("#detail-function-description").html(description);
});

</script>
</head>

<body style="overflow:scroll;overflow-x:hidden">
	<div class="wrapper">
		<div class="page">
		<jsp:include page="top.jsp" flush="true" />


		<div class="container">
			<div class="row"></div>
			<div class="row breadcrumb-nav" style="font-size: 14px;">
				<div class="col-xs-12 col-sm-12 col-sm-push-0" >
					<ol class="breadcrumb">
						<li><a href="query.jsp">Home</a></li>
						<%if(role_id != null && !role_id.equals("")){%>
							<li><a href="access.jsp?role_id=<%=role_id%>">Access</a></li>
						<%}%>
						
						<li class="active"><%=access.getShortTitle()%></li>

					</ol>
				</div>
			</div>

			<div class="row row-content">
				<div class="col-xs-12 col-sm-2 col-sm-push-0 " style="margin-top: 50px;">
					<p style="padding: 15px;"></p>
					<div class="row">
						<div class="col-xs-12 col-sm-8 col-sm-push-1 access-item-test"
							id="generalAccess"
							style="font-size: 20px; text-align: center; height: 70px;">
							<h1 style="text-align: center; font-size: 20px;">Overview</h1>
						</div>
						<div class="col-xs-12 col-sm-8 col-sm-push-1 access-item-test"
							id="functionAccess"
							style="font-size: 20px; text-align: center; height: 70px;">
							<h1 style="text-align: center; font-size: 20px;">Apply</h1>
						</div>
						<div class="col-xs-12 col-sm-8 col-sm-push-1 access-item-test"
							id="otherAccess"
							style="font-size: 20px; text-align: center; height: 70px;">
							<h1 style="text-align: center; font-size: 20px;">Others</h1>
						</div>
					</div>
				</div>

				<div class="col-xs-12 col-sm-10 col-sm-push-0 "
					style="background-color: white; padding-bottom: 20px; border-left: 2px solid #5c7ebd;">

					<!-- å·ä½åå®¹ æ¾ç¤º -->
					<div class="row" id="general_access">
						<div class="col-xs-12 col-sm-12 access-item-detail" style="left: 26px; top: 19px;">
							<h3 style="font-size: 22px; "><%=access.getTitle()%></h3>
							<p style="font-size: 14px; padding-bottom: 20px; " id="detail-function-description">
								<%=access.getFunction()%>
							</p>
							<p style="font-size: 14px; padding-bottom: 20px;">
								<b>Access:</b>
								<%
								if (access.getParentPart() == 1) {
									out.print("general access");
								} else if (access.getParentPart() == 2) {
									out.print("function access");
								}
							%>
							</p>
							<p style="font-size: 14px; padding-bottom: 20px;">
								<b>Lead time:</b>
								<%=access.getLeadTime()%>
								days
							</p>
							<p
								style="font-size: 14px; padding-bottom: 20px; ">
								<b>Platform:</b>
								<%
								if (access.getPlatform().equals("1")) {
									out.print("lotus notes");
								} else if (access.getPlatform().equals("2")) {
									out.print("web");
								}
							%>
							</p>
							
						</div>
					</div>

					<div class="row" id="function_access" hidden="">
						<div class="col-xs-12 col-sm-12 access-item-detail"
							style="left: 26px; top: 19px;">
							<h3>Apply</h3>

							<p
								style="font-size: 14px; padding-bottom: 10px; padding-top: 10px;" id="detail-apply-step">
								<%=access.getApplyStep()%>
							</p>
							<%
								if (access.getUrl() != null && !"".equals(access.getUrl())) {
							%>
							<hr>
							<p
								style="font-size: 14px; ">
								Link: <a href=<%=access.getUrl()%> target="view_window"><%=access.getUrl()%></a>
							</p>
							<%
								}
							%>
							<%
								if (access.getOtherUrl() != null && !"".equals(access.getOtherUrl())) {
							%>
							<p
								style="font-size: 14px; padding-bottom: 10px; padding-top: 10px;">
								Link2: <a href=<%=access.getOtherUrl()%> target="view_window"><%=access.getOtherUrl()%></a>
							</p>
							<%
								}
							%>
							<%
								if (access.getApplyEmail() != null && !"".equals(access.getApplyEmail())) {
							%>
							<hr>
							<p
								style="font-size: 14px; padding-bottom: 20px; padding-top: 20px;">
								If you want to send an email to apply for the access, please
								click the button!</p>

							<div>
								<div>
									<a id="modal-317864" href="#modal-container-email"
										role="button" class="btn btn-primary" data-toggle="modal" style="background: #5c7ebd; border: 0;">Apply
										Access</a>

									<div class="modal fade" id="modal-container-email"
										role="dialog" aria-labelledby="myModalLabel"
										aria-hidden="true">
										<div class="modal-dialog">
											<div class="modal-content">
												<div class="modal-header">
													<button type="button" class="close" data-dismiss="modal"
														aria-hidden="true">×</button>
													<h4 class="modal-title" id="myModalLabel">Send an
														email to apply for the access</h4>
												</div>
												<form class="form-horizontal" role="form"
													action="sendEmail.jsp" dosubmit="false">
													<div class="modal-body" style="width: 610px;">
														<div>
															<div class="form-group">
																<label for="inputRecevieAddress"
																	class="col-sm-2 control-label">Receive Address</label>
																<div class="col-sm-6">
																	<input type="text" class="form-control" readonly
																		name="receive_email" 
																		value="<%=access.getApplyEmail()%>" />																</div>
																<div class="col-sm-3 ">
																	<span class="label label-warning" data-toggle="tooltip"
																		data-placement="right"
																		title="If the email address is wrong,please feedback to us!">Alert</span>
																</div>

															</div>

															<div class="form-group">
																<label for="inputEmailTitle"
																	class="col-sm-2 control-label">CC</label>
																<div class=" col-sm-9 ">
																	<input type="text" class="form-control"
																		name="carbon_copying" 
																		value="<%=email%>" />
																		
																</div>
																
																<div class="col-sm-offset-2 col-sm-9 ">
																	<div id="myAlert" class="alert alert-warning" style="padding-top: 5px; padding-bottom: 5px; margin-bottom: 0px;">
																		<button type="button" class="close" data-dismiss="alert"
																				aria-hidden="true">
																			&times;
																		</button>
																		<strong>Alert！</strong>separate multiple addresses by comma!
																	</div>
																</div>
															</div>
															<div class="form-group">
																<label for="inputEmailTitle"
																	class="col-sm-2 control-label">Subject</label>
																<div class="col-sm-9">
																	<input type="text" class="form-control"
																		name="email_title" style="width: 410px;"
																		value="<%=mail.getSubjectTitle()%>" />
																</div>
															</div>
															<div class="form-group">
																<label for="inputEmailContent"
																	class="col-sm-2 control-label">Content</label>
																<div class="col-sm-9">
																	<textarea class="form-control" name="email_content"
																		rows="15"> <%=mail.getContent()%></textarea>

																</div>
															</div>
														</div>
													</div>
													<div class="modal-footer">
														<input type="hidden" name="access_id"
															value="<%=access_id%>">
														<button type="button" class="btn btn-default"
															data-dismiss="modal">Cancel</button>
														<button type="submit" class="btn btn-primary">Send</button>
													</div>
												</form>
											</div>
										</div>
									</div>
								</div>
							</div>
							<%
								}
							%>
						</div>

					</div>
					<!-- <div class="col-xs-12 col-sm-9 " style=" background-color:white; padding-bottom: 20px;padding-left: 20px;border-left: 2px solid #5c7ebd;" hidden="">
 -->
					<div class="row" id="other_access" hidden="">
						<div class="col-xs-12 col-sm-12 access-item-detail"
							style="left: 26px; top: 19px;">
							<h3>Resource</h3>

						</div>
					</div>
				</div>
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

		$(function() {
			$("[data-toggle='tooltip']").tooltip();
		});

		var generalAccess = document.getElementById("generalAccess");
		// alert(generalAccess.id);

		var functionAccess = document.getElementById("functionAccess");

		var otherAccess = document.getElementById("otherAccess");

		var generalTotal = document.getElementById("general_access");

		var functionTotal = document.getElementById("function_access");

		var otherTotal = document.getElementById("other_access");
		generalAccess.onclick = function showGeneral() {
			generalAccess.style.backgroundColor = "#5c7ebd";
			generalAccess.style.color = "white";
			functionAccess.style.backgroundColor = "";
			functionAccess.style.color = "#5C7EBD";
			otherAccess.style.backgroundColor = "";
			otherAccess.style.color = "#5C7EBD";
			functionTotal.style.display = "none";
			// functionTotal.parentNode.style.display="none";
			generalTotal.style.display = "inline";
			// generalTotal.parentNode.style.display="inline";

			// otherTotal.parentNode.style.display="none";
			otherTotal.style.display = "none";
		}
		functionAccess.onclick = function showFunction() {
			generalAccess.style.backgroundColor = "";
			generalAccess.style.color = "#5C7EBD";
			functionAccess.style.backgroundColor = "#5c7ebd";
			functionAccess.style.color = "white";
			otherAccess.style.backgroundColor = "";
			otherAccess.style.color = "#5C7EBD";
			// functionTotal.parentNode.style.display="inline";
			functionTotal.style.display = "inline";
			// generalTotal.parentNode.style.display="none";
			generalTotal.style.display = "none";

			// generalTotal.parentNode.style.borderLeft="";
			// otherTotal.parentNode.style.display="none";
			otherTotal.style.display = "none";
			// otherTotal.parentNode.style.borderLeft="";
		}
		otherAccess.onclick = function showOther() {
			otherAccess.style.backgroundColor = "#5c7ebd";
			otherAccess.style.color = "white";
			generalAccess.style.backgroundColor = "";
			generalAccess.style.color = "#5C7EBD";
			functionAccess.style.backgroundColor = "";
			functionAccess.style.color = "#5C7EBD";
			// generalTotal.parentNode.style.display="none";
			generalTotal.style.display = "none";

			// functionTotal.parentNode.style.display="none";
			functionTotal.style.display = "none";

			// otherTotal.parentNode.style.display="inline";
			otherTotal.style.display = "inline";

		}
		generalAccess.click();
	</script>
</body>
</html>

