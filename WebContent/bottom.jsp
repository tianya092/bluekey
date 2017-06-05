<%@ page language="java" import="BlueKey.connDb,java.util.*" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%  
	String servletPath=request.getServletPath();
%>
<style type="text/css">
	div.footer-container{
	text-align:center
		margin:0 auto;
		text-align:center; 
		
	}
	 div.footer-container ul, div.footer-container ul li{
		height:30px;
		list-style-type:none;
		text-align:center;
	}
	 div.footer-container ul li{
		width:150px;
		float:left;
	}
	 div.footer-container ul{
		width:1000px;
		float:left;
	}
	 div.footer-container img{
		width:100px;
		height:50px;
	}
	
</style>
<div  class="container" >
	<div  class="footer-container" >
		<hr>
		<nav role="navigation" aria-label="Footer Links" class="footer__nav" data-feature="footer.linklist" data-i18n="[aria-label]awf.page.footer.links">
			<ul class="">
				<li class="">
					<a  href="http://w3.ibm.com/w3/info_terms_of_use.html" target="_blank">Terms of use</a>
				</li>
				<li>
					<a  href="http://w3.ibm.com/ibm/documents/corpdocweb.nsf/ContentDocsByTitle/Business+Conduct+Guidelines" target="_blank">Business conduct guidelines</a>
				</li>
				<li class="">
					<a  href="http://w3.ibm.com/feedback/" target="_blank">Feedback</a>
				</li>
				<li class="">
					<a  href="https://w3-connections.ibm.com/wikis/home?lang=zh-cn#!/wiki/Wf49a0f070e65_41de_bb0a_ff81f7eb3319/page/yourIBM%20Accessibility%20Features" target="_blank">yourIBM Accessibility</a>
				</li>
				<li class="">
					<a  href="https://w3-connections.ibm.com/communities/service/html/communitystart?communityUuid=6dd64b47-6463-4cf4-8f10-c18d63bf00b3&amp;lang=zh-cn" target="_blank">yourIBM Community</a>
				</li>
			</ul>
			 <img src="css/img/IBMlogo.png">
		</nav>
	</div>
</div>