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
		
		/* if(activedStatus.equals("1")){
			response.sendRedirect("result.jsp?user_id="+user_id);  
		} */
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
<script src="js/jquery.cxselect.js"></script>

<script src="js/bootstrap.min.js"></script>
<script src="//rawgithub.com/indrimuska/jquery-editable-select/master/dist/jquery-editable-select.min.js"></script>
<link href="//rawgithub.com/indrimuska/jquery-editable-select/master/dist/jquery-editable-select.min.css" rel="stylesheet">
<script>
(function() {
	function sdf(){
		alert("dsfads");
	}
  var urlChina = 'js/cityData.min.json';
  var urlGlobal = 'js/globalData.min.json';
  var dataCustom = [
    {'v': '1', 'n': 'PP', 's': [
      {'v': '1', 'n': 'Platform GCM', 's': [
        {'v': '3', 'n': '第三级 >', 's': [
          {'v': '4', 'n': '第四级 >', 's': [
            {'v': '5', 'n': '第五级 >', 's': [
              {'v': '6', 'n': '第六级 >'}
            ]}
          ]}
        ]}
      ]},
	  {'v': '2', 'n': 'ECAT GCM', 's': [
        {'v': '3', 'n': '第1级 >', 's': [
          {'v': '4', 'n': '第2级 >', 's': [
            {'v': '5', 'n': '第2级 >', 's': [
              {'v': '6', 'n': '第3级 >'}
            ]}
          ]}
        ]}
      ]},
      {'v': '3', 'n': 'OPERATION', 's': [
          {'v': '3', 'n': '第1级 >', 's': [
            {'v': '4', 'n': '第2级 >', 's': [
              {'v': '5', 'n': '第2级 >', 's': [
                {'v': '6', 'n': '第3级 >'}
              ]}
            ]}
          ]}
       ]}
	  
    ]},
    {'v': 'test number', 'n': '测试数字', 's': [
      {'v': 'text', 'n': '文本类型', 's': [
        {'v': '4', 'n': '4'},
        {'v': '5', 'n': '5'},
        {'v': '6', 'n': '6'},
        {'v': '7', 'n': '7'},
        {'v': '8', 'n': '8'},
        {'v': '9', 'n': '9'},
        {'v': '10', 'n': '10'}
      ]},
      {'v': 'number', 'n': '数值类型', 's': [
        {'v': 11, 'n': 11},
        {'v': 12, 'n': 12},
        {'v': 13, 'n': 13},
        {'v': 14, 'n': 14},
        {'v': 15, 'n': 15},
        {'v': 16, 'n': 16},
        {'v': 17, 'n': 17}
      ]}
    ]},
    {'v': 'test boolean','n': '测试 Boolean 类型', 's': [
      {'v': true ,'n': true},
      {'v': false ,'n': false}
    ]},
    {v: 'test quotes', n: '测试属性不加引号', s: [
      {v: 'quotes', n: '引号'}
    ]},
    {v: 'test other', n: '测试奇怪的值', s: [
      {v: '[]', n: '数组（空）'},
      {v: [1,2,3], n: '数组（数值）'},
      {v: ['a','b','c'], n: '数组（文字）'},
      {v: new Date(), n: '日期'},
      {v: new RegExp('\\d+'), n: '正则对象'},
      {v: /\d+/, n: '正则直接量'},
      {v: {}, n: '对象'},
      {v: document.getElementById('custom_data'), n: 'DOM'},
      {v: null, n: 'Null'},
      {n: '未设置 value'}
    ]},
    {'v': '' , 'n': '无子级'}
  ];

  $('#custom_data').cxSelect({
    selects: ['function', 'team', 'job_role', 'commodity'],
    required: true,
    jsonValue: 'v',
    url: dataCustom
  });
})();
</script>
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
<p onclick="sdf()">sdfsdafsdf</p>
	<fieldset id="custom_data">
	    <legend>自定义选项</legend>
	    <p>function<select class="function"></select></p>
	    <p>team<select class="team"></select></p>
	    <p>job_role<select class="job_role"></select></p>
	    <p>commodity<select class="commodity"></select></p>
	  </fieldset>
	<div id="bg">
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
			
			<div class="ui grid" id="select_role">
				 
			 	<form class="form-horizontal" role="form" name="form" active = "dosubmit.jsp" onsubmit="return check_submit()">
			 
				    <div class="form-group">
					    <label for="functionid"  class="col-sm-3 control-label">Function</label>
					    <div class="col-sm-8">
						    <select class="form-control" name="function" "> 
						    </select>
					    </div>
				    </div>
				
					<div class="form-group">
					    <label for="teamid"  class="col-sm-3 control-label">Team</label>
					    <div class="col-sm-8">
						    <select class="form-control" name="team" ">  
						    </select>
					    </div>
				    </div>
				
				    <div class="form-group">
				       <label for="commodity"  class="col-sm-3 control-label">Job Role</label>
					    <div class="col-sm-8">
					    <select class="form-control" name="job_role">
					    </select>
					    </div>
				    </div>
				    <div class="form-group">
					    <label for="commodity"  class="col-sm-3 control-label">Commodity</label>
					    <div class="col-sm-8">
						    <select class="form-control" name="commodity"></select>
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

</script>
</body>
</html>
