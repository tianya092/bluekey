<%@ page language="java" import="BlueKey.connDb,java.util.*" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%  
	String servletPath=request.getServletPath();
	String	email =	(String)session.getAttribute("email");
	String	user_id =	(String)session.getAttribute("user_id");
	
%>
<nav class="navbar navbar-inverse navbar-fixed-top" role="navigation">
	<div class="container">
		<div class="navbar-header">
		    <button type="button" class="navbar-toggle collapsed" data-toggle="collapse" data-target="#navbar" aria-expanded="false" aria-controls="navbar">
		        <span class="sr-only">Toggle navigation</span>
		         <span class="icon-bar"></span>
		         <span class="icon-bar"></span>
		         <span class="icon-bar"></span> 
		     </button>
		     <a class="navbar-brand" href="login.jsp">Blue key</a>
		 </div>
		 <div id="navbar" class="navbar-collapse collapse">
		     <ul class="nav navbar-nav">
		         <li ><a href="input.jsp?user_id=<%=user_id %>"><span class="glyphicon glyphicon-home" aria-hidden="true" ></span> Home</a></li>
		         
		        <li
		        	<% 
		        		if(servletPath.indexOf("contact")!=-1){
		        			out.println("class=\"active\"");
		        		} 
		        	%>
		         ><a href="contact.jsp?user_id=<%=user_id %>">Contact</a></li>
		        <%if("brucel@cn.ibm.com".equals(email)) {%>
		        <li class="dropdown">
					<a href="#" class="dropdown-toggle" data-toggle="dropdown">
						Setting
						<b class="caret"></b>
					</a>
					<ul class="dropdown-menu">
						<li><a href="userList.jsp">User Manage</a></li>
						<li><a href="roleList.jsp">Role Manage</a></li>
						<li><a href="accessList.jsp">Access Manage</a></li>
					</ul>
				</li>
				<%} %>
		     </ul>
		     <span class="login" style="float:right;color:white;padding:15px"> 
		     <%
			    if(session.getAttribute("email")==null){
		     %>
		     	<a href ="login.jsp" style="color:#D8D8D8">sign in</a>
	     	<%}else{ %>
		     	welcome, <b><%=email %></b> &nbsp;&nbsp;
				<a href ="logout.jsp" style="color:#D8D8D8">sign out</a>
			<%
	     		}
			%>
			 </span>
		     
		</div>
	</div>
</nav> 