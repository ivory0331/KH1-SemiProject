<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c"   uri="http://java.sun.com/jsp/jstl/core" %> 
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<% String ctxPath = request.getContextPath(); %>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>market kurly Password search</title>
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
    line-height: 10px;
    text-align: center;
}

.section_login * {
    color: #333;
}

h3 {
    display: block;
    font-weight: bold;
    padding: 0;
    margin: 0;
}

.section_login .write_form {
    padding-top: 36px;
}


input {
    display: inline-block;
    width: 300px;
    height: 54px;
    padding: 0 0 0 20px;
    border: 1px solid #ccc;
    border-radius: 3px;
    background-color: #fff;
    font-size: 14px;
    margin: 0px;
}


input::placeholder {
  color: #ccc;
}


a {
    color: -webkit-link;
    cursor: pointer;
    text-decoration: none;
}


.section_login .bar  {
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
    cursor:pointer;
}
.btn_type1{
	margin-top: 30px;
	border : solid 1px #5f0080;
	background-color: #5f0080;
	font-style: normal;
}	

.txt_type{
	font-weight: 500;
	font-size: 16px;
	color: #fff;
}
.text_type_btn{
	color: #5f0080;
	vertical-align: middle;
}
.txt_type_form{
	float:left;
	font-weight: 600;
	font-size: 12px;
	margin: 0;
	padding: 11px 0 5px 10px;
    display: block;
    font-size: 12px;
    line-height: 20px;
    text-align: left;

}
div.pwdCheck{
	padding-bottom: 14px;
	font-weight: 700;
	font-size: 16pt;
	line-height: 29px;
	font-family: noto sans;
	color: #5f0080;	
}

div.loginCheck {
	padding-bottom: 14px;
	font-weight: 700;
	font-size: 16pt;
	line-height: 29px;
	font-family: noto sans;
	color: #5f0080;
}

</style>
<script src="https://t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js"></script>
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.1/css/bootstrap.min.css">
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
<script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.1/js/bootstrap.min.js"></script> 
<script type="text/javascript" src="<%= ctxPath%>/js/jquery-3.3.1.min.js"></script>
<script type="text/javascript" src="<%= ctxPath%>/util/myutil.js"></script>
<script type="text/javascript">

	
	$(document).ready(function() {

		$("#btnConfirmCode").click(function() {
				goCheck(); // 로그인 시도한다.
		});

		$("#btnConfirmCode").keydown(function(event) {
			if (event.keyCode == 13) { // 암호입력란에 엔터를 했을 경우 
				goCheck(); // 로그인 시도한다.
			}
		});
		
	});// end of $(document).ready()------------------

	function goCheck() {
		
		var frm = document.verifyCertificationFrm;
		//frm.userid.value = $("#userid").val();
		frm.userCertificationCode.value = $("#input_confirmCode").val();
		
		frm.action = "<%= ctxPath%>/login/verifyCertification.do";
		frm.method = "POST";
		frm.submit();
	}
	
	   
	
</script>
</head>
<body>
	<div id="content">
		<div class = "section_login">
			<h3 class="tit_login">비밀번호 찾기</h3>
			<div class="write_form">
			
				<form name="pwdSearchForm" id="form" method="post">
					<span class="txt_type_form">이메일 주소 인증</span>
					<input type="text" name="input_confirmCode" id="input_confirmCode" size="20" tabindex="1" value=""required /><br/>
										
					<button type="button" id="btnConfirmCode"class="btn_type1 btn_member" >
						<span class="txt_type" >확인 </span>
					</button>
				</form>
				
				<form name="verifyCertificationFrm">
					<input type="hidden" name="userid" />
					<input type="hidden" name="userCertificationCode" />
				</form>
				
			</div>
		</div>
	</div>
</body>
</html>