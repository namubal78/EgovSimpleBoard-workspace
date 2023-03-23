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
	 * @return
	 */
	@RequestMapping("enrollForm.me")
	public String memberEnrollForm() {
		return "member/memberEnrollForm";
	}
	
	/**
	 * @param checkId
	 * @return
	 */
	@ResponseBody
	@RequestMapping(value="idCheck.me", produces="text/html; charset=UTF-8")
	public String idCheck(String checkId) {
		int count = memberService.idCheck(checkId);
		return (count > 0) ? "NNNNN" : "NNNNY";
	}
	

	/**
	 * @param param
	 * @return
	 */
	@ResponseBody
	@RequestMapping(value = "sendmail.do", produces="text/html; charset=UTF-8")
	public String sendmail(String email) {
		
		Random r = new Random();
		int checkNum = r.nextInt(888888) + 111111;
		String code = Integer.toString(checkNum);
		
		try {

			String emailContent = "인증번호는\r\n" + checkNum + "\r\n입니다.";
			
			emailCheck.sendMail(email, "간편 게시판 인증번호", emailContent);
		} catch (Exception e) {
			e.printStackTrace();
			return "";			
		}
		
		return code;
	}		
	
	/**
	 * @param m
	 * @param model
	 * @param session
	 * @return
	 */
	@RequestMapping("insert.me")
	public String insertMember(Member m, Model model, HttpSession session) {
		
		String encPwd = cryptoAriaService.encryptData(m.getMemberPwd());
		
		m.setMemberPwd(encPwd);
				
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
	 * @param m
	 * @param mv
	 * @param session
	 * @param saveId
	 * @param response
	 * @return
	 */
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
		
		Member loginUser = memberService.loginMember(m);
		
		if(loginUser != null && cryptoAriaService.encryptData(m.getMemberPwd()).equals(loginUser.getMemberPwd())) {
  
			session.setAttribute("loginUser", loginUser);
			// 비밀번호도 일치한다면 => 로그인 성공 session.setAttribute("loginUser", loginUser);
			session.setAttribute("alertMsg", "로그인 성공!"); mv.setViewName("redirect:/"); }
		else { // 로그인 실패 mv.addObject("errorMsg", "로그인실패");
		mv.setViewName("common/errorPage"); }
 
		return mv;
		
	}
	
	/**
	 * @param session
	 * @return
	 */
	@RequestMapping("logout.me")
	public String logoutMember(HttpSession session) {
		session.invalidate();
		return "redirect:/";
		
	}
	
	/**
	 * @return
	 */
	@RequestMapping("myPage.me")
	public String myPage() {
		return "member/myPage";
	}

	/**
	 * @param mno
	 * @param model
	 * @return
	 */
	@RequestMapping("memberPage.me")
	public String selectMemberPage(int mno, Model model) {
		
		Member m = memberService.selectMemberPage(mno);
		model.addAttribute("m", m);
		return "member/memberPage";
	}
		
	/**
	 * @return
	 */
	@RequestMapping("adminPage.me")
	public String adminPage() {
		return "member/adminPage";
	}
	
	/**
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
	 * @param m
	 * @param model
	 * @param session
	 * @return
	 */
	@RequestMapping("delete.me")
	public String deleteMember(Member m, Model model, HttpSession session) {

		String encPwd = cryptoAriaService.encryptData((m.getMemberPwd()));
		
		m.setMemberPwd(encPwd);
		
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
	
	/**
	 * @param currentPage
	 * @param category
	 * @param keyword
	 * @param model
	 * @return
	 */
	@RequestMapping("memberList.me")
	public String selectMemberList(@RequestParam(value="cpage", defaultValue="1")int currentPage, @RequestParam(value="category", defaultValue="basic")String category, @RequestParam(value="keyword", defaultValue="nothing")String keyword, Model model) {

		CommonVo cvPi = new CommonVo();
		
		cvPi.setCategory(category);
		cvPi.setKeyword(keyword);		
		
		int listCount = memberService.selectMemberListCount(cvPi);
		
		int pageLimit = 5;
		int boardLimit = 5;
		
		CommonVo cv = Pagination.getPageInfo(category, keyword, listCount, currentPage, pageLimit, boardLimit);
		
		ArrayList<Member> list = memberService.selectMemberList(cv);
		
		model.addAttribute("cv", cv);
		model.addAttribute("list", list);		
		
		return "member/memberList";
	}
	
	/**
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
