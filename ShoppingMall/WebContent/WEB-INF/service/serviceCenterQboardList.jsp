<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<% String ctxPath = request.getContextPath(); %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<link rel="stylesheet" href="<%= ctxPath %>/css/style.css" />
<title>serviceCenterQboardList</title>
<style type="text/css">
	.sideMenu{
		display: inline-block;
		width: 150px;
		float:left;
	}
	
	.serviceCenter-board{
		width: 780px;
		margin-left: 90px;
		text-align: left;
	}
	
	.board-title{
		width: 550px;
	}
	
	.txt_center{
		text-align: center;
	}
	
	.boardSearch{
		margin-top:10px;
	}
	
	
	.panel {
	  
	  background-color: white;
	  overflow: hidden;
	  text-align: left;
	  margin : 0px ; 
	
	}
	
	.panel-none{
		display: none;
	}
	

</style>
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.1/css/bootstrap.min.css">
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
<script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.1/js/bootstrap.min.js"></script>
<script type="text/javascript" src="/ShoppingMall/js/jquery-3.3.1.min.js"></script>
<script type="text/javascript" src="/ShoppingMall/util/myutil.js"></script>
<script type="text/javascript">
	$(document).ready(function(){
		console.log("${categoryList}");
		var acc = document.getElementsByClassName("accordion");

		for (i = 0; i < acc.length; i++) {
			  acc[i].addEventListener("click", function(event) {
				var $target = $(this).next();
				var $other = $target.siblings();
				$other.each(function(index, item){
					if($(item).hasClass("panel")){
						$(item).addClass("panel-none");	
					}
				});
				$target.toggleClass("panel-none");
			  });
			}
		
		
		$("select[name='favoriteQ_Category']").bind("change",function(){
			goInquiry();
		});
	});
	
	function goInquiry(){
		var frm = document.faqFrm;
		frm.action="<%=ctxPath%>/service/FAQ.do";
		frm.method="get";
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
					<jsp:include page="../include/serviceCenterSide.jsp"></jsp:include>
				</div>
				<form name="faqFrm">
				<div class="serviceCenter-board">
					<div class="boardInfo">
						<h3 style="display:inline-block">자주하는 질문</h3>
						<span style="margin-left:10px; font-size:8pt; font-weight: bold;">고객님들께서 가장 많이하는 질문들은 모두 모았습니다.</span>
						<br/>
						<select name="favoriteQ_Category">
							<c:forEach var="item" items="${categoryList}">
								<c:if test="${category == item.num }">
									<option value="${item.num }" selected>${item.category}</option>
								</c:if>
								<c:if test="${category != item.num }">
									<option value="${item.num }" >${item.category}</option>
								</c:if>
							</c:forEach>
						</select>
					</div>
					<table style="border-top:solid 2px purple;" class="boardTable table">
						<tr style="border-bottom:solid 1px black;">
							<th class="txt_center">번호</th>
							<th class="txt_center">카테고리</th>
							<th class="txt_center board-title">제목</th>
						</tr>
						<c:if test="${empty FAQList}">	
							<tr>
								<td colspan="5"> 자주하는 질문 게시판 준비중 입니다. </td>
							</tr>	
						</c:if>
						<c:if test="${not empty FAQList}">		
							<c:forEach var="faq" items="${FAQList}">
									<tr class='accordion'>
										<td class="txt_center">${faq.faq_num}<input type="hidden" value="${nvo.faq_num}" name="faq_num" /></td>
										<td class="board-title">${faq.category_content}</td>
										<td class="txt_center">${faq.subject}</td>
									</tr>
									<tr class='panel panel-none'>
										<td colspan="3">${faq.content}</td>
									</tr>
								</c:forEach>	
							</c:if>
					</table>
					
					<div style="border-bottom:solid 1px black; text-align:center;">${pageBar}</div>
					<div class="boardSearch">
						<input type="text" style="float:right" name="searchWord" />
					</div>
				</div>
				</form>
			</div>
		</div>
		<div style="clear:both;">
			<jsp:include page="../include/footer.jsp"></jsp:include>
		</div>
	</div>
</body>
</html>