<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %> 
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>   

<% String ctxPath = request.getContextPath(); %>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<link rel="stylesheet" href="<%= ctxPath %>/css/style.css" />
<title>마이페이지 주문 내역 상세</title>

<style type="text/css">
	.contents {
		border: solid 0px black;
		min-height: 600px;
	}	    
	
	.menu1 > a {
		color: #5f0080 !important;
		background-color: #eee;
	}		
	
	#myOrderHistoryDetail_Header {
		border: solid 0px pink;
		margin-top: 5px;
	}
	
	#myOrderHistory_List {
		border: solid 0px navy;
	}
	
	#myOrderHistoryDetail_Title {
		border: solid 0px blue;
		font-size: 16pt;
		display: inline-block;
		float: left;
	}
	
	#line {
		border-top: solid 2px #5f0080;
		height: 20px;
	}	
	
	.myOrder_number > h3 {
		border: solid 0px blue;
		text-align: left;
		font-size: 14pt;		
	}
	
	a.productName:hover {
		text-decoration: none;
		color: black;
		cursor: pointer;
	}
	
	table.myOrder_Desc {
		border: solid 0px red;
		width: 100%;
	}
	
	.desc-list {
		border: solid 1px #eee;
	}
	
	td {
		border: solid 0px red;
	}
	
	td.image {
		width: 130px;
	}
	
	td.image > img {
		margin: 10px 30px;
		width: 80px;
		height: 102px;
	}
	
	.info {
		width: 400px;
	}
	
	.productName {
		font-size: 11pt;
		color: black;
	}
	
	.count {
		font-size: 9pt;
		margin-left: 5px;
	}
	
	td.delivery {
		width: 160px;
		text-align: center;
		color: #5f0080;
	}
	
	
	a.link_review {
		border: solid 1px #5f0080;
		display: inline-block; 
		width: 110px;
		padding: 5px;
		margin: 10px;
		color: white;
		font-weight: bold;
		background-color: #5f0080;
		text-align: center;
	}
	
	a.link_review:hover {
		text-decoration: none;		
		color: white;
		cursor: pointer;
	}	
	
	a.link_review_complete {
		border: solid 1px #ccc;
		display: inline-block; 
		width: 110px;
		padding: 5px;
		margin: 10px;
		color: #ccc;
		font-weight: bold;
		text-align: center;
	}
	
	a.link_review_complete:hover {
		text-decoration: none;	
		color: #ccc;
	}

	.head_section {
		padding-top: 30px;
		text-align: left;
		border-bottom: solid 2px #5f0080;		
	}
	
	h3.tit {
		font-size: 14pt;
	}
	
	table.info {
		width: 100%;
	}
	
	th.info  {
		border: solid 0px red;
		width: 208px;
		height: 50px;
	}
	
	td.info {
		border: solid 0px blue;
		width: 610px;
		height: 50px;
	}
	
}
	
	
</style>

<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.1/css/bootstrap.min.css">
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
<script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.1/js/bootstrap.min.js"></script>
<script type="text/javascript" src="/ShoppingMall/js/jquery-3.3.1.min.js"></script>
<script type="text/javascript" src="/ShoppingMall/util/myutil.js"></script>

<script type="text/javascript">

	$(document).ready(function(){
		var price = Number("${OrderInfoDetail.price}")-3000;
		$(".orderProduct-price").html(func_comma(price)+"원");
	});

	function goReview(num){
		location.href="<%= ctxPath%>/member/myPageReviewWrite.do?product_num="+num;
	}
	
</script>

</head>
<body>	
	<div class="Mycontainer">
		<jsp:include page="../include/header.jsp"></jsp:include>
		<div class="section" align="center">
			<div class="contents">	
			
			<jsp:include page="../include/myPageSideMenu.jsp"></jsp:include>
				
			<div id="myPage_Contents">		
				<div id="myOrderHistoryDetail_Header">
					<h2 id="myOrderHistoryDetail_Title">주문 내역 상세</h2>	
					<div id="line" style="clear:both;"></div>				
				</div>
			
				<div id="myOrderHistoryDetail_List">
					<div>												
						<div class="myOrder_number">
							<h3>주문번호&nbsp;${order_num}</h3>
						</div>
						
						<div class="myOrder_Goods">						
							<div class="myOrder_Info">
							
								<table class="myOrder_Desc">	
									<c:forEach var="OrderProductsList" items="${OrderProductsList}">					
									<tr class="desc-list">
										<td class="image">
											<img alt="해당 주문 대표 상품 이미지" src="<%=ctxPath %>/images/${OrderProductsList.representative_img}">
										</td>
										<td class="info">
											<div class="name">
												<a class="productName" href="<%= ctxPath %>/detail.do?product_num=${OrderProductsList.product_num}">${OrderProductsList.product_name}</a>
											</div>
											<div class="desc">
												<span class="price"><fmt:formatNumber value="${OrderProductsList.price}" pattern="###,###"/> 원</span>
												<span class="count">${OrderProductsList.product_count}개 구매</span>
											</div>											
										</td>		
										<td class="delivery">
											<span>${OrderProductsList.order_state}</span>
										</td>
										
										<c:choose>
											<c:when test="${OrderProductsList.reviewFlag != 1 && OrderProductsList.order_state == '배송완료'}">
												<td class="link">
													<a class="link_review" onclick="goReview('${OrderProductsList.product_num}')">후기 작성</a>
												</td>							
											</c:when>	
											<c:when test="${OrderProductsList.reviewFlag == 1 && OrderProductsList.order_state == '배송완료'}">
												<td class="link">
													<a class="link_review_complete">후기 작성 완료</a>
												</td>							
											</c:when>
											<c:otherwise>
												<td class="link">
													<a class="link_review_complete">후기 작성</a>
												</td>
											</c:otherwise>
										</c:choose>														
									</tr>
									</c:forEach>														
								</table>
									
													
								<div style="clear:both;"></div>
													
								<div class="head_section">								
									<h3 class="tit">결제 정보</h3>									
								</div>
								
								<table class="info">
									<tr>
										<th class="info">총주문금액</th>
										<td class="info orderProduct-price">
											
										</td>
									</tr>
									<tr>
										<th class="info">배송비</th>
										<td class="info">3,000 원</td>
									</tr>
									<tr style="border-bottom:solid 1px #ddd;">
										<th class="info">결제금액</th>
										<td class="info"><fmt:formatNumber value="${OrderInfoDetail.price}" pattern="###,###"/> 원</td>										
									</tr>
								</table>
								
								<div class="head_section">								
									<h3 class="tit">주문 정보</h3>									
								</div>
								
								<table class="info">
									<tr>
										<th class="info">주문 번호</th>
										<td class="info">${order_num}</td>
									</tr>
									<tr>
										<th class="info">주문자명</th>
										<td class="info">${name}</td>
									</tr>
									<tr>
										<th class="info">결제일시</th>
										<td class="info">${OrderInfoDetail.order_date}</td>										
									</tr>
									<tr style="border-bottom:solid 1px #ddd;">
										<th class="info">주문 처리상태</th>
										<td class="info">${OrderInfoDetail.order_state}</td>										
									</tr>
								</table>
								
								<div class="head_section">								
									<h3 class="tit">배송 정보</h3>									
								</div>
								
								<table class="info" style="margin-bottom: 50px;">
									<tr>
										<th class="info">받는 분</th>
										<td class="info">${OrderInfoDetail.recipient}</td>
									</tr>
									<tr>
										<th class="info">받는 분 핸드폰</th>
										<td class="info">${OrderInfoDetail.mobileForm}</td>
									</tr>
									<tr>
										<th class="info">우편번호</th>
										<td class="info">${OrderInfoDetail.recipient_postcode}</td>										
									</tr>
									<tr>
										<th class="info">주소</th>
										<td class="info">${OrderInfoDetail.recipient_address}&nbsp;${OrderInfoDetail.recipient_detailAddress}</td>										
									</tr>
									<tr style="border-bottom:solid 1px #ddd;">
										<th class="info">배송 요청사항</th>
										<td class="info">${OrderInfoDetail.memo}</td>										
									</tr>
								</table>																
							</div>												
						</div>
						
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





















