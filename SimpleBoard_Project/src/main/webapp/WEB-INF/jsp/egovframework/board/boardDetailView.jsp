<%@ page language="java" contentType="text/html; charset=UTF-8" 
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<title>Document</title>
	<style>
		table * {
			margin: 5px;
		}

		table {
			width: 100%;
		}
	</style>
</head>
<body>

	<jsp:include page="../common/header.jsp" />

	<div class="content">
		<br><br>
		<div class="innerOuter">
			<h2>자유게시판</h2>
			<br>

			<a class="btn btn-secondary" style="float:right;" href="list.bo">목록으로</a>
			<br><br>

			<table id="contentArea" align="center" class="table">
				<tr>
					<th width="100">제목</th>
					<td colspan="3">${ b.boardTitle }</td>
				</tr>
				<tr>
					<th>작성자</th>
					<td>${ b.boardWriter }</td>
					<th>작성일</th>
					<td>${ b.boardDate }</td>
				</tr>
				<tr>
					<th>첨부파일</th>
					<td colspan="3">
						<c:choose>
							<c:when test="${ empty b.originName }">
								첨부파일이 없습니다.
							</c:when>
							<c:otherwise>
								<a href="${ b.changeName }" download="${ b.originName }">${ b.originName }</a>
							</c:otherwise>
						</c:choose>
					</td>
				</tr>
				<tr>
					<th>내용</th>
					<td colspan="3"></td>
				</tr>
				<tr>
					<td colspan="4">
						<pre style="height:150px; white-space: pre-line;">${ b.boardContent }</pre>
					</td>
				</tr>
			</table>
			<br>
			<c:choose>
				<c:when test="${ loginUser.memberId eq 'admin' or loginUser.memberId eq 'subadmin' }">
					<div align="center">
						<a class="btn btn-danger" onclick="postFormSubmit(2);">삭제하기</a>
					</div>
					<br><br>

					<form id="postForm" action="" method="post">
						<input type="hidden" name="bno" value="${ b.boardNo }">
						<input type="hidden" name="filePath" value="${ b.changeName }">
					</form>
				</c:when>
				<c:when test="${ loginUser.memberId eq b.boardWriter }">
					<div align="center">
						<!-- 수정하기, 삭제하기 버튼은 이 글이 본인이 작성한 글일 경우에만 보여져야 함 -->
						<a class="btn btn-primary" onclick="postFormSubmit(1);">수정하기</a>
						<a class="btn btn-danger" onclick="postFormSubmit(2);">삭제하기</a>
					</div>
					<br><br>

					<form id="postForm" action="" method="post">
						<input type="hidden" name="bno" value="${ b.boardNo }">
						<input type="hidden" name="filePath" value="${ b.changeName }">
					</form>
				</c:when>
			</c:choose>

			<script>
				function postFormSubmit(num) {

					// action 속성값을 부여 후 연이어서 submit 시키기
					if (num == 1) { // 수정하기 버튼 클릭 시 num == 1 : updateForm.bo

						$("#postForm").attr("action", "updateForm.bo").submit();
					} else { // 삭제하기 버튼 클릭 시 num == 2 : delete.bo

						$("#postForm").attr("action", "delete.bo").submit();
					}
				}
			</script>
			<table id="replyArea" class="table" align="center">
				<thead>
					<tr>
						<c:choose>
							<c:when test="${ empty loginUser }">
								<!-- 로그인 전 -->
								<th colspan="2">
									<textarea class="form-control" name="" id="content" cols="55" rows="2"
										style="resize:none; width:100%;"
										readonly>로그인한 사용자만 이용가능한 서비스 입니다. 로그인 후 이용바랍니다.</textarea>
								</th>
								<th style="vertical-align:middle"><button class="btn btn-secondary"
										disabled>등록</button></th>
							</c:when>
							<c:otherwise>
								<!-- 로그인 후 -->
								<th colspan="2">
									<textarea class="form-control" name="" id="content" cols="55" rows="2"
										style="resize:none; width:100%;"></textarea>
								</th>
								<th id="rep2" width="10%" align="center"><span id="textCount"
										style="font-size: 10px; font-weight: lighter;">0</span><span
										id="textCount" style="font-weight: lighter; font-size: 10px;">/
										300</span></th>
								<th style="vertical-align:middle"><button class="btn btn-primary"
										onclick="addReply();">등록</button></th>
							</c:otherwise>
						</c:choose>
					</tr>
					<tr>
						<td colspan="3">댓글 (<span id="rcount">3</span>)</td>
					</tr>
				</thead>
				<tbody>
				</tbody>
			</table>
		</div>
		<br><br>

		<script>
			$(function () {

				selectReplyList();
			});

			function selectReplyList() { // 해당 게시글에 있는 댓글리스트 조회용 ajax 요청

				$.ajax({
					url: "rlist.bo",
					data: { bno: ${ b.boardNo }},
					success: function(result) {

						// colsole.log(result);
						var resultStr = "";

						for (var i = 0; i < result.length; i++) {

							resultStr += "<tr>"
								+ "<td>" + result[i].replyWriter + "</td>"
								+ "<td><pre style='white-space: pre-line;'>" + result[i].replyContent + "</pre></td>"
								+ "<td>" + result[i].replyDate + "</td>";

							if ("${loginUser.memberId}" == result[i].replyWriter || "${loginUser.memberId}" == "admin" || "${loginUser.memberId}" == "subadmin") {

								resultStr += "<td width='10%' align='center'>"
									+ "<button class='btn btn-danger button btn-sm' type='submit' onclick='deleteReply(" + result[i].replyNo + ");'>"
									+ "삭제" + "</button>"
									+ "</td>";
							}

							resultStr += "</tr>";
						}

						$("#replyArea>tbody").html(resultStr);

						// 댓글 개수 출력
						$("#rcount").text(result.length);
					},
					error: function() {
						console.log("댓글리스트 조회용 ajax 통신 실패!");
					}
				});
			}

			function addReply() { // 댓글 작성 요청용 ajax

				if ($("#content").val().trim().length != 0) {

					$.ajax({
						url: "rinsert.bo",
						data: {
							boardNo: ${ b.boardNo },
							replyWriter: "${ loginUser.memberId }",
							replyContent: $("#content").val()
						},
						success: function(result) {

							if (result == "success") {

								selectReplyList();

								// 댓글 작성 창 초기화 효과
								$("#content").val("");
								$('#textCount').val("");
							}
						},
						error: function() {
							console.log("댓글 작성용 ajax 통신 실패!");
						}
					});
				} else {
					alertify.alert("댓글 작성 실패", "댓글 작성 후 등록을 요청해주세요.");
				}
			}

			// 댓글 작성 글자수 체크
			$("#content").keyup(function (e) {
				var content = $(this).val();

				// 글자수 세기
				$("#textCount").text(content.length);

				// 글자수 제한
				if (content.length > 300) {
					// 300자 부터는 타이핑 되지 않도록
					$(this).val($(this).val().substring(0, 300));
					alertify.alert("댓글 글자수 초과", "300자 이내로 적어주세요.");
				};
			});

			function deleteReply(replyNo) { // 댓글 삭제 요청용 ajax

				$.ajax({
					url: "rdelete.re",
					data: { replyNo: replyNo },
					success: function (result) {

						if (result == "success") {
							selectReplyList();
							alertify.alert("댓글 삭제", "댓글이 삭제되었습니다.");
						}
					},
					error: function () {
						console.log("댓글 삭제용 ajax 통신 실패!");
					}
				});
			}

		</script>

	</div>

	<jsp:include page="../common/footer.jsp" />

</body>

</html>