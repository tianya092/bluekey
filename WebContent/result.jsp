<%@ page language="java" import="com.bluekey.connDb,java.util.*" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%  
	String role_id = request.getParameter("role_id");
	String	email =	(String)session.getAttribute("email");
	/* int role_id ;
	if(role_id_str.equals("")||role_id_str==null){
		out.println("<javascript> alter(\"function is empyt\")</javascript>");
		response.sendRedirect("error.jsp");
	}else{
		role_id =Integer.parseInt(role_id_str);
	} */
	Map<String,String> general_access= null;
	Map<String,String> function_access= null;
	Map<String,String> other_access= null;
	
	/* if(session.getAttribute("email")==null){
		response.sendRedirect("login.jsp");
	}else{
		String user_id = request.getParameter("user_id");
		String	email =	(String)session.getAttribute("email");
		boolean right = connDb.checkUserRight(email, user_id); //check use-id is right or not
		if(right==false){
			out.println("<javascript> alter(\"please login yourself ID!\")</javascript>");
			response.sendRedirect("error.jsp");
		}else{
			ArrayList<Map<String,String>> list = connDb.result(user_id); //get access list 
			general_access= list.get(0);
			function_access= list.get(1);
			other_access= list.get(2);
		}
	} */
	if(role_id==null||role_id.equals("")){
		
	}else{
		
	}
	ArrayList<Map<String,String>> list = connDb.result(role_id); //get access list 
	general_access= list.get(0);
	function_access= list.get(1);
	other_access= list.get(2);

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
	<div class="container">
	   <div class="jumbotron">
	        <!-- <h1>Blue key</h1> -->
	        <img src="css/img/logo1.png">
	    </div>
	    <div class="row">
	            <div class="col-xs-12 col-sm-12">
	               <ol class="breadcrumb">
	                    <li><a href="input.jsp">Home</a></li>
	                    <li class="active"><a href="#">Access</a></li>
	                 
	                </ol>
	            </div>
	        </div>
	    <div class="row">
	        <div class="col-xs-3" id="myScrollspy">
	            <ul class="nav nav-tabs nav-stacked" id="myNav">
	                <li class="active"><a href="#section-1">General Access</a></li>
	                <li><a href="#section-2">Functional Access</a></li>
	                <li><a href="#section-3">Others</a></li>
	            </ul>
	        </div>
	        <div class="col-xs-9">
	            <h2 id="section-1">General Access</h2>
	             <ul >
		             <%
		             	if(general_access!=null){
			             	for(String key :general_access.keySet()){
			             		out.println("<li><a href=\"detail.jsp?access_id="+key+"\">"+general_access.get(key)+"</a></li>");
			             	}	
		             	}
		             %>
	            </ul>
	            <hr>
	            <h2 id="section-2">Functional Access</h2>
	            <ul >
		            <%
		            	if(function_access!=null){
		            		for(String key :function_access.keySet()){
			             		out.println("<li><a href=\"detail.jsp?access_id="+key+"\">"+function_access.get(key)+"</a></li>");
			             	}	
		            	}
		             %>
	            </ul>
	            <hr>
	            <h2 id="section-3">Others</h2>
				<ul >
					 <%
					 	if(function_access!=null){
					 		for(String key :other_access.keySet()){
						   		out.println("<li><a href=\"detail.jsp?access_id="+key+"\">"+other_access.get(key)+"</a></li>");
						   	}
					 	}
					   		
					 %>
				</ul>
	        </div>
	    </div>
	    <jsp:include page= "bottom.jsp" flush ="true"/>
	</div>
	
</body>
</html>
