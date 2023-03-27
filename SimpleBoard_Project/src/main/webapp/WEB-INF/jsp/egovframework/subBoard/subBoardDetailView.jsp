<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>    
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>간단 게시판 과제</title>
<style>
    table * {margin:5px;}
    table {width:100%;}
</style>
</head>
<body>
        
    <jsp:include page="../common/header.jsp" />

    <div class="content">
        <br><br>
        <div class="innerOuter">
            <h2>공지사항</h2>
            <br>

            <a class="btn btn-secondary" style="float:right;" href="list.sub">목록으로</a>
            <br><br>

            <table id="contentArea" align="center" class="table">
                <tr>
                    <th width="100">제목</th>
                    <td colspan="3">${ b.subBoardTitle }</td>
                </tr>
                <tr>
                    <th>작성자</th>
                    <td>${ b.subBoardWriter }</td>
                    <th>작성일</th>
                    <td>${ b.subBoardDate }</td>
                </tr>
                <tr>
                    <th>첨부파일</th>
                    <td colspan="3">
                        <c:choose>
                            <c:when test="${ empty b.subOriginName }">
								첨부파일이 없습니다.
                            </c:when>
                            <c:otherwise>
                                <a href="${ b.subChangeName }" download="${ b.subOriginName }">${ b.subOriginName }</a>      
                            </c:otherwise>
                        </c:choose>
                    </td>
                </tr>
                <tr>
                    <th>내용</th>
                    <td colspan="3"></td>
                </tr>
                <tr>
                    <td colspan="4"><pre style="height:150px; white-space: pre-line;">${ b.subBoardContent }</pre></td>
                </tr>
            </table>
            <br>
            
            <!-- 관리자 로그인일 경우만 보여지는 삭제하기 버튼 -->        		
            <c:choose>
                <c:when test="${ loginUser.memberId eq 'subadmin' or loginUser.memberId eq 'admin' }">
                    <div align="center">
						<a class="btn btn-danger" data-toggle="modal" data-target="#deleteForm">삭제하기</a>
                    </div>
                    <br>
                    
                    <form id="postForm" action="delete.sub" method="post">
                        <input type="hidden" name="subBno" value="${ b.subBoardNo }">
                        <input type="hidden" name="filePath" value="${ b.subChangeName }">
                    </form>
                </c:when>
				<c:otherwise></c:otherwise>
			</c:choose>
            
            <!-- 공지 삭제 모달창 -->
            <div class="modal fade" id="deleteForm">
		        <div class="modal-dialog modal-sm">
		            <div class="modal-content">
		
		                <!-- Modal Header -->
		                <div class="modal-header">
		                    <h4 class="modal-title">공지 삭제</h4>
		                    <button type="button" class="close" data-dismiss="modal">&times;</button>
		                </div>
		
		                <form id="deleteBoardForm" action="delete.sub?subBno=${ b.subBoardNo }" method="post">
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
		                    <input type="hidden" name="filePath" value="${ b.subChangeName }">
		                </form>
		            </div>
				</div>
			</div>
  
        </div>
        <br><br><br>
        
    </div>
        
	<jsp:include page="../common/footer.jsp" />
        
</body>
</html>