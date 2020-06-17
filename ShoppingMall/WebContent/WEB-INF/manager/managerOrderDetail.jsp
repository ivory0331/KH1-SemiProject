<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>managerOrderDetail.jsp</title>
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
	
	.orderInfo{
		display:inline-block;
		width: 900px;
		margin-left:10px;
	}
	
	.part{
		width: 100%;
		margin-top:10px;
		min-height: 200px;
		border:solid 1px black;
	}
	
	.orderGoods-img{
		width:100px;
		height:100px;
		border:solid 1px black;
	}
	
	.orderGoods-info{
		width:700px;
		text-align: left;
		border-left:solid 1px gray;
		
	}
	
	.orderGoods-info > ul{
		list-style: none;
		padding:0;
	}
	
	
</style>
<!-- 부트스트랩 -->
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.1/css/bootstrap.min.css">
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
<script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.1/js/bootstrap.min.js"></script>
<script type="text/javascript" src="/ShoppingMall/js/jquery-3.3.1.min.js"></script>
<script type="text/javascript" src="/ShoppingMall/util/myutil.js"></script>
<script type="text/javascript">
	
	$(document).ready(function(){
		
	});
		
	
	
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
				<div class="orderInfo">
					<div id="goodsOrderList" class="part">
						상품리스트
						<table class="table">
							<tr>
								<td class="orderGoods-img">이미지</td>
								<td class="orderGoods-info">
									<ul>
										<li>상품명</li>
										<li>구매 수</li>
										<li>금액</li>
										<li>주문상태</li>
									</ul>
								</td>
							</tr>
							<tr>
								<td class="orderGoods-img">이미지</td>
								<td class="orderGoods-info">
									<ul>
										<li>상품명</li>
										<li>구매 수</li>
										<li>금액</li>
										<li>주문상태</li>
									</ul>
								</td>
							</tr>
							<tr>
								<td class="orderGoods-img">이미지</td>
								<td class="orderGoods-info">
									<ul>
										<li>상품명</li>
										<li>구매 수</li>
										<li>금액</li>
										<li>주문상태</li>
									</ul>
								</td>
							</tr>
						</table>
					</div>
					<div id="pay" class="part">
						결제내역
					</div>
					
					<div id=delivery class="part">
						배송정보
					</div>
				</div>
				<div style="clear:both;"></div>
			</div>
		</div>
		<jsp:include page="../include/footer.jsp"></jsp:include>
	</div>
</body>
</html>