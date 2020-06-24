<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<% String ctxPath = request.getContextPath(); %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<link rel="stylesheet" href="<%= ctxPath %>/css/style.css" />
<title>마이페이지 상품후기</title>

<style type="text/css">
	.contents {
		border: solid 0px black;
		min-height: 600px;
	}	    
	
	.menu2 > a {
		color: #5f0080 !important;
		background-color: #eee;
	}			
	
	#myProductReview_Header {
		border: solid 0px pink;
		margin: 5px;		
	}
	
	#myProductReview_List {
		border: solid 0px navy;
	}
	
	#myProductReview_Title {
		border: solid 0px blue;
		font-size: 16pt;
		display: inline-block;
		float: left;
	}
	
	#myProductReview_Text {
		border: solid 0px red;	
		font-size: 8pt;
		display: inline-block;
		margin: 30px 0 0 10px;
		float: left;
	}	
	
	a.tab {
		display: inline-block;	
		width: 416px;
		border: solid 1px #ddd;
		padding: 10px;			
	}
	
	a.tab:hover {
		text-decoration: none;
		cursor: pointer;
		color: #bbb;
	}	
	
	.possibleReview {
		float: left;
		color: #bbb;	
	}
	
	.completedReview {
		float: right;
		color: #5f0080;	
		border-bottom: solid 2px #5f0080 !important;
	}	
	
	.completedReview:hover {
		color: #5f0080 !important;	
	}
	
	#line {
		border-top: solid 2px #5f0080;
		height: 20px;
	}
	
	.myOrder_number > h3 {
		border: solid 0px blue;
		text-align: left;
		font-size: 11pt;
		
	}
	
	table.myOrder_Desc {
		border: solid 0px red;
		width: 100%;
	}
	
	.desc-list {
		border: solid 1px #eee;
	}
	
	td {
		border: solid 0px red;
	}
	
	td.image {
		width: 130px;
	}
	
	td.image > img {
		margin: 10px 30px;
		width: 80px;
		height: 102px;
	}
	
	.info {
		width: 400px;
	}
	
	.productName {
		font-size: 11pt;
		color: black;
	}
	
	a.productName:hover {
		text-decoration: none;
		color: black;
		cursor: pointer;
	}
	
	.count {
		font-size: 9pt;
	}
	
	td.delivery {
		width: 160px;
		text-align: center;
		font-size: 10pt;
	}	
	
	a.link_review {
		border: solid 1px #5f0080;
		display: inline-block; 
		width: 110px;
		padding: 5px;
		margin: 10px;
		color: white;
		font-weight: bold;
		background-color: #5f0080;
		text-align: center;
	}
	
	a.link_review:hover {
		text-decoration: none;		
		color: white;
		cursor: pointer;
	}
			
	.column {
		border-bottom: solid 2px #5f0080;
		padding-top: 10px;
		height: 50px;
	}
	
	div.col {
		display: inline-block;		
	}
	
	.accordion {
		border-bottom: solid 1px #eee;
		padding-top: 15px;		
		height: 50px;		
	}
	
	div.num {
		width: 70px;
	}
	
	div.name {
		width: 550px;
	}
	
	div.date {
		width: 100px;
	}
	
	div.view {
		width: 80px;
	}
	
	div.panel {
		border-bottom: solid 1px #eee;
		padding: 10px;
	}
	
	.title {
		border: solid 0px red;
		text-align: left;
	}	
	
	img.image {
		width: 600px;
		height: 600px;
	}
	
	.review {
		text-align: left;
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
	$(document).ready(function() {

		$("div.panel").css('display','none');
	  
		$("div.accordion").click(function(event){						
			
			var $targetNext = $(this).next();
		
			var targetNextDisplayProperty = $targetNext.css('display');				
			
			if(targetNextDisplayProperty == 'none') {
				
				$("div.panel").css('display','none');
								
				$targetNext.css('display','');	
			}
			
			else {
				
				$targetNext.css('display','none');	
			}
			
		});
		
	});
</script>

</head>
<body>	
	<div class="container">
		<jsp:include page="../include/header.jsp"></jsp:include>
		<div class="section" align="center">
			<div class="contents">	
			
			<jsp:include page="../include/myPageSideMenu.jsp"></jsp:include>
							
			<div id="myPage_Contents">		
				<div id="myProductReview_Header">
					<h2 id="myProductReview_Title">상품후기</h2>
					<span id="myProductReview_Text">후기 작성은 배송 완료일로부터 30일 이내 가능합니다.</span>	
					
					<div style="clear:both; height:20px;"></div>
					
					<div class="tab">
						<a class="tab possibleReview" href="<%= ctxPath %>/member/myPageProductPossibleReview.do">작성가능 후기(<span>3</span>)</a>	
					</div>				
					<div class="tab">					
						<a class="tab completedReview" href="<%= ctxPath %>/member/myPageProductCompleteReview.do">작성완료 후기(<span>2</span>)</a>	
					</div>	
					
					<div style="clear:both; height:10px;"></div>								
				</div>			

				<div class="reviewList">    				
					<div class="column">
						<div class="col" style="width:70px;">번호</div>
						<div class="col" style="width:550px;">상품명</div>
						<div class="col" style="width:100px;">작성일</div>
						<div class="col" style="width:80px;">조회</div>
					</div>
					
					<div class="accordion">
				    	<div class="col num" style="width:70px;">2</div>
						<div class="col name" style="width:550px;">상품명2</div>
						<div class="col date" style="width:100px;">0000-00-00</div>
						<div class="col view" style="width:80px;">2</div>
				    </div>
				    <div class="panel">
				    	<div class="title">~~제목2~~</div>
				    	<div class="image">
				    		<img class="image" alt="해당 주문 대표 상품 이미지" src="include/images/logo.png">
				    	</div>
				    	<div class="review">~~~~~~~~~~~~~~내용2~~~~~~~~~~~~~~</div>
				    </div>
				    
				    <div class="accordion">
				    	<div class="col num" style="width:70px;">1</div>
						<div class="col name" style="width:550px;">상품명1</div>
						<div class="col date" style="width:100px;">0000-00-00</div>
						<div class="col view" style="width:80px;">1</div>
				    </div>
				    <div class="panel">
				    	<div class="title">~~제목1~~</div>
				    	<div class="image">
				    		<img class="image" alt="해당 주문 대표 상품 이미지" src="include/images/logo.png">
				    	</div>
				    	<div class="review">~~~~~~~~~~~~~~내용1~~~~~~~~~~~~~~</div>
				    </div>
				
				</div>
				
				<div style="border-bottom:solid 1px black; text-align:center;">페이징 처리</div>			
			</div>						
			</div>
			<div style="clear:both;"></div>
		</div>	
		<jsp:include page="../include/footer.jsp"></jsp:include>
	</div>
</body>
</html>