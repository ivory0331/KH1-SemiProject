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
	location.href="<%=ctxPath%>/manager/"+url;
}
</script>
</head>
<body>
	<h4>관리자 페이지</h4>
	<ul class="menu">
		<li class="underLine" onclick="goService('')">매출관리</li>
		<li class="underLine" onclick="goService('managerMemberList.do')">회원관리</li>
		<li class="underLine" onclick="goService('')">주문관리</li>
		<li class="underLine" onclick="goService('managerProductList.do')">상품관리</li>
		<li class="underLine" onclick="goService('')">문의관리</li>
		<li class="underLine" onclick="goService('mangerBoardWrite.do')">게시글 작성</li>
		<li>고객센터</li>
	</ul>
</body>
</html>