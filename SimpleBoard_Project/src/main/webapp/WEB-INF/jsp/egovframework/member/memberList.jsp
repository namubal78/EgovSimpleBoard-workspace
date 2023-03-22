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

    #memberList {text-align:center;}
    #memberList>tbody>tr>td:hover {cursor:pointer;}

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
            <h2>회원 관리</h2>
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
                	<% int count = 0; %>
                	<c:forEach var="m" items="${ list }">
                		<c:choose>
                			<c:when test="${ m.memberId eq 'admin' or m.memberId eq 'subadmin'}">
                		
                			</c:when>
                			<c:otherwise>
                				<tr>
			                        <td>${ m.memberNo }</td>
			                        <td>${ m.memberId }</td>
			                        <td>${ m.memberName }</td>
			                        <td>${ m.email }</td>
			                        <td>${ m.phone }</td>
			                        <td class="deleteMember">
			                        	<button class="btn btn-danger btn-sm" data-toggle="modal" data-target="#deleteForm<%= count %>">탈퇴</button>
			                            <!-- 회원탈퇴 버튼 클릭 시 보여질 Modal -->
									    <div class="modal fade" id="deleteForm<%= count++ %>">
									        <div class="modal-dialog modal-sm">
									            <div class="modal-content">
									
									                <!-- Modal Header -->
									                <div class="modal-header">
									                    <h4 class="modal-title">회원 탈퇴</h4>
									                    <button type="button" class="close" data-dismiss="modal">&times;</button>
									                </div>
									
									                <form id="adminDeleteMemberForm" action="adminDelete.me?mno=${ m.memberNo }" method="post">
									                    <!-- Modal body -->
									                    <div class="modal-body">
									                        <div align="center">
									                            정말로 탈퇴 하시겠습니까? <br>
									                        </div>
									                        <br>
															<br>
									                    </div>
									                    <!-- Modal footer -->
									                    <div class="modal-footer" align="center">
									                        <button type="submit" class="btn btn-danger">탈퇴하기</button>
									                    </div>
									                </form>
									            </div>
									        </div>
									    </div>
			                        
			                        </td>
			                    </tr>
                			</c:otherwise>
                		</c:choose>
                		
                	</c:forEach>
                </tbody>
            </table>
            <br>
            
            <script>
            	$(function(){
            		$("#memberList>tbody>tr>td[class!='deleteMember']").click(function(){           			
            			location.href = "memberPage.me?mno=" + $(this).parent().children().eq(0).text();
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
                			<li class="page-item"><a class="page-link" href="memberList.me?cpage=${ cv.currentPage - 1 }&category=${ cv.category }&keyword=${ cv.keyword }">Previous</a></li>
                		</c:otherwise>
                	</c:choose>
                
                    <c:forEach var="p" begin="${ cv.startPage }" end="${ cv.endPage }">
	                    <li class="page-item"><a class="page-link" href="memberList.me?cpage=${ p }&category=${ cv.category }&keyword=${ cv.keyword }">${ p }</a></li>
                    </c:forEach>
                    
                    <c:choose>
                    	<c:when test="${ cv.currentPage eq cv.maxPage }">
                    		<li class="page-item disabled"><a class="page-link" href="#">Next</a></li>
                    	</c:when>
                    	<c:otherwise>
                			<li class="page-item"><a class="page-link" href="memberList.me?cpage=${ cv.currentPage + 1 }&category=${ cv.category }&keyword=${ cv.keyword }">Next</a></li>
                		</c:otherwise>
                    </c:choose>
                    
                </ul>
            </div>

            <br clear="both"><br>

            <form id="searchForm" action="memberList.me" method="get" align="center">
                <div class="select">
                    <select class="custom-select" name="category">
                        <option value="memberId">아이디</option>
                        <option value="memberName">이름</option>
                        <option value="phone">연락처</option>
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

	<jsp:include page="../common/footer.jsp" />


</body>
</html>