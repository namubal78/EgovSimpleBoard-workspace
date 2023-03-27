<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>간단 게시판 과제</title>
</head>
<body>
    
    <jsp:include page="../common/header.jsp" />

    <div class="content">
        <br><br>
        <div class="innerOuter">
            <h2>회원 상세페이지</h2>
            <br>

            <form action="update.me" method="post" accept-charset="utf-8">
                <input type="hidden" name="memberPwd" value="${ m.memberPwd }">
                <input type="hidden" name="memberNo" value="${ m.memberNo }">
                <div class="form-group">
                    <label for="memberId">* 아이디 : </label>
                    <input type="text" class="form-control" id="memberId" value="${ m.memberId }" name="memberId" readonly> <br>

                    <label for="memberName">* 이름 : </label>
                    <input type="text" class="form-control" id="memberName" value="${ m.memberName }" name="memberName" required> <br>

                    <label for="email"> &nbsp; 이메일 : </label>
                    <input type="text" class="form-control" id="email" value="${ m.email }" name="email"> <br>

                    <label for="phone"> &nbsp; 연락처 : </label>
                    <input type="text" class="form-control" id="phone" value="${ m.phone }" name="phone"> <br>
                    
                </div> 
                <br>
                <div class="btns" align="center">
                    <button type="button" class="btn btn-success" id="myList">작성글확인</button>
                    <button type="button" class="btn btn-danger" data-toggle="modal" data-target="#deleteForm">회원탈퇴</button>
                </div>
            </form>
        </div>
        
        <!-- 클릭 시 작성글 조회 -->
        <script>
        	$(function() {
        		$("#myList").click(function() {
        			location.href = "myList.bo?mno=" + $(this).parent().parent().children().eq(1).val();
        		});
        	});

        </script>
        <br><br>
        
    </div>

    <!-- 회원탈퇴 버튼 클릭 시 보여질 Modal -->
    <div class="modal fade" id="deleteForm">
        <div class="modal-dialog modal-sm">
            <div class="modal-content">

                <!-- Modal Header -->
                <div class="modal-header">
                    <h4 class="modal-title">회원 탈퇴</h4>
                    <button type="button" class="close" data-dismiss="modal">&times;</button>
                </div>

                <form action="delete.me" method="post">
                    <!-- Modal body -->
                    <div class="modal-body">
                        <div align="center">
                            	정말로 탈퇴처리 하시겠습니까? <br>
                        </div>
                            <input type="hidden" name="mno" value="${ m.memberNo }">
                    </div>
                    <!-- Modal footer -->
                    <div class="modal-footer" align="center">
                        <button type="submit" class="btn btn-danger">탈퇴하기</button>
                    </div>
                </form>
            </div>
        </div>
    </div>

	<jsp:include page="../common/footer.jsp" />

</body>
</html>