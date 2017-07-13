<%@ page language="java" import="com.bluekey.connDb,com.bluekey.User,java.util.*" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%  

	String email = (String)session.getAttribute("email");
	String  activedStatus =null;
	int  user_id =0;
	String[] remember_arr = null;
	
	if(session.getAttribute("email")==null){
		response.sendRedirect("login.jsp");
	}else{
		User user = connDb.getUser(email);
		String remember= user.getRemember();
		
		if(remember!=null&&!remember.equals("")){ 
			remember_arr = remember.split(",");
		}else{
			remember_arr =new String[] {"0","0","0","0"}; 
		}
		
		user_id = user.getUserId();
		
    }
%> 
<!DOCTYPE html>
<html>
<head>
<meta charset="utf-8">
<title>blue key</title>
<link rel="stylesheet" href="css/style.css">
<link href="css/bootstrap.css" rel="stylesheet" type="text/css">
<script src="js/jquery-3.1.0.js"></script>
<script src="js/jquery.cxselect.js"></script>
<script src="js/bootstrap.min.js"></script>

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
		  		</div>
			</div>
			
			<div class="ui grid" >
			 	<form class="form-horizontal" role="form" name="form" action = "doSubmit1.jsp"  method="post" >
			 		<div id="select_role">
					    <div class="form-group">
					    	<label for="functionid"  class="col-sm-3 control-label"><span style="color:red">*</span>Function</label>
					    	 <div class="col-sm-8">
						    	<select class="function form-control" data-value="<%=remember_arr[0] %>" data-required="true" name="function" ></select>
					    	</div>
				    	</div>
				    	<div class="form-group">
					    	<label for="functionid"  class="col-sm-3 control-label"><span style="color:red">*</span>team</label>
					    	 <div class="col-sm-8">
						    	<select class="team form-control" data-value="<%=remember_arr[1] %>"  data-required="true" name="team" ></select>
					    	</div>
				    	</div>
				    	
				    	<div class="form-group">
					    	<label for="functionid"  class="col-sm-3 control-label"><span style="color:red">*</span>job_role</label>
					    	 <div class="col-sm-8">
						    	<select class="job_role form-control" data-value="<%=remember_arr[2] %>" data-required="true" name="job_role" ></select>
					    	</div>
				    	</div>
				    	<div class="form-group">
					    	<label for="functionid"  class="col-sm-3 control-label">commodity</label>
					    	 <div class="col-sm-8">
						    	<select class="commodity form-control" data-value="<%=remember_arr[3] %>"  name="commodity" ></select>
					    	</div>
				    	</div>
					</div>
				    <div class="form-group">
					    <div class="col-sm-offset-4 col-sm-6">
					      <div class="checkbox">
					        <label>
					          <input type="checkbox" name="remember_type">remember me
					        </label>
					      </div>
					    </div>
				 	</div>
				
				  	<div class="form-group">
					    <div class="col-sm-offset-4 col-sm-4">
					    <input type="hidden" name="user_id" value = "<%=user_id %>">
					      <button type="submit" class="btn btn-default">submit</button>
					    </div>
				  	</div>
				</form>
			</div>
		</div>
	</div>


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
