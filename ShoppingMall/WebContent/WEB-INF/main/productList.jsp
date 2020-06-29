<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
<% 
	String ctxPath = request.getContextPath(); 
%>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<link rel="stylesheet" href="<%= ctxPath %>/css/style.css" />
<title>상품리스트</title>
</head>
<style>
	div#smallT, .productList {
		border: solid 0px gray;
		display: inline-block;
		margin: 30px;
	}
	.contents h3{
		margin-left: 30px;
	}
	.sub {
		font-size: 15pt;
		padding: 0px 15px;
		cursor: pointer;
	} 
	#smallT {
		border: solid 1px green;
		clear: both;
		float: left;
	}
	#list {
		border: solid 1px blue;
		margin-top: 80px;
		float: right;
	}
	tr, td {
		border: solid 0px red;
		display: inline-block;
		padding: 30px;
	}
	#h3{
		border: solid 1px red;
		width: 200px;
		margin-top: 100px;
		font-size: 20pt;
		float: left;
	}
	a:link { text-decoration: none;}
 	a:visited { text-decoration: none;}

</style>
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.1/css/bootstrap.min.css">
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
<script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.1/js/bootstrap.min.js"></script>
<script type="text/javascript" src="/ShoppingMall/js/jquery-3.3.1.min.js"></script>
<script type="text/javascript" src="/ShoppingMall/util/myutil.js"></script>
<script type="text/javascript">

	$(document).ready(function(){
		
		$(".sub").hover(function(){
			var selectcate = $(this).index();
			console.log(selectcate); 
			// 2 3 4
			$(this).css('color','purple');
		},function(){
			$(".sub").css('color','black');
		});
		
		$(".sub").click(function(){
			$(".sub").css('border-bottom','solid 0px purple');
			$(this).css('border-bottom','solid 2px purple');
			
		});
		
		$("#list").change(function(){
			var optionSelect = $("#list option:selected").val();
			var cate = $(".cate").val();
			var subcate = $(".subcate").val();
			// alert(subcate);
			
			$.ajax({
				url:"<%=ctxPath%>/product/selectOption.do",
				data:{"optionSelect":optionSelect,
					  "subcate":subcate,
					  "cate":cate},
				dataType:"JSON",
				success:function(json){
					
				},
				error: function(request, status, error){
					alert("code: "+request.status+"\n"+"message: "+request.responseText+"\n"+"error: "+error);
				}
			});
			
		}); // end of $("#list").change()----------------------------
		
		
	});
	
</script>
<body>
	<div class="Mycontainer">
		<jsp:include page="../include/header.jsp"></jsp:include>
		<div class="section" align="center">
			<div class="contents">
				
				<div id="h3">${categoryInfo}</div>
				
				<div id="smallT">
						<a href='/ShoppingMall/product/productList.do?fk_category_num=${fk_category_num}'><span class="sub">전체보기</span></a>
					<c:forEach var="cate" items="${subcategoryList}" varStatus="status">
						<a href='/ShoppingMall/product/productList.do?fk_category_num=${fk_category_num}&fk_subcategory_num=${cate.subcategory_num}'><span class="sub">${cate.subcategory_content}</span></a>
					</c:forEach>
					<input type="hidden" class="cate" value="${fk_category_num}"/>
					<input type="hidden" class="subcate" value="${fk_subcategory_num}"/>
					
				</div>
				<div id="list">
					<select>
						<option value="registerdate" >신상품순</option>
						<option value="desc" >낮은 가격순</option>   
						<option value="asc" >높은 가격순</option>
					</select>
				</div>
				
		<div class="productList" align="center">
		<table>
	        <tbody id="pList">
				<%-- 일단은 페이징처리를 안한 관리자를 제외한 모든 회원정보를 조회하도록 한다. --%>
				<c:if test="${empty productList}">
					<tr> 
						<td colspan = "3">현재 상품 준비중...</td>
					</tr>
				</c:if>
				
				<c:if test="${not empty productList}">
					<tr>
						<c:forEach var="pvo" items="${productList}" varStatus="status">
							<td>
								<a href='/ShoppingMall/detail.do?product_num=${pvo.product_num}'>
									<img width="300px;" height="400px;" src="/ShoppingMall/images/${pvo.representative_img}" />
								</a>
								<br/>${pvo.product_name}
								<c:if test="${pvo.sale != 0}">
									<br/><span style="text-decoration: line-through;"><fmt:formatNumber value="${pvo.price}" pattern="###,###"/> 원</span>
									&nbsp;=>&nbsp;<fmt:formatNumber value="${pvo.finalPrice}" pattern="###,###" /> 원
								</c:if>
								<c:if test="${pvo.sale == 0}">
									<br/><fmt:formatNumber value="${pvo.price}" pattern="###,###"/> 원
								</c:if>
							</td> 
						<c:if test="${(status.count)%3 == 0 }">
							</tr>
							<tr>
						</c:if>
						
						</c:forEach>
					</tr>
				</c:if>
			</tbody>
		</table>
		
	    <div>
	    	${pageBar}
	    </div>	
				</div>
			</div>
		
		<jsp:include page="../include/footer.jsp"></jsp:include>
		
		</div>
	</div>
</body>
</html>