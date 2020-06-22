<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<<<<<<< HEAD
<%@ page import="java.util.List" %>
<%@ page import="java.util.Map" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%
	String ctxPath = request.getContextPath();
	Object obj = session.getAttribute("basket");
	List<Map<String,String>> basketNum = null;
	if(obj!=null){
		basketNum = (List<Map<String,String>>)obj;
	}
	 
	int n = 0;
	if(basketNum!=null) n = basketNum.size();
=======
<%
	String ctxPath = request.getContextPath();
>>>>>>> origin/sanga
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>header.jsp</title>
<style type="text/css">
	/*로고와 링크가 있는 영역*/
	.logo_login{
		width:1080px;
		margin: 10px auto;
		border:solid 0px black;
		background-color: white;
	}
	
	/*회원가입, 로그인 링크 영역*/
	.loginLink{
		float:right;
		margin-right: 50px;
	}
	
	
	.loginLink a{
		text-decoration: none;
		color: gray;
	}
	
	
	.loginLink a:hover{
		color: purple;
	}
	
	/*고객센터 영역*/
	.serviceCenter{
		position: relative;
	}
	
	.underIcon{
		font-size: 8pt;
		padding: 0px;
	}
	
	/*고객센터 하위의 메뉴영역*/
	.serviceCenter-dropdown-content{
		display:none;
		position: absolute;
		z-index: 5;
		min-width: 100px;
		background-color: white;
		border:solid 1px black;
	}
	
	/*고객센터 하위의 메뉴가 되는 ul*/
	.serviceCenter-categori{
		display:inline-block;
		list-style: none;
		padding: 0px;
		text-align: left;
		margin: 0px;
		float:left;
	}
	
	.serviceCenter-categori .listType{
		display: block;
		margin: 0px 10px;
		color:black;
		font-size: 8pt;
	}
	
	/*로고 이미지가 있는 영역*/
	.logo{
<<<<<<< HEAD
		width: 150px;
		
		clear:both;
	}
	
	.logo img{
		width: 110px;
		height: 100px;
	}
	
=======
		width: 300px;
		border:solid 1px gray;
		clear:both;
	}
	
>>>>>>> origin/sanga
	/*상단에 고정해야 하는 navigation이 있을 영역*/
	.header-navi{
		max-width:1700px;
		min-width:1080px;
		border:solid 0px black;
		margin: 0 auto;
		z-index: 4;
		background-color: white;
	}
	
	/*navigation이 되는 ul태그*/
	.header-naviList{
		list-style: none;
		border:solid 0px blue;
		margin-top: 10px;
		margin-bottom: 0;
	}
	
	.header-naviList > li{
		text-align: center;
		display: inline-block;
		border: solid 0px gray;
		
	}
	
	/*각각의 navigation을 구분하는 I(span태그)*/
	.bar{
		font-size: 8pt;
		color:gray;
		
	}
	
	/*navi에 들어가는 li태그 안의 영역(span)*/
	.navi-categori .listType, .header-naviList .listType {
		display: inline-block;
		margin: 0px 10px;
		font-weight: bold;
		color:black;
		font-size: 12pt;
		width: 150px;
		height: 30px;
	}
	
	.listType:hover{
		color:purple;
		text-decoration:underline;
		cursor: pointer;
	}
	
	/*navi에 들어가는 li태그에서 input태그가 있는 영역(span)*/
	.search{
		width: 200px;
	}
	
	/*navi에 들어가는 li태그에서 아이콘(장바구니)이 들어가 있을 영역(span)*/
	.icon{
		width: 120px;
	}
	
	
	/*전체 카테고리 li*/
	.navi-dropdown{
		position: relative;
	}
	
	/*전체 카테고리 하위의 navi영역*/
	.navi-dropdown-content{
		display:none;
		position: absolute;
		z-index: 5;
		min-width:170px;
		background-color: white;
		border:solid 1px black;
	}
	
	/*전체 카테고리 하위의 navi가 되는 ul*/
	.navi-categori{
		width:170px;
		display:inline-block;
		list-style: none;
		padding:0px;
		text-align: left;
		margin: 0px;
		float:left;
	}
	
	/*하위 navi가 되는 ul 두번째*/
	.navi-categori2{
		width:168px;
		display:none;
		list-style: none;
		padding:0px;
		text-align: left;
<<<<<<< HEAD
		background-color: #f1f1f1;
		min-height:150px; 
=======
		background-color: #f1f1f1; 
>>>>>>> origin/sanga
	}
	
	/*하위 navi에 들어가는 li*/
	.navi-categori > li {
		line-height: 30px;
	}
	
	.navi-categori2 > li{
		line-height: 30px;
	}
	
	/*상단 navi가 고정되도록 하는 css*/
	.scroll_fixed{
    	position: fixed;
    	top:0px;
    	
	}
	
	/*첫번째 하위 navi 안에 있는 li태그에 hover 했을 때 그 li태그의 배경색 변경*/
<<<<<<< HEAD
	/*.navi-categori .list:hover{background-color: #f1f1f1;}*/
	
	
	.navi-basket > img{
		width:40px;
		heigth:40px;
		cursor: pointer;
	}
	
	#basketCnt{
		position: absolute;
		top: -9px;
		left: 18px;
		border:solid 1px white;
		width: 20px;
		height: 20px;
		border-radius: 50%;
		background-color: purple;
		color:white;
		cursor: pointer;
	}
=======
	.navi-categori .list:hover{background-color: #f1f1f1;}
	
>>>>>>> origin/sanga
</style>

<script type="text/javascript">
	$(document).ready(function(){
		var $list = $(".list"); //하위 navi에 존재하는 li태그들 (배열)
<<<<<<< HEAD
		  
		// 하위 navi에 존재하는 li태그에 hover했을 때 function
		$(".navi-categori .list").hover(function(){ //마우스를 올렸을 때
			var other = $(this).siblings();
			$(".navi-dropdown-content").css("min-width","340px"); //하위 navi가 존재하는 영역의 넓이 300px로 조정
			$(".navi-categori2").css("display","inline-block"); //navi-categori 옆에 붙을 navi-categori2(ul)태그의 display변경
			$(this).css("background-color","#f1f1f1");
			other.css("background-color","white");
		},function(){ //마우스를 내렸을 때
			/* $(".navi-dropdown-content").css("min-width","170px"); //하위 navi가 존재하는 영역의 넓이 150px로 조정
			$(".navi-categori2").css("display","none"); //navi-categori2(ul)태그의 display none(안보이도록) */
=======
		
		// 하위 navi에 존재하는 li태그에 hover했을 때 function
		$(".list").hover(function(){ //마우스를 올렸을 때
			$(".navi-dropdown-content").css("min-width","340px"); //하위 navi가 존재하는 영역의 넓이 300px로 조정
			$(".navi-categori2").css("display","inline-block"); //navi-categori 옆에 붙을 navi-categori2(ul)태그의 display변경
			
		},function(){ //마우스를 내렸을 때
			$(".navi-dropdown-content").css("min-width","170px"); //하위 navi가 존재하는 영역의 넓이 150px로 조정
			$(".navi-categori2").css("display","none"); //navi-categori2(ul)태그의 display none(안보이도록)
>>>>>>> origin/sanga
		});
		
		
		// 전체카테고리 li태그에 hover했을 때 function
		$(".navi-dropdown").hover(function(){
			$(".navi-dropdown-content").css("display","block"); //하위 navi가 존재하는 영역 display 변경
		},function(){
			$(".navi-dropdown-content").css({"display":"none","min-width":"150px"}); //원래 있던대로 display와 width 수정
<<<<<<< HEAD
			$(".navi-categori2").css("display","none");
=======
>>>>>>> origin/sanga
		});
		
		// 고객센터 span태그에 hover했을 때 function
		$(".serviceCenter-dropdown").hover(function(){
			$(".serviceCenter-dropdown-content").css("display","block"); //하위 navi가 존재하는 영역 display 변경
		},function(){
			$(".serviceCenter-dropdown-content").css({"display":"none"}); //원래 있던대로 display와 width 수정
		});
		
		
		// === 상단 navi 스크롤 사용 시와 브라우저 가로 길이 변경했을 때 고정하도록 하는 내용 === //
		
		var naviPosition = $(".header-navi").offset(); //문서가 로딩 되었을 때 상단 navi가 위치하는 위치값을 변수에 대입
		
		//스크롤 이동할 때 실행되는 function
		$(window).scroll(function(){ 
			var width = $(".header-navi").css("width"); //스크롤을 움직였을 때 상단 navi의 width값 변수에 대입
			
			if($(document).scrollTop()>naviPosition.top){ //스크롤을 움직여 나온 top의 값이 실제 상단 navi의 top값 보다 클 경우(상단 navi가 화면에서 안보여질 때)
				$(".header-navi").addClass("scroll_fixed"); //상단 navi에 fix기능을 하는 css를 갖는 class(scroll_fixed) 를 추가
				$(".scroll_fixed").css("width",width); //기존에 있던 width그대로 고정
				
			}
			else{ //반대인 경우(상단 navi가 화면에 보여질 때)
				$(".header-navi").removeClass("scroll_fixed"); //fix기능을 하는 css를 갖는 class(scroll_fixed)제거
				$(".header-navi").removeAttr('style'); //고정으로 주고 있었던 css를 리셋
				
			}
		});
		
		// 브라우저의 가로길이에 변화가 있을 때 실행되는 function
		$(window).resize(function(){
			var width = $(".header").css("width"); //header(로고+링크)영역의 width값 변수에 대입
			$(".scroll_fixed").css("width",width); //해당 width값을 scroll_fixed(상단navi)클래스에 적용하는 css에 추가
		});
		
		
		// 전체 카테고리에서 서브 카테고리 변화주기 //
<<<<<<< HEAD
		var $category = $(".navi-categori").find(".listType");
=======
		 var $category = $(".navi-categori").find(".listType");
>>>>>>> origin/sanga
		$category.each(function(index, item){
			var sub = ["기본채소,쌈 샐러드,특수채소"
				      ,"국산과일,수입과일,냉동 건과일"
				      ,"생선류,오징어 낙지 문어,새우 게 랍스타"
				      ,"소고기,돼지고기,닭 오리고기"
				      ,"생수 음료 주스,커피 차,우유 두유 요거트"];
				
			$(item).mouseover(function(){
<<<<<<< HEAD
				var subArr = sub[index].split(",");
				for(var i=0; i<subArr.length; i++){
						 $(".navi-categori2").find(".listType:eq("+i+")").html(subArr[i]);
=======
				$(".navi-categori2").empty();
				var subArr = sub[index].split(",");
				for(var i=0; i<subArr.length; i++){
						// $(".navi-categori2").find(".listType:eq("+i+")").html(subArr[i]);
						var html="<li class='list'><span class='listType'>"+subArr[i]+"</span></li>";
						$(".navi-categori2").append(html);
>>>>>>> origin/sanga
					} 
			});
				
			
		}); 
		
	});
<<<<<<< HEAD
	
	function goBasket(){
		location.href="<%= ctxPath%>/shoppingBasket.do";
	}
	
	function goList(){
		location.href="<%= ctxPath%>/productList.do";
	}
=======
>>>>>>> origin/sanga
</script>
</head>
<body>
	
	<div class="logo_login" align="center">
		<div class="loginLink"> 
<<<<<<< HEAD
			<a href="javascript:location.href='<%=ctxPath%>/member/register.do'">회원가입</a> |
			 <c:if test="${sessionScope.userid == null }">
			 	 <a href="javascript:location.href='<%=ctxPath%>/member/login.do'">로그인</a> | 
			 </c:if>
			 <c:if test="${sessionScope.userid != null }">
			 	회원님 |
			 </c:if>
=======
			<a href="javascript:location.href='<%=ctxPath%>/member/register.do'">회원가입</a> | <a href="javascript:location.href='<%=ctxPath%>/member/login.do'">로그인</a> | 
>>>>>>> origin/sanga
			<div class="serviceCenter-dropdown" style="display:inline-block;">
				<a href="javascript:location.href='<%=ctxPath%>/service.do'">고객센터</a> <span class="underIcon">▼</span>
				<div class="serviceCenter-dropdown-content" align="left">
					<ul class="serviceCenter-categori">
						<li class="list"><a href="javascript:location.href='<%=ctxPath%>/service/board.do'"><span class="listType">공지사항</span></a></li>
						<li class="list"><a href="javascript:location.href='<%=ctxPath%>/service/FAQ.do'"><span class="listType">자주하는 질문</span></a></li>
						<li class="list"><a href="javascript:location.href='<%=ctxPath%>/service/MyQue.do'"><span class="listType">1:1문의</span></a></li>
					</ul>
				</div>
			</div>
		</div>
		<div class="logo">
			<a href="javascript:location.href='<%=ctxPath %>/index.do'"><img src="<%=ctxPath %>/images/logo.png" /> </a>
		</div>	
	</div>
	<div class="header-navi" align="center" >
		<ul class="header-naviList" style="border-bottom:solid 1px purple;">
			<li class="navi-dropdown">
				<span class="listType dropbtn">전체 카테고리</span>
				<span class="bar">I</span><br/>
				<div class="navi-dropdown-content" align="left">
					<ul class="navi-categori">
<<<<<<< HEAD
						<li class="list" onclick="goList()"><span class="listType">채소</span></li>
						<li class="list" onclick="goList()"><span class="listType">과일 견과 쌀</span></li>
						<li class="list" onclick="goList()"><span class="listType">수산 해산 건어물</span></li>
						<li class="list" onclick="goList()"><span class="listType">정육 계란</span></li>
						<li class="list" onclick="goList()"><span class="listType">음료 우유 간식</span></li>
					</ul>
					<ul class="navi-categori2">
						<li class="list" onclick="goList()"><span class="listType"></span></li>
						<li class="list" onclick="goList()"><span class="listType"></span></li>
						<li class="list" onclick="goList()"><span class="listType"></span></li>
					</ul> 
				</div>
			</li>
			<li><a><span class="listType" onclick="goList()">알뜰쇼핑</span></a><span class="bar">I</span></li>
			<li><a><span class="listType" onclick="goList()">신상품</span></a><span class="bar">I</span></li>
			<li><a><span class="listType" onclick="goList()">추천쇼핑</span></a></li>
			<li><span class="search"><input type="text" placeholder="test"/></span></li>
			<li>
				<span class="navi-basket" style="position:relative; ">
					<img src="<%=ctxPath %>/images/basket.jpg" onclick="goBasket()"/>
					<% if(n>0){ %>
					<div id="basketCnt" onclick="goBasket()">
					
						<%=n %>
					
					</div>
					<%} %>
				</span>
			</li>
=======
						<li class="list"><span class="listType">채소</span></li>
						<li class="list"><span class="listType">과일 견과 쌀</span></li>
						<li class="list"><span class="listType">수산 해산 건어물</span></li>
						<li class="list"><span class="listType">정육 계란</span></li>
						<li class="list"><span class="listType">음료 우유 간식</span></li>
					</ul>
					<ul class="navi-categori2">
						<li class="list"><span class="listType">채소6</span></li>
						<li class="list"><span class="listType">채소7</span></li>
						<li class="list"><span class="listType">채소8</span></li>
						<li class="list"><span class="listType">채소9</span></li>
						<li class="list"><span class="listType">채소10</span></li>
					</ul>
				</div>
			</li>
			<li><a><span class="listType">알뜰쇼핑</span></a><span class="bar">I</span></li>
			<li><a><span class="listType">신상품</span></a><span class="bar">I</span></li>
			<li><a><span class="listType">추천쇼핑</span></a></li>
			<li><span class="search"><input type="text" placeholder="test"/></span></li>
			<li><span class="">장바구니 아이콘</span></li>
>>>>>>> origin/sanga
		</ul>		
	</div>
</body>