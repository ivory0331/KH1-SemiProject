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
	
	/*footer.jsp가 include되는 영역*/
	.footer{
		clear:both;
	}
	
	
	#best_item0 {
		position:relative;
	}
	
	#best_item0 > img{
		
	}
	
	.slideL{
		float:left;
	}
	
	.slideR{
		float:right;
	}
	
	
</style>
<link rel="stylesheet" href="css/style.css" />
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.1/css/bootstrap.min.css">
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
<script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.1/js/bootstrap.min.js"></script>
<script type="text/javascript" src="/ShoppingMall/js/jquery-3.3.1.min.js"></script>
<script type="text/javascript" src="/ShoppingMall/util/myutil.js"></script>
<script type="text/javascript">

	// 왼쪽 버튼을 클릭하면 실행되는 function //
	function func_slideL(type){ //type = 각각의 배너의 class명의 앞부분ex)best, sale
		console.log(type);
		var $item = $("."+type+"_item"); //button으로 호출할 때 갖고온 파라미터 값을 이용해 만든 class를 갖는 li태그 선택
		for(var i=0; i<$item.length; i++){ //각각의 li태그에 함수의 기능을 적용하기 때문에 for문 사용
			// eq를 사용해서 순차적으로 animate()를 적용
			$("."+type+"_item:eq("+i+")").animate({"left":-1080},"normal", //x좌표 값을 li가 들어가 있는 ul태그의 화면의 크기만큼 왼쪽으로 움직인다.
												  function(){ //콜백함수 - animate가 끝나면 오른쪽 버튼은 보이고 왼쪽 버튼은 숨긴다.
													 $("#"+type+"_slideR").show();
													 $("#"+type+"_slideL").hide();
										          });
		}	
	}
	
	// 오른쪽 버튼을 클릭하면 실행되는 function //
	function func_slideR(type){
		console.log(type);
		var $item = $("."+type+"_item");
		for(var i=0; i<$item.length; i++){
			$("."+type+"_item:eq("+i+")").animate({"left":0},"normal",//x좌표 값을 다시 본래 위치(0)로 이동 
											      function(){ 
													 $("#"+type+"_slideL").show();
													 $("#"+type+"_slideR").hide();
										          });
		}	
	}

</script>
</head>
<body>
	
	<div class="Mycontainer">
		<jsp:include page="include/header.jsp"></jsp:include>
		<div class="section" align="center">
			<div class="contents">
				<div id="best">
					<div class="item_type">
						<h3>추천 상품</h3>
						<!-- sale영역에 있는 li(class=best_item)태그를 움직여야 하므로 onclick의 파라미터에 'best'을 입력한다. -->
						<button id="best_slideL" class="slideL" onclick="func_slideL('best')">클릭L</button>
						<button id="best_slideR" class="slideR" onclick="func_slideR('best')" style="display:none;">클릭R</button>
					</div>
					<div class="slide_wrapper">
					<%-- DB에서 갖고온 결과물 뿌리는 부분 --%>
					<ul class="item_list">
						<li class="best_item" id="best_item0" >
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
				
				<div id="sale">
					<div class="item_type">
						<h3>세일 상품</h3>
						<!-- sale영역에 있는 li(class=sale_item)태그를 움직여야 하므로 onclick의 파라미터에 'sale'을 입력한다. -->
						<button id="sale_slideL" class="slideL" onclick="func_slideL('sale')">클릭L</button>
						<button id="sale_slideR" class="slideR"onclick="func_slideR('sale')" style="display:none;">클릭R</button>
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