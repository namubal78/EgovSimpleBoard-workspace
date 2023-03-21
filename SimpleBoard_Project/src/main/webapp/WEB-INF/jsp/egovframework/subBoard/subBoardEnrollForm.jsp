<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<meta charset="UTF-8">
<title>Document</title>
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.4.1/jquery.min.js"></script>
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css">
<script src="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/js/bootstrap.min.js"></script>
<style>
	#enrollForm>table {width:100%;}
	#enrollForm>table * {margin:5px;}
</style>
</head>
<body>
        
    <jsp:include page="../common/header.jsp" />

    <div class="content">
        <br><br>
        <div class="innerOuter">
            <h2>공지사항 작성</h2>
            <br>

            <form id="enrollForm" method="post" action="insert.sub" enctype="multipart/form-data">
                <input type="hidden" value="${loginUser.memberNo}" name="memberNo">
                <table align="center">
                    <tr>
                        <th><label for="title">제목</label></th>
                        <td><input type="text" id="title" class="form-control" name="subBoardTitle" placeholder="150byte 이내로 작성해주세요" maxlength="150" required></td>
                    </tr>
                    <tr>
                        <th><label for="writer">작성자</label></th>
                        <td><input type="text" id="writer" class="form-control" value="${ loginUser.memberId }" name="subBoardWriter" readonly></td>
                    </tr>
                    <tr>
                        <th><label for="upfile">첨부파일</label></th>
                        <td><input type="file" id="upfile" class="form-control-file border" name="upfile"></td>
                    </tr>
                    <tr>
                        <th><label for="content">내용</label></th>
                        <td><textarea id="content" class="form-control" rows="10" style="resize:none;" name="subBoardContent" placeholder="3000byte 이내로 작성해주세요" required></textarea></td>
                    </tr>
                </table>
                <br>

                <div align="center">
                    <button type="submit" class="btn btn-primary">등록하기</button>
                    <button type="reset" class="btn btn-danger">취소하기</button>
                </div>
            </form>
        </div>
        <br><br>

    </div>
        
	<script>
	
	    // 작성 내용 글자수 체크
	    $("#content").keyup(function (e) {
	        
	        const maxByte = 3000; //최대 100바이트
	        const content = $(this).val(); //입력한 문자
	        const contentLength = content.length; //입력한 문자수
	        
	        let totalByte=0;
	        
	        for(let i = 0; i < contentLength; i++){
	        	
	        	const eachChar = content.charAt(i);
	            const uniChar = escape(eachChar); //유니코드 형식으로 변환
	            
	            if(uniChar.length > 4){ // 한글 : 2Byte
	                totalByte += 2;
	            } else { // 영문,숫자,특수문자 : 1Byte
	                totalByte += 1;
	            }
	        }
	        	        
	        if(totalByte > maxByte) {
		       	alert('최대 3000Byte까지만 입력가능합니다.');
                $(this).val($(this).val().substring(0, contentLength-1)); // 초과 byte 삭제
	        }
		});
	    
	</script>        
        
	<jsp:include page="../common/footer.jsp" />
	

</body>
</html>