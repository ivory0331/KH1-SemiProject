<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<% String ctxPath = request.getContextPath(); %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %> 
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<link rel="stylesheet" href="<%= ctxPath %>/css/style.css" />
<title>장바구니</title>
<style type="text/css">
#container {
	max-width: 1080px;
	min-width: 1700px;
	border: solid 1px black;
}
#shoppingBasket {
	border-top: solid 2px #5F0080;
}
img.imgsmall {
	width: 60px;
	height: 70px;
	margin-left: 20px;
}
.j {
	margin-left: 20px;
}
.result {
	width: 1000px;
	height: 200px;
	padding: 50px;
	font-size: 15pt;
}
.t {
	border-right: solid 2px #d9d9d9;
	border-left: solid 2px #d9d9d9;
}
#jumun {
	font-size: 20pt;
	display: inline-block;
	margin: 50px;
}
.u {
	border-top: solid 2px #d9d9d9;
}
.d {
	border-bottom: solid 2px #d9d9d9;
}
#jumunBtn {
	background-color: #5F0080; 
	color: white;
}
.bottomList {
	color: #737373;
	font-weight: bold;
}
.longtd {
	border: solid 0px red;
	width: 120px;
}
</style>
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.1/css/bootstrap.min.css">
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
<script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.1/js/bootstrap.min.js"></script>
<script type="text/javascript" src="/ShoppingMall/js/jquery-3.3.1.min.js"></script>
<script type="text/javascript" src="/ShoppingMall/util/myutil.js"></script>
<script type="text/javascript" src="<%= ctxPath%>/jquery-ui-1.11.4.custom/jquery-ui.js"></script>
<link rel="stylesheet" href="//code.jquery.com/ui/1.12.1/themes/base/jquery-ui.css">
<%-- <link rel="stylesheet" href="/resources/demos/style.css"> --%>

<script type="text/javascript">

			  
	$(document).ready(function(){
		// 선택한 목록 테이블에 넣어주기
		
		$(".spinner").spinner({
			spin: function(event, ui) {
				if(ui.value > 100) {
					$(this).spinner("value", 100);
					return false;
				}
				else if(ui.value < 1) {
					$(this).spinner("value", 1);
					return false;
				}
			}
		
		});// end of $(".spinner").spinner({});-----------------
		
		// 체크박스 다 눌러지면 전체선택 체크박스 켜지도록
		$(".chkboxpnum").click(function(){
			
			var bFlag = false;
			$(".chkboxpnum").each(function(){
				var bChecked = $(this).prop("checked");
				if(!bChecked) {
					$("input:checkbox[class=allCheckOrNone]").prop("checked",false);
					bFlag = true;
					return false;
				}
			});
			
			if(!bFlag) {
				$("input:checkbox[class=allCheckOrNone]").prop("checked",true);
			}
			
		});
		
		// 전체선택 클릭하면 다 켜지도록
		$(document).on("click",".allCheckOrNone",function(){
			var bool = $(this).prop("checked");
			
			$("input:checkbox[class=chkboxpnum]").prop("checked", bool);
			$("input:checkbox[class=allCheckOrNone]").prop("checked", bool);
			
		}); 
		
		// 수량변경 하기 (수량 증가)
		$(".ui-icon-triangle-1-n").click(function(){
			
			var index = $(".ui-icon-triangle-1-n").index(this);
			var $tr = $(".cartTR").eq(index);
			var cartno = $tr.find(".basketNum").val();
			var oqty = $tr.find(".spinnerImgQty").val();
		//	alert("장바구니번호:"+cartno+", 주문량:"+oqty);
			func_edit(cartno, oqty);
		});
		
		// 수량변경 하기 (수량 감소)
		$(".ui-icon-triangle-1-s").click(function(){
			
			var index = $(".ui-icon-triangle-1-s").index(this);
			var $tr = $(".cartTR").eq(index);
			var cartno = $tr.find(".basketNum").val();
			var oqty = $tr.find(".spinnerImgQty").val();
		//	alert("장바구니번호:"+cartno+", 주문량:"+oqty);
			func_edit(cartno, oqty);
		});
		
		
		
	}); // end of $(document).ready(function(){})---------------------------------

	// 수량변경 함수
	function func_edit(cartno, oqty){
	

		$.ajax({
			url:"/ShoppingMall/product/cartEdit.do",
			type:"POST",
			data:{"cartno":cartno,
				  "oqty":oqty},
			dataType:"JSON",
			success:function(json){
				if(json.n == 1) {
					location.href= "<%= request.getContextPath()%>/${goBackURL}";
				}
			},
			error: function(request, status, error){
				alert("code: "+request.status+"\n"+"message: "+request.responseText+"\n"+"error: "+error);
			}
		})

			
	} // function func_edit(cartno, oqty)---------------------------------------------------------------------
	
	// 장바구니 카테고리에 선택 물품 삭제
	function goDel(cartno){
		console.log("ddd");
		var $target = $(event.target);
		var pname = $target.parent().parent().find(".cart_pname").text();
		
		var bool = confirm(pname+"을 장바구니에서 제거하시는 것이 맞습니까?");
		
		if(bool) {
			
			$.ajax({
				url:"/ShoppingMall/product/cartDel.do",
				type:"POST",
				data:{"cartno":cartno},
				dataType:"JSON",
				success:function(json){
					if(json.n == 1) { // 특정 제품을 장바구니에서 비운후 페이지이동을 해야 하는데 이동할 페이지는 페이징 처리하여 보고 있던 그 페이지로 가도록 한다. 
						location.href= "<%= request.getContextPath()%>/${goBackURL}";
					}
				},
				error: function(request, status, error){
					alert("code: "+request.status+"\n"+"message: "+request.responseText+"\n"+"error: "+error);
				}
			});
			
		}
		else {
			alert("장바구니에서 "+pname+" 제품 삭제를 취소하셨습니다.");
		}
		
	} // end of function goDel()----------------------------------------------------------------------------
	
	
	// 선택 삭제 버튼을 눌렀을때 체크박스에 선택된 것이 있다면 삭제 시키기 
 	function cancelProduct(){
		// 체크박스에 체크된것이 있는지 확인
		var bCkecked = false;
		var cartListArr = ('${cartList}').split(",");
		
		for(var i=0; i<cartListArr.length; i++){
			
			bCkecked = document.getElementById('product_cknum'+[i]+'').checked;
			// 체크가 되어있다면 true로 나옴
			if(bCkecked) { 
				var cartno = $("#product_cknum"+[i]+"").parent().find("#product_num"+[i]+"").val();
				var pname = $("#product_cknum"+[i]+"").parent().parent().find(".cart_pname").text();
				
				var bool = confirm(pname+"을 장바구니에서 제거하시는 것이 맞습니까?");
				
				if(bool) {
					
					$.ajax({
						url:"/ShoppingMall/product/cartDel.do",
						type:"POST",
						data:{"cartno":cartno},
						dataType:"JSON",
						success:function(json){
							if(json.n == 1) { // 특정 제품을 장바구니에서 비운후 페이지이동을 해야 하는데 이동할 페이지는 페이징 처리하여 보고 있던 그 페이지로 가도록 한다. 
								location.href= "<%= request.getContextPath()%>/${goBackURL}";
							}
						},
						error: function(request, status, error){
							alert("code: "+request.status+"\n"+"message: "+request.responseText+"\n"+"error: "+error);
						}
					});
					
				}
				else {
					alert("장바구니에서 "+pname+" 제품 삭제를 취소하셨습니다.");
				}
			}
		}
		
		
	} // function cancelProduct()---------------------------------------------------------------------------
	
	function order(){
		var frm = document.frmData;
		frm.action="<%=ctxPath%>/payment.do";
		frm.method="post";
		frm.submit();
	}
	
	
</script>
</head>
<body>
<div class="Mycontainer">
<jsp:include page="../include/header.jsp"></jsp:include>
		<div class="section" align="center">
			<div class="contents">
			
			<h1 style="font-weight : bold; margin-top: 50px;">장바구니</h1>
			<h5 style="margin-bottom: 30px;">주문하실 상품명 및 수량을 정확하게 확인해 주세요.</h5>
		
			<form name="frmData">
				<table id="shoppingBasket" class="table">
				<tr align="center" class="bottomList" >
					<td class="td1" align="left">
						<input type="checkbox" class="allCheckOrNone" id="all2" /><label for="all2" class="j">전체 선택</label>
					</td>
					<td>
						제품이미지
					</td>
					<td>
						제품정보
					</td>
					<td>
						수량
					</td>
					<td align="left">
						상품금액
					</td>
					<td>
						삭제
					</td>
				</tr>
				
				<tbody>
					<c:if test="${empty cartList}">
						<tr>
							<td colspan="6">
								<span style="color: red; font-weight: bold;">
									장바구니에 담긴 상품이 없습니다.
								</span>
							</td>
						</tr>
					</c:if>
					<c:if test="${not empty cartList}">
						
						<c:forEach var="cartvo" items="${cartList}" varStatus="status">
						<tr class="cartTR">
							<td class="longtd"> <%--체크박스 및 제품번호 --%>
							 	<input type="checkbox" name="product_num" class="chkboxpnum" id="product_cknum${status.index}" value="${cartvo.product_num}" />
							 	<input type="hidden" class="basketNum" name="product_num" id="product_num${status.index}" value="${cartvo.basket_num}" />
							</td>
							<td align="center"> <%-- 제품이미지 --%>
								<a href='/ShoppingMall/detail.do?product_num=${cartvo.product_num}'>

									<img src="/ShoppingMall/images/${cartvo.prod.representative_img}" width="60px" height="80px" />
									<input type="hidden" name="product_img" value="${cartvo.prod.representative_img}"/>
								</a>
							</td>
							<td align="center"> <%-- 제품정보 --%>
								<span style="font-weight: bold;" class="cart_pname">${cartvo.prod.product_name}</span>
								<c:if test="${cartvo.prod.sale != 0}">
									<br/><span style="text-decoration: line-through;"><fmt:formatNumber value="${cartvo.prod.price}" pattern="###,###"/> 원</span>
									&nbsp;=>&nbsp;<fmt:formatNumber value="${cartvo.prod.finalPrice}" pattern="###,###" /> 원
								</c:if>
								<c:if test="${cartvo.prod.sale == 0}">
									<br/><fmt:formatNumber value="${cartvo.prod.price}" pattern="###,###"/> 원
								</c:if>
							</td>
							<td align="center"> <%-- 수량 --%>
								<input class="spinner spinnerImgQty" name="product_count" value="${cartvo.product_count}" style="width: 30px; height: 20px;">개
							</td>
							<td> <%--총 제품가격 --%>
							<span id="totalPrice">
								<fmt:formatNumber value="${cartvo.prod.totalPrice}" pattern="###,###" />
							</span> 원
							<input class="totalPrice" type="hidden" name="product_totalPrice" value="${cartvo.prod.totalPrice}" />
							
							</td>
							<td align="center"> <%-- 장바구니에서 해당 제품 삭제하기 --%>
								<span class="del" style="cursor: pointer;" onClick="goDel('${cartvo.basket_num}');">X</span>
							</td>
						</tr>
						</c:forEach>
						
					</c:if>
				</tbody>
				
				<tr>
					<td>
						<input type="checkbox" class="allCheckOrNone" id="all1"/><label for="all1" class="j" style="color : #737373;">전체 선택</label>
					</td>
					<td>
						<input type="button" class="selectDel" onClick="cancelProduct();" value="선택 삭제"/>
					</td> 
				</tr>
				</table>
				<table class="result">
					<tr align="center">
						<td class="t u">
							상품금액
						</td>
						<td rowspan="2" class="t">+</td>
						<td class="t u">
							배송비
						</td>
						<td rowspan="2" class="t">=</td>
						<td class="t u">
							결제예정금액
						</td>
					</tr>
					<tr align="center">
						<td id="price" class="t d">
							<span style="font-weight: bold;"><fmt:formatNumber value="${sumMap.SUMTOTALPRICE}" pattern="###,###" /> 원</span>
						</td>
						<td id="delivery" class="t d">
							<label>3,000원</label>
						</td>
						<td id="totalPrice" class="t d">
							<span style="color: purple; font-weight: bold;"><fmt:formatNumber value="${sumMap.SUMTOTALPRICE+3000}" pattern="###,###" /> 원</span>
						</td>
					</tr>
				</table>
				<span id="jumun">
					<input type="button" id="jumunBtn" value="주문하기" onClick="order()"/>
				</span>
			</form>
		</div>
		<jsp:include page="../include/footer.jsp"></jsp:include>
	</div>
</div>
</body>
</html>