<%@ page language="java"
	import="com.bluekey.connDb,com.bluekey.Access,com.bluekey.User,java.util.*"
	contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%
	request.setCharacterEncoding("utf-8");
	String email = (String) session.getAttribute("email");
	if (email == null) {
		response.sendRedirect("login.jsp");
	}

	String user_id = request.getParameter("user_id");
	User user = new User();

	if (user_id != null && !user_id.equals("")) {
		user = connDb.getUserByID(user_id); //get user info
	}
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>BLUE KEY</title>
<script src="js/jquery-3.1.0.min.js"></script>
<script src="js/bootstrap.min.js"></script>
<script src="js/bootstrapValidator.js"></script>
<script src="js/language/zh_CN.js"></script>
<script src="js/jquery.cxselect.js"></script>

<link rel="shortcut icon" href="img/favico.ico"/>
<link href="css/bootstrap.min.css" rel="stylesheet">
<link href="css/bootstrap-theme.min.css" rel="stylesheet">
<link href="css/mystyles.css" rel="stylesheet">
<link href="css/font-awesome.css" rel="stylesheet">
<link href="css/bootstrap-social.css" rel="stylesheet">
<link href="css/bootstrapValidator.css" rel="stylesheet">

</head>
<body style="overflow:scroll;overflow-x:hidden">
	<div class=" wrapper">
		<div class="page">
			<jsp:include page="top.jsp" flush="true" />
			<div class="container">

				<div class="row breadcrumb-nav">
					<div class="col-xs-12 col-sm-12 col-sm-push-0">
						<ol class="breadcrumb">
							<li><a href="query.jsp">Home</a></li>
							<li><a href="#">Setting</a></li>
							<li class="active">Edit authority role </li>

						</ol>
					</div>
				</div>
				<legend>Edit authority</legend>
				<div class="col-md-12 column">
					<form class="form-horizontal" role="form" action="doUserRight.jsp">
						<div id="select_role">
							<div class="form-group">
								<label for="inputEmailTitle" class="col-sm-3 control-label"><span
									style="color: red">*</span>User Email:</label>
								<div class="col-sm-6 ">
									<label class="col-sm-3 control-label"><%=user.getEmail()%></label>
								</div>
							</div>
							<div class="form-group">
								<label for="inputParent_part" class="col-sm-3 control-label">
									<span style="color: red">*</span>Function:
								</label>
								<div class="col-sm-6">
									<select class="function form-control"
										data-value="<%=user.getFunction()%>" name="function"></select>
								</div>
							</div>
							<div class="form-group">
								<label for="inputParent_part" class="col-sm-3 control-label">Team:</label>
								<div class="col-sm-6">
									<select class="team form-control" data-required="false"
										data-first-title="Select team"
										data-value="<%=user.getTeam()%>" name="team"></select>
								</div>
							</div>
							<div class="form-group">
								<div class="col-sm-offset-3 col-sm-10">
									<input type="hidden" name="user_id" value="<%=user_id%>">
									<input type="hidden" name="user_email"
										value="<%=user.getEmail()%>">
									<button type="submit" class="btn btn-primary">submit</button>
								</div>
							</div>
						</div>
					</form>
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
	<script>
		$(document).ready(function(){
			$(".top").on("click", function() { 
	            $("body").stop().animate({  
	                scrollTop: 0  
	            });  
	        })  
		});
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
			}, {
				'v' : '7',
				'n' : 'global procurement for test',
				's' : [ {
					'v' : '15',
					'n' : 'team_01',
					's' : [ {
						'v' : '36',
						'n' : 'job role_01',
						's' : [ {
							'v' : '4',
							'n' : 'commodity_01'
						}, {
							'v' : '5',
							'n' : 'commodity_02'
						}, {
							'v' : '6',
							'n' : 'commodity_03'
						} ]
					} ]
				} ]
			} , {
				'v' : '1000',
				'n' : 'Super Admin'
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
