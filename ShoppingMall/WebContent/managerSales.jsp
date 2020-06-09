<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>managerSales.jsp</title>
<link rel="stylesheet" href="css/style.css" />
<link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.3.1/css/bootstrap.min.css" integrity="sha384-ggOyR0iXCbMQv3Xipma34MD+dH/1fQ784/j6cY/iJTQUOhcWr7x9JvoRxT2MZw1T" crossorigin="anonymous"> 
<!-- 차트 링크 --> 
<script src="https://cdn.jsdelivr.net/npm/chart.js@2.8.0"></script> 
<style type="text/css">
	.sideMenu{
		display: inline-block;
		width: 150px;
		float:left;
	}
	.sales{
		width: 780px;
		margin-left: 90px;
	}
</style>
<!-- 부트스트랩 -->
<script src="https://code.jquery.com/jquery-3.3.1.slim.min.js" integrity="sha384-q8i/X+965DzO0rT7abK41JStQIAqVgRVzpbzo5smXKp4YfRvH+8abtTE1Pi6jizo" crossorigin="anonymous"></script> 
<script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.14.7/umd/popper.min.js" integrity="sha384-UO2eT0CpHqdSJQ6hJty5KVphtPhzWj9WO1clHTMGa3JDZwrnQq4sF86dIHNDz0W1" crossorigin="anonymous"></script> 
<script src="https://stackpath.bootstrapcdn.com/bootstrap/4.3.1/js/bootstrap.min.js" integrity="sha384-JjSmVgyd0p3pXB1rRibZUAYoIIy6OrQ6VrjIEaFf/nJGzIxFDsf4x0xIM+B07jRM" crossorigin="anonymous"></script> 
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
					data: { labels: ['January', 'February', 'March', 'April', 'May', 'June', 'July'], 
					datasets: [{ label: 'My First dataset', backgroundColor: 'transparent', borderColor: 'red', data: [0, 10, 5, 2, 20, 30, 45] }] }, 
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
					<div class="range">
						<span>월간</span>
						<span>년간</span>
					</div>
					<canvas id="myChart"></canvas> 
					
					<canvas id="myChart2"></canvas>
				</div>
			</div>
		</div>
		
		<jsp:include page="include/footer.jsp"></jsp:include>
		
	</div>
</body>
</html>