<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>간단 게시판 과제</title>
</head>
<style>
	.input-group-addon>input,button  {
		float: left;
	}
</style>
<body>
    
    <jsp:include page="../common/header.jsp" />

    <div class="content">
        <br><br>
        <div class="innerOuter">
            <h2>회원 가입</h2>
            <br>

            <form action="insert.me" method="post" id="enrollForm" name="enrollForm">
                <div class="form-group">
                    <label for="memberId">* 아이디 : </label>
                    <input type="text" class="form-control" id="memberId" placeholder="5글자 이상을 입력해주세요." name="memberId"> <br>
                    <div id="checkResult" style="font-size:0.8em; display:none;"></div>

                    <label for="memberPwd">* 비밀번호 : </label>
                    <input type="password" class="form-control" id="memberPwd" placeholder="비밀번호를 입력해주세요." name="memberPwd"> <br>

                    <label for="checkPwd">* 비밀번호 재확인 : </label>
                    <input type="password" class="form-control" id="checkPwd" placeholder="동일하게 입력해주세요." > <br>

                    <label for="memberName">* 이름 : </label>
                    <input type="text" class="form-control" id="memberName" placeholder="이름을 입력해주세요." name="memberName"> <br>

					<label for="email"> * 이메일 : </label>
					<div class="input-group-addon">					
	                    <input type="text" class="form-control" id="email" placeholder="예) gasystem@gasystem.co.kr" name="email" style="width: 780px;"> 
	                    <button type="button" class="btn btn-primary" id="mail-Check-Btn" style="width: 130px;">인증번호받기</button>
	                    <input type="hidden" id="checkNum" val="">
					</div>
					<div class="mail-check-box">
						<input class="form-control mail-check-input" placeholder="인증번호 6자리를 입력해주세요!" disabled="disabled" maxlength="6">
						<button type="button" class="btn btn-primary" id="check-number-Btn" style="width: 130px;">인증하기</button>
					</div>
					<div>	
						<span id="mail-check-warn"></span>
					</div>

					<br>
					
                    <label for="phone"> * 연락처(-포함) : </label>
                    <input type="tel" class="form-control" id="phone" placeholder="예) 010-1111-2222" name="phone"> <br>

                </div> 
                <br>
                <div class="btns" align="center">
                    <button class="btn btn-primary" onclick="formCheck();">회원가입</button>
                    <button type="reset" class="btn btn-danger">초기화</button>
                </div>
            </form>
        </div>
        <br><br>
        
        <script>
	        
	        /*
	        	회원가입 함수 목록
	        	1. 아이디 중복 체크 ajax
	        	2. 이메일 인증 체크 ajax
	        	3. 가입하기 버튼 클릭 시 체크
	        		3-1. 공란 여부	
	        		3-2. 비밀번호, 비밀번호 재입력 일치 여부
	        		3-3. 비밀번호 유효성 검사
	        */
              
        	$(function() { // 아이디 중복 체크 ajax
        		
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
        
        <script>
        	
    		$('#mail-Check-Btn').click(function() { // 인증번호 받기 함수 호출
    			
    			sendmail();
    		});
    		
    		function sendmail() { // 인증번호 받기 ajax

    			var email = document.getElementById('email').value;
    			    			
    			$.ajax({
    				url: "sendmail.do",
    				data: {email:email},
    				success: function(result) {
    					
    					alert("인증번호를 메일로 보냈습니다.");
   						$('#checkNum').val(result);    
        				$('.mail-check-input').attr('disabled',false);
   						console.log("인증번호 전송 성공");
    				},
    				error: function() {
    				}
    			
    			});
    			
    		} 

    		// 인증번호 비교 
    		$('#check-number-Btn').onclick(function () {
    			const inputCode = $(this).val();
    			const $resultMsg = $('#mail-check-warn');
    			const checkNum = $('#checkNum').val();
    			
    			if(inputCode === checkNum){
    				$resultMsg.html('인증번호가 일치합니다.');
    				$resultMsg.css('color','green');
    				$('#mail-Check-Btn').attr('disabled',true);
					$("#enrollForm button[type=submit]").attr("disabled", false);


    			}else{
    				$resultMsg.html('인증번호가 불일치 합니다. 다시 확인해주세요!.');
    				$resultMsg.css('color','red');
					$("#enrollForm button[type=submit]").attr("disabled", true);

    			}
    		});
    		
        </script>

		<script>

		// joinform_check 함수로 유효성 검사
		function formCheck() {
		  // 변수에 담아주기
			let memberId = document.getElementById('memberId');
			let memberPwd = document.getElementById('memberPwd');
			let checkPwd = document.getElementById('checkPwd');
			let memberName = document.getElementById('memberName');
			let email = document.getElementById('email');
			let phone = document.getElementById('phone');
			
		  if (memberId.value == "") { // 해당 입력값이 없을 경우 같은말: if(!uid.value)
		    alert("아이디를 입력하세요.");
		    memberId.focus(); // focus(): 커서가 깜빡이는 현상, blur(): 커서가 사라지는 현상
		    return false; // return: 반환하다 return false:  아무것도 반환하지 말아라 아래 코드부터 아무것도 진행하지 말것
		  };

		  if (memberPwd.value == "") {
		    alert("비밀번호를 입력하세요.");
		    memberPwd.focus();
		    return false;
		  };

		  // 비밀번호 영문자+숫자+특수조합(6~16자리 입력) 정규식
		  var pwdCheck = /^(?=.*[a-zA-Z])(?=.*[!@#$%^*+=-])(?=.*[0-9]).{6,16}$/;

		  if (!pwdCheck.test(memberPwd.value)) {
		    alert("비밀번호는 영문자+숫자+특수문자 조합으로 6~16자리 사용해야 합니다.");
		    memberPwd.focus();
		    return false;
		  };

		  if (checkPwd.value !== memberPwd.value) {
		    alert("비밀번호가 일치하지 않습니다..");
		    checkPwd.focus();
		    return false;
		  };

		  if (memberName.value == "") {
		    alert("이름을 입력하세요.");
		    memberName.focus();
		    return false;
		  };

		  if (email.value == "") {
		    alert("이메일 주소를 입력하세요.");
		    email.focus();
		    return false;
		  }
		  
		  var reg = /^[0-9]{2,3}-[0-9]{3,4}-[0-9]{4}/; // 숫자만 입력하는 정규식

		  if (!reg.test(phone.value)) {
		    alert("전화번호는 숫자만 입력할 수 있습니다.");
		    phone.focus();
		    return false;
		  }

		  //입력 값 전송
		  document.enrollForm.submit();  
		}
		
		</script>


    </div>

	<jsp:include page="../common/footer.jsp" />

</body>
</html>