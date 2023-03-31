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
<script type="text/javascript" src="se2/js/HuskyEZCreator.js" charset="utf-8"></script>
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
                        <td><input type="text" id="title" class="form-control" name="subBoardTitle" placeholder="150 byte 이내로 작성해주세요" maxlength="45" required></td>
                    </tr>
                    <tr>
                        <th><label for="writer">작성자</label></th>
                        <td><input type="text" id="writer" class="form-control" value="${ loginUser.memberName }" name="subBoardWriter" readonly></td>
                    </tr>
                    <tr>
                        <th><label for="upfile">첨부파일</label></th>
                        <td><input type="file" id="upfile" class="form-control-file border" name="upfile" onchange='changeFilename(this);'></td>
                    </tr>
                    <tr>
                        <th><label for="content">내용</label></th>
                        <td><textarea name="subBoardContent" id="content" style="width: 100%; height: 312px;" required maxlength="1000"></textarea></td>                                             
                    </tr>
                </table>
                <br>

                <div align="center">
                    <button id="insertBtn" type="button" class="btn btn-primary">등록하기</button>
                    <button type="reset" class="btn btn-danger">취소하기</button>
                </div>
            </form>
        </div>
        <br><br>

    </div>
        
   
  	<script>
	
		var oEditors = [];
		nhn.husky.EZCreator.createInIFrame({ // 네이버 스마트 에디터
			oAppRef : oEditors,
			elPlaceHolder : "content", // textarea의 id와 동일
			sSkinURI : "se2/SmartEditor2Skin.html",
			fCreator : "createSEditor2",
			htParams : {
				// 툴바 사용 여부 (true:사용/ false:사용하지 않음)
				bUseToolbar : true,
		
				// 입력창 크기 조절바 사용 여부 (true:사용/ false:사용하지 않음)
				bUseVerticalResizer : false,
		
				// 모드 탭(Editor | HTML | TEXT) 사용 여부 (true:사용/ false:사용하지 않음)
				bUseModeChanger : false,
				
				fOnBeforeUnload : function(){}
			}
		});

	</script>
   
	<script>
	
		$("#insertBtn").click(function(){ // 공지사항 작성 시 유효성 확인
			
			oEditors.getById["content"].exec("UPDATE_CONTENTS_FIELD", []); // textarea value에 웹 에디터로 작성한 내용 담기
 
			let boardTitle = $('#title').val(); // 제목 내용
			let boardContent= $('#content').val(); // 본문 내용
			
			if(boardTitle.trim().length == 0 || boardContent == "<br>") { // 둘 중 하나라도 비어있을 경우
				
				alertify.alert("공지 작성 실패", "제목과 내용을 작성해주세요.");
				return false;
				
			} else {
				
		        document.getElementById('enrollForm').submit(); // submit

			}

		});
		
		function changeFilename(file) { // 첨부파일 등록
			
			file = $(file);
			const filename = file[0].files[0].name; // 파일명 ex) pill14.png
			const fileElem = file[0].files[0]; // 파일
			
			if(validation(fileElem)) { // 유효성 검사 통과
				
				console.log("validation true");

				const target = file.prevAll('input');
				target.val(fileElem.name); // 파일명 출력
				
			}
			
		}
		
		/* 첨부파일 검증 */
		function validation(fileElem){
			
			console.log("validation 도착");

		    const fileTypes = ['application/pdf', 'image/gif', 'image/jpeg', 'image/png', 'image/bmp', 'image/tif', 'application/haansofthwp', 'application/x-hwp'];
		    if (fileElem.name.length > 100) { // 파일명 검증
		    	
		        alert("파일명이 100자 이상인 파일은 제외되었습니다.");
		        return false;
		    } else if (fileElem.size > (2 * 1000 * 1000)) { // 파일 용량 검증

		        alert("최대 파일 용량인 2MB를 초과한 파일은 제외되었습니다.");
		        return false;
		    } else if (fileElem.name.lastIndexOf('.') == -1) { // 확장자 유무 검증

		        alert("확장자가 없는 파일은 제외되었습니다."); 
		        return false;
		    } else if (!fileTypes.includes(fileElem.type)) { // 파일 타입 검증

		        alert("첨부가 불가능한 파일은 제외되었습니다.");
		        return false;
		    } else {
		        return true;
		    }
		}
	
	</script>      
        
	<jsp:include page="../common/footer.jsp" />

</body>
</html>