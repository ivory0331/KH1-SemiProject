<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>detail.jsp</title>
<link rel="stylesheet" href="css/style.css" />
<style type="text/css">
	.productImg{
		display: inline-block;
		width: 350px;
		float:left;
		border:solid 1px black;
	}
	
	.productImg > img{
		width:100%;
		height:440px;
	}
	
	.productInfo{
		float:right;
		width:600px;
		margin-right:30px;
		text-align: left;
		border: solid 0px blue;
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
	
	.count input[type='number']{
		width: 35px;
		text-align: center;
	}
	
	.money{
		font-size: 24pt;
		font-weight: bold;
	}
	
	.detailTable{
		clear:both;
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
</style>
<script type="text/javascript" src="/ShoppingMall/js/jquery-3.3.1.min.js"></script>
<script type="text/javascript" src="/ShoppingMall/util/myutil.js"></script>
<script type="text/javascript">
	var money = "1000";
	
	$(document).ready(function(){
		
		$(".numPrice").val(money);
		$(".money").html(func_comma(money));
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
	
	

</script>
</head>
<body>
	
	<div class="container">
		<jsp:include page="include/header.jsp"></jsp:include>
		<div class="section" align="center">
			<div class="contents">
				<div class="info">
					<div class="productImg">
						<img alt="상품1" src="include/images/logo.png" />
					</div>
					<div class="productInfo">
						<p><strong>상품명</strong></p>
						<span>가격</span>
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
							<dd><spna class="count"><button onclick="cntMynus()">-</button><input type="number" value=1 max="999"  readonly id="count"/><button onclick="cntPlus()">+</button></spna></dd>
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
					
				</div>
			</div>
		</div>
		<jsp:include page="include/footer.jsp"></jsp:include>
	</div>
</body>
</html>