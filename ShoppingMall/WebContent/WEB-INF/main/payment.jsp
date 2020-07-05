<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %> 
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %> 

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
	
	.contents input{
		height:35px;
		vertical-align: middle;
		margin-right:10px;
		border: solid 1px #949296; /* 회색 */
	}
	
	.contents input[type=radio]{
		margin-right : 8px !important;
	}	
	
	
	/* 주문서 */
	h3#header_order{
		margin-bottom : 15px;
		font : normal bold;
		font-size : 30px;
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
		color : #000;
	}
	
	
	/* 테이블 전체 설정 */
	.contents table{
		border-bottom: solid 1px #ddd;		
	}
	
	.contents th,  .contents td{
		height : 50px;
		vertical-align: middle;	
		padding : 15px;
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
		padding:30px;	
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
		font-size: 11pt;
		margin-bottom : 15px;
	}
	
	div#productInfo_cnt{
		font-size: 10pt;
	}
	
	td#productPrice{
		color:#000;
		font-weight: bolder;
		text-align: right;
	}
	
	
	
	
	/* 주문자 정보 */	
	#ordererTable{
		width: 1080px;
	}
	
	input.peopleInfo{
		border : 0 none;
	}
	
	
	/* 배송 정보 */
	#deliverInfo_table{
		width: 1080px;
	}
	
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
	
	span#address_all, #address_new_all{
		height:25px;
		margin:0px;
		padding:0px;
		font-size : 12px;
		font-weight: bold;
    	color : #333333;
	}
	
	
	/* 결제 정보 */	
	
	.contents .list{
		height: 35px;
	}
	
	#costInfo_table{
		width: 1080px;		
	}
	
	
	
	/* 개인 정보 동의 */
	#agreeInfo_table{
		width: 1080px;
	}
	
	.agreeLink{
		color:#5f0080;
		font-weight: bold;
	}
	
	.agreeLink:hover{
		cursor:pointer;
	}
	
	.view_terms {
	    position: fixed;
	    z-index: 2;
	    left: 50%;
	    top: 50%;
	    width: 480px;
	    margin: 0 0 0 -220px;
	    padding : 30px;
	    border-radius: 10px;
	    background-color: #fff;
	    text-align: center;
	    align-content: center;
	}
	
	.bg_dim {
	    position: fixed;
	    z-index: 1;
	    left: 0;
	    top: 0;
	    width: 100%;
	    height: 100%;
	    background-color: #000;
	    opacity: .5;
	}
   
	
	.tit_layer {
	    display: block;
	    font-size: 30px;
	    font-weight: 500;
	    margin : 0 auto;
	    padding: 30px 0;
	    line-height: 40px;
	    color: #333;
	}
	
	table#agree_table{
		margin: 20px 0; 
		text-align: center;
		border-collapse: collapse;
	}
	
	table#agree_table th{
		text-align : center;
		background-color: #f7f5f8;
		height: 15px;
		border : solid 1px #dddfe1;
	}
	
	table#agree_table td{
		border : solid 1px #dddfe1;
	}
	
	
	.btn_agree_close{
		background-color: #5f0080;
		width : 60%;
		height:50px;
		color: #fff;
		border: none;
	}
	
	p#txt_service{
		margin-bottom: 10px;
	}
    
    /* 결제 버튼 */
	#btn_payment{
		width: 200px;
		height: 48px;
    	background-color: #5f0080;
	    color: #fff;
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
		
		$("div.address_new").css('display','none');
		
		if("${sessionScope.payResult}"==""){
			//처음 상품 리스트 숨기기
			$("#productList").hide();	
		
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
				if($("#address_new_postcode").val()!=""){
					$(".address_new").css('display','');			
				}
			})
			
			//기존배송지클릭
			$("#selectDelivery").click(function(){
				$(".address_default").show();
				$("#btn_add").hide();
				$(".address_new").hide();
				$("#deliver_guide").hide();
			})
			
			//기존배송지에 최근 기록 또는 자신의 핸드폰 번호 입력
			if("${deliveryInfo.recipient_mobile}"!=""){
				var mobile1 = "${deliveryInfo.recipient_mobile}".substring(0,3);
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
			var address_new_all="";
			
			
			if("${deliveryInfo.recipient_address}"!=""){
				cntAddress = $("#address_default_sub").val().length;
				$("#bytesAddress").text(cntAddress);
				
				//배송지 상세주소 재입력 카운트
				$("input#address_default_sub").keyup(function(){
					cntAddress = $("#address_default_sub").val().length;
					$("#bytesAddress").val('');
					$("#bytesAddress").text(cntAddress);
					
					address_all = $("#address_default_main").val()+" "+$("#address_default_sub").val();
				
					$("#address_all").text(address_all);
					
				});
				
			}
			
			
			// 새배송지 상세주소 카운트
			var cntNewAddress = $("#address_new_sub").val().length;
			$("#bytesNewAddress").text(cntNewAddress);
			
			$("#address_new_sub").keyup(function(){
				var cntNewAddress2 = $("#address_new_sub").val().length;
				$("#bytesNewAddress").val('');
				$("#bytesNewAddress").text(cntNewAddress2);
				
				address_new_all = $("#address_new_main").val()+" "+$("#address_new_sub").val();
				
				$("#address_new_all").text(address_new_all);
				
				
			});
			
			
			
			
			$(".agreeLink").click(function(){
				$(".choice_agree").css('display','');
				$("body").css({overflow:'hidden'}).bind('touchmove', function(e){e.preventDefault()});
			})
			
			
			$(".btn_agree_close").click(function(){
				$(".choice_agree").css('display','none');
				$("body").css({overflow:'scroll'}).unbind('touchmove');
			})
			 
			
			
		
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
	                var all = '';

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
	                    
	                    $("input#address_new_main").val(extraAddr);
	                
	                } else {
		                 $("input#address_new_main").val('');	
		            }

	                // 우편번호와 주소 정보를 해당 필드에 넣는다.
	                $("#address_new_postcode").val(data.zonecode);
            		all = addr + " " + extraAddr;

                    $("#address_new_main").val(all);
        			$("div.address_new").css('display','');
        			$("#address_new_all").text(all);	
        			$("#deliver_guide").css('display','none');
        			$("#deliver_guide_result").css('display','');
	                
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
						
						<div id="show" ><span id="show">${cartList[0].prod.product_name}
							<c:if test="${fn:length(cartList) > 1}">
								&nbsp; 외 &nbsp; ${fn:length(cartList)-1}</c:if>&nbsp;개의 상품을 주문합니다.</span>
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
										<td class="product productInfo last_td productPrice" id="productPrice"><fmt:formatNumber value="${item.prod.totalPrice}" pattern="###,###" /> 원</td>
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
								<td colspan="2" style="height:7px"></td>
							</tr>
							<tr>
								<th class="table_th">보내는분</th>
								<td><input class="peopleInfo" type = "text" value="${sessionScope.loginuser.name}" readonly></input></td>
							</tr>
							<tr>
								<c:if test="${not empty sessionScope.loginuser.mobile}">
								<th class="table_th peopleInfo">휴대폰</th>
								
								<td>
									${sessionScope.loginuser.mobileForm}
								</td>
								</c:if>
							</tr>
							<tr>
								<th class="table_th">이메일</th>
								<td><input class="peopleInfo" type = "text" value="${sessionScope.loginuser.email}" readonly></input></td>
							</tr>
							<tr>
								<th class="table_th"></th>
								<td class="last_td" colspan="2">
									<p>이메일을 통해 주문처리과정을 보내드립니다.<br/>정보 변경은 마이컬리>개인벙보 수정 메뉴에서 가능합니다.</p>
								</td>
							</tr>
							<tr>
								<td colspan="2" style="height:7px"></td>
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
									<td colspan="2" style="height:7px"></td>
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
									<th>주소 *</th>
									<td>
										<div class="address_default">
											<input class="input_address" name="postcode" type="text" id="address_default_postcode" value="${deliveryInfo.recipient_postcode}" readonly/>
											<input class="input_address" name="mainaddress" type="text" id="address_default_main" value="${deliveryInfo.recipient_address}" readonly>
											<input class="input_address" name="subaddress" type="text" id="address_default_sub" value="${deliveryInfo.recipient_detailaddress}" style="display:inline-block;">
											<span id="bytesAddress" style="display:inline-block;">0</span>자 / 60자
											<span class="input_address" id="address_all"> ${deliveryInfo.recipient_address} &nbsp; ${deliveryInfo.recipient_detailaddress}</span>										
										</div>			
			 					
										<button type="button" id="btn_add" style="display: none;" onclick="openPOST()">새 배송지 추가</button>	
											<div class="address_new">
												<input class="input_address" name="newPostcode" id="address_new_postcode" readonly>
												<input class="input_address" name="newMainaddress" id="address_new_main" readonly>
												<input class="input_address" name="newSubaddress" id="address_new_sub" style="display:inline-block;">	
												<span id="bytesNewAddress" style="display:inline-block;">0</span>자 / 60자
												<span class="input_address" id="address_new_all"></span>																					
											</div>
									</td>
								</tr>
								
								<tr>
									<th>배송 구분</th>
									<td>
										<span id="deliver_guide_result" style="display: none;">택배배송지역</span>
										<span id="deliver_guide">
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
							
							<!-- 배송지 없으면 새배송지 바로 -->
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
									<th>주소 *</th>
									<td>
										<button type="button" id="btn_add" onclick="openPOST()">새 배송지 추가</button>	
										<div class="address_new">
											<input class="input_address" name="newPostcode" id="address_new_postcode" readonly>
											<input class="input_address" name="newMainaddress" id="address_new_main" readonly>
											<input class="input_address" name="newSubaddress" id="address_new_sub" style="display:inline-block;">	
											<span id="bytesNewAddress" style="display:inline-block;">0</span>자 / 60자
											<span class="input_address" id="address_new_all"></span>																					
										</div>						
									</td>
								</tr>
								<tr>
									<th>배송 구분</th>
									<td>
										<span id="deliver_guide_result" style="display:none;">택배배송지역</span>
										<span id="deliver_guide">
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
									<td colspan="2" style="height:7px"></td>
								</tr>		
							</c:if>		 														
						</table> 
						
					</div>					
					
					<c:set var="sum" value="0" />
					<c:forEach var="item" items="${cartList}">
								<c:set var="sum" value="${sum + item.prod.totalPrice}" />
					</c:forEach> 
					
					<!-- 4.결제금액 -->					
					<div id="costInfo">
						<div class="payment_title">결제 금액</div>		
						<div id="costInfo_div">		
							<table id="costInfo_table">		
								<tr>
									<td colspan="2" style="height:7px"></td>
								</tr>					
								<tr>
									<th class="table_th">상품 금액</th>
									<td><fmt:formatNumber value="${sum}" pattern="###,###" />원</td>
								</tr>						
								<tr>
									<th class="table_th">배송비</th>
									<td>3,000 원</td>
								</tr>							
								<tr>
									<th>최종 결제 금액</th>
									<td class="last_td">
										<fmt:formatNumber value="${sum+3000}" pattern="###,###" />원
										<input type="hidden" name="totalPrice" id="totalPrice" value="${sum+3000}" />
									</td>									
								</tr>
								<tr>
									<td colspan="2" style="height:7px"></td>
								</tr>						
							</table>	
						</div>	
					</div>
					
					
					<!-- 5.개인정보수집제공 -->					
					<div id="agreeInfo">
						<div class="payment_title">개인정보 수집/제공</div>		
						<div id="agreeInfo_div">	
							<table id="agreeInfo_table" style="border:none;">
								<tr>							
									<td colspan="2" style="height:30px">
										<label for="agreeCheck">	
										<input type="checkbox" name="agreeCheck" id="agreeCheck"> 결제 진행 필수 동의</label>	
										<div style="margin-bottom: 3px;">개인정보 수집·이용 동의<span class="agree_sub">(필수)</span><span class="agreeLink"> 약관확인 > </span></div>	
											<div class="choice_agree" style="display:none;">
												<div class="bg_dim"></div>										
												<div class="view_terms" style="margin-top: -274px;">
													<div class="in_layer" id="viewTerms">								
														<div class="layer_head">
															<h3 class="tit_layer">개인정보 수집·이용 동의(필수)</h3>
														</div>
														<div class="layer_body">
															<div>
																<table id="agree_table">															
																	<thead>
																		<tr>
																			<th>수집 목적</th>
																			<th>수집 항목</th>
																			<th>보유 기간</th>
																		</tr>
																	</thead>
																	<tbody>
																		<tr>
																			<td>온라인 쇼핑 구매자에 대한 상품 결제 및 배송</td>
																			<td>결제정보, 수취인명, 휴대전화번호, 수취인 주소</td>
																			<td>회원 탈퇴 후 30일 내<br>(단, 타 법령에 따라 법령에서 규정한 기간동안 보존)</td>
																		</tr>																	
																	</tbody>
																</table>
															<p id="txt_service">서비스 제공을 위해서 필요한 최소한의 개인정보이므로 <br/>동의를 해 주셔야 서비스를 이용하실 수 있습니다.</p>
															</div>
														</div>
													</div>
													<button type="button" class="btn_agree_close">확인</button>
												</div>
											</div>	
										</td>
									</tr>												
								</table>	
							</div>	
						</div>
					
					
					
					
					
					
					<!-- 6. 전송 버튼 -->					
					<div style="padding:30px 0 30px;" align="center">
						<input type="button" onclick="go_complete()" style="float:none;" value="결제하기" id="btn_payment">
					</div>	
					
					<div style="padding:30px 0">
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