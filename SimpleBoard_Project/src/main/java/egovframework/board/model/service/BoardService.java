package egovframework.board.model.service;

import java.util.ArrayList;

import egovframework.board.model.vo.Board;
import egovframework.common.model.vo.PageInfo;

public interface BoardService {

	// 게시판 전체 조회 리스트 카운트
	int selectListCount();

	// 게시판 전체 조회
	ArrayList<Board> selectList(PageInfo pi);

	// 게시글 조회수 증가
	int increaseCount(int bno);

	// 게시글 상세 조회
	Board selectBoard(int bno);

}
