<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>GoodsInsert.jsp</title>
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
	
	#info{
		display:inline-block;
		width: 900px;
		margin-left:10px;
		margin-top:10px;
	}

	
	.managerBtn{
		display: inline-block;
		border:solid 1px black;
		padding: 5px 30px;
		background-color: purple;
		color:white;
	}
	
	.managerBtn:hover{
		cursor: pointer;
		background-color: white;
		color:purple;
	}
	
	.btn_area{
		margin-top:30px;
	}
	
	.newGoodsAdd{
		margin-top:5px;
		/*background-color: #f4f4f4;*/
		border:solid 1px gray;
	}
	
	.newGoodsTitle > h4{
		display: inline-block;
	}
	
	.newGoodsTitle > span{
		float:right;
		font-size: 16pt;
		background-color: red;
		padding: 0 10px;
		cursor: pointer;
	}
	
	.newGoodsImg{
		width: 400px;
		min-height:300px;
		display: inline-block;
		border: solid 1px black;
		float: left;
		margin: 0 20px;
		background-color: white;
	
	}
	
	.representation-img{
		width:50%;
		height: 200px;
		border:solid 1px red;
		margin-bottom: 10px;
	}
	
	.detail-img{
		width: 80px;
		height: 80px;
		display: inline-block;
		margin: 0 20px;
		border: solid 1px black;
	}
	
	.newGoodsForm{
		display: inline-block;
		background-color: white;
		margin-bottom:5px;
	}
	
	.newGoods-info{
		list-style: none;
		padding: 0;
		
	}
	
	.newGoods-info > li{
		margin-bottom: 20px;
	}
	
	.newGoods-info > li > label{
		width: 80px;
	}
	
	
	
</style>
<!-- 부트스트랩 -->
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.1/css/bootstrap.min.css">
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
<script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.1/js/bootstrap.min.js"></script>
<script type="text/javascript" src="/ShoppingMall/js/jquery-3.3.1.min.js"></script>
<script type="text/javascript" src="/ShoppingMall/util/myutil.js"></script>
<script type="text/javascript">
	var offSet = new Array();
	var newGoodsCnt = 0;
	var existGoodsCnt = 0;
	var $newGoodsForm = "";
	$(document).ready(function(){
		$("#newGoodsAdd0").hide();
		
	});
	
	function func_newGoodsAdd(){
		var Frm = document.goodsInsert;
		if(newGoodsCnt == 0){
			$("#newGoodsAdd0").show();
		}
		else{
			Frm.innerHTML+="<div class='newGoodsAdd' id='newGoodsAdd"+newGoodsCnt+"' align='left'>"
			  +"<div class='newGoodsTitle' id='newGoodsTitle"+newGoodsCnt+"'>"
			  +"<h4>신규 상품 추가 폼</h4>"
			  +"<span>X</span>"
			  +"</div>"
			  +"<div class='newGoodsImg' align='center' id='newGoodsImg"+newGoodsCnt+"'>"
			  +"<div class='representation-img'>"
			  +"</div>"
			  +"<div class='detail-img'></div>"
			  +"<div class='detail-img'></div>"
			  +"<div class='detail-img'></div>"
			  +"</div>"
			  +"<div class='newGoodsForm' align='left' id='newGoodsForm"+newGoodsCnt+"'>"
			  +"<select id='bigSelect"+newGoodsCnt+"' class='bigSelect'>"
			  +"<option>채소</option>"
			  +"</select>"
			  +"<select id='smallSelect"+newGoodsCnt+"' class='smallSelect'>"
			  +"<option>쌈</option>"
			  +"</select>"
			  +"<ul class='newGoods-info' id='newGoods-info"+newGoodsCnt+"'>"
			  +"<li>"
			  +"<label for='goddsName"+newGoodsCnt+"'>상품명</label>"
			  +"<input type='text' id='goodsName"+newGoodsCnt+"' />"
			  +"</li>"
			  +"<li>"
			  +"<label for='goddsUnit"+newGoodsCnt+"'>단위</label>"
			  +"<input type='text' id='goddsUnit"+newGoodsCnt+"' />"
			  +"</li>"
			  +"<li>"
			  +"<label for='packageType"+newGoodsCnt+"'>포장타입</label>"
			  +"<input type='text' id='packageType"+newGoodsCnt+"' />"
			  +"</li>"
			  +"<li>"
			  +"<label for='goodsOrigin"+newGoodsCnt+"'>원산지</label>"
			  +"<input type='text' id='goodsOrigin"+newGoodsCnt+"' />"
			  +"</li>"
			  +"<li>"
			  +"<label for='goodsShelflife"+newGoodsCnt+"'>유통기한</label>"
			  +"<input type='text' id='goodsShelflife"+newGoodsCnt+"' />"
			  +"</li>"
			  +"<li>"
			  +"<label for='goodsPrice"+newGoodsCnt+"'>가격</label>"
			  +"<input type='text' id='goodsPrice"+newGoodsCnt+"' />"
			  +"</li>"
			  +"<li style='margin:0;'>"
			  +"<label for='goodsCount"+newGoodsCnt+"'>재고 수</label>"
			  +"<input type='text' id='goodsCount"+newGoodsCnt+"' />"
			  +"</li>"
			  +"</ul>"
			  +"</div>"
			  +"</div>"
			  +"<div style='clear:both;'></div>";
		}
		
		newGoodsCnt++;		
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
				<div id="info">
					<div id="add_area" align="right">
							<span class="managerBtn" onclick="func_newGoodsAdd()">신규상품 추가</span>
							<span class="managerBtn">기존상품 재고 추가</span>
					</div>
					<form name="goodsInsert" >
						<div class="newGoodsAdd" id="newGoodsAdd0" align="left">
							<div class="newGoodsTitle" id="newGoodsTitle0">
								<h4>신규 상품 추가 폼</h4>
								<span>X</span>
							</div>
							<div class="newGoodsImg" align="center" id="newGoodsImg0">
								<div class="representation-img">		
									
								</div>
								<div class="detail-img"></div>
								<div class="detail-img"></div>
								<div class="detail-img"></div>
							</div>
							
							<div class="newGoodsForm" align="left" id="newGoodsForm0">
								<select id="bigSelect0" class="bigSelect">
									<option>채소</option>
								</select>
								<select id="smallSelect0" class="smallSelect">
									<option>쌈</option>
								</select>
								
								<ul class="newGoods-info" id="newGoods-info0">
									<li>
										<label for="goddsName0">상품명</label>
										<input type="text" id="goodsName0" />
									</li>
									<li>
										<label for="goddsUnit0">단위</label>
										<input type="text" id="goddsUnit0" />
									</li>
									<li>
										<label for="packageType0">포장타입</label>
										<input type="text" id="packageType0" />
									</li>
									<li>
										<label for="goodsOrigin0">원산지</label>
										<input type="text" id="goodsOrigin0" />
									</li>
									<li>
										<label for="goodsShelflife0">유통기한</label>
										<input type="text" id="goodsShelflife0" />
									</li>
									<li>
										<label for="goodsPrice0">가격</label>
										<input type="text" id="goodsPrice0" />
									</li>
									<li style="margin:0;">
										<label for="goodsCount0">재고 수</label>
										<input type="text" id="goodsCount0" />
									</li>
								</ul>
							</div>
						</div>
						<div style="clear:both;"></div>
					</form>
					
					<div class="btn_area" align="right" >
							<span class="managerBtn">확인</span>
							<span class="managerBtn">취소</span>
					</div>
				</div>
				
			</div>
		</div>
		<jsp:include page="include/footer.jsp"></jsp:include>
	</div>
</body>
</html>