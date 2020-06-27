<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<% String ctxPath = request.getContextPath(); %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<link rel="stylesheet" href="<%= ctxPath %>/css/style.css" />
<title>마이페이지 개인 정보 수정</title>

<style type="text/css">
	.contents {
		border: solid 0px black;
		min-height: 600px;
	}	    
	
	.menu3 > a {
		color: #5f0080 !important;
		background-color: #eee;
	}
	
	#myInfoUpdate_Title {
		border: solid 0px blue;
		font-size: 16pt;
		display: inline-block;
		float: left;
	}
	
	#line {
		border-top: solid 2px #5f0080;
		height: 20px;
	}
	
	#myInfoUpdate_PWcheck{
		margin: 30px;
		padding: 30px;
		border: solid 1px #eee;	
	}
	
	#userid {
		text-align: center;
		color: #5f0080;
		font-size: 12pt;
		display: inline-block;
		margin-bottom: 10px;
		border-style: none;
	}
	
	a#submit {
		background-color: #5f0080;
		color: white;
		font-size: 11pt;
		display: inline-block;
		width: 200px;
		padding: 15px;
	}
	
	a#submit:hover {
		text-decoration: none;
		cursor: pointer;
	}
	
</style>	

<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.1/css/bootstrap.min.css">
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
<script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.1/js/bootstrap.min.js"></script>
<script type="text/javascript" src="/ShoppingMall/js/jquery-3.3.1.min.js"></script>
<script type="text/javascript" src="/ShoppingMall/util/myutil.js"></script>

<script type="text/javascript">

	$(document).ready(function(){    
	    
		$("#submit").click(function(){
			goUpdate(); // 비밀번호가 맞는지 확인
		});
		
		
		$("#passwd").keydown(function(event){
			if(event.keyCode == 13) {	// 비밀번호 입력란에 엔터를 했을 경우
				goUpdate(); // 비밀번호가 맞는지 확인
			}
		});
		
	});	
	
	
	/* === 비밀번호가 맞는지 확인하는 함수 === */
	function goUpdate() {
	
		var passwd = $("#passwd").val().trim();	
		
		if(passwd == "") {
			alert("비밀번호를 정확하게 입력해 주세요.");
			$("#passwd").val("");
			$("#passwd").focus();
			return;	// goUpdate() 함수 종료
		}		
		
		else {		
			var frm = document.updateFrm;
			frm.action = "<%= ctxPath%>/member/myPageMyInfoUpdate.do";
			frm.method = "POST";
			frm.submit();
		}
			
	}// end of function goUpdate()---------------------------------
	
	

</script>

</head>
<body>	
	<div class="Mycontainer">
		<jsp:include page="../include/header.jsp"></jsp:include>
		<div class="section" align="center">
			<div class="contents">
							
			<jsp:include page="../include/myPageSideMenu.jsp"></jsp:include>	
			
			<form name="updateFrm">		
			<div id="myPage_Contents">		
				<div id="myInfoUpdate_Header">
					<h2 id="myInfoUpdate_Title">개인 정보 수정</h2>
					<div id="line" style="clear:both;"></div>
				</div>
				<div id="myInfoUpdate_Section">
					<h3>비밀번호 재확인</h3>
					<h5>회원님의 정보를 안전하게 보호하기 위해 비밀번호를 다시 한번 확인해주세요.</h5>
					<div id="myInfoUpdate_PWcheck">
						<div>아이디</div>				
					    <span id="userid">${(sessionScope.loginuser).userid}</span>

						<div>비밀번호</div>
						<input type="password" name="passwd" id="passwd" />
					</div>
					<div>
						<a id="submit">확인</a>
					</div>
				</div>
			</div>
			</form>
				
			</div>
			<div style="clear:both;"></div>
		</div>	
		<jsp:include page="../include/footer.jsp"></jsp:include>
	</div>
</body>
</html>