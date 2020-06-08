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
	<h3>고객센터</h3>
	<ul class="menu">
		<li class="underLine">공지사항</li>
		<li class="underLine">자주하는 질문</li>
		<li>1:1 문의</li>
	</ul>
</body>
</html>