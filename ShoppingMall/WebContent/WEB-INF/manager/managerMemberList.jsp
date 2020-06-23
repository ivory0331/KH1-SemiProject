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
	
	.member-search{
		width:100%;
		margin-bottom:5px;
	}
	
	.member-count{
		float: right;
	}
	
	.board-title{
		width: 400px;
	}
	
	.type{
		border:solid 1px purple;
		margin-left:10px;
		padding:10px 20px;
		color:purple;
	}
	
	.type:hover{
		cursor: pointer;
		background-color: purple;
		color:white;
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
		
	});
	
	
	<%-- 
	function func_pop(){
		window.name="parentFrm";
		var emailArr = "";
		$("input:checkbox").each(function(index, item){
			if() //체크된 것을 if구분
			{
				emailArr+=","
			}
		})
		sessionStorage.setItem("recieve",emailArr);
		console.log(sessionStorage.getItem("recieve"));
		var win = window.open("<%=ctxPath%>/manager/popup.do","childFrm","left=100px, top=100px, width=400px, height=350px");
	} --%>

	
	 // 검색
	 function goSearch() {		  
		  
		  var frm = document.memberFrm;
		  frm.method = "GET";
		  frm.action = "managerMemberList.do";
		  frm.submit();
		  
	  }
	 
	 

	 //삭제
	 function member_delete(){
		if (confirm("해당 회원을 삭제하시겠습니까?") == true){ //확인 누르면 전송
			var frm = document.manager_memberTableFrm;
			frm.method = "POST";
			frm.action = "managerMemberDelete.do";
			frm.submit();		
		}else{   //취소
		    return;
		}
	 } 
	 	 
		
	
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
					<div class="member-search">
						<h4>회원관리</h4>
						<form name="memberFrm">
							<select id="searchType" name="searchType">
								<option value="name">회원명</option>
								<option value="userid">id</option>
								<option value="address">주소</option>
							</select>
							<input type="text" id="searchWord" name="searchWord" />
							<button type="button" onclick="goSearch();" style="margin-right: 30px;">검색</button>
							
							<span style="color: red; font-weight: bold; font-size: 12pt;">페이지당 회원명수-</span>
							<select id="sizePerPage" name="sizePerPage">
								<option value="10">10</option>
								<option value="5">5</option>
								<option value="3">3</option>
							</select>
						</form>
						<span class="member-count">전체 회원 수 : ${memberList}</span>
					</div>
					<form name="manager_memberTableFrm">
						<table class="table member-table" style="border-top:solid 2px purple;">
							<thead>
								<tr>
									<th>선택</th>
									<th>No.</th>
									<th>회원명</th>
									<th>id</th>
									<th class="board-title">주소</th>
									<th>모바일</th>
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
											<td><input type="checkbox" name="member_num" value="${mvo.member_num}" /></td>
											<td>${mvo.member_num}</td>
											<td>${mvo.name}</td>
											<td>${mvo.userid}</td>
											<td class="board-title">${mvo.address}</td>
											<td>핸드폰번호</td>
										</tr>
									</c:forEach>	
								</c:if>
							</tbody>
						</table>
					</form>
					
					${pageBar}
					
				</div>
				<div style="clear:both;"></div>
				<div class="managerBtn" align="right">
					<span class="type" onclick="member_delete()">선택 탈퇴</span>
				</div>
				<div class="paging">
					
				</div>
			</div>
		</div>
		<jsp:include page="../include/footer.jsp"></jsp:include>
	</div>
</body>
</html>