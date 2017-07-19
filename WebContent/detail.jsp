<%@ page language="java" import="com.bluekey.connDb,com.bluekey.Access,com.bluekey.Mail,java.util.*,java.io.*" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%  
	String email = (String)session.getAttribute("email");
	if(email==null||email.equals("")){
		response.sendRedirect("login.jsp");
	}
	
	String access_id = request.getParameter("access_id");
	String role_id = request.getParameter("role_id");
	Access access = new Access();
	
	if(access_id==null||access_id.equals("")){
		response.sendRedirect("error.jsp");
	}else{
		access  = connDb.accessDetail(access_id); //get access detail
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
</head>

<body style="margin-bottom: 150px;overflow:scroll;overflow-x:hidden">
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
		</div>
	</header>

	<div class="container">
		<div class="row"></div>
		<div class="row" style="font-size: 16px;">
			<div class="col-xs-12 col-sm-12 col-sm-push-0">
				<ol class="breadcrumb">
					<li><a href="query.jsp">Home</a></li>
					<li><a href="access.jsp?role_id=<%=role_id %>">Access</a></li>
					<li class="active"><%=access.getShortTitle() %></li>

				</ol>
			</div>
		</div>

		<div class="row row-content">
			<div class="col-xs-12 col-sm-2 col-sm-push-0 ">
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
				style="background-color: white; padding-bottom: 20px; border-left: 2px solid #5c7ebd; ">

				<!-- å·ä½åå®¹ æ¾ç¤º -->
				<div class="row" id="general_access">
					<div class="col-xs-12 col-sm-12 access-item-detail"
						style="left: 26px; top: 19px;">
						<h3 style="font-size: 22px; padding-bottom: 40px;"><%=access.getTitle() %></h3>
						<p style="font-size: 14px; padding-bottom: 20px;">
							access: 
							<%
								if(access.getParentPart()==1) {
									out.print("general access");
								}else if(access.getParentPart()==2){
									out.print("function access");
								}
									
							%>
						</p>
						<p style="font-size: 14px; padding-bottom: 20px;">
							lead time: <%=access.getLeadTime() %> days
						</p>
						<p style="font-size: 14px; padding-bottom: 20px; padding-top: 20px;">
							Platform:
							<%
								if(access.getPlatform().equals("1")) {
									out.print("lotus notes");
								}else if(access.getPlatform().equals("2")){
									out.print("web");
								}
									
							%>
						</p>
						<p style="font-size: 14px; padding-bottom: 20px; padding-top: 20px;">
							<%=access.getFunction() %>
						</p>
					</div>
				</div>

				<div class="row" id="function_access" hidden="">
					<div class="col-xs-12 col-sm-12 access-item-detail" style="left: 26px; top: 19px;">
						<h3>Apply</h3>

						<p style="font-size: 14px; padding-bottom: 20px; padding-top: 20px;">
							<%=access.getApplyStep() %>
						</p>
						<%if(access.getApplyEmail()!= null &&!"".equals(access.getApplyEmail())){%>
							<hr>
							<p style="font-size: 14px; padding-bottom: 20px; padding-top: 20px;">
								If you want to send an email to apply for the access, please click the button!
							</p>
				            
				          	<div class="container">
								<div >
									<a id="modal-317864" href="#modal-container-email" role="button" class="btn btn-primary" data-toggle="modal">Apply Access</a>
									
									<div class="modal fade" id="modal-container-email" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true" >
										<div class="modal-dialog">
											<div class="modal-content">
												<div class="modal-header">
													 <button type="button" class="close" data-dismiss="modal" aria-hidden="true">×</button>
													<h4 class="modal-title" id="myModalLabel">
														Send an email to apply for the access
													</h4>
												</div>
												<form class="form-horizontal" role="form" action="sendEmail.jsp">
													<%
														Mail mail = connDb.getMailTemplate("1"); //get send mail template
													%>
													<div class="modal-body" style="width:610px;">
														<div >
																<div class="form-group">
																	 <label for="inputRecevieAddress" class="col-sm-2 control-label">Receive Address</label>
																	<div class="col-sm-9">
																		<input type="text" class="form-control"  disabled name="Receive_email" style="width:410px;" value="<%=access.getApplyEmail() %>"/><span class="label label-warning" data-toggle="tooltip" data-placement="right" title="If the email address is wrong,please feedback to us!">Alert</span>
																	</div>
																	
																</div>
																
																<div class="form-group">
																	 <label for="inputEmailTitle" class="col-sm-2 control-label">CC</label>
																	<div class="col-sm-9 ">
																		<input type="text" class="form-control" name="carbon_copying" style="width:410px;" value="<%=email %>"/>
																	</div>
																</div>
																<div class="form-group">
																	 <label for="inputEmailTitle" class="col-sm-2 control-label">Subject</label>
																	<div class="col-sm-9">
																		<input type="text" class="form-control" name="email_title" style="width:410px;" value="<%=mail.getSubjectTitle() %>"/>
																	</div>
																</div>
																<div class="form-group">
																	 <label for="inputEmailContent" class="col-sm-2 control-label">Content</label>
																	<div class="col-sm-9">
																		<textarea class="form-control" name="email_content" rows="15"> <%=mail.getContent()%></textarea>
																		
																	</div>
																</div>
														</div>
													</div>
													<div class="modal-footer">
														<input type="hidden" name="access_id" value="<%=access_id %>>">
														 <button type="button" class="btn btn-default" data-dismiss="modal">Cancel</button> <button type="submit" class="btn btn-primary">Send</button>
													</div>
												</form>
											</div>
										</div>
									</div>
								</div>
							</div>
						<%} %>
					</div>

				</div>
				<!-- <div class="col-xs-12 col-sm-9 " style=" background-color:white; padding-bottom: 20px;padding-left: 20px;border-left: 2px solid #5c7ebd;" hidden="">
 -->
				<div class="row" id="other_access" hidden="">
					<div class="col-xs-12 col-sm-12 access-item-detail"
						style="left: 26px; top: 19px;">
						<h3>Resource</h3>
						<p style="font-size: 14px; padding-bottom: 20px; padding-top: 20px;">
						Link:
							<a href=<%=access.getUrl() %> target="view_window"><%=access.getUrl()%></a>
						</p>

					</div>
				</div>
			</div>
		</div>


	</div>


	<jsp:include page="bottom.jsp" flush="true" />

	
	<script src="js/jquery-3.1.0.min.js"></script>
	<script src="js/bootstrap.min.js"></script>

	<script type="text/javascript">
		$(function () { $("[data-toggle='tooltip']").tooltip(); });
		
		var generalAccess = document.getElementById("generalAccess");
		// alert(generalAccess.id);
		
		var functionAccess = document.getElementById("functionAccess");
		
		var otherAccess = document.getElementById("otherAccess");
		
		
		var generalTotal = document.getElementById("general_access");
		
		var functionTotal = document.getElementById("function_access");
		
		var otherTotal = document.getElementById("other_access");
		generalAccess.onclick = function showGeneral(){
		  generalAccess.style.backgroundColor="#5c7ebd";
		  generalAccess.style.color="white";
		  functionAccess.style.backgroundColor="";
		  functionAccess.style.color="#5C7EBD";
		   otherAccess.style.backgroundColor="";
		  otherAccess.style.color="#5C7EBD";
		functionTotal.style.display="none";
		// functionTotal.parentNode.style.display="none";
		generalTotal.style.display="inline";
		// generalTotal.parentNode.style.display="inline";
		
		// otherTotal.parentNode.style.display="none";
		otherTotal.style.display="none";
		}
		functionAccess.onclick = function showFunction(){
		    generalAccess.style.backgroundColor="";
		    generalAccess.style.color="#5C7EBD";
		 functionAccess.style.backgroundColor="#5c7ebd";
		 functionAccess.style.color="white";
		    otherAccess.style.backgroundColor="";
		    otherAccess.style.color="#5C7EBD";
		// functionTotal.parentNode.style.display="inline";
		  functionTotal.style.display="inline";
		 // generalTotal.parentNode.style.display="none";
		generalTotal.style.display="none";
		
		// generalTotal.parentNode.style.borderLeft="";
		// otherTotal.parentNode.style.display="none";
		otherTotal.style.display="none";
		// otherTotal.parentNode.style.borderLeft="";
		}
		otherAccess.onclick = function showOther(){
		 otherAccess.style.backgroundColor="#5c7ebd";
		 otherAccess.style.color="white";
		  generalAccess.style.backgroundColor="";
		    generalAccess.style.color="#5C7EBD";
		     functionAccess.style.backgroundColor="";
		  functionAccess.style.color="#5C7EBD";
		  // generalTotal.parentNode.style.display="none";
		  generalTotal.style.display="none";
		
		  // functionTotal.parentNode.style.display="none";
		  functionTotal.style.display="none";
		
		  // otherTotal.parentNode.style.display="inline";
		  otherTotal.style.display="inline";
		
		}
		generalAccess.click();
</script>
</body>
</html>

