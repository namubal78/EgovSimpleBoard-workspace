package egovframework.common.controller;

import java.util.ArrayList;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.google.gson.Gson;

import egovframework.common.model.service.CommonService;
import egovframework.common.model.vo.MasterBoard;

@Controller
public class CommonController {
	
	@Autowired
	private CommonService commonService;
	
	/**
	 * @return
	 */
	@ResponseBody
	@RequestMapping(value="boardList.co", produces="application/json; charset=UTF-8")
	public String boardList() {
		ArrayList<MasterBoard> list = commonService.boardList(); 
		return new Gson().toJson(list);
	}	
	
	/**
	 * @return
	 */
	@ResponseBody
	@RequestMapping(value="selectAdminBoardList.co", produces="application/json; charset=UTF-8")
	public String selectAdminBoardList() {
		ArrayList<MasterBoard> list = commonService.selectAdminBoardList(); 
		return new Gson().toJson(list);
	}
	
	/**
	 * @param model
	 * @return
	 */
	@RequestMapping("adminBoardListPage.co")
	public String adminBoardListPage(Model model) {
		ArrayList<MasterBoard> list = commonService.adminBoardList();
		model.addAttribute("list", list);
		return "admin/adminBoardManagePage";
	}

	/**
	 * @param bno
	 * @return
	 */
	@ResponseBody
	@RequestMapping(value="ajaxOpenBoard.co", produces="text/htmll; charset=UTF-8")
	public String ajaxOpenBoard(int bno) {
		int result = commonService.ajaxOpenBoard(bno);
		return (result > 0) ? "success" : "false";
	}
	
	/**
	 * @param bno
	 * @return
	 */
	@ResponseBody
	@RequestMapping(value="ajaxUnopenBoard.co", produces="text/htmll; charset=UTF-8")
	public String ajaxUnopenBoard(int bno) {
		int result = commonService.ajaxUnopenBoard(bno);
		return (result > 0) ? "success" : "false";
	}
	
}
