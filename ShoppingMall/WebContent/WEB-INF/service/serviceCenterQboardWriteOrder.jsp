<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>  
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<% String ctxPath = request.getContextPath(); %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>주문조회</title>
<style type="text/css">
#content{
	width : 98%;
	margin : 0 auto;
}

#content table{
	width : 100%;
	height: 100% ;
	cellpadding: 0;	
	cellspacing: 0;
	align:center;
}

body{
	position: absolute; 
	top: 0px; 
	left: 0px;
	bottom: 0px; 
	right: 0px;
}
td.stxt {
	height: 100%;
	valign: top;
	font : normal 8.5pt 돋움; 
}

.pagingBtn {
    display: inline-block;
    width: 30px;
    height: 30px;
    border-left: 0;
    font-size: 11pt;    
    color : gray;
    outline: 0;
    border : solid 1px #ccc;
    margin : 6px 0;
    vertical-align: middle;
    padding-top:4px;
}
.pagediv{
	border: solid 0px #ccc;
	margin : 0 auto;
}

a {
    background-color: transparent;
    text-decoration: none;
    color: inherit;
    cursor: pointer;
}

a:hover {
   text-decoration: none;
}

.stxt {
    color: #A8A8A8;
    letter-spacing: -1px;
    padding : 10px 0 0px 2px;
    font : normal 8.5pt 돋움; 
}

#btn_close{
	color: #fff;
    font-size: 9pt;
    padding :3px 8px;
    cursor: pointer;   
    background-color: #A8A8A8;
    margin : 10px 0;
    border-style:none;
    outline : 0;
    
}
</style>
<link rel="stylesheet" href="<%= ctxPath %>/css/style.css" />
<link rel="stylesheet"	href="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.1/css/bootstrap.min.css">
<script	src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
<script	src="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.1/js/bootstrap.min.js"></script>
<script type="text/javascript" src="/ShoppingMall/js/jquery-3.3.1.min.js"></script>
<script type="text/javascript" src="/ShoppingMall/util/myutil.js"></script>
<script type="text/javascript">
	

	$(document).ready(function(){
				
		$("#btn_close").click(function(){
			
			parent.$('#ifm_order').hide();
			
		});
	   
	});//end of $(document).ready(function(){})------------------------
    	
	function goWriteOrderNum(orderNum){
		
		parent.goWriteOrderNumToText(orderNum);
		parent.$('#ifm_order').hide();
	}
	

</script>

</head>
<body>
<div id="content">
	<table id="orderList" >
		<tbody>
			<tr>
				<td >
					<table >
						<tbody>
							<tr>
								<td >
									<table cellpadding="3" cellspacing="0" border="0">
										<tbody>
											<tr>
												<td class="stxt" style="padding-top: 10">문의하실 주문번호를 선택하세요.</td>
											</tr>
										</tbody>
									</table>
									<table width="100%" cellpadding="0" cellspacing="0" border="0" style="margin-top: 10px;">
										<colgroup>
											<col width="13%">
											<col width="13%">
											<col width="40%">
											<col width="10%">
											<col width="15%">
											<col width="7%">
										</colgroup>
										<tbody>
										
											<tr height="19" bgcolor="#A8A8A8">
												<th style="font: bold 8pt 돋움; color: #FFFFFF; padding: 4px; padding-left:10px" >주문번호</th>
												<th style="font: bold 8pt 돋움; color: #FFFFFF">주문일자</th>
												<th style="font: bold 8pt 돋움; color: #FFFFFF" align="center">상품명</th>
												<th style="font: bold 8pt 돋움; color: #FFFFFF">수량</th>
												<th style="font: bold 8pt 돋움; color: #FFFFFF">주문금액</th>
												<th style="font: bold 8pt 돋움; color: #FFFFFF">선택</th>
											</tr>
										
										<c:if test="${empty orderHistoryList}">
											<tr style="margin-bottom:1px;">
												<td class="stxt" colspan="6" height="1" bgcolor="#fff" align="center" style="padding: 30px;">
										   	    	주문 내역이 없습니다.
										   	    </td>
											</tr>		
										</c:if>
										<c:if test="${not empty orderHistoryList}">					
										<c:set var="temp" value="0" />
										<c:forEach var="ohvo" items="${orderHistoryList}">	
										<c:choose>
										<c:when test="${ohvo.order_num != temp}">															
											<tr height="25" align="center" style="border: solid 1px #ccc;">
												<td style="font: normal 8pt 돋움; color: #A8A8A8" ><span>${ohvo.order_num}</span></td>
												<td style="font: normal 8pt 돋움; color: #A8A8A8" >${ohvo.order_date}</td>
												<td style="font: normal 8pt 돋움; color: #A8A8A8" >${ohvo.product_name}..
													<c:if test="${ohvo.product_cnt != 0}">외 ${ohvo.product_cnt}건</c:if></td>
												<td style="font: normal 8pt 돋움; color: #A8A8A8" align="right">${ohvo.product_cnt}개</td>
												<td style="font: normal 8pt 돋움; color: #A8A8A8" align="right"><fmt:formatNumber value="${ohvo.price}" pattern="###,###"/>원</td>
												<td><input type="radio" name="ordernoSelect" onclick="goWriteOrderNum('${ohvo.order_num}')"></td>
											</tr>									
											<tr>
												<td colspan="6" height="1" bgcolor="E5E5E5"></td>
											</tr>
										
										<c:set var="temp" value="${ohvo.order_num}" />
										</c:when>
											<c:otherwise>
												<c:set var="temp" value="${ohvo.order_num}" />
											</c:otherwise>
										</c:choose>
										
									</c:forEach>
									</c:if>
									</tbody>
									</table>
									 <%-- 
									<div class="pagediv" align="center" style="margin-top: 30px;">									
									<a href="/service/serviceCenterQboardWriteOrder.jsp?&amp;page=1" class="pagingBtn layout-pagination-first-page"> &lt;&lt; </a>
									<a href="/service/serviceCenterQboardWriteOrder.jsp?&amp;page=1" class="pagingBtn layout-pagination-prev-page"> &lt; </a>
									<span class="pagingBtn" style="background-color:#F7F7F7;"></span>
									<a href="/service/serviceCenterQboardWriteOrder.jsp?&amp;page=1" class="pagingBtn layout-pagination-next-page"> &gt;</a>
									<a href="/service/serviceCenterQboardWriteOrder.jsp?&amp;page=1" class="pagingBtn layout-pagination-last-page"> &gt;&gt;</a> <!--  맨끝페이지로 가기 -->
									</div>--%>
									<div class="pagediv" align="center" style="margin-top: 30px;">${pageBar}</div>
								</td>
							</tr>
							<tr>								
								<td height="10" align="right" >
								<span id="btn_close" >CLOSE</span></td>					
							</tr>
						</tbody>
					</table>
				</td>
			</tr>
		</tbody>
	</table>
	<script>
	
</script>
</div>
</body>
</html>