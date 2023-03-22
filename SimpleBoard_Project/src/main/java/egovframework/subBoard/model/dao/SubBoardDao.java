package egovframework.subBoard.model.dao;

import java.util.ArrayList;

import org.apache.ibatis.session.RowBounds;
import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.stereotype.Repository;

import egovframework.common.model.vo.CommonVo;
import egovframework.subBoard.model.vo.SubBoard;

@Repository
public class SubBoardDao {

	public int selectListCount(CommonVo cvPi, SqlSessionTemplate sqlSession) {
		return sqlSession.selectOne("subBoardMapper.selectListCount", cvPi);
	}

	public ArrayList<SubBoard> selectList(CommonVo cv, SqlSessionTemplate sqlSession) {
		int limit = cv.getBoardLimit();
		int offset = (cv.getCurrentPage() - 1) * limit;
		RowBounds rowBounds = new RowBounds(offset, limit);
		
		return (ArrayList)sqlSession.selectList("subBoardMapper.selectList", cv, rowBounds);
	}

	public int increaseCount(int subBno, SqlSessionTemplate sqlSession) {
		return sqlSession.update("subBoardMapper.increaseCount", subBno);

	}

	public SubBoard selectBoard(int subBno, SqlSessionTemplate sqlSession) {
		return sqlSession.selectOne("subBoardMapper.selectBoard", subBno);

	}

	public int insertBoard(SqlSessionTemplate sqlSession, SubBoard b) {
		return sqlSession.insert("subBoardMapper.insertBoard", b);

	}

	public int deleteBoard(SqlSessionTemplate sqlSession, int subBno) {
		return sqlSession.update("subBoardMapper.deleteBoard", subBno);
	}

	public ArrayList<SubBoard> selectMainList(SqlSessionTemplate sqlSession) {
		return (ArrayList)sqlSession.selectList("subBoardMapper.selectMainList");
	}

}
