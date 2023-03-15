package egovframework.member.controller;

import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import egovframework.member.model.service.MemberService;
import egovframework.member.model.vo.Member;

@Controller
public class MemberController {

	@Autowired
	private MemberService memberService;

//	
//	// 비밀번호 암호화를 위한 변수
//	@Autowired
//	private BCryptPasswordEncoder bcryptPasswordEncoder;
	
	@RequestMapping("enrollForm.me")
	public String memberEnrollForm() {
		return "member/memberEnrollForm";
	}
	
	
	@ResponseBody
	@RequestMapping(value="idCheck.me", produces="text/html; charset=UTF-8")
	public String idCheck(String checkId) {
		
		int count = memberService.idCheck(checkId);

		return (count > 0) ? "NNNNN" : "NNNNY";
	}
	
	@RequestMapping("insert.me")
	public String insertMember(Member m, Model model, HttpSession session) {
		System.out.println("m: " + m);

		int result = memberService.insertMember(m);
		
		if(result > 0) {
			session.setAttribute("alertMsg", "회원가입이 완료되었습니다.");
			return "redirect:/";

		} else {
			model.addAttribute("errorMsg", "회원가입을 실패했습니다.");
			return "common/errorPage";

		}
	}
	
	@RequestMapping("login.me")
	public ModelAndView loginMember(Member m, ModelAndView mv, HttpSession session, String saveId, HttpServletResponse response) {
		
		if(saveId != null && saveId.equals("y")) {
			
			// 요청 시 전달값 중에 saveId 가 y 라면 saveId 라는 키값으로 현재 아이디값을 쿠키 생성
			Cookie cookie = new Cookie("saveId", m.getMemberId());
			cookie.setMaxAge(24 * 60 * 60 * 1); // 유효기간 1일
			response.addCookie(cookie);
			
		} else {
			
			// 요청 시 전달값 중에 saveId 가 y 가 아니라면 쿠키 삭제
			Cookie cookie = new Cookie("saveId", m.getMemberId());
			cookie.setMaxAge(0); // 쿠키가 삭제되는 효과
			response.addCookie(cookie);
			
			
		}
//		
//		// 암호화 작업 후 로직
//		// => BCrypt 방식에 의해 복호화가 불가능한 암호문 형태의 비밀번호와 일치하는지 대조작업
//		// Member m 의 userId 필드 : 사용자가 입력한 아이디 (평문)
//		// 			  userPwd 필드 : 사용자가 입력한 비밀번호 (평문)
//		Member loginUser = memberService.loginMember(m);
//		
//		// loginUser : 오로지 아이디만으로 조회된 회원의 정보
//		// Member 타입의 loginUser 의 userPwd 필드 : DB 에 기록된 암호화된 비밀번호
//		
//		// BCryptPasswordEncoder 객체의 matches 메소드
//		// matches (평문, 암호문) 을 작성하면 내부적으로 평문과 암호문을 맞추는 작업이 이루어짐
//		// 두 구문이 일치하는지 비교 후 일치하면 true 반환
//		if(loginUser != null &&
//				bcryptPasswordEncoder.matches(m.getUserPwd(), loginUser.getUserPwd())) {
//			
//			// 비밀번호도 일치한다면 => 로그인 성공
//			session.setAttribute("loginUser", loginUser);
//			
//			session.setAttribute("alertMsg", "로그인 성공!");
//			
//			mv.setViewName("redirect:/");
//		}
//		else {
//			
//			// 로그인 실패
//			mv.addObject("errorMsg", "로그인실패");
//			
//			// /WEB-INF/views/common/errorPage.jsp
//			mv.setViewName("common/errorPage");
//		}
//		
//		return mv;
		
		
		// 암호화 작업 전 로직
		
		Member loginUser = memberService.loginMember(m);
		
		if(loginUser == null) { // 로그인 실패
			
			// model.addAttribute("errorMsg", "로그인 실패");
			mv.addObject("errorMsg", "로그인 실패");
			
			// return "common/errorPage";
			mv.setViewName("common/errorPage"); // 포워딩
			// ModelAndView 객체를 이용해서 응답페이지를 지정할 경우에도
			// 또한 ViewResolver 에 의해 접두어와 접미어를 생략한 형태로 지정해야만 한다!!
		}
		else { // 로그인 성공
			
			session.setAttribute("loginUser", loginUser);
			
			// return "redirect:/";
			mv.setViewName("redirect:/"); // url 재요청방식
		}
		
		// 잘 셋팅한 mv 리턴
		return mv;
		
	}
	
	@RequestMapping("logout.me")
	public String logoutMember(HttpSession session) {
		
		session.invalidate();
		return "redirect:/";
		
	}
	
	@RequestMapping("myPage.me")
	public String myPage() {
		return "member/myPage";
	}
	
	@RequestMapping("update.me")
	public String updateMember(Member m, Model model, HttpSession session) {
		System.out.println(m);
		int result = memberService.updateMember(m);
		System.out.println(result);

		if(result > 0) {
			Member updateMember = memberService.loginMember(m);
			session.setAttribute("loginUser", updateMember);
			session.setAttribute("alertMsg", "회원 정보 수정이 성공했습니다.");
			System.out.println("updateMember: " + updateMember);
			return "redirect:/myPage.me";
			
		} else {
			model.addAttribute("errorMsg", "회원 정보 수정이 실패했습니다.");
			return "common/errorPage";

		}
	}
	
	@RequestMapping("delete.me")
	public String deleteMember(Member m, Model model, HttpSession session) {
		int result = memberService.deleteMember(m);

		if(result > 0) {
			session.removeAttribute("loginUser");
			session.setAttribute("alertMsg", "회원 탈퇴에 성공했습니다.");
			return "redirect:/";
		} else {
			model.addAttribute("errorMsg", "회원 탈퇴에 실패했습니다.");
			return "common/errorPage";
		}
		
		
	}
	
	
}
