<%@ page language="java"
	import="com.bluekey.connDb,com.bluekey.Access,com.bluekey.Role,com.bluekey.User,java.util.*"
	contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%
	request.setCharacterEncoding("utf-8");
	String email = (String) session.getAttribute("email");
	if (email == null) {
		response.sendRedirect("login.jsp");
	}

	User user = connDb.getUser(email); //get user info

	String role_id = request.getParameter("role_id");

	String[] functionArr = new String[]{"", "PP", "PI", "Finance", "DSA", "COSSM", "Eng","global procurement for test"};
	String[] teamArr = new String[]{"", "Ellen Xu", "Vivian Chen", "Shirly Xie", "Simon Lv", "Hugo cai",
			"kenny Kong", "Anne lei", "Li Ping", "Mike Huang", "Jessica Wei", "Logan Huang", "Ziv Zhao",
			"Jason Guo", "Mary Ma","team_01"};
	String[] jobRoleArr = new String[]{"", "GCM", "BC", "Admin", "Government relationship", "HR",
			"Assistant of Excutive", "Communication", "Reception", "Consult", "PCE", "GCM", "DSW NPM",
			"DSW BNPM", "BPE", "ESW NPM", "ESW BNPM", "Code Mangerment Team", "SAP team", "Pring team",
			"CP team", "CPC FIN Control", "Staff Financial Analyst", "Demand planning", "Inventory",
			"Supply Assurance", "GCSA", "Hardware Order to Delivery management", "QE", "TE", "OPE", "PQE",
			"TQE", "Test", "ENG", "PQE","job_role_01"};
	String[] commodityArr = new String[]{"", "Platform", "ECAT", "PCB","commodity_01","commodity_02","commodity_03"};

	Role role = new Role();
	ArrayList<String[]> generalList = null;
	ArrayList<String[]> functionList = null;
	ArrayList<String[]> othersList = null;

	String[] general_access = null;
	String[] function_access = null;
	String[] accessArr = null;

	Map<String, ArrayList<String[]>> accessMap = connDb.getAccessList1(); //get access list
	generalList = accessMap.get("generalList");// get all general access
	functionList = accessMap.get("functionList");// get all general  access

	if (role_id != null && !role_id.equals("")) {
		role = connDb.getRole(role_id); //get access list
		accessArr = role.getAccessList().split(",");

		//user access_id is in the list
		for (int i = 0; i < generalList.size(); i++) {
			if (Arrays.asList(accessArr).contains(generalList.get(i)[0])) {
				generalList.set(i, connDb.concat(generalList.get(i), new String[]{"checked"}));
			} else {
				generalList.set(i, connDb.concat(generalList.get(i), new String[]{""}));
			} ;
		}

		for (int i = 0; i < functionList.size(); i++) {
			if (Arrays.asList(accessArr).contains(functionList.get(i)[0])) {
				functionList.set(i, connDb.concat(functionList.get(i), new String[]{"checked"}));
			} else {
				functionList.set(i, connDb.concat(functionList.get(i), new String[]{""}));
			} ;
		}
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

<link rel="shortcut icon" href="img/favico.ico"/>
<link href="css/bootstrap.min.css" rel="stylesheet">
<link href="css/bootstrap-theme.min.css" rel="stylesheet">
<link href="css/mystyles.css" rel="stylesheet">
<link href="css/font-awesome.css" rel="stylesheet">
<link href="css/bootstrap-social.css" rel="stylesheet">
<link href="css/bootstrapValidator.css" rel="stylesheet">
<script type="text/javascript">
$(document).ready(function(){
	var functionStatus ="<%= user.getFunction() %>";
	var teamStatus ="<%= user.getTeam() %>";
	if (functionStatus > 0 && functionStatus != 1000){
		$("#edit-role-select").attr("disabled", true);
	}
	if (teamStatus > 0 ){
		$("#edit-team-select").attr("disabled", true);
	}
	
})

</script>
</head>
<body style="overflow:scroll;overflow-x:hidden">
	<div class=" wrapper">
	<div class="page">
		<jsp:include page="top.jsp" flush="true" />
		
		<div class="container" >
			<div class="row breadcrumb-nav">
				<div class="col-xs-12 col-sm-12">
					<ol class="breadcrumb">
						<li><a href="input.jsp">Home</a></li>
						<li><a href="#">Setting</a></li>
						<li class="active">Edit job role</li>

					</ol>
				</div>
			</div>
		
			<fieldset id="custom_data">
				<legend>Edit Job Role</legend>
				<div class="col-md-12 column">
					<form class="form-horizontal" id="role_form" method="post"
						role="form" action="doEditRole.jsp">
						<div id="select_role">
							<div class="form-group">
								<label for="inputParent_part" class="col-sm-2 control-label"><span
									style="color: red">*</span>Function:</label>
								<div class="col-sm-4">
									<%
										if (role_id == null || role_id.equals("")) {
									%>
									<select class="function form-control" name="function" id="edit-role-select"
										data-value="<%=user.getFunction()%>"></select>
									<%
										} else {
									%>
									<div class="col-sm-7">
										<p class="form-control-static"><%=functionArr[role.getFunction()]%></p>
									</div>
									<%
										}
									%>
								</div>
							</div>
							<div class="form-group">
								<label for="inputParent_part" class="col-sm-2 control-label"><span
									style="color: red">*</span>Team:</label>
								<div class="col-sm-4">
									<%
										if (role_id == null || role_id.equals("")) {
									%>
									<select class="team form-control" name="team" id="edit-team-select"
										data-value="<%=user.getTeam()%>"></select>
									<%
										} else {
									%>
									<div class="col-sm-7">
										<p class="form-control-static"><%=teamArr[role.getTeam()]%></p>
									</div>
									<%
										}
									%>
								</div>
							</div>
							<div class="form-group">
								<label for="inputParent_part" class="col-sm-2 control-label"><span
									style="color: red">*</span>Job Role:</label>
								<div class="col-sm-4">
									<%
										if (role_id == null || role_id.equals("")) {
									%>
									<select class="job_role form-control" name="job_role"></select>
									<%
										} else {
									%>
									<div class="col-sm-7">
										<p class="form-control-static"><%=jobRoleArr[role.getJobRole()]%></p>
									</div>
									<%
										}
									%>
								</div>
							</div>
							<div class="form-group">
								<label for="inputParent_part" class="col-sm-2 control-label">Commodity:</label>
								<div class="col-sm-4">
									<%
										if (role_id == null || role_id.equals("")) {
									%>
									<select class="commodity form-control" name="commodity"></select>
									<%
										} else {
									%>
									<div class="col-sm-7">
										<p class="form-control-static"><%=commodityArr[role.getCommodity()]%></p>
									</div>
									<%
										}
									%>
								</div>
							</div>
						</div>
						<div class="form-group">
							<label for="inputPlatform" class="col-sm-2 control-label">Access:</label>
							<div class="col-sm-8 check-role">
								<hr>
								<span style="color: red">*</span><label>General access</label></br>
								<%
									if (generalList != null) {
										for (String[] generalAccess : generalList) {
											if (role_id != null) {
												out.println("<div ><input type=\"checkbox\" name=\"general_access\" " + generalAccess[3]
														+ " value=" + generalAccess[0] + ">" + generalAccess[2] + "&nbsp;&nbsp;</div>");

											} else {
												out.println("<div ><input type=\"checkbox\" name=\"general_access\"  value=" + generalAccess[0]
														+ ">" + generalAccess[2] + "&nbsp;&nbsp;</div>");
											}
										}
									}
								%>
								<hr>
								<label>Function access</label></br>
								<%
									if (functionList != null) {
										for (String[] functionAccess : functionList) {
											if (role_id != null) {
												out.println("<div ><input type=\"checkbox\" name=\"function_access\" " + functionAccess[3]
														+ " value=" + functionAccess[0] + ">" + functionAccess[2] + "&nbsp;&nbsp;</div>");
											} else {
												out.println("<div ><input type=\"checkbox\" name=\"function_access\"  value="
														+ functionAccess[0] + ">" + functionAccess[2] + "&nbsp;&nbsp;</div>");
											}
										}
									}
								%>
								<%-- <hr>otherAccess</br>
						<%
							if(otherList!=null){
				             	for(String[] otherAccess :otherList){
				             		out.println("<label class=\"checkbox-inline\"><input type=\"checkbox\" name=\"other_access\" value="+otherAccess[0]+"\">"+otherAccess[2]+"</label>");
				             	}	
		             		} 
						%> --%>
								<hr>
							</div>

						</div>
						<div class="form-group">
							<div class="col-sm-offset-2 col-sm-10">
								<input type="hidden" name="role_id"
									value="<%if (role_id != null) {
				out.print(role_id);
			}%>">
								<button type="submit" class="btn btn-primary">submit</button>
							</div>
						</div>
					</form>
				</div>
			</fieldset>
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
		$(document)
				.ready(
						function() {

							$('#role_form')
									.bootstrapValidator(
											{
												message : 'This value is not valid',
												feedbackIcons : {/*输入框不同状态，显示图片的样式*/
													valid : 'glyphicon glyphicon-ok',
													invalid : 'glyphicon glyphicon-remove',
													validating : 'glyphicon glyphicon-refresh'
												},
												fields : {/*验证*/

													general_access : {
														validators : {
															notEmpty : {
																message : 'The general access is required and cannot be empty'
															},
															stringLength : {
																min : 1,

																message : 'The general access must be more than 1 access'
															},
														}
													},

												}
											});
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
			} , {
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
