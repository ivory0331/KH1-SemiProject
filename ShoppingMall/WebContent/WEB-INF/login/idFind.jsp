
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<% String ctxPath = request.getContextPath(); %>
<%@ taglib prefix="c"   uri="http://java.sun.com/jsp/jstl/core" %> 
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>market kurly Id search</title>
<style type="text/css">
#content {
	font-family: noto sans, sans-serif, malgun gothic;
	min-width: 1080px;
	height: 612px;
	background-color: #fafafa;
	padding: 0;
	margin: 0 auto;
	text-align: center;
}

.section_login {
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

.section_login .tit_login {
	font-weight: 800;
	font-size: 20px;
	line-height: 10px;
	text-align: center;
}

div.loginCheck {
	padding-bottom: 14px;
	font-weight: 700;
	font-size: 16pt;
	line-height: 29px;
	font-family: noto sans;
	color: #5f0080;
}

.section_login * {
	color: #333;
}

h3.tit_login {
	display: block;
	font-weight: 800;
	font-size: 16pt;
	padding: 0;
	margin: 0;
}

.section_login .write_form {
	padding-top: 36px;
}

.thumb {
	width: 52px;
	height: 60px;
	margin: 10px 0 5px 0;
}

#content input{
	display: inline-block;
	width: 320px;
	height: 52px;
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
	color: -webkit-link;
	cursor: pointer;
	text-decoration: none;
}

.section_login .bar {
	float: right;
	width: 1px;
	height: 10px;
	margin: 3px 6px 0;
	background-color: #333;
}

.btn_member {
	display: inline-block;
	width: 320px;
	height: 54px;
	border: 1px solid #ccc;
	border-radius: 3px;
	background-color: #fff;
	font-size: 14px;
	cursor: pointer;
}

.btn_type1 {
	margin-top: 30px;
	padding: 0 40px;
	border: solid 1px #5f0080;
	background-color: #5f0080;
	font-style: normal;
}

.txt_type {
	font-weight: 500;
	font-size: 16px;
	color: #fff;
}

.text_type_btn {
	color: #5f0080;
	vertical-align: middle;
}

.txt_type_form {
	width : 300px;
	float: left;
	font-weight: 600;
	font-size: 12px;
	margin: 0;
	padding: 11px 0 5px 10px;
	display: block;
	font-size: 12px;
	line-height: 20px;
	text-align: left;
	/*border : solid 1px red;*/
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

		$("#btnSubmit").click(function() {
				goCheck(); // 로그인 시도한다.
		});

		$("#email").keydown(function(event) {
			if (event.keyCode == 13) { // 암호입력란에 엔터를 했을 경우 
				goCheck(); // 로그인 시도한다.
			}
		});
		
		$("#btn_login").click(function(){
			
			goLogin();
		});
		
		
		
	});// end of $(document).ready()------------------

	function goCheck() {
		
		var frm = document.idSearchForm;

		//1. 성명 입력란에 데이터 값 들어왔는지 검사
		var sNameVal = frm.name.val().trim();

		if (sNameVal == "") {
			alert("성명은 필수입력사항 입니다");
			frm.name.value = "";
			frm.name.focus();
			return;
		}

		//2. 이메일 입력란에 데이터값 들어왔는지 검사
		var regExp_email = /^[0-9a-zA-Z]([-_\.]?[0-9a-zA-Z])*@[0-9a-zA-Z]([-_\.]?[0-9a-zA-Z])*\.[a-zA-Z]{2,3}$/i;
		var bool = regExp_email.test($("#email").val().trim());

		if (!bool) {
			alert("올바른 이메일 형식이 아닙니다");
			return;
		}

		//리턴이 안되어야만 도달한다			
		var frm = document.idSearchForm;
		frm.action = "<%=ctxPath%>/login/idFind.do";
		frm.submit();
	}
	
	function goLogin() {
		
		var frm = document.loginForm;	
		frm.action = "<%=ctxPath%>/member/login.do";
		frm.submit();
	}
	
	   
</script>


</head>
<body>
	<jsp:include page="../include/header.jsp"></jsp:include>
	 <div id="content">
		<div class = "section_login">
			<h3 class="tit_login">아이디 찾기</h3>
			<div class="write_form">
				 <c:if test="${userid == null}">
				<form name="idSearchForm" id="idSearchForm" method="post">
					<span class="txt_type_form">이름</span>
					<input type="text" name="name" size="20" tabindex="1" value="" placeholder="고객님의 이름을 입력해주세요" required /><br/>
					<span class="txt_type_form">이메일 </span>
					<input type="email" name="email" id="email" size="20" tabindex="2" placeholder= "가입 시 등록하신 이메일 주소를 입력해주세요" required />
					
					<button type="submit" id="btnSubmit"class="btn_type1 btn_member">
						<span class="txt_type">확인 </span>
					</button>
				</form>
			</c:if>
			 <%-- *** 아이디 찾기 확인 된 화면 *** --%>
		   	 <c:if test="${userid != null}">
		        <form method="get" name="loginForm" id="loginForm">
					<img class="thumb" src="https://res.kurly.com/pc/service/member/1908/img_id_find_succsess_v2.png" alt="아이디찾기완료">
					<div class="loginCheck" >고객님의 <br/> 아이디 찾기가 완료되었습니다 </div>			
					<h6 class="tit_login" style="font-size:12pt; color:gray">아이디 : ${userid}</h6>
					<button type="button" id="btn_login" class="btn_type1 btn_member"  >
						<span class="txt_type">로그인 하기 </span>
					</button>
				</form>
		        
   			 </c:if>
			</div>
		  </div>
		</div>
	 <jsp:include page="../include/footer.jsp"></jsp:include>
</body>
</html>