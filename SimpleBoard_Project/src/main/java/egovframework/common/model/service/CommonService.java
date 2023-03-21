package egovframework.common.model.service;

import java.util.ArrayList;

import egovframework.common.model.vo.MasterBoard;

public interface CommonService {

	// 게시판리스트 조회용
	ArrayList<MasterBoard> boardList();

	// 게시판 관리 조회용
	ArrayList<MasterBoard> adminBoardList();

	// 게시판 공개
	int ajaxOpenBoard(int boardNo);

	// 게시판 비공개
	int ajaxUnopenBoard(int boardNo);

}
