<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<% String ctxPath = request.getContextPath(); %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<link rel="stylesheet" href="<%= ctxPath %>/css/style.css" />
<title>serviceCenterBoardUpdate.jsp</title>
<style type="text/css">
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
	
	#Qboard-categori{
		width:100px;
		height:30px;
	}
</style>
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.1/css/bootstrap.min.css">
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
<script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.1/js/bootstrap.min.js"></script>
<script type="text/javascript" src="/ShoppingMall/js/jquery-3.3.1.min.js"></script>
<script type="text/javascript" src="/ShoppingMall/util/myutil.js"></script>
<script type="text/javascript">
$(document).ready(function(){
	$("option:eq('${fvo.fk_category_num}')").prop("selected",true);
		
});
function divCheck(){
	if($("input[name='title']").val().trim()==""){
		alert("제목을 작성하세요");
		return;
	}
	
	if($("#txt_area").val().trim()==""){
		alert("내용을 채워주세요");
		return;
	}
	
	if($("#Qboard-categori").val()=="0"){
		alert("카테고리를 선택해주세요");
		return;
	}
	$("input[name='contents']").val($("#txt_area").val().trim());
	var frm = document.noticeWriteFrm;
	frm.action="<%=ctxPath%>/service/boardUpdate.do";
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
					<h3 style="display:inline-block">공지사항</h3>
					<span style="margin-left:10px; font-size:8pt; font-weight: bold;">새로운 소식들과 유용한 정보들을 고객에게 전달할게요.</span>
					
				</div>
				<form name="noticeWriteFrm">
					<input type="hidden" name="notice_num" value="${nvo.notice_num}" />
					<table class="writeTable">
						<tr>
							<td class="frmTitle">작성자</td>
							<td><input type="text" value="관리자" disabled name="userName"/></td>
						</tr>
						<tr>
							<td class="frmTitle">제목</td>
							<td><input type="text" value="${nvo.subject}"  name="title"/></td>
						</tr>
						<tr>
							<td class="txt_field" colspan="2">
								<textarea rows="30" cols="30" id="txt_area">${nvo.content}</textarea>
								<input type="hidden"  name="contents" id="txt_content"/>
							</td>
						</tr>
		
					</table>
					<div class="userBtn" align="center">
						<span onclick="javascript:histroy.back();">취소</span> <span style="background-color:purple; color:white;" onclick="divCheck()">등록</span>
					</div>
				</form>
			</div>
		</div>
		<jsp:include page="../include/footer.jsp"></jsp:include>
	</div>
</body>
</html>