<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>index.jsp</title>
<link rel="stylesheet" href="css/style.css" />
<style type="text/css">

	#container{
		width:1080px;
		margin: auto;
	}
	
	
	#payment_header{
		text-align: center;
	}
	
	div.payment_title{
		text-align: left;
		padding-top: 50px;
		padding-bottom: 10px;
		border-bottom: solid 1px #5F0080;
	}
	

	#tbl_1{
		border-bottom: solid 1px gray;
	}
	
	h2{
	    margin-bottom: 0;
	    font-size: 10px;
	    color: #808080;
	}
	
	tr, td{
		padding:10px;
	}
	
	th_info{
		text-align: center;
	}
	
	th{
		width: 200px;
		text-align: left;
	}
	
	div#show{
		padding:20px;	
	}
	
	div#costInfo{
		position:absolute;
	}
	
	div#costInfo_table{
		border: solid 1px #5F0080;
		padding: 10px;
	}
	
	
	

</style>
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.1/css/bootstrap.min.css">
<link rel="stylesheet" href="css/style.css" />
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
<script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.1/js/bootstrap.min.js"></script>
<script type="text/javascript" src="/ShoppingMall/js/jquery-3.3.1.min.js"></script>
<script type="text/javascript" src="/ShoppingMall/util/myutil.js"></script>
<script type="text/javascript">
	
	
	$(document).ready(function(){
		$("#productList").hide();

	
	});
	
	
	function detailShow(){
		$("div#show").hide();
		$("#productList").show();
	}
	
	
</script>
</head>
<body>
	
	<div class="container">
		<jsp:include page="include/header.jsp"></jsp:include>
		<div class="section" align="center">
			<div class="contents">
			
				<div id="payment_header">
					<h3>주문서</h3>
					<p>주문하실 상품명 및 수량을 정확하게 확인해 주세요</p>
				</div>
				
				
				<!-- 1 상품정보 -->						
				<div id="productInfo">
					<div class="payment_title"><h4>상품정보</h4></div>
					
					<div id="show" >상품을 주문합니다.<br/>
						<div onclick="detailShow()"><a id="detailClick" >상세보기<img src="https://res.kurly.com/pc/ico/1803/ico_arrow_open_28x16.png"/></a></div>
					</div>
					
					<table id="productList" class="table">
						<thead id="tbl_1">
							<tr id="th_info">
								<th class="productImg"></th>
								<th class="productInfo">상품 정보</th>
								<th>상품 금액</th>
							</tr>					
						</thead>
						<tbody>
							<tr>
								<td class="productImg"><img src = "http://www.thessan.com/m/product_detail.html?brand_uid=518748" /></td>
								<td class="productInfo">계란 웅앵</td>
								<td>1000원</td>
							</tr>
						</tbody>			
					</table>
				</div>
				
				
				
				<!-- 2 주문자정보 -->
				<div id="ordererInfo">
					<div class="payment_title"><h4>주문자 정보</h4></div>
					<table class = "table">
						<tr>
							<th>보내는분</th>
							<td><input value="나나" readonly></input></td>
						</tr>
						<tr>
							<th>휴대폰</th>
							<td>010</td>
						</tr>
						<tr>
							<th>이메일</th>
							<td>
								<span>hha_</span>
							</td>
						</tr>
						<tr>
							<th></th>
							<td colspan="2">
								<p>이메일을 통해 주문처리과정을 보내드립니다.<br/>정보 변경은 마이컬리>개인벙보 수정 메뉴에서 가능합니다.</p>
							</td>
						</tr>
					</table>
				</div>
	
	
	
	
				<!-- 3 배송정보 -->
				<div id="deliverInfo">
					<div class="payment_title"><h4 style="display: inline-block;">배송 정보</h4><p style="display: inline-block;">*정기 배송 휴무일:샛별배송(휴무없음),택배배송(일요일)</p></div>
					
					<table id="deliverInfo_table" class="table">
							<tr>
								<th>배송지 선택</th>
								<td>
									<label for="selectDelivery">
									<input type="radio" name="selectDelivery" id="selectDelivery" checked="checked"> 최근 배송지
									</label>
									<label for="selectDelivery2">
									<input type="radio" name="selectDelivery" id="selectDelivery2"> 새로운 배송지
									</label>
								</td>
							</tr>				
							<tr>
								<th>주소</th>
								<td>
									주소들어갈 위치
									<button style="display: none;">새 배송지 추가</button>									
								</td>
							</tr>
							
							<tr>
								<th>배송 구분</th>
								<td>
									<span id="adress">택배배송지역</span>
									<span class="deliver_guide" style="display: none;">
										샛별 배송 지역 중 아래 장소는 <strong>배송 불가 장소</strong>입니다.<br/>
										<strong>▶ 배송 불가 장소</strong> : 관공서/ 학교/ 병원/ 시장/ 공단 지역/ 산간 지역/ 백화점 등
									</span>
								</td>
							</tr>
																						
							<tr>
								<th>수령인 이름 *</th>
								<td>
									<input type="text" id="nameReceiver" name="nameReceiver" value="나나" required="required">
								</td>
							</tr>
							
							<tr>
								<th>휴대폰 *</th>
								<td>
									<input style="width:43px;" type="text" name="mobile" value="010" size="3" maxlength="3" required="required" >
										<span class="bar"><span>-</span></span>
									<input style="width:50px;" type="text" name="mobile" value="1234" size="4" maxlength="4" required="required">
										<span class="bar"><span>-</span></span>
									<input style="width:50px;" type="text" name="mobile" value="5678" size="4" maxlength="4" required="required" >
								</td>
							</tr>							
														
							<tr>
								<th>배송 요청사항</th>
								<td>
									<textarea id="deliveryMemo" name="deliveryMemo" maxlength="50"></textarea>
									<span class="num">0</span>자 / 50자
								</td>
							</tr>
																							
					</table>
					
				</div>	
				
				
				
					<!-- 4.결제수단 -->
					<div id="deliverInfo">
						<div class="payment_title"><h4>결제 수단</h4></div>
							<table class="table" >
								<tr>
									<th>일반결제</th>
									<td class="noline" style="position:relative">
										<label for="card" >
											<input type="radio" name="pay" id="card" checked="checked">신용카드</label>
										<label for="mobilePay">
											<input type="radio" name="pay" id="mobilePay">휴대폰</label>
									</td>
								</tr>
								
								<tr id="card_detail">
								<th></th>
									<td>
										<div id="cardSelect">
											<select name="card_list" class="list">
													<option disabled="disabled" value="">카드를 선택해주세요</option> 
													<option value="61">현대 (무이자)</option>
													<option value="41">신한</option>
													<option value="31">비씨</option>
													<option value="11">KB국민</option>
													<option value="51">삼성</option>
													<option value="71">롯데</option>
													<option value="91">NH채움</option>
													<option value="33">우리</option>
													<option value="62">신협체크</option>
													<option value="15">카카오뱅크</option></select>
										</div>
									</td>
								</tr>
								
								<tr>
									<th>PAYCO 결제</th>
									<td>
										<label for="payco">
											<input type="radio" name="pay" id="payco"><img src="https://static-bill.nhnent.com/payco/checkout/img/v2/btn_checkout2.png"/>									
										</label>
									</td>
								</tr>	
															
								<tr>
									<th>네이버페이 결제</th>
									<td>
										<label for="naverPay">
											<input type="radio" name="pay" id="naverPay"><img src="//res.kurly.com/pc/service/order/1710/ico_naverpay_v3.png"/>
										</label>
									</td>
								</tr>
								
								<tr>
									<td colspan="2">
										<p>※ 페이코, 네이버페이, 토스 결제는 결제 시 결제하신 수단으로만 환불되는 점 양해부탁드립니다.</p>
										<p>※ 보안강화로 Internet Explorer 8 미만 사용 시 결제창이 뜨지 않을 수 있습니다. </p>
									</td>								
								</tr>
								
							</table>
						</div>				
					</div>
				
				
				
				
					<!-- 5.결제금액 -->					
					<div id="costInfo">
						<div class="payment_title" style="border:none;"><h4>결제 금액</h4></div>		
						<div id="costInfo_table">		
							<table class="table">
								<tr>
									<th>상품 금액</th>
									<td>12,000 원</td>
								</tr>
								
								<tr>
									<th>상품 할인 금액</th>
									<td>0 원</td>
								</tr>
								
								<tr>
									<th>배송비</th>
									<td>3,000 원</td>
								</tr>
							
								<tr>
									<th>최종 결제 금액</th>
									<td>15,000 원</td>
								</tr>						
							</table>	
						</div>	
					</div>
	

			
		</div>
		
	</div>	
	<jsp:include page="include/footer.jsp"></jsp:include>
		
</body>
</html>