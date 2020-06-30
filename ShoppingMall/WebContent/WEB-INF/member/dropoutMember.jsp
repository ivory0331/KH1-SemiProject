<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<% String ctxPath = request.getContextPath(); %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<link rel="stylesheet" href="<%= ctxPath %>/css/style.css" />
<title>회원탈퇴</title>
<style type="text/css">
#content{
	font-family : noto sans, sans-serif, malgun gothic;
	width : 960px;
	height: 100%;
	/*background-color: #fafafa;*/
	padding : 0;
	margin : 0 auto;
	text-align: center;	
}

div.section_login {
    color: #333;
    width : 960px;
	height: 100%;
	margin : 0 auto;
}

.layout-page-title{
	margin-top:40px;
	font-size: 23pt;
	font-weight: 500;
    color: #514859;
    letter-spacing: 0;
    width:960px;
}

input[type=password]{
    width: 200px;
	height: 30px;
	border: solid 1px #ccc; 
}

div.boardWrite{
	width : 960px;
	border-top: solid 2px #5f0080;
	border-bottom: solid 1px #ccc
}
h3.txt_head{
    padding: 50px 0 10px 0px;
    font-size: 20px;
    line-height: 20px;
    font-family: noto sans;
    font-weight: 600;
    color: #514859;
    letter-spacing: 0;
    margin : 0;
    text-align: left;
}

a {
    cursor: pointer;
    text-decoration: none;
}

td.memberCols1 {
    width: 130px;
    padding: 23px 0 25px 20px;
    text-align: left;
    vertical-align: middle;
    font-size: 13.5px;
    font-weight: 700;
   /* border : solid 1px red;*/
}

td.memberCols2 {
    width: 830px;
    padding: 13px 0 13px 30px;
    vertical-align: middle;
    text-align: left;
    font-size: 9.5pt;
    color : #333;
}

.dropbtns{
	width: 960px;
}
.drop_button{
	width: 130px;
	height: 40px;
    display: inline-block;
    line-height: 30px;
    text-align: center;
    background-color: #5f0080;
    color: #fff;
    font-size: 14px;
    float: right;
    margin-left: 2px;
    border-radius: 2px;
    border-style: none;
    cursor: pointer;
    margin-left : 5px;
    vertical-align: middle;
}


</style>
<!-- 부트스트랩 -->
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.1/css/bootstrap.min.css">
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
<script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.1/js/bootstrap.min.js"></script>
<script type="text/javascript" src="/ShoppingMall/js/jquery-3.3.1.min.js"></script>
<script type="text/javascript" src="/ShoppingMall/util/myutil.js"></script>
<script type="text/javascript">
   
   
   
	$(document).ready(function() {
		
		$("input#dropout_btn").click(function(event) {
			
		      var bool = confirm("회원탈퇴를 하시면 회원님의 모든 데이터가 삭제되어집니다. 그래도 회원탈퇴를 하시겠습니까?");
		      
		      if(bool) {//true (회원탈퇴 원할  시)
				
				if($("#password").val().trim()==""){
		           alert("회원탈퇴시 확인을 위해 비밀번호 입력은 필수입니다");
		           $(this).focus();	
		           bPasswordValidateCheck = false;
		           return;
	        	}$.ajax({
		            url:"<%=ctxPath%>/member/dropoutPwdDuplicateCheck.do",
		            type:"POST",
		            data:{"password":$("#password").val()},
		            dataType:"JSON",
					success:function(json){
		            	if(json.equalPwd) { //동일하지 않은 비밀번호
							alert("회원님의 동일한 비밀번호를 입력해주세요");
							$("#password").val("");
							$("#password").focus();
							
		            	}else{ //비밀번호 동일하지 않음
							//alert("동일한 비밀번호");
							goDropout();
							
						}
					},
					 error: function(request, status, error){
           			 alert("code: "+request.status+"\n"+"message: "+request.responseText+"\n"+"error: "+error);
       			 	}
		        });
			}
			else { //회원탈퇴 취소 클릭시
	         	alert("회원탈퇴를 취소하셨습니다.");
				$("input#password").val("");
				bPasswordValidateCheck = false;
				return;
		    }
		});//end of $("input#dropout_btn").click(function(){});-----------------

		$("input#cancle_btn").click(function(event) {
			
			location.href= "<%= request.getContextPath()%>/member/myPageMyInfoUpdate.do"; 
			return;
		});
		
		
		
	});//end of  $(document).ready(function(){})-------
	
	function goDropout() {
		
		var frm = document.dropoutFrm;
		frm.action = "dropoutMember.do";
		frm.method = "POST";
		frm.submit();
		alert("회원님의 정보가 탈퇴 되었습니다");
		logout();
		//return;
	}
	
	function logout(){
		$.ajax({
			url:"<%=ctxPath%>/member/logout.do",
			dataType:"JSON",
			success:function(json){
				if(json.check=="true"){
					//location.reload(true);
					location.href= "<%= request.getContextPath()%>/index.do"; 
				}
				else{
					alert("회원탈퇴에 실패했습니다.");
				}
			},
			error:function(e){
				console.log(e);
			}
		});
	}

	
</script>
</head>
<body>
	<div class="Mycontainer" >
		<jsp:include page="../include/header.jsp"></jsp:include>
		<div class="section_login" id="content" align="center">
			<div class="contents" >
				<h2 class="layout-page-title">회원탈퇴</h2>
				<form name="dropoutFrm" id="dropoutFrm" >
					<h3 class="txt_head">회원탈퇴안내</h3>
					<div class="boardWrite">
						<table>
							<tbody><tr>
							<td class="memberCols1" >
							회원탈퇴안내
							</td>
							<td class="memberCols2">
							고객님께서 회원 탈퇴를 원하신다니 저희 쇼핑몰의 서비스가 많이 부족하고 미흡했나 봅니다.<br>
							불편하셨던 점이나 불만사항을 알려주시면 적극 반영해서 고객님의 불편함을 해결해 드리도록 노력하겠습니다.<br>
							<br>
							■ 아울러 회원 탈퇴시의 아래 사항을 숙지하시기 바랍니다.<br>
							1. 회원탈퇴 시 고객님의 정보는 상품 반품 및 A/S를 위해 전자상거래 등에서 소비자 보호에 관한 법률에 의거한 고객정보 보호정책에따라 관리 됩니다.<br>
							2. 탈퇴 시 고객님께서 보유하셨던 적립금은 삭제 됩니다.<br>
							3. 회원 탈퇴 후 30일간 재가입이 불가능합니다.<br>
							4. 회원 탈퇴 시 컬리패스 해지는 별도로 고객행복센터(1644-1107)를 통해서 가능합니다. 직접 해지를 요청하지 않으면 해지 처리가 되지 않습니다.<br>
							</td>
							</tr>
							</tbody>
						</table>
					</div>
					
					<h3 class="txt_head">회원탈퇴하기</h3>
					<div class="boardWrite" >
						<table>
						<tbody><tr>
						<td class="memberCols1">
						비밀번호가 어떻게 <br/> 되세요?
						</td>
						<td class="memberCols2">
						<input type="password" id="password" name="password" size="20">
						</td>
						</tr>			
						</tbody></table>
					</div>
					
					<div class="dropbtns" style="margin-top:30px;">
					<input class="drop_button" type="button" value="탈퇴" id="dropout_btn" >
					<input class="drop_button" type="reset" value="취소" id="cancle_btn">
					</div>
					<input type="hidden" name="userid" id="userid" value="${sessionScope.userid}" />
				</form>
			</div>
			<div style="clear:both;"></div>
		</div>
		<jsp:include page="../include/footer.jsp"></jsp:include>
	</div>
</body>
</html>



