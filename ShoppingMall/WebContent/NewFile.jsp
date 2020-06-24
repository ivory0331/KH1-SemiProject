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
		font-family : noto sans, sans-serif, malgun gothic;
	}
	
	input{
		height:35px;
		vertical-align: middle;
		margin-right:10px;
		padding-left:7px;
		border: solid 1px #949296; /* 회색 */
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
	
	
	div#header_div{
		text-align: center;
		margin : 10px; 
	    padding: 20px 0 20px;
	    font-size : 14px;
    	color: #999999;  /* 회색 */
	}			
	
	/* 항목 타이틀 */
	div.payment_title{
		display:block;
		width:100%;
		text-align: left;
		padding-top : 80px;
		padding-bottom : 14px;
		border-bottom: solid 1.5px #5F0080;  /* 보라색 */
		font-weight: 700;
		font-size: 15pt;
		color : #808080;
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
	
	.input_address{
		display : block;
		margin-top: 10px;
		width : 700px;
		height: 35px;
	}
	
	div.input_address{
		margin-right:10px;
		padding:5px;		
		padding-left:5px;
		border: solid 1px #949296; /* 회색 */
		width : 700px;
		height: 35px;
		cursor:pointer;
	}
	
	div#address_default_main_list{
		position:absolute;
		margin:0;
		width : 700px;
		background-color: #ffffff;
		border-top: none;
	}
	
	#addressMain{
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
		width:700px;
		height:25px;
		margin:10px 0 0 0;
		padding:0px;
		font-size : 12px;
		font-weight: bold;
    	color : #333333;
	}
	
	div.address_new{
		margin-bottom: 10px;
	}
	
	
	/* 결제 정보 */
	div#paymentInfo{
		width:100%;		
	}
	
	div#paymentTable_div{
		display:inline-block;
		width:70%;
		height:100%;
		float:left;
	}	
	
	table#payment_table{
		width: 100%;
		border-bottom: solid 1px #ddd;
	}	
			
	div#costInfo{
		display:inline-block;
		width:25%;
		float:right;
	}		
	
	div#costInfo_div{
		position:fixed;
		border: solid 1px #5F0080;
		padding: 10px 20px 10px 20px;
		background-color:#F7F5F8;
	}
	
	#costInfo_div.on{
		position:absolute;
	}
	
	
	table.payment_table{
		vertical-align: middle;
	}
	
	#address_default_main_option{
		height:25px;
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
    
    
    /* 결제 버튼 */
	#btn_payment{
		width: 200px;
		height: 48px;
    	background-color: #5f0080;
	    color: #fff;
	}       
	
	
	/* 개인 정보 동의 */
	#agreeInfo{
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
	
	var productArr = [{img:'하리보.jpg',name:'하리보', cnt:'2', price:'12000'}
					,{img:'탄탄멘.PNG',name:'탄탄멘', cnt:'1', price:'7000'}];


	$(document).ready(function(){
		//처음 상품 리스트 숨기기
		$("#productList").hide();	
		
		var name = $("#receiverName").val();
		var mobile = $(".receiverMobile").val();


		//상품 리스트
		var html='';
		for(var i=0; i<productArr.length; i++){
			var price = productArr[i].price;
			var cnt = productArr[i].cnt;
			var priceall=String(price*cnt);
			html+="<tr style='border-bottom:solid 1px #ddd'>"
				+	"<td class='product productImg'><img style ='width: 100%' src='images/"+productArr[i].img+"' /></td>"
				+ 	"<td class='product productInfo'>"
				+		"<div id='productInfo_name'>"+productArr[i].name+"</div>"
				+		"<div id='productInfo_cnt'><span>"+productArr[i].cnt+"</span><span>개 / 개당 </span><span>"+func_comma(price)+"</span><span>원</span></div>"
				+	"</td>"
				+	"<td class='product productInfo last_td productPrice'><span>"+func_comma(priceall)+"</span><span>원</span></td>"
				+ "</tr>";
				
			$("#productList_body").html(html);
		}
		
		
		
		//배송 메모 입력
		$("#deliveryMemo").keyup(function(){
			var cntMemo = $("#deliveryMemo").val().length;
			$("#bytesMemo").val('');
			$("#bytesMemo").text(cntMemo);
		});
		
		
		
		//새배송지클릭
		$("input#selectDelivery2").click(function(){
			$(".address_default").hide();
			$("#btn_add").show();
			$("#receiverName").val('');
			$(".receiverMobile").val('');
			$("#deliveryMemo").val('');
			$("#deliver_guide").show();
			$("#deliver_info").show();		
			if($("#address_new_postcode").val()!=null){
				$(".address_new").css('display','');			
			}
		})
		
		
		//기존배송지클릭
		$("#selectDelivery").click(function(){
			$(".address_default").show();
			$("#btn_add").hide();
			$(".address_new").hide();
			$("#deliver_guide").hide();
			$("#receiverName").val(name);
			$(".receiverMobile").val(mobile);
		})
		
		
		// 기존배송지 리스트
		var bool = false;
		$("div#address_default_main").click(function(){
			
			if(!bool){
				$("div#address_default_main_list").show();
				$("div#address_default_main_list").mouseover(function(){
					$("div#address_default_main_list").css('background-color','#f2f2f2');			
				});
				bool = true;		
				if(bool){
					$("div#address_default_main_list").mouseout(function(){
						$("div#address_default_main_list").css('background-color','#ffffff');		
						$("div#address_default_main_list").hide();			
						bool = false;
					});
				}
				
				
				

			}else{
				$("div#address_default_main_list").hide();
				bool = false;
			}
			
		});
		
		
		
		
		
		
		
		
		
		//배송지 상세주소 카운트
		var cntAddress = $("#address_default_sub").val().length;
		$("#bytesAddress").text(cntAddress);
		
		// 배송 주소 전부 입력
		var address_all = $("#address_default_main").text()+" "+$("#address_default_sub").val();
		$("#address_all").text(address_all);
			
		//배송지 상세주소 재입력 카운트
		$("input#address_default_sub").keyup(function(){
			cntAddress = $("#address_default_sub").val().length;
			$("#bytesAddress").val('');
			$("#bytesAddress").text(cntAddress);
			address_all = $("#address_default_main").text()+" "+$("#address_default_sub").val();
			$("#address_all").text(address_all);
		});
		
				
		
		// 새배송지 상세주소 카운트
		var cntNewAddress = $("#address_new_sub").val().length;
		$("#bytesNewAddress").text(cntNewAddress);
		
		$("#address_new_sub").keyup(function(){
			cntNewAddress = $("#address_new_sub").val().length;
			$("#bytesNewAddress").val('');
			$("#bytesNewAddress").text(cntNewAddress);
		});
		

		//일반결제 선택시 카드/할부 선택
		$("input[type=radio]").click(function(){
			if($("#card").prop('checked')){
				$("#card_detail").css('display','');
			}else{
				$("#card_detail").css('display','none');

			}
		});
				
		
		
		
		
		//플로팅
		
		
		
		
		/* $(function() {

			  $("#cosInfo").on('scroll', function() {

			    footerHei = $('footer').outerHeight(),

			    var sT = $("#costInfo").scrollTop();
			    var val = $(document).height() - $w.height() - footerHei;

			    if (sT >= val)
			        $("#costInfo_div").addClass('on')
			    else
			    	#("#costInfo_div").removeClass('on')
			    
			  });


		});
 */
		
		
		
		
		
		
		
		
		
		
	});
	
	
	//상품 상세정보 보이기
	function detailShow(){
		$("div#show").hide();
		$("#productList").show();
	}
	
	
	//주소
	function openPOST(){
		 new daum.Postcode({
	            oncomplete: function(data) {
	            	
                    $("div.address_new").show();                    

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
	                    
	                //    $("div#address_new").show();
	                    $("input#address_new_main").val(extraAddr);
	                
	                } else {
	                //    $("div#address_new").show();
		                $("input#address_new_main").val('');	
		            }

	                // 우편번호와 주소 정보를 해당 필드에 넣는다.
			//		$("#address_new_postcode").show();
	                $("#address_new_postcode").val(data.zonecode);
	        //        $("#address_new_main").show();
                    $("#address_new_main").val(addr);
            //        $(".address_new_bytes").show();
	                
	            }
	        }).open();
			$("div.address_new").css('display','');		 
		 	
	};
		
	
	function go_complete(){	

		//약관 동의
		if(!($("input:checkbox[id=agreeCheck]").prop('checked'))){
			alert('약관에 동의해주세요.');			
			return;
	 	}	 		
	
		var frm = document.frm_payment;
		frm.action = 'register.do';
		frm.method = 'post';
		frm.submit();
		
	};
	
	
	
	
</script>
</head>
<body>
	
	<div class="container">
		<%-- <jsp:include page="include/header.jsp"></jsp:include> --%>
		<div class="section" align="center">
			<div class="contents">

				<form name="frm_payment" action = 'market.html' method='post'>
					<!-- 0 주문서 -->						
					<div id="header_div">
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
							<tbody id="productList_body">
								
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
								<td class="last_td" colspan="2" style="padding:5px;">
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
							<p id="p_deliver" style="display: inline-block; margin:0 20px 0;">*정기 배송 휴무일:샛별배송(<span style="color:red">휴무없음</span>),택배배송(<span style="color:red">일요일</span>)</p>
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
											<div class="input_address" id="address_default_main">(기본)서울 강남
												<img src="images/dropdown.png" style="height:15px; float:right; margin-top: 5px;"/>
											</div>
											<div class="input_address" id="address_default_main_list" style="display:none;">(기본)서울 강남</div>
											<input class="input_address"id="address_default_sub" value="1234호" style="display:inline-block;">
											<span id="bytesAddress" style="display:inline-block;"></span>자 / 60자
											<span class="input_address" id="address_all"></span>										
										</div>			
										
										<button type="button" id="btn_add" style="display: none;" onclick="openPOST()">새 배송지 추가</button>	
											<div class="address_new" style="display: none;">
												<input class="input_address" id="address_new_postcode">
												<input class="input_address" id="address_new_main">
												<input class="input_address" id="address_new_sub" style="display:inline-block;">
												<div class="address_new_bytes" style="display:inline-block;">
													<span id="bytesNewAddress"></span>자 /60자
												</div>
											</div>
									</td>
								</tr>
								
								<tr>
									<th>배송 구분</th>
									<td>
										<span id="deliver_info">샛별배송지역</span>
										<span id="deliver_guide" style="display: none;">
											샛별 배송 지역 중 아래 장소는 <strong>배송 불가 장소</strong>입니다.<br/>
											<strong>▶ 배송 불가 장소</strong> : 관공서/ 학교/ 병원/ 시장/ 공단 지역/ 산간 지역/ 백화점 등
										</span>
									</td>
								</tr>
																							
								<tr>
									<th>수령인 이름 *</th>
									<td>
										<input type="text" id="receiverName" name="nameReceiver" value="나나" required="required">
									</td>
								</tr>
								
								<tr>
									<th>휴대폰 *</th>
									<td>
										<input class="receiverMobile" style="width:42px;" type="text" name="mobile" value="010" size="3" maxlength="3" required="required" >
											<span class="bar"><span>-</span></span>
										<input class="receiverMobile" style="width:48px;" type="text" name="mobile" value="1234" size="4" maxlength="4" required="required">
											<span class="bar"><span>-</span></span>
										<input class="receiverMobile" style="width:48px;" type="text" name="mobile" value="5678" size="4" maxlength="4" required="required" >
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
					
					
					<div id="paymentInfo">
					
						<!-- 4.결제수단 -->
						<div id="paymentTable_div">
							<div class="payment_title">결제 수단</div>
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
						
						<!-- 5.결제금액 -->					
						<div id="costInfo">
							<div class="payment_title" style="border:none;">결제 금액</div>		
							<div id="costInfo_div">		
								<table id="costInfo_table" style="border:none;">
									<tr>
										<th style="width:120px;">상품 금액</th>
										<td style="text-align: right;">12,000 원</td>
									</tr>								
									<tr>
										<td colspan="2" style="height:2px;"><hr style="border-top:solid 1px #ddd; margin: -5px 0;"></td>
									</tr>																
									<tr>
										<th style="width:120px;">상품 할인 금액</th>
										<td style="text-align: right;">0 원</td>
									</tr>
									
									<tr>
										<th style="width:120px;">배송비</th>
										<td style="text-align: right;">3,000 원</td>
									</tr>
									<tr>
										<td colspan="2" style="height:2px;"><hr style="border-top:solid 1px #ddd; margin: -5px 0;"></td>
									</tr>						
									<tr>
										<th style="width:120px;">최종 결제 금액</th>
										<td style="text-align: right;">15,000 원</td>
									</tr>						
								</table>	
							</div>	
						</div>
											
					</div>	
					
					
					
					<div style="clear:both;"></div>
					
					<!-- 6.개인정보수집제공 -->					
					<div id="agreeInfo">
						<div id="agreeInfo_div">	
							<div class="payment_title">개인정보 수집/제공</div>						
							<table id="agreeInfo_table" style="border:none;">
								<tr>
									<td colspan="2" style="height:10px"></td>
								</tr>
								<tr>
									<td style="height:25px;">
										<label for="agreeCheck" style="margin:0;">	
										<input type="checkbox" name="agreeCheck" id="agreeCheck" style="margin:0 5px 0 0; "> 결제 진행 필수 동의</label>	
									</td>
								</tr>
								
								<tr>
									<td style="height:25px;">
										<span style="padding-left:22px; margin:0;">개인정보 수집·이용 동의<span class="agree_sub">(필수)</span></span><a class="agreeLink"> 약관확인</a>	
									</td>
								</tr>
								<tr>
									<td style="height:25px;">
										<span style="padding-left:22px;">결제대행 서비스 약관 동의<span class="agree_sub">(필수)</span></span>	<a class="agreeLink"> 약관확인</a>	
									</td>
								</tr>							
							</table>	
						</div>	
					</div>
					
					
					
					
					<!-- 7. 전송 버튼 -->					
					<div style="padding:30px 0 14px;" align="center">
						<input type="button" onclick="go_complete()" style="float:none" value="결제하기" id="btn_payment">
					</div>	
					
					
					
				</form>
			</div>						
		</div>
		
	</div>	
	<%-- <jsp:include page="include/footer.jsp"></jsp:include> --%>
		
</body>
</html>