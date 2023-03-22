package egovframework.common.template;

import egovframework.common.model.vo.CommonVo;

public class Pagination {
	
	/** 검색 기능 없는 페이징
	 * @param listCount
	 * @param currentPage
	 * @param pageLimit
	 * @param boardLimit
	 * @return
	 */
	public static CommonVo getPageInfo(int listCount, int currentPage, int pageLimit, int boardLimit) {
		
		String category = "myList";
		String keyword = "nothing";
		
		int maxPage = (int)Math.ceil((double)listCount / boardLimit);
		int startPage = (currentPage - 1) / pageLimit * pageLimit + 1;
		int endPage = startPage + pageLimit - 1;
		
		if(endPage > maxPage) {
			endPage = maxPage;
		}
		
		return new CommonVo(category, keyword, listCount, currentPage, pageLimit, boardLimit, maxPage, startPage, endPage);		
		
	}
	
	/** 검색 기능있는 페이징
	 * @param category
	 * @param keyword
	 * @param listCount
	 * @param currentPage
	 * @param pageLimit
	 * @param boardLimit
	 * @return
	 */
	public static CommonVo getPageInfo(String category, String keyword, int listCount, int currentPage, int pageLimit, int boardLimit) {
		
		int maxPage = (int)Math.ceil((double)listCount / boardLimit);
		int startPage = (currentPage - 1) / pageLimit * pageLimit + 1;
		int endPage = startPage + pageLimit - 1;
		
		if(endPage > maxPage) {
			endPage = maxPage;
		}
		
		return new CommonVo(category, keyword, listCount, currentPage, pageLimit, boardLimit, maxPage, startPage, endPage);
	}
	
}
