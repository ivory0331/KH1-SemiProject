<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<% String ctxPath = request.getContextPath(); %>
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
		border:solid 1px black;
	}
	
	.goodsImg > img{
		width:100%;
		height:440px;
	}
	
	/*상품 이미지의 옆에 나오는 상품 정보가 들어가 있는 div*/
	.goodsInfo{
		display: inline-block;
		width:600px;
		margin-right:30px;
		text-align: left;
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
		width: 240px;
		padding:10px 0px;
		text-align: center;
		background-color: purple;
		color: white;
		font-size: 18pt;
		border-radius: 10px;
		margin-top: 5px;
		cursor: pointer;
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
	  padding: 14px 20px;
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
		border: solid 1px purple;
		background-color: #f1f1f1;
		color: purple;
		font-size: 12pt;
		cursor: pointer;
		
	}

	.writeBtn{
		display: inline-block;
		width: 100px;
		padding:15px 0px;
		background-color: purple;
		color: white;
		font-size: 12pt;
		font-weight: bolder;
		text-align: center;
		border-radius: 10px;
		cursor: pointer;
		margin-left: 5px;
		border: solid 1px purple;
	}

	.tab a:hover{
		color:white;
		font-weight: bold;
		background-color: purple;
	}
	
	.writeBtn:hover{
		color: purple;
		background-color: white;
	}

</style>
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.1/css/bootstrap.min.css">

<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
<script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.1/js/bootstrap.min.js"></script>
<script type="text/javascript" src="/ShoppingMall/js/jquery-3.3.1.min.js"></script>
<script type="text/javascript" src="/ShoppingMall/util/myutil.js"></script>
<script type="text/javascript">
	var money = "${product.price}";
	var offSet = new Array();
	
	
	$(document).ready(function(){
		
		$(".numPrice").val(money);
		$(".money").html(func_comma(money));
		
		for(var i=0; i<$(".detailTablePart").length; i++){
			offSet[i] = $(".detailTablePart")[i].offsetTop;
		}
		
		
		var acc = document.getElementsByClassName("accordion");

		for (i = 0; i < acc.length; i++) {
			  acc[i].addEventListener("click", function(event) {
				var $target = $(this).next();
				var $other = $target.siblings();
				$other.each(function(index, item){
					if($(item).hasClass("panel")){
						$(item).addClass("panel-none");	
					}
				});
				$target.toggleClass("panel-none");
			  });
			}
		
		func_reviewCall();
		func_productQCall();
	});
	
	function cntPlus(){
		var $num = $("#count").val();
		var $money = $(".numPrice").val();
		
		if($num<999){
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
		
		if(${sessionScope.loginuser == null}){
			alert("로그인을 하셔야 합니다.");
			location.href="<%=ctxPath%>/member/login.do";
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
				location.reload(true);
			},
			error:function(e){
				alert(e);
			}
		});
	}
	
	function func_reviewCall(){
		var url = "/reviewCall.do";
		var data = {"product_num":"${product.product_num}"};
		reqServer(url, data);
	}
	
	function printReview(json){
		if(json.length > 0){
			for(var i=0; i<json.length; i++){
				var html = "<tr class='accordion'>"
				         + "<td>"+json[i].getReview_num()+"</td>"
				         + "<td class='content-title'>"+json[i].getSubject()+"</td>"
				         + "<td>"+json[i].getName()+"</td>"
				         + "<td>"+json[i].getWrite_date()+"</td>"
				         + "<td>"+json[i].getHit()+"</td>"
				         + "</tr>"
				         + "<tr class='panel panel-none'>"
				         + "<td colspan='5' class='review_content'>"+json[i].getContent();
				for(var j=0; j<json[i].getImageList().length; j++){
					var imageFileName = decodeURIComponent(json[i].getImageList.get(j));
					var imageFile = "<%=ctxPath%>/images/"+imageFileName;
					html+="<img src='"+imageFile+"' />";	
				}
				
				if(json[i].getMember_name() == "${sessionScope.user.name}"){
					html+=" <div class='userBtn' align='right'>"
					     +" <span>수정</span><span>삭제</span> "
					     +" </div> ";
				}
				else{
					html+=" <div class='userBtn' align='right'>"
					     +" <span>좋아요♡</span> "
					     +" </div> ";
				}
				
				html += "</td>"
			         + "</tr>";
			}
			$("#review tbody").html(html);
		}
		else{
			var html = "<td colspan='5'><div class='' align='center'><h3>작성된 후기가 없습니다.</h3></div></td>";
			$("#review tbody").html("<tr>"+html+"</tr>");
			$(".review").css("border-bottom","none");
			
		}
	}
	
	
	function func_productQCall(){
		var url = "/productQCall.do";
		var data = {"product_num":"${product.product_num}"};
		reqServer(url, data);
	}
	
	function printProductInquiry(json){
		if(json.length > 0){
			<%-- for(var i=0; i<json.length; i++){
				var html = "<tr class='accordion'>"
				         + "<td>"+json[i].getReview_num()+"</td>"
				         + "<td class='content-title'>"+json[i].getSubject()+"</td>"
				         + "<td>"+json[i].getName()+"</td>"
				         + "<td>"+json[i].getWrite_date()+"</td>"
				         + "<td>"+json[i].getHit()+"</td>"
				         + "</tr>"
				         + "<tr class='panel panel-none'>"
				         + "<td colspan='5' class='review_content'>"+json[i].getContent();
				for(var j=0; j<json[i].getImageList().length; j++){
					var imageFileName = decodeURIComponent(json[i].getImageList.get(j));
					var imageFile = "<%=ctxPath%>/images/"+imageFileName;
					html+="<img src='"+imageFile+"' />";	
				}
				
				if(json[i].getMember_name() == "${sessionScope.user.name}"){
					html+=" <div class='userBtn' align='right'>"
					     +" <span>수정</span><span>삭제</span> "
					     +" </div> ";
				}
				else{
					html+=" <div class='userBtn' align='right'>"
					     +" <span>좋아요♡</span> "
					     +" </div> ";
				}
				
				html += "</td>"
			         + "</tr>";
			}
			$("#review tbody").html(html); --%>
		}
		else{
			var html = "<td colspan='5'><div class='' align='center'><h3>작성된 상품문의가 없습니다.</h3></div></td>";
			$("#question tbody").html("<tr>"+html+"</tr>");
			$(".goodsQ").css("border-bottom","none");
			
		}
	}
	
	
	
	function reqServer(url, data){
		$.ajax({
			url:"<%=ctxPath%>"+url,
			data:data,
			type:"POST",
			dataType:"JSON",
			success:function(json){
				console.log(json);
				if(url=="/reviewCall.do"){
					printReview(json);
				}
				else if(url=="/productQCall.do"){
					printProductInquiry(json);
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

</script>
</head>
<body>
	<div class="Mycontainer">
		<jsp:include page="../include/header.jsp"></jsp:include>
		<div class="section" align="center">
			<div class="contents">
				<div class="info">
					<div class="goodsImg">
						<img alt="상품1" src="<%=ctxPath %>/images/${product.representative_img}" />
					</div>
					<div class="goodsInfo">
						<h2><strong>${product.product_name}</strong></h2>
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
						<dl class="underLine">
							<dt>원산지</dt>
							<dd>${product.origin}</dd>
						</dl>
						<dl class="underLine">
							<dt>포장타입</dt>
							<dd>${product.packing}</dd>
						</dl>
						<dl class="underLine">
							<dt>구매수량</dt>
							<dd><spna class="count"><button onclick="cntMynus()">-</button><input type="text" value="1" size="3" readonly id="count"/><button onclick="cntPlus()">+</button></spna></dd>
						</dl>
						<div class="price" align="right" >
							총 상품금액 : <span class="money"></span>원
							<input type="hidden" class="numPrice" />
							<br />
							<span class="basket" onclick="inBasket()">장바구니 담기</span>
						</div>
					</div>
				</div>
				
				<div class="detailTable">
					<div class="detailTablePart" id="info">
						<div class="tab">
							<button class="tablinks choice" onclick="goTable('0')">상품 정보</button>
							<button class="tablinks" onclick="goTable('1')">고객 후기</button>
							<button class="tablinks" onclick="goTable('2')" style="border-right:solid 1px black">상품 문의</button>
						</div>
						<img alt="상품이미지1" src="<%=ctxPath %>/images/logo.png" class="otherImg">
						<img alt="상품이미지1" src="<%=ctxPath %>/images/logo.png" class="otherImg">
						<img alt="상품이미지1" src="<%=ctxPath %>/images/logo.png" class="otherImg">
						<div>${product.explain}</div>
					</div>
				
					<div class="detailTablePart" id="review">
						<div class="tab">
							<button class="tablinks" onclick="goTable('0')">상품 정보</button>
							<button class="tablinks choice" onclick="goTable('1')">고객 후기</button>
							<button class="tablinks" onclick="goTable('2')" style="border-right:solid 1px black">상품 문의</button>
						</div>
						<table class="table review" style="border-bottom:solid 1px gray;">
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
						<p align="right">
							<span class="writeBtn">후기 쓰기</span>
						</p>
					</div>
				
				
					<div class="detailTablePart" id="question">
						<div class="tab">
							<button class="tablinks" onclick="goTable('0')">상품 정보</button>
							<button class="tablinks" onclick="goTable('1')">고객 후기</button>
							<button class="tablinks choice" onclick="goTable('2')" style="border-right:solid 1px black">상품 문의</button>
						</div>
						<table class="table goodsQ" style="border-bottom:solid 1px black;">
							<thead>
								<tr>
									<th style="border:none" class="tableTitle">상품 문의</th>
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
						<p align="right">
							<span class="writeBtn" onclick="location.href='<%=ctxPath %>/productList.do'">목록 보기</span><span class="writeBtn" onclick="goWriteQ('${product.product_num}')">문의 쓰기</span>
						</p>
					</div>
				</div>
			</div>
		</div>
		<jsp:include page="../include/footer.jsp"></jsp:include>
	</div>
</body>
</html>