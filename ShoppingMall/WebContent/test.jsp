<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>index.jsp</title>
<link rel="stylesheet" href="css/style.css" />
<style type="text/css">

	#container{
		width:1080px;
		margin: auto;
	}
	
	#payment_header{
		text-align: center;
	}
	
	.payment_title{
		padding-top: 50px;
		padding-bottom: 10px;
		border-bottom: solid 1px #5F0080;
	}

	#tbl_1{
		border-bottom: solid 1px gray;
	}
	
	tr, td{
		padding:10px;
	}
	
	th_info{
		text-align: center;
	}
	
	th{
		width: 200px;
		text-align: left;
	}

</style>
<script type="text/javascript">
	
</script>
</head>
<body>
	
	<div class="container">
		<jsp:include page="include/header.jsp"></jsp:include>
		<div class="section" align="center">
			<div class="contents">
			
				<!-- 1 -->						
				<div id="payment_header">
					<h3>주문서</h3>
					<p>주문하실 상품명 및 수량을 정확하게 확인해 주세요</p>
				</div>
				<div id="productInfo">
					<div class="payment_title">상품정보</div>
					<table id="productList">
						<thead id="tbl_1">
							<tr id="th_info">
								<th></th>
								<th>상품 정보</th>
								<th>상품 금액</th>
							</tr>					
						</thead>
						<tbody>
							<tr>
								<td></td>
								<td>계란 웅앵</td>
								<td>1000원</td>
							</tr>
						</tbody>			
					</table>
				</div>
				
				<!-- 2 -->
				<div id="ordererInfo">
					<div class="payment_title">주문자 정보</div>
					<table>
						<tr>
							<th>보내는분</th>
							<td>나나</td>
						</tr>
						<tr>
							<th>휴대폰</th>
							<td>010</td>
						</tr>
						<tr>
							<th>이메일</th>
							<td>
								<span>hha_</span>
								<p>이메일을 통해 주문처리과정을 보내드립니다.<br/>정보 변경은 마이컬리>개인벙보 수정 메뉴에서 가능합니다.</p>
							</td>
						</tr>
					</table>
				</div>
	
	
			</div>
		</div>
	</div>
		
	<jsp:include page="include/footer.jsp"></jsp:include>
		
</body>
</html>