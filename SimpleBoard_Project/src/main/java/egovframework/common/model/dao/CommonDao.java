package egovframework.common.model.dao;

import java.util.ArrayList;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.stereotype.Repository;

import egovframework.common.model.vo.MasterBoard;

@Repository
public class CommonDao {

	public ArrayList<MasterBoard> boardList(SqlSessionTemplate sqlSession) {
		return (ArrayList)sqlSession.selectList("masterBoardMapper.boardList");
	}

	public ArrayList<MasterBoard> adminBoardList(SqlSessionTemplate sqlSession) {
		return (ArrayList)sqlSession.selectList("masterBoardMapper.adminBoardList");
	}

	public int ajaxOpenBoard(SqlSessionTemplate sqlSession, int bno) {
		return sqlSession.update("masterBoardMapper.ajaxOpenBoard", bno);
	}

	public int ajaxUnopenBoard(SqlSessionTemplate sqlSession, int bno) {
		return sqlSession.update("masterBoardMapper.ajaxUnopenBoard", bno);
	}

	public ArrayList<MasterBoard> selectAdminBoardList(SqlSessionTemplate sqlSession) {
		return (ArrayList)sqlSession.selectList("masterBoardMapper.selectAdminBoardList");
	}
}
