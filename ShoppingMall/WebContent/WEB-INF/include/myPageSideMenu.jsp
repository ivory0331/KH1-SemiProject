<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%
    String ctxPath = request.getContextPath();
    //    /MyMVC
%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>myPageSideMenu.jsp</title>
<style>
	#myPage_Side {
		border: solid 0px red;
		margin-top: 50px;
		width: 20%;
		float: left;
	}
	
	#myPage_Contents {
		border: solid 0px blue;
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
</style>
</head>
<body>
	<div id="myPage_Side">
		<h3 id="myPage_Title">마이페이지</h3>
		<div id="myPage_Menu">
			<table id="myPage_SideMenu">
				<tr>
					<td class="myPage_SideInnerMenu menu1"><a href="<%= ctxPath %>/member/myPageOrderHistory.do">주문 내역</a></td>
				</tr>
				<tr>
					<td class="myPage_SideInnerMenu menu2"><a href="<%= ctxPath %>/member/myPageProductPossibleReview.do">상품후기</a></td>
				</tr>
				<tr>
					<td class="myPage_SideInnerMenu menu3"><a href="<%= ctxPath %>/member/myPageMyInfoUpdatePW.do">개인 정보 수정</a></td>
				</tr>
				<tr>
					<td class="myPage_SideInnerMenu menu4"><a href="<%= ctxPath %>/service/serviceCenterMyQboardWrite.do">1:1 문의</a></td>
				</tr>
			</table>
		</div>
	</div>
</body>
</html>