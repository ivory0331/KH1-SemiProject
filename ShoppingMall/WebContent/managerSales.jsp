<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>managerSales.jsp</title>
<link rel="stylesheet" href="css/style.css" />
<!-- 차트 링크 --> 
<script src="https://cdn.jsdelivr.net/npm/chart.js@2.8.0"></script> 
<style type="text/css">
	.sideMenu{
		margin-top:10px;
		display: inline-block;
		width: 150px;
		float:left;
	}
	.sales{
		width: 780px;
		margin-left: 90px;
	}
	
	.range{
		margin-top:15px;
	}
	
	.type{
		border:solid 1px purple;
		margin-left:10px;
		padding:10px 20px;
		color:purple;
	}
	
	.type:hover{
		cursor: pointer;
		background-color: purple;
		color:white;
	}
</style>
<!-- 부트스트랩 -->
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.1/css/bootstrap.min.css">
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
<script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.1/js/bootstrap.min.js"></script>
<script type="text/javascript" src="/ShoppingMall/js/jquery-3.3.1.min.js"></script>
<script type="text/javascript" src="/ShoppingMall/util/myutil.js"></script>
<script type="text/javascript">
	$(document).ready(function(){
		func_lineGraph();
		
		
	});
	
	function func_lineGraph(){
		var ctx = document.getElementById('myChart').getContext('2d'); 
		var chart = new Chart(ctx, 
				{ 	// 챠트 종류를 선택 
					type: 'line', 
					// 챠트를 그릴 데이타
					data: { labels: ['1월', '2월', '3월', '4월', '5월', '6월', '7월', '8월','9월','10월','11월','12월'], 
					datasets: [{ label: 'My First dataset', backgroundColor: 'transparent', borderColor: 'red', data: [0, 10, 5, 2, 20, 30, 45, 60, 80, 24, 11, 60] }] }, 
					// 옵션
					 options: {} 
			})
	}
	
</script>
</head>
<body>
	<div class="Mycontainer">
		<jsp:include page="include/header.jsp"></jsp:include>
		<div class="section" align="center">
			<div class="contents">
				<div class="sideMenu">
					<jsp:include page="include/managerSide.jsp"></jsp:include>
				</div>
				<div class="sales">
					<canvas id="myChart"></canvas> 
					<div class="range" align="right">
						<span class="type month">월간</span>
						<span class="type year">년간</span>
					</div>
				</div>
				<div style="clear:both;"></div>
			</div>
		</div>
		<jsp:include page="include/footer.jsp"></jsp:include>
	</div>
</body>
</html>