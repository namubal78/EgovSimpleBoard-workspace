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
	.mail-check-box>input,button,span  {
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

            <form action="insert.me" method="post" id="enrollForm">
				<table id="memberEnrollForm" align="center" >
					<tr>
						<th align="left" colspan="3">* 아이디</th>
					</tr>
					<tr style="display: inline-block;">
						<td colspan="3">
							<input class="form-control" type="text" placeholder="영문, 숫자 조합 6~16자 입력해주세요" minlength="6" maxlength="16" style="width: 400px;" name="memberId" id="newMemberId" required>
						</td>
						<td>
							<button type="button" class="btn btn-primary" style="width:100px" name="idCheck" id="idCheckbtn">중복확인</button>
						</td>
					</tr>
					<tr>
						<th colspan="3">* 비밀번호</th>
					</tr>
					<tr>
						<td colspan="3">
							<input type="password" class="form-control" placeholder="영문자, 숫자, 특수문자(,./;'[]\ 제외) 조합 6~16자 입력해주세요" minlength="6" maxlength="16" style="width:500px" name="memberPwd" id="newMemberPwd">
						</td>
					</tr>
					<tr>
						<th colspan="3">* 비밀번호 재확인</th>
					</tr>
					<tr>
						<td colspan="3">
							<input type="password" class="form-control" placeholder="동일하게 한 번 더 입력해주세요" style="width: 500px;" name="checkPwd" id="checkPwd">
						</td>
					</tr>
					<tr>
						<th colspan="3">* 이름</th>
					</tr>
					<tr>
						<td colspan="3">
							<input type="text" class="form-control" placeholder="한글 1~4자리 입력해주세요" style="width: 500px;" name="memberName" id="memberName">
						</td>
					</tr>
					<tr>
						<th colspan="3">* 휴대폰번호</th>
					</tr>
					<tr>
						<td colspan="3"> 
							<input type="tel" class="form-control" placeholder="- 포함 13자리 입력해주세요" maxlength="13" style="width: 500px;" name="phone" id="phone">
						</td>
					</tr>
					<tr>
						<th colspan="3">* 이메일</th>
					</tr>
					<tr style="display: inline-block;">
						<td>
							<input type="text" class="form-control" placeholder="@ 포함해서 입력해주세요" style="width: 400px;" id="email" name="email" maxlength="30">
						</td>
						<td>
							<button type="button" class="btn btn-primary" id="mail-Check-Btn" style="width: 100px;">번호받기</button>
						</td>
					</tr>
					<tr style="display: inline-block;">
						<td class="mail-check-box">
							<input class="form-control mail-check-input" placeholder="인증번호 6자리를 입력해주세요" disabled="disabled" maxlength="6" style="width: 400px;" required>
						</td>
						<td>
							<button type="button" class="btn btn-primary" id="check-number-Btn" style="width: 100px;">인증하기</button>
						</td>
					</tr>
					<tr>
						<td colspan="3"><input type="hidden" id="checkNum" value=""></td>
					</tr>

				</table>

				<div align="center" style="padding: 15px 0px; margin-top: 30px;">
					<button class="btn btn-primary" id="enrollbtn" type="submit" style="width: 140px; height: 40px;" onclick="return validate();" disabled="disabled">가입하기</button>
					<button class="btn btn-danger" style="width: 140px; height: 40px;" type="reset">초기화</button>
				</div>
			</form>
        </div>
        <br><br>
        
        <script>
        
	        function validate() { // submit 전 유효성 검사(아이디, 이메일은 별도 체크 통해서 검사)
	            
	            var memberPwd = document.getElementById("newMemberPwd");
	            var checkPwd = document.getElementById("checkPwd");
	            var memberName = document.getElementById("memberName");
	            var phone = document.getElementById("phone");

	            var regExp = /^[a-zA-Z\\d`~!@#$%^&*()-_=+]{6,16}$/;
	            if(!regExp.test(memberPwd.value)) { // 비밀번호 유효성 검증
	               
	          	  alert("영문자, 숫자, 특수문자(,./;'[]\ 제외) 조합 6~16자 입력해주세요");
	               
	          	  memberPwd.value = "";
	              memberPwd.focus(); // 재입력 유도
	              return false;
	            }
	            
	            if($("input[id=newMemberPwd]").val() != $("input[name=checkPwd]").val()) { // 비밀번호 동일 검증
	              
	            	alert("비밀번호가 일치하지 않습니다.");
	              checkPwd.select(); // 재입력 유도
	              return false;
	            }
	            
	            regExp = /^[가-힣]{1,4}$/;
	            if(!regExp.test(memberName.value)) { // 이름 유효성 검증
	                
	            	alert("한글로 된 1~4자리 이름을 입력해주세요.");
	              	memberName.select(); // 재입력 유도
	              	return false;
	            }
	            
	            regExp = /^\d{3}-\d{3,4}-\d{4}$/;
	            if(!regExp.test(phone.value)) { // 연락처 유효성 검증
	            	
	            	alert("-를 포함 핸드폰 13자리를 입력해주세요.");
	                phone.select(); // 재입력 유도
	                return false;
	            }
	        }
        
        </script>
        
        <script>
	        
        	$('#idCheckbtn').click(function() { // 중복 체크 전 아이디 유효성 검사 함수
        		
    	        let memberId = document.getElementById("newMemberId");
	            let regExp = /^(?=.*[a-zA-Z])(?=.*[0-9]).{6,16}$/;
	            
	            if(!regExp.test(memberId.value)) { // 아이디 유효성 검증 탈락 시
	                
	          		alert("영문, 숫자를 포함하여 6자 이상 16자 이하로 입력해주세요.");
	                memberId.select(); // 재입력 유도
	                return false;
	            }
	            
            	idCheck(); // 중복 체크 함수 호출
 
        	});    
        
        	function idCheck() { // 아이디 중복 체크 ajax
        		        		
        		// 아이디를 입력받는 input 요소 객체를 변수에 담아두기
        		let $idInput = $("#enrollForm input[name=memberId]");
        		let idCheckbtn = $("#idCheckbtn");
       			
				// ajax 를 요청하여 중복체크
				$.ajax({
					url : "idCheck.me",
					data : {checkId : $idInput.val()},
					success : function(result) {
														
						console.log(result);
						
						if(result == "NNNNN") { // 사용 불가
							
							alert("이미 사용중이거나 탈퇴한 아이디입니다.");
							
						} else { // 사용 가능
							
							alert("사용할 수 있는 아이디입니다.");
							// 중복 체크 버튼 비활성화
							$(idCheckbtn).prop("disabled", true);
							// 아이디 입력창 readonly
							$($idInput).attr("readonly", true);

						}
					},
					error : function() {
						console.log("아이디 중복 체크용 ajax 통신 실패!");
					}
				});
        	}
        	
        </script>
        
        <script>
        	
    		$('#mail-Check-Btn').click(function() { // 인증 번호 받기 전 이메일 유효성 검사 함수
    			
	            let email = document.getElementById("email"); // 사용자 입력 값
	            let regExp = /^([a-zA-Z0-9._%-]+@[a-zA-Z0-9.-]+.[a-zA-Z]{2,6})*$/;
	            
	            if(!regExp.test(email.value)) { // 이메일 유효성 검증 탈락 시
	                
	          		alert("올바른 이메일 형식이 아닙니다.");
	                email.select(); // 재입력 유도
	                return false;
	            }
	                			
    			sendmail(); // 인증번호 받기 함수 호출
    		});
    		
    		function sendmail() { // 인증번호 받기 ajax

    			var email = document.getElementById('email').value;
    			    			
    			$.ajax({
    				url: "sendmail.do",
    				data: {email:email},
    				success: function(result) {
    					
    					alert("인증번호를 메일로 보냈습니다.");
   						$('#checkNum').val(result); // 인증 번호    
        				$('.mail-check-input').attr('disabled',false);
    				},
    				error: function() {
    				}
    			
    			});
    			
    		} 

    		
    		// 인증번호 비교 
    		$('#check-number-Btn').click(function () {
    			
    			checkNum();
    		});
    		
    		function checkNum() {
    			
    			const inputCode = $('.mail-check-input').val(); // 사용자 입력 값
    			const checkNum = $('#checkNum').val(); // 인증 번호
    			console.log(checkNum);
    			
    			if(inputCode == checkNum){ // 일치 시

    				alert("인증번호가 일치합니다.");
    				$('#check-number-Btn').prop('disabled',true);
    				$('#enrollbtn').prop('disabled', false);
					// 인증번호 입력창 readonly
					$('.mail-check-input').attr("readonly", true);
					$('#mail-Check-Btn').attr("disabled", true);

    			}else{

    				alert("인증번호가 불일치 합니다. 다시 확인해주세요!.");

    			}
    		}
    		
        </script>

    </div>

	<jsp:include page="../common/footer.jsp" />

</body>
</html>