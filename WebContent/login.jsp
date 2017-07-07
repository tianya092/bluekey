<%@ page language="java" import="com.bluekey.connDb,java.util.*" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%  
    String email=request.getParameter("email");  
    String password=request.getParameter("password");  
    //if(email!=null &password!=null)  
    {  
        //如果用户名和密码都合法,则记下用户名,一般把用户和密码存在数据库中  
        //用数据库中的信息与提交的用户名和密码比较以进行用户合法性检查  
        //session.setAttribute("email", email);  
        //response.sendRedirect("sessionUserLogin1.jsp");  
    }  
%> 
<!DOCTYPE html>
<html>
<head>
<title>Blue Key</title>
<link rel="stylesheet" href="./css/login.css">

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
            alert("Password is empty, please fill!");  
            loginform.password.focus();  
            return false  
        }  
	}  
</script>

<style type="text/css">
  /*  #bg{
    background: url("css/img/bg_blue.png");
    background-repeat: no-repeat;
    background-size: cover;
    width: 100%;
    height: 100%;
    position: absolute;
   opacity: .9;

  }
   #tip{
    color: white;
    margin-bottom: 0px;
    margin-top:10px;
   }

   #cont{
     opacity: .9;

   }*/

 .img:before {
  
  background: url("css/img/bg_blue.png");
 
 }

 #logo{
    height: 120px;
    width: 100%;
    m
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

  a{ text-decoration:none}
  
  #tip{
    color: white;
    margin-bottom: 20px;
    margin-top:30px;
  } 
  #cont{
    margin-bottom:20px;

  }
  #form{
  	padding: 70px;
  }
  
</style>

</head>
<body>
<div id="bg">
<div class="tip" id="tip">
<div id="logo">
       <div id="logo_cont">
         <img src="css/img/logo1.png" id="img"/>
        <!--  <br/>Search -->
       </div>
     </div> 

</div>
<div class="cont" id="cont">
  <div class="form sign-in" style="padding-top: 110px;">
    <form class="loginform" name="loginform"  action="dologin.jsp" method="post"  onsubmit="return on_submit()">
	    <h2>Welcome IBMer</h2>
	    <label>
	      <span>email</span>
	      <input type="email" id="email" name="email"/>
	    </label>
	    <label>
	      <span>Password</span>
	      <input type="password" id="password" name="password" />
	    </label>
	    <p class="forgot-pass"><a href="#">Forgot password?</a></p>
	    <button type="submit" class="submit" id="login_submit">Sign In</a></button>
<!-- 	    <button type="submit" class="fb-btn">Log in with <span>w3id</span></button> -->
    </form>
  </div>
  
  <div class="sub-cont">
    <div class="img">
      <div class="img__text m--up">
        <h2>New here?</h2>
        <p>Sign up and discover great amount of new opportunities!</p>
      </div>
      <div class="img__text m--in">
        <h2>One of us?</h2>
        <p>If you already has an account, just sign in. We've missed you!</p>
      </div>
      <div class="img__btn">
        <span class="m--up">Sign Up</span>
        <span class="m--in">Sign In</span>
      </div>
    </div>
    <div class="form sign-up">
      <h2>Time to feel like home,</h2>
      <label>
        <span>Name</span>
        <input type="text" />
      </label>
      <label>
        <span>Email</span>
        <input type="email" />
      </label>
      <label>
        <span>Password</span>
        <input type="password" />
      </label>
      <button type="button" class="submit">Sign Up</button>
      <button type="button" class="fb-btn">Join with <span>w3id</span></button>
    </div>
  </div>
</div>
</div>

<script src="https://ajax.googleapis.com/ajax/libs/jquery/1.11.3/jquery.min.js"></script>
    <!-- Include all compiled plugins (below), or include individual files as needed -->
<script src="js/bootstrap.min.js"></script>

<script type="text/javascript">
	document.querySelector('.img__btn').addEventListener('click', function() {
  	document.querySelector('.cont').classList.toggle('signup');
  
});

  $("#button").click(function(){window.location.href="input.html"});


</script>
</body>
</html>