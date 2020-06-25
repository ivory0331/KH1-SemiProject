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
	
	
</style>
<!-- 부트스트랩 -->
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.1/css/bootstrap.min.css">
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
<script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.1/js/bootstrap.min.js"></script>
<script type="text/javascript" src="/ShoppingMall/js/jquery-3.3.1.min.js"></script>
<script type="text/javascript" src="/ShoppingMall/util/myutil.js"></script>
<script type="text/javascript">
	$(document).ready(function(){
		
		// 소분류 활성화	
		$("select#fk_category_num").bind("change", function(){
			if($("select#fk_category_num").val()!=0){
				$("select#fk_subcategory_num").prop('disabled',false);
			}else{
				$("select#fk_subcategory_num").prop('disabled',true);
			}			
		})
		
		// 검색 상황 유지
		if("${searchWord}" != "") {
			$("select#fk_category_num").val("${fk_category_num}");
			$("input#searchWord").val("${searchWord}");
		}			
		  
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
								<select id="fk_category_num" name="fk_category_num">
									<option value="0">=== 대분류 ===</option>
									<option value="1">채소</option>
									<option value="2">과일 견과</option>
									<option value="3">수산 해산</option>
									<option value="4">정육 계란</option>
									<option value="5">음료 우유</option>
								</select>
								<select id="fk_subcategory_num" name="fk_subcategory_num" disabled>
									<option value="0">=== 소분류 ===</option>
									<option value="41">기본채소</option>
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
						<span class="type goods-add">상품 추가</span>
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
										<td>${pvo.product_num}</td>
										<td style="text-align: left;">${pvo.category_content}</td>
										<td style="text-align: left;">${pvo.subcategory_content}</td>
										<td><img src="" alt="사진"></td>								
										<td style="text-align: left;">${pvo.product_name}</td>
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