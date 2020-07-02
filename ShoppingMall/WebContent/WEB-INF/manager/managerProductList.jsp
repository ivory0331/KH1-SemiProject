<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %> 
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
   
<% String ctxPath = request.getContextPath(); %>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<link rel="stylesheet" href="<%= ctxPath %>/css/style.css" />
<!-- 진하 -->
<title>managerProduct.jsp</title>

<!-- 차트 링크 --> 
<script src="https://cdn.jsdelivr.net/npm/chart.js@2.8.0"></script> 
<style type="text/css">
	.sideMenu{
		margin-top:10px;
		display: inline-block;
		width: 150px;
		float:left;
	}
	.memberList{
		display:inline-block;
		width:800px;
		margin-top: 10px;
	}
	
	.member-search{
		width:100%;
		margin-bottom:5px;
	}
	
	.goodsList{
		width: 100%;
		text-align: center;
	}
	
	.goods-add{
		float: right;
		margin-bottom:5px;
	}
	
	.board-title{
		width: 150px;
	}
	
	.type{
		border:solid 1px purple;
		margin-left:10px;
		padding:10px 20px;
		color:purple;
	}
	
	.type:hover{
		cursor: pointer;
		background-color: purple;
		color:white;
	}
	
	td#product_click{
		cursor:pointer;
	}
	
	
	.img{
		width:80px;
		height:100px;
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
		
		
		
		
		// 검색 상황 유지
		if("${searchWord}" != "") {
			$("input#searchWord").val("${searchWord}");
		}		
				
		$("option.bigSelect").each(function(index,item){
			if($(item).val()==0){
				$("select#fk_subcategory_num").prop('disabled',true);
			}
			else if($(item).val()=="${fk_category_num}"){
				
				$(item).prop("selected",true);		
				$("select#fk_subcategory_num").prop('disabled',false);
				
				
			}
		})
		
		
		$("option.smallSelect").each(function(index,item){
			if($(item).val()=="${fk_subcategory_num}"){
				$(item).prop("selected",true);				
			}
		})
				
		
		// 소분류 	변경
		$("select#fk_category_num").bind("change", function(){
			
			if($("select#fk_category_num").val()==0){
				var html="<option class='smallSelect' value='0'>===소분류===</option>";
				$("#fk_subcategory_num").html(html); 	
				$("select#fk_subcategory_num").prop('disabled',true);
			}else{
			
				$.ajax({
					url:"<%= ctxPath%>/manager/getSubCategoryList.do",
					type:"post",
					data:{"fk_category_num":$("#fk_category_num").val()},
					dataType:"json",
					success:function(json){	
						$("select#fk_subcategory_num").prop('disabled',false);
						var html="<option class='smallSelect' value='0'>전체</option>";
						for(var i=0; i<json.length;i++){
							html +="<option class='smallSelect' value='"+json[i].subcategory_num+"'>"+json[i].subcategory_content+"</option>";
						}
						$("#fk_subcategory_num").html(html); 	
						
					},						
					error: function(request, status, error){
						alert("code: "+request.status+"\n"+"message: "+request.responseText+"\n"+"error: "+error);
					}
					
				});
			}	
		})
		
		
		
		// 페이지처리
		$("#sizePerPage").val("${sizePerPage}");	  
		
		$("#sizePerPage").bind("change", function(){		 	  
			var frm = document.manager_productFrm;		 
			frm.method = "GET";
			frm.action = "<%= ctxPath%>/manager/managerProductList.do";
			frm.submit();
		});
		
		
		$("#searchWord").bind("keydown", function(event){
			if(event.keyCode == 13) {//엔터
				goSearch();
			}
		});
		
		
		
		// 상품 상세 보기
		$("td#product_click").click(function(){
			var product_num = $(this).siblings(".product_num").text();
	        location.href="<%= ctxPath%>/manager/managerProductDetail.do?product_num="+product_num;  
		})

		
		
	});
	
	
	
	
	
	// 검색 버튼 전송
	function goSearch() {	 
	 
		var frm = document.manager_productFrm;
		frm.method = "GET";
		frm.action = "managerProductList.do";
		frm.submit();
	 
	}
	
	// 전체 선택
	var bool = true;
	function allCheck(){			
		
		for(var i=0; i<$(".goodsList tr").length; i++){
			$(".goodsList_check").prop('checked',bool);
			bool = !bool;
		}
	}
	
	
	function product_delete(){
		if (confirm("해당 상품을 삭제하시겠습니까?") == true){ //확인 누르면 전송
			/* 
			var selectedProductsNum = "";
			$("input:checkbox[name=product_num]").each(function(index,item){
				if($(this).checked){
					selectedProductsNum += this.value + ",";
				}
			});
			 */
			
			var frm = document.manager_productTableFrm;
			frm.method = "POST";
			frm.action = "managerProductDelete.do";
			frm.submit();		
			
		}else{   //취소
		    return;
		}
	}
	
	
	// 상품 신규 등록
	function product_insert(){
		location.href="<%=ctxPath%>/manager/managerProductInsert.do";
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
				<div class="memberList" align="left">
					<div class="member-search">
						<h4>상품관리</h4>
						<form name="manager_productFrm">
							<div>
								<select id="fk_category_num" name="fk_category_num" class="bigSelect">
									<option class="bigSelect" value="0">=== 대분류 ===</option>
									<c:forEach var="map" items="${requestScope.categoryList}">
								    	<option class="bigSelect" value="${map.category_num}">${map.category_content}</option>
								    </c:forEach>	
								</select>
								<select id="fk_subcategory_num" name="fk_subcategory_num" disabled>
									<option>=== 소분류 ===</option>
								</select>
							</div>
							<input type="text" id ="searchWord" name="searchWord"/>	
							<button type="button" onclick="goSearch();">검색</button>
							<select id="sizePerPage" name="sizePerPage">
								<option value="10">10</option>
								<option value="5">5</option>
								<option value="3">3</option>
							</select>									
						</form>		
						<span class="type goods-add" onclick="product_insert()">상품 추가</span>
					</div>
					
					<button type="button" id="btnAllCheck" onclick="allCheck();">전체선택</button>
					<form name="manager_productTableFrm">
					<table class="table goodsList" style="border-top:solid 2px purple;">
						<thead>
							<tr>
								<th>선택</th>
								<th>No.</th>
								<th>대분류</th>
								<th>소분류</th>
								<th class="board-title">상품 이미지</th>
								<th>상품명</th>
								<th>가격</th>
								<th>재고수</th>
							</tr>
						</thead>	
						<tbody>		
							<c:if test="${empty productList}">	
								<tr>
									<td colspan="8"> 검색 설정에 맞는 상품이 없습니다. </td>
								</tr>	
							</c:if>
						
							
							<c:if test="${not empty productList}">		
								<c:forEach var="pvo" items="${productList}">
									<tr>
										<td><input type="checkbox" class="goodsList_check" name="product_num" value="${pvo.product_num}"></td>
										<td class="product_num">${pvo.product_num}</td>
										<td style="text-align: left;">${pvo.category_content}</td>
										<td style="text-align: left;">${pvo.subcategory_content}</td>
										<td><img class="img" src="/ShoppingMall/images/${pvo.representative_img}" alt="사진"/></td>								
										<td style="text-align: left;" id="product_click">${pvo.product_name}</td>
										<td style="text-align: right;"><fmt:formatNumber value="${pvo.price}" pattern="###,###"/></td>
										<td>${pvo.stock}</td>
									</tr>
								</c:forEach>	
							</c:if>					
						</tbody>
					</table>
					</form>
				</div>
				
				<div style="clear:both;"></div>
				
				<div class="managerBtn" align="right">
					<span class="type" onclick="product_delete()">삭제</span>
				</div>
				
				<div class="paging">
					${pageBar}	
				</div>
				
			</div>
		</div>
		<jsp:include page="../include/footer.jsp"></jsp:include>
	</div>
</body>
</html>