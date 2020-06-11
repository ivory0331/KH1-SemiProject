<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>serviceCenterSide.jsp</title>
<style>
	.menu{
		display: inline-block;
		list-style: none;
		padding: 0;
		width: 100%;
		border: solid 1px black;
	}
	
	.menu > li{
		line-height: 50px;
		cursor: pointer;
	}
	
	.menu > li:hover{
		text-decoration: underline;
		color:purple;
		background-color: #f4f4f4;
	}
</style>
</head>
<body>
	<h3>관리자 페이지</h3>
	<ul class="menu">
		<li class="underLine">매출관리</li>
		<li class="underLine">회원관리</li>
		<li class="underLine">주문관리</li>
		<li class="underLine">상품관리</li>
		<li>고객센터</li>
	</ul>
</body>
</html>