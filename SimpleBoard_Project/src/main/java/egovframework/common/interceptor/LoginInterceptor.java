package egovframework.common.interceptor;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

public class LoginInterceptor {

	// 선처리용 preHandler 메소드 오버라이딩
	public boolean preHandle(HttpServletRequest request, HttpServletResponse response, Object Handler) throws Exception {
		
		// boolean 리턴 => true / false
		// true 리턴했을 시 : 기존 요청 흐름대로 해당 Controller 가 제대로 실행
		// false 리턴했을 시 : Controller 가 실행되지 않음
		
		// 로그인 유무 검사를 위한 Session 객체 얻어내기
		HttpSession session = request.getSession();
		
		// loginUser 키값이 있나 검사
		if(session.getAttribute("loginUser") != null) {
			// 현재 요청을 보낸 사람이 로그인 되어있는 상태라면
			// => Controller 가 실행
			return true;
			
		} else {
			// 현재 요청을 보낸 사람이 로그인 되어있지 않은 상태라면
			// => Controller 실행 막기
			
			// alertMsg 로 "로그인 후 이용 가능한 서비스입니다." 알람메세지 담기
			session.setAttribute("alertMsg", "로그인 후 이용 가능한 서비스입니다.");
			
			// 응답뷰 지정 (메인페이지로 url 재요청)
			response.sendRedirect(request.getContextPath());
			
			
			return false;
		}
		
		
		
		
		
		
		
	}
	
}
