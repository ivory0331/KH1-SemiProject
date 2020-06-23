<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%
	String ctxPath = request.getContextPath();
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<link rel="stylesheet" href="<%=ctxPath%>/css/style.css" />
<title>마이페이지 개인 정보 수정</title>

<style type="text/css">
.contents {
	border: solid 0px black;
	min-height: 600px;
}

.menu3>a {
	color: #5f0080 !important;
	background-color: #eee;
}

#myInfoUpdate_Title {
	border: solid 0px blue;
	font-size: 16pt;
	display: inline-block;
	float: left;
}

h3#title {
	border: solid 0px blue;
	text-align: left;
	font-size: 14pt;
}

#line {
	border-top: solid 2px #5f0080;
	height: 20px;
}

body {
	background-color: #f2f2f2;
}

.page_article .fieldhead {
	margin: 0 auto;
	width: 640px;
}

.page_article {
	background-color: #f2f2f2;
	margin: 0 auto;
	width: 1080px;
	margin: 0 auto;
	border: solid 1px #fff;
}

#form {
	width: 640px;
	margin: 0 auto;
	/*border: solid 1px hotpink;*/
}

.tit {
	text-align: center;
	color: #333;
}

.fieldhead_tit {
	padding: 8px 0;
	margin: 0;
	color: #666;
	font-size: 12px;
}

.member_join .txt_guide {
	width: 300px;
	margin: 0;
	display: block;
	padding: 7px 0 0 0px;
	font-size: 12px;
	color: #51495a;
	line-height: 20px;
	letter-spacing: 0.6px;
}

fieldset {
	text-align: left;
	border: none;
	background-color: #fff;
	width: 640px;
	/*border : solid 1px navy;*/
}

.contents input {
	width: 300px;
	height: 40px;
	border: solid 1px #ccc;
	border-radius: 5px;
}

input::placeholder {
	color: #ccc;
	padding: 0 5px;
}

input.tel_confirm {
	margin-top: 10px;
}

span.btn_tel {
	background-color: #ddd;
	border: 1px solid #ddd;
	color: #fff;
}

span.btn_tel_correct {
	width: 130px;
	height: 40px;
	display: inline-block;
	line-height: 30px;
	text-align: center;
	background-color: #5f0080;
	border: 1px solid #5f0080;
	color: #fff;
	font-size: 14px;
	float: right;
	margin-left: 2px;
	border-radius: 3px;
	cursor: pointer;
}

span.btnCheck_tel {
	margin-top: 10px;
	background-color: #fff;
	border: 1px solid #ccc;
	color: #ccc;
	cursor: default;
}

#address, #detailAddress {
	width: 410px;
	height: 40px;
	margin-top: 5px;
}

input.gender {
	width: 15px;
	height: 15px;
	border: solid 1px #ccc;
	margin: 10px 5px;
}

label.text_position {
	padding: 0px 15px 0px 2px;
	margin: 0;
	color: #666;
	font-size: 14px;
	display: inline-block;
	flex-direction: row;
}

button.btn_address {
	float: none;
	margin-bottom: 3px;
	width: 200px;
}

.birth_day {
	overflow: hidden;
	width: 300px;
	height: 40px;
	border: solid 1px #ccc;
	border-radius: 5px;
}

.birth_day input[type=text] {
	float: left;
	width: 80px;
	height: 37px;
	border: 0;
	text-align: center;
	padding-left: 4px;
}

.contents span.bar {
	width: 20px;
	height: 37px;
	padding-top: 10px;
	text-align: center;
	position: relative;
	float: left;
	font-size: 15pt;
	color: #ccc;
}

.btnCheck {
	width: 130px;
	height: 40px;
	display: inline-block;
	line-height: 30px;
	text-align: center;
	background-color: #5f0080;
	border: 1px solid #5f0080;
	color: #fff;
	font-size: 14px;
	float: right;
	margin-left: 2px;
	border-radius: 3px;
}

.bthCheck_tel {
	cursor:;
}

.contents table {
	border-collapse: collapse;
	border-spacing: 0;
}

.contents td {
	display: table-cell;
	vertical-align: inherit;
}

.memberCols1 {
	width: 130px;
	font-size: 14px;
	font-weight: 500;
	/*border: solid 1px pink;*/
	padding: 20px 0 20px 15px;
	color: #333;
	line-height: 20px;
	vertical-align: top;
}

.memberCols2 {
	padding: 10px 0;
	border-top: 0;
	font-size: 10pt;
	vertical-align: top;
	text-align: left;
	width: 461px;
	height: 20px;
	/*border: solid 1px skyblue;*/
	border-radius: 5px;
	margin: 0;
}

.contents li {
	display: flex;
	flex-direction: row;
	align-items: center;
}

div.reg_agree {
	margin-top: 10px;
	padding: 0;
	border: 1px solid #f3f2f4;
	background-color: #fff;
	width: 640px;
	height: 280px;
	/*border : solid 1px red;*/
}

.contents input[type=checkbox] {
	display: inline-block;
	width: 14px;
	height: 14px;
	border: 0;
	text-align: center;
}

.contents a.link {
	font-size: 14px;
	font-weight: 430;
	color: #5f0080;
	line-height: 17px;
	letter-spacing: 0;
	text-decoration: none;
}

.contents a {
	cursor: pointer;
	text-decoration: none;
}

#head_tit_agree {
	/*border : solid 1px pink;*/
	padding: 8px 0 8px 18px;
	color: #333;
	letter-spacing: 0px;
	font-size: 12pt;
	font-weight: bold;
}

.head_sub_agree {
	font-size: 12px;
	font-weight: normal;
	padding: 0;
	color: #333;
}

div#submit {
	padding: 40px 0;
	display: flex;
	aline-items: center;
	justify-content: center;
	/*border: solid 1px black;*/
}

button.btn_submit {
	width: 340px;
	height: 54px;
	font-size: 12pt;
	background-color: #5f0080;
	color: #fff;
	border-style: none;
	border-radius: 3px;
	letter-spacing: 0.6px;
}

.check {
	font-size: 12pt;
	font-weight: 630;
	color: #333;
	letter-spacing: 0.6px;
	padding: 0 0 10px 20px;
}

.check_view {
	padding: 5px 0 5px 40px;
	font-size: 14px;
	letter-spacing: 0.6px;
	color: #333;
	font-weight: 400;
}

span.sub_agree {
	color: gray;
}

div.check_event {
	padding: 7px 0 4px 45px;
}

.correct {
	color: #0f851a;
}

.wrong {
	color: #b3130b;
}
</style>

<link rel="stylesheet"
	href="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.1/css/bootstrap.min.css">
<link rel="stylesheet" href="css/style.css" />
<script
	src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
<script
	src="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.1/js/bootstrap.min.js"></script>
<script type="text/javascript"
	src="/ShoppingMall/js/jquery-3.3.1.min.js"></script>
<script type="text/javascript" src="/ShoppingMall/util/myutil.js"></script>

<script type="text/javascript">
	var bIdValidateCheck = false; //아이디 유효성 체크 
	var bPwValidateCheck = false; //비밀번호 유효성  체크 
	var bPwChValidateCheck = false; //비밀번호 확인 체크 
	var bIdDuplicateCheck = false; // 아이디 중복확인을 클릭여부 확인 
	var bEmailDuplicateCheck = false; //이메일 중복확인 클릭여부 확인 
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
	      
	        
	   /// **** AJAX로 ID중복확인하기  ****///
	   $("#idcheck").click(function() {
	 	var regExp = /^[A-Za-z0-9]{5,10}$/;
	     var bool = regExp.test($(this).val()); 
	     
	     if($("#userid").val().trim()==""){
	        alert("아이디를 입력하세요");
	        bIdValidateCheck = false;
	        return;
	     }$.ajax({
	         url:"<%=ctxPath%>/member/idDuplicateCheck.do",
	         type:"get",
	         data:{"userid":$("#userid").val()},
	         dataType:"JSON",
	         success:function(json){
	            if(json.isUse) {
	                 alert("사용 가능한 ID입니다.");
	                 bIdDuplicateCheck = true; // 아이디중복확인을 클릭했는지 클릭안했는지를 알아보기 위한 용도임.(클릭함)
	                $(".userid_error:eq(1)").addClass('correct');
	              $(".userid_error:eq(1)").removeClass('wrong');
	            }
	            else {
	               alert("중복된 ID라 사용이 불가능 합니다.");
	               bIdDuplicateCheck = false;
	               $("#userid").val("");
	               $(".userid_error:eq(1)").addClass('wrong');
	            $(".userid_error:eq(1)").removeClass('correct');
	            }
	         },
	         error: function(request, status, error){
	            alert("code: "+request.status+"\n"+"message: "+request.responseText+"\n"+"error: "+error);
	         }
	      });
	      
	   });// end of $("#idcheck").click()------------
	
	   
	   // == 비밀번호 유효성 검사 ==          
	   $("input#passwd").focus(function(){
	      $(".txt_guide:eq(1)").show();
	   }); 
	   
	   $("#passwd").keyup(function(event){          
	      var regExp = new RegExp(/^.*(?=^.{8,15}$)(?=.*\d)(?=.*[a-zA-Z])(?=.*[^a-zA-Z0-9]).*$/g); 
	      // 숫자/문자/특수문자/ 포함 형태의 8~15자리 이내의 암호 정규표현식 객체 생성
	      
	      var bool = regExp.test($(this).val()); 
	      
	      if(!bool){                  
	         $(".passwd_error").addClass('wrong');
	         $(".passwd_error").removeClass('correct');
	         bPwValidateCheck = false;
	      }
	     else{ //비밀번호를 올바르게 입력했으면, 에러문자 지워지고 다음 탭 쓸수있게 한다
	         $(".passwd_error").addClass('correct');
	         $(".passwd_error").removeClass('wrong');
	         bPwValidateCheck = true;
	     }
	   }); // end of $("#pwd").blur()---------------
	   
	   
	   // == 비밀번호 체크 검사 == 
	   $("input#passwdCk").focus(function(){
	      $(".txt_guide:eq(2)").show();
	   });
	   $("#passwdCk").keyup(function(){
	      var passwd = $("#passwd").val();
	      var passwdCheck = $(this).val();
	      
	      if(passwd != passwdCheck) { // 암호와 암호확인값이 틀린 경우 
	        $(".passwdCk_error").addClass('wrong');
	        $(".passwdCk_error").removeClass('correct');   
	        bPwChValidateCheck = false;
	      }
	      else { // 암호와 암호확인값이 같은 경우 
	        $(".passwdCk_error").addClass('correct');
	        $(".passwdCk_error").removeClass('wrong'); 
	        bPwChValidateCheck = true;
	      }
	   });// end of $("#passwdCk").blur()--------------   
	   
	   
	   //== 휴대폰 유효성 검사 == 
	   // 1) 숫자만 입력(숫자이외의 글자를 치면 아예 못치게 차단) 2)유효성검사에 맞으면 인증번호받기 클릭가능 3)버튼 누르면 메세지 전송
	                   
	   $("#tel").keyup(function(event){
	      
	      //1) 숫자만 입력(숫자이외의 글자를 치면 아예 못치게 차단)
	      var keycode = event.keyCode;
	        //console.log(keycode+"input value=>"+$(this).val());
	        //console.log($(this).val().length);
	        //console.log(keycode);
	      
	      if( !((48 <= keycode && keycode<=57) || (96<=keycode && keycode<=105))){
	         var word = $(this).val().length;
	         var keyValue = $(this).val().substring(0,word-1);
	         $(this).val(keyValue);
	      }
	      
	      //2)유효성검사에 맞으면 인증번호받기 클릭가능
	      if($(this).val().length == 11) {
	           // console.log("핸드폰 번호 형태 맞음");
	              var regExp = /^((01[1|6|7|8|9])[1-9]+[0-9]{6,7})|(010[1-9][0-9]{7})$/;
	              var bool = regExp.test($(this).val());
	               
	             if(!bool) { //맞지않을시 a태그 클릭 안되게 
	            $(".btn_tel").removeClass('btn_tel_correct');
	             
	             }
	             else { // 맞을시 : 색 변경 + a태그 클릭 가능하게 
	              $(".btn_tel").addClass('btn_tel_correct');
	               }
	         }
	      else{
	            $(".btn_tel").removeClass('btn_tel_correct');
	            $(".btn_tel").removeAttr("href");
	       }
	     
	         
	   });// end of $("#tel").focus()-------------
	   
	   
	   //==인증번호 받기 (인증번호 클릭하면 telCk_error나오게 )
	   $(".btn_tel").click(function(event){
	 	  $(".txt_guide:eq(3)").show();
	 	  
	   });
	   
	   
	   //==인증번호 확인 
	   
	   //생년월일 클릭 시 
	   $(".birth_day").click(function(event){
	 	  $(".txt_guide_birth_error").show();
	 	  
	   });
	   
	   $("input#birth_year, input#birth_month, input#birth_day").keyup(validateBirth);
	   
	
	   //== 생년월일에 0추가 == 
	   var mmhtml = "";
	   for(var i=1; i<=12; i++) {
	      if(i<10) {
	         mmhtml += "<option value ='0"+i+"'>0"+i+"</option>";
	      }
	      else {
	         mmhtml += "<option value ='"+i+"'>"+i+"</option>";
	      }
	   }
	   
	   $("#birth_month").html(mmhtml);
	   
	   
	   var ddhtml = "";
	   for(var i=1; i<=31; i++) {
	      if(i<10) {
	         ddhtml += "<option value ='0"+i+"'>0"+i+"</option>";
	      }
	      else {
	         ddhtml += "<option value ='"+i+"'>"+i+"</option>";
	      }
	   }
	   
	   $("#birth_day").html(ddhtml);	   
	   
	   // == 필수 선택 클릭 시 == //
	   $("input.agree").click(function(){
	     var flag = true;
	     if($(this).prop("checked")){
	        $("input.agree").each(function(){
	           var bChecked = $(this).prop("checked");
	           if(!bChecked){
	              flag = false;
	              return false;
	           }
	        });
	     }
	     else{
	        flag = false;
	     }
	     $("input[name='agree_allcheck']").prop("checked",flag);
	   });
	   
	         
	}); // end of $(document).ready()-----------------
	
	   
		//== 이메일 중복검사 기능 호출 ==
		function chkEmail() {
			var email = $("#email").val();
			var regExp_EMAIL = /^[0-9a-zA-Z]([-_\.]?[0-9a-zA-Z])*@[0-9a-zA-Z]([-_\.]?[0-9a-zA-Z])*\.[a-zA-Z]{2,3}$/i;
			var bool = regExp_EMAIL.test(email);
	
			if (!bool) { // 이메일이 정규표현식에 위배된 경우
	
				alert("잘못된 형식의 이메일 입니다.");
				bEmailDuplicateCheck = false; 
				return;
				
			} $.ajax({
				url : "<%=ctxPath%>
		/member/emailDuplicateCheck.do",
				type : "post",
				data : {
					"email" : $("#email").val()
				},
				dataType : "json",
				success : function(json) {
					if (json.isEmail) {
						alert("사용이 가능한 이메일입니다.");
						bEmailDuplicateCheck = true;
					} else {
						alert("이미 사용중인 이메일입니다.");
						bEmailDuplicateCheck = false;
					}
				},
				error : function(request, status, error) {
					alert("code: " + request.status + "\n" + "message: "
							+ request.responseText + "\n" + "error: " + error);
				}
			});
		}//end of function chkEmail() {}---------
	
		//== 생년월일 유효성 검사 ==
		function validateBirth(event) {
			event.preventDefault();
	
			var yearRegex = /^(19[0-9][0-9]|20\d{2})$/;
			var monthRegex = /^(0[0-9]|1[0-2])$/;
			var dateRegex = /^(0[1-9]|[1-2][0-9]|3[0-1])$/;
	
			// 1. 연도 형식 맞는지?
			var yearValue = $("#birth_year").val();
			if (!yearRegex.test(yearValue)) {
				// error 표시 후 리턴
				$("#txt_birth_error").html("태어난 연도를 정확하게 입력해주세요").addClass('wrong');
				return;
			}
	
			// 2. 월 형식 맞는지?
			var monthValue = $("#birth_month").val();
			if (!monthRegex.test(monthValue)) {
				// error , return
				$("#txt_birth_error").html("태어난 월을 정확하게 입력해주세요").addClass('wrong');
				return;
			}
	
			// 3. 일 형식 맞는지?
			var dateValue = $("#birth_day").val();
			if (!dateRegex.test(dateValue)) {
				// error , return
				$("#txt_birth_error").html("태어난 일을 정확하게 입력해주세요").addClass('wrong');
				return;
			}
	
			var userYearInt = parseInt(yearValue);
			var userMonthInt = parseInt(monthValue);
			var userDayInt = parseInt(dateValue);
			var userInputDate = new Date(userYearInt, userMonthInt, userDayInt);
			var today = new Date();
	
			var userAge = Math.floor((today - userInputDate)
					/ (1000 * 60 * 60 * 24 * 365));
			console.log('userAge', userAge);
	
			// 4. 미래를 입력했는지?
			if (userAge < 0) {
				// error, return
				$("#txt_birth_error").html("생년월일이 미래로 입력되었어요.").addClass('wrong');
				return;
			}
	
			// 5. 14세 이상인지?
			if (userAge <= 14) {
				// error , return
				$("#txt_birth_error").html("만 14세 미만은 가입이 불가합니다.")
						.addClass('wrong');
				return;
			}
			// 1,2,3,4,5가 모두 맞으면
			$("#txt_birth_error").html("").addClass('wrong');
	
		}
	
		//== submit 가입하기 클릭시  ==
		function goRegister() {
	
			//아이디 유효성 검사 체크 
			if (!bIdValidateCheck) {
				alert("올바른 아이디 형식이 아닙니다");
				return;
			}
			//비밀번호 유효성 검사 체크
			if (!bPwValidateCheck) {
				alert("올바른 비밀번호 형식이 형식이 아닙니다");
				return;
			}
			//비밀번호확인 동일여부 검사 체크 
			if (!bPwChValidateCheck) {
				alert("동일한 비밀번호 형식을 입력해주세요");
				return;
			}
			//휴대폰 번호 검사 체크여부 
	
			//아이디 중복체크 검사 
			if (!bIdDuplicateCheck) {
				alert("아이디 중복확인을 해주세요");
				return;
			}
			//이메일 중복체크 검사 
			if (!bEmailDuplicateCheck) {
				alert("이메일 중복확인을 해주세요");
				return;
			}
	
			//관심분야 필수 3개 이상 선택했는지 검사
			var nAgreeLen = $("input:checkbox[name=agree]:checked").length;
			if (nAgreeLen < 3) {
				alert("이용약관동의 필수사항을 선택하세요")
				return;
			}
	
			var frm = document.registerFrm;
			frm.method = "POST";
			frm.action = "register.do";
			frm.submit();
			alert("가입되었습니다");
	
		}// end of function goRegister(event)----------
</script>

</head>
<body>
	<div class="container">
		<jsp:include page="../include/header.jsp"></jsp:include>
		<div class="section" align="center">
			<div class="contents">

				<jsp:include page="../include/myPageSideMenu.jsp"></jsp:include>

				<div id="myPage_Contents">

					<div id="myInfoUpdate_Header">
						<h2 id="myInfoUpdate_Title">개인 정보 수정</h2>
					</div>

					<div class="member_update">
						<div class="fieldhead">
							<p class="tit fieldhead_tit" style="text-align: right">*필수입력사항</p>
						</div>
						<form id="form" name="registerFrm">
							<fieldset>

								<table>
									<tr>
										<td class="memberCols1">아이디*</td>
										<td class="memberCols2"><input type="text" name="userid"
											id="userid" placeholder="5자 이상 10글자 이하의 영문과 숫자를 조합" value=""
											maxlength="16" required autocomplete="off"> <span
											id="idcheck"><span class="btnCheck" id="idcheckResult">중복확인</span></span>
											<p class="txt_guide" style="display: block;">
												<span class="txt txt_errorCk userid_error">5자 이상 10글자
													이하의 영문과 숫자를 조합</span><br /> <span
													class="txt txt_errorCk userid_error">아이디 중복확인</span>
											</p></td>
									</tr>

									<tr>
										<td class="memberCols1">비밀번호*</td>
										<td class="memberCols2"><input type="password" name="pwd"
											id="passwd" placeholder="비밀번호를 입력해주세요" value=""
											maxlength="20" required />
											<p class="txt_guide" style="display: block;">
												<span class="txt txt_errorCk passwd_error">8~15자리 이내의
													암호입력 <br />영문/숫자/특수문자(공백 제외)만 허용
												</span><br />
											</p></td>
									</tr>

									<tr>
										<td class="memberCols1">비밀번호확인*</td>
										<td class="memberCols2"><input type="password"
											id="passwdCk" placeholder="비밀번호를 한번 더 입력해주세요" value=""
											maxlength="20" required />
											<p class="txt_guide" style="display: block;">
												<span class="txt txt_errorCk passwdCk_error">동일한
													비밀번호를 입력해주세요.</span>
											</p></td>
									</tr>

									<tr>
										<td class="memberCols1">이름*</td>
										<td class="memberCols2"><input type="text" name="name"
											id="name" value="" maxlength="20"
											placeholder="고객님의 이름을 입력해주세요" required /></td>
									</tr>

									<tr>
										<td class="memberCols1">이메일*</td>
										<td class="memberCols2"><input type="email" name="email"
											id="email" value="" maxlength="40"
											placeholder="예: marketkurly@kurly.com" required /> <a
											href="javascript:chkEmail()"><span
												class="btnCheck email_error">이메일 중복확인</span></a></td>
									</tr>

									<tr>
										<td class="memberCols1">휴대폰*</td>
										<td class="memberCols2"><input type="tel" name="mobile"
											id="tel" value="" maxlength="11" placeholder="숫자만 입력해주세요" />
											<span class="btnCheck btn_tel ">인증번호 받기 </span> <input
											type="text" class="tel_confirm" name="tel_confirm"
											id="tel_confirm" value="" maxlength="6"> <span
											class="btnCheck btnCheck_tel ">인증번호 확인 </span>

											<p class="txt_guide" style="display: block;">
												<span class="txt txt_errorCk telCk_error">인증번호가 오지
													않는다면, 통신사 스팸 차단 서비스 혹은 휴대폰 번호 차단 여부를 확인해주세요. (마켓컬리
													1644-1107)</span>
											</p></td>
									</tr>
								</table>

								<div class="fieldhead">
									<h3 id="title">추가 정보</h3>
									<div id="line" style="clear: both;"></div>
								</div>

								<table>
									<tr>
										<td class="memberCols1">성별</td>
										<td class="memberCols2"><input type="radio"
											class="gender" name="gender" value="1" id="male" /> <label
											for="male" class="text_position">남자</label> <input
											type="radio" class="gender" name="gender" value="2"
											id="female"> <label for="female"
											class="text_position">여자</label> <input type="radio"
											class="gender" name="gender" value="3" id="none" checked>
											<label for="none" class="text_position">선택안함</label></td>
									</tr>

									<tr>
										<td class="memberCols1">생년월일</td>
										<td class="memberCols2">
											<div class="birth_day">
												<input type="text" name="birthyear" id="birth_year" value=""
													size="4" maxlength="4" placeholder="YYYY"> <span
													class="bar">/</span> <input type="text" name="birthmonth"
													id="birth_month" value="" size="2" maxlength="2"
													placeholder="MM"> <span class="bar">/</span> <input
													type="text" name="birthday" id="birth_day" value=""
													size="2" maxlength="2" placeholder="DD">
											</div>
											<p class="txt_guide txt_guide_birth_error">
												<span class="txt txt_errorCk" id="txt_birth_error">태어난
													생년월일을 정확하게 입력해주세요</span>
											</p>
										</td>
									</tr>
								</table>
							</fieldset>

							<div class="fieldhead">
								<h3 id="title">이용약관동의</h3>
								<p class="tit fieldhead_tit" style="text-align: right">선택항목에
									동의하지 않은 경우도 회원가입 및 일반적인 서비스를 이용할 수 있습니다.</p>
								<div id="line" style="clear: both;"></div>
							</div>

							<table>
								<tr>
									<td class="memberCols1">선택약관 동의</td>
									
									<td class="memberCols2">
										<div class="check_view">
											<label class="select_check check_agree"> <input
												type="checkbox" name="hiddenCheck" class="agree" value="3">
												<span class="txt_checkbox no_pd">개인정보처리방침<span
													class="sub_agree">(선택)</span></span>
											</label> <a class="link btn_choice" data-toggle="modal"
												data-target="#thirdCheckAgree" data-dismiss="modal">&nbsp;&nbsp;
												약관보기 > </a>
										</div>
	
										<%-- ****** 개인정보처리방침 Modal(ThirdCheckAgree) ****** --%>
										<div class="modal fade" id="thirdCheckAgree" role="dialog">
											<div class="modal-dialog">
	
												<!-- Modal content-->
												<div class="modal-content">
													<div class="modal-header">
														<button type="button" class="close myclose"
															data-dismiss="modal">&times;</button>
														<h4 class="modal-title" style="font-size: 25pt;">개인정보
															수집 및 이용동의(선택)</h4>
													</div>
													<div class="modal-body">
														<div id="thirdAgreeModal">
															<iframe style="border: none; width: 100%; height: 300px;"
																src="<%=request.getContextPath()%>/modal/thirdAgreeModal.html">
															</iframe>
														</div>
													</div>
													<div class="modal-footer">
														<button type="button" class="btn btn-default btn_submit"
															style="display: block; margin: 0 auto;"
															data-dismiss="modal">확인</button>
													</div>
												</div>
											</div>
										</div>
									</td>
								</tr>
							</table>

							<div id="dropout">
								<input type="button" class="btn_dropout" value="탈퇴하기"></input>
							</div>

							<div id="update">
								<input type="button" class="btn_update" value="회원정보수정"></input>
							</div>

						</form>
					</div>
				</div>
			</div>

		</div>

		<div style="clear: both;"></div>

		<jsp:include page="../include/footer.jsp"></jsp:include>
	</div>
</body>
</html>