
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>market kurly Id search</title>
<style type="text/css">
#content{
	font-family : noto sans, sans-serif, malgun gothic;
	min-width : 1080px;
	height: 612px;
	background-color: #fafafa;
	padding : 0;
	margin : 0 auto;
	text-align: center;	
}

.section_login{
	width: 340px;
	margin: 0 auto;
	padding-top : 90px;
	letter-spacint : 6px;
	diplay : block;
	color : #4c4c4c;
	font-size: 12px;
	max-width: 100%;
    line-height: 35px;
}

.section_login .tit_login {
    font-weight: 800;
    font-size: 20px;
    line-height: 10px;
    text-align: center;
}

.section_login * {
    color: #333;
}

h3 {
    display: block;
    font-weight: bold;
    padding: 0;
    margin: 0;
}



.section_login .write_form {
    padding-top: 36px;
}


input {
    display: inline-block;
    width: 300px;
    height: 54px;
    padding: 0 0 0 20px;
    border: 1px solid #ccc;
    border-radius: 3px;
    background-color: #fff;
    font-size: 14px;
    margin: 0px;
}


input::placeholder {
  color: #ccc;
}


a {
    color: -webkit-link;
    cursor: pointer;
    text-decoration: none;
}


.section_login .bar  {
    float: right;
    width: 1px;
    height: 10px;
    margin: 3px 6px 0;
    background-color: #333;
}

.btn_member{
	display: inline-block;
    width: 320px;
    height: 54px;
    border: 1px solid #ccc;
    border-radius: 3px;
    background-color: #fff;
    font-size: 14px;
    cursor:pointer;
}
.btn_type1{
	margin-top: 30px;
	padding: 0 40px;
	border : solid 1px #5f0080;
	background-color: #5f0080;
	font-style: normal;
}	

.txt_type{
	font-weight: 500;
	font-size: 16px;
	color: #fff;
}
.text_type_btn{
	color: #5f0080;
	vertical-align: middle;
}
.txt_type_form{
	float:left;
	font-weight: 600;
	font-size: 12px;
	margin: 0;
	padding: 11px 0 5px 10px;
    display: block;
    font-size: 12px;
    line-height: 20px;
    text-align: left;

}

</style>

<script type="text/javascript" src="/JqueryStudy/js/jquery-3.3.1.min.js"></script>

<script type="text/javascript">

	$(document).ready(function(){
	
		
		//=== submit 보내기 전 고려사항 체크 ===
		$("form[name=idSearchForm]").submit(function(){
			//name이 registerFrm인 form을 submit하려고 할 때 발생되어지는 이벤트임
			
			var frm = document.idSearchForm; 
			
			//1. 성명 입력란에 데이터 값 들어왔는지 검사
	    	var sNameVal = frm.name.val().trim();
	    	
	    	if(sNameVal ==""){
	    		alert ("성명은 필수입력사항 입니다");
	    		frm.name.value="";
	    		frm.name.focus();
	    		return;
	    	}
	    	
	    	//2. 이메일 입력란에 데이터값 들어왔는지 검사
	    	var regExp_email = /^[0-9a-zA-Z]([-_\.]?[0-9a-zA-Z])*@[0-9a-zA-Z]([-_\.]?[0-9a-zA-Z])*\.[a-zA-Z]{2,3}$/i; 
			var bool = regExp_email.test($(this).val().trim());
			
			if(!bool){ 
				alert("올바른 이메일 형식이 아닙니다");
				$(this).focus();	
				return;
			}
			
			
			//리턴이 안되어야만 도달한다			
			var frm = document.idSearchForm;
			frm.action = "#";
			frm.submit();
			
			
			
		});//end of $("form:[name=idSearchForm]").submit(function(){})------------------
		
		
		
				
	});// end of $(document).ready()------------------

</script>




</head>
<body>
	<div id="content">
		<div class = "section_login">
			<h3 class="tit_login">아이디 찾기</h3>
			<div class="write_form">
				<form method="post" name="idSearchForm" id="idSearchForm" action="#" onsubmit="">
					<span class="txt_type_form">이름</span>
					<input type="text" name="name" size="20" tabindex="1" value="" placeholder="고객님의 이름을 입력해주세요" required /><br/>
					<span class="txt_type_form">이메일 </span>
					<input type="email" name="password" size="20" tabindex="2" placeholder= "가입 시 등록하신 이메일 주소를 입력해주세요" required />
					
					<button type="submit" class="btn_type1 btn_member" >
						<span class="txt_type">확인 </span>
					</button>
				</form>
			</div>
		</div>
	</div>
</body>
</html>