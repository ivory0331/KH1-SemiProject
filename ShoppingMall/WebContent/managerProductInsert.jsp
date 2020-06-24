<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<% String ctxPath = request.getContextPath(); %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<link rel="stylesheet" href="<%= ctxPath %>/css/style.css" />
<title>GoodsInsert.jsp</title>
<!-- 차트 링크 --> 
<script src="https://cdn.jsdelivr.net/npm/chart.js@2.8.0"></script> 
<style type="text/css">
	.sideMenu{
		margin-top:10px;
		display: inline-block;
		width: 150px;
		float:left;
	}
	
	div#info{
		border : solid 1px red;
		display:inline-block;
		width: 900px;
		margin-left:10px;
		margin-top:10px;
	}
	
	input, select{
		width:210px;
		height:35px;
		vertical-align: middle;
		border: solid 1px #ddd; /* 회색 */
		padding-left: 5px;		
	}

	
	.managerBtn{
		display: inline-block;
		padding: 5px 30px;
		background-color: #5F0080; /* 보라색*/
		color:white;
		cursor:pointer;
	}
	
	
	.btn_area{
		margin : 30px 50px 30px 0;
	}
	
	.newGoodsAdd{
		margin-top:5px;
	}
	
	.newGoodsTitle > h4{
		display: inline-block;
	}
	
	
	/* 이미지 추가 */
	div.newProductImg{
		width: 60%;
		height: 100%;
		display: inline-block;
		float: left;
		margin: 0 15px;
		background-color: white;
	}
	
	
	div.representative_img{
		margin-bottom: 10px;
	} 
	
	
	.upload_image_representative{
		margin-bottom:10px;
		padding:10px;
		width : 446px;
		height: 300px;
		border:solid 1px #ddd;
	}
	
	#representative_img1{
		height: 280px;
	}
	
	div.detail_img{
		align-content : center;
		display: inline-block;	
		width: 150px;
		height: 180px;
		margin:0 10px;
	}
	
	.detail{
		height:180px;
	}
	
	/* 파일 선택 디자인 */
	.newProductImg label { 
		margin: 2px;
		padding: .5em .75em; 
		color: #999; 
		font-size: inherit; 
		line-height: normal; 
		vertical-align: middle; 
		background-color: #fdfdfd; 
		cursor: pointer; 
		border: 1px solid #ebebeb; 
		border-bottom-color: #e2e2e2; 
		border-radius: .25em; 
	}
	
	.newProductImg .upload_name { 
		display: inline-block; 
		padding: .5em .75em; /* label의 패딩값과 일치 */ 
		width:150px;
		font-family: inherit; 
		line-height: normal; 
		vertical-align: middle; 
		background-color: #f5f5f5; 
		border: 1px solid #ebebeb; 
		border-bottom-color: #e2e2e2; 
		border-radius: .25em; 
		-webkit-appearance: none; /* 네이티브 외형 감추기 */ 
		-moz-appearance: none; 
		appearance: none; 
	}

	
	/* 파일 필드 숨기기 */ 	
	.newProductImg input[type="file"] { 
		position:absolute;
		width: 1px; 
		height: 1px; 
		/* padding:0;
		margin:-1px; */
		overflow: hidden; 
		clip:rect(0,0,0,0); 
		border: 0; 
	}
	
	
	div.upload_image_detail{
		width:150px;
		height:180px;
		border:solid 1px #ddd;
		margin-bottom: 10px;
	}

	
	/**/
	div.newProductForm{
		width: 35%;
		display: inline-block;
		background-color: none;
		margin-bottom:5px;
	}
	
	.newProductInfo{
		list-style: none;
		padding: 0;
		
	}
	
	.newProductInfo > li{
		margin-bottom: 20px;
	}
	
	.newProductInfo > li > label{
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

	$(document).ready(function(){
		
				
		// 대표이미지 삽입
		$('.upload_hidden').on('change', function(){
			if(window.FileReader){ // modern browser 
				var filename = $(this)[0].files[0].name;
			} 
		
			$(this).siblings('.upload_name').val(filename); 			
			var html = "<img src='images/"+filename+"' id='representative_img1' alt='대표이미지 오류'/>";	
			$(".upload_image_representative").html(html);
		
		});	
		
		
		// 상세이미지 삽입
		$(".upload_image").each(function(index, item){
			
			var index = index+1;
			
			$('#image'+index+'_btn').on('change', function(){ 
				if(window.FileReader){  
					var filename = $(this)[0].files[0].name; 
				}
			
			$(this).siblings('#upload_image'+index).val(filename); 
			var html = "<img src='images/"+filename+"' class = 'detail' id='image'"+index+"' alt='상세이미지 오류'/>";
			$(".detail"+index).html(html);
			
			});		
			
		});
				
		
		
	});
	
	
	
	function goSubmit(){
		
		var boolSubmit = false;
		// 1. 대표이미지 선택
		if($("#upload_name_rep").val()=="※필수 대표이미지선택"){
			alert("대표이미지를 등록해주세요.");
			return;
		}		 
		 
		// 2. 상품명 필수		
		if($("#product_name").val().trim()==""){
			alert('상품명을 입력해주세요.');
			$("#product_name").val("");
			$("#product_name").focus();
			return;
		}
		
		// 3. 상품명 중복 확인
		if($("#product_name").val().trim()!=""){
			$.ajax({
				url:"<%= ctxPath%>/manager/productNameDuplicateCheck.do",
				type:"post",
				data:{"productName":$("#product_name").val()},
				dataType:"json",
				success:function(json){
					if(!json.isUse){
						alert("중복된 상품명입니다. 상품명을 수정해주세요.");
						$("#product_name").val("");
						$("#product_name").focus();
						return;
					}else{
						// 4. 가격 필수 입력 
						if($("#price").val().trim()==""){
							alert("가격을 입력해주세요.");
							$("#price").val("");
							$("#price").focus();
							return;
						}
						// 4-1. 가격 숫자 유효성
						if($("#price").val()!=""){
							var regExp = new RegExp(/^[0-9]*$/); 
							var bool = regExp.test($("#price").val());
							if(!bool){
								alert("가격은 숫자만 입력 가능합니다.");
								$("#price").val("");
								$("#price").focus();
								return;
							}
						}								
						
						// 5. 재고 필수 입력
						if($("#stock").val().trim()==""){
							alert("재고를 입력해주세요.");
							$("#stock").focus();
							return;
						}
						
						// 5-1. 재고 숫자 유효성
						if($("#stock").val()!=""){
							var regExp = new RegExp(/^[0-9]*$/); 
							var bool = regExp.test($("#stock").val());
							if(!bool){
								alert("재고는 숫자만 입력 가능합니다.");
								$("#stock").val("");
								$("#stock").focus();
								return;
							}
						}
						
						// 6. 할인율 숫자 유효성
						if($("#sale").val()!=""){
							var regExp = new RegExp(/^[0-9]*$/); 
							var bool = regExp.test($("#sale").val());
							if(!bool){
								alert("할인율는 숫자만 입력 가능합니다.");
								$("#sale").val("");
								$("#sale").focus();
								return;
							}
						}
					
						// 7. best-point 유효성
						if($("#best_point").val()!=""){
							var regExp = new RegExp(/^[0-9]*$/); 
							var bool = regExp.test($("#best_point").val());
							if(!bool){
								alert("추천지수는 숫자만 입력 가능합니다.");
								$("#best_point").val("");
								$("#best_point").focus();
								return;
							}
						}
						
						var frm = document.productInsert;
						frm.method="post";
						frm.action="managerProductInsert.do";
						frm.submit();		
						 
					}
				},						
				error: function(request, status, error){
					alert("code: "+request.status+"\n"+"message: "+request.responseText+"\n"+"error: "+error);
				}
				
			});
	
		}
		
		
	}
	
</script>
</head>
<body>
	<div class="Mycontainer">
	
		<%-- <jsp:include page="include/header.jsp"></jsp:include> --%>
		
		<div class="section" align="center">
			<div class="contents">
				<div class="sideMenu">
					<%-- <jsp:include page="include/managerSide.jsp"></jsp:include> --%>
				</div>
				
				<div id="info">
					<form name="productInsert" >
						<div class="newGoodsAdd" id="newGoodsAdd0" align="left">
							<div class="newGoodsTitle" id="newGoodsTitle0">
								<h4>신규 상품 추가 폼</h4>
							</div>
							
							<div class="newProductImg" align="center" id="newGoodsImg0">
								<div class="representative_img">
									<div class="upload_image_representative">								
									</div>
									<input class="upload_name" id="upload_name_rep" value="※필수※ 대표이미지 선택" disabled="disabled" style="width:200px;">
									<label for="representative_img_btn">찾기</label>
									<input type="file" class="upload_hidden" id="representative_img_btn" name="representative_img" />
								</div>
								<div class="abcd">
									<div class="detail_img">
										<div class="upload_image_detail detail1">
										</div>
										<input class="upload_name" id="upload_image1" value="이미지 선택1" disabled="disabled">																		
										<label for="image1_btn">찾기</label>
										<input type="file" class="upload_image" id="image1_btn" name="image1" />
									</div>
									<div class="detail_img">
										<div class="upload_image_detail detail2">								
										</div>
										<input class="upload_name" value="이미지 선택2" disabled="disabled">
										<label for="image2_btn">찾기</label>
										<input type="file" class="upload_image" id="image2_btn" name="image2" />
									</div>
									<div class="detail_img">
										<div class="upload_image_detail detail3">								
										</div>
										<input class="upload_name" value="이미지 선택3" disabled="disabled">
										<label for="image3_btn">찾기</label>
										<input type="file" class="upload_image" id="image3_btn" name="image3" />
									</div>
								</div>
							</div>
							
							<div class="newProductForm" align="left" id="newGoodsForm0">				
								
								<ul class="newProductInfo" id="newProduct_ul">
									<li>
										<label>대분류</label>
										<select id="fk_category_num" name="fk_category_num" class="bigSelect">
											<option value="1">채소</option>
											<option value="2">과일 견과</option>									
										</select>									
									</li>
									<li>
										<label>소뷴류</label>
										<select id="fk_subcategory_num" name="fk_subcategory_num" class="smallSelect">
											<option value="11">기본채소</option>
											<option value="12">쌈 샐러드</option>	
										</select>
									</li>
									<li>
										<label for="product_name">상품명</label>
										<input type="text" id="product_name" name="product_name" class="goodsName" placeholder="※필수※"/>
									</li>
									<li>
										<label for="unit">단위</label>
										<input type="text" id="unit" name="unit" class="goddsUnit"/>
									</li>
									<li>
										<label for="packing">포장타입</label>
										<input type="text" id="packing" name="packing" class="packageType"/>
									</li>
									<li>
										<label for="origin">원산지</label>
										<input type="text" id="origin" name="origin" class="goodsOrigin"/>
									</li>									
									<li>
										<label for="price">가격(원)</label>
										<input type="text" id="price" name="price" class="goodsPrice" placeholder="※필수※  숫자로 입력 ex)10000"/>
									</li>
									<li>
										<label for="sale">할인율(%)</label>
										<input type="text" id="sale" name="sale" class="goodsPrice" placeholder="숫자로 입력 ex)10"/>
									</li>
									<li>
										<label for="best_point">추천지수</label>
										<input type="text" id="best_point" name="best_point" class="goodsPrice" placeholder="숫자로 입력 ex)10"/>
									</li>
									<li>
										<label for="seller">판매자</label>
										<input type="text" id="seller" name="seller" class="goodsPrice"/>
									</li>
									<li>
										<label for="seller_phone">판매자 번호</label>
										<input type="text" id="seller_phone" name="seller_phone" class="goodsPrice"/>
									</li>
									<li style="margin:0;">
										<label for="stock">재고 수</label>
										<input type="text" id="stock" name="stock" class="goodsCount" placeholder="※필수※  숫자로 입력"/>
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
		<%-- <jsp:include page="include/footer.jsp"></jsp:include> --%>
	</div>
</body>
</html>