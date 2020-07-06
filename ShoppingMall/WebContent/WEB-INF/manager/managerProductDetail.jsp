<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<% String ctxPath = request.getContextPath(); %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<link rel="stylesheet" href="<%= ctxPath %>/css/style.css" />
<title>ProductUpdate.jsp</title>
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
		display:inline-block;
		width: 900px;
		margin-left:10px;
		margin-top:10px;
	}
	
	input, select, textarea{
		width:210px;
		height:35px;
		vertical-align: middle;
		border: solid 1px #ddd; /* 회색 */
		padding-left: 5px;		
		outline: none;
		
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
	
	
	.representative_img_upload{
		margin-bottom:10px;
		width : 446px;
		height: 300px;
		border:solid 1px #ddd;
	}
	
	#img0{
		width : 446px;
		height: 300px;
	}
	
	div.detail_img{
		align-content : center;
		display: inline-block;	
		width: 150px;
		height: 180px;
		margin:0 10px;
	}
	
	/* 파일 선택 디자인 */
	.newProductImg label{ 
		height:35px;
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
	
	.detail_img{
		width:150px;
		height:180px;
	}

	
	/* 상품 정보 입력*/
	div.newProductInfo{
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
		
		// 상세 이미지 빈칸 시 설정
		$(".upload_name").each(function(index,item){
			
			if($("#upload_name"+index).val()==""){
				$("#upload_name"+index).val("이미지 선택"+index);
			}			
		})
		
		
		
		// 대표이미지 삽입
		$('.upload_rep_image').on('change', function(){
			
			if(window.FileReader){
				var filename = $(this)[0].files[0].name;
			} 		
			
			var extn = filename.substring(filename.lastIndexOf('.') + 1).toLowerCase();			

			if (extn == "gif" || extn == "png" || extn == "jpg" || extn == "jpeg") {
				
				$(this).siblings('.upload_name').val(filename); 
				
		         if (typeof (FileReader) != "undefined") {

	                 var reader = new FileReader();
	                 reader.onload = function (e) {	 
	                	 $("#img0").prop("src",e.target.result);
	                 }

	                 reader.readAsDataURL($(this)[0].files[0]);	             

		         } else {
		             alert("이미지 업로드에 실패하였습니다");
		         }
		     } else {
		         alert("이미지 확장자 파일만 선택해주세요.");
		     }
			
			
		});		
		
		
		// 상세이미지 삽입
		$(".detail_img").each(function(index, item){
			
			var index = index+1;
			
			$('#image'+index+'_btn').on('change', function(){ 
								
				if(window.FileReader){  
					var filename = $(this)[0].files[0].name; 
				}
			
				var extn = filename.substring(filename.lastIndexOf('.') + 1).toLowerCase();			

				if (extn == "gif" || extn == "png" || extn == "jpg" || extn == "jpeg") {
					
					$(this).siblings('.upload_name').val(filename); 
					
			         if (typeof (FileReader) != "undefined") {

		                 var reader = new FileReader();
		                 reader.onload = function (e) {	                    
		                     var html = "<img class='detail_img' id='img"+index+"' src='"+e.target.result+"'>";
		                     $(".detail"+index).html(html);
		                 }

		                 reader.readAsDataURL($(this)[0].files[0]);
		             

			         } else {
			             alert("이미지 업로드에 실패하였습니다");
			         }
			     } else {
			         alert("이미지 확장자 파일만 선택해주세요.");
			     }
			
				
				
			});		
			

			$("#image"+index+"_delete").click(function(){ 
				if($('image'+index+'_btn').val!=null){
					$('image'+index+'_btn').val('');
					$('#upload_name'+index).val('이미지 선택'+index); 
					$("#img"+index).remove();
				}
			});
			
		});
		
		
		
		
		
		// 소분류 불러오기
		$.ajax({
			url:"<%= ctxPath%>/manager/getSubCategoryList.do",
			type:"post",
			data:{"fk_category_num":$("#fk_category_num").val()},
			dataType:"json",
			success:function(json){	
				var html='';
				for(var i=0; i<json.length;i++){
					html +="<option value='"+json[i].subcategory_num+"'";

					if(json[i].subcategory_num==$("#subcategory_num").val()){
						html += " selected ";
					}
					
					html +=">"+json[i].subcategory_content+"</option>";
				}
				$("#fk_subcategory_num").html(html); 
			},						
			error: function(request, status, error){
				alert("code: "+request.status+"\n"+"message: "+request.responseText+"\n"+"error: "+error);
			}
			
		});

		
		
		
		// 대분류 변경 시
		$("select#fk_category_num").bind("change", function(){
			
			$.ajax({
				url:"<%= ctxPath%>/manager/getSubCategoryList.do",
				type:"post",
				data:{"fk_category_num":$("#fk_category_num").val()},
				dataType:"json",
				success:function(json){	
					$("select#fk_subcategory_num").prop('disabled',false);
					var html='';
					for(var i=0; i<json.length;i++){
						html +="<option value='"+json[i].subcategory_num+"'>"+json[i].subcategory_content+"</option>";
					}
					$("#fk_subcategory_num").html(html); 
				},						
				error: function(request, status, error){
					alert("code: "+request.status+"\n"+"message: "+request.responseText+"\n"+"error: "+error);
				}
				
			});
					
		})
		
	});
		
	
	
	
	
	
	
	function goSubmit(){
		
		var imageCount=0;
		for(var i=0; i<3; i++){
			if($("#image"+(i+1)+"_btn").val()!=""){
				imageCount++;	
			}			
		}
					
		$("#imageCount").val(imageCount);		
		
		var boolSubmit = false;
		// 1. 대표이미지 선택
		if($(".upload_name").val()==""){
			alert("대표이미지를 등록해주세요.");
			return;
		}		 
		
		// 1.1 분류 선택
		if($("#fk_category_num").val()=="0"){
			alert('상품 분류를 선택해주세요.');
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
				data:{"productName":$("#product_name").val(),"productNum":$("#product_num").val()},
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
						frm.action="managerProductUpdate.do";
						frm.enctype="multipart/form-data";
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
	
		<jsp:include page="../include/header.jsp"></jsp:include>
		
		<div class="section" align="center">
			<div class="contents">
				<div class="sideMenu">
				<jsp:include page="../include/managerSide.jsp"></jsp:include>
				</div>
				
				<div id="info">
					<form name="productInsert" >
						<div class="newGoodsAdd" id="newGoodsAdd0" align="left">
							<div class="newGoodsTitle" id="newGoodsTitle0" style="margin:10px 0;">
								<h3 style="margin:25px 0; padding:15px">상품 상세 페이지</h3>
							</div>
							
							<div class="newProductImg" align="center" id="newProductImg0">
								<div class="representative_img">
									<div class="representative_img_upload">	
										<img id="img0" src="/ShoppingMall/images/${pvo.representative_img}">							
									</div>
									<input class="upload_name" id="upload_name0" value="${pvo.representative_img}" disabled style="width:200px;">
									<label for="representative_img_btn">찾기</label>
									<input type="file" class="upload_rep_image" id="representative_img_btn" name="representative_img" />
								</div>
								
								<div class="detailImgDiv">
									<div class="detail_img">
										<div class="upload_image_detail detail1">
											<c:if test="${not empty pvo.imageList[0].image }">
												<img class="detail_img" id="img1" src="/ShoppingMall/images/${pvo.imageList[0].image}">
											</c:if>
										</div>
										<input class="upload_name" name="upload_name1" id="upload_name1" value="${pvo.imageList[0].image}" readonly>
										<input type="hidden" class="old_name" name="old_name1" id="old_name1" value="${pvo.imageList[0].img_num}">
										<label for="image1_btn">찾기</label>
										<input type="file" class="upload_image" id="image1_btn" name="detail_img1" />`	
										<label class="image_delete" id="image1_delete">삭제</label>
									</div>
									<div class="detail_img">
										<div class="upload_image_detail detail2">	
											<c:if test="${not empty pvo.imageList[1].image }">
												<img class="detail_img" id="img2" src="/ShoppingMall/images/${pvo.imageList[1].image}">
											</c:if>
										</div>
										<input class="upload_name" name="upload_name2" id="upload_name2" value="${pvo.imageList[1].image}" readonly>
										<input type="hidden" class="old_name" name="old_name2" id="old_name2" value="${pvo.imageList[1].img_num}">
										<label for="image2_btn">찾기</label>
										<input type="file" class="upload_image" id="image2_btn" name="detail_img2" />
										<label class="image_delete" id="image2_delete">삭제</label>										
									</div>
									<div class="detail_img">
										<div class="upload_image_detail detail3">
											<c:if test="${not empty pvo.imageList[2].image }">
												<img class="detail_img" id="img3" src="/ShoppingMall/images/${pvo.imageList[2].image}">
											</c:if>																		
										</div>
										<input class="upload_name" name="upload_name3" id="upload_name3" value="${pvo.imageList[2].image}" readonly>
										<input type="hidden" class="old_name" name="old_name3" id="old_name3" value="${pvo.imageList[2].img_num}">
										<label for="image3_btn">찾기</label>
										<input type="file" class="upload_image" id="image3_btn" name="detail_img3" />
										<label class="image_delete" id="image3_delete">삭제</label>
									</div>
									<input type="hidden" name="imageCount" id="imageCount">
								</div>
							</div>
							
							<div class="newProductInfo" align="left" id="newProductInfo0">				
								
								<ul class="newProductInfo" id="newProduct_ul">
									<li>
										<label for="product_num">제품번호</label>
										<input type="text" id="product_num" name="product_num" value="${pvo.product_num}"class="goodsNum" readonly/>
									</li>
									<li>
										<label>대분류</label>
										<select id="fk_category_num" name="fk_category_num" class="bigSelect">
											<c:forEach var="map" items="${requestScope.categoryList}">
								               <option value="${map.category_num}"
								                 <c:if test="${map.category_num==pvo.fk_category_num}">selected</c:if>>${map.category_content}</option>
								            </c:forEach>	
										</select>									
									</li>
									<li>
										<label>소뷴류</label>
										<input type="hidden" id="subcategory_num" value="${pvo.fk_subcategory_num}">
										<select id="fk_subcategory_num" name="fk_subcategory_num" class="smallSelect">																					
										</select>
									</li>
									<li>
										<label for="product_name">상품명</label>
										<input type="text" id="product_name" name="product_name" value="${pvo.product_name}" class="goodsName" placeholder="※필수※"/>
									</li>
									<li>
										<label for="unit">단위</label>
										<input type="text" id="unit" name="unit" value="${pvo.unit}"class="goddsUnit"/>
									</li>
									<li>
										<label for="weight">중량/용량</label>
										<input type="text" id="weight" name="weight" value="${pvo.weight }" class="goddsWeight"/>
									</li>
									<li>
										<label for="packing">포장타입</label>
										<input type="text" id="packing" name="packing" value="${pvo.packing}" class="packageType"/>
									</li>
									<li>
										<label for="origin">원산지</label>
										<input type="text" id="origin" name="origin" value="${pvo.origin}" class="goodsOrigin"/>
									</li>	
									<li>
										<label for="shelf">유통기한</label>
										<input type="text" id="shelf" name="shelf" value="${pvo.shelf }" class="goodsShelf"/>
									</li>								
									<li>
										<label for="price">가격(원)</label>
										<input type="text" id="price" name="price" value="${pvo.price}" class="goodsPrice" placeholder="※필수※  숫자로 입력 ex)10000"/>
									</li>
									<li>
										<label for="sale">할인율(%)</label>
										<input type="text" id="sale" name="sale" value="${pvo.sale}" class="goodsPrice" placeholder="숫자로 입력 ex)10"/>
									</li>
									<li>
										<label for="best_point">추천지수</label>
										<input type="text" id="best_point" name="best_point" value="${pvo.best_point}" class="goodsPrice" placeholder="숫자로 입력 ex)10"/>
									</li>
									<li>
										<label for="seller">판매자</label>
										<input type="text" id="seller" name="seller" value="${pvo.seller}" class="goodsPrice"/>
									</li>
									<li>
										<label for="seller_phone">판매자 번호</label>
										<input type="text" id="seller_phone" name="seller_phone" value="${pvo.seller_phone}" class="goodsPrice"/>
									</li>
									<li style="margin:0;">
										<label for="stock">재고 수</label>
										<input type="text" id="stock" name="stock" value="${pvo.stock}" class="goodsCount" placeholder="※필수※  숫자로 입력"/>
									</li>
								</ul>
							</div>
							<div align="center">
								<label>안내사항</label>
								<textarea style="width:95%; height:150px; resize: none;" name="information">${pvo.information}</textarea>
							</div>
							<div align="center">
								<label>상품 상세 설명</label>
								<textarea style="width:95%; height:150px; resize: none;"  name="explain" >${pvo.explain}</textarea>
							</div>
							</div>
				
						<div style="clear:both;"></div>
					</form>
					
					<div class="btn_area" align="right" >
							<span class="managerBtn" onclick="goSubmit()">확인</span>
							<span class="managerBtn" onclick="javascript:history.back();">취소</span>
					</div>
				</div>
				
			</div>
		</div>
		<jsp:include page="../include/footer.jsp"></jsp:include>
	</div>
</body>
</html>