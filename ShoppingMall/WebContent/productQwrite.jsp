<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>productQwrite.jsp</title>
<link rel="stylesheet" href="css/style.css" />
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
		width:60px;
		border: solid 1px purple;
		font-size: 16pt;
		cursor: pointer;
	}
	
	#txt_area{
		overflow-y: scroll;
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
	});
	
	function divCheck(){
		console.log($("#txt_area").html());
		console.log($("#txt_area").text());
	}
	
</script>
</head>
<body>
	<div class="Mycontainer">
		<jsp:include page="include/header.jsp"></jsp:include>
		<div class="section" align="center">
			<div class="contents">
				<div class="boardInfo">
					<h3 style="display:inline-block">공지사항</h3>
					<span style="margin-left:10px; font-size:8pt; font-weight: bold;">새로운 소식들과 유용한 정보들을 한곳에 확인하세요.</span>
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
							<td><label for="imgFile">이미지 추가</label></td>
							<td><input type="file" id="imgFile" accept=".gif, .jpg, .png"/></td>
						</tr>
					</table>
					<div class="userBtn" align="center">
						<span>취소</span> <span style="background-color:purple; color:white;" onclick="divCheck()">등록</span>
					</div>
				</form>
			</div>
		</div>
		<jsp:include page="include/footer.jsp"></jsp:include>
	</div>
</body>
</html>