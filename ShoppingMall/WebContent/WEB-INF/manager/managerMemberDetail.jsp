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
<title>managerSales.jsp</title>
<!-- 차트 링크 --> 
<script src="https://cdn.jsdelivr.net/npm/chart.js@2.8.0"></script> 
<style type="text/css">

	.sideMenu{
		margin-top:10px;
		display: inline-block;
		width: 150px;
		float:left;
	}
	
	.memberInfo{
		display:inline-block;
		width: 900px;
		margin-left:10px;
		
	}
	
	.detailTablePart{
		margin-top:50px;
	}
	
	/* Style the tab */
	.tab {
	  overflow: hidden;
	  background-color: white;
	  border-bottom: solid 2px purple;
	  margin-bottom: 5px;
	}
	
	/* Style the buttons inside the tab */
	.tab a{
		text-decoration: none;
		color:black;
	}
	
	.choice{
		background-color: purple;
		color:white;
		font-weight: bold;
	}
	
	.tab button {
	  float: left;
	  cursor: pointer;
	  padding: 14px 0;
	  width: 100px;
	  transition: 0.3s;
	  font-size: 17px;
	  border:none;
	  border-top: solid 1px purple;
	  outline: none;
	  border-left:solid 1px purple;
	}
	
	.tableTitle{
		font-size: 18pt;
	}
	
	#userBtn{
		margin-top:10px;
		
	}
	
	.type{
		text-align:center;
		display: inline-block;
		position: relative;
		border:solid 1px purple;
		margin-left:10px;
		padding:10px 0;
		width: 80px;
		color:purple;
	}
	
	
	.accordion {
	  background-color: white;
	  color: #444;
	  cursor: pointer;
	  border: none;
	  text-align: center;
	  outline: none;
	  font-size: 15px;
	  transition: 0.4s;
	} 
	
	.content-title{
		text-align: left;
	}
	
	.panel {
	  
	  background-color: transparent;
	  overflow: hidden;
	  text-align: left;
	  margin : 0px ; 
	
	}
	
	.panel-none{
		display: none;
	}
	
	
	#answer{
	
		border-top: solid 1px #bfbfbf;
		background-color:#f0eef1;
		padding-top: 20px;
		padding-bottom:20px;;
		margin:10px auto;
		width:100%;		
	}
	
	
	
	.td_count{
		width: 15%;
	}
	
	
	.td_price{
		width: 20%;
	}
	
	
</style>
<!-- 부트스트랩 -->
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.1/css/bootstrap.min.css">

<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
<script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.1/js/bootstrap.min.js"></script>
<script type="text/javascript" src="/ShoppingMall/js/jquery-3.3.1.min.js"></script>
<script type="text/javascript" src="/ShoppingMall/util/myutil.js"></script>
<script type="text/javascript">

	var offSet = new Array();
	var order_currentPage = 1;
	var order_totalPage = 1;
	var reivew_currentPage = 1;
	var rivew_totalPage = 1;
	var oneQ_currentPage = 1;
	var oneQ_totalPage = 1;

		
	
	
	$(document).ready(function(){		
		
		
		// 리뷰 클릭 아코디언
		$(document).on("click", ".accordion", function(){
			var $target = $(this).next();
		    var targetDisplay = $target.css('display');			
			var $other = $(this).siblings();	
			

			$other.each(function(index2, item2){
				if($(item2).hasClass("panel")){
					$(item2).addClass("panel-none");	
				}
			});			
			
			if($(item).hasClass("panel-none")){
				$(item).removeClass("panel-none");				
			}else{
				$(item).addClass("panel-none");				

			}
		
			//$target.toggleClass("panel-none");		

			
			
		})
		
			
				
		for(var i=0; i<$(".detailTablePart").length; i++){
			offSet[i] = $(".detailTablePart")[i].offsetTop;
		}		
		   
		func_orderCall(order_currentPage);
		func_reviewCall(reivew_currentPage);
		func_oncQCall(oneQ_currentPage);		
		
	});
	
	
	
		
	
	function goTable(num){
			
		var top = offSet[num]-Number("81");
		console.log("top:"+top);
		$('html, body').animate({scrollTop : top}, 0);		
	}
	
	
	
	// 주문
	function func_orderCall(order_currentPage){
		var url = "/manager/orderCall.do";
		var data = {"member_num":"${mvo.member_num}",
				    "pagePerNum":"5",
			   	    "currentPage":order_currentPage,
			   	    "totalPage":order_totalPage		   
				   };
		reqServer(url, data);
	}
	
	function printOrder(json){
		console.log(json);
		if(json.orderList.length > 0){
			var temp=0;
			var html = "";
			
		
			$(json.orderList).each(function(index, item){
				
				if(temp!=item.order_num){
					html += "<tr class='accordion'>"
				         	 + "<td>"+item.order_num+"</td>"
				         	 + "<td class='content-title'>"+item.orderProductList[0].product.product_name;
				    if(item.product_cnt!=1){
				    	html += "<span> 외 " + (item.product_cnt-1) + "건 </span>"
				    }
				    
				    html +=  "</td>"
				         	 + "<td>"+func_comma(item.price)+"원</td>"
				         	 + "<td>"+item.order_date+"</td>"
				         	 + "<td>"+item.order_state+"</td>"
			         		 + "</tr>";
			        
			      
		        	html += "<tr class='panel panel-none'>"
		        		+ "<td colspan='5'>";
		        	
		        	$(item.orderProductList).each(function(index2, item2){
		        		html += "<div>"
		        			+ "<table>"
			        		+ "<tr>"
			        		+ "<td><img src='/ShoppingMall/images/"+item2.product.representative_img+"' style='width:80px;height:100px;'></td>"
			        		+ "<td>"+item2.product.product_name+"</td>"
			        		+ "<td class='td_count'>"+item2.count+"</td>"
			        		+ "<td class='td_price'>"+item2.price+"</td>"
		        			+ "</tr>"
			        		+ "</table>"			        		
			        		+ "</div>";		 		        		
		        	})
		     
		        				        				        		
		        	html += "<div>"
		        		+ "<table>"
		        		+ "<tr><th>수령인</th><td>"+item.recipient+"</td></tr>"
		        		+ "<tr><th>전화번호</th><td>"+item.recipient_mobile+"</td></tr>"
		        		+ "<tr><th>우편번호</th><td>"+item.recipient_postcode+"</td></tr>"
		        		+ "<tr><th>주소</th><td>"+item.recipient_address+"</td></tr>"
		        		+ "<tr><th>상세주소</th><td>"+item.recipient_detailaddress+"</td></tr>"
		        		+ "</table>"
		        		+ "</div>"		        		
		        		+ "</td>"					
				  	 	+"</tr>";
			         
			        temp = item.order_num;


				}else{
					temp = item.order_num;
				}
			         	 
			});
			
			$("tbody#order").html(html);
			$("#orderPageBar").html(json.pageBar);
		}
		else{
			var html = "<td colspan='5'>구매 내역이 없습니다.</td>";
			
		}
	}
	
	
	
	
	
	// 후기 
	function func_reviewCall(reivew_currentPage){
		var url = "/manager/reviewCall.do";
		var data = {"member_num":"${mvo.member_num}",
				    "pagePerNum":"5",
			   	    "currentPage":reivew_currentPage,
			   	    "totalPage":rivew_totalPage		   
				   };
		reqServer(url, data);
	}
	
	
	function printReview(json){
		if(json.reviewList.length > 0){
			var html = "";
			$(json.reviewList).each(function(index, item){
					html += "<tr class='accordion'>"
				         	 + "<td>"+item.review_num+"</td>"
				         	 + "<td>"+item.product_name+"</td>"
				         	 + "<td class='content-title'>"+item.subject+"</td>"
				         	 + "<td>"+item.write_date+"</td>"
			         	 + "</tr>"
				         + "<tr class='panel panel-none'>"
					         + "<td colspan='4' class='review_content'>"+item.content;
						if(item.imageList.length>0){
							 $(item.imageList).each(function(index2, item2){
								  html+="<div><img src='<%=ctxPath%>/Upload/"+item2+"' / style='margin-bottom:10px;'></div>";
							  });
						}				
					html += "</td>"
				         + "</tr>";
			         	 
			});
			
			$("#review tbody").html(html);
			$("#reviewPageBar").html(json.pageBar);
		}
		else{
			var html = "<td colspan='5'><div class='' align='center'><h3>작성된 후기가 없습니다.</h3></div></td>";
			$("#review tbody").html("<tr>"+html+"</tr>");
			$(".review").css("border-bottom","none");
			
		}
	}
		
	
	
	// 문의
	function func_oncQCall(currentPage){
		var url = "/manager/oneQCall.do";
		var data = {"member_num":"${mvo.member_num}",
				   	"pagePerNum":"5",
				   	"currentPage":currentPage,
				   	"totalPage":oneQ_totalPage
		           };
		reqServer(url, data);
	}
	
	
	function printOneInquiry(json){
		if($(json.oneQList).length > 0){
			var html="";
			$(json.oneQList).each(function(index, item){
				
				html += "<tr class='accordion' onclick='inquiryOpen(this)'>"
					      + "<td>"+item.one_inquiry_num+"</td>"
					      + "<td>"+item.category_content+"</td>"
					      + "<td class='content-title'>"+item.subject+"</td>"
					      + "<td>"+item.write_date+"</td>"
					      + "<td>"+item.answer_content+"</td>"
				      + "</tr>"
				      + "<tr class='panel panel-none'>"
					  	+ "<td colspan='5' class='review_content'>"+item.content 
					  	if(item.answer_content=="답변완료"){
							  html+= "<div id='answer'>"
							  		+ item.answer
							  		+ "</div>";
						  }						  	
					  	+ "</td>"
					  	+"</tr>";
				  				  
			});
			
			$("#question tbody").html(html); 
			$("#questionPageBar").html(json.pageBar);
		}
		else{
			var html = "<td colspan='5'><div class='' align='center'><h3>작성된 1:1 문의가 없습니다.</h3></div></td>";
			$("#question tbody").html("<tr>"+html+"</tr>");
			$(".goodsQ").css("border-bottom","none");
			
		}
	}
	
	
	
	// ajax 처리
	function reqServer(url, data){
		$.ajax({
			url:"<%=ctxPath%>"+url,
			data:data,
			type:"POST",
			dataType:"JSON",
			success:function(json){
				if(url=="/manager/orderCall.do"){
					printOrder(json);
					
				}else if(url=="/manager/reviewCall.do"){
					printReview(json);
				}
				else if(url=="/manager/oneQCall.do"){
					printOneInquiry(json);
				}
			},
			error:function(e){
				console.log(e);
			}
		});
	}
	
	
	
	
</script>
</head>
<body>
	<div class="Mycontainer">
		<jsp:include page="../include/header.jsp"></jsp:include>
		<div class="section" align="center">
			<div class="contents">
				<div class="sideMenu">
					<jsp:include page="../include/managerSide.jsp"></jsp:include>
				</div>
				<div class="memberInfo">
					<div id="userBtn" align="right">
						<span class="type">탈퇴</span>
					</div>
					
					<!-- 1. 회원정보 -->						
					<div class="detailTablePart" id="info">
						<div class="tab">
							<button class="tablinks choice" onclick="goTable('0')">회원정보</button>
							<button class="tablinks" onclick="goTable('1')">구매내역</button>
							<button class="tablinks" onclick="goTable('2')" style="border-right:solid 1px black">후기</button>
							<button class="tablinks" onclick="goTable('3')" style="border-right:solid 1px black">1:1문의</button>							
						</div>					
							<table class="table">
								<tr>
									<th>회원번호</th>
									<td>${mvo.member_num}</td>
								</tr>
								<tr>
									<th>성명</th>
									<td>${mvo.name}</td>
								</tr>
								<tr>
									<th>아이디</th>
									<td>${mvo.userid}</td>
								</tr>
								<tr>
									<th>이메일</th>
									<td>${mvo.email}</td>
								</tr>
								<tr>
									<th>휴대폰 번호</th>
									<td>${mvo.mobile}</td>
								</tr>
								
								<c:if test="${not empty mvo.postcode}">
									<tr>
										<th>우편번호</th>
										<td>${mvo.postcode}</td>
									</tr>
									<tr>
										<th>주소</th>
										<td>${mvo.address}</td>
									</tr>
									<tr>
										<th>상세주소</th>
										<td>${mvo.detailAddress}</td>
									</tr>
								</c:if>						
								
								<tr>
									<th>성별</th>
									<td>
										<c:choose>
											<c:when test="${mvo.gender eq '1'}">
												남자
											</c:when>
											<c:when test="${mvo.gender eq '2'}">
												여자
											</c:when>
											<c:otherwise>
												설정 안 함
											</c:otherwise>
										</c:choose>
									</td>
								</tr>
								<tr>
									<th>생일</th>
									<td>
										<c:choose>
											<c:when test="${empty mvo.birthday}">
												설정 안 함
											</c:when>
											<c:otherwise>
												${mvo.birthday}
											</c:otherwise>
										</c:choose>
									</td>
								</tr>
								<tr>
									<th>가입날짜</th>
									<td>${mvo.registerdate}</td>
								</tr>							
							</table>					
						</div>


					<!-- 2. 주문정보 -->
					<div class="detailTablePart" id="sales">
						<div class="tab">
							<button class="tablinks" onclick="goTable('0')">회원정보</button>
							<button class="tablinks choice" onclick="goTable('1')">구매내역</button>
							<button class="tablinks" onclick="goTable('2')" style="border-right:solid 1px black">후기</button>
							<button class="tablinks" onclick="goTable('3')" style="border-right:solid 1px black">1:1문의</button>
						</div>
						<table class="table sales">	
							<thead>						
								<tr>
									<th>주문 번호</th>
									<th>주문 내역</th>
									<th>결제 금액</th>
									<th>주문일</th>
									<th>주문 상태</th>
								</tr>
							</thead>
							<tbody id="order">
							<tr>
							<td>
							<div><table></table></div>
							</td>
							</tr>
							
							</tbody>						
						</table>
						<div id="orderPageBar"></div>	
					</div>
					
					<div class="detailTablePart" id="review">
						<div class="tab">
							<button class="tablinks" onclick="goTable('0')">회원정보</button>
							<button class="tablinks" onclick="goTable('1')">구매내역</button>
							<button class="tablinks choice" onclick="goTable('2')" style="border-right:solid 1px black">후기</button>
							<button class="tablinks" onclick="goTable('3')" style="border-right:solid 1px black">1:1문의</button>
						</div>
						<table class="table review">
							<thead>
								<tr>
									<th>글번호</th>
									<th>상품명</th>
									<th>제목</th>
									<th>작성일</th>
								</tr>
							</thead>
							<tbody id="review">							
							
							</tbody>							
						</table>
						<div id="reviewPageBar"></div>
					</div>
					
					
					<div class="detailTablePart" id="question">
						<div class="tab">
							<button class="tablinks" onclick="goTable('0')">회원정보</button>
							<button class="tablinks" onclick="goTable('1')">구매내역</button>
							<button class="tablinks" onclick="goTable('2')" style="border-right:solid 1px black">후기</button>
							<button class="tablinks choice" onclick="goTable('3')" style="border-right:solid 1px black">1:1문의</button>
						</div>
						<table class="table question">
							<thead>
								<tr>
									<th>글번호</th>
									<th>카테고리</th>
									<th>글제목</th>
									<th>작성일</th>
									<th>답변 상태</th>
								</tr>
							</thead>	
							<tbody id="question">							
							
							</tbody>	
						</table>
						<div id="questionPageBar"></div>																				
					</div>
					
					
				</div>
				<div style="clear:both;"></div>
			</div>
		</div>
		<jsp:include page="../include/footer.jsp"></jsp:include>
	</div>
</body>
</html>