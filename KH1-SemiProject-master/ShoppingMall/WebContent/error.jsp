<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" isErrorPage="true"%>
<%
	String ctxPath = request.getContextPath();
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>error.jsp</title>
<link rel="stylesheet" href="<%= ctxPath %>/css/style.css" />
<style type="text/css">
	
	.imgSelect {
    cursor: pointer;
}
.popupLayer {
    position: absolute;
    display: none;
    background-color: #ffffff;
    border: solid 2px #d0d0d0;
    width: 350px;
    height: 150px;
    padding: 10px;
}
.popupLayer div {
    position: absolute;
    top: 5px;
    right: 5px
}
	}
</style>
<!-- 부트스트랩 -->
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.1/css/bootstrap.min.css">
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
<script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.1/js/bootstrap.min.js"></script>
<script type="text/javascript" src="/ShoppingMall/util/myutil.js"></script>
<script type="text/javascript">

</script>
</head>
<body id="error">
	
	<!-- 클릭  -->
<p>
    <a class="Select">테스트</a>
    <a class="Select">테스트1</a>
    <a class="Select">테스트3</a>
</p>
<!-- 폼 레이어  -->
<div class="popupLayer">
    <div>
        <span onClick="closeLayer(this)" style="cursor:pointer;font-size:1.5em" title="닫기">X</span>
    </div>
    클릭하였을때 나오는곳</br>
</div>
<!-- //폼 레이어  -->
 
<p><br/></p>
<p><br/></p>


<script>
function closeLayer( obj ) {
    $(obj).parent().parent().hide();
}
 
$(function(){
 
    /* 클릭 클릭시 클릭을 클릭한 위치 근처에 레이어가 나타난다. */
    $('.Select').click(function(e)
    {
        var sWidth = window.innerWidth;
        var sHeight = window.innerHeight;
 
        var oWidth = $('.popupLayer').width();
        var oHeight = $('.popupLayer').height();
 
        // 레이어가 위치 셋팅
        var divLeft = e.clientX + 10;
        var divTop = e.clientY + 5;
 
        // 레이어가 화면 크기를 벗어나면 위치를 바꾸어 배치한다.
        if( divLeft + oWidth > sWidth ) divLeft -= oWidth;
        if( divTop + oHeight > sHeight ) divTop -= oHeight;
 
        // 레이어 위치를 바꾸었더니 상단기준점(0,0) 밖으로 벗어난다면 상단기준점(0,0)에 배치하자.
        if( divLeft < 0 ) divLeft = 0;
        if( divTop < 0 ) divTop = 0;
 
        $('.popupLayer').css({
            "top": divTop,
            "left": divLeft,
            "position": "absolute"
        }).show();
    });
 
});
 
</script>
	
		

</body>
</html>