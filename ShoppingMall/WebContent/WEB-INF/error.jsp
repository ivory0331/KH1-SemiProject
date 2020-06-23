<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
	String ctxPath = request.getContextPath();
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>error.jsp</title>
<link rel="stylesheet" href="<%= ctxPath %>/css/style.css" />
<style type="text/css">

	body#error{
		background-color: purple;
	}
	
	.contents img{
		border-radius: 50%;
	}
	
	.contents{
		background-color: purple;
		padding:250px 0;
	}
	
	#message{
		background-color: white;
		text-align: center;
		line-height: 30px;
		height: 100px;
		width: 200px;
	}
</style>
<!-- 부트스트랩 -->
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.1/css/bootstrap.min.css">
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
<script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.1/js/bootstrap.min.js"></script>
<script type="text/javascript" src="/ShoppingMall/js/jquery-3.3.1.min.js"></script>
<script type="text/javascript" src="/ShoppingMall/util/myutil.js"></script>
<script type="text/javascript">
	
</script>
</head>
<body id="error">
	
		<div class="section" align="center">
			<div class="contents">
				<h1 style="color:white; margin-bottom:20px;">페이지 접속 중 오류가 발생</h1>
				<a href="javascript:location.href='<%=ctxPath %>/index.do'"><img src="<%=ctxPath %>/images/logo.png" /> </a>
			</div>
		</div>
		

</body>
</html>