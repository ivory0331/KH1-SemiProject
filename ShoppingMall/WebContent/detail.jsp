<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>detail.jsp</title>

<style type="text/css">
	

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
	
	.goodsInfo{
		display: inline-block;
		width:600px;
		margin-right:30px;
		text-align: left;
	}
	
	dt{
		
		display: inline-block;
		width: 200px;
		
	}
	
	dd{
		margin-left:-10px;
		display: inline-block;
		width: 350px;
		
	}
	
	.count input[type='text']{
		text-align: center;
	}
	
	.money{
		font-size: 24pt;
		font-weight: bold;
	}
	
	.detailTable{
		clear:both;
		width: 1080px;
		margin-top:50px;
	}
	
	.table{
		width: 1080px;
	}
	
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
	  width: 100%;
	  border: none;
	  text-align: left;
	  outline: none;
	  font-size: 15px;
	  transition: 0.4s;
	}
	
	
	
	.panel {
	  display: none;
	  background-color: white;
	  overflow: hidden;
	  text-align: left;
	  margin : 0px ; 
	
	}
	
	.goodsQ_content{
		min-height: 200px;
	}
	
	.review_content{
		min-height: 200px;
	}
	
	.userBtn{
		width:1080px;
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
 <link rel="stylesheet" href="css/style.css" />
 <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
 <script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.1/js/bootstrap.min.js"></script>
<script type="text/javascript" src="/ShoppingMall/js/jquery-3.3.1.min.js"></script>
<script type="text/javascript" src="/ShoppingMall/util/myutil.js"></script>
<script type="text/javascript">

	var money = "1000";
	var offSet = new Array();
	
	
	$(document).ready(function(){
		
		$(".numPrice").val(money);
		$(".money").html(func_comma(money));
		
		for(var i=0; i<$(".detailTablePart").length; i++){
			offSet[i] = $(".detailTablePart")[i].offsetTop;
		}
		
		
		var acc = document.getElementsByClassName("accordion");

		for (i = 0; i < acc.length; i++) {
		  acc[i].addEventListener("click", function() {
		    this.classList.toggle("active");
		    var panel = this.nextElementSibling;
		    if (panel.style.display === "block") {
		      panel.style.display = "none";
		    } else {
		      panel.style.display = "block";
		    }
		  });
		}
		
		
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
		
		var top = offSet[num]-Number("81");
		console.log("top:"+top);
		$('html, body').animate({scrollTop : top}, 0);
		
		
	}

</script>
</head>
<body>
	<div class="Mycontainer">
		<jsp:include page="include/header.jsp"></jsp:include>
		<div class="section" align="center">
			<div class="contents">
				<div class="info">
					<div class="goodsImg">
						<img alt="상품1" src="include/images/logo.png" />
					</div>
					<div class="goodsInfo">
						<p><strong>상품명</strong></p>
						<dl>
							<dt>판매단위</dt>
							<dd>1팩</dd>
						</dl>
						<dl class="underLine">
							<dt>중량/용량</dt>
							<dd>100g</dd>
						</dl>
						<dl class="underLine">
							<dt>배송구분</dt>
							<dd>샛별배송/택배배송</dd>
						</dl>
						<dl class="underLine">
							<dt>원산지</dt>
							<dd>국산</dd>
						</dl>
						<dl class="underLine">
							<dt>포장타입</dt>
							<dd>냉장/종이포장</dd>
						</dl>
						<dl class="underLine">
							<dt>유통기한</dt>
							<dd>농산물임으로 별도 유통기한은 없으나 가급적 빨리 드시기 바랍니다.</dd>
						</dl>
						<dl class="underLine">
							<dt>구매수량</dt>
							<dd><spna class="count"><button onclick="cntMynus()">-</button><input type="text" value="1" size="3" readonly id="count"/><button onclick="cntPlus()">+</button></spna></dd>
						</dl>
						<div class="price" align="right" >
							총 상품금액 : <span class="money"></span>원
							<input type="hidden" class="numPrice" />
							<br />
							<span class="basket">장바구니 담기</span>
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
						
						<img alt="상품이미지1" src="include/images/logo.png" class="otherImg">
						<img alt="상품이미지1" src="include/images/logo.png" class="otherImg">
						<img alt="상품이미지1" src="include/images/logo.png" class="otherImg">
						<div>상품정보(설명)</div>
					</div>
				
					<div class="detailTablePart" id="review">
						<div class="tab">
							<button class="tablinks" onclick="goTable('0')">상품 정보</button>
							<button class="tablinks choice" onclick="goTable('1')">고객 후기</button>
							<button class="tablinks" onclick="goTable('2')" style="border-right:solid 1px black">상품 문의</button>
						</div>
						<table class="table review" style="border-bottom:solid 1px gray;">
							<tr>
								<th style="border:none" class="tableTitle">고객 후기</th>
							</tr>
							<tr class="accordion">
								<td >Section 1</td>
							</tr>
							<tr class="panel">
								<td ><div class="review_content">내용</div></td>
							</tr>
							
							<tr class="accordion">
								<td >Section 2</td>
							</tr>
							<tr class="panel">
								<td ><div class="review_content">내용</div></td>
							</tr>
							
							<tr class="accordion">
								<td >Section 3</td>
							</tr>
							<tr class="panel">
								<td colspan="2">
									<div class="review_content">내용</div>
									<div class="userBtn" align="right">
										<span>수정</span><span>삭제</span>
									</div>
								</td>
							</tr>
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
							<tr>
								<th style="border:none" class="tableTitle">상품 문의</th>
							</tr>
							<tr class="accordion">
								<td >Section 1</td>
							</tr>
							<tr class="panel">
								<td ><div class="goodsQ_content">내용</div></td>
							</tr>
							
							<tr class="accordion">
								<td >Section 2</td>
							</tr>
							<tr class="panel">
								<td ><div class="goodsQ_content">내용</div></td>
							</tr>
							
							<tr class="accordion">
								<td >Section 3</td>
							</tr>
							<tr class="panel">
								<td colspan="2">
									<div class="goodsQ_content">내용</div>
									<div class="userBtn" align="right">
										<span>수정</span><span>삭제</span>
									</div>
								</td>
							</tr>
						</table>
						<p align="right">
							<span class="writeBtn">목록 보기</span></a><a><span class="writeBtn">문의 쓰기</span>
						</p>
					</div>
				</div>
			</div>
		</div>
		<jsp:include page="include/footer.jsp"></jsp:include>
	</div>
</body>
</html>