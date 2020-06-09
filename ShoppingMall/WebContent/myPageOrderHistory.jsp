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
		min-height: 600px;
	}
	
	#myPage_Side {
		/* border: solid 1px red; */
		width: 20%;
		float: left;
	}
	
	#myPage_Contents {
		/* border: solid 1px blue; */
		width: 78%;
		float: right;
	}
	
	#myPage_SideMenu, .myPage_SideInnerMenu {
		border: solid 1px gray;
		border-collapse: collapse;
	}
	
	.myPage_SideInnerMenu > a {
		display: table-cell;
		vertical-align: middle;
		padding-left: 5px;
		width: 200px;
		height: 50px;
		color: black;
	}
	
	.myPage_SideInnerMenu > a:hover {
		color: green;
		background-color: #eee;
		text-decoration: none;
		cursor: pointer;
	}
	
	li {
		list-style-type: none;
	}	
	
	#myOrderHistory_Header {
		/* border: solid 1px pink; */
		margin-top: 5px;
	}
	
	#myOrderHistory_List {
		/* border: solid 1px navy; */
	}
	
	#myOrderHistory_Title {
		/* border: solid 1px blue; */
		font-size: 16pt;
		display: inline-block;
		float: left;
	}
	
	#myOrderHistory_Text {
		/* border: solid 1px red; */	
		font-size: 8pt;
		display: inline-block;
		margin: 30px 0 0 10px;
		float: left;
	}
	
	#mySelectTerm {
		display: inline-block;				
		margin: 25px 10px 0 0;
		float: right;
	}
	
	#line {
		border-top: solid 2px #5f0080;
		height: 20px;
	}
	
	.myOrder_Date {
		/* border: solid 1px red; */
		text-align: left;
	}
	
	.myOrder_Goods {
		border: solid 1px #eee;
	}
	
	.myOrder_Name {
		/* border: solid 1px cyan; */
		border-bottom: solid 1px #eee;
		padding: 10px 5px;
		text-align: left;
		color: black;
	}
	
	.myOrder_Name > a {
		color: black;
	}
	
	.myOrder_Name > a:hover {
		text-decoration: none;
		color: black;
		cursor: pointer;
	}
	
	.myOrder_Info {
		/* border: solid 1px orange; */
		display: inline-block;
		width: 80%;
	}
	
	.myOrder_Image > img {
		/* border: solid 1px purple; */
		margin: 5px;
		width: 60px;
		height: 75px;
		float: left;
	}
	
	.myOrder_Desc > dl {
		float: left;
		display: inline-block;
	}
	
	.myOrder_Desc {
		/* border: solid 1px lime; */
		margin: 16px 0 0 10px;
		display: inline-block;
		float: left;
		font-size: 10pt;
	}

	.mytd1 {
		width: 80px;
	}
	
	.myOrder_Status {
		/* border: solid 1px lime; */
		display: inline-block;
		width: 15%;
	}
	
	a.link {
		border: solid 1px #5f0080;
		display: inline-block; 
		float: right;
		width: 100px;
		padding: 5px 0;
		margin: 5px;
	}
	
	a.link_review {
		color: white;
		font-weight: bold;
		background-color: #5f0080;
	}
	
	a.link_review:hover {
		text-decoration: none;		
		color: white;
		cursor: pointer;
	}
	
	a.link_question {
		color: #5f0080;
		background-color: white;
	}
	
	a.link_question:hover {
		text-decoration: none;		
		color: #5f0080;
		cursor: pointer;
	}

}
	
	
</style>

<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.1/css/bootstrap.min.css">
<link rel="stylesheet" href="css/style.css" />
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
<script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.1/js/bootstrap.min.js"></script>
<script type="text/javascript" src="/ShoppingMall/js/jquery-3.3.1.min.js"></script>
<script type="text/javascript" src="/ShoppingMall/util/myutil.js"></script>

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
					<div id="line" style="clear:both;"></div>
				</div>
			
				<div id="myOrderHistory_List">
					<div>
						<div class="myOrder_Date">0000.00.00 (00시 00분)</div>
						<div class="myOrder_Goods">
							<div class="myOrder_Name">
								<a>상품명 (ex.코코넛간식) 외 2건</a>
							</div>
							<div class="myOrder_block">
								<div class="myOrder_Info">
									<div class="myOrder_Image">
										<img src="https://img-cf.kurly.com/shop/data/goods/1514871081387s0.jpg" alt="해당 주문 대표 상품 이미지">
									</div> 
									<table class="myOrder_Desc">
										<tr>
											<td class="mytd1">주문번호</td>
											<td class="mytd2">1111111111</td>
										</tr>
										<tr>
											<td class="mytd1">결제금액</td>
											<td class="mytd2">11,111원</td>
										</tr>
										<tr>
											<td class="mytd1">주문상태</td>
											<td class="status end mytd2">배송완료</td>
										</tr>															
									</table>						
									<div style="clear:both;"></div>
								</div>						
								<div class="myOrder_Status">
									<span class="myOrder_InnerStatus">
										<a class="link link_review">후기 쓰기</a>
										<a class="link link_question">1:1 문의</a>
									</span>
								</div>
							</div>
						</div>
					</div>						
				</div>				
			</div>
				
			</div>
			<div style="clear:both;"></div>
		</div>	
		<jsp:include page="include/footer.jsp"></jsp:include>
	</div>
</body>
</html>






















