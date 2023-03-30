package egovframework.board.controller;

import java.io.File;
import java.io.IOException;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Arrays;
import java.util.Date;
import java.util.List;

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
import egovframework.board.model.vo.BoardFile;
import egovframework.board.model.vo.Reply;
import egovframework.common.model.vo.CommonVo;
import egovframework.common.template.Pagination;
import egovframework.member.model.vo.Member;
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
	 * 메인 페이지 연결
	 * @param model
	 * @return
	 */
	@RequestMapping("mainList.bo")
	public String mainList(Model model) {
		
		ArrayList<Board> list = boardService.selectMainList(); // 메인 페이지 최근 자유게시판 게시글 조회		
		ArrayList<SubBoard> subList = subBoardService.selectMainList(); // 메인 페이지 최근 공지사항 게시글 조회

		model.addAttribute("list", list);
		model.addAttribute("subList", subList);
		
		return "main";
		
	}
	
	/**
	 * 게시글 전체 조회
	 * @param currentPage
	 * @param category
	 * @param keyword
	 * @param model
	 * @return
	 */
	@RequestMapping("list.bo")
	public String selectList(@RequestParam(value="cpage", defaultValue="1")int currentPage, @RequestParam(value="category", defaultValue="")String category, @RequestParam(value="keyword", defaultValue="")String keyword, Model model) {
		
		// 검색 및 페이징 처리
		CommonVo cvPi = new CommonVo();
		
		cvPi.setCategory(category);
		cvPi.setKeyword(keyword);
		
		int listCount = boardService.selectListCount(cvPi);

		int pageLimit = 5;
		int boardLimit = 5;
		CommonVo cv = Pagination.getPageInfo(category, keyword, listCount, currentPage, pageLimit, boardLimit);

		// ArrayList 에 담기
		ArrayList<Board> list = boardService.selectList(cv);

		model.addAttribute("cv", cv);
		model.addAttribute("list", list);
		
		return "board/boardListView";
		
	}
	
	/**
	 * 관리자 게시글관리용 전체 게시글 조회
	 * @param currentPage
	 * @param category
	 * @param keyword
	 * @param model
	 * @return
	 */
	@RequestMapping("adminBoardList.bo")
	public String selectAdminBoardList(@RequestParam(value="cpage", defaultValue="1")int currentPage, @RequestParam(value="category", defaultValue="")String category, @RequestParam(value="keyword", defaultValue="")String keyword, Model model) {
		
		// 검색 및 페이징 처리
		CommonVo cvPi = new CommonVo();
		
		cvPi.setCategory(category);
		cvPi.setKeyword(keyword);
		
		int listCount = boardService.selectListCount(cvPi);

		int pageLimit = 5;
		int boardLimit = 5;
		CommonVo cv = Pagination.getPageInfo(category, keyword, listCount, currentPage, pageLimit, boardLimit);

		// ArrayList 에 담기
		ArrayList<Board> list = boardService.selectList(cv);
		
		model.addAttribute("cv", cv);
		model.addAttribute("list", list);
		
		return "admin/adminBoardListView";
		
	}
	
	/**
	 * 내 작성글 조회
	 * @param currentPage
	 * @param mno
	 * @param model
	 * @return
	 */
	@RequestMapping("myList.bo")
	public String selectMyList(@RequestParam(value="cpage", defaultValue="1")int currentPage, int mno, Model model) {
				
		// 페이징 처리
		int listCount = boardService.selectMyListCount(mno);
		
		int pageLimit = 5;
		int boardLimit = 5;
		
		CommonVo cv = Pagination.getPageInfo(listCount, currentPage, pageLimit, boardLimit);
		
		// ArrayList 에 담기
		ArrayList<Board> list = boardService.selectMyList(cv, mno);
		
		model.addAttribute("cv", cv);
		model.addAttribute("list", list);
		model.addAttribute("mno", mno);
		
		return "member/myList";
	}
	
	/**
	 * 게시글 상세 조회
	 * @param bno
	 * @param mv
	 * @return
	 */
	@RequestMapping("detail.bo")
	public ModelAndView selectBoard(int bno, ModelAndView mv) {

		ArrayList<BoardFile> boardFileList = new ArrayList<BoardFile>();
		
		// 조회수 증가
		int result = boardService.increaseCount(bno);

		if(result > 0) {
			
			boardFileList = boardService.selectBoardFile(bno);
			
			Board b = boardService.selectBoard(bno);
			mv.addObject("boardFileList", boardFileList);
			mv.addObject("b", b).setViewName("board/boardDetailView");
		} else {
			mv.addObject("errorMsg", "게시글 조회에 실패했습니다.").setViewName("common/errorPage");
		}
		
		return mv;
	}
	
	/**
	 * 관리자용 게시글 상세 조회
	 * @param bno
	 * @param mv
	 * @return
	 */
	@RequestMapping("adminDetail.bo")
	public ModelAndView selectMemberBoard(int bno, ModelAndView mv) {

		ArrayList<BoardFile> boardFileList = new ArrayList<BoardFile>();

		// 조회수 증가
		int result = boardService.increaseCount(bno);

		if(result > 0) {
			
			boardFileList = boardService.selectBoardFile(bno);

			Board b = boardService.selectBoard(bno);
			mv.addObject("boardFileList", boardFileList);
			mv.addObject("b", b).setViewName("admin/adminBoardDetailView");
		} else {
			mv.addObject("errorMsg", "게시글 조회에 실패했습니다.").setViewName("common/errorPage");
		}
		
		return mv;
	}
	
	
	/**
	 * 게시글 내 댓글 조회
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
	 * 게시글 내 댓글 작성
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
	 * 게시글 내 댓글 삭제
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
	 * 게시글 작성폼 연결
	 * @return
	 */
	@RequestMapping("enrollForm.bo")
	public String boardEnrollForm() {
		return "board/boardEnrollForm";
	}
	

	/**
	 * 게시글 작성
	 * @param b
	 * @param upfile
	 * @param session
	 * @param mv
	 * @return
	 */
	@RequestMapping("insert.bo")
	public ModelAndView insertBoard(Board b, List<MultipartFile> upfile, HttpSession session, ModelAndView mv) {

		System.out.println("b: " + b);
		System.out.println("upfile: " + upfile);
		
		
		int memberNo = ((Member)session.getAttribute("loginUser")).getMemberNo();
		b.setMemberNo(memberNo);

		// System.out.println(r);
		
		// 먼저 파일 여부와 무관하게 rawReview 를 insert
		int rawResult = boardService.insertRawBoard(b);

		// System.out.println(rawResult);
		
		if(rawResult > 0) { // 만들어졌으면 진행
		
			// b에 들어있는 memberNo로 만들어진 board 중에서 rawBoard 를 select 해서 boardNo 추출, 
			Board rawBoard = boardService.selectRawBoard(memberNo);

			int rawBoardNo = rawBoard.getBoardNo();
			// upfile 에 비었든 안 비었든 MultipartFIle 객체는 하나 이상 만들어짐(사용자가 파일첨부를 시도하고 취소하더라도 빈 MultipartFIle 객체가 만들어지기 때문)
			
			// FILE 테이블에 INSERT
			for(int i = 0; i < upfile.size(); i++) {
				
				String fileExist = upfile.get(i).getOriginalFilename();
				
				if(!fileExist.equals("")) { // 첨부 파일 있음 => FILE 테이블에 insert
					
					String originName = upfile.get(i).getOriginalFilename(); // "flower.png"
										
					String currentTime =  new SimpleDateFormat("yyyyMMddHHmmss").format(new Date());
										
					int ranNum = (int)(Math.random() * 90000) + 10000; // 5자리 랜덤값
					
					String ext = fileExist.substring(fileExist.lastIndexOf(".")); //
					
					String changeName = currentTime + ranNum + ext;

					String filePath = session.getServletContext().getRealPath("/uploadFiles/");

					try {
						upfile.get(i).transferTo(new File(filePath + changeName));
					} catch (IllegalStateException | IOException e) {
						e.printStackTrace();
					}
					
					BoardFile boardFile = new BoardFile();
					
					boardFile.setOriginName(originName);
					boardFile.setChangeName(changeName);
					boardFile.setFilePath("/uploadFiles/");
					boardFile.setBoardNo(rawBoardNo);
					boardFile.setOriginName(upfile.get(i).getOriginalFilename());
					boardFile.setChangeName("/uploadFiles/" + changeName); 
					
					int fileResult = boardService.insertBoardFile(boardFile);
										
					if(fileResult == 0) {
						
						boardService.deleteBoard(rawBoardNo);
						session.setAttribute("alertMsg", "첨부 파일 등록에 실패했습니다.");
						mv.setViewName("redirect:/list.bo");
						return mv;
					}
					
				} else {} // 첨부 파일 없음
				
			}
			
			session.setAttribute("alertMsg", "게시글이 성공적으로 등록되었습니다.");

		} else {
			// 실패했으면 그냥 alert 하고 list.bo 로 리다이렉트
			session.setAttribute("alertMsg", "게시글 작성에 실패했습니다.");
		}
		mv.setViewName("redirect:/list.bo");
		return mv;
		
	}
	
	/**
	 * 게시글 수정폼 연결
	 * @param bno
	 * @param model
	 * @return
	 */
	@RequestMapping("updateForm.bo")
	public String updateForm(int bno, Model model) {
		
		
		Board b = boardService.selectBoard(bno);
		
		ArrayList<BoardFile> boardFileList = boardService.selectBoardFile(bno);
		 

		
		model.addAttribute("b", b);
		/*
		 * model.addAttribute("upfile", upfile);
		 */		model.addAttribute("boardFileList", boardFileList);

		return "board/boardUpdateForm";
	}
	

	/**
	 * 게시글 수정
	 * @param b
	 * @param upfile
	 * @param session
	 * @param model
	 * @return
	 */
	@RequestMapping("update.bo")
	public String updateBoard(Board b, List<MultipartFile> upfile, HttpSession session, Model model) {

		// 새로 넘어온 첨부파일이 있는 경우
		if(!upfile.get(0).getOriginalFilename().equals("")) {
			
			int boardNo = b.getBoardNo();

			// 새로운 첨부파일 INSERT
			for(int i = 0; i < upfile.size(); i++) {
		
				String originName = upfile.get(i).getOriginalFilename(); // "flower.png"
									
				String currentTime =  new SimpleDateFormat("yyyyMMddHHmmss").format(new Date());
									
				int ranNum = (int)(Math.random() * 90000) + 10000; // 5자리 랜덤값
				
				String ext = originName.substring(originName.lastIndexOf(".")); //
				
				String changeName = currentTime + ranNum + ext;
				
				String filePath = session.getServletContext().getRealPath("/uploadFiles/");
				
				try {
					upfile.get(i).transferTo(new File(filePath + changeName));
				} catch (IllegalStateException | IOException e) {
					e.printStackTrace();
				}
				
				BoardFile boardFile = new BoardFile();
				
				boardFile.setOriginName(originName);
				boardFile.setChangeName(changeName);
				boardFile.setFilePath("/uploadFiles/");
				boardFile.setBoardNo(boardNo);
				boardFile.setOriginName(upfile.get(i).getOriginalFilename());
				boardFile.setChangeName("/uploadFiles/" + changeName); 
								
				boardService.insertBoardFile(boardFile);
					
			}
			 
		}
				
		// 게시글 수정
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
	 * 게시글 수정 내 파일 삭제
	 * @param fileNo
	 * @return
	 */
	@ResponseBody
	@RequestMapping(value="deletePrevFile.bo", produces="text/html; charset=UTF-8")
	public String deletePrevFile(int fileNo) {
		
		int result = boardService.deletePrevFile(fileNo);
 		return (result > 0 ) ? "success" : "fail";
	}	

	/** 
	 * 게시글 삭제
	 * @param bno
	 * @param session
	 * @param model
	 * @return
	 */
	@RequestMapping("delete.bo")
	public String deleteBoard(int bno, HttpSession session, Model model) {
				
		int result = boardService.deleteBoard(bno);
		
		if(result > 0) { // 게시글 삭제 성공
		
			ArrayList<BoardFile> boardFileList = boardService.selectBoardFile(bno);
			
			for(int i = 0; i < boardFileList.size(); i++) { 
				
				if(!boardFileList.get(i).getFilePath().equals("")) { // 첨부파일이 있으면
					
					int fileNo = boardFileList.get(i).getFileNo();
					
					boardService.deleteBoardFile(fileNo);
					String realPath = session.getServletContext().getRealPath(boardFileList.get(i).getFilePath());
					new File(realPath).delete(); // 첨부파일 삭제
				}
			} 
			
			session.setAttribute("alertMsg", "성공적으로 게시글이 삭제되었습니다.");
			return "redirect:/list.bo";
		} else { // 게시글 삭제 실패
			
			model.addAttribute("errorMsg", "게시글 삭제 실패");
			return "common/errorPage";
		}
	}	
	
	/**
	 * 게시글 관리자 삭제
	 * @param bno
	 * @param session
	 * @param model
	 * @return
	 */
	@RequestMapping("adminDelete.bo")
	public String deleteAdminBoard(int bno, HttpSession session, Model model) {

		int result = boardService.deleteBoard(bno);
		
		if(result > 0) { // 게시글 삭제 성공
			
			ArrayList<BoardFile> boardFileList = boardService.selectBoardFile(bno);
			
			for(int i = 0; i < boardFileList.size(); i++) { 
				
				if(!boardFileList.get(i).getFilePath().equals("")) { // 첨부파일이 있으면
					
					int fileNo = boardFileList.get(i).getFileNo();
					
					boardService.deleteBoardFile(fileNo);
					String realPath = session.getServletContext().getRealPath(boardFileList.get(i).getFilePath());
					new File(realPath).delete(); // 첨부파일 삭제
				}
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
