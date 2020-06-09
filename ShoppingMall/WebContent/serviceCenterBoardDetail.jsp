<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>serviceCenterBoardDetail.jsp</title>
<link rel="stylesheet" href="css/style.css" />
<style type="text/css">
	
	.frmTitle{
		background-color: #ffe6ff;
		padding: 10px 0 10px 10px;
		font-size: 10pt;
		font-weight: bold;
		width: 100px;
	}
	
	.detailContent{
		height:400px;
		background-color: white;
		border-bottom:solid 1px purple;
	}
	
	.listBtn{
		display: inline-block;
		border:solid 1px black;
		padding: 5px 30px;
		background-color: purple;
		color:white;
		cursor: pointer;
	}
	
	.otherList{
		list-style: none;
		border-top:solid 2px purple;
		border-bottom:solid 2px purple;
	}
</style>
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.1/css/bootstrap.min.css">
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
				<div class="boardInfo">
					<h3 style="display:inline-block">공지사항</h3>
					<span style="margin-left:10px; font-size:8pt; font-weight: bold;">새로운 소식들과 유용한 정보들을 한곳에 확인하세요.</span>
				</div>
				<div class="boardDetail">
					<table class="table" style="border-top:solid 2px purple">
						<tr>
							<td class="frmTitle">제목</td>
							<td colspan="3">공지사항</td>
						</tr>
						<tr>
							<td class="frmTitle">작성자</td>
							<td colspan="3">마켓컬리</td>
						</tr>
						<tr>
							<td class="frmTitle">작성일</td>
							<td>2020-06-09</td>
							<td class="frmTitle">조회수</td>
							<td>0</td>
						</tr>
						<tr>
							<td colspan="4" class="detailContent" valign="top">공지사항 상세 내용</td>
						</tr>
						<tr >
							<td colspan="4" align="right"><span class="listBtn">목록보기</span></td>
						</tr>
					</table>
					<div class="other" align="left">
						<ul class="otherList">
							<li class="prev">이전글</li>
							<li class="next">다음글</li>
						</ul>
					</div>
				</div>
				
			</div>
		</div>
		
		<jsp:include page="include/footer.jsp"></jsp:include>
		
	</div>
</body>
</html>