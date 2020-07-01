<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>footer.jsp</title>
<style type="text/css">
	.footer{
		min-width:1080px;
		max-width: 1700px;
		background-color: white;
	}
	
	.firstInfo{
		display: inline-block;
		margin-right:10px;
	}
	
	.firstInfo > h3{
		display: block;
		margin: 0px;
		width: 180px;
		text-align: center;
		color:black;
	}
	
	.cc_call{
		height: 100px;
	}
	
	.cc_call > h3{
		display: inline-block;
		font-size: 20pt;
		padding: 10px 5px;
		font-weight: bolder;
		width: 180px;
		text-align: center;
		color:black;
	}
	
	.cc_list{
		list-style: none;
		display: inline-block;
		padding-left: 5px;
		font-size:10pt;
		color:gray;
	}
	
	
	.cc_kakao{
		height: 80px;
	}
	.cc_kakao > h3{
		display: inline-block;
		box-sizing: border-box;
		border: solid 1px gray;
		letter-spacing: 2px;
		cursor: pointer;
		margin: 0px;
		padding: 10px 5px;
		font-size: 16pt;
		font-weight: bolder;
		width: 180px;
		text-align: center;
		color:black;
	}
	
	.cc_qua{
		height: 80px;
	}
	
	.cc_qua > h3{
		display: inline-block;
		box-sizing: border-box;
		border: solid 1px gray;
		cursor: pointer;
		margin: 0px;
		padding: 10px 5px;
		font-size: 16pt;
		font-weight: bolder;
		width: 180px;
		text-align: center;
		color:black;
	}
	.secondInfo{
		display: inline-block;
		text-align: left;
		color:gray;
		font-size: 8pt;
		line-height: 20px;
	}
	
</style>
</head>
<body>
	<div class="footer" align="center">
		<div class="topFooter">
			<div class="firstInfo" align="left">
				<!-- <h3>고객행복센터</h3> -->
				<div class="cc_call">
					<h3>고객행복센터<br/><span class="tit">1644-1107</span></h3>
					<ul class="cc_list">
						<li>365고객 센터</li>
						<li>오전7시 ~ 오후7시</li>
					</ul>
				</div>
				<div class="cc_kakao">
					<h3><span>카카오톡 문의</span></h3>
					<ul class="cc_list">
						<li>365고객 센터</li>
						<li>오전7시 ~ 오후7시</li>
					</ul>
				</div>
				<div class="cc_qua">
					<h3><span onclick = "javascript:location.href='/ShoppingMall/service/serviceCenterMyQboardWrite.do'">1:1 문의</span></h3>
					<ul class="cc_list">
						<li>24시간 접수가능</li>
						<li>고객센터 운영시간에 순차적으로 답변드리겠습니다.</li>
					</ul>
				</div>
			</div>
			<div class="secondInfo">
				법인명(상호):주식화사 컬리 <span class="bar">I</span> 사업자 등록번호:261-81-00000<br/>
				통신판매업:제2018-서울강남-00000호 <span class="bar">I</span> 개인정보보호책임자:OOO<br/>
				주소:서울시 도선대로 16길 20, 이래빌딩 B1~4F <span class="bar">I</span> 대표이사: OOO<br/>
				팩스:070-7500-6098<span class="bar">I</span> 이메일:OOOOO@OOOO.com
			</div>
		</div>
	</div>
</body>
</html>