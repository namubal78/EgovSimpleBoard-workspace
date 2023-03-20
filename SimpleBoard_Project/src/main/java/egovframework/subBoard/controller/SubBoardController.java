package egovframework.subBoard.controller;

import java.io.File;
import java.io.IOException;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.ModelAndView;

import egovframework.common.model.vo.CommonVo;
import egovframework.common.template.Pagination;
import egovframework.subBoard.model.service.SubBoardService;
import egovframework.subBoard.model.vo.SubBoard;

@Controller
public class SubBoardController {

	@Autowired
	private SubBoardService subBoardService;
	
	@RequestMapping("list.sub")
	public String selectList(@RequestParam(value="cpage", defaultValue="1")int currentPage, @RequestParam(value="category", defaultValue="basic")String category, @RequestParam(value="keyword", defaultValue="nothing")String keyword, Model model) {
		
		CommonVo cvPi = new CommonVo();
		
		cvPi.setCategory(category);
		cvPi.setKeyword(keyword);
		
		int listCount = subBoardService.selectListCount(cvPi);

		int pageLimit = 5;
		int boardLimit = 5;
//		PageInfo pi = Pagination.getPageInfo(listCount, currentPage, pageLimit, boardLimit);
		CommonVo cv = Pagination.getPageInfo(category, keyword, listCount, currentPage, pageLimit, boardLimit);

		ArrayList<SubBoard> list = subBoardService.selectList(cv);
		
//		System.out.println("pi: " + pi);
//		System.out.println("list: " + list);
		
		model.addAttribute("cv", cv);
		model.addAttribute("list", list);
		
		return "subBoard/subBoardListView";
		
	}
//	
//	@RequestMapping("adminBoardList.bo")
//	public String selectAdminBoardList(@RequestParam(value="cpage", defaultValue="1")int currentPage, @RequestParam(value="category", defaultValue="basic")String category, @RequestParam(value="keyword", defaultValue="nothing")String keyword, Model model) {
//		
//		CommonVo cvPi = new CommonVo();
//		
//		cvPi.setCategory(category);
//		cvPi.setKeyword(keyword);
//		
//		int listCount = boardService.selectListCount(cvPi);
//
//		int pageLimit = 5;
//		int boardLimit = 5;
////		PageInfo pi = Pagination.getPageInfo(listCount, currentPage, pageLimit, boardLimit);
//		CommonVo cv = Pagination.getPageInfo(category, keyword, listCount, currentPage, pageLimit, boardLimit);
//
//		ArrayList<Board> list = boardService.selectList(cv);
//		
////		System.out.println("pi: " + pi);
////		System.out.println("list: " + list);
//		
//		model.addAttribute("cv", cv);
//		model.addAttribute("list", list);
//		
//		return "member/adminBoardList";
//		
//	}
	
//	@RequestMapping("myList.sub")
//	public String selectMyList(@RequestParam(value="cpage", defaultValue="1")int currentPage, int mno, Model model) {
//				
//		int listCount = subBoardService.selectMyListCount(mno);
//		
//		int pageLimit = 5;
//		int boardLimit = 5;
//		
//		CommonVo cv = Pagination.getPageInfo(listCount, currentPage, pageLimit, boardLimit);
//		
//		ArrayList<SubBoard> list = subBoardService.selectMyList(cv, mno);
//		
////		System.out.println("pi: " + pi);
////		System.out.println("list: " + list);
//		
//		model.addAttribute("cv", cv);
//		model.addAttribute("list", list);
//		model.addAttribute("mno", mno);
//		
//		return "member/myList";
//	}
	
	@RequestMapping("detail.sub")
	public ModelAndView selectBoard(int subBno, ModelAndView mv) {

		int result = subBoardService.increaseCount(subBno);

		if(result > 0) {
			SubBoard b = subBoardService.selectBoard(subBno);
			
			mv.addObject("b", b).setViewName("subBoard/subBoardDetailView");
		} else {
			mv.addObject("errorMsg", "게시글 조회에 실패했습니다.").setViewName("common/errorPage");
		}
		
		return mv;
	}
	
	@RequestMapping("enrollForm.sub")
	public String boardEnrollForm() {
		return "subBoard/subBoardEnrollForm";
	}
	
	@RequestMapping("insert.sub")
	public ModelAndView insertBoard(SubBoard b, MultipartFile upfile, HttpSession session, ModelAndView mv) {

		
		// 전달된 파일이 있을 경우 => 파일명 수정 작업 후 서버로 업로드
		// => 원본명, 서버에 업로드된 경로를 이어붙이기
		if(!upfile.getOriginalFilename().equals("")) {
		
			String changeName = saveFile(upfile, session);			
						
			// 8. 원본명, 서버에 업로드 된 수정명을 Board b 에 담기
			// => boardTitle, boardContent, boardWriter 필드에만 값이 담겨있음
			// => originName, changeName 필드에도 전달된 파일에 대한 정보를 담을것
			b.setSubOriginName(upfile.getOriginalFilename());
			b.setSubChangeName("uploadFiles/" + changeName); 
			// 실제 경로도 같이 이어붙일것(FILE_PATH 컬럼을 따로 빼두지 않음)
		}
				
		// 넘어온 첨부파일이 있을 경우 b : 제목, 작성자, 내용, 원본파일명, 경로 + 수정파일명
		// 넘어온 첨부파일이 없을 경우 b : 제목, 작성자, 내용
		int result = subBoardService.insertBoard(b);

		if(result > 0) { // 성공 => 게시글 리스트 페이지로 url 재요청(list.bo)
			
			session.setAttribute("alertMsg", "성공적으로 게시글이 등록되었습니다.");
			
			mv.setViewName("redirect:/list.sub");
		}
		else { // 실패 => 에러페이지로 포워딩
			
			// mv.addObject("errorMsg", "게시글 작성 실패");
			// mv.setViewName("common/errorPage");
			
			// addObject 메소드의 반환형은 ModelAndView 타입임
			// => 다음과 같이 메소드 체이닝도 가능
			mv.addObject("errorMsg", "게시글 작성 실패").setViewName("common/errorPage");
		}
		
		return mv;		
		
	}
	
	// 현재 넘어온 첨부파일 그 자체를 수정명으로 서버의 폴더에 저장시키는 메소드 (일반메소드)
	// => Spring 의 Controller 메소드는 반드시 요청을 처리하는 역할이 아니어도 됨
	public String saveFile(MultipartFile upfile, HttpSession session) {
		
		// 파일명 수정 작업 후 서버에 업로드 시키기
		// 예) "flower.png" => "2022112210405012345.png"
		// 1. 원본파일명 뽑아오기
		String originName = upfile.getOriginalFilename(); // "flower.png"
		
		// 2. 시간 형식을 문자열로 뽑아내기
		String currentTime =  new SimpleDateFormat("yyyyMMddHHmmss").format(new Date());
		
		// 3. 뒤에 붙을 5자리 랜덤값 뽑기
		int ranNum = (int)(Math.random() * 90000) + 10000; // 5자리 랜덤값
		
		// 4. 원본 파일로부터 확장자만 뽑기
		String ext = originName.substring(originName.lastIndexOf(".")); //
		
		// 5. 모두 이어 붙이기
		String changeName = currentTime + ranNum + ext;
		
		// 6. 업로드 하고자 하는 서버의 물리적인 실제 경로 알아내기
		String savePath = session.getServletContext().getRealPath("/uploadFiles/");
		
		// 7. 경로와 수정파일명을 합체 후 파일을 업로드해주기
		try {
			upfile.transferTo(new File(savePath + changeName));
		} catch (IllegalStateException | IOException e) {
			e.printStackTrace();
		}
		
		return changeName;
	}
	
	@RequestMapping("delete.sub")
	public String deleteBoard(int subBno, String filePath, HttpSession session, Model model) {
				
		int result = subBoardService.deleteBoard(subBno);
		
		if(result > 0) { // 게시글 삭제 성공
			
			// 첨부파일이 있을 경우 => 파일 삭제
			// filePath 에는 해당 게시글의 수정파일명이 들어있음
			// filePath 값이 빈 문자열이 아니라면 첨부파일이 있었던 경우임
			if(!filePath.equals("")) {
				
				String realPath = session.getServletContext().getRealPath(filePath);
				new File(realPath).delete();
			}
			
			// 게시판 리스트 페이지 url 재요청
			session.setAttribute("alertMsg", "성공적으로 게시글이 삭제되었습니다.");
			
			return "redirect:/list.sub";
		}
		else { // 게시글 삭제 실패
			
			model.addAttribute("errorMsg", "게시글 삭제 실패");
			
			return "common/errorPage";
		}
	}	
	
//	@RequestMapping("adminDelete.bo")
//	public String deleteAdminBoard(int bno, int mno, String filePath, HttpSession session, Model model) {
//		int result = boardService.deleteAdminBoard(bno);
//		if(result > 0) { // 게시글 삭제 성공
//
//			// 첨부파일이 있을 경우 => 파일 삭제
//			// filePath 에는 해당 게시글의 수정파일명이 들어있음
//			// filePath 값이 빈 문자열이 아니라면 첨부파일이 있었던 경우임
//			if(!filePath.equals("")) {
//
//				String realPath = session.getServletContext().getRealPath(filePath);
//				new File(realPath).delete();
//			}
//			
//			// 게시글 관리 페이지 url 재요청
//			session.setAttribute("alertMsg", "성공적으로 게시글이 삭제되었습니다.");
////			String returnStr = "redirect:/myList.bo?mno=" + Integer.toString(mno);
//			return "redirect:/adminBoardList.bo";
//		}
//		else { // 게시글 삭제 실패
//			
//			model.addAttribute("errorMsg", "게시글 삭제 실패");
//			
//			return "common/errorPage";
//		}
//	}	

	
}
