<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>    
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>간단 게시판 과제</title>
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.4.1/jquery.min.js"></script>
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css">
<script src="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/js/bootstrap.min.js"></script>
<style>

    #boardList {text-align:center;}
    #boardList>tbody>tr:hover {cursor:pointer;}

    #pagingArea {width:fit-content; margin:auto;}
    
    #searchForm {
        width:80%;
        margin:auto;
    }
    #searchForm>* {
        float:left;
        margin:5px;
    }
    .select {width:20%;}
    .text {width:53%;}
    .searchBtn {width:20%;}
    
</style>
</head>
<body>

	<jsp:include page="../common/header.jsp" />
	
	    <div class="content">
        <br><br>
        <div class="innerOuter" style="padding:5% 10%;">
            <h2>공지사항</h2>
            <br>
            <!-- 관리자 로그인일 경우만 보여지는 글쓰기 버튼 -->
            <c:if test="${ loginUser.memberId eq 'admin' or loginUser.memberId eq 'subadmin' }">
            	<a class="btn btn-secondary" style="float:right;" href="enrollForm.sub">글쓰기</a>
            </c:if>
            <br>
            <br>
            <table id="boardList" class="table table-hover" align="center">
                <thead>
                    <tr>
                        <th style="width: 100px;">글번호</th>
                        <th style="width: 250px;">제목</th>
                        <th style="width: 250px;">작성자</th>
                        <th style="width: 100px;">조회수</th>
                        <th style="width: 100px;">작성일</th>
                    </tr>
                </thead>
                <tbody>
                	<c:forEach var="b" items="${ list }">
                		<tr>
	                        <td style="width: 100px;">${ b.subBoardNo }</td>
	                        <td style="width: 250px;">${ b.subBoardTitle }</td>
	                        <td style="width: 250px;">${ b.subBoardWriter }</td>
	                        <td style="width: 100px;">${ b.subBoardCount }</td>
	                        <td style="width: 100px;">${ b.subBoardDate }</td>
	                    </tr>
                	</c:forEach>
                </tbody>
            </table>
            <br>
            
			<!-- 클릭 시 해당 게시글 상세 조회 -->            
            <script>
            	$(function(){
            		$("#boardList>tbody>tr").click(function(){
            			
            			location.href = "detail.sub?subBno=" + $(this).children().eq(0).text();
            		});
            	});	
            </script>

			<!-- 페이징 -->
            <div id="pagingArea">
                <ul class="pagination">
                	
                	<c:choose>
                		<c:when test="${ cv.currentPage eq 1 }">
                			<li class="page-item disabled"><a class="page-link" href="#">&lt;</a></li>
                		</c:when>
                		<c:otherwise>
                			<li class="page-item"><a class="page-link" href="list.sub?cpage=${ cv.currentPage - 1 }&category=${ cv.category }&keyword=${ cv.keyword }">&lt;</a></li>
                		</c:otherwise>
                	</c:choose>
                
                    <c:forEach var="p" begin="${ cv.startPage }" end="${ cv.endPage }">
	                    <li class="page-item"><a class="page-link" href="list.sub?cpage=${ p }&category=${ cv.category }&keyword=${ cv.keyword }">${ p }</a></li>
                    </c:forEach>
                    
                    <c:choose>
                    	<c:when test="${ cv.currentPage eq cv.maxPage }">
                    		<li class="page-item disabled"><a class="page-link" href="#">&gt;</a></li>
                    	</c:when>
                    	<c:otherwise>
                			<li class="page-item"><a class="page-link" href="list.sub?cpage=${ cv.currentPage + 1 }&category=${ cv.category }&keyword=${ cv.keyword }">&gt;</a></li>
                		</c:otherwise>
                    </c:choose>
                    
                </ul>
            </div>

            <br clear="both"><br>

			<!-- 검색창 -->
            <form id="searchForm" action="list.sub" method="get" align="center">
                <div class="select">
                    <select class="custom-select" name="category">
                        <option value="subBoardTitle">제목</option>
                        <option value="subBoardContent">내용</option>
                    </select>
                    
                </div>
                <div class="text">
                    <input type="text" class="form-control" name="keyword" value="${ cv.keyword }">
                </div>
                <button type="submit" class="searchBtn btn btn-secondary">검색</button>
            </form>
            <br><br>
        </div>
        <br><br>

    </div>

	<jsp:include page="../common/footer.jsp" />

</body>
