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
            <h2>자유게시판</h2>
            <br>
            
            <!-- 검색 키워드 및 결과 -->
            <c:choose> 
           		<c:when test="${ empty cv.keyword }">
           			<br>
           		</c:when>
           		<c:otherwise>
           			<c:choose>
           				<c:when test="${ cv.category eq 'boardTitle' }">
           					<p><span style="color: #78C2AD; font-weight: bold;">제목</span>에 대한 검색어 <span style="color: #78C2AD; font-weight: bold;">${ cv.keyword }</span>에 대한 결과 <span style="color: #78C2AD; font-weight: bold;">${ cv.listCount }</span>건 입니다.</p>
           				</c:when>
           				<c:when test="${ cv.category eq 'boardContent' }">
           					<p><span style="color: #78C2AD; font-weight: bold;">내용</span>에 대한 검색어 <span style="color: #78C2AD; font-weight: bold;">${ cv.keyword }</span>에 대한 결과  <span style="color: #78C2AD; font-weight: bold;">${ cv.listCount }</span>건 입니다.</p>
           				</c:when>
           				<c:when test="${ cv.category eq 'boardWriter' }">
           					<p><span style="color: #78C2AD; font-weight: bold;">작성자</span>에 대한 검색어 <span style="color: #78C2AD; font-weight: bold;">${ cv.keyword }</span>에 대한 결과  <span style="color: #78C2AD; font-weight: bold;">${ cv.listCount }</span>건 입니다.</p>
           				</c:when>           				           				
           			</c:choose>
           		</c:otherwise>
            </c:choose>
            
            <!-- 로그인 후 상태일 경우만 보여지는 글쓰기 버튼 -->
            <c:if test="${ not empty loginUser }">
            	<a class="btn btn-secondary" style="float:right;" href="enrollForm.bo">글쓰기</a>
            </c:if>
            <br>
            <br>
            <table id="boardList" class="table table-hover" align="center">
                <thead>
                    <tr>
                        <th style="width: 100px;">글번호</th>
                        <th style="width: 400px;">제목</th>
                        <th style="width: 100px;">작성자</th>
                        <th style="width: 100px;">조회수</th>
                        <th style="width: 100px;">작성일</th>
                    </tr>
                </thead>
                <tbody>
                	<c:forEach var="b" items="${ list }">
                		<tr>
	                        <td style="width: 100px;">${ b.boardNo }</td>
	                        <td style="width: 400px;" align="left"><span id="titleSpan">${ b.boardTitle }</span></td>
	                        <td style="width: 100px;"><span id="writerSpan">${ b.boardWriter }</span></td>
	                        <td style="width: 100px;">${ b.boardCount }</td>
	                        <td style="width: 100px;">${ b.boardDate }</td>
	                    </tr>
                	</c:forEach>
                </tbody>
            </table>
            <br>
            
            <!-- 클릭시 게시글 상세 조회 -->
            <script>
            	$(function(){
            		$("#boardList>tbody>tr").click(function(){
            			
            			location.href = "detail.bo?bno=" + $(this).children().eq(0).text();
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
                			<li class="page-item"><a class="page-link" href="list.bo?cpage=${ cv.currentPage - 1 }&category=${ cv.category }&keyword=${ cv.keyword }">&lt;</a></li>
                		</c:otherwise>
                	</c:choose>
                
                    <c:forEach var="p" begin="${ cv.startPage }" end="${ cv.endPage }">
                    	<c:if test="${ p eq cv.currentPage }">
                    		<li class="page-item"><a class="page-link" href="list.bo?cpage=${ p }&category=${ cv.category }&keyword=${ cv.keyword }"><span style="font-weight: bold;">${ p }</span></a></li>
                    	</c:if>
                    	<c:if test="${ p ne cv.currentPage }">
                    		<li class="page-item"><a class="page-link" href="list.bo?cpage=${ p }&category=${ cv.category }&keyword=${ cv.keyword }">${ p }</a></li>
                    	</c:if>
                    </c:forEach>
                    
                    <c:choose>
                    	<c:when test="${ cv.currentPage eq cv.maxPage }">
                    		<li class="page-item disabled"><a class="page-link" href="#">&gt;</a></li>
                    	</c:when>
                    	<c:otherwise>
                			<li class="page-item"><a class="page-link" href="list.bo?cpage=${ cv.currentPage + 1 }&category=${ cv.category }&keyword=${ cv.keyword }">&gt;</a></li>
                		</c:otherwise>
                    </c:choose>
                    
                </ul>
            </div>

            <br clear="both"><br>

			<!-- 검색창 -->
            <form id="searchForm" action="list.bo" method="get" align="center">
                <div class="select">
                    <select class="custom-select" name="category">
                        <option value="boardTitle">제목</option>
                        <option value="boardContent">내용</option>
                        <option value="boardWriter">작성자</option>
                    </select>
                </div>
                <div class="text">
                    <input type="text" class="form-control" name="keyword" value="${ cv.keyword }">
                </div>
                <button type="submit" class="searchBtn btn btn-secondary">검색</button>
            </form>
            
            <script>
            
            $(document).ready(function() {

            	let category = "${cv.category}";  // 검색 카테고리 변수에 담기
                let keyword = "${cv.keyword}"; // 검색 키워드 변수에 담기

                // 검색 카테고리 유지 함수
            	if(category == "boardTitle") {  // 카테고리가 제목
					$("option[value='boardTitle']").attr("selected", true); // 해당 카테고리 option 에 selected 속성 부여
            	} else if(category == 'boardContent') { // 카테고리가 내용
					$("option[value='boardContent']").attr("selected", true); // 해당 카테고리 option 에 selected 속성 부여
            	} else if(category == 'boardWriter') { // 카테고리가 작성자
					$("option[value='boardWriter']").attr("selected", true); // 해당 카테고리 option 에 selected 속성 부여
            	}
            	
            	// 검색 키워드 색깔 처리
            	if(keyword != "" && category == 'boardTitle') { // 제목 카테고리에 검색어가 있을 경우
            		
                	$("span[id='titleSpan']:contains('" + keyword + "')" ).each(function() {
                		
                		var regex = new RegExp(keyword, 'gi'); // 정규식
                		$(this).html($(this).text().replace(regex, "<span style='color:#78C2AD;'>" + keyword + "</span>")); // 색깔 변경

                	});
                } else if(keyword != "" && category == 'boardWriter') { // 작성자 카테고리에 검색어가 있을 경우
                	
                	$("span[id='writerSpan']:contains('" + keyword + "')" ).each(function() {
                		
                		var regex = new RegExp(keyword, 'gi'); // 정규식
                		$(this).html($(this).text().replace(regex, "<span style='color:#78C2AD;'>" + keyword + "</span>")); // 색깔 변경

                	});
                }
            });
            
            </script>
            
            <br><br>
        </div>
        <br><br>

    </div>

	<jsp:include page="../common/footer.jsp" />

</body>
</html>