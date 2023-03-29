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
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/font-awesome/4.7.0/css/font-awesome.min.css">
<script src="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/js/bootstrap.min.js"></script>
<script type="text/javascript" src="se2/js/HuskyEZCreator.js" charset="utf-8"></script>
<style>
	#enrollForm>table {width:100%;}
	#enrollForm>table * {margin:5px;}
	
	.insert {
    padding: 20px 30px;
    display: block;
    width: 100%;
    margin: 5vh auto;
    height: 200px;
    border: 1px solid #dbdbdb;
    -webkit-box-sizing: border-box;
    -moz-box-sizing: border-box;
    box-sizing: border-box;
	}
	.insert .file-list {
	    height: 100px;
	    overflow: auto;
	    border: 1px solid #989898;
	    padding: 10px;
	}
	.insert .file-list .filebox p {
	    font-size: 14px;
	    margin-top: 10px;
	    display: inline-block;
	}
	.insert .file-list .filebox .delete i{
	    color: #ff5353;
	    margin-left: 5px;
	}
		
</style>
</head>

<body>
    <jsp:include page="../common/header.jsp" />

    <div class="content">
        <br><br>
        <div class="innerOuter">
            <h2>게시글 작성</h2>
            <br>

            <form id="enrollForm" method="post" action="insert.bo" enctype="multipart/form-data" onsubmit="return false;" >
                <input type="hidden" value="${loginUser.memberNo}" name="memberNo">
                <table align="center">
                    <tr>
                        <th><label for="title">제목</label></th>
                        <td><input type="text" id="title" class="form-control" name="boardTitle" placeholder="150byte 이내로 작성해주세요" maxlength="150" required></td>
                    </tr>
                    <tr>
                        <th><label for="writer">작성자</label></th>
                        <td><input type="text" id="writer" class="form-control" value="${ loginUser.memberName }" name="boardWriter" readonly></td>
                    </tr>
					<tr>
                        <th><label for="content">내용</label></th>
                        <td><textarea name="boardContent" id="content" style="width: 100%; height: 312px;" required></textarea></td> 
                    </tr>
                    <tr>
                        <th><label for="upfile">첨부파일</label></th>
                       	<td class="insert">
					        <input type="file" onchange="addFile(this);" multiple/>
					        <div class="file-list"></div>
						</td>
<!--                         <td><input type="file" id="upfile" class="form-control-file border" name="upfile"></td>
 -->                </tr>
                                        
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
		nhn.husky.EZCreator.createInIFrame({
			oAppRef : oEditors,
			elPlaceHolder : "content", //저는 textarea의 id와 똑같이 적어줬습니다.
			sSkinURI : "se2/SmartEditor2Skin.html", //경로를 꼭 맞춰주세요!
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
	
		$("#insertBtn").click(function(){
			
			oEditors.getById["content"].exec("UPDATE_CONTENTS_FIELD", []); // textarea value에 작성 내용 담기
 
			let boardTitle = $('#title').val(); // 제목 내용
			let boardContent= $('#content').val(); // 본문 내용
			
			if(boardTitle.trim().length == 0 || boardContent == "<br>") { // 둘 중 하나라도 비어있을 경우
				
				alertify.alert("게시글 작성 실패", "제목과 내용을 작성해주세요.");
				return false;
				
			} else {
				console.log("insert.fi 전");
				submitForm();
				
		        document.getElementById('enrollForm').submit();

			}

		});
	
	</script>
	
	<script>
		
		var fileNo = 0;
		var filesArr = new Array();
	
		/* 첨부파일 추가 */
		function addFile(obj){
		    var maxFileCnt = 3;   // 첨부파일 최대 개수
		    var attFileCnt = document.querySelectorAll('.filebox').length;    // 기존 추가된 첨부파일 개수
		    var remainFileCnt = maxFileCnt - attFileCnt;    // 추가로 첨부가능한 개수
		    var curFileCnt = obj.files.length;  // 현재 선택된 첨부파일 개수
	
		    // 첨부파일 개수 확인
		    if (curFileCnt > remainFileCnt) {
		        alert("첨부파일은 최대 " + maxFileCnt + "개 까지 첨부 가능합니다.");
		    }
	
		    for (var i = 0; i < Math.min(curFileCnt, remainFileCnt); i++) {
	
		        const file = obj.files[i];
	
		        // 첨부파일 검증
		        if (validation(file)) {
		            // 파일 배열에 담기
		            var reader = new FileReader();
		            reader.onload = function () {
		                filesArr.push(file);
		            };
		            reader.readAsDataURL(file)
	
		            // 목록 추가
		            let htmlData = '';
		            htmlData += '<div id="file' + fileNo + '" class="filebox">';
		            htmlData += '   <p class="name">' + file.name + '</p>';
		            htmlData += '   <a class="delete" onclick="deleteFile(' + fileNo + ');"><i class="far fa-minus-square"></i></a>';
		            htmlData += '</div>';
		            $('.file-list').append(htmlData);
		            fileNo++;
		        } else {
		            continue;
		        }
		    }
		    // 초기화
		    document.querySelector("input[type=file]").value = "";
		}
	
		/* 첨부파일 검증 */
		function validation(obj){
		    const fileTypes = ['application/pdf', 'image/gif', 'image/jpeg', 'image/png', 'image/bmp', 'image/tif', 'application/haansofthwp', 'application/x-hwp'];
		    if (obj.name.length > 100) {
		        alert("파일명이 100자 이상인 파일은 제외되었습니다.");
		        return false;
		    } else if (obj.size > (100 * 1024 * 1024)) {
		        alert("최대 파일 용량인 100MB를 초과한 파일은 제외되었습니다.");
		        return false;
		    } else if (obj.name.lastIndexOf('.') == -1) {
		        alert("확장자가 없는 파일은 제외되었습니다.");
		        return false;
		    } else if (!fileTypes.includes(obj.type)) {
		        alert("첨부가 불가능한 파일은 제외되었습니다.");
		        return false;
		    } else {
		        return true;
		    }
		}
	
		/* 첨부파일 삭제 */
		function deleteFile(num) {
		    document.querySelector("#file" + num).remove();
		    filesArr[num].is_delete = true;
		}
	
		/* 폼 전송 */
		function submitForm() {
			console.log("insert.fi 도착");

		    // 폼데이터 담기
		    var form = document.querySelector(".insert");
		    var formData = new FormData(form);
		    for (var i = 0; i < filesArr.length; i++) {
		        // 삭제되지 않은 파일만 폼데이터에 담기
		        if (!filesArr[i].is_delete) {
		            formData.append("attach_file", filesArr[i]);
		        }
		    }
	
			$.ajax({
		   	      type: "POST",
		   	   	  enctype: "multipart/form-data",
		   	      url: "insert.fi",
		       	  data : formData,
		       	  processData: false,
		   	      contentType: false,
		   	      success: function (data) {
		   	    	if(JSON.parse(data)['result'] == "OK"){
		   	    		alert("파일업로드 성공");
					} else
						alert("서버내 오류로 처리가 지연되고있습니다. 잠시 후 다시 시도해주세요");
		   	      },
		   	      error: function (xhr, status, error) {
		   	    	alert("서버오류로 지연되고있습니다. 잠시 후 다시 시도해주시기 바랍니다.");
		   	     return false;
		   	      }
		   	    });
		   	    return false;
			}
		
	</script>

	<jsp:include page="../common/footer.jsp" />

        
</body>
</html>