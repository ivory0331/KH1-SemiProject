<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<% String ctxPath = request.getContextPath(); %>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<link rel="stylesheet" href="<%= ctxPath %>/css/style.css" />
<title>마이페이지 상품후기</title>

<style type="text/css">
	.contents {
		border: solid 0px black;
		min-height: 600px;
	}	    
	
	.menu2 > a {
		color: #5f0080 !important;
		background-color: #eee;
	}			
	
	#myProductReview_Header {
		border: solid 0px pink;
		margin: 5px;		
	}
	
	#myProductReview_List {
		border: solid 0px navy;
	}
	
	#myProductReview_Title {
		border: solid 0px blue;
		font-size: 16pt;
		display: inline-block;
		float: left;
	}	
	
	a.tab {
		display: inline-block;	
		width: 416px;
		border: solid 1px #ddd;
		padding: 10px;			
	}
	
	a.tab:hover {
		text-decoration: none;
		cursor: pointer;
		color: #bbb;
	}	
	
	.possibleReview {
		float: left;
		color: #bbb;	
	}
	
	.completedReview {
		float: right;
		color: #5f0080;	
		border-bottom: solid 2px #5f0080 !important;
	}	
	
	.completedReview:hover {
		color: #5f0080 !important;	
	}
	
	#line {
		border-top: solid 2px #5f0080;
		height: 20px;
	}
	
	.myOrder_number > h3 {
		border: solid 0px blue;
		text-align: left;
		font-size: 11pt;
		
	}
	
	table.myOrder_Desc {
		border: solid 0px red;
		width: 100%;
	}
	
	.desc-list {
		border: solid 1px #eee;
	}
	
	td {
		border: solid 0px red;
	}
	
	td.image {
		width: 130px;
	}
	
	td.image > img {
		margin: 10px 30px;
		width: 80px;
		height: 102px;
	}
	
	.info {
		width: 400px;
	}
	
	.productName {
		font-size: 11pt;
		color: black;
	}
	
	a.productName:hover {
		text-decoration: none;
		color: black;
		cursor: pointer;
	}
	
	.count {
		font-size: 9pt;
	}
	
	td.delivery {
		width: 160px;
		text-align: center;
		font-size: 10pt;
	}	
	
	a.link_review {
		border: solid 1px #5f0080;
		display: inline-block; 
		width: 110px;
		padding: 5px;
		margin: 10px;
		color: white;
		font-weight: bold;
		background-color: #5f0080;
		text-align: center;
	}
	
	a.link_review:hover {
		text-decoration: none;		
		color: white;
		cursor: pointer;
	}
			
	.column {
		border-bottom: solid 2px #5f0080;
		padding-top: 10px;
		height: 50px;
	}
	
	div.col {
		display: inline-block;		
	}
	
	.accordion {
		border-bottom: solid 1px #eee;
		padding-top: 15px;		
		height: 50px;		
	}
	
	div.num {
		width: 70px;
	}
	
	div.name {
		width: 550px;
	}
	
	div.date {
		width: 100px;
	}
	
	div.view {
		width: 80px;
	}
	
	div.panel {
		border-bottom: solid 1px #eee;
		padding: 10px;
	}
	
	.title {
		border: solid 0px red;
		text-align: left;
	}	
	
	img.image {
		width: 600px;
		height: 600px;
	}
	
	.review {
		text-align: left;
	}

	.button {
		float: right;
	}

	.delete , .delete:focus {
		border-style: none;
		background-color: white;
		font-size: 9pt;
		color: #5f0080;
		margin-right: 20px;
		padding: 8px;
		outline:none;
	}
	
	.update , .update:focus  {
		border: solid 1px #5f0080;
		background-color: white;
		font-size: 9pt;
		color: #5f0080;
		margin-right: 20px;
		padding: 8px;
		outline:none;
	}
	
}
	
	
</style>

<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.1/css/bootstrap.min.css">
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
<script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.1/js/bootstrap.min.js"></script>
<script type="text/javascript" src="/ShoppingMall/js/jquery-3.3.1.min.js"></script>
<script type="text/javascript" src="/ShoppingMall/util/myutil.js"></script>

<script type="text/javascript">
	$(document).ready(function() {

		$("div.panel").css('display','none');
	  
		$("div.accordion").click(function(event){						
			
			var $targetNext = $(this).next();
		
			var targetNextDisplayProperty = $targetNext.css('display');				
			
			if(targetNextDisplayProperty == 'none') {
				
				$("div.panel").css('display','none');
								
				$targetNext.css('display','');	
			}
			
			else {
				
				$targetNext.css('display','none');	
			}
			
		});
		
	});
	
	
	// === 작성완료 후기 삭제하기 === //  
	function goDelete(review_num) {
		
		var $target = $(event.target);
		var bool = confirm("작성한 후기를 정말로 삭제하시겠습니까?\r\n삭제 시 복구가 불가능합니다.");
	
		if(bool) {
			
			$.ajax({
				url:"/ShoppingMall/member/myPageReviewDelete.do",
				type:"POST",
				data:{"review_num":review_num},
				dataType:"JSON",
				success:function(json){
					if(json.n == 2) { // 작성한 후기를 삭제한 후 페이지이동을 해야 하는데 이동할 페이지는 페이징 처리하여 보고 있던 그 페이지로 가도록 한다. 
						alert(json.message);
						location.href= "<%= request.getContextPath()%>/member/myPageProductCompleteReview.do";
						<%-- location.href= "<%= request.getContextPath()%>/${goBackURL}"; --%>
					}
				},
				error: function(request, status, error){
					alert("code: "+request.status+"\n"+"message: "+request.responseText+"\n"+"error: "+error);
				}
			});
			
		}
		else {
			alert("삭제를 취소하셨습니다.");
		}

	}// end of function goDelete(review_num)---------------------------
	
	
	// === 작성완료 후기 수정하기 === // 
	function goUpdate(review_num) {
		
		location.href="<%= ctxPath%>/member/myPageReviewUpdate.do?review_num="+review_num;

	}// end of function goUpdate(review_num)---------------------------
	
</script>

</head>
<body>	
	<div class="Mycontainer">
		<jsp:include page="../include/header.jsp"></jsp:include>
		<div class="section" align="center">
			<div class="contents">	
			
			<jsp:include page="../include/myPageSideMenu.jsp"></jsp:include>
							
			<div id="myPage_Contents">		
				<div id="myProductReview_Header">
					<h2 id="myProductReview_Title">상품후기</h2>
					
					<div style="clear:both; height:20px;"></div>
					
					<div class="tab">
						<a class="tab possibleReview" href="<%= ctxPath %>/member/myPageProductPossibleReview.do">작성가능 후기(<span>${pReviewCount}</span>)</a>	
					</div>				
					<div class="tab">					
						<a class="tab completedReview" href="<%= ctxPath %>/member/myPageProductCompleteReview.do">작성완료 후기(<span>${cReviewCount}</span>)</a>	
					</div>	
					
					<div style="clear:both; height:10px;"></div>								
				</div>			

				<c:if test="${empty completeReviewList}">
					<div style="margin-bottom:100px;">
						<span>
				   	    	작성완료 후기내역이 없습니다.
				   	    </span>
					</div>
				</c:if>

				<c:if test="${not empty completeReviewList}">
				<div class="reviewList">    				
					<div class="column">
						<div class="col" style="width:70px;">번호</div>
						<div class="col" style="width:550px;">상품명</div>
						<div class="col" style="width:110px;">작성일</div>
						<div class="col" style="width:80px;">조회</div>
					</div>
					
					<c:forEach var="List" items="${completeReviewList}">
					<div class="accordion" style="cursor: pointer;">
				    	<div class="col num" style="width:70px;">${List.review_num}</div>
						<div class="col name" style="width:550px;">${List.product.getProduct_name()}</div>
						<div class="col date" style="width:110px;">${List.write_date}</div>
						<div class="col view" style="width:80px;">${List.hit}</div>
				    </div>
				    <div class="panel">
				    	<div class="title" style="margin: 10px 10px 20px 10px;">제목 : ${List.subject}</div>
				    	<c:if test="${not empty List.imageList[0]}">
					    	<div class="image">
					    		<img class="image" alt="${List.subject} 이미지" src="<%=ctxPath%>/Upload/${List.imageList[0]}">
					    	</div>
				    	</c:if>
				    	<div class="review" style="margin: 20px 10px;">${List.content}</div>
				    	<div class="button">
					    	<input type="button" id="delete" class="delete" name="delete" value="삭제하기" onclick="goDelete('${List.review_num}')" />
					    	<input type="button" id="update" class="update" name="update" value="수정" onclick="goUpdate('${List.review_num}')" />
				    	</div>
				    	<div style="clear:both;"></div>
				    </div>
				    
				    </c:forEach>				    
				</div>
				</c:if>
				
				<div style="border-bottom:solid 1px black; text-align:center;">페이징 처리</div>			
			</div>						
			</div>
			<div style="clear:both;"></div>
		</div>	
		<jsp:include page="../include/footer.jsp"></jsp:include>
	</div>
</body>
</html>