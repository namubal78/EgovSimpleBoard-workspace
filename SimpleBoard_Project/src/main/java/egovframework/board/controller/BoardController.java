package egovframework.board.controller;

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
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.ModelAndView;

import com.google.gson.Gson;

import egovframework.board.model.service.BoardService;
import egovframework.board.model.vo.Board;
import egovframework.board.model.vo.Reply;
import egovframework.common.model.vo.CommonVo;
import egovframework.common.template.Pagination;
import egovframework.subBoard.model.service.SubBoardService;
import egovframework.subBoard.model.vo.SubBoard;

/**
 * @author GASystem
 *
 */
@Controller
public class BoardController {

	@Autowired
	private BoardService boardService;
	
	@Autowired
	private SubBoardService subBoardService;
	
	/**
	 * @param model
	 * @return
	 */
	@RequestMapping("mainList.bo")
	public String mainList(Model model) {
		
		ArrayList<Board> list = boardService.selectMainList();		
		ArrayList<SubBoard> subList = subBoardService.selectMainList();

		model.addAttribute("list", list);
		model.addAttribute("subList", subList);
		
		return "main";
		
	}
	
	/**
	 * @param currentPage
	 * @param category
	 * @param keyword
	 * @param model
	 * @return
	 */
	@RequestMapping("list.bo")
	public String selectList(@RequestParam(value="cpage", defaultValue="1")int currentPage, @RequestParam(value="category", defaultValue="basic")String category, @RequestParam(value="keyword", defaultValue="nothing")String keyword, Model model) {
		
		CommonVo cvPi = new CommonVo();
		
		cvPi.setCategory(category);
		cvPi.setKeyword(keyword);
		
		int listCount = boardService.selectListCount(cvPi);

		int pageLimit = 5;
		int boardLimit = 5;
		CommonVo cv = Pagination.getPageInfo(category, keyword, listCount, currentPage, pageLimit, boardLimit);

		ArrayList<Board> list = boardService.selectList(cv);

		model.addAttribute("cv", cv);
		model.addAttribute("list", list);
		
		return "board/boardListView";
		
	}
	
	/**
	 * @param currentPage
	 * @param category
	 * @param keyword
	 * @param model
	 * @return
	 */
	@RequestMapping("adminBoardList.bo")
	public String selectAdminBoardList(@RequestParam(value="cpage", defaultValue="1")int currentPage, @RequestParam(value="category", defaultValue="basic")String category, @RequestParam(value="keyword", defaultValue="nothing")String keyword, Model model) {
		
		CommonVo cvPi = new CommonVo();
		
		cvPi.setCategory(category);
		cvPi.setKeyword(keyword);
		
		int listCount = boardService.selectListCount(cvPi);

		int pageLimit = 5;
		int boardLimit = 5;
		CommonVo cv = Pagination.getPageInfo(category, keyword, listCount, currentPage, pageLimit, boardLimit);

		ArrayList<Board> list = boardService.selectList(cv);
		
		model.addAttribute("cv", cv);
		model.addAttribute("list", list);
		
		return "member/adminBoardList";
		
	}
	
	/**
	 * @param currentPage
	 * @param mno
	 * @param model
	 * @return
	 */
	@RequestMapping("myList.bo")
	public String selectMyList(@RequestParam(value="cpage", defaultValue="1")int currentPage, int mno, Model model) {
				
		int listCount = boardService.selectMyListCount(mno);
		
		int pageLimit = 5;
		int boardLimit = 5;
		
		CommonVo cv = Pagination.getPageInfo(listCount, currentPage, pageLimit, boardLimit);
		
		ArrayList<Board> list = boardService.selectMyList(cv, mno);
		
		model.addAttribute("cv", cv);
		model.addAttribute("list", list);
		model.addAttribute("mno", mno);
		
		return "member/myList";
	}
	
	/**
	 * @param bno
	 * @param mv
	 * @return
	 */
	@RequestMapping("detail.bo")
	public ModelAndView selectBoard(int bno, ModelAndView mv) {

		int result = boardService.increaseCount(bno);

		if(result > 0) {
			Board b = boardService.selectBoard(bno);
			mv.addObject("b", b).setViewName("board/boardDetailView");
		} else {
			mv.addObject("errorMsg", "게시글 조회에 실패했습니다.").setViewName("common/errorPage");
		}
		
		return mv;
	}
	
	
	/**
	 * @param bno
	 * @return
	 */
	@ResponseBody
	@RequestMapping(value="rlist.bo", produces="application/json; charset=UTF-8")
	public String ajaxSelectReplyList(int bno) {
		ArrayList<Reply> list = boardService.ajaxSelectReplyList(bno);
		return new Gson().toJson(list);
	  
	}
  
	/**
	 * @param r
	 * @return
	 */
	@ResponseBody
	@RequestMapping(value="rinsert.bo", produces="text/html; charset=UTF-8")
	public String ajaxInsertReply(Reply r) {
		int result = boardService.ajaxInsertReply(r);  
		return (result > 0) ? "success" : "fail";
	}
	
	/**
	 * @param replyNo
	 * @return
	 */
	@ResponseBody
	@RequestMapping(value="rdelete.re", produces="text/html; charset=UTF-8")
	public String ajaxDeleteReviewReply(int replyNo) {
		int result = boardService.ajaxDeleteReply(replyNo);
 		return (result > 0 ) ? "success" : "fail";
	}
	
	/**
	 * @return
	 */
	@RequestMapping("enrollForm.bo")
	public String boardEnrollForm() {
		return "board/boardEnrollForm";
	}
	
	/**
	 * @param b
	 * @param upfile
	 * @param session
	 * @param mv
	 * @return
	 */
	@RequestMapping("insert.bo")
	public ModelAndView insertBoard(Board b, MultipartFile upfile, HttpSession session, ModelAndView mv) {

		if(!upfile.getOriginalFilename().equals("")) {
		
			String changeName = saveFile(upfile, session);			
						
			b.setOriginName(upfile.getOriginalFilename());
			b.setChangeName("uploadFiles/" + changeName); 
		}
		
		int result = boardService.insertBoard(b);

		if(result > 0) { // 성공 => 게시글 리스트 페이지로 url 재요청(list.bo)
			
			session.setAttribute("alertMsg", "성공적으로 게시글이 등록되었습니다.");
			
			mv.setViewName("redirect:/list.bo");
		}
		else { // 실패 => 에러페이지로 포워딩

			mv.addObject("errorMsg", "게시글 작성 실패").setViewName("common/errorPage");
		}
		
		return mv;		
		
	}
	
	/**
	 * @param upfile
	 * @param session
	 * @return
	 */
	public String saveFile(MultipartFile upfile, HttpSession session) {
		

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
	
	/**
	 * @param bno
	 * @param model
	 * @return
	 */
	@RequestMapping("updateForm.bo")
	public String updateForm(int bno, Model model) {
		
		Board b = boardService.selectBoard(bno);
		model.addAttribute("b", b);
		
		return "board/boardUpdateForm";
	}
	
	/**
	 * @param b
	 * @param reupfile
	 * @param session
	 * @param model
	 * @return
	 */
	@RequestMapping("update.bo")
	public String updateBoard(Board b, MultipartFile reupfile, HttpSession session, Model model) {
		
		// 새로 넘어온 첨부파일이 있는 경우
		if(!reupfile.getOriginalFilename().equals("")) {
			
			// 1. 기존 첨부파일이 있었을 경우 => 기존 첨부파일을 찾아서 삭제
			if(b.getOriginName() != null) {
				String realPath = session.getServletContext().getRealPath(b.getChangeName());
				new File(realPath).delete();
			}
			
			// 2. 새로 넘어온 첨부파일을 수정명으로 바꾸고 서버에 업로드 시키기
			String changeName = saveFile(reupfile, session);
			
			// 3. b 객체에 새로 넘어온 첨부파일에 대한 원본명, 수정파일명 필드에 담기
			b.setOriginName(reupfile.getOriginalFilename());
			b.setChangeName("uploadFiles/" + changeName);
		}
		
		int result = boardService.updateBoard(b);
		
		if(result > 0) { // 게시글 수정 성공
			
			session.setAttribute("alertMsg", "성공적으로 게시글이 수정되었습니다.");
			
			return "redirect:/detail.bo?bno=" + b.getBoardNo();
		}
		else { // 게시글 수정 실패
			
			model.addAttribute("errorMsg", "게시글 수정 실패");
			
			return "common/errorPage";
		}
	}
	
	
	/**
	 * @param bno
	 * @param filePath
	 * @param session
	 * @param model
	 * @return
	 */
	@RequestMapping("delete.bo")
	public String deleteBoard(int bno, String filePath, HttpSession session, Model model) {
				
		int result = boardService.deleteBoard(bno);
		
		if(result > 0) { // 게시글 삭제 성공

			if(!filePath.equals("")) {
				
				String realPath = session.getServletContext().getRealPath(filePath);
				new File(realPath).delete();
			}
			
			session.setAttribute("alertMsg", "성공적으로 게시글이 삭제되었습니다.");
			
			return "redirect:/list.bo";
		}
		else { // 게시글 삭제 실패
			
			model.addAttribute("errorMsg", "게시글 삭제 실패");
			
			return "common/errorPage";
		}
	}	
	
	/**
	 * @param bno
	 * @param mno
	 * @param filePath
	 * @param session
	 * @param model
	 * @return
	 */
	@RequestMapping("adminDelete.bo")
	public String deleteAdminBoard(int bno, int mno, String filePath, HttpSession session, Model model) {
		int result = boardService.deleteAdminBoard(bno);
		if(result > 0) { // 게시글 삭제 성공

			if(!filePath.equals("")) {

				String realPath = session.getServletContext().getRealPath(filePath);
				new File(realPath).delete();
			}
			
			session.setAttribute("alertMsg", "성공적으로 게시글이 삭제되었습니다.");
			return "redirect:/adminBoardList.bo";
		}
		else { // 게시글 삭제 실패
			
			model.addAttribute("errorMsg", "게시글 삭제 실패");
			
			return "common/errorPage";
		}
	}	
	
}
