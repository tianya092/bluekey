<%@ page language="java"
	import="com.bluekey.connDb,com.bluekey.User,java.util.*"
	contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%  

	String email = (String)session.getAttribute("email");
	String  activedStatus =null;
	int  user_id =0;
	String[] remember_arr = null;
	
	if(session.getAttribute("email")==null){
		response.sendRedirect("login.jsp");
	}else{
		User user = connDb.getUser(email);
		String remember= user.getRemember();
		
		if(remember!=null&&!remember.equals("")){ 
			remember_arr = remember.split(",");
		}else{
			remember_arr =new String[] {"0","0","0","0"}; 
		}
		
		user_id = user.getUserId();
		
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

<link href="css/font-awesome.css" rel="stylesheet">
<link href="css/bootstrap-social.css" rel="stylesheet">

<link rel="stylesheet" href="css/style.css">
<link href="css/mystyles.css" rel="stylesheet">

<!-- HTML5 shim and Respond.js for IE8 support of HTML5 elements and media queries -->
<!-- WARNING: Respond.js doesn't work if you view the page via file:// -->
<!--[if lt IE 9]>
      <script src="https://oss.maxcdn.com/html5shiv/3.7.2/html5shiv.min.js"></script>
      <script src="https://oss.maxcdn.com/respond/1.4.2/respond.min.js"></script>
    <![endif]-->


</head>

<body style="margin-bottom: 100px;">
	<div class="container">
	<jsp:include page= "top.jsp" flush ="true"/>

	<div class="top-content" style="margin-top: 100px;">
		<div class="container">
			<div class="row">
				<div class="col-sm-6 col-sm-offset-3 form-box">
					<div class="form-top">
						<img src="img/u6.jpg" style="width: 80%; padding-left: 20%;">
					</div>
					
					<div class="form-bottom" id="select_role" style="background-color: #E7ECF5;">
						<form role="form" action="doSubmit1.jsp" method="post" class="login-form">
							
							<div class="row" style="margin-bottom: 15px;">
								<div class="form-group" style="margin-bottom: 15px;">
									<label for="functionid" class="col-sm-4 control-label "
										style="text-align: right; color: #5c7ebd; font-size: 20px;">Function</label>
									<div class="col-sm-8">
										<select class="function form-control" data-value="<%=remember_arr[0] %>" data-required="true" name="function" ></select>
									</div>
								</div>
							</div>
							<div class="row" style="margin-bottom: 15px;">
								<div class="form-group" style="margin-bottom: 15px;">
									<label for="teamid" class="col-sm-4 control-label" style="text-align: right; color: #5c7ebd; font-size: 20px;">Team</label>
									<div class="col-sm-8">
										<select class="team form-control" data-value="<%=remember_arr[1] %>"  data-required="true" name="team" ></select>
									</div>
								</div>
							</div>
							<div class="row" style="margin-bottom: 15px;">

								<div class="form-group" style="margin-bottom: 15px;">
									<label for="commodity" class="col-sm-4 control-label" style="text-align: right; color: #5c7ebd; font-size: 20px;">Job Role</label>
									<div class="col-sm-8">
										<select class="job_role form-control" data-value="<%=remember_arr[2] %>" data-required="true" name="job_role" ></select>
									</div>
								</div>
							</div>
							<div class="row" style="margin-bottom: 15px;">

								<div class="form-group">
									<label for="commodity" class="col-sm-4 control-label" style="text-align: right; color: #5c7ebd; font-size: 20px;">Commodity</label>
									<div class="col-sm-8">
										<select class="commodity form-control" data-value="<%=remember_arr[3] %>"  name="commodity" ></select>
									</div>
								</div>

							</div>

							<div class="row" style="margin-bottom: 15px;">


								<div class="form-group">
									<div class="col-sm-offset-4 col-sm-6">
										<div class="checkbox">
											<label> <input type="checkbox" style="height: 22px;">
												Remember me
											</label>
										</div>
									</div>
								</div>
							</div>
							<input type="hidden" name="user_id" value = "<%=user_id %>">
							<button type="submit" class="btn">Submit</button>
						</form>
					</div>
				</div>
			</div>
		</div>
	</div>
	</div>
	<jsp:include page= "bottom.jsp" flush ="true"/>

<script src="js/jquery-3.1.0.js"></script>
<script src="js/jquery.cxselect.js"></script>
<script src="js/bootstrap.min.js"></script>
<script>
(function() {
  var urlSelectData = [
	    {'v': '1', 'n': 'PP', 's': [
	        {'v': '1', 'n': 'Ellen Xu', 's': [
		          {'v': '1', 'n': 'GCM', 's': [
			        	  {'v': '1', 'n': 'Platform'},
			        	  {'v': '2', 'n': 'Ecat'},
			        	  {'v': '3', 'n': 'PCB'},
		          ]}
	        ]},
	        {'v': '2', 'n': 'Vivian Chen', 's': [
		          {'v': '2', 'n': 'BC'},
		          {'v': '3', 'n': 'Admin'},
		          {'v': '4', 'n': 'Government relationship'},
		          {'v': '5', 'n': 'HR'},
		          {'v': '6', 'n': 'Assistant of Excutive'},
		          {'v': '7', 'n': 'Communication'},
		          {'v': '8', 'n': 'Reception'}
	        ]},
         	{'v': '3', 'n': 'Shirly Xie', 's': [
	          	  {'v': '9', 'n': 'Consult'}
	        ]},
	        {'v': '4', 'n': 'Simon Lv', 's': [
		          {'v': '10', 'n': 'PCE'},
		          {'v': '11', 'n': 'GCM'}
	        ]}
	   ]},
	   {'v': '2', 'n': 'PI', 's': [
	        {'v': '5', 'n': 'Hugo cai', 's': [
		          {'v': '11', 'n': 'DSW NPM'},
		          {'v': '12', 'n': 'DSW BNPM'},
		          {'v': '13', 'n': 'BPE'},
		          {'v': '14', 'n': 'ESW NPM'},
		          {'v': '15', 'n': 'ESW BNPM'},
		          {'v': '16', 'n': 'Code Mangerment'},
		          {'v': '17', 'n': 'SAP'},
		          {'v': '18', 'n': 'Pring'},
		          {'v': '19', 'n': 'CP'}
	        ]},
	        {'v': '6', 'n': 'kenny Kong', 's': [
		          {'v': '11', 'n': 'DSW NPM'},
		          {'v': '12', 'n': 'DSW BNPM'},
		          {'v': '13', 'n': 'BPE'},
		          {'v': '14', 'n': 'ESW NPM'},
		          {'v': '15', 'n': 'ESW BNPM'},
		          {'v': '16', 'n': 'Code Mangerment'},
		          {'v': '17', 'n': 'SAP'},
		          {'v': '18', 'n': 'Pring'},
		          {'v': '19', 'n': 'CP'}
	        ]},
	        {'v': '7', 'n': 'Anne lei', 's': [
		          {'v': '11', 'n': 'DSW NPM'},
		          {'v': '12', 'n': 'DSW BNPM'},
		          {'v': '13', 'n': 'BPE'},
		          {'v': '14', 'n': 'ESW NPM'},
		          {'v': '15', 'n': 'ESW BNPM'},
		          {'v': '16', 'n': 'Code Mangerment'},
		          {'v': '17', 'n': 'SAP'},
		          {'v': '18', 'n': 'Pring'},
		          {'v': '19', 'n': 'CP'}
	        ]}
	   ]},
	   {'v': '3', 'n': 'Finance', 's': [
	        {'v': '8', 'n': 'Li Ping', 's': [
		          {'v': '20', 'n': 'CPC FIN Control'},
		          {'v': '21', 'n': 'Staff Financial Analyst'}
	        ]}
	   ]},
	   {'v': '4', 'n': 'DSA', 's': [
	        {'v': '9', 'n': 'Mike Huang', 's': [
		          {'v': '22', 'n': 'Demand planning'},
		          {'v': '23', 'n': 'Inventory '},
		          {'v': '24', 'n': 'Supply Assurance'},
		          {'v': '25', 'n': 'GCSA '},
	        ]}
	   ]},
	   {'v': '5', 'n': 'COSSM', 's': [
	        {'v': '10', 'n': 'Jessica Wei', 's': [
		          {'v': '26', 'n': 'Hardware Order to Delivery management'}		         
	        ]}
	   ]},
	   {'v': '6', 'n': 'Eng', 's': [
	        {'v': '11', 'n': 'Logan Huang', 's': [
		          {'v': '27', 'n': 'QE'},
		          {'v': '28', 'n': 'TE'},
		          {'v': '29', 'n': 'OPE'}
	        ]},
	        {'v': '12', 'n': 'Ziv Zhao', 's': [
		          {'v': '30', 'n': 'PQE'},
		          {'v': '31', 'n': 'TQE'},
		          {'v': '32', 'n': 'Test'}
	        ]},
	        {'v': '13', 'n': 'Jason Guo', 's': [
		          {'v': '33', 'n': 'ENG'}
	        ]},
	        {'v': '14', 'n': 'Mary Ma', 's': [
		          {'v': '30', 'n': 'PQE'}
	        ]}
	   ]}
  ];
  $('#select_role').cxSelect({
    selects: ['function', 'team', 'job_role', 'commodity'],
    required: true,
    jsonValue: 'v',
    url: urlSelectData
  });
})();
</script>
</body>
</html>

