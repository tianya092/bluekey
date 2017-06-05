<%@ page language="java" import="BlueKey.connDb,java.util.*" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%  

	String email = (String)session.getAttribute("email");
	String  activedStatus =null;
	String  user_id =null;
	if(session.getAttribute("email")==null){
		response.sendRedirect("login.jsp");
	}else{
		Map<String,String> user = connDb.checkUserActived(email);
		activedStatus = user.get("actived");
		user_id = user.get("user_id");
		
		if(activedStatus.equals("1")){
			response.sendRedirect("result.jsp?user_id="+user_id);  
		}
    }
%> 
<!DOCTYPE html>
<html>
<head>
<meta charset="utf-8">
<title>blue key</title>
<link rel="stylesheet" href="css/style.css">
<link href="css/bootstrap.css" rel="stylesheet" type="text/css">
<script src="js/jquery-3.1.0.min.js"></script>

<script src="js/bootstrap.min.js"></script>
<script src="//rawgithub.com/indrimuska/jquery-editable-select/master/dist/jquery-editable-select.min.js"></script>
<link href="//rawgithub.com/indrimuska/jquery-editable-select/master/dist/jquery-editable-select.min.css" rel="stylesheet">

<style type="text/css">
/*  #bg{
    z-index: -999;
  }*/
  #bg{
    background: url("css/img/bg_blue.png");
    background-repeat: no-repeat;
    background-size: cover;
    width: 100%;
    height: 100%;
    position: absolute;
   
   opacity: .9;
/*    -webkit-filter: blur(10px);
    filter: blur(10px);*/

  }

  #container{
    position: absolute;
    top: 50%;
    left: 50%;
    margin-top: -220px;
    margin-left: -290px;
    width: 580px;
    height: 440px;

  }

  #container_test{
    position: absolute;
    top: 50%;
    left: 50%;
    margin-top: -220px;
    margin-left: -290px;
    width: 580px;
    height: 440px;
    background-color: #f5f7fa;
    opacity: .5;
  	/* -webkit-filter: blur(5px);
    filter: blur(5px);*/
   /*  border:2px solid white ;*/
	border-radius:25px;
    z-index: -99;
  }


  #logo{
    height: 120px;
    width: 100%;
   /* margin-bottom: 5px;*/

  }
  #logo_cont{
    vertical-align: middle; 
    text-align: center; 
/*    font-size: 24pt;*/

  }
  #img{
    vertical-align: middle; 
    height: 90px;
  }
  body {
  font-family: 'Open Sans', Helvetica, Arial, sans-serif;
  font-size: 20px;
 /* background: #ededed;*/
}

</style>
</head>
<body style=" padding-top: 0px;">
	<div id="bg">
		<div id="container_test">
		</div>
		<div id="container">
		    <div class="nav">
		  		<div class="ui grid">
					<div id="logo">
					     <div id="logo_cont">
					       <img src="css/img/logo2.png" id="img"/>
					      <!--  <br/>Search -->
					    </div>
					</div> 
					<!--  <a href="/posts" class="text-center"><h1>Blue Key</h1></a>
			      	<p  class="text-center">Management</p> -->
		  		</div>
			</div>
			<div class="ui grid">
			 	<form class="form-horizontal" role="form" name="form" active = "dosubmit.jsp" onsubmit="return check_submit()">
			 
				   	<!--  <div class="form-group">
				    <label for="cnid"  class="col-sm-4 control-label">CN number</label>
				    <div class="col-sm-7">
				    <input type="text"></div>
				    </div> -->
				  
				    <div class="form-group">
					    <label for="functionid"  class="col-sm-3 control-label">Function</label>
					    <div class="col-sm-8">
						    <select class="form-control" name="functionid" onChange="getCommodity()">    
						      <OPTION VALUE="0">select your function </OPTION>
						      <option>PP</option>
						      <option>PI</option>
						      <option>ENG</option>
						      <option>BTIT</option>
						      <option>DSA</option>
						    </select>
					    </div>
				    </div>
				
					<div class="form-group">
					    <label for="teamid"  class="col-sm-3 control-label">Team</label>
					    <div class="col-sm-8">
						    <select class="form-control" name="functionid" onChange="getCommodity()">    
						      <OPTION VALUE="0">select your team </OPTION>
						      <option>Platform GCM</option>
						      <option>ECAT GCM</option>
						      <option>OPERATION</option>
						      <option>SERVICE</option>
						      <option>PCE</option>
						    </select>
					    </div>
				    </div>
				
				    <div class="form-group">
				       <label for="commodity"  class="col-sm-3 control-label">Job Role</label>
					    <div class="col-sm-8">
					    <select class="form-control" name="commodity">
					    	 <OPTION VALUE="0">select your Job Role</OPTION>
					    </select>
					    </div>
				    </div>
				    <div class="form-group">
					    <label for="commodity"  class="col-sm-3 control-label">Commodity</label>
					    <div class="col-sm-8">
						    <select class="form-control" name="commodity">
						     	<OPTION VALUE="0">select your commodity </OPTION>
						    </select>
					    </div>
				    </div>
				
				    <div class="form-group">
					    <div class="col-sm-offset-4 col-sm-6">
					      <div class="checkbox">
					        <label>
					          <input type="checkbox"> please remember me
					        </label>
					      </div>
					    </div>
				 	</div>
				
				  	<div class="form-group">
					    <div class="col-sm-offset-4 col-sm-4">
					    <input type="hidden" name="user_id" value = "<%=user_id %>>">
					      <button type="submit" class="btn btn-default">submit</button>
					    </div>
				  	</div>
				</form>
			</div>
		</div>
	</div>

<script language="JavaScript" type="text/javascript">

     var commodity=[["MECHANICAL","THERMAL","PCB"],[],["INTERCONNECT","PSU","PCB"],[],[]];

     function getCommodity(){
          var slt_functionid = document.form.functionid;
          var slt_commodity = document.form.commodity;
          var function_commodity = commodity[slt_functionid.selectedIndex -1];
          slt_commodity.length = 1;
          for(var j = 0; j<function_commodity.length;j++){
            slt_commodity[j+1]=new Option(function_commodity[j],function_commodity[j]);
          }
          this.parentNode.nextSibling.value=this.options[this.selectedIndex].text;
     
     }
     //å¯ä»¥éè¿è¾å¥æ¥å¿«ééæ©

	$('#functionid').editableSelect({ effects: 'default' });
	<script type="text/javascript">
	function on_submit(){  
	    if(loginform.email.value=="")  
	        {  
	            alert("Email is empty, please fill!");  
	            loginform.email.focus();  
	            return false;  
	              
	        }  
	    if(loginform.password.value=="")  
	        {  
	            alert("Password is empty, please fiil!");  
	            loginform.password.focus();  
	            return false  
	        }  
	}  

</script>
</body>
</html>
