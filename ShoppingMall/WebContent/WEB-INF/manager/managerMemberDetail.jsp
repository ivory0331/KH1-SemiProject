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
	
	.memberInfo{
		display:inline-block;
		width: 900px;
		margin-left:10px;
		
	}
	
	.detailTablePart{
		margin-top:50px;
	}
	
	/* Style the tab */
	.tab {
	  overflow: hidden;
	  background-color: white;
	  border-bottom: solid 2px purple;
	  margin-bottom: 5px;
	}
	
	/* Style the buttons inside the tab */
	.tab a{
		text-decoration: none;
		color:black;
	}
	
	.choice{
		background-color: purple;
		color:white;
		font-weight: bold;
	}
	
	.tab button {
	  float: left;
	  cursor: pointer;
	  padding: 14px 0;
	  width: 100px;
	  transition: 0.3s;
	  font-size: 17px;
	  border:none;
	  border-top: solid 1px purple;
	  outline: none;
	  border-left:solid 1px purple;
	}
	
	.tableTitle{
		font-size: 18pt;
	}
	#userBtn{
		margin-top:10px;
		
	}
	
	.type{
		text-align:center;
		display: inline-block;
		position: relative;
		border:solid 1px purple;
		margin-left:10px;
		padding:10px 0;
		width: 80px;
		color:purple;
	}
	
	
</style>
<!-- 부트스트랩 -->
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.1/css/bootstrap.min.css">
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
<script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.1/js/bootstrap.min.js"></script>
<script type="text/javascript" src="/ShoppingMall/js/jquery-3.3.1.min.js"></script>
<script type="text/javascript" src="/ShoppingMall/util/myutil.js"></script>
<script type="text/javascript">
	var offSet = new Array();
	$(document).ready(function(){
		for(var i=0; i<$(".detailTablePart").length; i++){
			offSet[i] = $(".detailTablePart")[i].offsetTop;
			console.log(offSet[i]);
		}
	});
		
	function goTable(num){
			
		var top = offSet[num]-Number("81");
		console.log("top:"+top);
		$('html, body').animate({scrollTop : top}, 0);		
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
				<div class="memberInfo">
					<div id="userBtn" align="right">
						<span class="type">경고주기</span>
						<span class="type">탈퇴</span>
					</div>
					<div class="detailTablePart" id="info">
						<div class="tab">
							<button class="tablinks choice" onclick="goTable('0')">회원정보</button>
							<button class="tablinks" onclick="goTable('1')">구매내역</button>
							<button class="tablinks" onclick="goTable('2')" style="border-right:solid 1px black">후기</button>
							<button class="tablinks" onclick="goTable('3')" style="border-right:solid 1px black">1:1문의</button>
						</div>
						<table class="table info">
							<tr>
								<th style="border:none" class="tableTitle">회원정보</th>
							</tr>
						</table>
					</div>
				
				
					<div class="detailTablePart" id="sales">
						<div class="tab">
							<button class="tablinks" onclick="goTable('0')">회원정보</button>
							<button class="tablinks choice" onclick="goTable('1')">구매내역</button>
							<button class="tablinks" onclick="goTable('2')" style="border-right:solid 1px black">후기</button>
							<button class="tablinks" onclick="goTable('3')" style="border-right:solid 1px black">1:1문의</button>
						</div>
						<table class="table sales">
							<tr>
								<th colspan="5" style="border:none" class="tableTitle">구매내역</th>
							</tr>
							<tr>
								<th>주문번호</th>
								<th>대표상품 이미지</th>
								<th>대표상품명</th>
								<th>결재금액</th>
								<th>주문상태</th>
							</tr>
							<tr>
								<td>0000000</td>
								<td>img태그 사용</td>
								<td>한우</td>
								<td>100,000</td>
								<td>배송완료</td>
							</tr>
						</table>
					</div>
					
					<div class="detailTablePart" id="review">
						<div class="tab">
							<button class="tablinks" onclick="goTable('0')">회원정보</button>
							<button class="tablinks" onclick="goTable('1')">구매내역</button>
							<button class="tablinks choice" onclick="goTable('2')" style="border-right:solid 1px black">후기</button>
							<button class="tablinks" onclick="goTable('3')" style="border-right:solid 1px black">1:1문의</button>
						</div>
						<table class="table review">
							<tr>
								<th colspan="5" style="border:none" class="tableTitle">후기내역</th>
							</tr>
							
						</table>
					</div>
					
					
					<div class="detailTablePart" id="question">
						<div class="tab">
							<button class="tablinks" onclick="goTable('0')">회원정보</button>
							<button class="tablinks" onclick="goTable('1')">구매내역</button>
							<button class="tablinks" onclick="goTable('2')" style="border-right:solid 1px black">후기</button>
							<button class="tablinks choice" onclick="goTable('3')" style="border-right:solid 1px black">1:1문의</button>
						</div>
						<table class="table question">
							<tr>
								<th colspan="5" style="border:none" class="tableTitle">문의 내역</th>
							</tr>
							
						</table>
					</div>
					
					
				</div>
				<div style="clear:both;"></div>
			</div>
		</div>
		<jsp:include page="../include/footer.jsp"></jsp:include>
	</div>
</body>
</html>