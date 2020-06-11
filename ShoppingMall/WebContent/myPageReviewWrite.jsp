<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>마이페이지 상품후기</title>
<link rel="stylesheet" href="css/style.css" />

<style type="text/css">
	.contents {
		border: solid 0px black;
		min-height: 600px;
	}	    
	
	.menu2 > a {
		color: #5f0080 !important;
		background-color: #eee;
	}			
	
	#myProductReview_Header {
		border: solid 0px pink;
		margin: 5px;		
	}	
	
	#myProductReview_Title {
		border: solid 0px blue;
		font-size: 16pt;
		display: inline-block;
		float: left;
	}
	
	#myProductReview_Text {
		border: solid 0px red;	
		font-size: 8pt;
		display: inline-block;
		margin: 30px 0 0 10px;
		float: left;
	}		
	
	#line {
		border-top: solid 2px #5f0080;
		height: 20px;
	}
	


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
		<jsp:include page="include/header.jsp"></jsp:include>
		<div class="section" align="center">
			<div class="contents">	
			
			<jsp:include page="include/myPageSideMenu.jsp"></jsp:include>
				
			<div id="myPage_Contents">		
				<div id="myProductReview_Header">
					<h2 id="myProductReview_Title">후기 작성</h2>
					<div id="line" style="clear:both;"></div>										
				</div>				
			</div>						
			</div>
			<div style="clear:both;"></div>
		</div>	
		<jsp:include page="include/footer.jsp"></jsp:include>
	</div>
</body>
</html>






















