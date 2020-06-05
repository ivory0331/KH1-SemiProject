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
	
</style>
<script type="text/javascript" src="/ShoppingMall/js/jquery-3.3.1.min.js"></script>
<script type="text/javascript" src="/ShoppingMall/util/myutil.js"></script>
<script type="text/javascript">
	
</script>
</head>
<body>
	<div class="Mycontainer">
		<jsp:include page="include/header.jsp"></jsp:include>
		<div class="section" align="center">
			<div class="contents">
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
								<div contenteditable="true" style="border:solid 1px black;"></div>
								<input type="hidden" />
							</td>
						</tr>
					</table>
				</form>
			</div>
		</div>
		<jsp:include page="include/footer.jsp"></jsp:include>
	</div>
</body>
</html>