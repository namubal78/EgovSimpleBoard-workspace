package egovframework.common.model.service;

import java.util.ArrayList;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import egovframework.common.model.dao.CommonDao;
import egovframework.common.model.vo.MasterBoard;

@Service
public class CommonServiceImpl implements CommonService {

	@Autowired
	private CommonDao commonDao;
	
	@Autowired
	private SqlSessionTemplate sqlSession;

	@Override
	public ArrayList<MasterBoard> boardList() {
		return commonDao.boardList(sqlSession);
	}

	@Override
	public ArrayList<MasterBoard> adminBoardList() {
		return commonDao.adminBoardList(sqlSession);
	}

	@Override
	public int ajaxOpenBoard(int boardNo) {
		return commonDao.ajaxOpenBoard(sqlSession, boardNo);
	}
	
	@Override
	public int ajaxUnopenBoard(int boardNo) {
		return commonDao.ajaxUnopenBoard(sqlSession, boardNo);
	}
}
