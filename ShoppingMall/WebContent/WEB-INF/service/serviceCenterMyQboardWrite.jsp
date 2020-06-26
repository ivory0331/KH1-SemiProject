<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<% String ctxPath = request.getContextPath(); %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<link rel="stylesheet" href="<%= ctxPath %>/css/style.css" />
<title>serviceCenterQboardList</title>
<style type="text/css">
.sideMenu {
	display: inline-block;
	width: 150px;
	float: left; 
	
	nij]]
}

.serviceCenter-board {
	width: 780px;
	margin-left: 90px;
	text-align: left;
	border: solid 1px red;
}

.board-title {
	width: 350px;
}

.txt_center {
	text-align: center;
}

.writeBtn {
	display: inline-block;
	border: solid 1px black;
	padding: 5px 30px;
	background-color: purple;
	color: white;
	float: right;
}

.paging {
	width: 780px;
	clear: both;
	text-align: center;
}

.writeBtn:hover {
	cursor: pointer;
	background-color: white;
	color: purple;
}

.panel {
	background-color: white;
	overflow: hidden;
	text-align: left;
	margin: 0px;
}

.panel-none {
	display: none;
}

.Mycontainer{
    font-family: noto sans;
    letter-spacing: 0.7;
}

th.input_txt {
    width: 200px;
    padding: 30px 0 0 30px;
    background-color: #f7f5f8;
    border-bottom: 1px solid #e8e8e8;
    text-align: left;
    font-weight: 400;
    vertical-align: middle;
    font-size: 9pt;   
}

table td {
    width: auto;
    padding: 15px 0 15px 10px;
    height: 23px;
    border-top: 1px solid #e8e8e8;
    border-bottom: 1px solid #e8e8e8;
    vertical-align: middle;
    line-height: 20px;
}

.edit_area{
	font-size : 8.5pt;
	color : #333;
}

.select{
	width : 200px;
	height : 30px;
	margin : 5px 0 ;
	border : solid 1px #ccc;
}
input[type=text]{
	border : solid 1px #ccc;
	height : 30px;
}

.bhs_button{
	float : right;
	width : 150px;
	height : 30px;
	color: #fff;
	background-color:#5f0080;
	border-style: none;
	float : right;
	display: inline-block;
	
}

</style>
<link rel="stylesheet"	href="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.1/css/bootstrap.min.css">
<script	src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
<script	src="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.1/js/bootstrap.min.js"></script>
<script type="text/javascript" src="/ShoppingMall/js/jquery-3.3.1.min.js"></script>
<script type="text/javascript" src="/ShoppingMall/util/myutil.js"></script>
<script type="text/javascript">
	
	var bSubjectCheck = false; //아이디 유효성 체크 
	var bContentsCheck = false; //비밀번호 유효성  체크 
	
	
	$(document).ready(function(){
            
	   $(".txt_guide").hide();     
	   $(".txt_guide_address").show();
	    //== 아이디 유효성검사 ==   
	   $("input#userid").focus(function(){
	      $(".txt_guide:eq(0)").show();
	   });
	       
	    
	    $("input#userid").keyup(function(event){
	      //== 정규표현식 객체 만들기 ==
	      // 5자 이상 10글자 이하의 영문과 숫자를 조합
	      var regExp = /^[A-Za-z0-9]{5,10}$/;
	      
	      // 생성된 정규표현식 객체속에 데이터를 넣어서 검사하기
	      var bool = regExp.test($(this).val()); 
	      
	      if(!bool){                  
	         $(".userid_error:eq(0)").addClass('wrong');
	         $(".userid_error:eq(0)").removeClass('correct');
	         bIdValidateCheck = false;
	      }
	      else{ //아이디를 올바르게 입력했으면, 에러문자 지워지고 다음 탭 쓸수있게 한다
	         $(".userid_error:eq(0)").addClass('correct');
	         $(".userid_error:eq(0)").removeClass('wrong');
	         bIdValidateCheck = true;
	      }
	   });//end of $("input#userid").keyup(function(){});-----------------
	});
        
	
	
	
	
	//== submit 가입하기 클릭시  ==
	function goRegister() {
	
		//제목 입력 
		if (!bSubjectCheck) {
			alert("제목을 입력해주세요");
			return;
		}
		
		if (!bContentsCheck) {
			alert("내용을 입력해주세요");
			return;
		}
		
	
		var frm = document.boardWritefrm;
		frm.method = "POST";
		frm.action = "<%=ctxPath%>/service/serviceCenterMyQboardWrite.do";
		frm.submit();
		alert("문의가 등록되었습니다");

	}// end of function goRegister(event)----------
</script>
</head>
<body>

	<div class="Mycontainer">
		<jsp:include page="../include/header.jsp"></jsp:include>
		<div class="section" align="center">
			<div class="contents">
				<div class="sideMenu">
					<jsp:include page="../include/serviceCenterSide.jsp"></jsp:include>
				</div>
				<div class="serviceCenter-board">
					<div class="boardInfo">
						<h3 style="display: inline-block">1:1문의</h3>
					</div>
					
						<form name="boardWritefrm" id=boardWritefrm style="height: 100%;">
							<table style="border-top: solid 2px purple;" class="boardTable table">
								<colgroup><col width="14%" align="right"></colgroup>
									<tbody>
									<tr>
										<th class="input_txt" style="border-top: solid 2px purple;">제목</th>
										<td><select name="itemcd" required class="select">
												<option value="">선택해주세요.</option>
												<option value="1">배송지연/불만</option>
												<option value="2">컬리패스 (무료배송)</option>
												<option value="3">반품문의</option>
												<option value="4">A/S문의</option>
												<option value="5">환불문의</option>
												<option value="6">주문결제문의</option>
												<option value="7">회원정보문의</option>
												<option value="8">취소문의</option>
												<option value="9">교환문의</option>
												<option value="10">상품정보문의</option>
												<option value="11">기타문의</option>
										</select><br> 
										<input type="text" id="subject" name="subject" style="width: 100%" required value=""></td>
									</tr>
									
									<tr>
										<th class="input_txt">주문번호</th>
										<td>
										<input type="text" name="ordno" style="width:25%" value="" readonly="readonly">
										<input onclick="order_open()" type="button" class="bhs_button" value="주문조회" style="float:none; line-height:27px; width:100px;">
										<div style="position:relative;">
										<iframe id="ifm_order" style="display:none;position:absolute;width:560px;height:380px;background-color:#fff;position:absolute;left:0;top:0;border:1px solid #000"></iframe>
										</div>
										</td>
									</tr>
									<tr>
										<th class="input_txt">이메일</th>
										<td><input type="text" name="email" value="${sessionScope.loginuser.email}" size="26" readonly="readonly" class="read_only" style = "text-align:left; color:gray;"> 
										<span class="noline smalle" style="padding-left: 10px">
										<input type="checkbox" name="mailling" value="1"><span style="font-size: 8pt; padding-left: 5px">답변수신을 이메일로 받겠습니다.</span></span></td>
										
									</tr>
									
									<tr>
										<th class="input_txt">문자메시지</th>
										<td><input type="text" name="mobile" value="${sessionScope.loginuser.mobile}" readonly="readonly" class="read_only">
										<span class="noline smalle" style="padding-left: 10px">
										<input type="checkbox" name="sms" value="2"><span style="font-size: 8pt; padding-left: 5px">답변수신을 문자메시지로 받겠습니다.</span></span></td>
									</tr>
									<tr>
										<th class="input_txt">내용</th>
										<td class="edit_area" style="position: relative;">
											<div class="notice_qna">
											<strong class="tit qna_public">1:1 문의 작성 전 확인해주세요!</strong> 
												<dl class="list qna_public">
													<dt>반품 / 환불</dt>
													<dd>
													<span>제품 하자 혹은 이상으로 반품(환불)이 필요한 경우 사진과 함께 구체적인 내용을 남겨주세요.</span>
													</dd>
												</dl>
												<dl class="list" id="branchByVersion15">
													<dt>주문취소</dt>
													<dd class="new">
														<span> 배송 단계별로 주문취소 방법이 상이합니다. <br> [입금확인]
															단계 : [마이컬리 &gt; 주문내역 상세페이지] 에서 직접 취소 가능 <br>
															[입금확인] 이후 단계 : 고객행복센터로 문의
														</span> <br> <span>생산이 시작된 [상품 준비중] 이후에는 취소가 제한되는
															점 고객님의 양해 부탁드립니다.</span> <span>비회원은 모바일 App 또는 모바일
															웹사이트에서 [마이컬리 &gt; 비회원 주문 조회 페이지] 에서 취소가 가능합니다.</span> <span>일부
															예약상품은 배송 3~4일 전에만 취소 가능합니다.</span> <span>주문상품의 부분 취소는
															불가능합니다. 전체 주문 취소 후 재구매 해주세요.</span>
													</dd>
												</dl>
												<dl class="list">
													<dt>배송</dt>
													<dd>
														<span>주문 완료 후 배송 방법(샛별 / 택배)은 변경이 불가능합니다.</span> 
														<span>배송일 및 배송시간 지정은 불가능합니다. (예약배송 포함)</span>
														<p class="info">※ 전화번호, 이메일, 주소, 계좌번호 등의 상세 개인정보가 문의 내용에 저장되지 않도록 주의해 주시기 바랍니다.</p>
													</dd>
												</dl>
											</div>
										<textarea name="contents" style="width: 100%; height: 474px;" class="editing_area" required > </textarea>
									</td>
								</tr>
								
								<tbody>
								<tr> 
								<td colspan="2" style= "border:none" id="submit" align="right"; >
									<input type="submit" class="bhs_button" value="저장" onclick="goRegister();">
								</td>
								</tr>
								</tbody>
							</table>
						</form>
					</div>
				</div>
			  </div>
			</div>
	
		<div style="clear: both;">
			<jsp:include page="../include/footer.jsp"></jsp:include>
		</div>

</body>
</html>