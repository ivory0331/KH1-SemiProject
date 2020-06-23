<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<% String ctxPath = request.getContextPath(); %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<link rel="stylesheet" href="<%= ctxPath %>/css/style.css" />
<title>productQwrite.jsp</title>
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
		width: 200px;
		
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
		padding : 10px 0;
		margin-top:20px;
		width:80px;
		border: solid 1px purple;
		font-size: 14pt;
		cursor: pointer;
		margin-right:10px;
	}

	.imgInput{
		width: 80%;
		
	}
	

	#txt_area{
		overflow-y: scroll;
	}
	
	
	#imgAdd{
		display: inline-block;
		width: 80px;
		background-color: purple;
		font-weight: bold;
		margin-right: 10px;
		cursor: pointer;
		color:white;
	}
	
	.imgInput, .closeInput{
		display: inline-block;
	}
	
	.closeInput{
		cursor: pointer;
		background-color: red;
		font-size: 12pt;
		font-weight: bold;
		padding : 0  5px;
	}
	
</style>
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.1/css/bootstrap.min.css">
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
<script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.1/js/bootstrap.min.js"></script>
<script type="text/javascript" src="/ShoppingMall/js/jquery-3.3.1.min.js"></script>
<script type="text/javascript" src="/ShoppingMall/util/myutil.js"></script>
<script type="text/javascript">

	var cnt=1;
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

	});
	
	function divCheck(){
		console.log($("#txt_area").html());
		console.log($("#txt_area").text());
	}

	function func_addArea(){
		var html="<div class='imgInput' id='imgFile"+cnt+"'>"
		        +"<input type='file' name='imgFile'  accept='.gif, .jpg, .png' style='margin-bottom:10px;'/>"
			    +"</div>"
			    +"<div class='closeInput' id='close"+cnt+"' onclick = 'func_closeImg("+cnt+")' align='right'>X"
			    +"</div>";
		if($(".imgInput").length>7){
			alert("이미지는 최대 8장 만 입력할 수 있습니다.");
			return;
		}
		$(".productQ-img").append(html);
		cnt++;
	}
	
	function func_closeImg(num){
		$(".imgInput:eq("+num+")").remove();
		$(".closeInput:eq("+num+")").remove();
	}
	
	
	function goBack(){
		alert("작성된 내용은 저장되지 않습니다.");
		history.back();
		
	}
	
	function divCheck(){
		console.log(${param.product_num});
	}

</script>
</head>
<body>
	<div class="Mycontainer">
		<jsp:include page="../include/header.jsp"></jsp:include>
		<div class="section" align="center">
			<div class="contents">
				<div class="boardInfo">
					<h3 style="display:inline-block">상품문의 작성</h3>
					<span style="margin-left:10px; font-size:8pt; font-weight: bold;">tes</span>
				</div>
				<form name="questionWriteFrm">
					<table class="writeTable">
						<tr>
							<td class="frmTitle">작성자</td>
							<td><input type="text" value="test" disabled name="userName"/></td>
						</tr>
						<tr>
							<td class="frmTitle">이메일</td>
							<td>
								<input type="email" value="test@test.com" disabled name="userEmail"/>
								<input type="checkbox" value="1" id="emailComment" name="emailComment"/><label for="emailComment">이메일로 답변을 받겠습니다.</label>
							</td>
						</tr>
						<tr>
							<td class="frmTitle">핸드폰</td>
							<td>
								<input type="text" value="010-0000-0000" disabled name="userMobile"/>
								<input type="checkbox" value="1" id="mobileComment" name="mobileComment"/><label for="mobileComment">문자로 답변을 받겠습니다.</label>
							</td>
						</tr>
						<tr>
							<td class="frmTitle">비밀글</td>
							<td>
								<input type="checkbox" value="1" id="secretCheck" /><label for="secretCheck">비밀글</label>
							</td>
						</tr>
						<tr>
							<td class="frmTitle">제목</td>
							<td><input type="text" value=""  name="title"/></td>
						</tr>
						<tr>
							<td class="txt_field" colspan="2">
								<div contenteditable="true" style="border:solid 1px black; margin-top:10px; height: 600px;" id="txt_area"></div>
								<input type="hidden" name="contents"/>
							</td>

						</tr>
						<tr>
							<td style="vertical-align: top;" >
								<span id="imgAdd" onclick="func_addArea()">추가 업로드</span>
								<label for="imgFile0">이미지 파일</label>
							</td>
							<td class='productQ-img'>
								<div class="imgInput" id='imgFile0'>
									<input type='file' name="imgFile"  accept='.gif, .jpg, .png' style="margin-bottom:10px;"/>
								</div>
								<div class="closeInput" id="close0" onclick = "func_closeImg(0)" align="right">X</div>
								
							</td>
					</table>
					<div class="userBtn" align="center">
						<span onclick="goBack()">취소</span> <span style="background-color:purple; color:white;" onclick="divCheck()">등록</span>
					</div>
				</form>
			</div>
		</div>
		<jsp:include page="../include/footer.jsp"></jsp:include>
	</div>
</body>
</html>