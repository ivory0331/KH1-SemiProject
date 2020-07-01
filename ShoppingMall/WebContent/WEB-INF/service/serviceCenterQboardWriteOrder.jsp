<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>  
<% String ctxPath = request.getContextPath(); %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>주문조회</title>

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
    	
	

</script>
<style type="text/css">
#content table{
	width : 100%;
	height: 100% ;
	cellpadding: 0;	
	cellspacing: 0;
	border : solid 1px #ccc;
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
	border: solid 1px #ccc;
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
    color: gray;
    letter-spacing: -1px;
    font-size: 8.5pt;
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
											<col width="20%">
											<col width="12%">
											<col width="36%">
											<col width="10%">
											<col width="15%">
											<col width="7%">
										</colgroup>
										<tbody>
										
											<tr height="19" bgcolor="#A8A8A8">
												<th style="font: bold 8pt 돋움; color: #FFFFFF">주문번호</th>
												<th style="font: bold 8pt 돋움; color: #FFFFFF">주문일자</th>
												<th style="font: bold 8pt 돋움; color: #FFFFFF">상품명</th>
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
											<tr height="25" align="center" style="border: solid 1px #ccc;">
												<td style="font: bold 8pt 돋움; color: #A8A8A8" >${ohvo.order_num}</td>
												<td style="font: bold 8pt 돋움; color: #A8A8A8" >${ohvo.order_date}</td>
												<td style="font: bold 8pt 돋움; color: #A8A8A8" >${ohvo.product_name}..외 ${ohvo.product_cnt-1}건</td>
												<td style="font: bold 8pt 돋움; color: #A8A8A8" align="right">${ohvo.product_cnt}</td>
												<td style="font: bold 8pt 돋움; color: #A8A8A8" align="right">${ohvo.price}원</td>
												<td><input type="radio" name="ordernoSelect" onclick="parent.order_put('order_num')"></td>
											</tr>
																						
											<tr>
												<td colspan="6" height="1" bgcolor="E5E5E5"></td>
											</tr>
										</c:forEach>
										</c:if>
										</tbody>
									</table>
									<div class="pagediv" align="center" style="margin-top: 30px;">									
									<a href="/service/serviceCenterQboardWriteOrder.jsp?&amp;page=1" class="pagingBtn layout-pagination-first-page"> &lt;&lt; </a>
									<a href="/service/serviceCenterQboardWriteOrder.jsp?&amp;page=1" class="pagingBtn layout-pagination-prev-page"> &lt; </a>
									<strong class="pagingBtn" style="background-color:#F7F7F7;">1</strong>
									<a href="/service/serviceCenterQboardWriteOrder.jsp?&amp;page=1" class="pagingBtn layout-pagination-next-page"> &gt;</a>
									<a href="/service/serviceCenterQboardWriteOrder.jsp?&amp;page=1" class="pagingBtn layout-pagination-last-page"> &gt;&gt;</a> <!--  맨끝페이지로 가기 -->
									</div>
								</td>
							</tr>
							<tr>								
								<td height="19" align="right">
								<span id="btn_close">CLOSE</span></td>
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