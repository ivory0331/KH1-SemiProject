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
			<div class="contents full">
				contents
			</div>
			<div class="contents">
				contents
			</div>
			<div class="contents">
				contents
			</div>
		</div>
		<div class="footer">
			footer
		</div>
	</div>
</body>
</html>