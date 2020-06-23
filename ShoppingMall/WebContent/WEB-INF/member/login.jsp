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
#content{
	font-family : noto sans, sans-serif, malgun gothic;
	min-width : 1080px;
	height: 612px;
	background-color: #fafafa;
	padding : 0;
	margin : 0 auto;
	text-align: center;	
}

.section_login{
	width: 340px;
	margin: 0 auto;
	padding-top : 90px;
	letter-spacint : 6px;
	diplay : block;
	color : #4c4c4c;
	font-size: 12px;
	max-width: 100%;
    line-height: 35px;
}

.section_login .tit_login {
    font-weight: 800;
    font-size: 20px;
    line-height: 20px;
    text-align: center;
}

.section_login * {
    color: #333;
}

h3 {
    display: block;
    font-weight: bold;
}



.section_login .write_form {
    padding-top: 36px;
}


.contents input {
    display: inline-block;
    width: 300px;
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


.contents a {
    color: -webkit-link;
    cursor: pointer;
    text-decoration: none;
}


.section_login .login_search .bar {
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
	padding-top:10px;
 	
}

</style>
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.1/css/bootstrap.min.css">
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
<script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.1/js/bootstrap.min.js"></script>
<script type="text/javascript" src="/ShoppingMall/js/jquery-3.3.1.min.js"></script>
<script type="text/javascript" src="/ShoppingMall/util/myutil.js"></script>
</head>
<body>
	<div class="Mycontainer">
		<jsp:include page="../include/header.jsp"></jsp:include>
		<div class="section" align="center">
			<div class="contents">
			<h3 class="tit_login">로그인</h3>
			<div class="write_form">
				<form method="post" name="form" id="form" action="#" onsubmit="">
					<input type="text" name="id" size="20" tabindex="1" value="" placeholder="아이디를 입력해주세요" required /><br/>
					<input type="password" name="password" size="20" tabindex="2" placeholder="비밀번호를 입력해주세요" required />
					
					<div class="login_searh">
						<a href="#id찾기페이지 " class="link">아이디 찾기  |  </a>
						<span class="bar"></span>
						<a href="#비밀번호 찾기페이지" class="link">비밀번호 찾기 </a>
					</div>
					<button type="submit" class="btn_type1 btn_member">
						<span class="txt_type">로그인</span>
					</button>
				</form>
				
				<a href="#회원가입사이트" class="btn_type2 btn_member">
					<span class="txt_type text_type_btn">회원가입</span>
				</a>
			</div>
			</div>
		</div>
		<jsp:include page="../include/footer.jsp"></jsp:include>
		
	</div>
</body>
</html>