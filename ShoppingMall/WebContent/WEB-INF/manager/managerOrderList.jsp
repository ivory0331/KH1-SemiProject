<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<% String ctxPath = request.getContextPath(); %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<link rel="stylesheet" href="<%= ctxPath %>/css/style.css" />
<title>managerOrderList.jsp</title>
<!-- 차트 링크 --> 
<script src="https://cdn.jsdelivr.net/npm/chart.js@2.8.0"></script> 
<style type="text/css">
	.sideMenu{
		margin-top:10px;
		display: inline-block;
		width: 150px;
		float:left;
	}
	.orderList{
		display:inline-block;
		width:800px;
		margin-top: 10px;
	}
	
	.order-table{
		width: 100%;
		text-align: center;
	}
	
	.member-search{
		width:100%;
		margin-bottom:5px;
	}
	
	.goods-add{
		float: right;
		margin-bottom:5px;
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
	
	.userBtn > span{
		display: inline-block;
		text-align: center;
		padding : 10px 0;
		margin-right:5px;
		width:80px;
		border: solid 1px purple;
		background-color: #f1f1f1;
		color: purple;
		font-size: 10pt;
		cursor: pointer;
		
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
		$("select#orderState").bind("change",function(){
			goOrderSelect();
		});
		
		$("option[value='${searchType}']").prop("selected",true);
		
		$("#searchWord").bind("keydown", function(event){
			  if(event.keyCode == 13) { //엔터
				  goSearch();
			  }
		});
	});
	
	function goOrderSelect(){
		var frm = document.orderFrm;
		frm.action="<%=ctxPath%>/manager/managerOrderList.do";
		frm.method="get";
		frm.submit();
	}
	
	function goSearch(){
		
		if($("#searchWord").val().trim().length < 1){
			  alert("최소 한 글자는 입력해야 합니다.");
			  return false;
		  }
		
		var frm = document.orderFrm;
		frm.action="<%=ctxPath%>/manager/managerOrderList.do";
		frm.method="get";
		frm.submit();
	}
	
	function goChange(num){
		var state = "";
		$("input:checkbox[name='state']:checked").each(function(index, item){
			
			state += item.value+",";
			
		});
		
		if(state.trim()==""){
			alert("상태를 변경할 주문을 선택해주세요");
			return false;
		}
		
		 $.ajax({
			url:"<%=ctxPath%>/manager/managerOrderStateChange.do",
			data:{"value":num, "state":state},
			dataType:"JSON",
			success:function(json){
				alert(json);
				goOrderSelect();
			},
			error:function(e){
				alert(e);
			}
		}); 
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
				<div class="orderList" align="left">
				<form name="orderFrm">
					<div class="member-search">
						<h4>주문관리</h4>
						검색 : <input type="text" name="searchWord" id="searchWord" value="${searchWord}" />
						<select name="searchType" id="searchType" >
							<option value="name">주문자</option>
							<option value="order_num">주문번호</option>
							<option value="recipient_address">주소</option>
						</select>
						
						
						<select id="orderState" name="orderState" style="float:right;">
							<option value="0">==배송상태==</option>
							<c:forEach var="state" items="${stateList}">
								<c:if test="${state.num == orderState}">
									<option value="${state.num}" selected>${state.state}</option>
								</c:if>
								<c:if test="${state.num != orderState}">
									<option value="${state.num}">${state.state}</option>
								</c:if>
							</c:forEach>
						</select>
					</div>
					<div style="clear:both;"></div>
					<table class="table order-table" style="border-top:solid 2px purple;">
						<tr>
							<td>선택</td>
							<td>주문번호</td>
							<td>주문자</td>
							<td>배송주소</td>
							<td>금액</td>
							<td>주문상태</td>
						</tr>
						<c:if test="${empty orderList}">	
							<tr>
								<td colspan="6"> 검색한 내용에 해당하는 글이 없습니다. </td>
							</tr>	
						</c:if>
						<c:if test="${not empty orderList}">		
							<c:forEach var="order" items="${orderList}">
									<tr id="order${order.order_num}">
										<td><input type="checkbox" name="state" value="${order.order_num}" /></td>
										<td>${order.order_num}</td>
										<td>${order.member.name}</td>
										<td>${order.recipient_address}</td>
										<td>${order.price}</td>
										<td>${order.order_state}</td>
									</tr>
							</c:forEach>	
						</c:if>
					</table>
					
					<div class="paging" align="center">
						${pageBar}
					</div>
					<div class="userBtn" align="right">
						<span onclick = "goChange('1')">상품출하</span><span onclick = "goChange('1')">배송중</span><span onclick = "goChange('1')">배송완료</span>
					</div>
					</form>
				</div>
				<div style="clear:both;"></div>
				
			</div>
		</div>
		<jsp:include page="../include/footer.jsp"></jsp:include>
	</div>
</body>
</html>