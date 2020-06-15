<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>상품리스트</title>
</head>
<link rel="stylesheet" href="css/style.css" />
<style>
	div#smallT, .productList {
		border: solid 0px gray;
		display: inline-block;
		margin: 30px;
	}
	li {
		border: solid 1px gray;
		display: inline-block;
		cursor: pointer;
	}
	li:hover {
		border: solid 3px purple;
	}
	li>img {
		width: 300px;
		height: 400px;
	}
	h3{
		margin-left: 30px;
	}
	h4 {
		border-bottom: solid 2px purple;
		width: 100px;
		margin-left: 30px;
		cursor: pointer;
	}
	#smallT {
		float: left;
	}
	#list {
		border: solid 0px red;
		margin-top: 80px;
		float: right;
	}
</style>
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.1/css/bootstrap.min.css">
<link rel="stylesheet" href="css/style.css" />
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
<script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.1/js/bootstrap.min.js"></script>
<script type="text/javascript" src="/ShoppingMall/js/jquery-3.3.1.min.js"></script>
<script type="text/javascript" src="/ShoppingMall/util/myutil.js"></script>
<script type="text/javascript">
	
	$(document).ready(function(){
		
		$("li").click(function(){
			
			alert("상품을 선택하셨습니다");
			
		});
		
		$("h4").click(function(){
			
			alert("전체보기를 선택하셨습니다");
			
		});
		
	});
	
</script>
<body>
	<div class="Mycontainer">
		<jsp:include page="include/header.jsp"></jsp:include>
		<div class="section" align="center">
			<div class="contents">
			
				<div id="smallT">
					<h3>상품 리스트</h3>
					<h4>전체보기</h4>
				</div>
				<div id="list">
					<select>
						<option>신상품순</option>
						<option>인기상품순</option>
						<option>낮은 가격순</option>   
						<option>높은 가격순</option>
					</select>
				</div>
				
				<div class="productList" align="center">
					<div>
						<li class="product" id="product1">
							<img alt="상품1" src="images/iscream.png"><br/>
							루비 싱글 바<br/>
							<span>3,600 원</span>
						</li>
						<li class="product" id="product2">
							<img alt="상품2" src="images/salad.png"><br/>
							병 샐러드<br/>
							<span>6,200 원</span>
						</li>	
						<li class="product" id="product3">
							<img alt="상품3" src="images/milk.png"><br/>
							동물복지 우유<br/>
							<span>2,650 원</span>
						</li>
					</div>
					<div>
						<li class="product" id="product4">
							<img alt="상품1" src="images/iscream.png"><br/>
							루비 싱글 바<br/>
							<span>3,600 원</span>
						</li>
						<li class="product" id="product5">
							<img alt="상품2" src="images/salad.png"><br/>
							병 샐러드<br/>
							<span>6,200 원</span>
						</li>	
						<li class="product" id="product6">
							<img alt="상품3" src="images/milk.png"><br/>
							동물복지 우유<br/>
							<span>2,650 원</span>
						</li>
					</div>
					<div>
						<li class="product" id="product7">
							<img alt="상품1" src="images/iscream.png"><br/>
							루비 싱글 바<br/>
							<span>3,600 원</span>
						</li>
						<li class="product" id="product8">
							<img alt="상품2" src="images/salad.png"><br/>
							병 샐러드<br/>
							<span>6,200 원</span>
						</li>	
						<li class="product" id="product9">
							<img alt="상품3" src="images/milk.png"><br/>
							동물복지 우유<br/>
							<span>2,650 원</span>
						</li>
					</div>
			</div>
		</div>
		
		<jsp:include page="include/footer.jsp"></jsp:include>
		
		</div>
	</div>
</body>
</html>