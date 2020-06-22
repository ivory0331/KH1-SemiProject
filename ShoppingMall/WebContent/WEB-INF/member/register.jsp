<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<% String ctxPath = request.getContextPath(); %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<link rel="stylesheet" href="<%= ctxPath %>/css/style.css" />
<title>회원가입</title>
<style type="text/css">

 .page_article .fieldhead{
   margin: 0 auto;
   width: 640px;
}


.page_article .fieldhead{
   margin: 0 auto;
   width: 640px;
}



.page_article {
   background-color: #f2f2f2;
   margin: 0 auto;
   width: 1080px;
   height: 100%;
   margin: 0 auto;
}

#form {
   width: 640px;
   height: 100%;
   margin: 0 auto;

  /* border: solid 1px hotpink; */
}

.tit {
   text-align: center;
   color: #333;
}


.fieldhead_tit{
    padding: 8px 0;
    margin:0;
   color: #666;   
   font-size: 12px;
}

.member_join .txt_guide {
   width: 300px;
   margin : 0;
    display: block;
    padding: 7px 0 0 0px;
    font-size: 12px;
    color: #51495a;
    line-height : 20px;
    letter-spacing: 0.6px;
}

fieldset {
   text-align: left;
   border: none;
   background-color: #fff;
   width: 613px;
   height: 900px;
}

.contents input {
   width: 300px;
   height: 40px;
   border: solid 1px #ccc;
   border-radius: 5px;  
}

input::placeholder {
  color: #ccc;
  padding : 0 5px;
}

input.tel_confirm{
   margin-top: 10px;
}

span.btn_tel{
   background-color: #ddd;
   border: 1px solid #ddd;
    color: #fff;
}

span.btnCheck_tel{

   margin-top: 10px;
   background-color: #fff;
   /* border: 1px solid #ccc; */
    border: 1px solid #ccc;

    margin-top: 10px;
    background-color: #fff;
   /* border: 1px solid #ccc; */
    color: #ccc;
}

input.gender{
   width: 15px;
   height: 15px;
   border: solid 1px #ccc;
   margin : 10px 5px;
}
<<<<<<< HEAD
<<<<<<< HEAD

=======
>>>>>>> origin/sanga
=======

>>>>>>> hyemin
label.text_position {
    padding: 0px 15px 0px 2px;
    margin:0;
   color: #666;   
   font-size: 14px;
   display: inline-block;
    flex-direction: row; 
}

button.btn_address{
   float:none;
}

.birth_day {
   overflow : hidden;
    width: 300px;
   height: 40px;
   border: solid 1px #ccc;
   border-radius: 5px;  
}
<<<<<<< HEAD
<<<<<<< HEAD

=======
>>>>>>> origin/sanga
=======

>>>>>>> hyemin
.birth_day input[type=text] {
    float: left;
    width: 80px;
    height: 37px;
    border: 0;
    text-align: center;
    padding-left:4px;
}

.contents span.bar {
    width: 20px;
    height: 37px;
    padding-top: 10px;
    text-align: center;
    position: relative;
    float: left;
    font-size: 15pt;
    color : #ccc;
}

.btnCheck{
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
<<<<<<< HEAD
   font-weight: 500;
<<<<<<< HEAD
   /* border: solid 1px pink; */
=======
   /*border: solid 1px pink;*/
>>>>>>> origin/sanga
=======
   font-weight: 500;
   /* border: solid 1px pink; */
>>>>>>> hyemin
   padding: 20px 0 20px 15px;   
    color: #333;
    line-height: 20px;
    vertical-align: top;
<<<<<<< HEAD
}

<<<<<<< HEAD
=======
}
>>>>>>> hyemin

.memberCols2 {
   padding: 10px 0 ;
   border-top: 0;
   vertical-align: top;
   text-align: left;
<<<<<<< HEAD
   width: 461px;
=======
.memberCols2 {
    padding: 10px 0 ;
    border-top: 0;
    font-size: 0;
    vertical-align: top;
    text-align: left;
    width: 461px;
>>>>>>> origin/sanga
=======
   width: 461px;
>>>>>>> hyemin
   height: 20px;
   /*border: solid 1px skyblue;*/
   border-radius: 5px;  
   margin : 0;
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
    width : 640px;
    height : 280px;
    /*border : solid 1px red;*/
}

.contents input[type=checkbox] {
   display : inline-block;   
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
}

.contents a {
   cursor: pointer;
   text-decoration: none;
   
}
#head_tit_agree{
   /*border : solid 1px pink;*/
   padding: 8px 0 8px 18px;
   color: #333;
   letter-spacing: 0px;
   font-size: 12pt;
   font-weight: bold;
}

.head_sub_agree{
   font-size: 12px;
   font-weight: normal;
   padding: 0;
   color: #333;
}

div#submit {
   padding: 40px 0;
   display: flex;
   aline-items : center;
<<<<<<< HEAD
   justify-content : center;
<<<<<<< HEAD
   /* border: solid 1px black; */
=======
   /*border: solid 1px black;*/
>>>>>>> origin/sanga
}
=======
   justify-content : center;
   /* border: solid 1px black; */

>>>>>>> hyemin
button.btn_submit{
   width: 340px;
   height: 54px;
    font-size : 12pt;
    background-color: #5f0080;
    color: #fff;
    border-style:none;
    border-radius: 3px; 
    letter-spacing: 0.6px;
}

.check{
   font-size: 12pt;
   font-weight: 630;
   color: #333;
    letter-spacing: 0.6px;
    padding : 0 0 10px 20px;
}
.check_view{
   padding : 5px 0 5px 40px; 
   font-size : 14px;
   letter-spacing: 0.6px;
   color: #333;
   font-weight: 400;
}
span.sub_agree{
   color: gray;
}
div.check_event{
<<<<<<< HEAD
   padding : 7px 0 4px 45px; 
<<<<<<< HEAD
} 
=======
}
>>>>>>> origin/sanga
=======
   padding : 7px 0 4px 45px; 
} 

>>>>>>> hyemin


</style>
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
		<div class="section" align="center" style="background-color: #f2f2f2;">
			<div class="contents">
			   <div class = "page_article"> 
			   <div class=" head_join">
			      <h3 class="tit">회원가입</h3>
			   </div>
			      
			   <div class="member_join">
			   <div class ="fieldhead">
			   <p class="tit fieldhead_tit" style="text-align: right">*필수입력사항</p>
			   </div>
			      <form id="form" name="frmMember" method="post" action="#">
			         <fieldset>
			         
			         <table>
			            <tr>
			               <td class="memberCols1">아이디*</td>
<<<<<<< HEAD
			               <td class="memberCols2">
<<<<<<< HEAD
			                  <input type="text" name="userid" id="userid" placeholder ="6자 이상의 영문 혹은 영문과 숫자를 조합" value="" maxlength="16" required  >
=======
			                  <input type="text" name="userid" id="userid" placeholder ="6자 이상의 영문 혹은 영문과 숫자를 조합" value="" maxlength="16" required autofocus autocomplete="off">
>>>>>>> origin/sanga
=======
			               <td class="memberCols2">
			                  <input type="text" name="userid" id="userid" placeholder ="6자 이상의 영문 혹은 영문과 숫자를 조합" value="" maxlength="16" required  >
>>>>>>> hyemin
			                  <a href="javascript:chkId()"><span class="btnCheck">중복확인</span></a>
			                  <p class="txt_guide" style="display: block;">
			                  <span class="txt txt_case1">6자 이상의 영문 혹은 영문과 숫자를 조합</span><br/>
			                  <span class="txt txt_case2">아이디 중복확인</span>
			                  </p>
			                  
			               </td>
			            </tr>
			            
			            <tr>
			               <td class="memberCols1">비밀번호*</td>
			               <td class="memberCols2">                     
			                  <input type="password" name="passwd" id="passwd"  placeholder ="비밀번호를 입력해주세요" value="" maxlength="20" required />               
			                  <p class="txt_guide" style="display: block;">
			                  <span class="txt txt_case1">10자 이상 입력</span><br/>
			                  <span class="txt txt_case2">영문/숫자/특수문자(공백 제외)만 허용하며, 2개 이상 조합</span>
			                  <span class="txt txt_case3">동일한 숫자 3개 이상 연속 사용 불가</span>
			                  </p>
			               
			               </td>
			            </tr>
			            
			            <tr>
			               <td class="memberCols1">비밀번호확인*</td>
			               <td class="memberCols2">
			                  <input type="password" name="passwd" id="passwd" placeholder ="비밀번호를 한번 더 입력해주세요" value="" maxlength="20" required />
			                  <p class="txt_guide" style="display: block;">
			                  <span class="txt txt_case1">동일한 비밀번호를 입력해주세요.</span>
			                  </p>   
			               </td>
			            </tr>
			            
			            <tr>
			               <td class="memberCols1">이름*</td>
			               <td class="memberCols2">
			                  <input type="text" name="name" id="name" value="" maxlength="20"  placeholder ="고객님의 이름을 입력해주세요" required />
			                   <span class="error name_error"></span>
			               </td>
			            </tr>
			            
			            <tr>
			               <td class="memberCols1">이메일*</td>
			               <td class="memberCols2">
			                  <input type="email" name="email" id="email" value="" maxlength="40" placeholder="예: marketkurly@kurly.com" required />
			                      <span class="error email_error"></span>
			                      <a href="javascript:chkEmail()"><span class="btnCheck">이메일 중복확인</span></a>            
			               </td>
			            </tr>
			            
			            <tr>
			               <td class="memberCols1">휴대폰*</td>
			               <td class="memberCols2">
			                  <input type="tel"  name="tel" id="tel" value="" maxlength="13" placeholder="숫자만 입력해주세요"/>
			                    <a href="javascript:chkTel()"><span class="btnCheck btn_tel ">인증번호 받기 </span></a>
			                    
			                    <input type="text" class="tel_confirm" name="tel_confirm" id="tel_confirm" value="" maxlength="6" >   
			                    <a href="javascript:chkTel()"><span class="btnCheck btnCheck_tel ">인증번호 확인 </span></a>
			                    
			                    <p class="txt_guide" style="display: block;">
			                  <span class="txt txt_case1 receive">인증번호가 오지 않는다면, 통신사 스팸 차단 서비스 혹은 휴대폰 번호 차단 여부를 확인해주세요. (마켓컬리 1644-1107)</span>
			                  </p>      
			               </td>
			            </tr>
			            
			            <tr>
			               <td class="memberCols1">배송주소</td>
			                  <td class="memberCols2">      
			                     <button class="btnCheck btn_address">
			                        <span class="txt">주소 검색</span>
			                  </button>
			                  <p class="txt_guide">
			                     <span class="txt txt_case1">배송가능여부를 확인할 수 있습니다.</span>
			                  </p>
			                    </td>
			               </tr>
			            <tr>
			               <td class="memberCols1">성별</td>
			                  <td class="memberCols2">   
			                  <input type="radio" class="gender" name="gender" value="m" id="male"/>
			                  <label for="male" class="text_position">남자</label>
			                  
			                  <input type="radio" class="gender" name="gender" value="w" id="female">
			                  <label for="female" class="text_position">여자</label>
			                  
			                  <input type="radio" class="gender" name="gender" value="n" id="none" checked>
			                  <label for="none" class="text_position">선택안함</label>
			                    </td>
			               </tr>
			      
			               <tr>
			               <td class="memberCols1">생년월일</td>
			                  <td class="memberCols2">   
			                  <div class="birth_day">
			                  <input type="text" name="birth_year" id="birth_year"  value="" size="4" maxlength="4" placeholder="YYYY">
			                  <span class="bar">/</span>
			                  <input type="text" name="birth_month" id="birth_month" value="" size="2" maxlength="2" placeholder="MM">
			                  <span class="bar">/</span>
			                  <input type="text" name="birth_day" id="birth_day" value="" size="2" maxlength="2" placeholder="DD">
			                  </div>
			                  <p class="txt_guide">
			                  <span class="txt bad">태어난 생년월일을 정확하게 입력해주세요</span>
			                  </p>
			               </td>
			               </tr>   
			         </table>   
			         </fieldset>
			         
			            
			         <div class="reg_agree" align="left">
			            
			            <h3 id="head_tit_agree">이용약관동의*  
			            <span class="head_sub_agree">선택항목에 동의하지 않은 경우도 회원가입 및 일반적인 서비스를 이용할 수 있습니다.</span>
			            </h3>
			            
			            <div class="check">
			            <label class="inp_check check_agree label_all_check">
			            <input type="checkbox" class="styled-checkbox-black" name="agree_allcheck">
			            <span class="txt_checkbox">전체동의</span>
			            </label>
			            </div>
			            
			            <div class="check_view">
			            <label class="select_check check_agree">
			            <input type="checkbox" value="" name="agree" required class="styled-checkbox-black">
			            <span class="txt_checkbox">이용약관 <span class="sub_agree">(필수)</span></span>
			            </label>
			            <a href="#none" class="link btn_agreement"> &nbsp;&nbsp; 약관보기 > </a>
			            </div>
			            
			            
			            <div class="check_view">
			            <label class="select_check check_agree">
			            <input type="checkbox" id="private1" name="private1" value="y" required class="styled-checkbox-black">
			            <span class="txt_checkbox">개인정보처리방침 <span class="sub_agree">(필수)</span></span>
			            </label>
			            <a href="#none" class="link btn_essential">&nbsp;&nbsp; 약관보기 > </a>
			            </div>
			            
			            <div class="check_view">
			            <input type="hidden" id="consentHidden" name="consent[1]" value="">
			            <label class="select_check check_agree">
			            <input type="checkbox" name="hiddenCheck" class="styled-checkbox-black">
			            <span class="txt_checkbox no_pd">개인정보처리방침 <span class="sub_agree">(선택)</span></span>
			            </label>
			            <a href="#none" class="link btn_choice">&nbsp;&nbsp; 약관보기 > </a>
			            </div>
			                                    
			            <div class="check_view">
			                  <label class="select_check check_agree check_fourteen">
			                  <input type="checkbox" value="n" name="fourteen_chk" required class="styled-checkbox-black">
			                  <span class="txt_checkbox">본인은 만 14세 이상입니다. <span class="sub_agree">(필수)</span></span>
			                  </label>
			            </div>
			            </div>
			            
			            <div id="submit">
			               <button type="submit" class="btn_submit">가입하기</button>
			            </div>
			               
			         </form>      
			      </div>   
			   </div> 
			</div>
		</div>
		<jsp:include page="../include/footer.jsp"></jsp:include>
	</div>
</body>
</html>

