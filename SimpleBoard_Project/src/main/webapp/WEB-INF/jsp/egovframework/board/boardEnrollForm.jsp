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
<script src="https://kit.fontawesome.com/6cda7ccd12.js" crossorigin="anonymous"></script>
<script src="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/js/bootstrap.min.js"></script>
<script type="text/javascript" src="se2/js/HuskyEZCreator.js" charset="utf-8"></script>
<style>
	#enrollForm>table {width:100%;}
	#enrollForm>table * {margin:5px;}

    i { cursor: pointer; }
	  
	.filebox input[type="file"] {
		position: absolute;
		width: 1px;
		height: 1px;
		padding: 0;
		margin: -1px;
		overflow: hidden;
		clip: rect(0, 0, 0, 0);
		border: 0;
	}

	.filebox.bs3-primary .col-sm-10>label {
		color: #fff;
		background-color: #337ab7;
		border-color: #2e6da4;
	}

	.filebox .col-sm-10>label {
		display: inline-block;
		padding: .5em .75em;
		color: #999;
		font-size: inherit;
		font-weight: 600;
		line-height: normal;
		vertical-align: middle;
		background-color: #fdfdfd;
		cursor: pointer;
		border: 1px solid #ebebeb;
		border-bottom-color: #e2e2e2;
		border-radius: .20em;
	}

	.filebox .upload-name {
		display: inline-block;
		width: 520px;
		padding: .5em .75em;
		/* label의 패딩값과 일치 */
		font-size: inherit;
		font-family: inherit;
		line-height: normal;
		vertical-align: middle;
		background-color: #f5f5f5;
		border: 1px solid #ebebeb;
		border-bottom-color: #e2e2e2;
		border-radius: .20em;
		-webkit-appearance: none;
		/* 네이티브 외형 감추기 */
		-moz-appearance: none;
		appearance: none;
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

            <form id="enrollForm" method="post" action="insert.bo" enctype="multipart/form-data">
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
					<tr data-name="fileDiv" class="form-group filebox bs3-primary">
						<th><label for="file_0" class=" control-label" style="padding: 0px;">첨부(최대 5개)</label></th>
						<td class="col-sm-10" style="padding: 0px;">
							<input type="text" class="upload-name" value="첨부 파일을 등록해주세요." style="color: gray; margin-left:0px;" readonly />
							<label for="file_0" class="control-label" style="background-color: lightgray; border: none;">찾아보기</label>
							<input type="file" name="upfile" id="file_0" class="upload-hidden" onchange="changeFilename(this)" />
						
							<button type="button" onclick="addFile()" class="btn btn-outline-primary">
								<i class="fa fa-plus" aria-hidden="true"></i>
							</button>
							<button type="button" onclick="removeFile(this)" class="btn btn-outline-secondary">
								<i class="fa fa-minus" aria-hidden="true"></i>
							</button>
						</td>
					</tr>

                	<tr id="inputInsertTr"></tr>                        
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
				console.log("insert 스크립트");
				
		        document.getElementById('enrollForm').submit();

			}

		});
	
	</script>
	
	<script>
		
		let fileIdx = 0;
	
		function addFile() {
			
			console.log(fileIdx.value);
			
/* 			파일 개수 제한할 때 필요
 */			const fileDivs = $('tr[data-name="fileDiv"]');
			if (fileDivs.length > 4) {
				alert('첨부 파일은 최대 다섯 개까지 업로드 할 수 있습니다.');
				return false;
			}
	
			fileIdx++;
			
			var fileHtml = "";
			fileHtml += "<tr data-name='fileDiv' class='form-group filebox bs3-primary'>"
						+ "<th><label for='file_"+fileIdx+"' class='col-sm-2 control-label'></label></th>"
						+ "<td class='col-sm-10' style='padding: 0px;'>"
							+ "<input type='text' class='upload-name' value='첨부 파일을 등록해주세요.' style='color: gray; margin-left:0px;' readonly />"
							+ "<label for='file_"+fileIdx+"' class='control-label' style='background-color: lightgray; border: none; margin-left: 10px;'>찾아보기</label>"
							+ "<input type='file' name='upfile' id='file_"+fileIdx+"' class='upload-hidden' onchange='changeFilename(this);' />"
							+ "<button type='button' onclick='removeFile(this)' class='btn btn-outline-secondary' style='margin-left: 7px;'>"
							+ "<i class='fa fa-minus' aria-hidden='true'></i>"
							+ "</button>"
						+ "</td>"
					+ "</tr>";
			$('#inputInsertTr').before(fileHtml);
		}
	
		function removeFile(elem) {
	
			const prevTag = $(elem).prev().prop('tagName');
			if (prevTag === 'BUTTON') {
				const file = $(elem).prevAll('input[type="file"]');
				const filename = $(elem).prevAll('input[type="text"]');
				file.val('');
				filename.val('첨부 파일을 등록해주세요');
				return false;
			}
	
			const target = $(elem).parents('tr[data-name="fileDiv"]');
			target.remove();
		}
	
		function changeFilename(file) {
	
			file = $(file);
			const filename = file[0].files[0].name; // pill14.png
			
			const target = file.prevAll('input');
			target.val(filename);
		}
	
	</script>

	<jsp:include page="../common/footer.jsp" />

</body>
</html>