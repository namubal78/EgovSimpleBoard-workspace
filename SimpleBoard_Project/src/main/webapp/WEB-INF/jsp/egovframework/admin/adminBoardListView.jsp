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
            <h2>게시글 관리</h2>
            <br>
            <br>
            <br>
            <table id="boardList" class="table table-hover" align="center">
                <thead>
                    <tr>
<!--                     	<td><input id="allCheck" type="checkbox" name="allCheck"></td> -->
                        <th>글번호</th>
                        <th>제목</th>
                        <th>작성자</th>
                        <th>조회수</th>
                        <th>작성일</th>
                        <th>삭제</th>
                    </tr>
                </thead>
                <tbody>
                	<% int count = 0; %>
                	<c:forEach var="b" items="${ list }">
                		<tr>
<%--                 			<td class="rowCheck"><input name="rowCheck" type="checkbox" value="${ b.boardNo }"></td> --%>
	                        <td class="detailRow">${ b.boardNo }</td>
	                        <td class="detailRow">${ b.boardTitle }</td>
	                        <td class="detailRow">${ b.boardWriter }</td>
	                        <td class="detailRow">${ b.boardCount }</td>
	                        <td class="detailRow">${ b.boardDate }</td>
	                        <td class="deleteBoard">
	                        	<button class="btn btn-danger btn-sm" data-toggle="modal" data-target="#deleteForm<%= count %>">삭제</button>
	                            <!-- 게시글삭제 버튼 클릭 시 보여질 Modal -->
							    <div class="modal fade" id="deleteForm<%= count++ %>">
							        <div class="modal-dialog modal-sm">
							            <div class="modal-content">
							
							                <!-- Modal Header -->
							                <div class="modal-header">
							                    <h4 class="modal-title">게시글 삭제</h4>
							                    <button type="button" class="close" data-dismiss="modal">&times;</button>
							                </div>
							
							                <form id="deleteBoardForm" action="adminDelete.bo?bno=${ b.boardNo }" method="post">
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
<!--             <div style="display:flex; justify-content:flex-end;"> -->
<!--             	<input type="button" value="선택삭제" class="btn btn-outline-info btn-sm" onclick="multipleDelete();"> -->
<!--             </div> -->
            <br>
            
            <script>
//             	$(function() {
            		
//             		var checkObject = document.getElementsByName("rowCheck");
//             		var checkObjectLength = checkObject.length;
            		
//             		$("input[name='allCheck']").click(function() {
            			
//             			var checkObjectList = $("input[name = 'rowCheck']");
//             			for(let i = 0; i < checkObjectList.length; i++ ) {
//             				checkObjectList[i].checked = this.checked;
//             			}
//             		});
            		
//             		$("input[name='rowCheck']").click(function() {
            			
//             			if($("input[name='rowCheck']:checked").length == checkObjectLength) {
//             				$("input[name='allCheck']").checked = true;
//             			} else {
//             				$("input[name='allCheck']").checked = false;            				
//             			}
            		
//             		});
            		
//             	});
            
            </script>
            
            <script>
            
//             function multipleDelete() {
            	
//             	var valueArr = new Array();
//             	var list = $("input[name='rowCheck']");
//             	for(var i = 0; i < list.length; i++) {
//             		if(list[i].checked) {
//             			valueArr.push(list[i].value);
//             		}
//             	}
            	
//             	if(valueArr.length == 0) {
//             		alert("체크된 글이 없습니다.");
//             	} else {
            		
//             		var chk = confirm("정말 삭제하시겠습니까?");
            		
//             		$.ajax({
            		
//             			url: "multipleDelete.bo",
//             			type: "POST",
//             			traditional: true,
//             			data: {valueArr: valueArr},
//             			success: function(jdata) {
//             				if(jdata = 1) {
//             					alert("삭제에 성공했습니다.");
//             					location.href("adminBoardList.bo");
//             				} else {
//             					alert("삭제에 실패했습니다.");
//             				}
//             			}
//             		});
//             	}
//             }
            
            </script>

			<!-- 클릭 시 해당 게시글 상세 조회 -->                        
            <script>
            	$(function(){
            		$("#boardList>tbody>tr>td[class='detailRow']").click(function(){
            			
            			location.href = "adminDetail.bo?bno=" + $(this).parent().children().eq(0).text();
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
	                    <li class="page-item"><a class="page-link" href="list.bo?cpage=${ p }&category=${ cv.category }&keyword=${ cv.keyword }">${ p }</a></li>
                    </c:forEach>
                    
                    <c:choose>
                    	<c:when test="${ cv.currentPage eq cv.maxPage }">
                    		<li class="page-item disabled"><a class="page-link" href="#">&gt;</a></li>
                    	</c:when>
                    	<c:otherwise>
                			<li class="page-item"><a class="page-link" href="list.bo?cpage=${ cv.currentPage + 1 }&category=${ cv.category }&keyword=${ cv.keyword }">&gt;;</a></li>
                		</c:otherwise>
                    </c:choose>
                    
                </ul>
            </div>

            <br clear="both"><br>

			<!-- 검색창 -->
            <form id="searchForm" action="list.bo" method="get" align="center">
                <div class="select">
                    <select class="custom-select" name="category">
                        <option value="boardTitle" selected>제목</option>
                        <option value="boardContent">내용</option>
                        <option value="boardWriter">작성자</option>
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
</html>