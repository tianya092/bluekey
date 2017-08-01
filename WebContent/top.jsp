<%@ page language="java" import="com.bluekey.connDb,com.bluekey.User,java.util.*" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%  
	String search=""; 
	if(request.getParameter("search")!=null&&!request.getParameter("search").equals("")){
		search = request.getParameter("search");
	}
	
	String servletPath=request.getServletPath();
	String	email =	(String)session.getAttribute("email");
	User user = connDb.getUser(email);
	int  user_id = user.getUserId();
	
%>
<!--  navbar-fixed-top -->
<div id="header">
<nav class="navbar navbar-inverse" role="navigation"
	style="background-color: #5c7ebd; font-size: 14px;">
	<div class="container">
		<div class="navbar-header">
			<button type="button" class="navbar-toggle collapsed"
				data-toggle="collapse" data-target="#navbar" aria-expanded="false"
				aria-controls="navbar">
				<span class="sr-only">Toggle navigation</span> <span
					class="icon-bar"></span> <span class="icon-bar"></span> <span
					class="icon-bar"></span>
			</button>
			<!--   <a class="navbar-brand" href="#"><img src="img/logo.png" height=30 width=41></a> -->
		</div>
		<div id="navbar" class="navbar-collapse collapse">
			<ul class="nav navbar-nav">
				<li >
					<a href="query.jsp?user_id=<%=user_id %>">
						<span class="glyphicon glyphicon-home" aria-hidden="true"></span> Home
					</a>
				</li>
				<li <% 
		        		if(servletPath.indexOf("contact")!=-1){
		        			out.println("class=\"active\"");
		        		} 
		        	%>
	        	>
					<a href="#">
						<span class="glyphicon glyphicon-info-sign" aria-hidden="true"></span>About
					</a>
				</li>

				<li>
					<a href="#">
						<span class="fa fa-envelope-o" aria-hidden="true"></span> Contact
					</a>
				</li>
		        <li class="dropdown">
					<a href="#" class="dropdown-toggle" data-toggle="dropdown">
						Setting
						<b class="caret"></b>
					</a>
					<ul class="dropdown-menu">
					<%if("brucel@cn.ibm.com".equals(email)) {%>
						<li><a href="userList.jsp">User Manage</a></li>
						<li><a href="roleList.jsp">Role Manage</a></li>
					<%} %>
						<li><a href="accessList.jsp">Access Manage</a></li>
					</ul>
				</li>
				
			</ul>
			<div>
				 
				<ul class="nav navbar-nav navbar-right">
					
					
						<%
						    if(session.getAttribute("email")==null){
					     %>
					     	<li><a href ="login.jsp" style="color:#D8D8D8">sign in</a></li>
				     	<%}else{ %>
					     	<li style="color:white"><b><%=email%></b>&nbsp;&nbsp;&nbsp;
					     		<span class="glyphicon glyphicon-user" style="margin-top: 18px;"></span>
							</li>
							<li>
								<a href ="logout.jsp" >
								  Log out
								</a>
							</li>
						<%}%>
				</ul>

				<form class="navbar-form navbar-right" role="search" action="search.jsp" method="post">
					<div class="form-group">
						<input type="text" name="search" class="form-control" placeholder="Search" style="height: 34px" value="<%=search %>">
						 	<span class="">
						 		<button type="submit" class="btn btn-default"  style="height: 34px">
						 			<img src="img/u11.png" style="height: 20px; width: 20px;margin-bottom:10px;">
						 		</button>
					 		</span>
					</div>
				</form>
			</div>
		</div>
</nav>
</div>
