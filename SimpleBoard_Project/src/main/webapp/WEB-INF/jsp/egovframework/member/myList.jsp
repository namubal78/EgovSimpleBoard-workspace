<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>    
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
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
            <h2>작성 글</h2>
            <br>
			<br>
            <br>
            <br>
            <table id="boardList" class="table table-hover" align="center">
                <thead>
                    <tr>
                        <th>글번호</th>
                        <th>제목</th>
                        <th>조회수</th>
                        <th>작성일</th>
                        <th>삭제</th>
                    </tr>
                </thead>
                <tbody>
                	<% int count = 0; %>
                	<c:forEach var="b" items="${ list }">
                		<tr>
	                        <td>${ b.boardNo }</td>
	                        <td>${ b.boardTitle }</td>
	                        <td>${ b.boardCount }</td>
	                        <td>${ b.boardDate }</td>
	                        <td class="deleteBoard">
	                        	<button class="btn btn-danger btn-sm" data-toggle="modal" data-target="#deleteForm<%= count %>">삭제</button>
	                            <!-- 게시글삭제 버튼 클릭 시 보여질 Modal -->
							    <div class="modal fade" id="deleteForm<%= count++ %>">
							        <div class="modal-dialog modal-sm">
							            <div class="modal-content">
							
							                <!-- Modal Header -->
							                <div class="modal-header">
							                    <h4 class="modal-title">게시글삭제</h4>
							                    <button type="button" class="close" data-dismiss="modal">&times;</button>
							                </div>
							
							                <form id="deleteBoardForm" action="delete.bo?bno=${ b.boardNo }" method="post">
							                    <!-- Modal body -->
							                    <div class="modal-body">
							                        <div align="center">
							                            정말로 삭제 하시겠습니까? <br>
							                        </div>
							                        <br>
													<br>
							                    </div>
							                    <!-- Modal footer -->
							                    <div class="modal-footer" align="center">
							                        <button type="submit" class="btn btn-danger">삭제하기</button>
							                    </div>
							                    <input type="hidden" name="filePath" value="${ b.changeName }">
							                    <input type="hidden" name="mno" value="${ b.memberNo }">
							                </form>
							            </div>
							        </div>
							    </div>
	                        </td>
	                    </tr>
                	</c:forEach>
                </tbody>
            </table>
            <br>
            
            <script>
            	$(function(){
            		$("#boardList>tbody>tr>td[class!='deleteBoard']").click(function(){
            			
            			location.href = "detail.bo?bno=" + $(this).children().eq(0).text();
            		});
            	});	
            </script>

            <div id="pagingArea">
                <ul class="pagination">
                	
                	<c:choose>
                		<c:when test="${ cv.currentPage eq 1 }">
                			<li class="page-item disabled"><a class="page-link" href="#">Previous</a></li>
                		</c:when>
                		<c:otherwise>
                			<li class="page-item"><a class="page-link" href="myList.bo?cpage=${ cv.currentPage - 1 }&mno=${ mno }">Previous</a></li>
                		</c:otherwise>
                	</c:choose>
                
                    <c:forEach var="p" begin="${ cv.startPage }" end="${ cv.endPage }">
	                    <li class="page-item"><a class="page-link" href="myList.bo?cpage=${ p }&mno=${ mno }">${ p }</a></li>
                    </c:forEach>
                    
                    <c:choose>
                    	<c:when test="${ cv.currentPage eq cv.maxPage }">
                    		<li class="page-item disabled"><a class="page-link" href="#">Next</a></li>
                    	</c:when>
                    	<c:otherwise>
                			<li class="page-item"><a class="page-link" href="myList.bo?cpage=${ cv.currentPage + 1 }&mno=${ mno }">Next</a></li>
                		</c:otherwise>
                    </c:choose>
                    
                </ul>
            </div>
		<br>
        </div>
        <br><br>

    </div>

	<jsp:include page="../common/footer.jsp" />


</body>
</html>