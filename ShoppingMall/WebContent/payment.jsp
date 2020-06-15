<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>결제페이지</title>
<link rel="stylesheet" href="css/style.css" />
<style type="text/css">

	div#container{
		width:1080px;
		margin: auto;
		font-family : "Noto Sans";
		
	}
	
	input{
		height:35px;
		vertical-align: middle;
		margin-right:10px;
		border: solid 1px #999999;
	}
	
	input[type=radio]{
		margin-right : 8px !important;
	}
	
	
	
	/* 주문서 */
	h3#header_order{
		margin-bottom : 15px;
		font-size : 35px;
    	font-weight : bold;
    	color : #333333; /* 블랙 */
	}
	
	div#payment_header{
		text-align: center;
		margin : 10px;
	    padding: 20px 0 14px;
	    font-size : 14px;
    	color: #999999;  /* 회색 */
	}
	
	
	
	
	/* 항목 타이틀 */
	div.payment_title{
		text-align: left;
		padding-top : 80px;
		padding-bottom : 10px;
		border-bottom: solid 1.5px #5F0080;  /* 보라색 */
		font-weight: bold;
		font-size: 15pt;
		color : #999999;
	}
	
	
	/* 테이블 전체 설정 */
	table{
		border-bottom: solid 1px #ddd;
		width : 100%;		
	}
	
	th, td{
		height : 50px;
		vertical-align: middle;	
		padding : 20px;
	}
	
	th{
		width: 200px;
		text-align: left;
		padding-left: 10px;
	}
	
	td.last_td{
		padding-bottom: 15px;
	}
	
	/* 상품정보 */
	div#show{
		padding:20px;	
		border-bottom: solid 1px #DDDDDD;
	}
	
	span#show{
		margin-bottom : 10px;
		display : block;
	}
	
	span#detailClick{
		cursor : pointer;
	}
	
	
	/* 상세보기 테이블 th*/
	tr#th_info{
		height: 60px;
		text-align: center;
		vertical-align: middle;
	}
	
	
	/* 상품 정보 테이블 */
	table#productList{
		width: 1080px;
		border-bottom: solid 1px #ddd;
	}	
	
	th.product_head{
		border-bottom : solid 1px #ddd;
		padding : 20px;
		text-align: center;
	}
	
	.product{
		height:150px;
		padding : 20px;
	}
		
	.productImg{
		width : 10%;
	}
	
	.productInfo{
		width : 75%;
	}
	
	.productPrice{
		width : 15%;
	}
	
	div#productInfo_name{
		font-weight: bolder;
		font-size: 12pt;
		margin-bottom : 10px;
	}
	
	
	/* 주문자 정보 */	
	input.peopleInfo{
		border : 0 none;
	}
	
	/* 배송 정보 */
	
	p#p_deliver{
		font-size : 12px;
    	color : #333333;
    	margin-left : 10px;
	}
	
	textarea#deliveryMemo{
		margin-top : 10px;
		width : 700px;
		height : 60px;
	}
	
	#btn_add {
	    display: block;
	    overflow: hidden;
	    width: 150px;
	    height: 42px;
	    margin-bottom: 22px;
	    border: 0 none;
	    border-radius: 3px;
	    background-color: #5f0080;
	    font-family: 'Noto Sans';
	    font-size: 14px;
	    color: #fff;
	    line-height: 18px;
	    text-align: center;
		vertical-align: middle;
	}
	
	input.input_address{
		display : block;
		margin-bottom: 10px;
		width : 700px;
	}
	
	span.input_address{
		display : block;
		margin: 10px 0 10px 0;
		width : 150px;
	}
	
	span#address_all{
		border: solid 1px red;
		height:25px;
		margin:0px;
		padding:0px;
		font-size : 12px;
		font-weight: bold;
    	color : #333333;
	}
	
	

	
	/* 결제 정보 */
	
	table#payment_table{
		width: 1080px;
		border-bottom: solid 1px #ddd;
	}	
	
	div#costInfo{
		position:absolute;
	}
	
	div#costInfo_div{
		border: solid 1px #5F0080;
		padding: 10px 20px 10px 20px;
		background-color:#F7F5F8;
	}
	
	table.payment_table{
		vertical-align: middle;
	}
	
	.list{
		height: 35px;
	}

	div#payment_notice{
		color:#333333;
		font-size:12px;
		padding :15px 0 15px 0;
	}
	
	.tbl_hr{
		height:2px;
	}
	
	.line{
		display: block;
	    height: 1px;
	    border: 0;
	    border-top: 1px solid #ddd;
    }
	
	

</style>
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.1/css/bootstrap.min.css">
<link rel="stylesheet" href="css/style.css" />
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
<script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.1/js/bootstrap.min.js"></script>
<script src="https://t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js"></script>
<script type="text/javascript" src="/ShoppingMall/js/jquery-3.3.1.min.js"></script>
<script type="text/javascript" src="/ShoppingMall/util/myutil.js"></script>
<script type="text/javascript">
	
	
	$(document).ready(function(){
		$("#productList").hide();

		
		
		$("#deliveryMemo").keyup(function(){
			var cntMemo = $("#deliveryMemo").val().length;
			$("#bytesMemo").val('');
			$("#bytesMemo").text(cntMemo);
		});
		
		
		//새배송지클릭
		$("input#selectDelivery2").click(function(){
			$(".address_default").hide();
			$("#btn_add").show();
		})
		
		//기존배송지클릭
		$("#selectDelivery").click(function(){
			$(".address_default").show();
			$("#btn_add").hide();
			$(".address_new").hide();
		})
		
		//배송지 상세주소 카운트
		var cntAddress = $("#address_default_sub").val().length;
		$("#bytesAddress").text(cntAddress);
		
		// 배송 주소 전부 입력
		var address_all = $("#address_default_main").val()+" "+$("#address_default_sub").val();
		$("#address_all").text(address_all);
			

		$("input#address_default_sub").keyup(function(){
			cntAddress = $("#address_default_sub").val().length;
			$("#bytesAddress").val('');
			$("#bytesAddress").text(cntAddress);
		});
		
		
		
		
		// 새배송지 상세주소 카운트
		var cntNewAddress = $("#address_new_sub").val().length;
		$("#bytesNewAddress").text(cntNewAddress);
		
		$("#address_new_sub").keyup(function(){
			var cntNewAddress2 = $("#address_new_sub").val().length;
			$("#bytesNewAddress").val('');
			$("#bytesNewAddress").text(cntMemo);
		});
		
		
		
		
		//일반결제선택
		$("input[type=radio]").click(function(){
			if($("#card").prop("checked")){
				$("#card_detail").css('display','');
			}else{
				$("#card_detail").css('display','none');
			}
		})
		
		
		
		
		
	
	});
	
	
	function detailShow(){
		$("div#show").hide();
		$("#productList").show();
	}
	
	
	function openPOST(){
		 new daum.Postcode({
	            oncomplete: function(data) {
	            	
	                var addr = ''; 
	                var extraAddr = '';

	                if (data.userSelectedType === 'R') {
	                    addr = data.roadAddress;
	                } else { 
	                    addr = data.jibunAddress;
	                }

	                if(data.userSelectedType === 'R'){
	                    if(data.bname !== '' && /[동|로|가]$/g.test(data.bname)){
	                        extraAddr += data.bname;
	                    }
	                    if(data.buildingName !== '' && data.apartment === 'Y'){
	                        extraAddr += (extraAddr !== '' ? ', ' + data.buildingName : data.buildingName);
	                    }
	                    if(extraAddr !== ''){
	                        extraAddr = ' (' + extraAddr + ')';
	                    }
	                    
	                    $("input#address_new_sub").show();
	                    $("input#address_new_main").val(extraAddr);
	                
	                } else {
	                	 $("input#address_new_sub").show();
		                 $("input#address_new_main").val('');	
		            }

	                // 우편번호와 주소 정보를 해당 필드에 넣는다.
					$("#address_new_postcode").show();
	                $("#address_new_postcode").val(data.zonecode);
	                $("#address_new_main").show();
                    $("#address_new_main").val(addr);
                    $(".address_new_bytes").show();
	                
	            }
	        }).open();
	}
	
	
	
	
</script>
</head>
<body>
	
	<div class="container">
		<jsp:include page="include/header.jsp"></jsp:include>
		<div class="section" align="center">
			<div class="contents">


				<!-- 0 주문서 -->						
				<div id="payment_header">
					<h3 id="header_order">주문서</h3>
					<p>주문하실 상품명 및 수량을 정확하게 확인해 주세요</p>
				</div>
				
				
				<!-- 1 상품정보 -->						
				<div id="productInfo">
					<div class="payment_title">상품정보</div>
					
					<div id="show" ><span id="show">상품을 주문합니다.</span>
						<div onclick="detailShow()">
							<span id="detailClick" >상세보기
								<img style="width:15px; margin-left:10px;" src="https://res.kurly.com/pc/ico/1803/ico_arrow_open_28x16.png"/>
							</span>
						</div>
					</div>
					
					<table id="productList">
						<thead>
							<tr id="th_info">
								<th class="product_head productImg"></th>
								<th class="product_head productInfo">상품 정보</th>
								<th class="product_head productPrice" >상품 금액</th>
							</tr>					
						</thead>
						<tbody>
							<tr>
								<td class="product productImg"><img style ="width: 100%" src="https://lh3.googleusercontent.com/proxy/JPUXyxKmTZ80Jtpsfx2m_Cq0aRp_XoZffwIrkVZ5X23xNnepSoBNPSE-oaZOZ-EvbQbRWDSz-lT80PXeY-6k-Jy86-CSi4g" /></td>
								<td class="product productInfo">
									<div id="productInfo_name">하리보</div>
									<div id="productInfo_cnt"><span>1</span><span>개 / 개당 </span><span>12,000</span><span>원</span></div>
								</td>
								<td class="product productInfo last_td productPrice">1,000원</td>
							</tr>
						</tbody>			
					</table>
				</div>
				
				
				
				<!-- 2 주문자정보 -->
				<div id="ordererInfo">
					<div class="payment_title">주문자 정보</div>
					<table id="ordererTable">
						<tr>
							<td colspan="2" style="height:10px"></td>
						</tr>
						<tr>
							<th class="table_th">보내는분</th>
							<td><input class=peopleInfo type = "text" value="나나" readonly></input></td>
						</tr>
						<tr>
							<th class="table_th">휴대폰</th>
							<td>
							<input class=peopleInfo style="width:43px;" type="text" name="mobileOrder" value="010" size="3" readonly>
								<span class="bar"><span>-</span></span>
							<input class=peopleInfo style="width:43px;" type="text" name="mobileOrder" value="1234" size="4" readonly>
								<span class="bar"><span>-</span></span>
							<input class=peopleInfo style="width:43px;" type="text" name="mobileOrder" value="5678" size="4" readonly>
						</tr>
						<tr>
							<th class="table_th">이메일</th>
							<td><input class=peopleInfo type = "text" value="nana@naver.com" readonly></input></td>
						</tr>
						<tr>
							<th class="table_th"></th>
							<td class="last_td" colspan="2">
								<p>이메일을 통해 주문처리과정을 보내드립니다.<br/>정보 변경은 마이컬리>개인벙보 수정 메뉴에서 가능합니다.</p>
							</td>
						</tr>
						<tr>
							<td colspan="2" style="height:10px"></td>
						</tr>
					</table>
				</div>
	
	

	
				<!-- 3 배송정보 -->
				<div id="deliverInfo">
					<div class="payment_title">배송 정보
						<p id="p_deliver" style="display: inline-block;">*정기 배송 휴무일:샛별배송(휴무없음),택배배송(일요일)</p>
					</div>
					
					<table id="deliverInfo_table">
							<tr>
								<td colspan="2" style="height:10px"></td>
							</tr>
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
									<div class="address_default">
										<div class="input_address" id="address_default_main">서울강남</div>
										<input class="input_address"id="address_default_sub" value="1234호" style="display:inline-block; margin-top:10px;">
										<span id="bytesAddress" style="display:inline-block;"></span>자 / 60자
										<span class="input_address" id="address_all"></span>										
									</div>			
									
									<button id="btn_add" style="display: none;" onclick="openPOST()">새 배송지 추가</button>	
										<div class="address_new">
											<input class="input_address" id="address_new_postcode" style="display: none;">
											<input class="input_address" id="address_new_main" style="display: none;">
											<input class="input_address" id="address_new_sub" style="display: none;">
											<div class="address_new_bytes" style="display: none;">
												<span id="bytesNewAddress" ></span>자 /60자
											</div>
										</div>
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
								<td class="last_td">
									<textarea id="deliveryMemo" name="deliveryMemo" maxlength="50"></textarea>
									<span id="bytesMemo">0</span>자 / 50자
								</td>
							</tr>
							<tr>
								<td colspan="2" style="height:10px"></td>
							</tr>
																							
					</table> 
					
				</div>	
				
				
				
					<!-- 4.결제수단 -->
					<div id="paymentInfo">
						<div class="payment_title"><h4>결제 수단</h4></div>
							<table class="payment_table" >
								<tr>
									<td colspan="2" style="height:10px"></td>
								</tr>
								<tr>
									<th>일반결제</th>
									<td class="noline" style="position:relative">
										<label for="card" >
											<input type="radio" name="pay" id="card" checked="checked">신용카드</label>
										<label for="mobilePay">
											<input type="radio" name="pay" id="mobilePay" style="margin-left:15px;">휴대폰</label>
									</td>
								</tr>
								
								<tr id="card_detail">
								<th></th>
									<td style="height:40px;">
										<div id="cardSelect" style="display:inline-block">
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
										<div id="installSelect" style="display:inline-block" style="margin-left:10px">
											<select name="install_list" class="list">
													<option disabled="disabled" value="">할부기간을 선택해주세요</option> 
													<option value="0">일시불</option>		
													<option value="3">3개월</option>													
											</select>		
										</div>
									</td>
								</tr>
								
								<tr>
									<th>스마일페이 결제</th>
									<td>
										<label for="smailPay">
											<input type="radio" name="pay" id="smailPay"><img src="//res.kurly.com/pc/service/order/1712/ico_smilepay_v2.png" height="18"/>
										</label>
									</td>
								</tr>
								
								<tr>
									<th>Paynow 결제</th>
									<td>
										<label for="Paynow">
											<input type="radio"  name="pay" id="Paynow"><img src="https://res.kurly.com/pc/service/order/1801/logo_paynow.png" height="18"/>									
										</label>
									</td>
								</tr>
								
								<tr>
									<th>PAYCO 결제</th>
									<td>
										<label for="payco">
											<input type="radio" name="pay" id="payco"><img src="https://static-bill.nhnent.com/payco/checkout/img/v2/btn_checkout2.png" height="18"/>									
										</label>
									</td>
								</tr>	
															
								<tr>
									<th>네이버페이 결제</th>
									<td>
										<label for="naverPay">
											<input type="radio" name="pay" id="naverPay"><img src="//res.kurly.com/pc/service/order/1710/ico_naverpay_v3.png" height="18"/>
										</label>
									</td>
								</tr>
								
								<tr>
									<th>토스 결제</th>
									<td>
										<label for="toss">
											<input type="radio" name="pay" id="toss"><img src="http://res.kurly.com/pc/service/order/1912/toss-logo-signature.svg" height="18"/>
										</label>
									</td>
								</tr>
								
								<tr>
									<th>CHAI 결제</th>
									<td>
										<label for="chai">
											<input type="radio" name="pay" id="chai"><img src="https://res.kurly.com/pc/service/order/2001/logo_chi_x2.png" height="18"/>
											<img src="https://res.kurly.com/pc/service/order/2005/bubble_chai.png" height="20" alt="첫결제 시 5천원 즉시할인, 5천원 캐시백" class="bubble">											
										</label>
									</td>
								</tr>
																			
								<tr>
									<td colspan="2">
										<div id="payment_notice">
											<p>※ 페이코, 네이버페이, 토스 결제는 결제 시 결제하신 수단으로만 환불되는 점 양해부탁드립니다.</p>
											<p>※ 보안강화로 Internet Explorer 8 미만 사용 시 결제창이 뜨지 않을 수 있습니다. </p>
										</div>
									</td>								
								</tr>
								<tr>
									<td colspan="2" style="height:10px"></td>
								</tr>
								
							</table>
						</div>				
					</div>
		
				
					<!-- 5.결제금액 -->					
					<div id="costInfo">
						<div class="payment_title" style="border:none;"><h4>결제 금액</h4></div>		
						<div id="costInfo_div">		
							<table id="costInfo_table" style="border:none;">
								<tr>
									<th>상품 금액</th>
									<td>12,000 원</td>
								</tr>								
								<tr style="height:2px;">
									<td colspan="2" style="height:2px;"><hr style="border-top:solid 1px black;"></td>
								</tr>																
								<tr>
									<th>상품 할인 금액</th>
									<td>0 원</td>
								</tr>
								
								<tr>
									<th>배송비</th>
									<td>3,000 원</td>
								</tr>
								<tr class="tbl_hr">
									<th><hr class="line"></th>
									<td><hr class="line"></td>
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