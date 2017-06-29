<%@ page language="java" import="BlueKey.connDb,java.util.*,java.io.*" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%  
	String email = (String)session.getAttribute("email");
	/* String page = request.getParameter("page"); */
	Map<String,String> detail = null; 
	
	ArrayList<String[]>  userList = connDb.getUserList(); //get access list
	
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
		<legend>User List</legend>
		<div class="page-header">
			<a href="editAccess.jsp" class="btn btn-info btn" >
          		<span class="glyphicon glyphicon-plus" ></span> add an access
        	</a>
		</div> 
		<div class="table-responsive">
				<table class="table table-condensed table-hover">
					<thead>
						<tr class="active">
		        			<th>No</th> 
		        			<th>email name</th>
		        			<th>create time</th>
		        			<th>operate</th>
		        		</tr>
					</thead>
		        	<tbody>
			        	<%
			        		for(String[] user : userList){
			        			out.print("<tr><td>"+user[0]+"</td><td>"+user[1]+"</td><td>"+user[2]+"</td><td><a href=\"editAccess.jsp?access_id="+user[0]+"\"><span class=\"glyphicon glyphicon-pencil\"></span></a>&nbsp;&nbsp;&nbsp;&nbsp <a href=\"deleteAccess.jsp?access_id="+user[0]+"\"><span class=\"glyphicon glyphicon-trash\"></span></a></td></tr>");
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
		</div>
	</div>
	<jsp:include page= "bottom.jsp" flush ="true"/>
</body>
</html>
