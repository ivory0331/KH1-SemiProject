<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.util.List" %>
<%@ page import="java.util.Map" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%
	String ctxPath = request.getContextPath();
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
	.serviceCenter, .mypage{
		position: relative;
	}
	
	.underIcon{
		font-size: 8pt;
		padding: 0px;
	}
	
	/*고객센터 하위의 메뉴영역*/
	.serviceCenter-dropdown-content, .mypage-dropdown-content{
		display:none;
		position: absolute;
		z-index: 5;
		min-width: 100px;
		background-color: white;
		border:solid 1px black;
	}
	
	/*고객센터 하위의 메뉴가 되는 ul*/
	.serviceCenter-categori, .mypage-categori{
		display:inline-block;
		list-style: none;
		padding: 0px;
		text-align: left;
		margin: 0px;
		float:left;
	}
	
	.serviceCenter-categori .listType, .mypage-categori .listType{
		display: block;
		margin: 0px 10px;
		color:black;
		font-size: 8pt;
	}
	
	/*로고 이미지가 있는 영역*/
	.logo{
		width: 150px;		
		clear:both;
	}
	
	.logo img{
		width: 110px;
		height: 100px;
	}
	
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
		background-color: #f1f1f1;
		min-height:150px; 
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
		display: none;
	}

	.navi-categori .list:hover{background-color: #f1f1f1;}
	input[name='searchWord']:focus{outline: none;}
</style>

<script type="text/javascript">


$(document).ready(function(){
	printNavi();
	var $list = $(".list"); //하위 navi에 존재하는 li태그들 (배열)

	// 하위 navi에 존재하는 li태그에 hover했을 때 function
	$(".navi-categori .list").hover(function(){ //마우스를 올렸을 때
		var other = $(this).siblings();
		$(".navi-dropdown-content").css("min-width","340px"); //하위 navi가 존재하는 영역의 넓이 300px로 조정
		$(".navi-categori2").css("display","inline-block"); //navi-categori 옆에 붙을 navi-categori2(ul)태그의 display변경
		$(this).css("background-color","#f1f1f1");
		other.css("background-color","white");
	},function(){ //마우스를 내렸을 때
		// $(".navi-dropdown-content").css("min-width","170px"); //하위 navi가 존재하는 영역의 넓이 150px로 조정
		// $(".navi-categori2").css("display","none"); //navi-categori2(ul)태그의 display none(안보이도록) 
		
	});
	
	
	// 전체카테고리 li태그에 hover했을 때 function
	$(".navi-dropdown").hover(function(){
		$(".navi-dropdown-content").css("display","block"); //하위 navi가 존재하는 영역 display 변경
		$(".navi-category .lit").css("background-color","white");	
	},function(){
		 $(".navi-dropdown-content").css({"display":"none","min-width":"150px"}); //원래 있던대로 display와 width 수정
		 $(".navi-categori2").css("display","none");
	});
	
	
	// 고객센터 span태그에 hover했을 때 function
	$(".serviceCenter-dropdown").hover(function(){
		$(".serviceCenter-dropdown-content").css("display","block"); //하위 navi가 존재하는 영역 display 변경
	},function(){
		$(".serviceCenter-dropdown-content").css({"display":"none"}); //원래 있던대로 display와 width 수정
	});
	
	// 회원된 span태그에 hover했을 때 function
	$(".mypage-dropdown").hover(function(){
		$(".mypage-dropdown-content").css("display","block"); //하위 navi가 존재하는 영역 display 변경
	},function(){
		$(".mypage-dropdown-content").css({"display":"none"}); //원래 있던대로 display와 width 수정
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
	var $category = $(".navi-categori").find(".list");
	$category.each(function(index, item){
		var idx = index	
		$(item).mouseover(function(){
			console.log(idx);
			subArr = [{"num":11,"content":"기본채소"},{"num":12,"content":"쌈 샐러드"},{"num":13,"content":"특수채소"},
				      {"num":21,"content":"국산과일"},{"num":21,"content":"수입과일"},{"num":21,"content":"냉동 건과일"},
				      {"num":31,"content":"생선류"},{"num":32,"content":"오징어 낙지 문어"},{"num":33,"content":"새우 게 랍스타"},
				      {"num":41,"content":"소고기"},{"num":42,"content":"돼지고기"},{"num":43,"content":"닭 오리고기"},
				      {"num":51,"content":"생수 음료 주스"},{"num":52,"content":"커피 차"},{"num":53,"content":"우유 두유 요거트"}];

			$(".navi-categori2").empty();
			
			for(var i=0; i<subArr.length; i++){
				if(parseInt(subArr[i].num/10)==(idx+1)){
					// $(".navi-categori2").find(".listType:eq("+i+")").html(subArr[i]);
					var html="<li class='list'><span class='listType' onclick='goList("+subArr[i].num+")'>"+subArr[i].content+"</span></li>";
					$(".navi-categori2").append(html); 
				}	
			}	
		});
	
	});
	
	
	if(${sessionScope.loginuser!=null}){
		func_basketCnt();
	}
	
	$("input[name='productSearchWord']").bind("keyup",function(event){
		if(event.keyCode==13){
			searchList();
		}
	})
	
});
	
	function goBasket(){
    	location.href="<%= ctxPath%>/product/basketList.do";
 	}
	
	
	
	function che(){
		$("input:checkbox").each(function(index, item){
			
			if($(item).prop("checked")){
				html+=$(item).val()+","	
			}
		})
	}
	
	
	
	function printNavi(){
		$.ajax({
			url:"<%=ctxPath%>/naviCategoryCall.do",
			dataType:"JSON",
			success:function(json){
				console.log(json);
				
				var cnt=0;
				 for(var i=0; i<5; i++){
					$(".categoryValue:eq("+i+")").html("<span class='listType' onclick='goList("+json[i].num+")'>"+json[i].content+"</span>");
				 }
				 
			},
			error:function(e){
				console.log(e);
			}
		});
	}
	
	function func_basketCnt(){
		$.ajax({
			url:"<%=ctxPath%>/basketCnt.do",
			dataType:"JSON",
			success:function(json){
				console.log("ajax:"+json.basketCnt);
				if(json.basketCnt>0){
					$("#basketCnt").show();
					$("#basketCnt").text(json.basketCnt);
				}
				
			},
			error:function(e){
				console.log(e);
			}
		});
	}
	
	function logout(){
		$.ajax({
			url:"<%=ctxPath%>/member/logout.do",
			dataType:"JSON",
			success:function(json){
				if(json.check=="true"){
					location.reload(true);
				}
				else{
					alert("로그아웃에 실패했습니다.");
				}
			},
			error:function(e){
				console.log(e);
			}
		});
	}

	function goList(num){
		var category = 0;
		var subcategory = 0;
		if(num>10){
			category = parseInt(Number(num)/10);
			subcategory = Number(num);
			location.href="<%= ctxPath%>/product/productList.do?fk_category_num="+category+"&fk_subcategory_num="+subcategory;
			
		}
		else{
			category = Number(num);
			location.href="<%= ctxPath%>/product/productList.do?fk_category_num="+category;
		}
		
	}
	
	 function searchList(){
		var productSearchWord = $("input[name='productSearchWord']").val();
		if(productSearchWord.trim().length<1){
			alert("검색할 단어를 최소 1글자 이상 입력해야 합니다.");
			return;
		}
		
		location.href="<%=ctxPath%>/searchList.do?productSearchWord="+productSearchWord;
	}

</script>
</head>
<body>
	<div class="logo_login" align="center">
		<div class="loginLink">
			 <c:if test="${sessionScope.loginuser == null }">
			 	 <a href="javascript:location.href='<%=ctxPath%>/member/register.do'">회원가입</a> |
			 	 <a href="javascript:location.href='<%=ctxPath%>/member/login.do'">로그인</a> | 
			 </c:if>
			 <c:if test="${sessionScope.loginuser != null }">
			 	<div class="mypage-dropdown" style="display:inline-block;">
				<a href="">${sessionScope.loginuser.name}님 환영합니다.</a> <span class="underIcon">▼</span>
				<div class="mypage-dropdown-content" align="left">
					<ul class="mypage-categori">
						<c:if test="${sessionScope.loginuser.status=='2'}">
							<li class="list"><a href="javascript:location.href='<%=ctxPath%>/service/board.do'"><span class="listType">매출관리</span></a></li>
							<li class="list"><a href="javascript:location.href='<%=ctxPath%>/manager/managerMemberList.do'"><span class="listType">회원관리</span></a></li>
							<li class="list"><a href="javascript:location.href='<%=ctxPath%>/manager/managerProductList.do'"><span class="listType">상품관리</span></a></li>
							<li class="list"><a href="javascript:location.href='<%=ctxPath%>/manager/managerMemberList.do'"><span class="listType">주문관리</span></a></li>
							<li class="list"><a href="javascript:logout()"><span class="listType">로그아웃</span></a></li>
						</c:if>
						<c:if test="${sessionScope.loginuser.status=='1'}">
							<li class="list"><a href="javascript:location.href='<%=ctxPath%>/member/myPageOrderHistory.do'"><span class="listType">주문내역</span></a></li>
							<li class="list"><a href="javascript:location.href='<%=ctxPath%>/member/myPageProductPossibleReview.do'"><span class="listType">상품 후기</span></a></li>
							<li class="list"><a href="javascript:location.href='<%=ctxPath%>/member/myPageMyInfoUpdatePW.do'"><span class="listType">개인정보 수정</span></a></li>
							<li class="list"><a href="javascript:logout()"><span class="listType">로그아웃</span></a></li>
						</c:if>
					</ul>
				</div>
				</div>
			 </c:if>
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
						<li class="list categoryValue" ><span class="listType">채소</span></li>
						<li class="list categoryValue" ><span class="listType">과일 견과 쌀</span></li>
						<li class="list categoryValue" ><span class="listType">수산 해산 건어물</span></li>
						<li class="list categoryValue" ><span class="listType">정육 계란</span></li>
						<li class="list categoryValue" ><span class="listType">음료 우유 간식</span></li>
					</ul>
					<ul class="navi-categori2">
						<li class="list categoryValue" ><span class="listType"></span></li>
						<li class="list categoryValue" ><span class="listType"></span></li>
						<li class="list categoryValue" ><span class="listType"></span></li>
					</ul> 
				</div>
			</li>
			<li><a href="javascript:location.href='<%=ctxPath%>/product/saleProduct.do'"><span class="listType">알뜰쇼핑</span></a><span class="bar">I</span></li>
			<li><a href="javascript:location.href='<%=ctxPath%>/product/newProduct.do'"><span class="listType">신상품</span></a><span class="bar">I</span></li>
			<li><a><span class="listType" onclick="goList()">추천쇼핑</span></a></li>
			<li style="border:solid 1px gray; border-radius: 15px; padding:5px;">
				<c:if test = "${not empty productSearchWord}">
					<input type="text" placeholder="검색" style="border:none;" name="productSearchWord" value="${productSearchWord}"/>
				</c:if>
				<c:if test = "${empty productSearchWord}">
					<input type="text" placeholder="검색" style="border:none;" name="productSearchWord" />
				</c:if>
			<img src="<%=ctxPath %>/images/search.png" onclick="searchList()" style="display:inline-block; width:20px; height:20px; cursor: pointer"/></li>
			<li>
				<span class="navi-basket" style="position:relative; ">
					<img src="<%=ctxPath %>/images/basket.jpg" onclick="goBasket()"/>
					
					<div id="basketCnt" onclick="goBasket()"></div>
					
				</span>
			</li>
		</ul>		
	</div>
</body>