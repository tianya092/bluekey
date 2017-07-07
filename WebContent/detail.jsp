<%@ page language="java" import="com.bluekey.connDb,com.bluekey.Access,com.bluekey.Mail,java.util.*,java.io.*" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%  
	String email = (String)session.getAttribute("email");
	Map<String,String> detail; 
	
	Access access = new Access();
	if(email==null){
		//request.getRequestDispatcher("login.jsp").forward(request,response);
		response.sendRedirect("login.jsp");
	}else{
		String access_id = request.getParameter("access_id");
		String	user_id = (String)session.getAttribute("user_id");
		
		access = connDb.accessDetail(access_id); //get access detail
		/* boolean right = connDb.checkUserAccess(user_id, access_id); //check access_id is in user'access or not
		if(right==false){
			out.println("<script>alert(\"You have't access to visit the page! Please contact Administrator\");window.location.href=\"result.jsp?user_id="+user_id+"\";</script>");
		}else{
			access = connDb.accessDetail(access_id); //get access detail
			
		} */
	}
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
       /* #section-1 {color: #fff; background-color: #1E88E5;}
        #section-2 {color: #fff; background-color: #673ab7;}
        #section-3 {color: #fff; background-color: #ff9800;}
       */
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

function sendEmail(access_id){
	if(confirm("Are you sure to send an email to apply for the access?")==true){
		
		$.ajax({
            type: "POST",
            url: "sendEmail.jsp",
            data: "access_id="+access_id,
            data_type:String,
            success:function(data){
            	data=$.trim(data) ;
            	if("true"== data  ){
            		alert("Send successfully!");
            	}else{
            		alert("Send error! Please contact IT for help.");
            	}
           	},
            error: function(XMLHttpRequest, textStatus, errorThrown) {  //#3这个error函数调试时非常有用，如果解析不正确，将会弹出错误框
                    alert("Some error occured! Please contact IT for help.");
            },
		})
	}
}


</script>
</head>
<body data-spy="scroll" data-target="#myScrollspy">

    <jsp:include page= "top.jsp" flush ="true"/>
	<div class="container" style="min-height:630px;">
	   
	    <div class="row">
	        <div class="col-xs-3" id="myScrollspy">
	            <ul class="nav nav-tabs nav-stacked" id="myNav">
	                <li class="active"><a href="#section-1">Description</a></li>
	                <li><a href="#section-2">Guideline</a></li>
	                <li><a href="#section-3">Resources</a></li>
	            </ul>
	        </div>
	        <div class="col-xs-9">
	            <h2 id="section-1"><%=access.getTitle() %></h2>   
				<hr>
	            <p>
					<%=access.getFunction() %>
				</p>
				<hr>
					<%
						if(access.getPlatform().equals("1")) {
							out.print("lotus notes");
						}else if(access.getPlatform().equals("2")){
							out.print("web");
						}
							
					%>
	            <hr>
	            <p>
	            	<%=access.getApplyStep() %>
	            </p>
	            <hr>
	            <p>
	            	<a href=<%=access.getUrl() %> target="view_window"><%=access.getUrl()%></a>
	            </p>
	            <hr>
	            <p>If you want to send an email to apply for the access, please click the button!</p>
	            <!-- <button onclick="sendEmail(1)">send Email</button> -->
	          	<div class="container">
					<div class="row clearfix">
						<div class="col-md-12 column">
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
												Map mailMap = connDb.getMailTemplate("1"); //get send mail template
											%>
											<div class="modal-body" style="width:610px;">
												<div >
														<div class="form-group">
															 <label for="inputRecevieAddress" class="col-sm-2 control-label">Receive Address</label>
															<div class="col-sm-9">
																<input type="text" class="form-control"  disabled name="Receive_email" style="width:410px;" value="<%=email %>"/><span class="label label-warning">Alert</span>
															</div>
															
														</div>
														
														<div class="form-group">
															 <label for="inputEmailTitle" class="col-sm-2 control-label">CC</label>
															<div class="col-sm-10 ">
																<input type="text" class="form-control" name="carbon_copying" style="width:410px;" value="<%=email %>"/>
															</div>
														</div>
														<div class="form-group">
															 <label for="inputEmailTitle" class="col-sm-2 control-label">Subject</label>
															<div class="col-sm-9">
																<input type="text" class="form-control" name="email_title" style="width:410px;" value="<%=mailMap.get("subject_title") %>"/>
															</div>
														</div>
														<div class="form-group">
															 <label for="inputEmailContent" class="col-sm-2 control-label">Content</label>
															<div class="col-sm-9">
																<textarea class="form-control" name="email_content" rows="15"> <%=mailMap.get("content")%></textarea>
																
															</div>
														</div>
												</div>
											</div>
											<div class="modal-footer">
												<input type="hidden" name="access_id" value="1">
												 <button type="button" class="btn btn-default" data-dismiss="modal">Cancel</button> <button type="submit" class="btn btn-primary">Send</button>
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
	    
	</div>
	 <jsp:include page= "bottom.jsp" flush ="true"/>
</body>
</html>
