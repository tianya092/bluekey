<%@ page language="java"
	import="com.bluekey.connDb,com.bluekey.User,java.util.*"
	contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
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
<div id="header">
	<nav class="navbar navbar-inverse navbar-fixed-top" role="navigation"
		style="background-color: #5c7ebd; font-size: 14px;">
		<div class="container">
			<div class="navbar-header" style="margin: 5px;">
				<a href="query.jsp?user_id=<%=user_id %>">
						<img src="img/logo2.png" height="50" width="180">
				</a>
			</div>

			<div id="navbar" class="navbar-collapse collapse" style=" margin-top: 5px;">
				<ul class="nav navbar-nav">
					<li>
						<a href="query.jsp?user_id=<%=user_id %>">
							<span class="glyphicon glyphicon-home" aria-hidden="true"></span> Home
						</a>
					</li>
					<li
						<% 
		        		if(servletPath.indexOf("contact")!=-1){
		        			out.println("class=\"active\"");
		        		} 
		        	%>>
						<a href="#"> <span class="glyphicon glyphicon-info-sign"
							aria-hidden="true"></span>About
					</a>
					</li>

					<li><a href="feedback.jsp"> <span class="fa fa-envelope-o"
							aria-hidden="true"></span> Feedback
					</a></li>
					<%
						if(user.getFunction()>0){
				%>
					<li class="dropdown"><a href="#" class="dropdown-toggle"
						data-toggle="dropdown"> Setting <b class="caret"></b>
					</a>
						<ul class="dropdown-menu">
							<%
							if(user.getFunction()==1000){
						%>
							<li><a href="userList.jsp">authority manage</a></li>

							<%} %>
							<%
							if(user.getFunction()>0){
						%>
							<li><a href="roleList.jsp">role manage</a></li>
							<%} %>
							<%
							if(user.getFunction()==1000){
						%>
							<li><a href="accessList.jsp">access manage</a></li>
							<%} %>
						</ul></li>
					<%} %>
					
				</ul>

				<div>
					<ul class="nav navbar-nav navbar-right">
						<%
						    if(session.getAttribute("email")==null){
					     %>
						<li><a href="login.jsp"><span
								class="glyphicon glyphicon-log-in"></span> sign in</a></li>
						<%}else{ %>
						<li class="dropdown"><a href="#" class="dropdown-toggle"
							data-toggle="dropdown"> <span
								class="glyphicon glyphicon-user""></span>&nbsp;&nbsp; <%=email%>&nbsp;&nbsp;&nbsp;
								<b class="caret"></b>
						</a>
							<ul class="dropdown-menu">
								<li><a href="history.jsp">apply history </a></li>
								<li class="divider"></li>
								<li><a href="logout.jsp">sign up</a></li>
							</ul></li>
						<%}%>
					</ul>
					<ul>
					<form class="navbar-form navbar-right" role="search"
						action="search.jsp" method="post">
						<div class="form-group">
							<input type="text" name="search" class="form-control"
								placeholder="Search" style="height: 34px" value="<%=search %>">
							<span class="">
								<button type="submit" class="btn btn-default"
									style="height: 34px;background: #647db6; border: 0;">
									<img src="img/u11.png" style="height: 20px; width: 20px;margin-bottom: 16px;">
								</button>
							</span>
						</div>
					</form>
					</ul>
				</div>
			</div>
	</nav>
</div>
