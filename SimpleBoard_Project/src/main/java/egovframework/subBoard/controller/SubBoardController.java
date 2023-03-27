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
	
	/**
	 * 공지사항 전체조회 및 검색조회
	 * @param currentPage
	 * @param category
	 * @param keyword
	 * @param model
	 * @return
	 */
	@RequestMapping("list.sub")
	public String selectList(@RequestParam(value="cpage", defaultValue="1")int currentPage, @RequestParam(value="category", defaultValue="")String category, @RequestParam(value="keyword", defaultValue="")String keyword, Model model) {
		
		// 검색 및 페이징 처리
		CommonVo cvPi = new CommonVo();
		
		cvPi.setCategory(category);
		cvPi.setKeyword(keyword);
		
		int listCount = subBoardService.selectListCount(cvPi);

		int pageLimit = 5;
		int boardLimit = 5;
		CommonVo cv = Pagination.getPageInfo(category, keyword, listCount, currentPage, pageLimit, boardLimit);

		// ArrayList 에 담기
		ArrayList<SubBoard> list = subBoardService.selectList(cv);
		
		model.addAttribute("cv", cv);
		model.addAttribute("list", list);
		
		return "subBoard/subBoardListView";
		
	}
	
	/**
	 * 공지사항 상세조회
	 * @param subBno
	 * @param mv
	 * @return
	 */
	@RequestMapping("detail.sub")
	public ModelAndView selectBoard(int subBno, ModelAndView mv) {

		// 조회수 증가
		int result = subBoardService.increaseCount(subBno);

		if(result > 0) {
			
			SubBoard b = subBoardService.selectBoard(subBno);
			mv.addObject("b", b).setViewName("subBoard/subBoardDetailView");
		} else {
			mv.addObject("errorMsg", "게시글 조회에 실패했습니다.").setViewName("common/errorPage");
		}
		
		return mv;
	}
	
	/**
	 * 공지사항 작성폼 연결
	 * @return
	 */
	@RequestMapping("enrollForm.sub")
	public String boardEnrollForm() {
		return "subBoard/subBoardEnrollForm";
	}
	
	/**
	 * 공지사항 작성
	 * @param b
	 * @param upfile
	 * @param session
	 * @param mv
	 * @return
	 */
	@RequestMapping("insert.sub")
	public ModelAndView insertBoard(SubBoard b, MultipartFile upfile, HttpSession session, ModelAndView mv) {

		// 첨부파일 없을 경우
		if(!upfile.getOriginalFilename().equals("")) {
		
			String changeName = saveFile(upfile, session);			
						
			// 원본명, 서버에 업로드 된 수정명을 Board b 에 담기
			// => boardTitle, boardContent, boardWriter 필드에만 값이 담겨있음
			// => originName, changeName 필드에도 전달된 파일에 대한 정보를 담을것
			b.setSubOriginName(upfile.getOriginalFilename());
			b.setSubChangeName("uploadFiles/" + changeName); 
		}
				
		// 넘어온 첨부파일이 있을 경우 b : 제목, 작성자, 내용, 원본파일명, 경로 + 수정파일명
		// 넘어온 첨부파일이 없을 경우 b : 제목, 작성자, 내용
		int result = subBoardService.insertBoard(b);

		if(result > 0) { // 성공 => 게시글 리스트 페이지로 url 재요청
			
			session.setAttribute("alertMsg", "성공적으로 게시글이 등록되었습니다.");
			mv.setViewName("redirect:/list.sub");
		}
		else { // 실패 => 에러페이지로 포워딩
			
			mv.addObject("errorMsg", "게시글 작성 실패").setViewName("common/errorPage");
		}
		
		return mv;		
		
	}
	
	/**
	 * 파일명 가공 및 업로드
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
	 * 공지사항 삭제
	 * @param subBno
	 * @param filePath
	 * @param session
	 * @param model
	 * @return
	 */
	@RequestMapping("delete.sub")
	public String deleteBoard(int subBno, String filePath, HttpSession session, Model model) {
				
		// 공지사항 삭제
		int result = subBoardService.deleteBoard(subBno);
		
		if(result > 0) { // 삭제 성공
			
			// 첨부파일이 있을 경우 => 파일 삭제
			if(!filePath.equals("")) {
				
				String realPath = session.getServletContext().getRealPath(filePath);
				new File(realPath).delete();
			}
			
			session.setAttribute("alertMsg", "성공적으로 공지가 삭제되었습니다.");
			
			return "redirect:/list.sub";
		}
		else { // 게시글 삭제 실패
			
			model.addAttribute("errorMsg", "공지 삭제 실패");
			
			return "common/errorPage";
		}
	}	
	
}
