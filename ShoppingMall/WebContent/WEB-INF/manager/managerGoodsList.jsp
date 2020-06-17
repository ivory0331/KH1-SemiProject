<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>managerGoods.jsp</title>
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
	.memberList{
		display:inline-block;
		width:800px;
		margin-top: 10px;
	}
	
	.member-search{
		width:100%;
		margin-bottom:5px;
	}
	
	.goodsList{
		width: 100%;
		text-align: center;
	}
	
	.goods-add{
		float: right;
		margin-bottom:5px;
	}
	
	.board-title{
		width: 150px;
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
		
		
	});
	
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
				<div class="memberList" align="left">
					<div class="member-search">
						<h4>상품관리</h4>
						검색 : <input type="text" />
						<select>
							<option>=== 대분류 ===</option>
							<option>...</option>
							<option>...</option>
						</select>
						<select>
							<option>=== 소분류 ===</option>
							<option>...</option>
							<option>...</option>
						</select>
						<span class="type goods-add">상품 추가</span>
					</div>
					<table class="table goodsList" style="border-top:solid 2px purple;">
						<tr>
							<th>선택</th>
							<th>No.</th>
							<th>대분류</th>
							<th>소분류</th>
							<th class="board-title">상품 이미지</th>
							<th>상품명</th>
							<th>가격</th>
							<th>재고수</th>
						</tr>
						<tr>
							<td><input type="checkbox" /></td>
							<td>No.</td>
							<td>채소</td>
							<td>콩나물.버섯류</td>
							<td class="board-title">img태그 사용</td>
							<td>콩나물</td>
							<td>1,000</td>
							<td>50</td>
						</tr>
					</table>
				</div>
				<div style="clear:both;"></div>
				<div class="managerBtn" align="right">
					<span class="type">선택 삭제</span>
				</div>
				<div class="paging">
					
				</div>
			</div>
		</div>
		<jsp:include page="../include/footer.jsp"></jsp:include>
	</div>
</body>
</html>