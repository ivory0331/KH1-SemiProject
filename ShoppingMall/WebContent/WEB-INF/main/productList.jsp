<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
<%@ page import="java.util.List" %>
<% 
	String ctxPath = request.getContextPath(); 
	List<String> productList = (List<String>)request.getAttribute("productList");
	int cnt=0;

%>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<link rel="stylesheet" href="<%= ctxPath %>/css/style.css" />
<title>상품리스트</title>
</head>
<style>
	div#smallT, .productList {
		border: solid 0px gray;
		display: inline-block;
		margin: 30px;
	}
	.contents li {
		border: solid 1px gray;
		display: inline-block;
		cursor: pointer;
	}
	.contents li:hover {
		border: solid 3px purple;
	}
	.contents li>img {
		width: 300px;
		height: 400px;
	}
	.contents h3{
		margin-left: 30px;
	}
	.contents h4 {
		border-bottom: solid 2px purple;
		width: 100px;
		margin-left: 30px;
		cursor: pointer;
	}
	#smallT {
		float: left;
	}
	#list {
		border: solid 0px red;
		margin-top: 80px;
		float: right;
	}
</style>
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.1/css/bootstrap.min.css">
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
<script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.1/js/bootstrap.min.js"></script>
<script type="text/javascript" src="/ShoppingMall/js/jquery-3.3.1.min.js"></script>
<script type="text/javascript" src="/ShoppingMall/util/myutil.js"></script>
<script type="text/javascript">

	
</script>
<body>
	<div class="Mycontainer">
		<jsp:include page="../include/header.jsp"></jsp:include>
		<div class="section" align="center">
			<div class="contents">
			
				<div id="smallT">
					<h3>상품 리스트</h3>
					<h4>전체보기</h4>
				</div>
				<div id="list">
					<select>
						<option>신상품순</option>
						<option>인기상품순</option>
						<option>낮은 가격순</option>   
						<option>높은 가격순</option>
					</select>
				</div>
				
		<div class="productList" align="center">
		<table>
	        <tbody id="pList">
				<%-- 일단은 페이징처리를 안한 관리자를 제외한 모든 회원정보를 조회하도록 한다. --%>
				<c:if test="${empty productList}">
					<tr> 
						<td colspan = "3">현재 상품 준비중...</td>
					</tr>
				</c:if>
				
				<c:if test="${not empty productList}">
					<tr>
						<td></td>
						<td></td>
						<td></td>
						
						<c:forEach var="pvo" items="${productList}">
							<td></td>
						</c:forEach>
						
					</tr>
				</c:if>
			</tbody>
		</table>
		
	    <div>
	    	${pageBar}
	    </div>	
				</div>
			</div>
		
		<jsp:include page="../include/footer.jsp"></jsp:include>
		
		</div>
	</div>
</body>
</html>