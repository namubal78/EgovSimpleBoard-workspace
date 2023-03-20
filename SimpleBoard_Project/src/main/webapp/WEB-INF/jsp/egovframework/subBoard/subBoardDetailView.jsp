<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>    
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Document</title>
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
            <h2>두 번째 게시글 상세보기</h2>
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
                    <td colspan="4"><p style="height:150px;">${ b.subBoardContent }</p></td>
                </tr>
            </table>
            <br>
		<c:choose>
			<c:when test="${ loginUser.memberId eq 'subadmin' }">
				<div align="center">
	                <a class="btn btn-danger" onclick="postFormSubmit(2);">삭제하기</a>
	            </div>
	            <br><br>
	            
	            <form id="postForm" action="" method="post">
	            	<input type="hidden" name="subBno" value="${ b.subBoardNo }">
	            	<input type="hidden" name="filePath" value="${ b.subChangeName }">
	            </form>
			</c:when>
			<c:when test="${ loginUser.memberId eq b.subBoardWriter }">
				<div align="center">
	                <!-- 수정하기, 삭제하기 버튼은 이 글이 본인이 작성한 글일 경우에만 보여져야 함 -->
	                <a class="btn btn-danger" onclick="postFormSubmit(2);">삭제하기</a>
	            </div>
	            <br><br>
	            
	            <form id="postForm" action="" method="post">
	            	<input type="hidden" name="subBno" value="${ b.subBoardNo }">
	            	<input type="hidden" name="filePath" value="${ b.subChangeName }">
	            </form>
			</c:when>
		</c:choose>
		
		<script>
			function postFormSubmit(num) {
				
				// action 속성값을 부여 후 연이어서 submit 시키기
				if(num == 1) { 
					
				} else { 
				
					$("#postForm").attr("action", "delete.sub").submit();
				}
			}
		</script>
  
        </div>
        <br><br>
        
    </div>
        
</body>
</html>