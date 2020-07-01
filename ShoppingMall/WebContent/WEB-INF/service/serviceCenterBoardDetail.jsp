<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<% String ctxPath = request.getContextPath(); %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<link rel="stylesheet" href="<%= ctxPath %>/css/style.css" />
<title>serviceCenterBoardDetail.jsp</title>
<style type="text/css">
	
	.frmTitle{
		background-color: #ffe6ff;
		padding: 10px 0 10px 10px;
		font-size: 10pt;
		font-weight: bold;
		width: 100px;
	}
	
	.detailContent{
		height:400px;
		background-color: white;
	}
	
	.listBtn{
		display: inline-block;
		border:solid 1px black;
		padding: 5px 30px;
		background-color: purple;
		color:white;
		cursor: pointer;
	}
	
	.otherList{
		list-style: none;
		border-top:solid 2px purple;
		border-bottom:solid 2px purple;
	}
	
	.userBtn > span{
		display: inline-block;
		text-align: center;
		padding : 10 0px;
		margin-right:5px;
		width:60px;
		border: solid 1px purple;
		background-color: #f1f1f1;
		color: purple;
		font-size: 12pt;
		cursor: pointer;
		
	}
	
	
</style>
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.1/css/bootstrap.min.css">
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
<script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.1/js/bootstrap.min.js"></script>
<script type="text/javascript" src="/ShoppingMall/js/jquery-3.3.1.min.js"></script>
<script type="text/javascript" src="/ShoppingMall/util/myutil.js"></script>
<script type="text/javascript">
function goUpdate(num){
	location.href="<%=ctxPath%>/service/boardUpdate.do?notice_num="+num;
}

function goDelete(num){
	location.href="<%=ctxPath%>/service/boardDelete.do?notice_num="+num;
}

function goBoardList(){
	location.href="<%=ctxPath%>/${sessionScope.serviceGoBackURL}";
}
</script>
</head>
<body>
	
	<div class="Mycontainer">
		<jsp:include page="../include/header.jsp"></jsp:include>
		<div class="section" align="center">
			<div class="contents">
				<div class="boardInfo">
					<h3 style="display:inline-block">공지사항</h3>
					<span style="margin-left:10px; font-size:8pt; font-weight: bold;">새로운 소식들과 유용한 정보들을 한곳에 확인하세요.</span>
				</div>
				<div class="boardDetail">
					<c:forEach var="nvo" items="${nvoList}">
						<c:if test="${nvo.notice_num == notice_num }">
							<table class="table" style="border-top:solid 2px purple">
								<tr>
									<td class="frmTitle">제목</td>
									<td colspan="3">${nvo.subject}</td>
								</tr>
								<tr>
									<td class="frmTitle">작성자</td>
									<td colspan="3">MarketKurly</td>
								</tr>
								<tr>
									<td class="frmTitle">작성일</td>
									<td>${nvo.write_date}</td>
									<td class="frmTitle">조회수</td>
									<td>${nvo.hit}</td>
								</tr>
								<tr>
									<td colspan="4" valign="top" style="border-bottom:solid 1px purple;">
										<div class="detailContent">
											${nvo.content}
										</div>
										<c:if test="${sessionScope.loginuser.status == 2 }">
											<div class="userBtn" align="right">
												<span onclick = "goUpdate('${nvo.notice_num}')">수정</span><span onclick = "goDelete('${nvo.notice_num}')">삭제</span>
											</div>
										</c:if>
									</td>
								</tr>
								<tr >
									<td colspan="4" align="right"><span class="listBtn" onclick="goBoardList()">목록보기</span></td>
								</tr>
							</table>
						</c:if>
						</c:forEach>
						<div class="other" align="left">
							<ul class="otherList">
								<c:forEach var="nvo" items="${nvoList}">
									<c:if test="${nvo.notice_num > notice_num}">
										<li class="prev">이전글<span style="margin:0 20px">I</span><span style="cursor: pointer;" onclick="javascript:location.href='<%=ctxPath%>/service/boardDetail.do?notice_num=${nvo.notice_num}'">${nvo.subject}</span></li>
									</c:if>
									<c:if test="${nvo.notice_num < notice_num}">
										<li class="next">다음글<span style="margin:0 20px">I</span><span style="cursor: pointer;" onclick="javascript:location.href='<%=ctxPath%>/service/boardDetail.do?notice_num=${nvo.notice_num}'">${nvo.subject}</span></li>
									</c:if>
								</c:forEach>
							</ul>
						</div>
					
				</div>
				
			</div>
		</div>
		
		<jsp:include page="../include/footer.jsp"></jsp:include>
		
	</div>
</body>
</html>