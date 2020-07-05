<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
<% 
	String ctxPath = request.getContextPath(); 
%>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<link rel="stylesheet" href="<%= ctxPath %>/css/style.css" />
<title>추천쇼핑 리스트</title>
</head>
<style>
	div#smallT, .productList {
		border: solid 0px gray;
		display: inline-block;
		margin: 30px;
	}
	.contents h3{
		margin-left: 30px;
	}
	.sub {
		font-size: 12pt;
		padding: 0px 15px;
		cursor: pointer;
		color: gray;
	} 
	#pList {
		border: solid 0px purple;
		display: inline-block;
		margin: 100px 0 40px 50px !important;
		
	}
	tr, td {
		border: solid 0px red;
		display: inline-block;
	}
	td {
		width: 270px;
		height: 450px;
		margin-bottom: 10px;
	}
	table {
		text-align: center;
	}

	.sample_image img {
	    -webkit-transform:scale(1);
	    -moz-transform:scale(1);
	    -ms-transform:scale(1); 
	    -o-transform:scale(1);  
	    transform:scale(1);
	    -webkit-transition:.3s;
	    -moz-transition:.3s;
	    -ms-transition:.3s;
	    -o-transition:.3s;
	    transition:.3s;
	}
	.sample_image:hover img {
	    -webkit-transform:scale(1.1);
	    -moz-transform:scale(1.1);
	    -ms-transform:scale(1.1);   
	    -o-transform:scale(1.1);
	    transform:scale(1.1);
	}
	.sample_image {
		border: solid 0px yellow;
		overflow: hidden;
	}
	.pricecolor {
		text-align: left;
	}
	a:hover {
		text-decoration: none !important;
	}
</style>
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.1/css/bootstrap.min.css">
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
<script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.1/js/bootstrap.min.js"></script>
<script type="text/javascript" src="/ShoppingMall/js/jquery-3.3.1.min.js"></script>
<script type="text/javascript" src="/ShoppingMall/util/myutil.js"></script>
<script type="text/javascript">

	$(document).ready(function(){
		
	});
	
</script>
<body>
	<div class="Mycontainer">
		<jsp:include page="../include/header.jsp"></jsp:include>
		<div class="section" align="center">
			
		<div class="productList" align="center">
		<table>
	        <tbody id="pList" align="center">
				<%-- 일단은 페이징처리를 안한 관리자를 제외한 모든 회원정보를 조회하도록 한다. --%>
				<c:if test="${empty recommendProduct}">
					<tr> 
						<td colspan = "3">현재 상품 준비중...</td>
					</tr>
				</c:if>
				
				<c:if test="${not empty recommendProduct}">
					<tr>
						<c:forEach var="pvo" items="${recommendProduct}" varStatus="status">
							<td class="pricecolor">
								<a href='/ShoppingMall/detail.do?product_num=${pvo.product_num}'>
									<div style="width:250px; height:350px;" class="sample_image"><img style="width:100%; height:100%;" src="/ShoppingMall/images/${pvo.representative_img}" /></div>
									
									<br/><span style="font-size:13pt; letter-spacing: 0.6px; color:#333;">${pvo.product_name}</span>
									<c:if test="${pvo.sale != 0}">
										<br/><span style="text-decoration: line-through; color: #ccc; font-weight: bold; font-size: 17px;"><fmt:formatNumber value="${pvo.price}" pattern="###,###"/> 원</span>
										<span style="color: #5f0080; font-weight: bold; font-size: 17px;">&nbsp;→&nbsp;<fmt:formatNumber value="${pvo.finalPrice}" pattern="###,###" />원</span>
									</c:if>
									
									<c:if test="${pvo.sale == 0}">
										<br/><span style="color: #5f0080; font-weight: bold; font-size: 17px;"><fmt:formatNumber value="${pvo.price}" pattern="###,###"/>원</span>
									</c:if>
								</a>
							</td> 
							
							<c:if test="${(status.count)%3 == 0 }">
								</tr>
								<tr>
							</c:if>
						
						</c:forEach>
					</tr>
				</c:if>
			</tbody>
		</table>
		
	    <div>
	    	${pageBar}
	    </div>	
	    <div>
	    	<a style="display:scroll;position:fixed;bottom:10px;right:10px;margin:10px;" href="#" title=”맨위로"><img style="width:60px; height:55px;" src="/ShoppingMall/images/topBtn.png"></a>
	    </div>
				</div>
			</div>
		
		<jsp:include page="../include/footer.jsp"></jsp:include>
		
		</div>
	</div>
</body>
</html>