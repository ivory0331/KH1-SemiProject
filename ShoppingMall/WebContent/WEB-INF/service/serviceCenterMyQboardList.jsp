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
		width: 350px;
	}
	
	.txt_center{
		text-align: center;
	}
	
	.writeBtn{
		display: inline-block;
		border:solid 1px black;
		padding: 5px 30px;
		background-color: purple;
		color:white;
		float: right;
		cursor:pointer;
	}
	
	.paging{
		width: 780px;
		clear:both;
		text-align: center;
	}
	
	.writeBtn:hover{
		cursor: pointer;
		background-color: white;
		color:purple;
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
	
	.one_content{
		min-height: 300px;
	}

</style>
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.1/css/bootstrap.min.css">
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
<script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.1/js/bootstrap.min.js"></script>
<script type="text/javascript" src="/ShoppingMall/js/jquery-3.3.1.min.js"></script>
<script type="text/javascript" src="/ShoppingMall/util/myutil.js"></script>
<script type="text/javascript">
	$(document).ready(function(){
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
		
		$(".writeBtn").click(function(){
			location.href="<%=ctxPath%>/service/serviceCenterMyQboardWrite.do";
		})
	})
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
				<form name="oneInquiryFrm">
				<div class="serviceCenter-board">
					<div class="boardInfo">
						<h3 style="display:inline-block">1:1문의</h3>
						
					</div>
					<table class="boardTable table" style="border-top:solid 2px purple;">
						<tr style="border-bottom:solid 1px black;">
							<th class="txt_center">번호</th>
							<th class="txt_center">카테고리</th>
							<th class="txt_center board-title">제목</th>
							<th class="txt_center">작성자</th>
							<th class="txt_center">작성날짜</th>
						</tr>
						<c:if test="${empty oneInquiryList}">
							<tr>
								<td colspan="5"> 1:1문의 게시판 준비중 입니다. </td>
							</tr>
						</c:if>
						<c:if test="${not empty oneInquiryList }">
							<c:forEach var="item" items="${oneInquiryList}">
							<tr class="accordion">
								<td class="txt_center">${item.one_inquiry_num}</td>
								<td class="txt_center">${item.category_content}</td>
								<td>${item.subject}</td>
								<td>${item.member.name}</td>
								<td>${item.write_date}</td>
							</tr>
							<tr class="panel panel-none">
								<td colspan="5" >
								<div class="one_content">${item.content}</div>
									<c:if test="${sessionScope.loginuser.member_num==item.member.member_num}">
									<div class="userBtn" align="right">
										<span onclick = "goUpdate('${item.one_inquiry_num}')">수정</span><span onclick = "goDelete('${item.one_inquiry_num}')">삭제</span>
									</div>
									</c:if>
								</td>
							</tr>
							<c:if test="${not empty item.answer}">
								<tr class="accordion">
								<td class="txt_center">Re</td>
								<td class="txt_center"></td>
								<td>안녕하세요, 고객님 답변드립니다.</td>
								<td>MarketKurly</td>
								<td>${item.write_date}</td>
							</tr>
							<tr class="panel panel-none">
								<td colspan="5" >
									<div class="one_content">
										${item.answer}
									</div>
								</td>
							</tr>
							</c:if>
							</c:forEach>
						</c:if>
					</table>
					<div class="paging">
						${pageBar }
						<span class="writeBtn">글쓰기</span>
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