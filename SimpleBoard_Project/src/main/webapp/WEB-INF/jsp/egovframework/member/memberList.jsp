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
    #boardList>tbody>tr>td>button:hover {cursor:pointer;}

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
            <h2>회원관리</h2>
            <br>
            <br>
            <br>
            <br>
            <table id="memberList" class="table table-hover" align="center">
                <thead>
                    <tr>
                        <th>회원번호</th>
                        <th>회원ID</th>
                        <th>회원이름</th>
                        <th>이메일</th>
                        <th>연락처</th>
                        <th>탈퇴</th>
                    </tr>
                </thead>
                <tbody>
                	<c:forEach var="m" items="${ list }">
                		<c:choose>
                			<c:when test="${ m.memberId eq 'admin' }">
                		
                			</c:when>
                			<c:otherwise>
                				<tr>
			                        <td>${ m.memberNo }</td>
			                        <td>${ m.memberId }</td>
			                        <td>${ m.memberName }</td>
			                        <td>${ m.email }</td>
			                        <td>${ m.phone }</td>
			                        <td><button class="btn btn-danger btn-sm" >탈퇴</button></td>
			                    </tr>
                			</c:otherwise>
                		</c:choose>
                		
                		
                		

                	</c:forEach>
                </tbody>
            </table>
            <br>
            
            <script>
            	$(function(){
            		$("#memberList>tbody>tr>td>button").click(function(){
            			location.href = "adminDelete.me?mno=" + $(this).parent().parent().children().eq(0).text();
            		});
            	});	
            </script>

            <div id="pagingArea">
                <ul class="pagination">
                	
                	<c:choose>
                		<c:when test="${ pi.currentPage eq 1 }">
                			<li class="page-item disabled"><a class="page-link" href="#">Previous</a></li>
                		</c:when>
                		<c:otherwise>
                			<li class="page-item"><a class="page-link" href="memberList.me?cpage=${ pi.currentPage - 1 }">Previous</a></li>
                		</c:otherwise>
                	</c:choose>
                
                    <c:forEach var="p" begin="${ pi.startPage }" end="${ pi.endPage }">
	                    <li class="page-item"><a class="page-link" href="memberList.me?cpage=${ p }">${ p }</a></li>
                    </c:forEach>
                    
                    <c:choose>
                    	<c:when test="${ pi.currentPage eq pi.maxPage }">
                    		<li class="page-item disabled"><a class="page-link" href="#">Next</a></li>
                    	</c:when>
                    	<c:otherwise>
                			<li class="page-item"><a class="page-link" href="memberList.me?cpage=${ pi.currentPage + 1 }">Next</a></li>
                		</c:otherwise>
                    </c:choose>
                    
                </ul>
            </div>

            <br clear="both"><br>

            <form id="searchForm" action="" method="get" align="center">
                <div class="select">
                    <select class="custom-select" name="condition">
                        <option value="writer">작성자</option>
                        <option value="title">제목</option>
                        <option value="content">내용</option>
                    </select>
                </div>
                <div class="text">
                    <input type="text" class="form-control" name="keyword">
                </div>
                <button type="submit" class="searchBtn btn btn-secondary">검색</button>
            </form>
            <br><br>
        </div>
        <br><br>

    </div>

</body>
</html>