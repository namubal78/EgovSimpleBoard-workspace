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
            <h2>회원 가입</h2>
            <br>

            <form action="insert.me" method="post" id="enrollForm">
                <div class="form-group">
                    <label for="memberId">* 아이디 : </label>
                    <input type="text" class="form-control" id="memberId" placeholder="5글자 이상을 입력해주세요." name="memberId" required> <br>
                    <div id="checkResult" style="font-size:0.8em; display:none;"></div>

                    <label for="memberPwd">* 비밀번호 : </label>
                    <input type="password" class="form-control" id="memberPwd" placeholder="비밀번호를 입력해주세요." name="memberPwd" required> <br>

                    <label for="checkPwd">* 비밀번호 재확인 : </label>
                    <input type="password" class="form-control" id="checkPwd" placeholder="동일하게 입력해주세요." required> <br>

                    <label for="memberName">* 이름 : </label>
                    <input type="text" class="form-control" id="memberName" placeholder="이름을 입력해주세요." name="memberName" required> <br>

                    <label for="email"> &nbsp; 이메일(@포함) : </label>
                    <input type="text" class="form-control" id="email" placeholder="예) gasystem@gasystem.co.kr" name="email"> <br>

                    <label for="phone"> * 연락처(-포함) : </label>
                    <input type="tel" class="form-control" id="phone" placeholder="예) 010-1111-2222" name="phone"> <br>

                </div> 
                <br>
                <div class="btns" align="center">
                    <button type="submit" class="btn btn-primary" disabled>회원가입</button>
                    <button type="reset" class="btn btn-danger">초기화</button>
                </div>
            </form>
        </div>
        <br><br>
        
        <script>
        	$(function() {
        		
        		// 아이디를 입력받는 input 요소 객체를 변수에 담아두기 => keyup 이벤트 걸기
        		var $idInput = $("#enrollForm input[name=memberId]");
        		
        		$idInput.keyup(function() {
        			
        			// 우선 최소 5글자 이상으로 아이디값이 입력되어 있을 때만 ajax 요청
        			// => 쿼리문의 갯수가 한정되어있을 수 있기 때문
        			if($idInput.val().length >= 5) {
        				
        				// ajax 를 요청하여 중복체크
        				$.ajax({
        					url : "idCheck.me",
        					data : {checkId : $idInput.val()},
        					success : function(result) {
        						        						
        						if(result == "NNNNN") { // 사용 불가
        							
        							// 빨간 메세지 출력
        							$("#checkResult").show();
        							$("#checkResult").css("color", "red").text("이미 사용중이거나 탈퇴한 아이디입니다.");
        							
        							// 버튼 비활성화
	        						$("#enrollForm button[type=submit]").attr("disabled", true);
        						
	        					} else { // 사용 가능
	        						
	        						// 초록색 메세지 출력
	        						$("#checkResult").show();
	        						$("#checkResult").css("color", "green").text("사용할 수 있는 아이디입니다.");
	        						
	        						// 버튼 활성화
	        						$("#enrollForm button[type=submit]").attr("disabled", false);
	        					}
        					},
        					error : function() {
        						console.log("아이디 중복 체크용 ajax 통신 실패!");
        					}
        				});
        			} else { // 5글자 미만일 때 => 버튼 비활성화, 메세지 내용 숨기기
        				
        				$("#checkResult").hide();
        				$("#enrollForm button[type=submit]").attr("disabled", true);
        			}
        		});
        	});
        </script>

    </div>

	<jsp:include page="../common/footer.jsp" />

</body>
</html>