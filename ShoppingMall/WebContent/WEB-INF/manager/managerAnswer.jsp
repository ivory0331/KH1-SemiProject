<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<% String ctxPath = request.getContextPath(); %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<link rel="stylesheet" href="<%= ctxPath %>/css/style.css" />
<meta charset="UTF-8">
<title>managerAnswer.jsp</title>
<style type="text/css">
	.sideMenu{
		display: inline-block;
		width: 150px;
		float:left;
	}
	
	.mainContent{
		display: inline-block;
	}
	
	.writeTable{
		width:1080px;
		border-top: solid 2px purple;
	}
	
	.writeTable td{
		border-bottom: solid 1px #e0e0eb;
	}
	
	.writeTable, td{
		border-collapse: collapse;
	}
	
	.frmTitle{
		width: 180px;
		background-color: #ffe6ff;
		padding: 10px 0 10px 10px;
		font-size: 10pt;
		font-weight: bold;
		
	}
	
	.frmTitle ~ td{
		padding-left:10px;
	}
	
	input[name='title']{
		width: 90%;
		height: 30px;
	}
	
	.userBtn{
		width:1080px;
	}
	
	.userBtn > span{
		display: inline-block;
		text-align: center;
		padding : 10px 50px;
		margin-top:20px;
		border: solid 1px purple;
		font-size: 16pt;
		cursor: pointer;
	}
	
	#txt_area{
		overflow-y: scroll;
		border:solid 1px black; 
		margin-top:10px; 
		height: 600px;
		width: 100%;
		resize: none;
		
	}
	
</style>
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.1/css/bootstrap.min.css">
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
<script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.1/js/bootstrap.min.js"></script>
<script type="text/javascript" src="/ShoppingMall/js/jquery-3.3.1.min.js"></script>
<script type="text/javascript" src="/ShoppingMall/util/myutil.js"></script>
<script type="text/javascript">
$(document).ready(function(){
	console.log("${type}");
});

function divCheck(){
	
	if($("#txt_area").val().trim() == ""){
		alert("내용을 입력해주세요");
		return;
	}
	
	var content = $("#txt_area").val().trim();
	$("#txt_content").val(content);
	var frm = document.questionWriteFrm;
	frm.action="<%=ctxPath%>/manager/quiryAnswer.do";
	frm.method="POST";
	frm.submit();
}
</script>
</head>
<body>
	<div class="Mycontainer">
		<jsp:include page="../include/header.jsp"></jsp:include>
		<div class="section" align="center">
			<div class="contents">
				<div class="boardInfo" align="left">
					<c:if test="${type == 'product'}" >
						<h3 style="display:inline-block">상품문의 답변</h3>
					</c:if>
					<c:if test="${type == 'one'}" >
						<h3 style="display:inline-block">1:1문의 답변</h3>
					</c:if>
				</div>
				<form name="questionWriteFrm" >
						<c:if test="${type == 'product'}" >
							<input type="hidden" name="quiry_num" value="${inquiry.inquiry_num}" />
						</c:if>
						<c:if test="${type == 'one'}" >
							<input type="hidden" name="quiry_num" value="${inquiry.one_inquiry_num}"/>
						</c:if>
						<input type="hidden" name="type" value="${type}" />
						<table class="writeTable">
						<tr>
							<td class="frmTitle">작성자</td>
							<td><input type="text" value="${inquiry.member.name}" disabled name="userName"/></td>
						</tr>
						
						<c:if test="${type == 'product'}" >
						<tr id="QboardSelect">
							<td class="frmTitle">상품명</td>
							<td>${inquiry.product_name}</td>
						</tr>
						</c:if>
						
						<c:if test="${type == 'one'}" >
						<tr id="QboardSelect">
							<td class="frmTitle">카테고리</td>
							<td>${inquiry.category_content}</td>
						</tr>
						</c:if>
						
						<tr>
							<td class="frmTitle">제목</td>
							<td><input type="text" value="${inquiry.subject}" disabled name="title"/></td>
						</tr>
						<tr>
							<td class="txt_field" colspan="2">
								<textarea rows="30" cols="30" id="txt_area">${inquiry.answer}</textarea>
								<input type="hidden" name="answer" id="txt_content"/>
							</td>
						</tr>
					</table>
				</form>
				<div class="userBtn" align="center">
					<span onclick="javascript:history.back()">취소</span> <span style="background-color:purple; color:white;" onclick="divCheck()">등록</span>
				</div>
				</div>
			</div>
		</div>
		<jsp:include page="../include/footer.jsp"></jsp:include>
	</div>
</body>
</html>