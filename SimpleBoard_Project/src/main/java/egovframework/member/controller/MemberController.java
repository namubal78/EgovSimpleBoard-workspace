package egovframework.member.controller;

import java.util.ArrayList;
import java.util.Random;

import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import egovframework.common.model.service.CryptoAriaService;
import egovframework.common.model.vo.CommonVo;
import egovframework.common.template.EmailCheck;
import egovframework.common.template.Pagination;
import egovframework.member.model.service.MemberService;
import egovframework.member.model.vo.Member;

@Controller
public class MemberController {

	@Autowired
	private MemberService memberService;

	@Autowired
	private CryptoAriaService cryptoAriaService;
	
	@Autowired
	private EmailCheck emailCheck;
	 	
	/**
	 * 회원가입폼 연결
	 * @return
	 */
	@RequestMapping("enrollForm.me")
	public String memberEnrollForm() {
		return "member/memberEnrollForm";
	}
	
	/**
	 * 회원가입 아이디 중복 체크
	 * @param checkId // 입력한 ID
	 * @return
	 */
	@ResponseBody
	@RequestMapping(value="idCheck.me", produces="text/html; charset=UTF-8")
	public String idCheck(String checkId) {
		int count = memberService.idCheck(checkId);
		return (count > 0) ? "NNNNN" : "NNNNY";
	}
	

	/**
	 * 회원가입 이메일 인증
	 * @param param
	 * @return
	 */
	@ResponseBody
	@RequestMapping(value = "sendmail.do", produces="text/html; charset=UTF-8")
	public String sendmail(String email) {
		
		// 인증코드 생성
		Random r = new Random();
		int checkNum = r.nextInt(888888) + 111111;
		String code = Integer.toString(checkNum);
		
		try {
			String emailContent = "인증번호는\r\n" + checkNum + "\r\n입니다.\r\n입력 후, 인증하기 버튼을 눌러주세요.";
			emailCheck.sendMail(email, "간편 게시판 인증번호입니다.", emailContent);
		} catch (Exception e) {
			e.printStackTrace();
			return "";			
		}
		
		return code;
	}		
	
	/**
	 * 회원가입
	 * @param m
	 * @param model
	 * @param session
	 * @return
	 */
	@RequestMapping("insert.me")
	public String insertMember(Member m, Model model, HttpSession session) {
		
		// 입력한 비밀번호를 암호화
		String encPwd = cryptoAriaService.encryptData(m.getMemberPwd());
		
		// 암호화된 비밀번호를 Member 객체에 담기
		m.setMemberPwd(encPwd);
		
		// MEMBER 테이블에 INSERT
		int result = memberService.insertMember(m);
		
		if(result > 0) {
			session.setAttribute("alertMsg", "회원가입이 완료되었습니다.");
			return "redirect:/";

		} else {
			model.addAttribute("errorMsg", "회원가입을 실패했습니다.");
			return "common/errorPage";
		}
	}
	
	/**
	 * 로그인
	 * @param m
	 * @param mv
	 * @param session
	 * @param saveId
	 * @param response
	 * @return
	 * @throws Exception 
	 */
	@RequestMapping("login.me")
	public ModelAndView loginMember(Member m, ModelAndView mv, HttpSession session, String saveId, HttpServletResponse response) throws Exception {
		
		// 아이디 저장 여부 확인
		if(saveId != null && saveId.equals("y")) {
			
			// 요청 시 전달값 중에 saveId 가 y 라면 saveId 라는 키값으로 현재 아이디값의 쿠키 생성
			Cookie cookie = new Cookie("saveId", m.getMemberId());
			cookie.setMaxAge(24 * 60 * 60 * 1); // 유효기간 1일
			response.addCookie(cookie);
			
		} else {
			
			// 요청 시 전달값 중에 saveId 가 y 가 아니라면 쿠키 삭제
			Cookie cookie = new Cookie("saveId", m.getMemberId());
			cookie.setMaxAge(0); // 쿠키 삭제
			response.addCookie(cookie);
			
		}
		
		/*
		 * 여기서 RSA 암호화한 비밀번호 복호화 
		 */
//		Rsa r = new Rsa();
//		//로그인전에 세션에 저장된 개인키를 가져온다.
//		PrivateKey privateKey = (PrivateKey)session.getAttribute(Rsa.RSA_WEB_KEY);
//		//암호화 된 비밀번호를 복호화 시킨다.
//		String password = r.decryptRsa(privateKey, m.getMemberPwd());
//		// ShA 256 암호화 = 단방향 
//		String sha = EgovFileScrty.encryptPassword(password);
//		m.setMemberPwd(sha);
//		
//		System.out.println("sha: " + sha);
//		
		// 입력한 정보로 MEMBER 테이블 조회
		Member loginUser = memberService.loginMember(m);
		
		// 입력한 비밀번호의 암호화한 결과와 DB 비밀번호 일치 여부 검사
		if(loginUser != null && cryptoAriaService.encryptData(m.getMemberPwd()).equals(loginUser.getMemberPwd())) {
  
			session.setAttribute("loginUser", loginUser);
			// 비밀번호도 일치한다면 => 로그인 성공 session.setAttribute("loginUser", loginUser);
			session.setAttribute("alertMsg", "로그인 성공!"); mv.setViewName("redirect:/"); }
		else { // 로그인 실패 mv.addObject("errorMsg", "로그인실패");
		mv.setViewName("common/errorPage"); }
 
		return mv;
		
	}
	
	/**
	 * 로그아웃
	 * @param session
	 * @return
	 */
	@RequestMapping("logout.me")
	public String logoutMember(HttpSession session) {
		session.invalidate(); // 세션 삭제
		return "redirect:/";
		
	}
	
	/**
	 * 마이페이지 연결
	 * @return
	 */
	@RequestMapping("myPage.me")
	public String myPage() {
		return "member/myPage";
	}

	/**
	 * 관리자페이지 연결
	 * @return
	 */
	@RequestMapping("adminPage.me")
	public String adminPage() {
		return "admin/adminPage";
	}

	/**
	 * 관리자용 회원 상세 조회
	 * @param mno
	 * @param model
	 * @return
	 */
	@RequestMapping("memberPage.me")
	public String selectMemberPage(int mno, Model model) {
		
		Member m = memberService.selectMemberPage(mno);
		model.addAttribute("m", m);
		return "admin/adminMemberDetailView";
	}
	
	/**
	 * 회원정보 수정
	 * @param m
	 * @param model
	 * @param session
	 * @return
	 */
	@RequestMapping("update.me")
	public String updateMember(Member m, Model model, HttpSession session) {
		int result = memberService.updateMember(m);

		if(result > 0) {
			
			Member updateMember = memberService.loginMember(m);
			session.setAttribute("loginUser", updateMember);
			session.setAttribute("alertMsg", "회원 정보 수정이 성공했습니다.");
			return "redirect:/myPage.me";
			
		} else {
			
			model.addAttribute("errorMsg", "회원 정보 수정이 실패했습니다.");
			return "common/errorPage";

		}
	}
	
	/**
	 * 회원 탈퇴
	 * @param m
	 * @param model
	 * @param session
	 * @return
	 */
	@RequestMapping("delete.me")
	public String deleteMember(Member m, Model model, HttpSession session) {

		// 입력한 비밀번호 암호화
		String encPwd = cryptoAriaService.encryptData((m.getMemberPwd()));
		
		// Member 객체에 담기
		m.setMemberPwd(encPwd);
		
		int result = memberService.deleteMember(m);

		if(result > 0) {
			session.removeAttribute("loginUser"); // 세션 삭제
			session.setAttribute("alertMsg", "회원 탈퇴에 성공했습니다.");
			return "redirect:/";
		} else {
			model.addAttribute("errorMsg", "회원 탈퇴에 실패했습니다.");
			return "common/errorPage";
		}
	}
	
	/**
	 * 관리자용 회원 검색
	 * @param currentPage
	 * @param category
	 * @param keyword
	 * @param model
	 * @return
	 */
	@RequestMapping("memberList.me")
	public String selectMemberList(@RequestParam(value="cpage", defaultValue="1")int currentPage, @RequestParam(value="category", defaultValue="")String category, @RequestParam(value="keyword", defaultValue="")String keyword, Model model) {

		// 검색 및 페이징 처리
		CommonVo cvPi = new CommonVo();
		
		cvPi.setCategory(category);
		cvPi.setKeyword(keyword);		
		
		int listCount = memberService.selectMemberListCount(cvPi);
		
		int pageLimit = 5;
		int boardLimit = 5;
		
		CommonVo cv = Pagination.getPageInfo(category, keyword, listCount, currentPage, pageLimit, boardLimit);
		
		// ArrayList 에 담기
		ArrayList<Member> list = memberService.selectMemberList(cv);
		
		model.addAttribute("cv", cv);
		model.addAttribute("list", list);		
		
		return "admin/adminMemberListView";
	}
	
	/**
	 * 관리자 회원 탈퇴
	 * @param mno
	 * @param model
	 * @param session
	 * @return
	 */
	@RequestMapping("adminDelete.me")
	public String deleteAdminMember(int mno, Model model, HttpSession session) {
		
		int result = memberService.deleteAdminMember(mno);

		if(result > 0) {
			
			session.setAttribute("alertMsg", "탈퇴 처리에 성공했습니다.");
			return "redirect:/memberList.me";
		} else {
			
			model.addAttribute("errorMsg", "탈퇴 처리에 실패했습니다.");
			return "common/errorPage";
		}
		
	}	
	
}
