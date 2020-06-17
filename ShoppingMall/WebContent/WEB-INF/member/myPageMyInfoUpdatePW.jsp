<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>마이페이지 개인 정보 수정</title>
<link rel="stylesheet" href="css/style.css" />

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
		display: inline-block;
		margin-bottom: 10px;
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
<link rel="stylesheet" href="css/style.css" />
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
<script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.1/js/bootstrap.min.js"></script>
<script type="text/javascript" src="/ShoppingMall/js/jquery-3.3.1.min.js"></script>
<script type="text/javascript" src="/ShoppingMall/util/myutil.js"></script>

<script type="text/javascript">

</script>

</head>
<body>	
	<div class="container">
		<jsp:include page="../include/header.jsp"></jsp:include>
		<div class="section" align="center">
			<div class="contents">
							
			<jsp:include page="../include/myPageSideMenu.jsp"></jsp:include>	
					
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
						<span id="userid">leess</span>
						<div>비밀번호</div>
						<input type="password" name="passwd" id="passwd" />
					</div>
					<div>
						<a id="submit">확인</a>
					</div>
				</div>
			</div>
				
			</div>
			<div style="clear:both;"></div>
		</div>	
		<jsp:include page="../include/footer.jsp"></jsp:include>
	</div>
</body>
</html>