<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<% String ctxPath = request.getContextPath(); %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<link rel="stylesheet" href="<%= ctxPath %>/css/style.css" />
<title>마이페이지 상품후기</title>

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
	
	table.myOrder_Desc {
		border: solid 1px #ddd;
		width: 100%;
	}	
	
	td {
		border: solid 0px red;
	}
	
	td.image {
		width: 80px;
	}
	
	td.image > img {
		border: solid 0px red;
		margin: 10px 30px;
		width: 80px;
		height: 102px;
	}	
	
	.productName {
		font-size: 12pt;
		color: black;
	}
	
	table.write {
		border: solid 1px #ddd;
		width: 100%;
		margin-bottom: 20px;
	}
	
	.reviewTR {
		border: solid 1px #ddd;
	}
	
	.reviewTH {
		background-color: #eee;
		text-align: center;
		padding: 10px;
	}

	.reviewTD {
		padding: 10px;
	}
	
	#subject {
		width: 100%;
	}
	
	#content {
		resize: none;
		width: 100%;
	}
	
	#btnSubmit {
	    border: 1px solid #5f0080;
	    background-color: #5f0080;
	    color: white;
	    width: 200px;
	    padding: 10px;
	}

	
	
</style>

<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.1/css/bootstrap.min.css">
<link rel="stylesheet" href="<%= ctxPath %>/css/style.css" />
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
<script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.1/js/bootstrap.min.js"></script>
<script type="text/javascript" src="/ShoppingMall/js/jquery-3.3.1.min.js"></script>
<script type="text/javascript" src="/ShoppingMall/util/myutil.js"></script>

<script type="text/javascript">

	$(document).ready(function(){
		
		$("#btnSubmit").click(function(){
		
			// == 제목 입력했는지 확인 == //
			if($("input#subject").val().trim()=="") {
				
				alert("제목을 입력해주세요.");	
									
				$(this).focus();					
				return;
			}
			
			
			// == 내용 10글자 이상 입력했는지 확인 == //				
			if($("textarea#content").val().length < 10) {
				
				alert("내용은 최소 10글자 이상 입력해야 합니다.");	
									
				$(this).focus();
				return;
			}				
			
			// == 이미지 파일 유효성 검사 == //
			var imgFile = $('#image').val().toLowerCase();
			var fileForm = /(.*?)\.(jpg|jpeg|png|gif|bmp|pdf)$/;
			var fileSize;		
			
			if(imgFile != "") {
				fileSize = document.getElementById("isFile").files[0].size;
			    
			    if(!imgFile.match(fileForm)) {
			    	alert("이미지 파일만 업로드 가능합니다.");
			        return;
			    }
			}
		
			var frm = document.reviewFrm;
			frm.method = "POST";
			frm.action = "myPageReviewWrite.do";
			frm.submit();			
			
		});// end of $("#btnRegister").click(function(){})-----------------------------------	
		
		
	});

</script>

</head>
<body>	
	<div class="container">
		<jsp:include page="../include/header.jsp"></jsp:include>
		<div class="section" align="center">
			<div class="contents">	
			
			<jsp:include page="../include/myPageSideMenu.jsp"></jsp:include>			
			
			<div id="myPage_Contents">		
				<div id="myProductReview_Header">
					<h2 id="myProductReview_Title">후기 작성</h2>
					<div id="line" style="clear:both;"></div>										
				</div>			
				
				<div class="myOrder_Goods">						
					<div class="myOrder_Info">							
						<table class="myOrder_Desc">
							<tr class="list">
								<td class="image">
									<img alt="해당 주문 대표 상품 이미지" src="../images/iscream.png">
								</td>
								<td class="info">
									<div class="name">
										<span class="productName">제품명1</span>
									</div>
								</td>	
							</tr>
						</table>	
					</div>	
				</div>				
				
				<div class="review">
				<form name="reviewFrm">	
					<table class="write">
						<tr class="reviewTR title">
							<th class="reviewTH">제목</th>
							<td class="reviewTD">
								<input type="text" id="subject" name="subject" placeholder="제목을 입력해주세요." value="">
							</td>
						</tr>
						<tr class="reviewTR contents">
							<th class="reviewTH">후기작성</th>
							<td class="reviewTD">
								<div class="field_cmt">
									<textarea id="content" name="content" cols="100" rows="10" placeholder="최소 10글자 이상 작성 가능합니다."></textarea>
								</div>
							</td>
						</tr>
						<tr class="reviewTR image">
							<th class="reviewTH">사진등록</th>
							<td class="reviewTD">
								<input type="file" name="image" id="image" accept="image/*" />
								<span style="font-size:8pt;">구매한 상품이 아니거나 캡쳐 사진을 첨부한 경우, 통보없이 삭제됩니다.</span>
							</td>
						</tr>
					</table>
				</form>					
				</div>				
				
				<button type="button" id="btnSubmit" class="button">등록하기</button>
					
			</div>
				
								
			</div>
			<div style="clear:both;"></div>
		</div>	
		<jsp:include page="../include/footer.jsp"></jsp:include>
	</div>
</body>
</html>






















