<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>index.jsp</title>
<link rel="stylesheet" href="css/style.css" />
<style type="text/css">
	
	/*슬라이드 영역*/
	.slide_wrapper{
		position: relative;
		height:500px;
		width: 1080px;
		overflow:hidden;
	}
	
	/*슬라이드 되는 상품의 ul태그*/
	.item_list{
		list-style: none;
		width: 2200px;
		padding: 0px 5px;
		margin: 0px;
	}
	
	.item_list > li{
		display: inline-block;
		width: 250px;
		text-align: left;
		float:left;
		position: relative;
		margin-right:20px;
		
		
	}
	
	.item_list > li > img{
		display: block;
		border: solid 1px black;
		width: 100%;
		height:440px;
	}
	
	.footer{
		clear:both;
	}
	
</style>
<script type="text/javascript" src="/ShoppingMall/js/jquery-3.3.1.min.js"></script>
<script type="text/javascript" src="/ShoppingMall/util/myutil.js"></script>
<script type="text/javascript">
	function func_slideL(type){
		console.log(type);
		
		var $item = $("."+type+"_item");
		for(var i=0; i<$item.length; i++){
			$("."+type+"_item:eq("+i+")").animate({"left":-1080},"normal",function(){
													 $("."+type+"_slideR").show();
													 $("."+type+"_slideL").hide();
										          });
		}	
	}
	
	function func_slideR(type){
		console.log(type);
		var $item = $("."+type+"_item");
		for(var i=0; i<$item.length; i++){
			$("."+type+"_item:eq("+i+")").animate({"left":0},"normal",function(){
													 $("."+type+"_slideL").show();
													 $("."+type+"_slideR").hide();
										          });
		}	
	}

</script>
</head>
<body>
	
	<div class="container">
		<jsp:include page="include/header.jsp"></jsp:include>
		<div class="section" align="center">
			<div class="contents">
				<div class="best">
					<div class="item_type">
						<h3>추천 상품</h3>
						<button class="best_slideL" onclick="func_slideL('best')">클릭L</button>
						<button class="best_slideR" onclick="func_slideR('best')" style="display:none;">클릭R</button>
					</div>
					<div class="slide_wrapper">
					<ul class="item_list">
						<li class="best_item" id="best_item0">
							<img alt="상품1" src="include/images/logo.png">
							<a href="#">	
								상품명0
							</a><br/>
							<span>가격</span>
						</li>
						<li class="best_item" id="best_item1">
							<img alt="상품1" src="include/images/logo.png">
							<a href="#">	
								상품명1
							</a>
							<br/>
							<span>가격</span>
						</li>
						<li class="best_item" id="best_item2">
							<img alt="상품1" src="include/images/logo.png">
							<a href="#">	
								상품명2
							</a><br/>
							<span>가격</span>
						</li>
						<li class="best_item" id="best_item3">
							<img alt="상품1" src="include/images/logo.png">
							<a href="#">	
								상품명3
							</a><br/>
							<span>가격</span>
						</li>
						<li class="best_item" id="best_item4">
							<img alt="상품1" src="include/images/logo.png">
							<a href="#">	
								상품명4
							</a><br/>
							<span>가격</span>
						</li>
						<li class="best_item" id="best_item5">
							<img alt="상품1" src="include/images/logo.png">
							<a href="#">	
								상품명5
							</a><br/>
							<span>가격</span>
						</li>
						<li class="best_item" id="best_item6">
							<img alt="상품1" src="include/images/logo.png">
							<a href="#">	
								상품명6
							</a><br/>
							<span>가격</span>
						</li>
						<li class="best_item" id="best_item7">
							<img alt="상품1" src="include/images/logo.png">
							<a href="#">	
								상품명7
							</a><br/>
							<span>가격</span>
						</li>
					</ul>
					<span style="clear:both;"></span>
					
					</div>
				</div>
				
				<div class="sale">
					<div class="item_type">
						<h3>세일 상품</h3>
						<button class="sale_slideL" onclick="func_slideL('sale')">클릭L</button>
						<button class="sale_slideR" onclick="func_slideR('sale')" style="display:none;">클릭R</button>
					</div>
					<div class="slide_wrapper">
					<ul class="item_list">
						<li class="sale_item" id="sale_item0">
							<img alt="상품1" src="include/images/logo.png">
							<a href="#">	
								상품명0
							</a><br/>
							<span>가격</span>
						</li>
						<li class="sale_item" id="sale_item1">
							<img alt="상품1" src="include/images/logo.png">
							<a href="#">	
								상품명1
							</a>
							<br/>
							<span>가격</span>
						</li>
						<li class="sale_item" id="sale_item2">
							<img alt="상품1" src="include/images/logo.png">
							<a href="#">	
								상품명2
							</a><br/>
							<span>가격</span>
						</li>
						<li class="sale_item" id="sale_item3">
							<img alt="상품1" src="include/images/logo.png">
							<a href="#">	
								상품명3
							</a><br/>
							<span>가격</span>
						</li>
						<li class="sale_item" id="sale_item4">
							<img alt="상품1" src="include/images/logo.png">
							<a href="#">	
								상품명4
							</a><br/>
							<span>가격</span>
						</li>
						<li class="sale_item" id="sale_item5">
							<img alt="상품1" src="include/images/logo.png">
							<a href="#">	
								상품명5
							</a><br/>
							<span>가격</span>
						</li>
						<li class="sale_item" id="sale_item6">
							<img alt="상품1" src="include/images/logo.png">
							<a href="#">	
								상품명6
							</a><br/>
							<span>가격</span>
						</li>
						<li class="sale_item" id="sale_item7">
							<img alt="상품1" src="include/images/logo.png">
							<a href="#">	
								상품명7
							</a><br/>
							<span>가격</span>
						</li>
					</ul>
					<span style="clear:both;"></span>
					
					</div>
				</div>
			</div>
		</div>
		
		<jsp:include page="include/footer.jsp"></jsp:include>
		
	</div>
</body>
</html>