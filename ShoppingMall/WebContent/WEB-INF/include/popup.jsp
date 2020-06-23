<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<style type="text/css">
	.letter{
		margin: 0 auto;
	}
	.letter-content{
		resize: none;
	}
	
	.letter-table{
		border:solid 1px purple;
	}
	.letter-title{
		width: 80px;
		text-align: right;
		vertical-align: top;
	}
	
	.letter-btn{
		padding:4px 10px;
		border: solid 1px black;
		margin-right: 10px;
	}
</style>
<script type="text/javascript" src="/ShoppingMall/js/jquery-3.3.1.min.js"></script>
<script type="text/javascript" src="/ShoppingMall/util/myutil.js"></script>
<script type="text/javascript">
	$(document).ready(function(){
		var recieve = sessionStorage.getItem("recieve");
		console.log(recieve);
		document.getElementById("letter-recieve").value=recieve;
	})
</script>
</head>
<body>
	<div class="letter" align="center">
		<table class="letter-table">
			<tr>
				<td class="letter-title">받는사람</td>
				<td><input type="text" value="test" id="letter-recieve"/></td>
			</tr>
			<tr>
				<td class="letter-title">제목</td>
				<td><input type="text" value="경고입니다." /></td>
			</tr>
			<tr>
				<td class="letter-title">내용</td>
				<td><textarea rows="5" cols="25" class="letter-content"></textarea></td>
			</tr>
			<tr>
				<td colspan="2" align="center">
					<span class="letter-btn">확인</span> <span class="letter-btn">취소</span>
				</td>
			</tr>
		</table>
	</div>
</body>
</html>