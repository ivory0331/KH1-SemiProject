<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
	String ctxPath = request.getContextPath();
%>
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
<script>
	function goService(url){
		location.href="<%=ctxPath%>/service/"+url;
	}
</script>
</head>
<body>
	<h3>고객센터</h3>
	<ul class="menu">
		<li class="underLine" onclick="goService('board.do')">공지사항</li>
		<li class="underLine" onclick="goService('FAQ.do')">자주하는 질문</li>
		<li onclick="goService('MyQue.do')">1:1 문의</li>
	</ul>
</body>
</html>