<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<% String ctxPath = request.getContextPath(); %>
<% ServletContext context = request.getSession().getServletContext(); 
   String realPath = context.getRealPath("Upload");
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<link rel="stylesheet" href="<%= ctxPath %>/css/style.css" />
<title>detail.jsp</title>
<style type="text/css">
	
	/*상품 이미지가 보이는 div*/
	.goodsImg{
		float:left;
		display: inline-block;
		width: 350px;
		border:solid 0px black;
	}
	
	.goodsImg > img{
		width: 430px;
		height:552px;
		margin-bottom: 30px;
	}
	
	/*상품 이미지의 옆에 나오는 상품 정보가 들어가 있는 div*/
	.goodsInfo{
		display: inline-block;
		width:600px;
		text-align: left;
		margin: 30px 0 0 100px;
	}
	
	/*상품 정보가 나열된 리스트에서 각각의 항목 부분의 태그*/
	dt{
		
		display: inline-block;
		width: 200px;
		
	}
	
	/*상품 정보가 나열된 리스트에서 각각의 내용 부분의 태그*/
	dd{
		margin-left:-10px;
		display: inline-block;
		width: 350px;
		
	}
	
	/*수량이 표시되는 input태그*/
	.count input[type='text']{
		text-align: center;
	}
	
	/*최종 결과물인 총 결제금액이 나오는 span태그*/
	.money{
		font-size: 24pt;
		font-weight: bold;
	}
	
	/*상품의 다른 이미지와 설명 그리고 후기 및 문의 테이블이 들어간 div*/
	.detailTable{
		clear:both;
		width: 1080px;
		margin-top:50px;
	}
	
	/*후기 및 문의에 들어가는 table태그*/
	.table{
		width: 1080px;
	}
	
	.table > thead{
		text-align: center;
	}
	
	/*장바구니 담기 버튼*/
	.basket{
		display: inline-block;
		width: 278px;
		height: 52px;
		padding-top: 17px;
		text-align: center;
		background-color: #5f0080;
		color: white;
		font-size: 15px;
		font-weight: 600;
		border-radius: 5px;
		margin-top: 20px;
		cursor: pointer;
	}
	.fakebtn {
		display: inline-block;
		width: 128px;
		height: 54px;
		padding-top: 17px;
		text-align: center;
		color: #ddd;
		border: solid 1px #ddd;
		font-size: 15px;
		font-weight: 600;
		border-radius: 5px;
		margin: 20px 10px 0 0;
	}
	
	.detailTablePart{
		clear:both;
		width: 100%;
		margin-top:50px;
	}
	
	.otherImg{
		width: 300px;
		display: inline-block;
		margin: 10px 20px;
	}
	
	/* Style the tab */
	.tab {
	  overflow: hidden;
	  background-color: white;
	  border-bottom: solid 1px #bfbfbf;
	  margin-bottom: 5px;
	}
	
	/* Style the buttons inside the tab */
	.tab a{
		text-decoration: none;
		color: #4C4C4C;
	}
	
	.choice{
		background-color: #FFFFFF;
		color: #4C4C4C;
		font-weight: bold;
	}
	
	.tab button {
	  float: left;
	  cursor: pointer;
	  padding: 14px 20px;
	  transition: 0.3s;
	  font-size: 17px;
	  border:none;
	  border-top: solid 1px #bfbfbf;
	  outline: none;
	  border-left:solid 1px #bfbfbf;
	}
	 .tableTitle{
		font-size: 18pt;
		color: #4C4C4C;
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
	  background-color: white;
	  overflow: hidden;
	  text-align: left;
	  margin : 0px ;
	}
	
	.panel-none{
		display: none;
	}
	
	.goodsQ_content{
		min-height: 200px;
	}
	
	.review_content{
		min-height: 200px;
	}
	
	
	.userBtn > span{
		display: inline-block;
		text-align: center;
		padding : 10 0px;
		margin-right:5px;
		width:60px;
		border: solid 1px #5f0080;
		background-color: #f1f1f1;
		color: #5f0080;
		font-size: 12pt;
		cursor: pointer;
		
	}

	.writeBtn{
		display: inline-block;
		width: 130px;
		height: 32px;
		padding-top: 5px;
		background-color: #795B8F;
		color: white;
		font-size: 13px;
		font-weight: 400;
		text-align: center;
		cursor: pointer;
		margin-left: 5px;
		border: solid 1px #5f0080;
	}

	.tab a:hover{
		color:white;
		font-weight: bold;
		background-color: #5f0080;
	}
	
	.writeBtn:hover{
		color: #5f0080;
		background-color: white;
	}

</style>
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.1/css/bootstrap.min.css">

<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
<script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.1/js/bootstrap.min.js"></script>
<script type="text/javascript" src="/ShoppingMall/js/jquery-3.3.1.min.js"></script>
<script type="text/javascript" src="/ShoppingMall/util/myutil.js"></script>
<script type="text/javascript">
	var money = "";
	var offSet = new Array();
	var productQ_currentPage = 1;
	var productQ_totalPage = 1;
	var reivew_currentPage = 1;
	var rivew_totalPage = 1;
	
	$(document).ready(function(){
		money = "${product.finalPrice}"
		$(".numPrice").val(money);
		$(".money").html(func_comma(money));
		
		$(document).on("click", ".review .accordion", function(){
			var $target = $(this).next();
			var $other = $target.siblings();
			$other.each(function(index, item){
				if($(item).hasClass("panel")){
					$(item).addClass("panel-none");	
				}
			});
			if($target.hasClass("panel-none")){
				var num = $(this).children().first().text();
				console.log(num);
				var writer = $(this).find(".writer").val();
				var hit = $(this).find(".hit");
				console.log(hit);
				console.log(writer);
				if(writer != "${sessionScope.loginuser.member_num}"){
					$.ajax({
						url:"<%=ctxPath%>/reviewHitUp.do",
						data:{"review_num":num},
						dataType:"JSON",
						success:function(json){
							console.log(json.review_num);
							hit.html(json.review_num);
						},
						error:function(e){
							
						}
						
					});
				}
				
			}
			$target.toggleClass("panel-none");
		})
		
		
		for(var i=0; i<$(".detailTablePart").length; i++){
			offSet[i] = $(".detailTablePart")[i].offsetTop;
		}
		
		
		func_reviewCall();
		func_productQCall(productQ_currentPage);
	});
	
	function cntPlus(){
		var $num = $("#count").val();
		var $money = $(".numPrice").val();
		
		if($num<100){
			$num++;
		}
		
		var result = Number($num)*Number(money)+"";
		$("#count").val($num);
		$(".numPrice").val(result);
		$(".money").html(func_comma(result));
		
		
	}
	
	function cntMynus(){
		var $num = $("#count").val();
		var $money = $(".numPrice").val();
		
		if($num>0){
			$num--;
		}
		var result = Number($num)*Number(money)+"";
		$("#count").val($num);
		$(".numPrice").val(result);
		$(".money").html(func_comma(result));

	}
	
	function goTable(num){
		
		var top = offSet[num]-Number("90");
		console.log("top:"+top);
		$('html, body').animate({scrollTop : top}, 0);
	}
	
	
	function inBasket(){
		
		if($("#count").val()==0){
			alert("장바구니에 담을 물건을 선택하세요");
			return false;
		}
		
		$.ajax({
			url:"<%=ctxPath%>/inBasket.do",
			data:{"product_num":"${product.product_num}"
				 ,"price":"${product.price}"
				 ,"count":$("#count").val()},
			type:"get",
			dataType:"JSON",
			success:function(json){
				console.log(json);
				alert(json.message);
				if(json.flag!="-1"){
					 location.reload(true);
				}
				else{
					 location.href="<%=ctxPath%>/member/login.do";
				}
				
			},
			error:function(e){
				alert(e);
			}
		});
	}
	
	function func_reviewCall(){
		var url = "/reviewCall.do";
		var data = {"product_num":"${product.product_num}",
				    "pagePerNum":"5",
			   	    "currentPage":reivew_currentPage,
			   	    "totalPage":rivew_totalPage		   
				   };
		reqServer(url, data);
	}
	
	function printReview(json){
		if(json.reviewList.length > 0){
			console.log(json.reviewList);
			var html = "";
			$(json.reviewList).each(function(index, item){
					html += "<tr class='accordion'>"
			         	 + "<td>"+item.review_num+"<input type='hidden' class='writer' value='"+item.fk_member_num+"' /></td>"
			         	 + "<td class='content-title'>"+item.subject+"</td>"
			         	 + "<td>"+item.name+"</td>"
			         	 + "<td>"+item.write_date+"</td>"
			         	 + "<td class='hit'>"+item.hit+"</td>"
			         	 + "</tr>"
				         + "<tr class='panel panel-none'>"
				         + "<td colspan='5' class='review_content'>"+item.content;
				if(item.imageList.length>0){
					 $(item.imageList).each(function(index2, item2){
						  html+="<div><img src='<%=ctxPath%>/Upload/"+item2+"' / style='margin-bottom:10px;'></div>";
					  });
				}
				if(item.fk_member_num == "${sessionScope.loginuser.member_num}"){
					html+=" <div class='userBtn' align='right'>"
					     +" <span>수정</span><span onclick='goReviewDel("+item.review_num+")'>삭제</span> "
					     +" </div> ";
				}
				html += "</td>"
			         + "</tr>";
			         	 
			});
			$("#review tbody").html(html);
			$("#reviewPageBar").html(json.pageBar);
		}
		else{
			var html = "<td colspan='5'><div class='' align='center'><h5>작성된 후기가 없습니다.</h5></div></td>";
			$("#review tbody").html("<tr>"+html+"</tr>");
			$(".review").css("border-bottom","none");
			
		}
	}
	
	function goReviewDel(num){
		var url="/reviewDel.do";
		var data={"review_num":num};
		reqServer(url, data);
	}
	
	
	
	function func_productQCall(currentPage){
		var url = "/productQCall.do";
		var data = {"product_num":"${product.product_num}",
				   	"pagePerNum":"5",
				   	"currentPage":currentPage,
				   	"totalPage":productQ_totalPage
		           };
		reqServer(url, data);
	}
	
	function printProductInquiry(json){
		 console.log($(json.productQList));
		if($(json.productQList).length > 0){
			var html="";
			$(json.productQList).each(function(index, item){
				html += "<tr class='accordion' onclick='inquiryOpen(this)'>"
				      + "<td>"+item.inquiry_num+"<input type='hidden' class='secret' value='"+item.secretFlag+"'/></td>"
				      + "<td class='content-title'>"+item.subject+"<input type='hidden' class='writer' value='"+item.fk_member_num+"'</td>"
				      + "<td>"+item.name+"</td>"
				      + "<td>"+item.write_date+"</td>"
				      + "</tr>"
				      + "<tr class='panel panel-none'>"
				      + "<td colspan='5' class='review_content'>"+item.content;
					  if(item.imageList.length > 0){
						  $(item.imageList).each(function(index2, item2){
							  html+="<div><img src='<%=ctxPath%>/Upload/"+item2+"' / style='margin-bottom:10px;'></div>";
						  })
					  }  
					  if(item.fk_member_num == "${sessionScope.loginuser.member_num}"){
							html+=" <div class='userBtn' align='right'>"
							     +" <span onclick='goInquiryUpdate("+item.inquiry_num+","+item.fk_member_num+")'>수정</span><span onclick ='goInquiryDelete("+item.inquiry_num+")'>삭제</span> "
							     +" </div> ";
						}
			    html += "</td>"
					  + "</tr>";
			});
			$("#question tbody").html(html); 
			$("#inqueruyPageBar").html(json.pageBar);
		}
		else{
			var html = "<td colspan='5'><div class='' align='center'><h5>작성된 상품문의가 없습니다.</h5></div></td>";
			$("#question tbody").html("<tr>"+html+"</tr>");
			$(".goodsQ").css("border-bottom","none");
			
		}
	}
	
	
	function inquiryOpen(elem){
		
		var $target = $(elem).next();
		var $other = $target.siblings();
		var secretFlag = $(elem).find(".secret").val();
		var writer = $(elem).find(".writer").val();
		var loginuser = '${sessionScope.loginuser.member_num}';
		
		if(secretFlag==1 && writer != loginuser){
			alert("비밀글은 작성자만 볼 수 있습니다.");
			return;
		}
		
		$other.each(function(index, item){
			if($(item).hasClass("panel")){
			   $(item).addClass("panel-none");	
			}
		});
		
		console.log(elem);
		console.log($target);
		
		$target.toggleClass("panel-none");
		offSet[2] = $(".detailTablePart")[2].offsetTop;
	}
	
	function goInquiryDelete(num){
		var url="/inquiryDel.do";
		var data={"inquiry_num":num};
		reqServer(url, data);
	}
	
	function goInquiryUpdate(num, idx){
		alert(num+"/"+idx)
		location.href="<%=ctxPath%>/inquiryUp.do?inquiry_num="+num+"&member_num="+idx;
	}
	
	
	function reqServer(url, data){
		$.ajax({
			url:"<%=ctxPath%>"+url,
			data:data,
			type:"POST",
			dataType:"JSON",
			success:function(json){
				console.log("ajax확인");
				console.log(json);
				if(url=="/reviewCall.do"){
					printReview(json);
				}
				else if(url=="/productQCall.do"){
					printProductInquiry(json);
				}
				else if(url=="/inquiryDel.do"){
					alert(json.message);
					location.reload(true);
				}
				else if(url=="/reviewDel.do"){
					alert(json.message);
					location.reload(true);
				}
			},
			error:function(e){
				console.log(e);
			}
		});
	}
	
 
	function goWriteQ(num){
		location.href="<%=ctxPath %>/productQwrite.do?product_num="+num;
	}
	
	function goReview(num){
		location.href="<%=ctxPath %>/member/myPageReviewWrite.do?product_num="+num;
	}

</script>
</head>
<body>
	<div class="Mycontainer">
		<jsp:include page="../include/header.jsp"></jsp:include>
		<div class="section" align="center">
			<div class="contents">
				<div class="info" style="margin-top:15px";>
					<div class="goodsImg">
						<img alt="상품1" src="<%=ctxPath %>/images/${product.representative_img}" />
					</div>
					<div class="goodsInfo">
						<span style="color: #333; font-size: 24px;">${product.product_name}</span>
						
						<dl>
							<c:if test = "${product.sale != 0 }">
								<dt style="font-size:28px; margin-top: 20px;"><fmt:formatNumber value="${product.finalPrice}" pattern="###,###" />원
								&nbsp;<span style="color: #FA622F;">${product.sale}%</span>
								<br/><span style="font-size: 15px; color: #CCC !important; text-decoration: line-through;"><fmt:formatNumber value="${product.price}" pattern="###,###" />원</span>
								</dt>
							</c:if>
							<c:if test = "${product.sale == 0 }">
								<dt style="font-size:28px"><fmt:formatNumber value="${product.finalPrice}" pattern="###,###" />원</dt>
							</c:if>
							
						</dl>
						
						<dl>
							<dt>분류</dt>
							<dd>${product.category_content} / ${product.subcategory_content }</dd>
						</dl>
						<dl>
							<dt>판매단위</dt>
							<dd>${product.unit }</dd>
						</dl>
						<dl class="underLine">
							<dt>배송구분</dt>
							<dd>택배배송</dd>
						</dl>
						<c:if test="${!empty(product.origin)}">
						<dl class="underLine">
							<dt>원산지</dt>
							<dd>${product.origin}</dd>
						</dl>
						</c:if>
						<c:if test="${!empty(product.packing)}">
						<dl class="underLine">
							<dt>포장타입</dt>
							<dd>${product.packing}</dd>
						</dl>
						</c:if>
						<dl class="underLine">
							<dt>구매수량</dt>
							<dd><span class="count"><button onclick="cntMynus()">-</button><input type="text" value="1" size="3" readonly id="count"/><button onclick="cntPlus()">+</button></span></dd>
						</dl>
						<div class="price" align="right" >
							총 상품금액 : <span class="money"></span>원
							<input type="hidden" class="numPrice" />
							<br />
							<span class="fakebtn">재입고 알림</span>
							<span class="basket" onclick="inBasket()">장바구니 담기</span>
						</div>
					</div>
				</div>
				
				<div class="detailTable">
					<div class="detailTablePart" id="info">
						<div class="tab">
							<button class="tablinks choice" onclick="goTable('0')">상품 정보</button>
							<button class="tablinks" onclick="goTable('1')">고객 후기</button>
							<button class="tablinks" onclick="goTable('2')" style="border-right:solid 1px #bfbfbf">상품 문의</button>
						</div>

						<div style="clear:both;"></div>
						<div id="mainImage" style="width:100%; padding-bottom:10px; border-bottom:solid 1px #bfbfbf;">
							<c:if test="${product.imageList!=null}">
								<c:forEach var="image" items="${product.imageList}">
									<img src="<%=ctxPath %>/images/${image}"  style="margin:20px 0;"/>
								</c:forEach>
							</c:if>
							
							<h3 >${product.product_name}</h3>
						</div>
						<div style="margin-top:15px; font-size: 18pt; line-height: 32px; color:gray; font-family: noto sans; font-weight: 200;">
							${product.explain}
						</div>


						<c:if test="${not empty product.imageList}">
							<c:forEach var="image" items="${product.imageList}">
								<img src="<%=ctxPath %>/images/${image}" style="margin: 0 auto;"/>
							</c:forEach>
						</c:if>
						
						<div>${product.explain}</div>

					</div>
				
					
				
					<div class="detailTablePart" id="review">
						<div class="tab">
							<button class="tablinks" onclick="goTable('0')">상품 정보</button>
							<button class="tablinks choice" onclick="goTable('1')">고객 후기</button>
							<button class="tablinks" onclick="goTable('2')" style="border-right:solid 1px #bfbfbf">상품 문의</button>
						</div>
						<table class="table review" style="border-bottom:solid 1px #bfbfbf;">
							<thead>
								<tr>
									<th style="border:none" class="tableTitle">고객 후기</th>
								</tr>
								<tr>
									<td>글 번호</td>
									<td style="width:50%;">제목</td>
									<td>작성자</td>
									<td>작성날짜</td>
									<td>조회 수</td>
								</tr>
							</thead>
							<tbody>
								<tr class="accordion">
									<td>0</td>
									<td class="content-title" >test</td>
									<td>이주명</td>
									<td>작성날짜</td>
									<td>조회 수</td>
								</tr>
								<tr class="panel panel-none">
									<td colspan="5"><div class="review_content">내용1</div></td>
								</tr>
								
								<tr class="accordion">
									<td>0</td>
									<td class="content-title" >test</td>
									<td>이주명</td>
									<td>작성날짜</td>
									<td>조회 수</td>
								</tr>
								<tr class="panel panel-none">
									<td colspan="5"><div class="review_content">내용1</div></td>
								</tr>
								
								<tr class="accordion">
									<td>0</td>
									<td class="content-title" >test</td>
									<td>이주명</td>
									<td>작성날짜</td>
									<td>조회 수</td>
								</tr>
								<tr class="panel panel-none">
									<td colspan="5">
										<div class="review_content">내용</div>
										<div class="userBtn" align="right">
											<span>수정</span><span>삭제</span>
										</div>
									</td>
								</tr>
							</tbody>
						</table>
						<div id="reviewPageBar"></div>
						<p align="right">
							<span class="writeBtn" onclick="goReview('${product.product_num}')">후기 쓰기</span>
						</p>
					</div>
				
				
					<div class="detailTablePart" id="question">
						<div class="tab">
							<button class="tablinks" onclick="goTable('0')">상품 정보</button>
							<button class="tablinks" onclick="goTable('1')">고객 후기</button>
							<button class="tablinks choice" onclick="goTable('2')" style="border-right:solid 1px #bfbfbf">상품 문의</button>
						</div>
						<table class="table goodsQ" style="border-bottom:solid 1px #bfbfbf;">
							<thead>
								<tr>
									<th style="border:none" class="tableTitle">상품 문의</th>
								</tr>
								<tr>
									<td>글 번호</td>
									<td style="width:50%;">제목</td>
									<td>작성자</td>
									<td>작성날짜</td>
								</tr>
							</thead>
							<tbody>
								<tr class="accordion">
									<td>0</td>
									<td class="content-title" >test</td>
									<td>이주명</td>
									<td>작성날짜</td>
									<td>조회 수</td>
								</tr>
								<tr class="panel panel-none">
									<td colspan="5"><div class="review_content">내용1</div></td>
								</tr>
								
								<tr class="accordion">
									<td>0</td>
									<td class="content-title" >test</td>
									<td>이주명</td>
									<td>작성날짜</td>
									<td>조회 수</td>
								</tr>
								<tr class="panel panel-none">
									<td colspan="5"><div class="review_content">내용1</div></td>
								</tr>
								
								<tr class="accordion">
									<td>0</td>
									<td class="content-title" >test</td>
									<td>이주명</td>
									<td>작성날짜</td>
									<td>조회 수</td>
								</tr>
								<tr class="panel panel-none">
									<td colspan="5">
										<div class="review_content">내용</div>
										<div class="userBtn" align="right">
											<span>수정</span><span>삭제</span>
										</div>
									</td>
								</tr>
							</tbody>
						</table>
						<div id="inqueruyPageBar"></div>
						<p align="right">
							<span class="writeBtn" onclick="location.href='javascript:history.back()'">뒤로가기</span><span class="writeBtn" onclick="goWriteQ('${product.product_num}')">문의 쓰기</span>
						</p>
					</div>
				</div>
			</div>
		</div>
		<jsp:include page="../include/footer.jsp"></jsp:include>
	</div>
</body>
</html>