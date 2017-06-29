<%@ page language="java" import="BlueKey.connDb,BlueKey.Role,java.util.*,java.io.*" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%  
	String email = (String)session.getAttribute("email");
	/* String page = request.getParameter("page"); */
	String[] functionArr = new String[]{"","PP","PI","Finance","DSA","COSSM"};
	String[] teamArr = new String[]{"","Ellen Xu","Vivian Chen","Shirly Xie","Simon Lv","Hugo cai","kenny Kong","Anne lei","Li Ping","Mike Huang","Jessica Wei"};
	String[] jobRoleArr = new String[]{"","GCM","BC","Admin","Government relationship","HR","Assistant of Excutive","Communication","Reception","Consult","PCE","DSW NPM","DSW BNPM","BPE","ESW NPM","ESW BNPM","Code Mangerment Team","SAP team","Pring team","CP team","CPC FIN Control","Staff Financial Analyst","Demand planning","Inventory","Supply Assurance","GCSA","Hardware Order to Delivery management"};
	String[] commodityArr = new String[]{"","Platform","Ecat","PCB"};
	ArrayList<Role>  roleList = connDb.getRoleList(); //get role list
	
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>BLUE KEY</title>
<link rel="stylesheet" href="http://cdn.static.runoob.com/libs/bootstrap/3.3.7/css/bootstrap.min.css">
<script src="http://cdn.static.runoob.com/libs/jquery/2.1.1/jquery.min.js"></script>
<script src="http://cdn.static.runoob.com/libs/bootstrap/3.3.7/js/bootstrap.min.js"></script>

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
</script>
</head>
<body data-spy="scroll" data-target="#myScrollspy">
	
    <jsp:include page= "top.jsp" flush ="true"/>
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
		<legend>Role List</legend>
		<div class="page-header">
			<a href="editRole.jsp" class="btn btn-info btn" >
          		<span class="glyphicon glyphicon-plus" ></span> add an role
        	</a>
		</div> 
		<div class="table-responsive">
		    <form role="form" action="doManageAccess.jsp">
		        
				<table class="table table-condensed table-hover">
					<thead>
						<tr class="active">
		        			<th>No</th> 
		        			<th>Function</th>
		        			<th>Team</th>
		        			<th>Job role</th>
		        			<th>Commodity</th>
		        			<th>operate</th>
		        		</tr>
					</thead>
		        	<tbody>
			        	<%
			        		int i= 1;
			        		for(Role role : roleList){
			        			if(role.getRoleId()!=0){
			        				//belongArr = role[1].split(",");
			        				out.print("<tr><td>"+i+"</td><td>"+functionArr[role.getFunction()]+"</td><td>"+teamArr[role.getTeam()]+"</td><td>"+jobRoleArr[role.getJobRole()]+"</td><td>"+commodityArr[role.getCommodity()]+"</td><td><a href=\"editRole.jsp?role_id="+role.getRoleId()+"\"><span class=\"glyphicon glyphicon-pencil\"></span></a>&nbsp;&nbsp;&nbsp;&nbsp <a href=\"deleteRole.jsp?role_id="+role.getRoleId()+"\"><span class=\"glyphicon glyphicon-trash\"></span></a></td></tr>");
					        		
			        			}
			        			i++;
		        			}
			        	%>
					</tbody>
				</table>
				<ul class="pagination">
				<li>
					 <a href="#">Prev</a>
				</li>
				<li>
					 <a href="#">1</a>
				</li>
				<li>
					 <a href="#">2</a>
				</li>
				<li>
					 <a href="#">3</a>
				</li>
				<li>
					 <a href="#">4</a>
				</li>
				<li>
					 <a href="#">5</a>
				</li>
				<li>
					 <a href="#">Next</a>
				</li>
			</ul>
		    </form>
		</div>
	</div>
	<jsp:include page= "bottom.jsp" flush ="true"/>
</body>
</html>
