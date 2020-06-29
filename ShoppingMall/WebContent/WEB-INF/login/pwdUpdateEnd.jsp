<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<% String ctxPath = request.getContextPath(); %>
<%@ taglib prefix="c"   uri="http://java.sun.com/jsp/jstl/core" %> 
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>비밀번호 찾기_새 비밀번호 등록</title>
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

#content h3 {
    display: block;
    font-weight: bold;
    padding: 0;
    margin: 0;
}

.section_login .write_form {
    padding-top: 36px;
}

#content input {
    display: inline-block;
    width: 320px;
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


#content a {
    color: #5f0080;
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
	padding: 0 40px;
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
	width : 300px;
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

.passwd_error{
	padding-top: 3px;
	padding-left: 12px;
	font-weight: 400;
	font-size: 9pt;
	line-height: 20px;
	font-family: noto sans;
	color: gray;	
	float : left;
	margin-bottom: 10px;
	text-align: left;
}

</style>
<script src="https://t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js"></script>
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.1/css/bootstrap.min.css">
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
<script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.1/js/bootstrap.min.js"></script> 
<script type="text/javascript" src="<%= ctxPath%>/js/jquery-3.3.1.min.js"></script>
<script type="text/javascript" src="<%= ctxPath%>/util/myutil.js"></script>
<script type="text/javascript">
	
	$(document).ready(function(){
		
		$("#btnUpdate").click(function(){
			
			var pwd = $("#pwd").val();
			var pwd2 = $("#pwd2").val();
			var regExp = /^.*(?=^.{8,15}$)(?=.*\d)(?=.*[a-zA-Z])(?=.*[^a-zA-Z0-9]).*$/g;			
			/* 암호는 숫자,영문자,특수문자가 포함된 형태의 8~15글자 이하만 허락해주는 정규표현식 객체 생성 */
			
			var bool = regExp.test(pwd);
			/* 암호 정규표현식 검사를 하는 것 
			      정규표현식에 만족하면 리턴값은 true,
			      정규표현식에 틀리면 리턴값은 false */
			      
			if(!bool) {
				alert("암호는 8글자 이상 15글자 이하에 영문자, 숫자, 특수기호가 혼합되어야 합니다."); 
				$("#pwd").val("");
				$("#pwd2").val("");
				return;
			}   
			else if(pwd != pwd2) {
				alert("암호가 일치하지 않습니다.");
				$("#pwd").val("");
				$("#pwd2").val("");
				return;
			}
			else {
				var frm = document.pwdSearchForm;
				
				frm.action = "<%= ctxPath%>/login/pwdUpdateEnd.do";
				frm.submit();	
			}
		});		
	});
	
</script>


<body>
	<jsp:include page="../include/header.jsp"></jsp:include>
	<div id="content">
		<div class = "section_login">
			<h3 class="tit_login">비밀번호 찾기</h3>
			<div class="write_form">			
				<form method="post" name="pwdSearchForm" id="form" method="post">
				<span class="txt_type_form">새 비밀번호 등록</span>
					<input type="password" name="pwd" id="pwd" size="20" tabindex="1" value="" placeholder="새 비밀번호를 입력해주세요" required /><br/>
					
					<div class="passwd_error">8~15자리 이내의 암호입력 <br/>영문/숫자/특수문자(공백 제외)만 허용</div>
					
					<span class="txt_type_form">새 비밀번호 확인 </span>
					<input type="password" name="pwd2" id="pwd2" size="20" tabindex="2" value="" placeholder="새 비밀번호를  한번 더 입력해주세요" required /><br/>
										
					<button type="button" class="btn_type1 btn_member" id="btnUpdate" >
						<span class="txt_type" id="btnSubmit">확인 </span>
					</button>
					
					<input type="hidden" name="userid" id="userid" value="${sessionScope.userid}" />
				</form>
				
			</div>
		</div>
	</div>
	<jsp:include page="../include/footer.jsp"></jsp:include>
</body>
</body>
</html>
    