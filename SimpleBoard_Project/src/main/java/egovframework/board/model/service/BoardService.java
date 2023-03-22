package egovframework.board.model.service;

import java.util.ArrayList;

import egovframework.board.model.vo.Board;
import egovframework.board.model.vo.Reply;
import egovframework.common.model.vo.CommonVo;

public interface BoardService {

	// 게시판 전체 조회 리스트 카운트
	int selectListCount(CommonVo cvPi);

	// 게시판 전체 조회
	ArrayList<Board> selectList(CommonVo cv);

	// 게시글 조회수 증가
	int increaseCount(int bno);

	// 게시글 상세 조회
	Board selectBoard(int bno);

	// 게시글 댓글 조회
	ArrayList<Reply> ajaxSelectReplyList(int bno);

	// 게시판 댓글 작성
	int ajaxInsertReply(Reply r);

	// 게시글 댓글 삭제
	int ajaxDeleteReply(int replyNo);

	// 게시글 작성
	int insertBoard(Board b);

	// 게시글 수정
	int updateBoard(Board b);

	// 게시글 삭제
	int deleteBoard(int bno);

	// 작성글 조회 리스트 카운트
	int selectMyListCount(int mno);

	// 작성글 조회
	ArrayList<Board> selectMyList(CommonVo cv, int mno);

	// 관리자 게시글 삭제
	int deleteAdminBoard(int bno);

	// 메인 페이지 게시글 조회
	ArrayList<Board> selectMainList();

}
