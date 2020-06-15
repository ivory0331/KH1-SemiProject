<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>serviceCenterQboardList</title>
<link rel="stylesheet" href="css/style.css" />
<style type="text/css">
	.sideMenu{
		display: inline-block;
		width: 150px;
		float:left;
	}
	
	.serviceCenter-board{
		width: 780px;
		margin-left: 90px;
		text-align: left;
	}
	
	.board-title{
		width: 550px;
	}
	
	.txt_center{
		text-align: center;
	}
	
	.boardSearch{
		margin-top:10px;
	}
	
	
	.panel {
	  
	  background-color: white;
	  overflow: hidden;
	  text-align: left;
	  margin : 0px ; 
	
	}
	
	.panel-none{
		display: none;
	}
	

</style>
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.1/css/bootstrap.min.css">
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
<script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.1/js/bootstrap.min.js"></script>
<script type="text/javascript" src="/ShoppingMall/js/jquery-3.3.1.min.js"></script>
<script type="text/javascript" src="/ShoppingMall/util/myutil.js"></script>
<script type="text/javascript">
	$(document).ready(function(){
		var acc = document.getElementsByClassName("accordion");

		for (i = 0; i < acc.length; i++) {
			  acc[i].addEventListener("click", function(event) {
				var $target = $(this).next();
				var $other = $target.siblings();
				$other.each(function(index, item){
					if($(item).hasClass("panel")){
						$(item).addClass("panel-none");	
					}
				});
				$target.toggleClass("panel-none");
			  });
			}
	})
</script>
</head>
<body>
	
	<div class="Mycontainer">
		<jsp:include page="include/header.jsp"></jsp:include>
		<div class="section" align="center">
			<div class="contents">
				<div class="sideMenu">
					<jsp:include page="include/serviceCenterSide.jsp"></jsp:include>
				</div>
				<div class="serviceCenter-board">
					<div class="boardInfo">
						<h3 style="display:inline-block">자주하는 질문</h3>
						<span style="margin-left:10px; font-size:8pt; font-weight: bold;">고객님들께서 가장 많이하는 질문들은 모두 모았습니다.</span>
						<br/>
						<select>
							<option>선택</option>
							<option>회원문의</option>
							<option>주문/결제</option>
							<option>배송문의</option>
						</select>
					</div>
					<table style="border-top:solid 2px purple;" class="boardTable table">
						<tr style="border-bottom:solid 1px black;">
							<th class="txt_center">번호</th>
							<th class="txt_center">카테고리</th>
							<th class="txt_center board-title">제목</th>
						</tr>
						
						<%-- DB에서 갖고온 결과물 뿌리는 부분 --%>
						<tr class=accordion>
							<td class="txt_center">공지</td>
							<td class="txt_center">Market kurly</td>
							<td>제목</td>
						</tr>
						<tr class="panel panel-none">
							<td colspan="3" >test입니다. 안녕하세요1</td>
						</tr>
						<tr class=accordion>
							<td class="txt_center">공지</td>
							<td class="txt_center">Market kurly</td>
							<td>제목</td>
						</tr>
						<tr class="panel panel-none">
							<td colspan="3" >test입니다. 안녕하세요2</td>
						</tr>
						<tr class=accordion>
							<td class="txt_center">공지</td>
							<td class="txt_center">Market kurly</td>
							<td>제목</td>
						</tr>
						<tr class="panel panel-none">
							<td colspan="3" >test입니다. 안녕하세요3</td>
						</tr>
					</table>
					
					<div style="border-bottom:solid 1px black; text-align:center;">페이징 처리</div>
					<div class="boardSearch">
						<input type="text" style="float:right"/>
					</div>
				</div>
				
			</div>
		</div>
		<div style="clear:both;">
			<jsp:include page="include/footer.jsp"></jsp:include>
		</div>
	</div>
</body>
</html>