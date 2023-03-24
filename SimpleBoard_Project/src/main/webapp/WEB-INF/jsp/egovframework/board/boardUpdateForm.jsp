<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>간단 게시판 과제</title>
<style>
    #updateForm>table {width:100%;}
    #updateForm>table * {margin:5px;}
</style>
</head>
<!-- 뒤로 가기 방지 -->
<script type="text/javascript">
    history.pushState(null, null, location.href);
    window.onpopstate = function (event) {
        history.go(1);
    };
</script>
<body>
        
    <jsp:include page="../common/header.jsp" />

    <div class="content">
        <br><br>
        <div class="innerOuter">
            <h2>게시글 수정</h2>
            <br>

            <form id="updateForm" method="post" action="update.bo" enctype="multipart/form-data">
                <input type="hidden" name="boardNo" value="${ b.boardNo }">
                <table align="center">
                    <tr>
                        <th><label for="title">제목</label></th>
                        <td><input type="text" id="title" class="form-control" value="${ b.boardTitle }" name="boardTitle" required></td>
                    </tr>
                    <tr>
                        <th><label for="writer">작성자</label></th>
                        <td><input type="text" id="writer" class="form-control" value="${ b.boardWriter }" readonly></td>
                    </tr>
                    <tr>
                        <th><label for="upfile">첨부파일</label></th>
                        <td>
                            <input type="file" id="upfile" class="form-control-file border" name="reupfile">
                            	
                            <c:if test="${ not empty b.originName }">
                            	현재 업로드된 파일 : 
                            <a href="${ b.changeName }" download="${ b.originName }">${ b.originName }</a>
                            
                            <!-- 기존 파일이 있을때 -->
                            <input type="hidden" name="originName" value="${ b.originName }">
                            <input type="hidden" name="changeName" value="${ b.changeName }">
                            </c:if>
                            
                        </td>
                    </tr>
                    <tr>
                        <th><label for="content">내용</label></th>
                        <td><textarea id="content" class="form-control" rows="10" style="resize:none;" name="boardContent" required>${ b.boardContent }</textarea></td>
                    </tr>
                </table>
                <br>

                <div align="center">
                    <button type="submit" class="btn btn-primary">수정하기</button>
                </div>
            </form>
        </div>
        <br><br>

    </div>

	<jsp:include page="../common/footer.jsp" />

        
</body>
</html>