package egovframework.board.controller;

import java.util.ArrayList;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.ModelAndView;

import egovframework.board.model.service.BoardService;
import egovframework.board.model.vo.Board;
import egovframework.common.model.vo.PageInfo;
import egovframework.common.template.Pagination;

@Controller
public class BoardController {

	@Autowired
	private BoardService boardService;
	
	@RequestMapping("list.bo")
	public String selectList(@RequestParam(value="cpage", defaultValue="1")int currentPage, Model model) {
		int listCount = boardService.selectListCount();

		int pageLimit = 5;
		int boardLimit = 5;
		
		PageInfo pi = Pagination.getPageInfo(listCount, currentPage, pageLimit, boardLimit);
		
		ArrayList<Board> list = boardService.selectList(pi);
		
//		System.out.println("pi: " + pi);
//		System.out.println("list: " + list);
		
		model.addAttribute("pi", pi);
		model.addAttribute("list", list);
		
		return "main";
		
	}
	
	@RequestMapping("detail.bo")
	public ModelAndView selectBoard(int bno, ModelAndView mv) {

		int result = boardService.increaseCount(bno);

		if(result > 0) {
			
			Board b = boardService.selectBoard(bno);
			System.out.println("b: " + b);
			mv.addObject("b", b).setViewName("board/boardDetailView");
			
		} else {
			
			mv.addObject("errorMsg", "게시글 조회에 실패했습니다.").setViewName("common/errorPage");

		}
		
		return mv;
		
	}
	
}
