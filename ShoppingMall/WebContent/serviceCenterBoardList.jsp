<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>serviceCenterBoardList.jsp</title>
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
		width: 400px;
	}
	
	.txt_center{
		text-align: center;
	}
	
	.boardSearch{
		margin-top:10px;
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
	
	<div class="Mycontainer">
		<jsp:include page="include/header.jsp"></jsp:include>
		<div class="section" align="center">
			<div class="contents">
				<div class="sideMenu">
					<jsp:include page="include/serviceCenterSide.jsp"></jsp:include>
				</div>
				<div class="serviceCenter-board">
					<div class="boardInfo">
						<h3 style="display:inline-block">공지사항</h3>
						<span style="margin-left:10px; font-size:8pt; font-weight: bold;">새로운 소식들과 유용한 정보들을 한곳에 확인하세요.</span>
					</div>
					<table style="border-top:solid 2px purple; border-bottom:solid 2px purple;" class="boardTable table">
						<tr style="border-bottom:solid 1px black;">
							<th class="txt_center">번호</th>
							<th class="txt_center board-title">제목</th>
							<th class="txt_center">작성자</th>
							<th class="txt_center">작성날짜</th>
							<th class="txt_center">조회수</th>
						</tr>
						
						<%-- DB에서 갖고온 결과물 뿌리는 부분 --%>
						<tr>
							<td class="txt_center">공지</td>
							<td>제목</td>
							<td class="txt_center">Market kurly</td>
							<td class="txt_center">2020-06-06</td>
							<td class="txt_center">0</td>
						</tr>
						<tr>
							<td class="txt_center">공지</td>
							<td>제목</td>
							<td class="txt_center">Market kurly</td>
							<td class="txt_center">2020-06-06</td>
							<td class="txt_center">0</td>
						</tr>
						<tr>
							<td class="txt_center">공지</td>
							<td>제목</td>
							<td class="txt_center">Market kurly</td>
							<td class="txt_center">2020-06-06</td>
							<td class="txt_center">0</td>
						</tr>
					</table>
					
					<div style="border-bottom:solid 1px black; text-align:center;">페이징 처리</div>
					<div class="boardSearch">
						<span style="padding-right:20px;">검색어</span>
						<label for="searchType-user">이름</label><input type="checkbox" value="" id="searchType-user"/>
						<label for="searchType-title">제목</label><input type="checkbox" value="" id="searchType-title"/>
						<label for="searchType-content">내용</label><input type="checkbox" value="" id="searchType-content"/>
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