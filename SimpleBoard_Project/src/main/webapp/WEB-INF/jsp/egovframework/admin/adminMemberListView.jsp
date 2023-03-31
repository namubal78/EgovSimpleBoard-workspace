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
            <br><br>
           
            <!-- 검색 키워드 및 결과 -->
            <c:choose> 
           		<c:when test="${ empty cv.keyword }">
					<p>총 <span style="color: #78C2AD; font-weight: bold;">${ cv.listCount }</span>명</p>
           		</c:when>
           		<c:otherwise>
           			<c:choose>
           				<c:when test="${ cv.category eq 'memberId' }">
           					<p><span style="color: #78C2AD; font-weight: bold;">아이디</span>에 대한 검색어 <span style="color: #78C2AD; font-weight: bold;">${ cv.keyword }</span>에 대한 결과 <span style="color: #78C2AD; font-weight: bold;">${ cv.listCount }</span>명 입니다.</p>
           				</c:when>
           				<c:when test="${ cv.category eq 'memberName' }">
           					<p><span style="color: #78C2AD; font-weight: bold;">이름</span>에 대한 검색어 <span style="color: #78C2AD; font-weight: bold;">${ cv.keyword }</span>에 대한 결과  <span style="color: #78C2AD; font-weight: bold;">${ cv.listCount }</span>명 입니다.</p>
           				</c:when>
           				<c:when test="${ cv.category eq 'phone' }">
           					<p><span style="color: #78C2AD; font-weight: bold;">연락처</span>에 대한 검색어 <span style="color: #78C2AD; font-weight: bold;">${ cv.keyword }</span>에 대한 결과  <span style="color: #78C2AD; font-weight: bold;">${ cv.listCount }</span>명 입니다.</p>
           				</c:when>           				           				
           			</c:choose>
           		</c:otherwise>
            </c:choose>
           
           
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
	             		<tr>
	                        <td>${ m.memberNo }</td>
	                        <td><span id="idSpan">${ m.memberId }</span></td>
	                        <td><span id="nameSpan">${ m.memberName }</span></td>
	                        <td>${ m.email }</td>
	                        <td><span id="phoneSpan">${ m.phone }</span></td>
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
							                            	정말로 탈퇴 처리하시겠습니까? <br>
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
                	</c:forEach>
                </tbody>
            </table>
            <br>
            
            <!-- 클릭 시 해당 회원 상세 조회 -->
            <script>
            	$(function(){
            		$("#memberList>tbody>tr>td[class!='deleteMember']").click(function(){           			
            			location.href = "memberPage.me?mno=" + $(this).parent().children().eq(0).text();
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
                			<li class="page-item"><a class="page-link" href="memberList.me?cpage=${ cv.currentPage - 1 }&category=${ cv.category }&keyword=${ cv.keyword }">&lt;</a></li>
                		</c:otherwise>
                	</c:choose>
                
                    <c:forEach var="p" begin="${ cv.startPage }" end="${ cv.endPage }">
                    	<c:if test="${ p eq cv.currentPage }">
                    		<li class="page-item"><a class="page-link" href="memberList.me?cpage=${ p }&category=${ cv.category }&keyword=${ cv.keyword }"><span style="font-weight: bold;">${ p }</span></a></li>
                    	</c:if>
                    	<c:if test="${ p ne cv.currentPage }">
                    		<li class="page-item"><a class="page-link" href="memberList.me?cpage=${ p }&category=${ cv.category }&keyword=${ cv.keyword }">${ p }</a></li>
                    	</c:if>                    	
                    </c:forEach>
                    
                    <c:choose>
                    	<c:when test="${ cv.currentPage eq cv.maxPage }">
                    		<li class="page-item disabled"><a class="page-link" href="#">&gt;</a></li>
                    	</c:when>
                    	<c:otherwise>
                			<li class="page-item"><a class="page-link" href="memberList.me?cpage=${ cv.currentPage + 1 }&category=${ cv.category }&keyword=${ cv.keyword }">&gt;</a></li>
                		</c:otherwise>
                    </c:choose>
                    
                </ul>
            </div>

            <br clear="both"><br>

			<!-- 검색창 -->
            <form id="searchForm" action="memberList.me" method="get" align="center">
                <div class="select">
                    <select class="custom-select" name="category">
                        <option value="memberId">아이디</option>
                        <option value="memberName">이름</option>
                        <option value="phone">연락처</option>
                    </select>
                </div>
                <div class="text">
                    <input type="text" class="form-control" name="keyword" value="${ cv.keyword }">
                </div>
                <button type="submit" class="searchBtn btn btn-secondary">검색</button>
            </form>
            
            <script>
            
            	
	            $(document).ready(function() {
	            	
	                let keyword = "${cv.keyword}"; // 검색 키워드 변수에 담기
	            	let category = "${cv.category}";  // 검색 카테고리 변수에 담기
	            	
	            	// 검색 카테고리 유지 함수
	            	if(category == "memberId") {  // 카테고리가 아이디
						$("option[value='memberId']").attr("selected", true); // 해당 카테고리 option 에 selected 속성 부여
	            	} else if(category == 'memberName') { // 카테고리가 이름
						$("option[value='memberName']").attr("selected", true); // 해당 카테고리 option 에 selected 속성 부여
	            	} else if(category == 'phone') { // 카테고리가 연락처
						$("option[value='phone']").attr("selected", true); // 해당 카테고리 option 에 selected 속성 부여
	            	}
	            	
	            	// 검색 키워드 색깔 처리
	            	if(keyword != "" && category == 'memberId') { // 아이디 카테고리에 검색어가 있을 경우
	            		
	                	$("span[id='idSpan']:contains('" + keyword + "')" ).each(function() {
	                		
	                		var regex = new RegExp(keyword, 'gi'); // 정규식
	                		$(this).html($(this).text().replace(regex, "<span style='color:#78C2AD;'>" + keyword + "</span>")); // 색깔 변경
	
	                	});
	                } else if(keyword != "" && category == 'memberName') { // 이름 카테고리에 검색어가 있을 경우
	                	
	                	$("span[id='nameSpan']:contains('" + keyword + "')" ).each(function() {
	                		
	                		var regex = new RegExp(keyword, 'gi'); // 정규식
	                		$(this).html($(this).text().replace(regex, "<span style='color:#78C2AD;'>" + keyword + "</span>")); // 색깔 변경
	
	                	});
	                } else if(keyword != "" && category == 'phone') { // 연락처 카테고리에 검색어가 있을 경우
	                	
	                	$("span[id='phoneSpan']:contains('" + keyword + "')" ).each(function() {
	                		
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