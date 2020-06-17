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
			Frm.innerHTML+= newGoodsaddForm(newGoodsCnt);
			console.log($("#newGoodsAddNum"+newGoodsCnt).val());
		}
		
		newGoodsCnt++;		
	}
	
	function newGoodsaddForm(cnt){
		var html = "<div class='newGoodsAdd' id='newGoodsAdd"+cnt+"' align='left'>"
		  +"<input type='hidden' value='"+cnt+"' name='newGoodsAddNum"+cnt+"' id='newGoodsAddNum"+cnt+"'/>"
		  +"<div class='newGoodsTitle' id='newGoodsTitle"+cnt+"'>"
		  +"<h4>신규 상품 추가 폼</h4>"
		  +"<span onclick='func_deleteAddForm("+cnt+")'>X</span>"
		  +"</div>"
		  +"<div class='newGoodsImg' align='center' id='newGoodsImg"+cnt+"'>"
		  +"<div class='representation-img'>"
		  +"<input type='file' name='representation-img"+cnt+"' />"
		  +"</div>"
		  +"<div class='detail-img'><input type='file' name='detailFirst-img"+cnt+"'/></div>"
		  +"<div class='detail-img'><input type='file' name='detailSecond-img"+cnt+"'/></div>"
		  +"<div class='detail-img'><input type='file' name='detailThird-img"+cnt+"'/></div>"
		  +"</div>"
		  +"<div class='newGoodsForm' align='left' id='newGoodsForm"+cnt+"'>"
		  +"<select id='bigSelect"+cnt+"' class='bigSelect' name='bigSelect"+cnt+"'>"
		  +"<option>채소</option>"
		  +"</select>"
		  +"<select id='smallSelect"+cnt+"' class='smallSelect' name='smallSelect"+cnt+"'>"
		  +"<option>쌈</option>"
		  +"</select>"
		  +"<ul class='newGoods-info' id='newGoods-info"+cnt+"'>"
		  +"<li>"
		  +"<label for='goddsName"+cnt+"'>상품명</label>"
		  +"<input type='text' id='goodsName"+cnt+"' name='goodsName"+cnt+"' class='goodName' />"
		  +"</li>"
		  +"<li>"
		  +"<label for='goddsUnit"+cnt+"'>단위</label>"
		  +"<input type='text' id='goddsUnit"+cnt+"' name='goddsUnit"+cnt+"' />"
		  +"</li>"
		  +"<li>"
		  +"<label for='packageType"+cnt+"'>포장타입</label>"
		  +"<input type='text' id='packageType"+cnt+"' name='packageType"+cnt+"' />"
		  +"</li>"
		  +"<li>"
		  +"<label for='goodsOrigin"+cnt+"'>원산지</label>"
		  +"<input type='text' id='goodsOrigin"+cnt+"' name='goodsOrigin"+cnt+"' />"
		  +"</li>"
		  +"<li>"
		  +"<label for='goodsShelflife"+cnt+"'>유통기한</label>"
		  +"<input type='text' id='goodsShelflife"+cnt+"' name='goodsShelflife"+cnt+"' />"
		  +"</li>"
		  +"<li>"
		  +"<label for='goodsPrice"+cnt+"'>가격</label>"
		  +"<input type='text' id='goodsPrice"+cnt+"' name='goodsPrice"+cnt+"' />"
		  +"</li>"
		  +"<li style='margin:0;'>"
		  +"<label for='goodsCount"+cnt+"'>재고 수</label>"
		  +"<input type='text' id='goodsCount"+cnt+"' name='goodsCount"+cnt+"' />"
		  +"</li>"
		  +"</ul>"
		  +"</div>"
		  +"</div>"
		  +"<div style='clear:both;'></div>";
		  
		  return html;
	}
	
	function func_deleteAddForm(cnt){
		$("#newGoodsAdd"+cnt).remove();
	}
	
	function goSubmit(){
		var frm = document.goodsInsert;
		var data={"test":"dddd"};
		frm.action="index.jsp";
		frm.method="post";
		frm.data=data;
		frm.submit();
	}
	
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
				<div id="info">
					<div id="add_area" align="right">
							<span class="managerBtn" onclick="func_newGoodsAdd()">신규상품 추가</span>
							<span class="managerBtn">기존상품 재고 추가</span>
					</div>
					<form name="goodsInsert" >
						<div class="newGoodsAdd" id="newGoodsAdd0" align="left">
							<input type="hidden" value="0" name="newGoodsAddNum0" />
							<div class="newGoodsTitle" id="newGoodsTitle0">
								<h4>신규 상품 추가 폼</h4>
								<span>X</span>
							</div>
							<div class="newGoodsImg" align="center" id="newGoodsImg0">
								<div class="representation-img">		
									<input type="file" name="representation-img0" />
								</div>
								<div class="detail-img">
									<input type="file" name="detailFirst-img0" />
								</div>
								<div class="detail-img">
									<input type="file" name="detailSecond-img0" />
								</div>
								<div class="detail-img">
									<input type="file" name="detailThird-img0" />
								</div>
							</div>
							
							<div class="newGoodsForm" align="left" id="newGoodsForm0">
								<select id="bigSelect0" name="bigSelect0" class="bigSelect">
									<option>채소</option>
								</select>
								<select id="smallSelect0" name="smallSelect0" class="smallSelect">
									<option>쌈</option>
								</select>
								
								<ul class="newGoods-info" id="newGoods-info0">
									<li>
										<label for="goddsName0">상품명</label>
										<input type="text" id="goodsName0" name="goodsName0" class="goodsName"/>
									</li>
									<li>
										<label for="goddsUnit0">단위</label>
										<input type="text" id="goddsUnit0" name="goddsUnit0" class="goddsUnit"/>
									</li>
									<li>
										<label for="packageType0">포장타입</label>
										<input type="text" id="packageType0" name="packageType0" class="packageType"/>
									</li>
									<li>
										<label for="goodsOrigin0">원산지</label>
										<input type="text" id="goodsOrigin0" name="goodsOrigin0" class="goodsOrigin"/>
									</li>
									<li>
										<label for="goodsShelflife0">유통기한</label>
										<input type="text" id="goodsShelflife0" name="goodsShelflife0" class="goodsShelflife"/>
									</li>
									<li>
										<label for="goodsPrice0">가격</label>
										<input type="text" id="goodsPrice0" name="goodsPrice0" class="goodsPrice"/>
									</li>
									<li style="margin:0;">
										<label for="goodsCount0">재고 수</label>
										<input type="text" id="goodsCount0" name="goodsCount0" class="goodsCount"/>
									</li>
								</ul>
							</div>
						</div>
						<div style="clear:both;"></div>
					</form>
					
					<div class="btn_area" align="right" >
							<span class="managerBtn" onclick="goSubmit()">확인</span>
							<span class="managerBtn">취소</span>
					</div>
				</div>
				
			</div>
		</div>
		<jsp:include page="../include/footer.jsp"></jsp:include>
	</div>
</body>
</html>