<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<% String ctxPath = request.getContextPath(); %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<link rel="stylesheet" href="<%= ctxPath %>/css/style.css" />
<title>managerMember.jsp</title>
<!-- 차트 링크 --> 
<script src="https://cdn.jsdelivr.net/npm/chart.js@2.8.0"></script> 
<style type="text/css">

	select{
		border-color : #949296;
	}
	
	.sideMenu{
		margin-top:10px;
		display: inline-block;
		width: 150px;
		float:left;
	}
	
	.memberList{
		display:inline-block;
		width:800px;
		margin-top: 10px;
	}
	
	.member-table{
		width: 100%;
		text-align: center;
	}
	
	.title{
		font-weight: bolder;
	}
	
	.member-search{
		display:inline-block;
		float: right;
		margin-bottom:8px;
	}
	
	.member-count{
		display : inline-block;
		margin:5px 0;
		font-weight: bolder;
 	}
	
	td.click{
		cursor: pointer;
	}
	
	.member_list_btn{
		background-color: #5F0080;
		color: #fff;
		padding:5px 10px;
		font-weight : normal;
		font-size: 9px;
	}
	
	.member_list_btn:hover{
		cursor:pointer;
	}
	

	
</style>
<!-- 부트스트랩 -->
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.1/css/bootstrap.min.css">
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
<script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.1/js/bootstrap.min.js"></script>
<script type="text/javascript" src="/ShoppingMall/js/jquery-3.3.1.min.js"></script>
<script type="text/javascript" src="/ShoppingMall/util/myutil.js"></script>
<script type="text/javascript">
	$(document).ready(function(){
		
		
		
		
		// 검색 상황 유지
	    if("${searchWord}" != "") {
		 	  $("#searchType").val("${searchType}");
	   		  $("#searchWord").val("${searchWord}");
	    }
		     
		
		// 검색 타입 바꿀 시에 검색어 비우기
		$("#searchType").bind("change", function(){
		  	  $("#searchWord").val("");  	  
		});
		     
		
		  
		// 페이지처리
		$("#sizePerPage").val("${sizePerPage}");	  
		  
		$("#sizePerPage").bind("change", function(){ // select 태그 이벤트는 click 아니고 change
		   	  
			  var frm = document.memberFrm;
			  
			  frm.method = "GET";
			  frm.action = "<%= ctxPath%>/manager/managerMemberList.do";
		 	  frm.submit();
		});
				  
		
		$("#searchWord").bind("keydown", function(event){
			  if(event.keyCode == 13) { //엔터
				  goSearch();
			  }
		});
		
		
		
		
		
		// 회원 상세 보기
		$("td.click").click(function(){
			var member_num = $(this).siblings(".member_num").text();
	        location.href="<%= ctxPath%>/manager/managerMemberDetail.do?member_num="+member_num;  
		})
		
		
		
		
		
		
	});
	
	

	
	 // 검색
	 function goSearch() {		  
		  var frm = document.memberFrm;
		  frm.method = "GET";
		  frm.action = "managerMemberList.do";
		  frm.submit(); 
		  
	  }
	 
	 
	 

	 // 전체 선택
	 var bool = true;
	 function allCheck(){			
		
		 for(var i=0; i<$(".member-table tr").length; i++){
			 $(".memberList_check").prop('checked',bool);
		 	 bool = !bool;
		 }
	 } 
 
	 
	 
	 
	 //삭제
	 function member_delete(){
		 
		var bCkecked = false; 
		$(".memberList_check").each(function(){
			if($(this).is(":checked")){
				bCkecked = true;
			};
		});
		
		if(bCkecked){
			 if (confirm("해당 회원을 삭제하시겠습니까?") == true){ //확인 누르면 전송
					var frm = document.manager_memberTableFrm;
					frm.method = "POST";
					frm.action = "managerMemberDelete.do";
					frm.submit();		
			}else{   //취소
			    return;
			}	 
			
		}
				
	};
	 
	 
	
</script>
</head>
<body>
	<div class="Mycontainer">
		<jsp:include page="../include/header.jsp"></jsp:include>
		<div class="section" align="center">
			<div class="contents">
				<div class="sideMenu">
					<jsp:include page="../include/managerSide.jsp"></jsp:include>
				</div>
				<div class="memberList" align="left">
					<div style="margin:10px 0;">
						<h3 style="margin:25px 0;">회원관리</h3>
					</div>
					<div style="width:100%">
						<form name="memberFrm">							
							<div class="member-count">
								
								<span>전체 회원 수 : 
									<c:if test="${empty searchWord}">
										${all}
									</c:if>
									<c:if test="${not empty searchWord}">
										${searchAll}
									</c:if>
								명</span>
							</div>
							<div class="member-search">
								<select id="searchType" name="searchType">
									<option value="name">회원명</option>
									<option value="userid">id</option>
									<option value="address">주소</option>
								</select>
								<input type="text" id="searchWord" name="searchWord" />
								<button type="button" onclick="goSearch();">검색</button>
								<select id="sizePerPage" name="sizePerPage">
									<option value="10">10</option>
									<option value="5">5</option>
									<option value="3">3</option>
								</select>
							</div>
						</form>
					</div>
					
					<form name="manager_memberTableFrm">
						<table class="table member-table" style="border-top:solid 2px purple;">
							<thead>
								<tr>
									<td class="title">선택</td>
									<td class="title">No.</td>
									<td class="title" style="width:15%">회원명</td>
									<td class="title" style="width:15%">id</td>
									<td class="title" style="width:40$">주소</td>
									<td class="title"style="width:20%">모바일</td>
								</tr>
							</thead>
							<tbody>
								<c:if test="${empty memberList}">	
										<tr>
											<td colspan="6"> 검색 설정에 맞는 회원이 없습니다. </td>
										</tr>	
								</c:if>
								<c:if test="${not empty memberList}">		
									<c:forEach var="mvo" items="${memberList}">
										<tr>
											<td><input type="checkbox" class="memberList_check" name="member_num" value="${mvo.member_num}" /></td>
											<td class="click member_num">${mvo.member_num}</td>
											<td class="click">${mvo.name}</td>
											<td class="click">${mvo.userid}</td>
											<c:if test="${empty mvo.address}">
												<td class="click board-title">설정 안 함</td>
											</c:if>
											<c:if test="${not empty mvo.address}">
												<td class="click board-title">${mvo.address}</td>
											</c:if>
											<td class="click">${mvo.mobile}</td>
										</tr>
									</c:forEach>	
								</c:if>
							</tbody>
						</table>
					</form>
					<div class="managerBtn" style="margin-bottom: 20px;">
						<span class="member_list_btn" id="btnAllCheck" onclick="allCheck();">전체선택</span>
						<span class="member_list_btn" style="float:right;"onclick="member_delete()">선택 탈퇴</span>
					</div>					
					<div align="center">
						${pageBar}
					</div>
				</div>
				<div style="clear:both;"></div>
				
			</div>
		</div>
		<jsp:include page="../include/footer.jsp"></jsp:include>
	</div>
</body>
</html>