<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<% String ctxPath = request.getContextPath(); %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<link rel="stylesheet" href="<%= ctxPath %>/css/style.css" />
<meta charset="UTF-8">
<title>serviceCenterBoardWrite.jsp</title>
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
	
	#QboardSelect{
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
	$("#imgFile").change(function(){
		if(this.files && this.files[0]) {
			var fileName = this.files[0].name;
			var index = fileName.indexOf(".");
			var fileType = fileName.substr(index);
			if(fileType==".png"||fileType==".jpg"||fileType==".png"){
				var reader = new FileReader;
				reader.onload = function(data) {
					var html = "<img src='"+data.target.result+"' />";
					$("#txt_area").append(html);
				}
				 reader.readAsDataURL(this.files[0]);
			}
			else{
				alert("이미지만 올릴 수 있습니다.");
			}
			// input[type='file'] 초기화 //
			$("#imgFile").replaceWith( $("#imgFile").clone(true) );
			$("#imgFile").val(""); 
		}
		
	});
	
	$("#boardType").bind("change",function(){
		if($(this).val()=="board"){
			$("#QboardSelect").hide();
		}
		else{
			$("#QboardSelect").show();
		}
		$("input[name='boardType']").val($(this).val());
	});
	
	
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
	
	if($("input[name='boardType']").val()=="Qboard" && $("#Qboard-categori").val()=="0"){
		alert("자주하는 질문 게시글을 작성시에는 카테고리를 선택해야 합니다.");
		return;
	}
	$("input[name='contents']").val($("#txt_area").val());
	var frm = document.questionWriteFrm;
	frm.action="<%=ctxPath%>/manager/mangerBoardWrite.do";
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
					<h3 style="display:inline-block">게시글 작성</h3>
					<span style="margin-left:10px; font-size:8pt; font-weight: bold;">새로운 소식들과 유용한 정보들을 고객에게 전달할게요.</span>
					<div>
						<select id="boardType">
							<option value="board">공지사항</option>
							<option value="Qboard">자주하는 질문</option>
						</select>
					</div>
				</div>
				<form name="questionWriteFrm" >
						<table class="writeTable">
						<tr>
							<td class="frmTitle">작성자<input type="hidden" name="boardType" value="board"/></td>
							<td><input type="text" value="관리자" disabled name="userName"/></td>
						</tr>
						<tr id="QboardSelect">
							<td class="frmTitle">카테고리</td>
							<td>
								<select id="Qboard-categori" name="Qboard-categori">
									<option value="0">선택</option>
									<option value="1">회원문의</option>
									<option value="2">주문/결제</option>
									<option value="3">배송문의</option>
									<option value="4">서비스 이용 및 기타</option>
								</select>
							</td>
						</tr>
						<tr>
							<td class="frmTitle">제목</td>
							<td><input type="text" value=""  name="title"/></td>
						</tr>
						<tr>
							<td class="txt_field" colspan="2">
								<textarea rows="30" cols="30" id="txt_area"></textarea>
								<input type="hidden" name="contents" id="txt_content"/>
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