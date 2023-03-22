<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>간단 게시판 과제</title>

<!-- Alertify 라이브러리 -->
<!-- JavaScript -->
<script src="//cdn.jsdelivr.net/npm/alertifyjs@1.13.1/build/alertify.min.js"></script>

<!-- CSS -->
<link rel="stylesheet" href="//cdn.jsdelivr.net/npm/alertifyjs@1.13.1/build/css/alertify.min.css"/>
<!-- Default theme -->
<link rel="stylesheet" href="//cdn.jsdelivr.net/npm/alertifyjs@1.13.1/build/css/themes/default.min.css"/>
<!-- Semantic UI theme -->
<link rel="stylesheet" href="//cdn.jsdelivr.net/npm/alertifyjs@1.13.1/build/css/themes/semantic.min.css"/>
<!-- Bootstrap theme -->
<link rel="stylesheet" href="//cdn.jsdelivr.net/npm/alertifyjs@1.13.1/build/css/themes/bootstrap.min.css"/>


<!-- jQuery 라이브러리 -->
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.4.1/jquery.min.js"></script>
<!-- 부트스트랩에서 제공하고 있는 스타일 -->
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css">
<!-- 부트스트랩에서 제공하고 있는 스크립트 -->
<script src="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/js/bootstrap.min.js"></script>
<style>
	div {box-sizing:border-box;}
	#header {
	    width:80%;
	    height:100px;
	    padding-top:20px;
	    margin:auto;
	}
	#header>div {width:100%; margin-bottom:10px;}
	#header_1 {height:40%;}
	#header_2 {height:60%;}
	
	#header_1>div{
	    height:100%;
	    float:left;
	}
	#header_1_left {width:30%; position:relative;}
	#header_1_center {width:40%;}
	#header_1_right {width:30%;}
	
	#header_1_left>img {height:80%; position:absolute; margin:auto; top:0px; bottom:0px; right:0px; left:0px;}
	#header_1_right {text-align:center; line-height:35px; font-size:12px; text-indent:35px;}
	#header_1_right>a {margin:5px;}
	#header_1_right>a:hover {cursor:pointer;}
	
	#header_2>ul {width:100%; height:100%; list-style-type:none; margin:auto; padding:0;}
	#header_2>ul>li {float:left; width:25%; height:100%; line-height:55px; text-align:center;}
	#header_2>ul>li a {text-decoration:none; color:black; font-size:18px; font-weight:900;}
	
	#header_2 {border-top:1px solid lightgray;}
	
	#header a {text-decoration:none; color:black;}
	
	/* 세부페이지마다 공통적으로 유지할 style */
	.content {
	    background-color:rgb(247, 245, 245);
	    width:80%;
	    margin:auto;
	}
	.innerOuter {
	    border:1px solid lightgray;
	    width:80%;
	    margin:auto;
	    padding:5% 10%;
	    background-color:white;
	}

</style>
</head>
<body>

	<c:if test="${ not empty alertMsg }">
		<script>
			// alert("${ alertMsg }");
			alertify.alert("서비스 성공", "${ alertMsg }");
		</script>
		<c:remove var="alertMsg" scope="session" />
	</c:if>

	<div id="header">
        <div id="header_1">
            <div id="header_1_left">
            	<a href="/">
                	<img src="images/logo-dark.png" alt="logo">
                </a>
            </div>
            <div id="header_1_center"></div>
            <div id="header_1_right">
            
            	<c:choose>
            		<c:when test="${ empty loginUser }">
	            		<!-- 로그인 전 -->
		                <a href="enrollForm.me">회원가입</a>
		                <a data-toggle="modal" data-target="#loginModal">로그인</a>
            		</c:when>
	            	<c:otherwise>
	            		<!-- 로그인 후 -->
	                    <label>${ loginUser.memberName }님 환영합니다</label> &nbsp;&nbsp;
	                    	<c:choose>
	                    		<c:when test="${ loginUser.memberId eq 'admin' or loginUser.memberId eq 'subadmin'}">
	                    			<a href="adminPage.me">관리자페이지</a>
	                    		</c:when>
	                    		<c:otherwise>
	                    			<a href="myPage.me">마이페이지</a>
	                    		</c:otherwise>
	                    	</c:choose>
	                    <a href="logout.me">로그아웃</a>
	            	</c:otherwise>
            	</c:choose>
              
            </div>
        </div>
        <div id="header_2">
            <ul>
<!--                 <li><a href="list.sub">공지사항</a></li> -->
<!--                 <li><a href="list.bo">자유게시판</a></li> -->
            </ul>
        </div>

		<script>
			$(function() {
				
				selectBoardList();
			});
			
			function selectBoardList() {
				
				$.ajax({
					url: "boardList.co",
					success: function(result) {
						
						var resultStr = "";
						
						for(var i = 0; i < result.length; i++) {
							
							resultStr += "<li><a href='" + result[i].boardPath 
										+ "'>" + result[i].boardName + "</a></li>";
						}
						
						$("#header_2>ul").html(resultStr);
						
					},
					error: function() {
						console.log("게시판리스트 조회용 ajax 통신 실패!");
					}
				});
			}
		
		</script>

    </div>

    <!-- 로그인 클릭 시 뜨는 모달 (기존에는 안보이다가 위의 a 클릭 시 보임) -->
    <div class="modal fade" id="loginModal">
        <div class="modal-dialog modal-sm">
            <div class="modal-content">
                <!-- Modal Header -->
                <div class="modal-header">
                    <h4 class="modal-title">로그인</h4>
                    <button type="button" class="close" data-dismiss="modal">&times;</button>
                </div>
        
                <form action="login.me" method="post">
                    <!-- Modal body -->
                    <div class="modal-body">
                        <label for="memberId" class="mr-sm-2">아이디 : </label>
                        <input type="text" class="form-control mb-2 mr-sm-2" placeholder="아이디를 입력하세요." id="memberId" name="memberId" value="${ cookie.saveId.value }" required> <br>
                        <label for="userPwd" class="mr-sm-2">비밀번호 : </label>
                        <input type="password" class="form-control mb-2 mr-sm-2" placeholder="비밀번호를 입력하세요." id="memberPwd" name="memberPwd" required>
                        <br>
                        
                        <c:choose>
                        	<c:when test="${ not empty cookie.saveId }">
                        		<!-- 만약 saveId 쿠키가 있다면 : 체크박스가 체크되게끔 -->
                        		<input type="checkbox" id="saveId" name="saveId" value="y" checked><label for="saveId">&nbsp;아이디 저장</label>
                        	</c:when>
                        	<c:otherwise>
                        		<!-- 만약 saveId 쿠키가 없다면 : 체크박스가 체크되지 않게끔 -->
                        		<input type="checkbox" id="saveId" name="saveId" value="y" ><label for="saveId">&nbsp;아이디 저장</label>
                        	</c:otherwise>
                        </c:choose>
                    </div>
                    <!-- Modal footer -->
                    <div class="modal-footer">
                        <button type="submit" class="btn btn-primary">로그인</button>
                        <button type="button" class="btn btn-danger" data-dismiss="modal">취소</button>
                    </div>
                </form>
            </div>
        </div>

    </div>
    
    <br clear="both">

</body>
</html>