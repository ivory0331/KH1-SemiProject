<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<% String ctxPath = request.getContextPath(); %>
<% Object obj = request.getAttribute("searchType"); 
   String[] searchType = (String[])obj;
   String searchType1 = "";
   String searchType2 = "";
   if(searchType!=null){
	   for(int i=0; i<searchType.length; i++){
		   if(i==0) searchType1 = searchType[i];
		   else searchType2 = searchType[i];
	   }
   }
   
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<link rel="stylesheet" href="<%= ctxPath %>/css/style.css" />
<title>serviceCenterBoardList.jsp</title>
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
		width: 400px;
	}
	
	.txt_center{
		text-align: center;
	}
	
	.boardSearch{
		margin-top:10px;
	}
	
	
</style>
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.1/css/bootstrap.min.css">
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
<script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.1/js/bootstrap.min.js"></script>
<script type="text/javascript" src="/ShoppingMall/js/jquery-3.3.1.min.js"></script>
<script type="text/javascript" src="/ShoppingMall/util/myutil.js"></script>
<script type="text/javascript">
$(document).ready(function(){    
	 
	$("#searchType-<%=searchType1%>").prop("checked",true);
	$("#searchType-<%=searchType2%>").prop("checked",true);
	
	$("#searchWord").bind("keydown", function(event){
		  if(event.keyCode == 13) { //엔터
			  goSearch();
		  }
	});
	
	 // 검색
	 function goSearch() {		  
		  var frm = document.noticeFrm;
		  frm.method = "GET";
		  frm.action = "<%=ctxPath%>/service/board.do";
		  frm.submit(); 
	  }
	
});
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
				<div class="serviceCenter-board">
					<div class="boardInfo">
						<h3 style="display:inline-block">공지사항</h3>
						<span style="margin-left:10px; font-size:8pt; font-weight: bold;">새로운 소식들과 유용한 정보들을 한곳에 확인하세요.</span>
					</div>
					<form name="noticeFrm">
						<table style="border-top:solid 2px purple; " class="boardTable table">
							<tr style="border-bottom:solid 1px black;">
								<th class="txt_center">번호</th>
								<th class="txt_center board-title">제목</th>
								<th class="txt_center">작성자</th>
								<th class="txt_center">작성날짜</th>
								<th class="txt_center">조회수</th>
							</tr>
							<tbody>
								<c:if test="${empty noticeList}">	
									<tr>
										<td colspan="5"> 공지사항 게시판 준비중 입니다. </td>
									</tr>	
								</c:if>
								<c:if test="${not empty noticeList}">		
									<c:forEach var="nvo" items="${noticeList}">
										<tr>
											<td class="txt_center">${nvo.notice_num}<input type="hidden" value="${nvo.notice_num}" name="notice_num" /></td>
											<td class="board-title">${nvo.subject}</td>
											<td class="txt_center">MarketKurly</td>
											<td class="txt_center">${nvo.write_date}</td>
											<td class="txt_center">${nvo.hit}</td>
										</tr>
									</c:forEach>	
								</c:if>
							</tbody>
						</table>
						
						<div style="border-bottom:solid 1px black; text-align:center;">${pageBar}</div>
						<div class="boardSearch">
							<span style="padding-right:20px;">검색어</span>
							<label for="searchType-title">제목</label><input type="checkbox" value="subject" name="searchType" id="searchType-subject" style="margin-right:20px;"/>
							<label for="searchType-content">내용</label><input type="checkbox" value="content" name="searchType" id="searchType-content"/>
							<input type="text" name="searchWord" style="float:right" id="searchWord"/>
						</div>
					</form>
				</div>
				<div style="clear:both;"></div>
			</div>
		</div>
		<div>
			<jsp:include page="../include/footer.jsp"></jsp:include>
		</div>
	</div>
</body>
</html>