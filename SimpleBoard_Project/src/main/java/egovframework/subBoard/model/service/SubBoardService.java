package egovframework.subBoard.model.service;

import java.util.ArrayList;

import egovframework.common.model.vo.CommonVo;
import egovframework.subBoard.model.vo.SubBoard;

public interface SubBoardService {

	// 공지사항 전체 조회 리스트 카운트
	int selectListCount(CommonVo cvPi);

	// 공지사항 전체 조회
	ArrayList<SubBoard> selectList(CommonVo cv);

	// 공지사항 조회수 증가
	int increaseCount(int subBno);

	// 공지사항 상세 조회
	SubBoard selectBoard(int subBno);

	//공지사항 작성
	int insertBoard(SubBoard b);

	// 공지사항 삭제
	int deleteBoard(int subBno);

	// 메인 페이지 공지사항 조회
	ArrayList<SubBoard> selectMainList();

}
