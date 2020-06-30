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
<title>결제페이지</title>
<style type="text/css">

	div#container{
		width:1080px;
		margin: auto;
		font-family : noto sans, sans-serif, malgun gothic;
	}
	
	.content input{
		height:35px;
		vertical-align: middle;
		margin-right:10px;
		padding-left:7px;
		border: solid 1px #949296; /* 회색 */
	}
	
	.contents input[type=radio]{
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
	.contents table{
		border-bottom: solid 1px #ddd;	
		width : 100%;		
	}
	
	 .contents th,  .contents td{
		height : 50px;
		vertical-align: middle;	
		padding : 20px;
	}
	
	.contents th{
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
	#ordererTable{
		width: 1080px;
	}
	
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
	}
	
	span#address_all{
		height:25px;
		margin:0px;
		padding:0px;
		font-size : 12px;
		font-weight: bold;
    	color : #333333;
	}
	
	

	
	/* 결제 정보 */
	
	div#paymentInfo{
		
	}
	
	div.payment_tableArea{
		display: inline-block;
		width: 600px;
		float:left;
	}
	
	table#payment_table{
		width: 900px;
		border-bottom: solid 1px #ddd;
	}	
	
	 div#costInfo{
		position:relative; 
		display: inline-block;
		max-width:400px;
	} 
	
	div#cosInfo.on{
		/*position:absolute;*/	
	}
	
	
	div#costInfo_div{
		border: solid 1px #5F0080;
		padding: 10px 20px 10px 20px;
		background-color:#F7F5F8;
	}
	
	table.payment_table{
		vertical-align: middle;
	}
	
	.contents .list{
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
    
    .scroll_fixed{
    	position: fixed;
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
		
		console.log("${deliveryInfo}");
		
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
		})
		
		//기존배송지클릭
		$("#selectDelivery").click(function(){
			$(".address_default").show();
			$("#btn_add").hide();
			$(".address_new").hide();
		})
		
		
		//기존배송지에 최근 기록 또는 자신의 핸드폰 번호 입력
		if("${deliveryInfo.recipient_mobile}"!=""){
			var mobile1 = "${deliveryInfo.recipient_mobile}".substring(0,3);
			console.log(mobile1);
			$("input[name='mobile']:eq(0)").val(mobile1);

		if("${sessionScope.payResult}"==""){
			//처음 상품 리스트 숨기기
			$("#productList").hide();	
			
			
			
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
			})
			
			//기존배송지클릭
			$("#selectDelivery").click(function(){
				$(".address_default").show();
				$("#btn_add").hide();
				$(".address_new").hide();
			})
			
			//기존배송지에 최근 기록 또는 자신의 핸드폰 번호 입력
			if("${deliveryInfo.recipient_mobile}"!=""){
				var mobile1 = "${deliveryInfo.recipient_mobile}".substring(0,3);
				console.log(mobile1);
				$("input[name='mobile']:eq(0)").val(mobile1);
				
				var mobile2 = "${deliveryInfo.recipient_mobile}".substring(3,7);
				$("input[name='mobile']:eq(1)").val(mobile2);
				
				var mobile3 = "${deliveryInfo.recipient_mobile}".substring(7);
				$("input[name='mobile']:eq(2)").val(mobile3);
			}
			
			
			//배송지 상세주소 카운트
			var cntAddress = "";
			
			// 배송 주소 전부 입력
			var address_all = "";
			
			if("${deliveryInfo.recipient_address}"!=""){
				cntAddress = $("#address_default_sub").val().length;
				$("#bytesAddress").text(cntAddress);
				
				// 배송 주소 전부 입력
				address_all = $("#address_default_main").val()+" "+$("#address_default_sub").val();
				$("#address_all").text(address_all);
					
				//배송지 상세주소 재입력 카운트
				$("input#address_default_sub").keyup(function(){
					cntAddress = $("#address_default_sub").val().length;
					$("#bytesAddress").val('');
					$("#bytesAddress").text(cntAddress);
				});
				
			}
			
			
			// 새배송지 상세주소 카운트
			var cntNewAddress = $("#address_new_sub").val().length;
			$("#bytesNewAddress").text(cntNewAddress);
			
			$("#address_new_sub").keyup(function(){
				var cntNewAddress2 = $("#address_new_sub").val().length;
				$("#bytesNewAddress").val('');
				$("#bytesNewAddress").text(cntNewAddress2);
			});
				
			
			
			
			
			
			
			
			//결제 정보 페이지 플로팅
		/* 	// 기존 css에서 플로팅 배너 위치(top)값을 가져와 저장한다.
			var floatPosition = parseInt($("#costInfo").css('top'));
		
			$(window).scroll(function() {
				// 현재 스크롤 위치를 가져온다.
				var scrollTop = $(window).scrollTop();
				var newPosition = scrollTop + floatPosition + "px";
		
				// 애니메이션 없이 바로 따라감
				$("#costInfo").css('top', newPosition);
				 
			}).scroll(); */
			
			
		  /*   var agreeInfoHei = $('#agreeInfo').outerHeight(); //동의 전까지

		    $("#paymentInfo").on('scroll', function() {
		
			    var sT = $(window).scrollTop();
			    var val = $(document).height() - $(window).height() - agreeInfoHei;
		
			    if (sT >= val)
			    	$('#agreeInfo').addClass('on')
			    else
			    	$('#agreeInfo').removeClass('on')
		    }); 
		     */
		    
		    var $w = $(window),
		    footerHei = $('footer').outerHeight(),
		    $banner = $('#costInfo');

		  	$w.on('scroll', function() {

			    var sT = $w.scrollTop();
			    var val = $(document).height() - $w.height() - footerHei;
		
			    if (sT >= val)
			        $banner.addClass('on')
			    else
			    	$banner.removeClass('on')
			    	
		   });
		  
		  

			//일반결제 선택시 카드/할부 선택
			$("input[type=radio]").click(function(){
				if($("#card").prop('checked')){
					$("#card_detail").css('display','');
					console.log('111');
				}else{
					$("#card_detail").css('display','none');
					console.log('222');

				}
			});
		}
		
		
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
                    $("#address_new_main").val(addr+extraAddr);
                    $(".address_new_bytes").show();
	                
	            }
	        }).open();
	};
		
	
	function go_complete(){	
		var mobileFlag=true;
		var selectDelivery = $("input[name='selectDelivery']:checked").val();
		
		
		if(selectDelivery=="1"){
			if($("#address_default_postcode").val().trim()=="" || $("#address_default_main").val().trim()=="" ){
				alert("주소를 입력해 주세요");
				return;
			}
		}else{
			if($("#address_new_postcode").val().trim()=="" || $("#address_new_main").val().trim()=="" ){
				alert("주소를 입력해 주세요");
				return;
			}
		}
		
		if($("#nameReceiver").val().trim()==""){
			alert("수령인을 작성해주세요");
			return;
		}
		
		$("input[name='mobile']").each(function(index,item){
			if(item.value.trim()==""){
				mobileFlag=false;
			}
		})
		
		if(!mobileFlag){
			alert("수령인 핸드폰 번호를 정확히 입력해주세요");
			return;
		}
		
		//약관 동의
		if(!($("input:checkbox[id=agreeCheck]").prop('checked'))){
			alert('약관에 동의해주세요.');			
			return;
	 	}
		
		func_pop();
	
		
		
	};
	
	
	function func_pop(){
		var pay = $("input[name='pay']:checked").val();
		console.log(pay);
		window.name="parentFrm";
		sessionStorage.setItem("recieve",$("#totalPrice").val());
		if($("input[name='selectDelivery']:checked").val()=="1"){
			sessionStorage.setItem("postcode",$("#address_default_postcode").val());
			sessionStorage.setItem("address",$("#address_default_main").val());
		}
		else{
			sessionStorage.setItem("postcode",$("#address_new_postcode").val());
			sessionStorage.setItem("address",$("#address_new_main").val());
		}
		console.log(sessionStorage.getItem("recieve"));
		var win = window.open("<%=ctxPath%>/pay.do?pay="+pay,"childFrm","left=300px, top=100px, width=800px, height=700px");
	}
	
	function goSubmit(){
		
		var frm = document.frm_payment;
		frm.action = 'pay.do';
		frm.method = 'post';
		frm.submit(); 
	}
	
	
	
	
</script>
</head>
<body>
	
	<div class="Mycontainer">
		<jsp:include page="../include/header.jsp"></jsp:include>
		<div class="section" align="center">
			<div class="contents">
				<c:if test="${empty sessionScope.payResult}">
				<form name="frm_payment" method='post'>
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
								<c:forEach var="item" items="${cartList}">
									<tr>
										<td class="product productImg"><img style="width:100%" src="/ShoppingMall/images/${item.prod.representative_img}" /></td>
										<td class="product productInfo">
											<div id="productInfo_name">${item.prod.product_name }</div>
											<input type="hidden" name="order_product_num" value="${item.prod.product_num}" />
											<div id="productInfo_cnt"><span>${item.product_count}</span><span>개/개당<span><fmt:formatNumber value="${item.prod.finalPrice}" pattern="###,###" /> 원</span></span></div>
											<input type="hidden" name="order_product_count" value="${item.product_count}" />
											<input type="hidden" name="order_product_price" value="${item.prod.finalPrice }" />
										</td>
										<td class="product productInfo last_td productPrice"><fmt:formatNumber value="${item.prod.totalPrice}" pattern="###,###" /> 원</td>
									</tr>
								</c:forEach>
							</tbody>			
						</table>
					</div>
					
					
					
					<!-- 2 주문자정보 -->
					<div id="ordererInfo">
						<div class="payment_title">주문자 정보</div>
						<input type="hidden" name="order_member_num" value="${sessionScope.loginuser.member_num }" />
						<table id="ordererTable">
							<tr>
								<td colspan="2" style="height:10px"></td>
							</tr>
							<tr>
								<th class="table_th">보내는분</th>
								<td><input class=peopleInfo type = "text" value="${sessionScope.loginuser.name}" readonly></input></td>
							</tr>
							<tr>
								<c:if test="${not empty sessionScope.loginuser.mobile}">
								<th class="table_th">휴대폰</th>
								
								<td>
									${sessionScope.loginuser.mobileForm}
								</td>
								</c:if>
							</tr>
							<tr>
								<th class="table_th">이메일</th>
								<td><input type = "text" value="${sessionScope.loginuser.email }" readonly></input></td>
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
							<p id="p_deliver" style="display: inline-block; margin:0 20px 0;">*정기 배송 휴무일:샛별배송(<span style="color:red">휴무없음</span>),택배배송(<span style="color:red">일요일</span>)</p>
						</div>
						
						<table id="deliverInfo_table">
							<c:if test="${!empty deliveryInfo.recipient_address}">
								<tr>
									<td colspan="2" style="height:10px"></td>
								</tr>
								<tr>
									<th>배송지 선택</th>
									<td>
										<label for="selectDelivery">
										<input type="radio" value="1" name="selectDelivery" id="selectDelivery" checked="checked"> 최근 배송지
										</label>
										<label for="selectDelivery2">
										<input type="radio" value="2" name="selectDelivery" id="selectDelivery2"> 새로운 배송지
										</label>
									</td>
								</tr>		
										
								<tr>
									<th>주소</th>
									<td>
										<div class="address_default">
											<input class="input_address" name="postcode" type="text" id="address_default_postcode" value="${deliveryInfo.recipient_postcode}" readonly/>
											<input class="input_address" name="mainaddress" type="text" id="address_default_main" value="${deliveryInfo.recipient_address}" readonly>
											<input class="input_address" name="subaddress" type="text" id="address_default_sub" value="${deliveryInfo.recipient_detailaddress}" style="display:inline-block;" readonly>
											<span id="bytesAddress" style="display:inline-block;"></span>자 / 60자
											<span class="input_address" id="address_all"></span>										
										</div>			
										
										<button type="button" id="btn_add" style="display: none;" onclick="openPOST()">새 배송지 추가</button>	
											<div class="address_new">
												<input class="input_address" name="newPostcode" id="address_new_postcode" style="display: none;">
												<input class="input_address" name="newMainaddress" id="address_new_main" style="display: none;">
												<input class="input_address" name="newSubaddress" id="address_new_sub" style="display: none;">
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
										<input type="text" id="nameReceiver" name="nameReceiver" value="${deliveryInfo.recipient}" required="required">
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
							</c:if>
							<c:if test="${empty deliveryInfo.recipient_address}">
								<tr>
									<td colspan="2" style="height:10px"></td>
								</tr>
								<tr>
									<th>배송지 선택</th>
									<td>
										<label for="selectDelivery2">
										<input type="radio" value="2" name="selectDelivery" id="selectDelivery2" checked> 새로운 배송지
										</label>
									</td>
								</tr>
								<tr>
									<th>주소</th>
									<td>		
										<button type="button" id="btn_add" onclick="openPOST()">새 배송지 추가</button>	
										<input class="input_address" name="newPostcode" id="address_new_postcode" style="display: none;">
										<input class="input_address" name="newMainaddress" id="address_new_main" style="display: none;">
										<input class="input_address" name="newSubaddress" id="address_new_sub" style="display: none;">
										<div class="address_new_bytes" style="display: none;">
											<span id="bytesNewAddress" ></span>자 /60자
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
										<input type="text" id="nameReceiver" name="nameReceiver" value="${deliveryInfo.recipient}" required="required">
									</td>
								</tr>
								
								<tr>
									<th>휴대폰 *</th>
									<td>
										<input style="width:43px;" type="text" name="mobile" value="" size="3" maxlength="3" required="required" >
											<span class="bar"><span>-</span></span>
										<input style="width:50px;" type="text" name="mobile" value="" size="4" maxlength="4" required="required">
											<span class="bar"><span>-</span></span>
										<input style="width:50px;" type="text" name="mobile" value="" size="4" maxlength="4" required="required" >
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
							</c:if>		 														
						</table> 
						
					</div>					
					
					
					<!-- 4.결제수단 -->
					<div id="paymentInfo" align="left">
						<div class="payment_title">결제 수단</div>
						<div class="payment_tableArea" align="center">
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
											<input type="radio" value="2" name="pay" id="toss"><img src="http://res.kurly.com/pc/service/order/1912/toss-logo-signature.svg" height="18"/>
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
						 <c:set var="sum" value="0" />
						<c:forEach var="item" items="${cartList}">
									<c:set var="sum" value="${sum + item.prod.totalPrice}" />
						</c:forEach> 
						<!-- 5.결제금액 -->					
						<div id="costInfo">
							<div class="payment_title" style="border:none; padding: 0;"><h4>결제 금액</h4></div>		
							<div id="costInfo_div">		
								<table id="costInfo_table" style="border:none;">
								
									<tr>
										<th>상품 금액</th>
										<td><fmt:formatNumber value="${sum}" pattern="###,###" />원</td>
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
										<td>
											<fmt:formatNumber value="${sum+3000}" pattern="###,###" />원
											<input type="hidden" name="totalPrice" id="totalPrice" value="${sum+3000}" />
										</td>
										
									</tr>						
								</table>	
							</div>	
						</div>
					</div>	
					<div style="clear:both;"></div>
					<!-- 6.개인정보수집제공 -->					
					<div id="agreeInfo">
						<div class="payment_title">개인정보 수집/제공</div>		
						<div id="agreeInfo_div">	
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
				</c:if>
				<c:if test="${not empty sessionScope.payResult}">
					<h3>결제가 완료되었습니다.</h3>
				</c:if>
			</div>						
		</div>
		
	</div>	
	<jsp:include page="../include/footer.jsp"></jsp:include>
		
</body>
</html>