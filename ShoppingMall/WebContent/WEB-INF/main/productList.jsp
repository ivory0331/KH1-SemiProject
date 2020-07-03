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
	.contents {
		border: solid 0px blue;
	}
	.sub {
		font-size: 12pt;
		padding: 0px 15px;
		cursor: pointer;
		color: gray;
	} 
	.smallT {
		border: solid 0px blue;
		clear: both;
		float: left;
		margin-left: 160px;
	}
	#list {
		border: solid 0px blue;
		margin-right: 130px;
		float: right;
	}
	#pList{
		display: inline-block;
		margin: 0 0 40px 50px !important;
	}
	tr, td {
		border: solid 0px red;
		display: inline-block;
	}
	td {
		width: 270px;
		height: 450px;
		margin-bottom: 10px;
	}
	#h3{
		border: solid 0px red;
		width: 200px;
		margin-top: 50px;
		float: left;
		margin-left: 120px;
		margin-bottom: 10px;
	}
	#catefont {
		font-size: 14pt;
		font-weight: bold;
	}
	
	.smallT>a :hover { text-decoration: none !important; 
			  border-bottom: solid 2px purple !important;}
	a:hover {
		text-decoration: none !important;
	}
	
	#searchWord{
		font-size: 14pt;
		width: 400px;
		margin-right: 30px;
	}
	
	#goBtn{
		width: 175px;
		height: 45px;
		font-size: 14pt;
		background-color: #5f0080;
		outline:none;
		border: none;
		padding: 0 40px;
		color:white;
	}
	
	form[name='searchForm']{
		display: block;
		padding: 50px;
	}
	table {
		text-align: center;
	}

	.sample_image img {
	    -webkit-transform:scale(1);
	    -moz-transform:scale(1);
	    -ms-transform:scale(1); 
	    -o-transform:scale(1);  
	    transform:scale(1);
	    -webkit-transition:.3s;
	    -moz-transition:.3s;
	    -ms-transition:.3s;
	    -o-transition:.3s;
	    transition:.3s;
	}
	.sample_image:hover img {
	    -webkit-transform:scale(1.1);
	    -moz-transform:scale(1.1);
	    -ms-transform:scale(1.1);   
	    -o-transform:scale(1.1);
	    transform:scale(1.1);
	}
	.sample_image {
		border: solid 0px yellow;
		overflow: hidden;
	}
	.pricecolor {
		text-align: left;
	}
	#optionSelect {
		height: 20px;
		font-size: 9pt;
	}
</style>
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.1/css/bootstrap.min.css">
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
<script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.1/js/bootstrap.min.js"></script>
<script type="text/javascript" src="/ShoppingMall/js/jquery-3.3.1.min.js"></script>
<script type="text/javascript" src="/ShoppingMall/util/myutil.js"></script>
<script type="text/javascript">

	$(document).ready(function(){
	
		
		$("option").each(function(index, item){
			if($(item).val() == "${optionSelect}"){
				$(item).prop("selected",true);
			}
		})
		
		$(".sub").each(function(index,item){
			var idvar = $(this).prop("id").substring(7);
		//	console.log(idvar);
			if(idvar == "${fk_subcategory_num}"){ // 5 51 전체보기 소분류
				$(item).css({'color':'purple','font-weight':'bold','border-bottom':'solid 2px purple'});
				$(".subb").css({'color':'gray','font-weight':'normal','border-bottom':'solid 0px purple'});
			}
			else if(idvar == "${fk_category_num}") {
				// 5 전체보기
				$(item).css({'color':'purple','font-weight':'bold','border-bottom':'solid 2px purple'});
			}
	
		});

		$("#optionSelect").change(function(){
			 
			var frm = document.opList;
			frm.action="<%=ctxPath%>/product/productList.do";
			frm.method="get";
			frm.submit();
		
		}); // end of $("#optionSelect").change()----------------------------
		
		
	}); // end of $(document).ready(function(){})-------------------------------
	
	function goSearch(){
		var frm = document.searchForm;
		frm.action="<%=ctxPath%>/searchList.do";
		frm.method="get";
		frm.submit();
	}
</script>
<body>
	<div class="Mycontainer">
		<jsp:include page="../include/header.jsp"></jsp:include>
		<div class="section" align="center">
			<div class="contents">
				<c:if test="${empty productSearchWord}">
					<div id="h3"><img alt="대분류사진" style="width:50px; height:50px;" src="/ShoppingMall/images/${categoryInfo}.png"><span id="catefont">${categoryInfo}</span></div>
					
					<div class="smallT">
							<a href='/ShoppingMall/product/productList.do?fk_category_num=${fk_category_num}'><span class="sub subb" id="cateNum${fk_category_num}">전체보기</span></a>
						<c:forEach var="cate" items="${subcategoryList}" varStatus="status">
							<a href='/ShoppingMall/product/productList.do?fk_category_num=${fk_category_num}&fk_subcategory_num=${cate.subcategory_num}'><span class="sub" id="cateNum${cate.subcategory_num}">${cate.subcategory_content}</span></a>
							
						</c:forEach>
					</div>
					<form name="opList">
					<div id="list">
						<select name="optionSelect" id="optionSelect">
							<option value="registerdate" >신상품순</option>
							<option value="asc" >낮은 가격순</option>   
							<option value="desc" >높은 가격순</option>
						</select>
					</div>
						<input type="hidden" name="fk_category_num" value="${fk_category_num}" />
						<input type="hidden" name="fk_subcategory_num" value="${fk_subcategory_num}" />
					</form>
				</c:if>

				<c:if test="${not empty productSearchWord}">
					<div style="margin: 50px 0 ;">
						<h1 style="padding-bottom: 15px;">상품검색</h1>
						<span style="color: #999; font-size: 16px;">신선한 컬리의 상품을 검색해보세요.</span>
					</div>
					<form name="searchForm" style="border-top:solid 2px #5f0080; border-bottom:solid 1px #5f0080;">
						<div style="display: inline-block; float:left; width: 100px; font-size:14pt;">
							<label style="margin-top: 10px;">검색조건</label>
						</div>
						<div style="display: inline-block;">
							<input type="text" name="productSearchWord" id="searchWord" value="${productSearchWord}"/>
							<input type="button" id="goBtn" onclick="goSearch()" value="검색하기" />
						</div>
						
					</form>
				</c:if>
				
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
							<td class="pricecolor">
								<a href='/ShoppingMall/detail.do?product_num=${pvo.product_num}'>
									<div style="width:250px; height:350px;" class="sample_image"><img style="width:100%; height:100%;" src="/ShoppingMall/images/${pvo.representative_img}" /></div>
									<br/><span style="font-size:13pt; letter-spacing: 0.6px; color:#333;">${pvo.product_name}</span>
									<c:if test="${pvo.sale != 0}">
										<br/><span style="text-decoration: line-through; color: #ccc; font-weight: bold; font-size: 17px;"><fmt:formatNumber value="${pvo.price}" pattern="###,###"/> 원</span>
										<span style="color: #5f0080; font-weight: bold; font-size: 17px;">&nbsp;→&nbsp;<fmt:formatNumber value="${pvo.finalPrice}" pattern="###,###" />원</span>
									</c:if>
									
									<c:if test="${pvo.sale == 0}">
										<br/><span style="color: #5f0080; font-weight: bold; font-size: 17px;"><fmt:formatNumber value="${pvo.price}" pattern="###,###"/>원</span>
									</c:if>
								</a>
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
	    <div>
	    	<a style="display:scroll;position:fixed;bottom:10px;right:10px;margin:10px;" href="#" title=”맨위로"><img style="width:60px; height:55px;" src="/ShoppingMall/images/topBtn.png"></a>
	    </div>
				</div>
			</div>
		
		<jsp:include page="../include/footer.jsp"></jsp:include>
		
		</div>
	</div>
</body>
</html>