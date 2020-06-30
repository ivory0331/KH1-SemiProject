<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<% String ctxPath = request.getContextPath(); %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>주문조회</title>

<link rel="stylesheet" href="<%= ctxPath %>/css/style.css" />
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
td {
	height: 100%;
	valign: top;
	border: 10px solid #fff
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
											<tr height="25" align="center">
												<td>1553018031241</td>
												<td>19-03-20</td>
												<td>[매일] 소화가 잘되는.. 외 1건</td>
												<td align="right">2 개</td>
												<td align="right">13,050 원</td>
												<td><input type="radio" name="ordernoSelect"
													onclick="parent.order_put('1553018031241')"></td>
											</tr>
											<tr>
												<td colspan="6" height="1" bgcolor="E5E5E5"></td>
											</tr>
											<tr bgcolor="#f7f7f7" height="25" align="center">
												<td>1553016101806</td>
												<td>19-03-20</td>
												<td>[멘즈앤가서] 無설탕 .. 외 8건</td>
												<td align="right">10 개</td>
												<td align="right">34,045 원</td>
												<td><input type="radio" name="ordernoSelect"
													onclick="parent.order_put('1553016101806')"></td>
											</tr>
											<tr>
												<td colspan="6" height="1" bgcolor="E5E5E5"></td>
											</tr>
											<tr height="25" align="center">
												<td>1536077455128</td>
												<td>18-09-05</td>
												<td>[두손드림] 마시는 죽.. 외 3건</td>
												<td align="right">4 개</td>
												<td align="right">26,840 원</td>
												<td><input type="radio" name="ordernoSelect"
													onclick="parent.order_put('1536077455128')"></td>
											</tr>
											<tr>
												<td colspan="6" height="1" bgcolor="E5E5E5"></td>
											</tr>
											<tr bgcolor="#f7f7f7" height="25" align="center">
												<td>1535453512517</td>
												<td>18-08-28</td>
												<td>유기농 베이비 채소 외 4건</td>
												<td align="right">5 개</td>
												<td align="right">26,910 원</td>
												<td><input type="radio" name="ordernoSelect"
													onclick="parent.order_put('1535453512517')"></td>
											</tr>
											<tr>
												<td colspan="6" height="1" bgcolor="E5E5E5"></td>
											</tr>
										</tbody>
									</table>
									
								</td>
							</tr>
							<tr>
								<td height="19" align="right"><a href="javascript:parent.order_close()" onfocus="blur()">
								<img src="/shop/data/skin/designgj/img/common/popup_close.gif"></a></td>
							</tr>
						</tbody>
					</table>
				</td>
			</tr>
		</tbody>
	</table>
	<script>
	parent.$('#ifm_order').height($('#orderList').outerHeight());
</script>
</div>
</body>
</html>