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
		/* border: solid 1px black; */
		min-height: 600px;
	}
	    
	#myPage_Side {
		/* border: solid 1px red; */
		margin-top: 50px;
		width: 20%;
		float: left;
	}
	
	#myPage_Contents {
		/* border: solid 1px blue; */
		margin-top: 60px;
		width: 78%;
		float: right;
	}
	
	#myPage_SideMenu, .myPage_SideInnerMenu {
		border: solid 1px gray;
		border-collapse: collapse;
	}
	   
	.myPage_SideInnerMenu > a {
		display: table-cell;
		vertical-align: middle;
		padding-left: 5px;
		width: 200px;
		height: 50px;
		color: black;
	}
	
	.myPage_SideInnerMenu > a:hover {
		color: #5f0080;
		background-color: #eee;
		text-decoration: none;
		cursor: pointer;
	}
	
	.menu3 > a {
		color: #5f0080;
		background-color: #eee;
	}
	
	#myInfoUpdate_Title {
		/* border: solid 1px blue; */
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
		<jsp:include page="include/header.jsp"></jsp:include>
		<div class="section" align="center">
			<div class="contents">	
			
			<div id="myPage_Side">
				<h3 id="myPage_Title">마이페이지</h3>
				<div id="myPage_Menu">
					<table id="myPage_SideMenu">
						<tr>
							<td class="myPage_SideInnerMenu menu1"><a href="/ShoppingMall/myPageOrderHistory.jsp">주문 내역</a></td>
						</tr>
						<tr>
							<td class="myPage_SideInnerMenu menu2"><a>상품후기</a></td>
						</tr>
						<tr>
							<td class="myPage_SideInnerMenu menu3"><a href="/ShoppingMall/myPageMyInfoUpdatePW.jsp">개인 정보 수정</a></td>
						</tr>
						<tr>
							<td class="myPage_SideInnerMenu menu4"><a>1:1 문의</a></td>
						</tr>
					</table>
				</div>
			</div>
			
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
		<jsp:include page="include/footer.jsp"></jsp:include>
	</div>
</body>
</html>