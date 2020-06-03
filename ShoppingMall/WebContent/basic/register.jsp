<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>기본 뼈대</title>
<style>
	div{border: solid 1px black;}
	#container{
		max-width:1700px;
		min-width:1080px;
		min-height:500px;
		margin: 0 auto;
	}
	.header{
		max-width:1700px;
		min-width:1080px;
		max-height:200px;
		margin:5px;
	}
	.logo_login{
		width: 1080px;
	}
	.navi{
		max-width:1700px;
		min-width:1080px;
	}
	
	.section{
		max-width:1700px;
		min-width:1080px;
		min-height:500px;
		margin:5px;
	}
	
	.contents{
		width:1080px;
		min-height:200px;
		margin: 5px;
	}
	
	.footer{
		max-width:1700px;
		min-width:1080px;
		height:300px;
		margin:5px;
	}
	
	.register{
		min-height:200px;
	}
	.registerTable, td{
		border:solid 1px black;
		border-collapse: collapse;
	}
	.registerTable{
		width:300px;
		margin:10px;
	}
	td{
		padding:10px;
	}
</style>
</head>
<body>
	<div id="container" align="center">
		container
		<div class="header">
			header
			<div class="logo_login">
				logo_login
			</div>
			<div class="navi">
				navi
			</div>
		</div>
		<div class="section">
			section
			<div class="contents">
				<form class="register">
					<fieldset>
						<legend>회원가입</legend>
						<table class="registerTable">
							<tr>
								<td><label for="userid">아이디</label></td>
								<td><input type="text" id="userid"/></td>
							</tr>
							<tr>
								<td><label for="userid1">아이디</label></td>
								<td><input type="text" id="userid1"/></td>
							</tr>
							<tr>
								<td><label for="userid2">아이디</label></td>
								<td><input type="text" id="userid2"/></td>
							</tr>
							<tr>
								<td><label for="userid3">아이디</label></td>
								<td><input type="text" id="userid3"/></td>
							</tr>
							<tr>
								<td><label for="userid4">아이디</label></td>
								<td><input type="text" id="userid4"/></td>
							</tr>
						</table>
						<div class="submit">
							<span>가입하기</span>
						</div>
					</fieldset>
				</form>
			</div>
		</div>
		<div class="footer">
			footer
		</div>
	</div>
</body>
</html>