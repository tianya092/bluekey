<%@ page language="java" import="BlueKey.connDb,java.util.*,java.io.*" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%  
	String email = (String)session.getAttribute("email");
	Map<String,String> detail = null; 
	if(email==null){
		//request.getRequestDispatcher("login.jsp").forward(request,response);
		response.sendRedirect("login.jsp");
	}else{
		String access_id = request.getParameter("access_id");
		String	user_id = (String)session.getAttribute("user_id");
		boolean right = connDb.checkUserAccess(user_id, access_id); //check access_id is in user'access or not
		if(right==false){
			out.println("<script>alert(\"You have't access to visit the page! Please contact Administrator\");window.location.href=\"result.jsp?user_id="+user_id+"\";</script>");
		}else{
			detail = connDb.detail(access_id); //get access detail
		}
	}
		
	
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
	            <h2 id="section-1"><%=detail.get("title") %></h2>   
				<hr>
	            <p>
					<%=detail.get("function") %>
				</p>
	            <hr>
	            <p>
	            	<%=detail.get("apply_step") %>
	            </p>
	            <hr>
	            <p>
	            	<a href=<%=detail.get("url") %>><%=detail.get("url") %></a>
	            </p>
	          
	        </div>
	    </div>
	</div>
	 <jsp:include page= "bottom.jsp" flush ="true"/>
</body>
</html>
