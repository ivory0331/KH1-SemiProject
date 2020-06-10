<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>managerSales.jsp</title>
<link rel="stylesheet" href="css/style.css" />
<!-- 차트 링크 --> 
<script src="https://cdn.jsdelivr.net/npm/chart.js@2.8.0"></script> 
<style type="text/css">
	.sideMenu{
		margin-top:10px;
		display: inline-block;
		width: 150px;
		float:left;
	}
	
	.info{
		display:inline-block;
		width: 900px;
		margin-left:10px;
	}
	
	/*상품 이미지가 보이는 div*/
	.goodsImg{
		float:left;
		display: inline-block;
		width: 200px;
		border:solid 1px black;
	}
	
	.goodsImg > img{
		width:100%;
		height:300px;
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
	
	
</style>
<!-- 부트스트랩 -->
<script type="text/javascript" src="/ShoppingMall/js/jquery-3.3.1.min.js"></script>
<script type="text/javascript" src="/ShoppingMall/util/myutil.js"></script>
<script type="text/javascript">
	var offSet = new Array();
	$(document).ready(function(){
		for(var i=0; i<$(".detailTablePart").length; i++){
			offSet[i] = $(".detailTablePart")[i].offsetTop;
			console.log(offSet[i]);
		}
	});
		
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
				<div class="sideMenu">
					<jsp:include page="include/managerSide.jsp"></jsp:include>
				</div>
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
				<div style="clear:both;"></div>
			</div>
		</div>
		<jsp:include page="include/footer.jsp"></jsp:include>
	</div>
</body>
</html>