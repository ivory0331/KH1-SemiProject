<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<% String ctxPath = request.getContextPath(); %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<link rel="stylesheet" href="<%= ctxPath %>/css/style.css" />
<title>managerGoods.jsp</title>
 
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
	
	a.tab {
		display: inline-block;	
		width: 400px;
		border: solid 1px #ddd;
		padding: 10px;			
	}
	
	a.tab:hover {
		text-decoration: none;
		cursor: pointer;
		color: #bbb;
	}
	
	.oneinquiry {
		float: left;
		
		color: #bbb;	
	}
	.quiryTitle{
		font-weight: bold;
	}
	
	.productinquriy {
		float: right;
		color: #5f0080;	
		border-bottom: solid 2px #5f0080 !important;
		
	}	
	
	.oneinquiry:hover {
		color: #5f0080 !important;	
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
		
		$("option[value='${searchType}']").prop("selected",true);
		
		$("#category").bind("change",function(event){
			
			goSubmit();
			
		});
		
		$("#searchWord").bind("keydown", function(event){
			  if(event.keyCode == 13) { //엔터
				  goSearch();
			  }
		});
		
	});
	
	function goSubmit(){
		$("select[name='searchType']").val("subject");
		$("input[name='searchWord']").val("");
		var frm = document.quiryFrm;
		frm.action = "<%=ctxPath%>/manager/managerOneInquiryList.do";
		frm.method = "get";
		frm.submit();
	}
	
	function goSearch(){
		if($("input[name='searchWord']").val().trim().length < 2){
			  alert("최소 두 글자를 입력해야 합니다.");
			  return false;
		  }
		var frm = document.quiryFrm;
		frm.action = "<%=ctxPath%>/manager/managerOneInquiryList.do";
		frm.method = "get";
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
				<form name="quiryFrm">
				<div class="memberList" align="left">
					<div class="member-search">
						<h4>문의관리</h4>
						<div id="quiry_Header">
							
							<div style="clear:both; height:20px;"></div>
							
							<div class="tab ">
								<a class="tab oneinquiry" href="<%= ctxPath %>/manager/managerOneInquiryList.do">1:1문의 관리</a>	
							</div>				
							<div class="tab">					
								<a class="tab productinquriy" href="<%= ctxPath %>/manager/managerProductInquiryList.do">상품문의 관리</a>	
							</div>	
							
							<div style="clear:both; height:10px;"></div>								
						</div>		
						<span>상품분류:</span>
						
						<select id="category" name="searchCategory">
							<option value="0">1차분류</option>
						<c:forEach var="category" items="${categoryList}">
							<c:if test="${category.num == searchCategory }">
							<option value="${category.num}" selected>${category.content}</option>
							</c:if>
							<c:if test="${category.num != searchCategory }">
							<option value="${category.num}">${category.content}</option>
							</c:if>
						</c:forEach>
						</select>
						
						
						<select id="subcategory" name="searchSubcategory">
							<option value="0">2차분류</option>
						<c:forEach var="category" items="${categoryList}">
							<c:if test="${category.num == searchCategory }">
							<option value="${category.num}" selected>${category.content}</option>
							</c:if>
							<c:if test="${category.num != searchCategory }">
							<option value="${category.num}">${category.content}</option>
							</c:if>
						</c:forEach>
						</select>
						
						검색 : <input type="text" name="searchWord" value="${searchWord}" style="float:right;"/>
						<select name="searchType">
							<option value="name">작성자</option>
							<option value="subject">제목</option>
							<option value="content">내용</option>
							<option value="product_name">상품명</option>
						</select>
					</div>
					<div style="clear:both"></div>
					<table class="table goodsList" style="border-top:solid 2px purple;">
						<c:if test="${empty inquiryList}">
							<tr>
								<td colspan="6">들어온 문의가 없습니다.</td>
							</tr>
						</c:if>
						<c:if test="${not empty inquiryList}">
						<tr align="center" class="quiryTitle">
							<td>No.</td>
							<td>상품명</td>
							<td>제목</td>
							<td>작성자</td>
							<td>작성날짜</td>
							<td>답변유무</td>
						</tr>
						<c:forEach var="item" items="${inquiryList}">
							<tr align="center">
								<td>${item.one_inquiry_num }</td>
								<td>${item.category_content }</td>
								<td>${item.subject }</td>
								<td>${item.member.name }</td>
								<td>${item.write_date }</td>
								
								<c:if test="${item.answer == null}">
									<td>X</td>
								</c:if>
								<c:if test="${item.answer != null}">
									<td>O</td>
								</c:if>
							</tr>
						</c:forEach>
						</c:if>
					</table>
				</div>
				</form>
				<div class="paging">
					${pageBar}
				</div>
				<div style="clear:both;"></div>
				
			</div>
		</div>
		<jsp:include page="../include/footer.jsp"></jsp:include>
	</div>
</body>
</html>