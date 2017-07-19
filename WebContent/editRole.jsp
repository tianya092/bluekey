<%@ page language="java" import="com.bluekey.connDb,com.bluekey.Access,com.bluekey.Role,java.util.*" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%  
	String role_id = request.getParameter("role_id");
	
	String[] functionArr = new String[]{"","PP","PI","Finance","DSA","COSSM"};
	String[] teamArr = new String[]{"","Ellen Xu","Vivian Chen","Shirly Xie","Simon Lv","Hugo cai","kenny Kong","Anne lei","Li Ping","Mike Huang","Jessica Wei"};
	String[] jobRoleArr = new String[]{"","GCM","BC","Admin","Government relationship","HR","Assistant of Excutive","Communication","Reception","Consult","PCE","DSW NPM","DSW BNPM","BPE","ESW NPM","ESW BNPM","Code Mangerment Team","SAP team","Pring team","CP team","CPC FIN Control","Staff Financial Analyst","Demand planning","Inventory","Supply Assurance","GCSA","Hardware Order to Delivery management"};
	String[] commodityArr = new String[]{"","Platform","Ecat","PCB"};

	Role role = new Role();
	ArrayList<String[]> generalList = null;
	ArrayList<String[]> functionList = null;
	ArrayList<String[]> othersList = null;
	
	String[] general_access= null;
	String[] function_access= null;
	String[] others_access= null;
	
	
	Map<String,ArrayList<String[]>> accessMap = connDb.getAccessList1(); //get access list
	generalList = accessMap.get("generalList");// get all general access
	functionList = accessMap.get("functionList");// get all general  access
	othersList = accessMap.get("otherList");// get all other  access

	if(role_id!=null&&!role_id.equals("")){
		role = connDb.getRole(role_id); //get access list
		general_access= role.getGeneralAccess().split(",");
		function_access= role.getFunctionAccess().split(",");
		others_access= role.getOthersAccess().split(",");
		
		String[] generalArr = null;
		//user access_is is in the list
		for(int i=0;i<generalList.size();i++){
			if(Arrays.asList(general_access).contains(generalList.get(i)[0])){
				generalList.set(i,connDb.concat(generalList.get(i),new String[]{"checked"}));
			}else{
				generalList.set(i,connDb.concat(generalList.get(i),new String[]{""}));
			};
		}
		
		for(int i=0;i<functionList.size();i++){
			if(Arrays.asList(function_access).contains(functionList.get(i)[0])){
				functionList.set(i,connDb.concat(functionList.get(i),new String[]{"checked"}));
			}else{
				functionList.set(i,connDb.concat(functionList.get(i),new String[]{""}));
			};
		}
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
	<fieldset id="custom_data">
    <legend>Edit Role</legend>
		<div class="col-md-12 column" id="select_role">
			<form class="form-horizontal" id="detail_form" method="post" role="form" action="doEditRole.jsp">
				<div id="select_role">
					<div class="form-group">
						 <label for="inputParent_part" class="col-sm-2 control-label"><span style="color:red">*</span>Function:</label>
						<div class="col-sm-4">
							<%if(role_id==null){ %>
								<select class="function form-control"  name="function" ></select>
							<% }else{ %>
								<div class="col-sm-7">
									<p class="form-control-static"><%=functionArr[role.getFunction()]%></p>
								</div>
							<%} %>
						</div>
					</div>
					<div class="form-group">
						<label for="inputParent_part" class="col-sm-2 control-label"><span style="color:red">*</span>Team:</label>
						<div class="col-sm-4">
							<%if(role_id==null){ %>
								<select class="team form-control"  name="team" ></select>
							<% }else{ %>
								<div class="col-sm-7">
									<p class="form-control-static"><%=teamArr[role.getTeam()] %></p>
								</div>
							<%} %>
						</div>
					</div>
					<div class="form-group">
						<label for="inputParent_part" class="col-sm-2 control-label"><span style="color:red">*</span>Job Role:</label>
						<div class="col-sm-4">
							<%if(role_id==null){ %>
								<select class="job_role form-control"  name="job_role" ></select>
							<% }else{ %>
								<div class="col-sm-7">
									<p class="form-control-static"><%=jobRoleArr[role.getJobRole()] %></p>
								</div>
							<%} %>
					</div>
				</div>
				<div class="form-group">
					 <label for="inputParent_part" class="col-sm-2 control-label">Comodity:</label>
					<div class="col-sm-4">
						<%if(role_id==null){ %>
							<select class="commodity form-control"  name="commodity" ></select>
						<% }else{ %>
							<div class="col-sm-7">
								<p class="form-control-static"><%=commodityArr[role.getCommodity()] %></p>
							</div>
						<%} %>
					</div>
				</div>
				</div>
				<div class="form-group">
					 <label for="inputPlatform" class="col-sm-2 control-label"><span style="color:red">*</span>Access:</label>
					<div class="col-sm-8">
						<hr>General access</br>
						<%
							if(generalList!=null){
				             	for(String[] generalAccess :generalList){
				             		if(role_id!=null){
				             			out.println("<label class=\"checkbox-inline\"><input type=\"checkbox\" name=\"general_access\" "+generalAccess[3]+" value="+generalAccess[0]+">"+generalAccess[2]+"&nbsp;&nbsp;</label>");
						             	
				             		}else{
				             			out.println("<label class=\"checkbox-inline\"><input type=\"checkbox\" name=\"general_access\"  value="+generalAccess[0]+">"+generalAccess[2]+"&nbsp;&nbsp;</label>");
				             		}
			             		}	
		             		} 
						%>
						<hr>Function access</br>
						<%
							if(functionList!=null){
								for(String[] functionAccess :functionList){
									if(role_id!=null){
				             			out.println("<label class=\"checkbox-inline\"><input type=\"checkbox\" name=\"function_access\" "+functionAccess[3]+" value="+functionAccess[0]+">"+functionAccess[2]+"&nbsp;&nbsp;</label>");
				             		}else{
				             			out.println("<label class=\"checkbox-inline\"><input type=\"checkbox\" name=\"function_access\"  value="+functionAccess[0]+">"+functionAccess[2]+"&nbsp;&nbsp;</label>");}	
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
						 <input type="hidden"name="role_id" value="<%if(role_id!=null){out.print(role_id);}%>">
						 <button type="submit" class="btn btn-primary">submit</button>
					</div>
				</div>
			</form>
		</div>
		</fieldset>
	</div>
	<jsp:include page= "bottom.jsp" flush ="true"/>
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
