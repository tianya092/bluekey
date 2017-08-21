<%@ page language="java"
	import="com.bluekey.connDb,com.bluekey.Role,com.bluekey.User,java.util.*,java.io.*"
	contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%
	String email = (String) session.getAttribute("email");
	if (email == null) {
		response.sendRedirect("login.jsp");
	}
	
	
	User user = connDb.getUser(email); //get user info
	if (user.getFunction() <0) {
		out.println(
				"<script>alert(\"You haven't permission  to vist the page!\");window.location.href=\"query.jsp\";</script>");
	}
	
	String query_function;
	String query_team;
	if (user.getFunction() > 0 && user.getFunction() != 1000) {
		query_function = String.valueOf(user.getFunction());
	} else {
		query_function = request.getParameter("function");
	}

	if (user.getTeam() > 0) {
		query_team = String.valueOf(user.getTeam());
	} else {
		query_team = request.getParameter("team");
	}

	String query_job_role = request.getParameter("job_role");
	String query_commodity = request.getParameter("commodity");

	/* String page = request.getParameter("page"); */
	String[] functionArr = new String[]{"", "PP", "PI", "Finance", "DSA", "COSSM", "Eng"};
	String[] teamArr = new String[]{"", "Ellen Xu", "Vivian Chen", "Shirly Xie", "Simon Lv", "Hugo cai",
			"kenny Kong", "Anne lei", "Li Ping", "Mike Huang", "Jessica Wei", "Logan Huang", "Ziv Zhao",
			"Jason Guo", "Mary Ma"};
	String[] jobRoleArr = new String[]{"", "GCM", "BC", "Admin", "Government relationship", "HR",
			"Assistant of Excutive", "Communication", "Reception", "Consult", "PCE", "GCM", "DSW NPM",
			"DSW BNPM", "BPE", "ESW NPM", "ESW BNPM", "Code Mangerment Team", "SAP team", "Pring team",
			"CP team", "CPC FIN Control", "Staff Financial Analyst", "Demand planning", "Inventory",
			"Supply Assurance", "GCSA", "Hardware Order to Delivery management", "QE", "TE", "OPE", "PQE",
			"TQE", "Test", "ENG", "PQE"};
	String[] commodityArr = new String[]{"", "Platform", "ECAT", "PCB"};

	ArrayList<Role> roleList = connDb.getRoleList(query_function, query_team, query_job_role, query_commodity); //get role list
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
</head>
<body data-spy="scroll" data-target="#myScrollspy">
	<div class=" wrapper">
		<jsp:include page="top.jsp" flush="true" />
		<div class="container">
			<div class="row breadcrumb-nav" >
				<div class="col-xs-12 col-sm-12 col-sm-push-0">
					<ol class="breadcrumb">
						<li><a href="query.jsp">Home</a></li>
						<li><a href="#">Setting</a></li>
						<li class="active">Role manage</li>

					</ol>
				</div>
			</div>

			<legend>Role List</legend>
			<div class="col-md-12" id="select_role_list">
				<form class="form-horizontal" id="detail_form" method="post"
					role="form" action="roleList.jsp">
					<div id="select_role" class="col-md-11">
						<div>
							<label for="inputParent_part"
								class="col-sm-1 control-label role-select-label">Function:</label>
							<div class="col-sm-2">
								<select class="function form-control role-select"
									name="function" data-value="<%=query_function%>"
									data-required="false" data-first-title="Select function"
									disabled="true"
									<%if (user.getFunction() > 0 && user.getFunction() != 1000) {
				out.print("disabled=\"true\"");
			}%>></select>
							</div>
						</div>
						<div>
							<label for="inputParent_part"
								class="col-sm-1 control-label role-select-label">Team:</label>
							<div class="col-sm-2">
								<select class="team form-control" name="team"
									data-value="<%=query_team%>" data-required="false"
									data-first-title="Select team"></select>
							</div>
						</div>
						<div>
							<label for="inputParent_part"
								class="col-sm-1 control-label role-select-label" style="">Job
								Role:</label>
							<div class="col-sm-2">
								<select class="job_role form-control" name="job_role"
									data-value="<%=query_job_role%>" data-required="false"
									data-first-title="Select job role"></select>
							</div>
						</div>
						<div>
							<label for="inputParent_part" class="col-sm-1 control-label"
								role-select-label>Comodity:</label>
							<div class="col-sm-2">
								<select class="commodity form-control" name="commodity"
									data-value="<%=query_commodity%>" data-required="false"
									data-first-title="Select commodity"></select>
							</div>
						</div>
					</div>
					<div class="col-md-1">
						<button class="btn">Query</button>
					</div>
				</form>
			</div>

			<div style="margin-top: 90px;; margin-bottom: 10px;">
				<a href="editRole.jsp" class="btn btn-info btn"> <span
					class="glyphicon glyphicon-plus"></span> add an role
				</a>
			</div>

			<div class="table-responsive">
				<table class="table table-condensed table-hover">
					<thead>
						<tr class="active">
							<th>No</th>
							<th>Function</th>
							<th>Team</th>
							<th>Job role</th>
							<th>Commodity</th>
							<th>Update time</th>
							<th>Update operator</th>
							<th>operate</th>
						</tr>
					</thead>
					<tbody>
						<%
							int i = 1;
							for (Role role : roleList) {
								if (role.getRoleId() != 0) {
									//belongArr = role[1].split(",");
									out.print("<tr><td>" + i + "</td><td>" + functionArr[role.getFunction()] + "</td><td>"
											+ teamArr[role.getTeam()] + "</td><td>" + jobRoleArr[role.getJobRole()] + "</td><td>"
											+ commodityArr[role.getCommodity()] + "</td><td>" + role.getUpdateTime() + "</td><td>"
											+ role.getUpdateOperator() + "</td><td><a href=\"editRole.jsp?role_id=" + role.getRoleId()
											+ "\" title=\"Edit\"><span class=\"glyphicon glyphicon-pencil\"></span></a>&nbsp;&nbsp;&nbsp;&nbsp <a href=\"deleteRole.jsp?role_id="
											+ role.getRoleId()
											+ "\" title=\"Delete\"><span class=\"glyphicon glyphicon-trash\"></span></a></td></tr>");

								}
								i++;
							}
						%>
					</tbody>
				</table>
			</div>
		</div>
	</div>
	<jsp:include page="bottom.jsp" flush="true" />
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
				$('#select_role_list').cxSelect({
					selects : [ 'function', 'team', 'job_role', 'commodity' ],
					required : true,
					jsonValue : 'v',
					url : urlSelectData
				});
			})();
		</script>
</body>
</html>
