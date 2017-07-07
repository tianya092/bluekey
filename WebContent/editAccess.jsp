<%@ page language="java" import="com.bluekey.connDb,com.bluekey.Access,java.util.*" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%  
	String access_id = request.getParameter("access_id");

	Access access = new Access(); 
	Map<String,String> mailMap = null;
	if(access_id!=null){
		access = connDb.accessDetail(access_id); //get access list
		mailMap = connDb.getMailTemplate(access_id); //get send mail template
	}
	String  title = "";
	String  short_title = "";
	String  function = "";
	String  platform = "";
	String  url = "";
	String  apply_email = "";
	int  	lead_time = 0;
	String  apply_step = "";
	int 	parent_part=0;
	String  email_title = "";
	String  content = "";
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>BLUE KEY</title>
<script src="js/jquery-3.1.0.js"></script>
<script src="js/bootstrap.min.js"></script>
<script src="js/bootstrapValidator.js"></script>
<script src="js/language/zh_CN.js"></script>

<link href="css/bootstrap.min.css" rel="stylesheet">
<link href="css/bootstrap-theme.min.css" rel="stylesheet">
<link href="css/mystyles.css" rel="stylesheet">
<link href="css/font-awesome.css" rel="stylesheet">
<link href="css/bootstrap-social.css" rel="stylesheet">
<link href="css/bootstrapValidator.css" rel="stylesheet">
<style>
/* Custom Styles */
    ul.nav-tabs{
       /* width: 140px;*/
        margin-top: 20px;
        border-radius: 4px;
        border: 1px solid #ddd;
        box-shadow: 0 1px 4px rgba(0, 0, 0, 0.067);
    }
    ul.nav-tabs li{
        margin: 0;
        border-top: 1px solid #ddd;
    }
    ul.nav-tabs li:first-child{
        border-top: none;
    }
    ul.nav-tabs li a{
        margin: 0;
        padding: 8px 16px;
        border-radius: 0;
    }
    ul.nav-tabs li.active a, ul.nav-tabs li.active a:hover{
        color: #fff;
        background: #0088cc;
        border: 1px solid #0088cc;
    }
    ul.nav-tabs li:first-child a{
        border-radius: 4px 4px 0 0;
    }
    ul.nav-tabs li:last-child a{
        border-radius: 0 0 4px 4px;
    }
    ul.nav-tabs.affix{
        top: 200px; /* Set the top position of pinned element */
    }
       
    img{
         height: 120px;
    
    }
</style>
<script>
	$(document).ready(function(){
	    $("#myNav").affix({
	        offset: { 
	            top: 125 
	      }
	    });
	});
	$(function () {
		alert("dsfdsf");
        $('#detail_form').bootstrapValidator({
        	
        	message: 'This value is not valid',
            feedbackIcons: {
                valid: 'glyphicon glyphicon-ok',
                invalid: 'glyphicon glyphicon-remove',
                validating: 'glyphicon glyphicon-refresh'
            },
            fields: {
            	
                short_title: {
                    validators: {
                        notEmpty: {
                            message: '邮箱不能为空'
                        }
                    }
                }
            }
        });
    });
	$('#validateBtn').click(function() {
		$('#defaultForm').bootstrapValidator('validate');
	});
</script>
</head>
<body data-spy="scroll" data-target="#myScrollspy">

    <jsp:include page= "top.jsp" flush ="true"/>
    <%
    	if(access_id!=null){
    		title = access.getTitle();
    	    short_title = access.getShortTitle();
    		function = access.getFunction();
    		platform = access.getPlatform();
    		url = access.getUrl();
    		apply_email = access.getApplyEmail();
    		lead_time = access.getLeadTime();
    		apply_step = access.getApplyStep().trim();
    		parent_part = access.getParentPart();
    		
    		email_title = mailMap.get("subject_title");
    		content =mailMap.get("content");
    	}
    	
    %>
	<div class="container" >
	   
	    <div class="row">
	            <div class="col-xs-12 col-sm-12">
	               <ol class="breadcrumb">
	                    <li><a href="input.jsp">Home</a></li>
	                    <li class="active"><a href="#">Contact</a></li>
	                 
	                </ol>
	            </div>
	   </div>
	</div>
	
	<div class="container">
		<legend>Edit access</legend>
		<div class="row clearfix">
			<div class="col-md-12 column">
				<div class="tabbable" id="tabs-368872">
					<ul class="nav nav-pills" style="margin-bottom: 20px;">
						<li class="active">
							 <a href="#panel-detail" data-toggle="tab"> Detail information</a>
						</li>
						<li>
							 <a href="#panel-mail-template" data-toggle="tab">Mail template</a>
						</li>
					</ul>
					<div class="tab-content">
						<div class="tab-pane fade in active" id="panel-detail">
							<div class="row clearfix">
								<div class="col-md-12 column">
									<form class="form-horizontal" id="detail_form" method="post" role="form" action="doEditAccess.jsp">
										<div class="form-group">
											 <label for="inputParent_part" class="col-sm-2 control-label"><span style="color:red">*</span>Parent part</label>
											<div class="col-sm-4">
												<select class="form-control " name="parent_part">
													<option value="0" >>please check an access</option>
													<option value="1" <%if(parent_part==1) {out.print("selected");}%>>general access</option>
													<option value="2" <% if(parent_part==2) {out.print("selected");}%>>function access</option>
												</select>
											</div>
										</div>
										
										<div class="form-group">
											 <label for="inputTitle" class="col-sm-2 control-label"><span style="color:red">*</span>Access Title</label>
											<div class="col-sm-8">
												<input type="text" class="form-control input-sm" name="title" check-type="required" required-message="密码不能为空！"   value="<%=title%>"/>
											</div>
										</div>
										<div class="form-group">
											 <label for="inputShortTitle" class="col-sm-2 control-label"><span style="color:red">*</span>Short Title</label>
											<div class="col-sm-8">
												<input type="text" class="form-control input-sm" name="short_title" value="<%=short_title%>"/>
											</div>
										</div>
										
										<div class="form-group">
											 <label for="inputFunction" class="col-sm-2 control-label"><span style="color:red">*</span>Function</label>
											<div class="col-sm-8">
												<input type="text" class="form-control input-sm" name="function" value="<%=function%>"/>
											</div>
										</div>
										<div class="form-group">
											 <label for="inputPlatform" class="col-sm-2 control-label"><span style="color:red">*</span>Platform</label>
											<div class="col-sm-8">
												 <input type="radio" name="platform" value="1" <%if(platform.equals("1")) out.print("checked"); %>>lotus notes &nbsp;&nbsp;&nbsp;
									            <input type="radio" name="platform" value="2" <%if(platform.equals("2")) out.print("checked"); %>>web
											</div>
										</div>				
										<div class="form-group">
											 <label for="inputURL" class="col-sm-2 control-label">URL</label>
											<div class="col-sm-8">
												<input type="url" class="form-control input-sm" name="url" value="<%=url%>"/>
											</div>
										</div>
										<div class="form-group">
											 <label for="inputURL" class="col-sm-2 control-label">Apply email</label>
											<div class="col-sm-8">
												<input type="email" class="form-control input-sm" name="apply_email" value="<%=apply_email%>"/>
											</div>
										</div>
										<div class="form-group">
											 <label for="inputURL" class="col-sm-2 control-label">Lead time</label>
											<div class="col-sm-2">
												<input type="number" class="form-control input-sm" name="lead_time"  value="<%=lead_time%>"/>
											</div>
											<div class="col-sm-1"><p class="form-control-static">days</p></div>
										</div>
										
										<div class="form-group">
											 <label for="inputApply_step" class="col-sm-2 control-label"><span style="color:red">*</span>Apply step</label>
											<div class="col-sm-8">
												<textarea class="form-control  input-sm" name="apply_step" rows="8"><%=apply_step%></textarea>
											</div>
										</div>
										<div class="form-group">
											<div class="col-sm-offset-2 col-sm-10">
												 <input type="hidden"name="access_id" value="<%if(access_id!=null){out.print(access_id);}%>">
												 <button type="submit" class="btn btn-primary">submit</button>
											</div>
										</div>
									</form>
								</div>
							</div>
						</div>
						<div class="tab-pane fade " id="panel-mail-template">
							
							<div class="row clearfix">
								<div class="col-md-13 column">
									<form class="form-horizontal" method="post" role="form" action="doEditAccess.jsp">
										
										<div class="form-group">
											 <label for="inputTitle" class="col-sm-2 control-label"><span style="color:red">*</span>Mail Title</label>
											<div class="col-sm-8">
												<input type="text" class="form-control" name="title"   value="<%=email_title%>"/>
											</div>
										</div>
										
										<div class="form-group">
											 <label for="inputContent" class="col-sm-2 control-label"><span style="color:red">*</span>Content</label>
											<div class="col-sm-8">
												<textarea class="form-control" name="apply_step" rows="18"><%=content%></textarea>
											</div>
										</div>
										<div class="form-group">
											<div class="col-sm-offset-2 col-sm-10">
												 <input type="hidden"name="access_id" value="<%if(access_id!=null){out.print(access_id);}%>">
												 <button type="submit" class="btn btn-primary">submit</button>
											</div>
										</div>
									</form>
								</div>
							</div>
						</div>
					</div>
				</div>
			</div>
		</div>
	</div>
	<jsp:include page= "bottom.jsp" flush ="true"/>
</body>
</html>
