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
	
	.header-navi{
		max-width:1700px;
		min-width:1080px;
		border:solid 0px black;
		margin: 0 auto;
		z-index: 4;
		background-color: white;
		
	}
	.header-naviList{
		list-style: none;
		border:solid 0px blue;
	}
	
	.header-naviList > li{
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
		color:black;
		font-size: 12pt;
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
	
	.navi-dropdown{
		position: relative;
	}
	
	.navi-dropdown-content{
		display:none;
		position: absolute;
		z-index: 5;
		min-width:150px;
		background-color: white;
		border:solid 1px black;
	}
	

	.navi-categori{
		width:149px;
		display:inline-block;
		list-style: none;
		padding:0px;
		text-align: left;
		margin: 0px;
		float:left;
	}
	
	.navi-categori2{
		width:149px;
		display:none;
		list-style: none;
		padding:0px;
		text-align: left;
		background-color: #f1f1f1;
	}
	
	.navi-categori > li, .navi-categori2 > li{
		line-height: 30px;
	}
	
	.scroll_fixed{
    	position: fixed;
    	top:0px;
    	
	}
	
	.navi-categori .list:hover{background-color: #f1f1f1;}
	.list:hover .navi-dropdown-content{display:inline-block;}
</style>

<script type="text/javascript">
	$(document).ready(function(){
		var $list = $(".list");
		
			$(".list").hover(function(){
				$(".navi-dropdown-content").css("min-width","300px");
				$(".navi-categori2").css("display","inline-block");
				$(".navi-categori").css("display","inline-block");
				
			},function(){
				
			});
		
		
		$(".navi-dropdown").hover(function(){
			$(".navi-dropdown-content").css("display","block");
		},function(){
			$(".navi-dropdown-content").css({"display":"none","min-width":"150px"});
			$(".navi-categori2").css("display","none");
		});
		
		
		var naviPosition = $(".header-navi").offset();
		$(window).scroll(function(){
			var width = $(".header-navi").css("width");
			if($(document).scrollTop()>naviPosition.top){
				$(".header-navi").addClass("scroll_fixed");
				$(".scroll_fixed").css("width",width);
				
			}
			else{
				$(".header-navi").removeClass("scroll_fixed");
				$(".header-navi").removeAttr('style');
				
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
	<div class="header-navi" align="center">
		<ul class="header-naviList" style="border-bottom:solid 1px green;">
			<li class="navi-dropdown">
				<span class="listType dropbtn">전체 카테고리</span>
				<span class="bar">I</span><br/>
				<div class="navi-dropdown-content" align="left">
					<ul class="navi-categori">
						<li class="list"><span class="listType">채소</span></li>
						<li class="list"><span class="listType">채소</span></li>
						<li class="list"><span class="listType">채소</span></li>
						<li class="list"><span class="listType">채소</span></li>
						<li class="list"><span class="listType">채소</span></li>
					</ul>
					<ul class="navi-categori2">
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