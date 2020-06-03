<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>header.jsp</title>
<style type="text/css">
	.header{
		max-width:1700px;
		min-width:1080px;
		margin: 5px;
	}
	
	.logo_login{
		width:1080px;
		border:solid 0px black;
	}
	
	.loginLink{
		float:right;
	}
	
	.loginLink a{
		text-decoration: none;
		color: gray;
	}
	
	.loginLink a:hover{
		color: purple;
	}
	
	.logo{
		width: 300px;
		border:solid 1px gray;
		clear:both;
	}
	
	.navi{
		max-width:1700px;
		min-width:1080px;
		border:solid 0px black;
		margin: 0 auto;
		z-index: 4;
		background-color: white;
		
	}
	.naviList{
		list-style: none;
		border:solid 0px blue;
	}
	
	.subNaviList{
		list-style: none;
		border:solid 0px blue;
		padding: 0px;
		
	}
	
	.subNaviList > li{
		line-height: 40px;
	}
	
	.naviList > li{
		text-align: center;
		display: inline-block;
		border: solid 0px gray;
		
	}
	
	.bar{
		font-size: 8pt;
		color:gray;
		
	}
	
	.listType {
		display: inline-block;
		margin: 0px 10px;
		font-weight: bold;
	}
	
	.search{
		width: 200px;
	}
	
	.listType{
		width: 150px;
	}
	
	.icon{
		width: 120px;
	}
	
	.listType:hover{
		color:purple;
		text-decoration:underline;
		cursor: pointer;
	}
	
	.dropdown{
		position: relative;
	}
	
	.dropdown-content{
		display:none;
		position: absolute;
		z-index: 5;
		min-width:150px;
		background-color: white;
		border:solid 1px black;
	}
	

	.categori{
		width:150px;
		display:inline-block;
		list-style: none;
		padding:0px;
		text-align: left;
		margin: 0px;
		float:left;
	}
	
	.categori2{
		width:150px;
		display:none;
		list-style: none;
		padding:0px;
		text-align: left;
		background-color: #f1f1f1;
	}
	
	.categori > li, .categori2 > li{
		line-height: 30px;
	}
	
	.scroll_fixed{
    	position: fixed;
    	top:0px;
    	
	}
	
	.categori .list:hover{background-color: #f1f1f1;}
	.list:hover .dropdown-content{display:inline-block;}
</style>
<script type="text/javascript" src="/ShoppingMall/js/jquery-3.3.1.min.js"></script>
<script type="text/javascript" src="/ShoppingMall/util/myutil.js"></script>
<script type="text/javascript">
	$(document).ready(function(){
		var $list = $(".list");
		
			$(".list").hover(function(){
				console.log("하이");
				$(".dropdown-content").css("min-width","300px");
				$(".categori2").css("display","inline-block");
				
			},function(){
				
			});
		
		
		$(".dropdown").hover(function(){
			$(".dropdown-content").css("display","block");
		},function(){
			$(".dropdown-content").css({"display":"none","min-width":"150px"});
			$(".categori2").css("display","none");
		});
		
		
		var naviPosition = $(".navi").offset();
		$(window).scroll(function(){
			var width = $(".navi").css("width");
			console.log("scroll:"+width);
			if($(document).scrollTop()>naviPosition.top){
				$(".navi").addClass("scroll_fixed");
				$(".scroll_fixed").css("width",width);
				
			}
			else{
				$(".navi").removeClass("scroll_fixed");
				$(".navi").removeAttr('style');
				
			}
		});
		
		$(window).resize(function(){
			var width = $(".header").css("width");
			$(".scroll_fixed").css("width",width);
		});
	});
</script>
</head>
<body>
	<div class="header" align="center">
		<div class="logo_login">
			<div class="loginLink"> 
				<a href="#">회원가입</a> | <a href="#">로그인</a> | 
			</div>
			
			<div class="logo">
				<a href="index.jsp"><img src = "/ShoppingMall/include/images/logo.png" /></a>
			</div>
			
		</div>
	</div>
	<div class="navi" align="center">
		<ul class="naviList" style="border-bottom:solid 1px green;">
			<li class="dropdown">
				<span class="listType dropbtn">전체 카테고리</span>
				<span class="bar">I</span><br/>
				<div class="dropdown-content" align="left">
					<ul class="categori">
						<li class="list"><span class="listType">채소</span></li>
						<li class="list"><span class="listType">채소</span></li>
						<li class="list"><span class="listType">채소</span></li>
						<li class="list"><span class="listType">채소</span></li>
						<li class="list"><span class="listType">채소</span></li>
					</ul>
					<ul class="categori2">
						<li class="list"><span class="listType">채소</span></li>
						<li class="list"><span class="listType">채소</span></li>
						<li class="list"><span class="listType">채소</span></li>
						<li class="list"><span class="listType">채소</span></li>
						<li class="list"><span class="listType">채소</span></li>
					</ul>
				</div>
			</li>
			<li><a><span class="listType">알뜰쇼핑</span></a><span class="bar">I</span></li>
			<li><a><span class="listType">신상품</span></a><span class="bar">I</span></li>
			<li><a><span class="listType">추천쇼핑</span></a></li>
			<li><span class="search"><input type="text" placeholder="test"/></span></li>
			<li><span class="">장바구니 아이콘</span></li>
		</ul>		
	</div>
</body>