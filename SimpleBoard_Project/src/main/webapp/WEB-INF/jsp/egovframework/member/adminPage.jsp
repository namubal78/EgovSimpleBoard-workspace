<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>간단 게시판 과제</title>
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
		cursor: pointer;
	}
	
</style>
</head>
<body>
    
    <jsp:include page="../common/header.jsp" />

    <div class="content">
        <br><br>
        <div class="innerOuter">
            <h2>관리자 페이지</h2>
            <br>
            
            <c:choose>
            	<c:when test="${ loginUser.memberType eq 1 }">
            		<div id="adminMenu">
		            	<button id="memberManageBtn" class="btn btn-primary btn-lg" onclick="location.href='memberList.me'">회원 관리</button>
		            	<br><br>
		            	<button id="memberManageBtn" class="btn btn-primary btn-lg" onclick="location.href='adminBoardListPage.co'">게시판 관리</button>
		            	<br><br>
		            	<button id="memberManageBtn" class="btn btn-primary btn-lg" onclick="location.href='adminBoardList.bo'">게시글 관리</button>
		            </div>
		    	</c:when>
		    	<c:when test="${ loginUser.memberType eq 2 }">
            		<div id="subAdminMenu">
		            	<button id="memberManageBtn" class="btn btn-primary btn-lg" onclick="location.href='adminBoardList.bo'">게시글 관리</button>
		            </div>
		    	</c:when>
            	<c:otherwise>
            	</c:otherwise>
            </c:choose>
            
            <br>
        </div>
        <br><br>
	</div>
	
	<jsp:include page="../common/footer.jsp" />

</body>
</html>