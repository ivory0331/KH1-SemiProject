<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>managerSales.jsp</title>
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
	
	.info{
		display:inline-block;
		width: 900px;
		margin-left:10px;
		margin-top:10px;
	}
	
	/*상품 이미지가 보이는 div*/
	.goodsImg{
		float:left;
		display: inline-block;
		width: 200px;
		border:solid 1px black;
	}
	
	.goodsImg > img{
		width:100%;
		height:300px;
		border-bottom: solid 1px black;
	}
	
	/*상품 이미지의 옆에 나오는 상품 정보가 들어가 있는 div*/
	.goodsInfo-table{
		display: inline-block;
		width:600px;
		margin-right:30px;
		text-align: left;
	}
	
	/*상품 정보가 나열된 리스트에서 각각의 항목 부분의 태그*/
	dt{
		
		display: inline-block;
		width: 200px;
		
	}
	
	/*상품 정보가 나열된 리스트에서 각각의 내용 부분의 태그*/
	dd{
		margin-left:-10px;
		display: inline-block;
		width: 350px;
		
	}
	
	.goodsInfo-table input[type='text']{
	
	}
	
	
	.goodsInfo-div{
		background-color: white;
		text-align: left;
		line-height: 30px;
		border-top : solid 1px #f4f4f4;
		border-bottom : solid 1px #f4f4f4;
		margin-bottom: 5px;
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
	
	.detail_img{
		display: inline-block;
		width: 200px;
		height: 200px;
		margin-left: 50px;
		border: solid 1px black;
	}
	
	.detail_img > div{
		height:200px;
	}
	
	.btn_area{
		margin-top:30px;
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
	$(document).ready(function(){
		for(var i=0; i<$(".detailTablePart").length; i++){
			offSet[i] = $(".detailTablePart")[i].offsetTop;
			console.log(offSet[i]);
		}
	});
		
	function goTable(num){
			
		var top = offSet[num]-Number("81");
		console.log("top:"+top);
		$('html, body').animate({scrollTop : top}, 0);		
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
				<div class="info">
					<div class="goodsImg">
						<img alt="상품1" src="include/images/logo.png"/>
						<input type="file" id="imgFile0" accept=".gif, .jpg, .png" />
					</div>
					<div class="goodsInfo-table">
						<dl>
							<dt>상품명</dt>
							<dd><input type="text" value="tet" /></dd>
						</dl>
						<dl class="underLine">
							<dt>대분류</dt>
							<dd><input type="text" value="채소" /></dd>
						</dl>
						<dl class="underLine">
							<dt>소분류</dt>
							<dd><input type="text" value="쌈" /></dd>
						</dl>
						<dl class="underLine">
							<dt>단위 / 그램</dt>
							<dd><input type="text" value="100g" /></dd>
						</dl>
						<dl class="underLine">
							<dt>원산지</dt>
							<dd><input type="text" value="국내산" /></dd>
						</dl>
						<dl class="underLine">
							<dt>구매 담당자</dt>
							<dd><input type="text" value="OOO" /></dd>
						</dl>
						<dl class="underLine">
							<dt>담당자 번호</dt>
							<dd><input type="text" value="010-0000-0000" /></dd>
						</dl>
						<dl class="underLine">
							<dt>가격</dt>
							<dd><input type="text" value="1,000" /></dd>
						</dl>
						<dl class="underLine">
							<dt>재고 수</dt>
							<dd><input type="text" value="100" disabled /></dd>
						</dl>
						
					</div>
					<div class="goodsInfo-div" contenteditable="true">
							상품 상세 설명<br/>
							test입니다.
					</div>
					<div id="goodsInfo-img">
						<div class="detail_img">
							<div>첫번째 상세 이미지</div>
							<input type="file" id="imgFile1" accept=".gif, .jpg, .png" />
						</div>
						<div class="detail_img">
							<div>두번째 상세 이미지</div>
							<input type="file" id="imgFile1" accept=".gif, .jpg, .png" />
						</div>
						<div class="detail_img">
							<div>세번째 상세 이미지</div>
							<input type="file" id="imgFile1" accept=".gif, .jpg, .png" />
						</div>
					</div>
					<div class="btn_area" >
							<span class="managerBtn">확인</span>
							<span class="managerBtn">취소</span>
					</div>
					
				</div>
				<div style="clear:both;"></div>
				
			</div>
		</div>
		<jsp:include page="include/footer.jsp"></jsp:include>
	</div>
</body>
</html>