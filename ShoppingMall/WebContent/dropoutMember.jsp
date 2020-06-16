<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>회원탈퇴</title>
<style type="text/css">
#content{
	font-family : noto sans, sans-serif, malgun gothic;
	min-width : 1080px;
	height: 100%;
	/*background-color: #fafafa;*/
	padding : 0;
	margin : 0 auto;
	text-align: center;	
}

div.section_login {
    color: #333;
    width : 1080px;
	height: 100%;
	/* border : solid 1px red;*/
	margin : 0 auto;
}

.layout-page-title{
	font-size: 38px;
	font-weight: 500;
    color: #514859;
    letter-spacing: 0;
}

input[type=password]{
    width: 200px;
	height: 30px;
	border: solid 1px #ccc; 
}

div.boardWrite{

	border-top: solid 2px purple;
	border-bottom: solid 1px #ccc
}
h3 {
    padding: 50px 0 12px;
    font-size: 20px;
    line-height: 28px;
    font-family: noto sans;
    font-weight: 600;
    color: #514859;
    letter-spacing: 0;
    margin : 0;
    text-align: left;
}

a {
    cursor: pointer;
    text-decoration: none;
}

td.memberCols1 {
    width: 130px;
    padding: 23px 0 25px 20px;
    text-align: left;
    vertical-align: middle;
    font-size: 13px;
    font-weight: 700;
   /* border : solid 1px red;*/
}

td.memberCols2 {
    width: auto;
    padding: 10px 0 10px 10px;
    vertical-align: middle;
    text-align: left;
    font-size: 9.8pt;
    /* border : solid 1px red;*/
    color : #333;
}
.drop_button{
	width: 130px;
	height: 40px;
    display: inline-block;
    line-height: 30px;
    text-align: center;
    background-color: #5f0080;
    color: #fff;
    font-size: 14px;
    float: right;
    margin-left: 2px;
    border-radius: 2px;
    border-style: none;
    cursor: pointer;
    margin-left : 5px;
    vertical-align: middle;
}


</style>
</head>
<body>
	<div id="content">
		<div class = "section_login">
		
		<h2 class="layout-page-title">회원탈퇴</h2>
		
		<form method="post" action="#" id="form">
			<h3>회원탈퇴안내</h3>
			<div class="boardWrite">
				<table width="100%">
					<tbody><tr>
					<td class="memberCols1" >
					회원탈퇴안내
					</td>
					<td class="memberCols2">
					고객님께서 회원 탈퇴를 원하신다니 저희 쇼핑몰의 서비스가 많이 부족하고 미흡했나 봅니다.<br>
					불편하셨던 점이나 불만사항을 알려주시면 적극 반영해서 고객님의 불편함을 해결해 드리도록 노력하겠습니다.<br>
					<br>
					■ 아울러 회원 탈퇴시의 아래 사항을 숙지하시기 바랍니다.<br>
					1. 회원탈퇴 시 고객님의 정보는 상품 반품 및 A/S를 위해 전자상거래 등에서 소비자 보호에 관한 법률에 의거한 고객정보 보호정책에따라 관리 됩니다.<br>
					2. 탈퇴 시 고객님께서 보유하셨던 적립금은 삭제 됩니다.<br>
					3. 회원 탈퇴 후 30일간 재가입이 불가능합니다.<br>
					4. 회원 탈퇴 시 컬리패스 해지는 별도로 고객행복센터(1644-1107)를 통해서 가능합니다. 직접 해지를 요청하지 않으면 해지 처리가 되지 않습니다.<br>
					</td>
					</tr>
					</tbody>
				</table>
			</div>
			
			<h3>회원탈퇴하기</h3>
			<div class="boardWrite" >
				<table width="100%">
				<tbody><tr>
				<td class="memberCols1">
				비밀번호가 어떻게 <br/> 되세요?
				</td>
				<td class="memberCols2">
				<input type="password" name="password" size="20">
				</td>
				</tr>			
				</tbody></table>
			</div>
			
			<div style="margin-top:30px;">
			<input class="drop_button" value="탈퇴" type="submit">
			<a href="#이전페이지"><span style="padding-top:1px; vertical-align: middle" class="drop_button">취소</span></a>	
			</div>
			
		</form>
			
		</div>
		</div>
</body>
</html>



