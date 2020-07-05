<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.util.*" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<% String ctxPath = request.getContextPath(); 
   Object obj = request.getAttribute("salesList");
   List<Map<String, String>> salesList = (List<Map<String, String>>)obj;
   String[] dateArr = new String[salesList.size()];
   String[] priceArr = new String[salesList.size()];
   for(int i=0; i<salesList.size(); i++){
	   dateArr[i]=salesList.get(i).get("date");
	   priceArr[i]=salesList.get(i).get("price");
   }
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<link rel="stylesheet" href="<%= ctxPath %>/css/style.css" />
<title>managerSales.jsp</title>
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
		cursor: pointer;
	}
	
	.select{
		cursor: pointer;
		color:white;
		background-color: purple;
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
		$(".${type}").addClass("select");
		func_lineGraph();
	});
	
	function func_lineGraph(){
		var ctx = document.getElementById('myChart').getContext('2d'); 
		var chart = new Chart(ctx, 
				{ 	// 챠트 종류를 선택 
					type: 'line', 
					// 챠트를 그릴 데이타
					data: { labels: [
						<% for(int i=0; i<dateArr.length; i++){%>
							<%if(i<dateArr.length-1){%>
								"<%=dateArr[i]%>",
							<%}
							else{%>
								"<%=dateArr[i]%>"
							<%}%>
						<%}%>
					], 
					datasets: [{ label: 'My First dataset', backgroundColor: 'transparent', borderColor: 'red', data: [
						<% for(int i=0; i<dateArr.length; i++){%>
						<%if(i<priceArr.length-1){%>
							"<%=priceArr[i]%>",
						<%}
						else{%>
							"<%=priceArr[i]%>"
						<%}%>
					<%}%>
						
						] }] }, 
					// 옵션
					 options: {} 
			});
	}
	
	function goSubmit(type){
		location.href="<%=ctxPath%>/manager/managerSale.do?type="+type;
	}
	
</script>
</head>
<body>
	<div class="Mycontainer">
		<jsp:include page="../include/header.jsp"></jsp:include>
		<div class="section" align="center">
			<div class="contents">
				<div class="sideMenu">
					<jsp:include page="../include/managerSide.jsp"></jsp:include>
				</div>
				<div class="sales">
					<canvas id="myChart"></canvas> 
					<div class="range" align="right">
						<span class="type month" onclick="goSubmit('month')">월간</span>
						<span class="type year" onclick="goSubmit('year')">년간</span>
					</div>
				</div>
				<div style="clear:both;"></div>
			</div>
		</div>
		<jsp:include page="../include/footer.jsp"></jsp:include>
	</div>
</body>
</html>