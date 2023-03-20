<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<style>

	#adminMenu {
 		box-sizing: border-box;
 		height: 400px;
 		text-align: center;
 		padding: 20px;
	}
	
	#memberManageBtn {
		width: 200px;
		height: 75px;
		margin: auto;
	}
	
	.btn:hover {
		pointer: cursor;
	}
	
</style>
</head>
<body>
    
    <jsp:include page="../common/header.jsp" />

    <div class="content">
        <br><br>
        <div class="innerOuter">
            <h2>관리자페이지</h2>
            <br>
            <div id="adminMenu">
            	<button id="memberManageBtn" class="btn btn-primary btn-lg" onclick="location.href='memberList.me'">회원 관리</button>
            	<br><br>
            	<button id="memberManageBtn" class="btn btn-primary btn-lg" onclick="location.href='adminTotalList.bo'">게시판 관리</button>
            	<br><br>
            	<button id="memberManageBtn" class="btn btn-primary btn-lg" onclick="location.href='adminBoardList.bo'">게시글 관리(첫 번째 게시판)</button>
            </div>
            <br>
        </div>
        <br><br>
	</div>
</body>
</html>