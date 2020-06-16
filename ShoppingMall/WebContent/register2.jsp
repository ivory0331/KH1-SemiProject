<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>회원가입</title>
<style type="text/css">
body {
	background-color: #f2f2f2;
}

div {
	margin: 0 auto;
	width: 640px;
}

.page_article {
	background-color: #f2f2f2;
	margin: 0 auto;
	width: 1080px;
	
	heigjt: 1385px;
	margin: 0 auto;
	border: solid 1px #fff;
}

.tit {
	text-align: center;
	color: #333;
}

#form {
	width: 640px;
	height: 1234px;
	margin: 0 auto;
	background-color: #fff;
	border: solid 1px #fff;
}

span.error {
	color: red;
	font-size: 10pt;
}

fieldset {
	text-align: left;
	border: none;
}


fieldset>ul {
	list-style: none;
	padding: 0;
}

fieldset>ul>li {
	line-height: 60px;
}

fieldset>ul>li>label {
	display: inline-block;
	width: 130px;
	font-size: 14px;
	font-weight: 700;
	/*border: solid 1px skyblue;*/	
	padding: 30px 0 0 15px;   
    color: #333;
    line-height: 20px;
    vertical-align: top;
}

fieldset>ul>li>input {
	width: 300px;
	height: 40px;
	border: solid 1px #ccc;
	border-radius: 5px;  
}

label.genderbtn{
	padding: 30px 0 0 0px;
	width: 90px;
}

button.btnCheck{
	width: 130px;
	height: 40px;
    display: inline-block;
    line-height: 30px;
    text-align: center;
    background-color: #5f0080;
    border: 1px solid #5f0080;
    color: #fff;
    font-size: 15px;
    float: right;
    margin-left: 2px;
    font-size: 13px;
    border-radius: 5px;  
}

</style>
<script type="text/javascript" src="/JqueryStudy/js/jquery-3.3.1.min.js"></script>
<script type="text/javascript">
$(document).ready(function(){
		
	 $("span.error").hide();
	
	
	});
	 
</script>
</head>
<body>
	<div class = "page_article">
	<div class=" head_join">
		<h3 class="tit">회원가입</h3>
	</div>
		
	<div class="member_join">
	<div>
	<h6 class="tit" style="text-align: right">*필수 입력사항</h6>
	</div>
		<div>
			<form id="form" name="frmMember" method="post" action="/shop/member/indb.php">
			<fieldset>
			
			
				<ul>
					<li>
						<label for="userid">아이디*</label>
						<input type="text" name="userid" id="userid" placeholder ="6자 이상의 영문 혹은 영문과 숫자를 조합" value="" maxlength="20" required autofocus autocomplete="off" />
						&nbsp; <button class="btnCheck">중복확인</button>
					</li>
					
					<li>
						<label for="passwd">비밀번호*</label>
						<input type="password" name="passwd" id="passwd"  placeholder ="비밀번호를 입력해주세요" value="" maxlength="20" required />
						<span class="error password_error">10자 이상 입력 <br/> 영문/숫자/특수문자(공백제외)만허용하며, 2개이상 조합</span>
					</li>
					
					<li>
						<label for="passwd">비밀번호확인*</label>
						<input type="password" name="passwd" id="passwd" placeholder ="비밀번호를 한번 더 입력해주세요" value="" maxlength="20" required />
						<span class="error passwdCheck_error">10자 이상 입력 <br/> 영문/숫자/특수문자(공백제외)만허용하며, 2개이상 조합</span>
					</li>
		
					
					<li>
						<label for="name">이름*</label>
						<input type="text" name="name" id="name" value="" maxlength="20"  placeholder ="고객님의 이름을 입력해주세요" required />
					    <span class="error name_error"></span>
					</li>
					
					<li>
					<label for="email">이메일*</label>
					<input type="email" name="email" id="email" value="" maxlength="40" placeholder="예: marketkurly@kurly.com" required />
				    <span class="error email_error"></span>
				    &nbsp; <button class="btnCheck">이메일 중복확인</button>
					</li>
					
					<li>
						<label for="tel">휴대폰*</label>
						<input type="tel"  name="tel" id="tel" value="" maxlength="13" placeholder="숫자만 입력해주세요"/>
						<span class="tel tel_error"></span>
					</li>
					
					
					<li>
						<label for="address">배송주소</label>
						<button class="btnCheck">주소검색</button>
						<h6 class="tit"></h6>
						<span class="error address_error"></span>
					</li>
					
					<li>
						<label>성별</label>
						<label class="genderbtn"><input type="radio" name="gender" value="M" />남</label>&nbsp;
						<label class="genderbtn"><input type="radio" name="gender" value="F" />여</label>&nbsp;
						<label class="genderbtn"><input type="radio" name="gender" value="N" />선택안함</label>
					</li>	
					
					<li>
						<label>생년월일</label>
						<label class="birth_year"><input type="text" name="birth_year" value="M" />남</label>&nbsp;
						
					</li>	
		
		
		
					
				</ul>
			</fieldset>
			</form>		
		</div>	
	</div>
	</div>

</body>
</html>


