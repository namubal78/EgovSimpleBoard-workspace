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
	public int ajaxOpenBoard(int bno) {
		return commonDao.ajaxOpenBoard(sqlSession, bno);
	}
	
	@Override
	public int ajaxUnopenBoard(int bno) {
		return commonDao.ajaxUnopenBoard(sqlSession, bno);
	}

	@Override
	public ArrayList<MasterBoard> selectAdminBoardList() {
		return commonDao.selectAdminBoardList(sqlSession);
	}
}
