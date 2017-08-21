<%@ page language="java"
	import="com.bluekey.connDb,com.bluekey.User,java.util.*"
	contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%
	String email = (String) session.getAttribute("email");
	String activedStatus = null;
	int user_id = 0;
	String[] remember_arr = null;
	remember_arr = new String[]{"0", "0", "0", "0"};

	if (session.getAttribute("email") == null) {
		response.sendRedirect("login.jsp");
	} else {
		User user = connDb.getUser(email);
		String remember = user.getRemember();

		if (remember != null && !remember.equals("")) {
			remember_arr = remember.split(",");
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
<link href="css/style.css" rel="stylesheet">
<link href="css/mystyles.css" rel="stylesheet">
</head>

<body>
	<div class="wrapper">
		<jsp:include page="top.jsp" flush="true" />

		<div class="container" style="margin-top: 10%;">
			<div class="col-sm-6 col-sm-offset-3 form-box">
				<div class="form-top">
					<img src="img/u6.jpg" style="width: 80%; padding-left: 20%;">
				</div>

				<div class="form-bottom" id="select_role"
					style="background-color: #E7ECF5;">
					<form role="form" action="doSubmit.jsp" method="post"
						class="login-form">

						<div class="row" style="margin-bottom: 15px;">
							<div class="form-group" style="margin-bottom: 15px;">
								<label for="functionid" class="col-sm-4 control-label "
									style="text-align: right; color: #5c7ebd; font-size: 20px;">Function</label>
								<div class="col-sm-8">
									<select class="function form-control"
										data-value="<%=remember_arr[0]%>" data-required="true"
										name="function"></select>
								</div>
							</div>
						</div>
						<div class="row" style="margin-bottom: 15px;">
							<div class="form-group" style="margin-bottom: 15px;">
								<label for="teamid" class="col-sm-4 control-label"
									style="text-align: right; color: #5c7ebd; font-size: 20px;">Team</label>
								<div class="col-sm-8">
									<select class="team form-control"
										data-value="<%=remember_arr[1]%>" data-required="true"
										name="team"></select>
								</div>
							</div>
						</div>
						<div class="row" style="margin-bottom: 15px;">

							<div class="form-group" style="margin-bottom: 15px;">
								<label for="commodity" class="col-sm-4 control-label"
									style="text-align: right; color: #5c7ebd; font-size: 20px;">Job
									Role</label>
								<div class="col-sm-8">
									<select class="job_role form-control"
										data-value="<%=remember_arr[2]%>" data-required="true"
										name="job_role"></select>
								</div>
							</div>
						</div>
						<div class="row" style="margin-bottom: 15px;">

							<div class="form-group">
								<label for="commodity" class="col-sm-4 control-label"
									style="text-align: right; color: #5c7ebd; font-size: 20px;">Commodity</label>
								<div class="col-sm-8">
									<select class="commodity form-control"
										data-value="<%=remember_arr[3]%>" name="commodity"></select>
								</div>
							</div>

						</div>

						<div class="row" style="margin-bottom: 15px;">


							<div class="form-group">
								<div class="col-sm-offset-4 col-sm-6">
									<div class="checkbox">
										<label> <input type="checkbox" name="remember_type"
											style="height: 22px;"> Remember my selection
										</label>
									</div>
								</div>
							</div>
						</div>
						<input type="hidden" name="user_id" value="<%=user_id%>">
						<button type="submit" class="btn">Query</button>
					</form>
				</div>
			</div>
		</div>
	</div>
	<jsp:include page="bottom.jsp" flush="true" />

	<script src="js/jquery-1.10.2.min.js"></script>
	<script src="js/jquery.cxselect.js"></script>
	<script src="js/bootstrap.min.js"></script>
	<script>
		(function() {
			var urlSelectData = [ {
				'v' : '1',
				'n' : 'PP',
				's' : [ {
					'v' : '1',
					'n' : 'Ellen Xu',
					's' : [ {
						'v' : '1',
						'n' : 'GCM',
						's' : [ {
							'v' : '1',
							'n' : 'Platform'
						}, {
							'v' : '2',
							'n' : 'Ecat'
						}, {
							'v' : '3',
							'n' : 'PCB'
						}, ]
					} ]
				}, {
					'v' : '2',
					'n' : 'Vivian Chen',
					's' : [ {
						'v' : '2',
						'n' : 'BC'
					}, {
						'v' : '3',
						'n' : 'Admin'
					}, {
						'v' : '4',
						'n' : 'Government relationship'
					}, {
						'v' : '5',
						'n' : 'HR'
					}, {
						'v' : '6',
						'n' : 'Assistant of Excutive'
					}, {
						'v' : '7',
						'n' : 'Communication'
					}, {
						'v' : '8',
						'n' : 'Reception'
					} ]
				}, {
					'v' : '3',
					'n' : 'Shirly Xie',
					's' : [ {
						'v' : '9',
						'n' : 'Consult'
					} ]
				}, {
					'v' : '4',
					'n' : 'Simon Lv',
					's' : [ {
						'v' : '10',
						'n' : 'PCE'
					}, {
						'v' : '11',
						'n' : 'GCM'
					} ]
				} ]
			}, {
				'v' : '2',
				'n' : 'PI',
				's' : [ {
					'v' : '5',
					'n' : 'Hugo cai',
					's' : [ {
						'v' : '12',
						'n' : 'DSW NPM'
					}, {
						'v' : '13',
						'n' : 'DSW BNPM'
					}, {
						'v' : '14',
						'n' : 'BPE'
					}, {
						'v' : '15',
						'n' : 'ESW NPM'
					}, {
						'v' : '16',
						'n' : 'ESW BNPM'
					}, {
						'v' : '17',
						'n' : 'Code Mangerment'
					}, {
						'v' : '18',
						'n' : 'SAP'
					}, {
						'v' : '19',
						'n' : 'Pring'
					}, {
						'v' : '20',
						'n' : 'CP'
					} ]
				}, {
					'v' : '6',
					'n' : 'kenny Kong',
					's' : [ {
						'v' : '12',
						'n' : 'DSW NPM'
					}, {
						'v' : '13',
						'n' : 'DSW BNPM'
					}, {
						'v' : '14',
						'n' : 'BPE'
					}, {
						'v' : '15',
						'n' : 'ESW NPM'
					}, {
						'v' : '16',
						'n' : 'ESW BNPM'
					}, {
						'v' : '17',
						'n' : 'Code Mangerment'
					}, {
						'v' : '18',
						'n' : 'SAP'
					}, {
						'v' : '19',
						'n' : 'Pring'
					}, {
						'v' : '20',
						'n' : 'CP'
					} ]
				}, {
					'v' : '7',
					'n' : 'Anne lei',
					's' : [ {
						'v' : '12',
						'n' : 'DSW NPM'
					}, {
						'v' : '13',
						'n' : 'DSW BNPM'
					}, {
						'v' : '14',
						'n' : 'BPE'
					}, {
						'v' : '15',
						'n' : 'ESW NPM'
					}, {
						'v' : '16',
						'n' : 'ESW BNPM'
					}, {
						'v' : '17',
						'n' : 'Code Mangerment'
					}, {
						'v' : '18',
						'n' : 'SAP'
					}, {
						'v' : '19',
						'n' : 'Pring'
					}, {
						'v' : '20',
						'n' : 'CP'
					} ]
				} ]
			}, {
				'v' : '3',
				'n' : 'Finance',
				's' : [ {
					'v' : '8',
					'n' : 'Li Ping',
					's' : [ {
						'v' : '21',
						'n' : 'CPC FIN Control'
					}, {
						'v' : '22',
						'n' : 'Staff Financial Analyst'
					} ]
				} ]
			}, {
				'v' : '4',
				'n' : 'DSA',
				's' : [ {
					'v' : '9',
					'n' : 'Mike Huang',
					's' : [ {
						'v' : '23',
						'n' : 'Demand planning'
					}, {
						'v' : '24',
						'n' : 'Inventory '
					}, {
						'v' : '25',
						'n' : 'Supply Assurance'
					}, {
						'v' : '26',
						'n' : 'GCSA '
					}, ]
				} ]
			}, {
				'v' : '5',
				'n' : 'COSSM',
				's' : [ {
					'v' : '10',
					'n' : 'Jessica Wei',
					's' : [ {
						'v' : '27',
						'n' : 'Hardware Order to Delivery management'
					} ]
				} ]
			}, {
				'v' : '6',
				'n' : 'Eng',
				's' : [ {
					'v' : '11',
					'n' : 'Logan Huang',
					's' : [ {
						'v' : '28',
						'n' : 'QE'
					}, {
						'v' : '29',
						'n' : 'TE'
					}, {
						'v' : '30',
						'n' : 'OPE'
					} ]
				}, {
					'v' : '12',
					'n' : 'Ziv Zhao',
					's' : [ {
						'v' : '31',
						'n' : 'PQE'
					}, {
						'v' : '32',
						'n' : 'TQE'
					}, {
						'v' : '33',
						'n' : 'Test'
					} ]
				}, {
					'v' : '13',
					'n' : 'Jason Guo',
					's' : [ {
						'v' : '34',
						'n' : 'ENG'
					} ]
				}, {
					'v' : '14',
					'n' : 'Mary Ma',
					's' : [ {
						'v' : '35',
						'n' : 'PQE'
					} ]
				} ]
			} ];
			$('#select_role').cxSelect({
				selects : [ 'function', 'team', 'job_role', 'commodity' ],
				required : true,
				jsonValue : 'v',
				url : urlSelectData
			});
		})();
	</script>
</body>
</html>

