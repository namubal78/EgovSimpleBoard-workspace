package egovframework.subBoard.model.service;

import java.util.ArrayList;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import egovframework.common.model.vo.CommonVo;
import egovframework.subBoard.model.dao.SubBoardDao;
import egovframework.subBoard.model.vo.SubBoard;

@Service
public class SubBoardServiceImpl implements SubBoardService {

	@Autowired
	private SubBoardDao subBoardDao;
	
	@Autowired
	private SqlSessionTemplate sqlSession;
	
	@Override
	public int selectListCount(CommonVo cvPi) {
		return subBoardDao.selectListCount(cvPi, sqlSession);
	}

	@Override
	public ArrayList<SubBoard> selectList(CommonVo cv) {
		return subBoardDao.selectList(cv, sqlSession);

	}

	@Override
	public int increaseCount(int subBno) {
		return subBoardDao.increaseCount(subBno, sqlSession);

	}

	@Override
	public SubBoard selectBoard(int subBno) {
		return subBoardDao.selectBoard(subBno, sqlSession);

	}

	@Override
	public int insertBoard(SubBoard b) {
		return subBoardDao.insertBoard(sqlSession, b);

	}

	@Override
	public int deleteBoard(int subBno) {
		return subBoardDao.deleteBoard(sqlSession, subBno);
	}

	@Override
	public ArrayList<SubBoard> selectMainList() {
		return subBoardDao.selectMainList(sqlSession);
	}

}
