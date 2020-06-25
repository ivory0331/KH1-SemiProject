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
	border-top: solid 2px purple;
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
	background-color: purple; 
	color: white;
}
</style>
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.1/css/bootstrap.min.css">
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
<script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.1/js/bootstrap.min.js"></script>
<script type="text/javascript" src="/ShoppingMall/js/jquery-3.3.1.min.js"></script>
<script type="text/javascript" src="/ShoppingMall/util/myutil.js"></script>
<script type="text/javascript">

	var arrFood = [{name:"루비 싱글 바 (3,600원)",filename:"iscream.png",price:"3600"}
				  ,{name:"병 샐러드 (6,200원)",filename:"salad.png",price:"6200"}
				  ,{name:"동물복지 우유 (2,650원)",filename:"milk.png",price:"2650"}];
			  
	$(document).ready(function(){
		// 선택한 목록 테이블에 넣어주기
		
		var html = "";
		for(var i=0; i<arrFood.length; i++) {
			html += "<tr id='deleteFood"+[i]+"'> <td>"+
						"<input type='checkbox' class='singleCheck' id='food"+[i]+"' onClick='choiceFood()' ></input>"+
							"<img class='imgsmall' src='images/"+arrFood[i].filename+"'/>"+
						"</td> <td>"+
							"<label>"+arrFood[i].name+"</label>"+
						"</td> <td>"+
							"<input type='number' class='foodOrdercnt' name='foodOrdercnt' min='1' max='99' step='1' value='1' required onchange='choiceCnt()' />"+
						"</td> <td>"+
							"<label class='cost'>"+arrFood[i].price+"</label>"+
						"</td> </tr> ";
		}
		$("#basket").html(html);
		
		// 전체 다 체크된 상태로 시작
		$("input:checkbox[class=singleCheck]").prop("checked", true);
		$("input:checkbox[class=allCheck]").prop("checked", true);
		choiceFood();
		
		
		// == 체크박스 전체선택/ 전체해제 == //
		$(document).on("click",".allCheck",function(){
			var bool = $(this).prop("checked");
			
			$("input:checkbox[class=singleCheck]").prop("checked", bool);
			$("input:checkbox[class=allCheck]").prop("checked", bool);
			
			choiceFood();
		}); 
		
		
		// == 체크박스 전체선택 / 전체해제 에서
	    //    하위 체크박스에 체크가 1개라도 체크가 해제되면 체크박스 전체선택/전체해제 체크박스도 체크가 해제되고
	    //    하위 체크박스에 체크가 모두 체크가 되어지지면  체크박스 전체선택/전체해제 체크박스도 체크가 되어지도록 하는 것 == //
		$(document).on("click",".singleCheck",function(){  
			var bFlag = false;
			
			$("input:checkbox[class=singleCheck]").each(function(){
				var bool = $(this).prop("checked");
				if(!bool) {
					$("input:checkbox[class=allCheck]").prop("checked", false);
					bFlag = true;
					return false; //continue;
				}
			});
			 if(!bFlag)
				 $("input:checkbox[class=allCheck]").prop("checked", true); 
		}); 
		
	}); // end of $(document).ready(function(){})---------------------------------

	
	// 가격 표시하기
	var arrCost = document.getElementsByClassName("cost");
	var arrFoodOrdercnt = document.getElementsByClassName("foodOrdercnt");
		
	function choiceCnt() {
		
		var sumCost = 0;
		var cnt = 0;
		var price = 0;
		
		for(var i=0; i<arrCost.length; i++){
			var bChecked = document.getElementById('food'+[i]+'').checked;

				if(arrFoodOrdercnt[i].value != "1") {
				 	cnt = Number( arrFoodOrdercnt[i].value );
				 	price = Number ( arrFood[i].price );
				 	
					sumCost = cnt*price;
					
					arrCost[i].innerText = sumCost;
				}
				else {
					arrCost[i].innerText = arrFood[i].price;
				}
				choiceFood();
		}
	}

	
	function choiceFood() {
	
		// 상품금액에 합산금액 나타내기
		var arrCost = document.getElementsByClassName("cost");
		var totalSum = 0;
		
		for(var i=0; i<arrFood.length; i++) {
			
			/*  var bChecked = document.getElementById('food'+[i]+'').checked;
			
			if(bChecked) {
				totalSum += Number( arrCost[i].innerText );
			}  */
			
		}
		
		var to = "<label>"+totalSum+"원</label>";
		
		$("#price").html(to);
		
		// 합산금액과 배송비합친 결제예정금액 나타내기
		var arrCost = document.getElementsByClassName("cost");
		var totalSum = 0;
		
		for(var i=0; i<arrFood.length; i++) {
			/* var bChecked = document.getElementById('food'+[i]+'').checked; */
			
			/* if(bChecked) {
				totalSum += Number( arrCost[i].innerText );
			} */
			
		}
		if(totalSum != 0) {
			totalSum = totalSum + 3000;
			
			var del = "<label>3000원</label>";
			
			$("#delivery").html(del);
		} else {
			var del = "<label>0원</label>";
			
			$("#delivery").html(del);	
		}
		
		var total = "<label>"+totalSum+"원</label>";
		
		$("#totalPrice").html(total);

	}
	
	// 상품 삭제하기
	function cancelProduct() {
		
		for(var i=0; i<arrFood.length; i++) {
			
			var bChecked = document.getElementById('food'+[i]+'').checked;
			
			if(bChecked) {
				alert("["+arrFood[i].name+"] 상품을 삭제하기를 누르셨습니다");
				$("#deleteFood"+[i]+"").hide();
				$('#food'+[i]+'').prop("checked", false);
				choiceFood();
			}
		}
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
				<tr>
					<td class="td1">
						<input type="checkbox" class="allCheck"/><label class="j">전체 선택</label>
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
					<td>
						상품금액
					</td>
					<td>
						삭제
					</td>
				</tr>
				
				<tbody>
					<c:if test="${empty cartList}">
						<tr>
							<td colsapn="6">
								<span style="color: red; font-weight: bold;">
									장바구니에 담긴 상품이 없습니다.
								</span>
							</td>
						</tr>
					</c:if>
					<c:if test="${not empty cartList}">
						
						<c:forEach var="cartvo" items="${cartList}" varStatus="status">
						<tr>
							<td> <%--체크박스 및 제품번호 --%>
							 	<input type="checkbox" name="product_num" class="chkboxnum" id="product_num${status.index}" value="${cartvo.product_num}" /> &nbsp;<label for="product_num${status.index}">${cartvo.product_num}</label>
							</td>
							<td align="center"> <%-- 제품이미지 --%>
								<a href='/ShoppingMall/detail.do?product_num=${cartvo.product_num}'>
									<img src="<%=ctxPath%>/images/${cartvo.prod.product_name}" width="130px" height="100px" />
								</a>
							</td>
							<td align="center"> <%-- 제품정보 --%>
								<span>${cartvo.prod.product_name}</span>
							</td>
							<td align="center"> <%-- 수량 --%>
								<input name="product_count" value="${cartvo.product_count}">개
							</td>
							<td> <%--총 제품가격 --%>
							<span id="totalPrice">
								<fmt:formatNumber value="${cartvo.prod.totalPrice}" pattern="###,###" />
							</span> 원
							<input class="totalPrice" type="hidden" value="${cartvo.prod.totalPrice}" />
							</td>
							<td align="center"> <%-- 장바구니에서 해당 제품 삭제하기 --%>
								<span class="del" style="cursor: pointer;" onClick="">X</span>
							</td>
						</tr>
						</c:forEach>
						
					</c:if>
				</tbody>
				
				<tr>
					<td>
						<input type="checkbox" class="allCheck"/><label class="j">전체 선택</label>
						<input type="button" onClick="cancelProduct();" value="선택 삭제"/>
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
							<span style="color: red; font-weight: bold;"><fmt:formatNumber value="${sumMap.SUMTOTALPRICE}" pattern="###,###" /> 원</span>
						</td>
						<td id="delivery" class="t d">
							<label>0원</label>
						</td>
						<td id="totalPrice" class="t d">
							<label>0원</label>
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