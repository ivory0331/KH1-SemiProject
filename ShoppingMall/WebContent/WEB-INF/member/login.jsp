<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<% String ctxPath = request.getContextPath(); %>
<!DOCTYPE html>
<html> 

<head>
<meta charset="UTF-8">
<link rel="stylesheet" href="<%= ctxPath %>/css/style.css" />
<title>market kurly login page</title>
<style type="text/css">
.contents{
	font-family: noto sans, sans-serif, malgun gothic;
	width: 100%;
	height: 612px;
	background-color: #fafafa;
	padding: 0;
	margin: 0 auto;
	text-align: center;
	border : solid 1px #fafafa;
}


.section_login{
	width: 340px;
	margin: 0 auto;
	padding-top: 90px;
	letter-spacint: 6px;
	diplay: block;
	color: #4c4c4c;
	font-size: 12px;
	max-width: 100%;
	line-height: 35px;
}


.tit_login {
    font-weight: 800;
    font-size: 16pt;
    line-height: 20px;
    text-align: center;
    padding: 30px 0;
}

.section_login * {
    color: #333;
}

.contents h3 {
    display: block;
    font-weight: bold;
    padding-top : 50px;
}

.section_login .write_form {
    padding-top: 36px;
}


.contents input {
    display: inline-block;
    width: 320px;
    height: 54px;
    padding: 0 0 0 20px;
    border: 1px solid #ccc;
    border-radius: 3px;
    background-color: #fff;
    font-size: 14px;
    margin: 5px;
}

.login_search {
    line-height: 40px;
    text-align: right;
}

.contents input::placeholder {
  color: #ccc;
}


.contents a:hover{
    color: #5f0080;
    cursor: pointer;
    text-decoration: none;
}

.contents a{
    color: #5f0080;
    cursor: pointer;
    text-decoration: none;
    padding: 6px 0;
    display: inline-block;
}

.login_search .bar {
    float: right;
    width: 1px;
    height: 10px;
    margin: 3px 6px 0;
    background-color: #333;
}

.btn_member{
	display: inline-block;
    width: 320px;
    height: 54px;
    border: 1px solid #ccc;
    border-radius: 3px;
    background-color: #fff;
    font-size: 14px;
    margin: 5px;
    cursor:pointer;
}
.btn_type1{
	margin-top: 20px;
	padding: 0 40px;
	border : solid 1px #5f0080;
	background-color: #5f0080;
	font-style: normal;
}	

.btn_type2{
	border : solid 1px #5f0080;
	
}
.txt_type{
	font-weight: 500;
	font-size: 16px;
	color: #fff;
}
.text_type_btn{
	color: #5f0080;
	vertical-align: middle;
	display: inline-block;
 	
}

</style>
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.1/css/bootstrap.min.css">
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
<script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.1/js/bootstrap.min.js"></script>
<script type="text/javascript" src="/ShoppingMall/js/jquery-3.3.1.min.js"></script>
<script type="text/javascript" src="/ShoppingMall/util/myutil.js"></script>
<script type="text/javascript">
   $(document).ready(function(){
      
      $("#btnSubmit").click(function(){
         goLogin(); // 로그인 시도한다.
      });
      
      
      $("#loginPwd").keydown(function(event){
         if(event.keyCode == 13) { // 암호입력란에 엔터를 했을 경우 
            goLogin(); // 로그인 시도한다.
         } 
      });
      
      
   });// end of $(document).ready()----------------------------
   
   
   /* === 로그인 처리 함수 === */
   function goLogin() {
   
      var loginUserid = $("#loginUserid").val().trim();
      var loginPwd = $("#loginPwd").val().trim();
      
      if(loginUserid == "") {
         alert("아이디를 입력하세요!!");
         $("#loginUserid").val("");
         $("#loginUserid").focus();
         return; 
      }
      
      if(loginPwd == "") {
         alert("암호를 입력하세요!!");
         $("#loginPwd").val("");
         $("#loginPwd").focus();
         return;  
      }
      var frm = document.loginFrm;
      frm.method = "post";
      frm.action = "<%=request.getContextPath()%>/member/login.do";
      frm.submit();
      
   }// end of function goLogin()-------------------------------
   
</script>
</head>
<body>
   <div class="Mycontainer">
      <jsp:include page="../include/header.jsp"></jsp:include>
      <div class="section" align="center">
         <div class="contents" >
         <h3 class="tit_login">로그인</h3>
         <div class="write_form">
            <form method="post" name="loginFrm" id="loginFrm" onsubmit="">
               <input type="text" id="loginUserid" name="userid" size="20" tabindex="1" value="" placeholder="아이디를 입력해주세요" required /><br/>
               <input type="password" id="loginPwd" name="pwd" size="20" tabindex="2" placeholder="비밀번호를 입력해주세요" required />
               
               <div class="login_searh">
                  <a href="<%=request.getContextPath()%>/login/idFind.do" class="link">아이디 찾기  |  </a>
                  <span class="bar"></span>
                  <a href="<%=request.getContextPath()%>/login/pwdFind.do" class="link">비밀번호 찾기 </a>
               </div>
               <button type="submit" class="btn_type1 btn_member" id="btnSubmit">
                  <span class="txt_type">로그인</span>
               </button>
            </form>
            
            <button onclick="javascript:location.href='<%=request.getContextPath()%>/member/register.do'" class="btn_type2 btn_member">
               <span class="txt_type text_type_btn">회원가입</span>
            </button>
         </div>
         </div>
      </div>
      <jsp:include page="../include/footer.jsp"></jsp:include>
      
   </div>


</body>
</html>