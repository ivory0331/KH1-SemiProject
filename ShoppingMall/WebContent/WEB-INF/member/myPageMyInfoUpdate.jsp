<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<% String ctxPath = request.getContextPath(); %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<link rel="stylesheet" href="<%= ctxPath %>/css/style.css" />
<title>마이페이지 개인 정보 수정</title>

<style type="text/css">
	.contents {
		border: solid 0px black;
		min-height: 600px;
	}	    
	
	.menu3 > a {
		color: #5f0080 !important;
		background-color: #eee;
	}
	
	#myInfoUpdate_Title {
		border: solid 0px blue;
		font-size: 16pt;
		display: inline-block;
		float: left;
	}
	
	#line {
		border-top: solid 2px #5f0080;
		height: 20px;
	}
	
	
</style>	

<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.1/css/bootstrap.min.css">
<link rel="stylesheet" href="css/style.css" />
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
<script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.1/js/bootstrap.min.js"></script>
<script type="text/javascript" src="/ShoppingMall/js/jquery-3.3.1.min.js"></script>
<script type="text/javascript" src="/ShoppingMall/util/myutil.js"></script>

<script type="text/javascript">

</script>

</head>
<body>	
	<div class="container">
		<jsp:include page="../include/header.jsp"></jsp:include>
		<div class="section" align="center">
			<div class="contents">
							
			<jsp:include page="../include/myPageSideMenu.jsp"></jsp:include>	
					
			<div id="myPage_Contents">		
				<div id="myInfoUpdate_Header">
					<h2 id="myInfoUpdate_Title">개인 정보 수정</h2>
					<div id="line" style="clear:both;"></div>
				</div>				
			</div>
				
			</div>
			<div style="clear:both;"></div>
		</div>	
		<jsp:include page="../include/footer.jsp"></jsp:include>
	</div>
</body>
</html>