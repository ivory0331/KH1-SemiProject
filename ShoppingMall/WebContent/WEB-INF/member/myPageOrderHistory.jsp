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
<title>마이페이지 주문 내역</title>

<style type="text/css">
	.contents {
		border: solid 0px black;
		min-height: 600px;
	}	    
	
	.menu1 > a {
		color: #5f0080 !important;
		background-color: #eee;
	}
	
	li {
		list-style-type: none;
	}	
	
	#myOrderHistory_Header {
		border: solid 0px pink;
		margin-top: 5px;
	}
	
	#myOrderHistory_List {
		border: solid 0px navy;
	}
	
	#myOrderHistory_Title {
		border: solid 0px blue;
		font-size: 16pt;
		display: inline-block;
		float: left;
	}
	
	#myOrderHistory_Text {
		border: solid 0px red;	
		font-size: 8pt;
		display: inline-block;
		margin: 30px 0 0 10px;
		float: left;
	}
	
	#mySelectTerm {
		display: inline-block;				
		margin: 25px 10px 0 0;
		float: right;
	}
	
	#line {
		border-top: solid 2px #5f0080;
		height: 20px;
	}
	
	.myOrder_Date {
		border: solid 0px red;
		text-align: left;
	}
	
	.myOrder_Goods {
		border: solid 1px #eee;
		margin-bottom: 20px;
	}
	
	div.myOrder_Name {
		border: solid 0px cyan;
		border-bottom: solid 1px #eee;
		padding: 10px 5px;
		text-align: left;
		color: black;
	}  
	
	.myOrder_Name > a {  
		color: black;
	}
	
	.myOrder_Name > a:hover {
		text-decoration: none;
		color: black;
		cursor: pointer;
	}
	
	.myOrder_Info {
		border: solid 0px orange;
		display: inline-block;
		width: 80%;
	}
	
	.myOrder_Image > img {
		border: solid 0px purple;
		margin: 5px;
		width: 60px;
		height: 75px;
		float: left;
	}
	
	.myOrder_Desc > dl {
		float: left;
		display: inline-block;
	}
	
	.myOrder_Desc {
		border: solid 0px lime;
		margin: 16px 0 0 10px;
		display: inline-block;
		float: left;
		font-size: 10pt;
	}

	.mytd1 {
		width: 80px;
	}
	
	.myOrder_Status {
		border: solid 0px lime;
		display: inline-block;
		margin-bottom: 17px;
		width: 15%;
	}	
	
	a.link_question {
		border: solid 1px #5f0080;
		display: inline-block; 
		float: right;
		width: 100px;
		padding: 5px 0;
		margin: 5px;
		color: #5f0080;
		background-color: white;
	}
	
	a.link_question:hover {
		text-decoration: none;		
		color: #5f0080;
		cursor: pointer;
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
		
		$(".myOrder_Name").click(function(){
			var order_num = $(this).find(".order_num").val();
			// alert(order_num);
		    location.href="<%= ctxPath%>/member/myPageOrderHistoryDetail.do?order_num="+order_num;
		});
		
	});// end of $(document).ready()---------------------
	
	
	
</script>

</head>
<body>	
	<div class="Mycontainer">
		<jsp:include page="../include/header.jsp"></jsp:include>
		<div class="section" align="center">
			<div class="contents">	
			
			<jsp:include page="../include/myPageSideMenu.jsp"></jsp:include>
				
			<div id="myPage_Contents">		
				<div id="myOrderHistory_Header">
					<h2 id="myOrderHistory_Title">주문 내역</h2>
					<span id="myOrderHistory_Text">지난 3년간의 주문 내역 조회가 가능합니다</span>
					<ul>
						<li id="mySelectTerm">
							<select name="term" id="term">
								<option value="1" selected>전체기간</option>
								<option value="2">2020년</option>
								<option value="3">2019년</option>
								<option value="4">2018년</option>
							</select>
						</li>
					</ul>
					<div id="line" style="clear:both;"></div>
				</div>
			
				<div id="myOrderHistory_List">
					<c:if test="${empty orderHistoryList}">
						<div style="margin-bottom:100px;">
							<span>
					   	    	주문 내역이 없습니다.
					   	    </span>
						</div>
					</c:if>
					
					<c:if test="${not empty orderHistoryList}">					
					<c:set var="temp" value="0" />
					<c:forEach var="ohvo" items="${orderHistoryList}">
					<div>
					 	<c:choose>
						 	<c:when test="${ohvo.order_num != temp}">
								<div class="myOrder_Date">${ohvo.order_date}</div>
								<div class="myOrder_Goods">
									<div class="myOrder_Name">
										<a class="myOrder_Name">${ohvo.product_name}&nbsp;
											<c:if test="${ohvo.product_cnt != 1}">외 ${ohvo.product_cnt-1}건</c:if>
											<input type="hidden" class="order_num" value="${ohvo.order_num}"/>
										</a>
									</div>
									<div class="myOrder_block">
										<div class="myOrder_Info">
											<div class="myOrder_Image">
												<img alt="해당 주문 대표 상품 이미지" src="<%=ctxPath %>/images/${ohvo.representative_img}">
											</div> 
											<table class="myOrder_Desc">
												<tr>
													<td class="mytd1">주문번호</td>
													<td class="mytd2">${ohvo.order_num}</td>
												</tr>
												<tr>
													<td class="mytd1">결제금액</td>
													<td class="mytd2"><fmt:formatNumber value="${ohvo.price}" pattern="###,###"/> 원</td>
												</tr>
												<tr>
													<td class="mytd1">주문상태</td>
													<td class="status end mytd2">${ohvo.order_state}</td>
												</tr>															
											</table>						
											<div style="clear:both;"></div>
										</div>						
										<div class="myOrder_Status">
											<span class="myOrder_InnerStatus">
												<a class="link link_question" href="<%= ctxPath %>/service/serviceCenterMyQboardWrite.do">1:1 문의</a>
											</span>
										</div>
									</div>
								</div>
								<c:set var="temp" value="${ohvo.order_num}" />
							</c:when>
							
							<c:otherwise>
								<c:set var="temp" value="${ohvo.order_num}" />
							</c:otherwise>
						</c:choose>						
					</div>	
					</c:forEach>
					</c:if>
				</div>	
				<div style="border-bottom:solid 1px black; text-align:center;">페이징 처리</div>			
			</div>						
			</div>
			<div style="clear:both;"></div>
		</div>	
		<jsp:include page="../include/footer.jsp"></jsp:include>
	</div>
</body>
</html>