<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>마이페이지 주문내역</title>
<link rel="stylesheet" href="css/style.css" />

<style type="text/css">
	.contents {
		border: solid 1px black;
	}
	
	#myPage_Side {
		border: solid 1px red;
		width: 20%;
		float: left;
	}
	
	#myPage_Contents {
		/* border: solid 1px blue; */
		width: 75%;
		float: right;
	}
	
	#myPage_SideMenu, .myPage_SideInnerMenu {
		border: solid 1px gray;
		border-collapse: collapse;
	}
	
	.myPage_SideInnerMenu {
		width: 200px;
		height: 50px;
	}
	
	li {
		list-style-type: none;
	}	
	
	#myOrderHistory_Header {
		border: solid 1px pink;
		margin-top: 5px;
	}
	
	#myOrderHistory_Title {
		border: solid 1px blue;
		display: inline;
		float: left;
		font-size: 16pt;
	}
	
	#myOrderHistory_List {
		border: solid 1px navy;
	}
	
	#myOrderHistory_Text {
		border: solid 1px red;
		display: inline;
		margin: 30px 0 0 10px;
		vertical-align: middle;
		float: left;
		font-size: 8pt;
	}
	
	#mySelectTerm {
	
	}
	
	/*
	.sideMenu {
		border: solid 1px gray;
		display: table;
		vertical-align: middle;
		text-align: left;
		width: 200px;
		height: 50px;
		cursor: pointer;
	}	
	
	.sideMenu:hover {
		color: green;
		background-color: #eee;
	}
	
	#myOrderHistory {
		display: inline-block;
		width: 75%;		
		float: right;
	}
	
	#myOrderHistoryTitle {
		border: solid 1px blue;
		display: inline;
		float: left;
		font-size: 16pt;
	}
	
	#text {
		border: solid 1px red;
		display: inline;
		margin: 30px 0 0 10px;
		vertical-align: middle;
		float: left;
		font-size: 8pt;
	}
	
	.mySelectTerm {	
		display: inline-block;
		float: right;
		margin: 30px 0 0 10px;
	}
	
	.list_order {
		border: solid 1px blue;
		display: inline-block;
		clear: both;
		width: 100%;		
	} */
	
</style>

<script type="text/javascript">
	
</script>

</head>
<body>	
	<div class="container">
		<jsp:include page="include/header.jsp"></jsp:include>
		<div class="section" align="center">
			<div class="contents">	
			
			<div id="myPage_Side">
				<h2 id="myPage_Title">마이페이지</h2>
				<div id="myPage_Menu">
					<table id="myPage_SideMenu">
						<tr>
							<td class="myPage_SideInnerMenu"><a>주문 내역</a></td>
						</tr>
						<tr>
							<td class="myPage_SideInnerMenu"><a>상품후기</a></td>
						</tr>
						<tr>
							<td class="myPage_SideInnerMenu"><a>개인 정보 수정</a></td>
						</tr>
						<tr>
							<td class="myPage_SideInnerMenu"><a>1:1 문의</a></td>
						</tr>
					</table>
				</div>
			</div>
				
			<div id="myPage_Contents">		
				<div id="myOrderHistory_Header">
					<h2 id="myOrderHistory_Title">주문 내역</h2>
					<span id="myOrderHistory_Text">지난 3년간의 주문 내역 조회가 가능합니다</span>
					<ul>
						<li id="mySelectTerm">
							<select name="term" id="term">
								<option value="1" selected>전체기간</option>
								<option value="2">2020년</option>
								<option value="3">2019년</option>
								<option value="4">2018년</option>
							</select>
						</li>
					</ul>
				</div>
			
				<ul id="myOrderHistory_List">
					<li>
						<div class="date">0000.00.00 (00시 00분)</div>
						<div class="order_goods"><div class="name">
						<a>상품명</a>
						</div>
						<div class="order_info">
							<div class="thumb">
								<img src="https://img-cf.kurly.com/shop/data/goods/1514871081387s0.jpg" alt="해당 주문 대표 상품 이미지">
							</div> 
							<div class="desc">
								<dl>
									<dt>주문번호</dt> 
									<dd>1111111111</dd>
								</dl> 
								<dl>
									<dt>결제금액</dt> 
									<dd>11,111원</dd>
									</dl>
								<dl>
									<dt>주문상태</dt> 
									<dd class="status end">배송완료</dd>
								</dl>
							</div>
						</div>
						<div class="order_status">
						<span class="inner_status">
							<a class="link link_review ga_tracking_event">후기 쓰기</a>
							<a class="link ga_tracking_event">1:1 문의</a>
						</span>
						</div>
						</div>
					</li>
				</ul>
			</div>
			<div style="clear:both;"></div>
		</div>
		</div>		
		<jsp:include page="include/footer.jsp"></jsp:include>
	</div>
</body>
</html>






















