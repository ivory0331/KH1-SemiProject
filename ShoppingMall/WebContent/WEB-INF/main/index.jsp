<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
	String ctxPath = request.getContextPath();
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>index.jsp</title>
<link rel="stylesheet" href="<%= ctxPath %>/css/style.css" />
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
	
	.item_type > h3{
		font-weight: bold;
	}
	
	.item_type > h6{
		font-weight: bold;
		font-size:10pt;
		color: gray;
	}
	
	.item_list > li{
		display: inline-block;
		width: 250px;
		text-align: left;
		float:left;
		position: relative;
		margin-right:20px;
		cursor: pointer;
		
		
	}
	
	.item_list > li > img{
		display: block;
		border: solid 0px black;
		width: 100%;
		height: 360px;
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
		font-size:18pt;
		color: purple;
		font-weight: bold;
		cursor: pointer;
	}
	
	.slideR{
		float:right;
		font-size:18pt;
		color: purple;
		font-weight: bold;
		cursor: pointer;
	}
	
	#list_category{
		list-style: none;
		padding: 0;
	}
	
	#list_category > li{
		display: inline-block;
		padding: 10px 20px;
		font-size: 12pt;
		background-color: #f7f7f6;
		border-radius: 20px;
		margin-right: 10px;
		cursor: pointer;
		font-weight: 600;
	}
	
	.select_MDbest{
		background-color: #5f0081 !important;
		color:white;
	}
	.item>img {
		height: 200px;
	}
	
</style>
<meta name="viewport" content="width=device-width, initial-scale=1">
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.1/css/bootstrap.min.css">
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
<script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.1/js/bootstrap.min.js"></script>
<script type="text/javascript" src="/ShoppingMall/js/jquery-3.3.1.min.js"></script>
<script type="text/javascript" src="/ShoppingMall/util/myutil.js"></script>
<script type="text/javascript">
	
	$(document).ready(function(){
		// 각각의 div에 해당하는 리스트 호출 //
		func_randomItemCall();
		func_saleItemCall();
		func_newItemCall();
		func_MDItemCall(1);
		
		// MD추천에서 해당 분류버튼을 클릭하면 리스트 호출 //
		$("#list_category li").click(function(){
			var index = $("#list_category li").index(this)+1;
			$(this).addClass("select_MDbest");
			$(this).siblings().removeClass("select_MDbest");
			func_MDItemCall(index);
		});
	}); // end of $(document).ready(function()) ----------------------------------

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

	} //end of func_slideL(type) ---------------------------------------------

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
	} //end of func_slideR(type)------------------------------------------------

	
	function func_randomItemCall(){
		var url="/listCall.do";
		var data={"type":"random"};
		reqServer(url,data);
	}
	
	// 신상품 리스트 불러오기 url 호출
	function func_newItemCall(){
		var url="/listCall.do";
		var data={"type":"new"};
		reqServer(url,data);
	} // end of func_newItemCall()-----------------------------------------------
	
	// MD추천 리스트 불러오기 url 호출
	function func_MDItemCall(category){
		var url="/listCall.do";
		var data={"type":"best","category":category};
		reqServer(url,data);
	} // end of func_MDItemCall(category)----------------------------------------
	
	// 세일상품 리스트 불러오기 url 호출
	function func_saleItemCall(){
		var url="/listCall.do";
		var data={"type":"sale"};
		reqServer(url,data);
	} // end of func_saleItemCall()-----------------------------------------------
	
	
	
	// 상세보기 url 이동
	function goDetail(product_num){
		//console.log(product_num);
		location.href="<%=ctxPath%>/detail.do?product_num="+product_num;
	} // end of goDetail(idx)----------------------------------------------------
	
	
	
	
	// ajax 기능
	function reqServer(url, data){
	      console.log(url);
	      console.log(data);
	      $.ajax({
	         url:"<%=ctxPath%>"+url,
	         type:"get",
	         async:false,
	         data:data,
	         dataType:"JSON",
	         success:function(json){
	            console.log(json);
	            if(data.type=="new"){
	            	$(json).each(function(index, item){
	            		console.log(item.sale);
	            		var imgFileName = decodeURIComponent(item.representative_img);
	            		var html="<img alt='상품1' src='<%=ctxPath %>/images/"+imgFileName+"' onclick = 'goDetail("+item.product_num+")'>"
            	        +"<span style='font-size:16px; color:#333;' onclick = 'goDetail("+item.product_num+")'>"+item.product_name+"<span>"
            	        +"<br/>";
            	        if(item.sale==0){
            	        	html+="<span style='color: #333; font-weight: bold; font-size: 16px;'>"+func_comma(""+item.price)+"원</span>";
            	        }
            	        else{
            	        	html+="<span style='color: #333; font-weight: bold; font-size: 16px;'>"+func_comma(""+item.finalPrice)+"원</span>"
            	        	html+="<br/><span style='text-decoration:line-through; color: #ccc; font-weight: bold; font-size: 14px;'>"+func_comma(""+item.price)+"</span>"
            	        }
            	        
            			$("#new_item"+index).html(html);
	            	});
	            	
	            }
	            else if(data.type=="best"){
	            	$(json).each(function(index, item){
	            		console.log(item.sale);
	            		var imgFileName = decodeURIComponent(item.representative_img);
	            		var html="<img alt='상품1' src='<%=ctxPath %>/images/"+imgFileName+"' onclick = 'goDetail("+item.product_num+")'>"
            	        +"<span style='font-size:16px; color:#333;' onclick = 'goDetail("+item.product_num+")'>"+item.product_name+"<span>"
            	        +"<br/>";
            	        if(item.sale==0){
            	        	html+="<span style='color: #333; font-weight: bold; font-size: 16px;'>"+func_comma(""+item.price)+"원</span>";
            	        }
            	        else{
            	        	html+="<span style='color: #333; font-weight: bold; font-size: 16px;'>"+func_comma(""+item.finalPrice)+"원</span>"
            	        	html+="<br/><span style='text-decoration:line-through; color: #ccc; font-weight: bold; font-size: 14px;'>"+func_comma(""+item.price)+"</span>"
            	        }
            	        
            			$("#MDbest_item"+index).html(html);
	            	});
	            }
	            else if(data.type=="sale"){
	            	$(json).each(function(index, item){
	            		console.log(item.sale);
	            		var imgFileName = decodeURIComponent(item.representative_img);
	            		var html="<img alt='상품1' src='<%=ctxPath %>/images/"+imgFileName+"' onclick = 'goDetail("+item.product_num+")'>"
            	        +"<span style='font-size:16px; color:#333;' onclick = 'goDetail("+item.product_num+")'>"+item.product_name+"<span>"
            	        +"<br/>";
            	        if(item.sale==0){
            	        	html+="<span style='color: #333; font-weight: bold; font-size: 16px;'>"+func_comma(""+item.price)+"원</span>";
            	        }
            	        else{
            	        	html+="<span style='color: #333; font-weight: bold; font-size: 16px;'>"+func_comma(""+item.finalPrice)+"원</span>"
            	        	html+="<br/><span style='text-decoration:line-through; color: #ccc; font-weight: bold; font-size: 14px;'>"+func_comma(""+item.price)+"</span>"
            	        }
            	        
            			$("#sale_item"+index).html(html);
	            	});
	            }
	            
	            else if(data.type=="random"){
	            	$(json).each(function(index, item){
	            		console.log(item.sale);
	            		var imgFileName = decodeURIComponent(item.representative_img);
	            		var html="<img alt='상품1' src='<%=ctxPath %>/images/"+imgFileName+"' onclick = 'goDetail("+item.product_num+")'>"
            	        +"<span style='font-size:16px; color:#333;' onclick = 'goDetail("+item.product_num+")'>"+item.product_name+"<span>"
            	        +"<br/>";
            	        if(item.sale==0){
            	        	html+="<span style='color: #333; font-weight: bold; font-size: 16px;'>"+func_comma(""+item.price)+"원</span>";
            	        }
            	        else{
            	        	html+="<span style='color: #333; font-weight: bold; font-size: 16px;'>"+func_comma(""+item.finalPrice)+"원</span>"
            	        	html+="<br/><span style='text-decoration:line-through; color: #ccc; font-weight: bold; font-size: 14px;'>"+func_comma(""+item.price)+"</span>"
            	        }
            	        
            			$("#random_item"+index).html(html);
	            	});
	            }
	            
	         },
	         error:function(error){
	           
	         }
	   });
	} // end of reqServer(url, data) --------------------------------------------
</script>
</head>
<body>
	
	<div class="Mycontainer">
		<jsp:include page="../include/header.jsp"></jsp:include>
		
	<div id="myCarousel" class="carousel slide" data-ride="carousel">
    <!-- Indicators -->
    <ol class="carousel-indicators">
      <li data-target="#myCarousel" data-slide-to="0" class="active"></li>
      <li data-target="#myCarousel" data-slide-to="1"></li>
      <li data-target="#myCarousel" data-slide-to="2"></li>
    </ol>

    <!-- Wrapper for slides -->
    <div class="carousel-inner" style="margin-bottom: 50px !important;">
      <div class="item active">
        <img src="<%=ctxPath %>/images/allpaper.png" alt="종이박스" style="width:100%;">
      </div>

      <div class="item">
        <img src="<%=ctxPath %>/images/banchan.png" alt="매일반찬" style="width:100%;">
      </div>
    
      <div class="item">
        <img src="<%=ctxPath %>/images/jarang.png" alt="장바구니자랑" style="width:100%;">
      </div>
    </div>

    <!-- Left and right controls -->
    <a class="left carousel-control" href="#myCarousel" data-slide="prev">
      <span class="glyphicon glyphicon-chevron-left"></span>
      <span class="sr-only">Previous</span>
    </a>
    <a class="right carousel-control" href="#myCarousel" data-slide="next">
      <span class="glyphicon glyphicon-chevron-right"></span>
      <span class="sr-only">Next</span>
    </a>
  </div>
  
		<div class="section" align="center">
			<div class="contents">
				<div id="best">
					<div class="item_type">
						<h3>이 상품 어때요?</h3>
						<!-- sale영역에 있는 li(class=best_item)태그를 움직여야 하므로 onclick의 파라미터에 'best'을 입력한다. -->
						<span id="random_slideL" class="slideL" onclick="func_slideL('random')">&lt;&lt;&lt;</span>
						<span id="random_slideR" class="slideR" onclick="func_slideR('random')" style="display:none;">&gt;&gt;&gt;</span>
					</div>
					<div style="clear:both"></div>
					<div class="slide_wrapper">
					<%-- DB에서 갖고온 결과물 뿌리는 부분 --%>
					<ul class="item_list">
						<li class="random_item" id="random_item0" >
							<img alt="상품1" src="<%=ctxPath %>/images/logo.png">
							<a href="#">	
								상품명0
							</a><br/>
							<span>가격</span>
						</li>
						<li class="random_item" id="random_item1">
							<img alt="상품1" src="<%=ctxPath %>/images/logo.png">
							<a href="#">	
								상품명1
							</a>
							<br/>
							<span>가격</span>
						</li>
						<li class="random_item" id="random_item2">
							<img alt="상품1" src="<%=ctxPath %>/images/logo.png">
							<a href="#">	
								상품명2
							</a><br/>
							<span>가격</span>
						</li>
						<li class="random_item" id="random_item3">
							<img alt="상품1" src="<%=ctxPath %>/images/logo.png">
							<a href="#">	
								상품명3
							</a><br/>
							<span>가격</span>
						</li>
						<li class="random_item" id="random_item4">
							<img alt="상품1" src="<%=ctxPath %>/images/logo.png">
							<a href="#">	
								상품명4
							</a><br/>
							<span>가격</span>
						</li>
						<li class="random_item" id="random_item5">
							<img alt="상품1" src="<%=ctxPath %>/images/logo.png">
							<a href="#">	
								상품명5
							</a><br/>
							<span>가격</span>
						</li>
						<li class="random_item" id="random_item6">
							<img alt="상품1" src="<%=ctxPath %>/images/logo.png">
							<a href="#">	
								상품명6
							</a><br/>
							<span>가격</span>
						</li>
						<li class="random_item" id="random_item7">
							<img alt="상품1" src="<%=ctxPath %>/images/logo.png">
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
						<span id="sale_slideL" class="slideL" onclick="func_slideL('sale')">&lt;&lt;&lt;</span>
						<span id="sale_slideR" class="slideR"onclick="func_slideR('sale')" style="display:none;">&gt;&gt;&gt;</span>
					</div>
					<div class="slide_wrapper">
					<ul class="item_list">
						<li class="sale_item" id="sale_item0">
							<img alt="상품1" src="<%=ctxPath %>/images/logo.png">
							<a href="#">	
								상품명0
							</a><br/>
							<span>가격</span>
						</li>
						<li class="sale_item" id="sale_item1">
							<img alt="상품1" src="<%=ctxPath %>/images/logo.png">
							<a href="#">	
								상품명1
							</a>
							<br/>
							<span>가격</span>
						</li>
						<li class="sale_item" id="sale_item2">
							<img alt="상품1" src="<%=ctxPath %>/images/logo.png">
							<a href="#">	
								상품명2
							</a><br/>
							<span>가격</span>
						</li>
						<li class="sale_item" id="sale_item3">
							<img alt="상품1" src="<%=ctxPath %>/images/logo.png">
							<a href="#">	
								상품명3
							</a><br/>
							<span>가격</span>
						</li>
						<li class="sale_item" id="sale_item4">
							<img alt="상품1" src="<%=ctxPath %>/images/logo.png">
							<a href="#">	
								상품명4
							</a><br/>
							<span>가격</span>
						</li>
						<li class="sale_item" id="sale_item5">
							<img alt="상품1" src="<%=ctxPath %>/images/logo.png">
							<a href="#">	
								상품명5
							</a><br/>
							<span>가격</span>
						</li>
						<li class="sale_item" id="sale_item6">
							<img alt="상품1" src="<%=ctxPath %>/images/logo.png">
							<a href="#">	
								상품명6
							</a><br/>
							<span>가격</span>
						</li>
						<li class="sale_item" id="sale_item7">
							<img alt="상품1" src="<%=ctxPath %>/images/logo.png">
							<a href="#">	
								상품명7
							</a><br/>
							<span>가격</span>
						</li>
					</ul>
					<span style="clear:both;"></span>
					
					</div>
				</div>
				
				<div id="MDbest">
					<div class="item_type">
						<h3>MD의 추천</h3>
						<div id="category_menu">
							<ul id="list_category">
								<li class="select_MDbest">채소</li>
								<li>과일</li>
								<li>수산</li>
								<li>정육</li>
								<li>음료</li>
							</ul>
						</div>
						<!-- sale영역에 있는 li(class=sale_item)태그를 움직여야 하므로 onclick의 파라미터에 'sale'을 입력한다. -->
						<span id="MDbest_slideL" class="slideL" onclick="func_slideL('MDbest')">&lt;&lt;&lt;</span>
						<span id="MDbest_slideR" class="slideR"onclick="func_slideR('MDbest')" style="display:none;">&gt;&gt;&gt;</span>
					</div>
					<div class="slide_wrapper">
					<ul class="item_list">
						<li class="MDbest_item" id="MDbest_item0">
							<img alt="상품1" src="<%=ctxPath %>/images/logo.png">
							<a href="#">	
								상품명0
							</a><br/>
							<span>가격</span>
						</li>
						<li class="MDbest_item" id="MDbest_item1">
							<img alt="상품1" src="<%=ctxPath %>/images/logo.png">
							<a href="#">	
								상품명1
							</a>
							<br/>
							<span>가격</span>
						</li>
						<li class="MDbest_item" id="MDbest_item2">
							<img alt="상품1" src="<%=ctxPath %>/images/logo.png">
							<a href="#">	
								상품명2
							</a><br/>
							<span>가격</span>
						</li>
						<li class="MDbest_item" id="MDbest_item3">
							<img alt="상품1" src="<%=ctxPath %>/images/logo.png">
							<a href="#">	
								상품명3
							</a><br/>
							<span>가격</span>
						</li>
						<li class="MDbest_item" id="MDbest_item4">
							<img alt="상품1" src="<%=ctxPath %>/images/logo.png">
							<a href="#">	
								상품명4
							</a><br/>
							<span>가격</span>
						</li>
						<li class="MDbest_item" id="MDbest_item5">
							<img alt="상품1" src="<%=ctxPath %>/images/logo.png">
							<a href="#">	
								상품명5
							</a><br/>
							<span>가격</span>
						</li>
						<li class="MDbest_item" id="MDbest_item6">
							<img alt="상품1" src="<%=ctxPath %>/images/logo.png">
							<a href="#">	
								상품명6
							</a><br/>
							<span>가격</span>
						</li>
						<li class="MDbest_item" id="MDbest_item7">
							<img alt="상품1" src="<%=ctxPath %>/images/logo.png">
							<a href="#">	
								상품명7
							</a><br/>
							<span>가격</span>
						</li>
					</ul>
					<span style="clear:both;"></span>
					
					</div>
				</div>
				
				<div id="new">
					<div class="item_type">
						<h3>오늘의 신상품</h3>
						<h6>매일 정오 신상품을 확인해보세요</h6>
						<!-- sale영역에 있는 li(class=sale_item)태그를 움직여야 하므로 onclick의 파라미터에 'sale'을 입력한다. -->
						<span id="new_slideL" class="slideL" onclick="func_slideL('new')">&lt;&lt;&lt;</span>
						<span id="new_slideR" class="slideR" onclick="func_slideR('new')" style="display:none;">&gt;&gt;&gt;</span>
					</div>
					<div class="slide_wrapper">
					<ul class="item_list">
						<li class="new_item" id="new_item0">
							<img alt="상품1" src="<%=ctxPath %>/images/logo.png">
							<a href="#">	
								상품명0
							</a><br/>
							<span>가격</span>
						</li>
						<li class="new_item" id="new_item1">
							<img alt="상품1" src="<%=ctxPath %>/images/logo.png">
							<a href="#">	
								상품명1
							</a>
							<br/>
							<span>가격</span>
						</li>
						<li class="new_item" id="new_item2">
							<img alt="상품1" src="<%=ctxPath %>/images/logo.png">
							<a href="#">	
								상품명2
							</a><br/>
							<span>가격</span>
						</li>
						<li class="new_item" id="new_item3">
							<img alt="상품1" src="<%=ctxPath %>/images/logo.png">
							<a href="#">	
								상품명3
							</a><br/>
							<span>가격</span>
						</li>
						<li class="new_item" id="new_item4">
							<img alt="상품1" src="<%=ctxPath %>/images/logo.png">
							<a href="#">	
								상품명4
							</a><br/>
							<span>가격</span>
						</li>
						<li class="new_item" id="new_item5">
							<img alt="상품1" src="<%=ctxPath %>/images/logo.png">
							<a href="#">	
								상품명5
							</a><br/>
							<span>가격</span>
						</li>
						<li class="new_item" id="new_item6">
							<img alt="상품1" src="<%=ctxPath %>/images/logo.png">
							<a href="#">	
								상품명6
							</a><br/>
							<span>가격</span>
						</li>
						<li class="new_item" id="new_item7">
							<img alt="상품1" src="<%=ctxPath %>/images/logo.png">
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
		
		<jsp:include page="../include/footer.jsp"></jsp:include>
		
	</div>
</body>
</html>