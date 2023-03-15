package egovframework.board.model.dao;

import java.util.ArrayList;

import org.apache.ibatis.session.RowBounds;
import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.stereotype.Repository;

import egovframework.board.model.vo.Board;
import egovframework.common.model.vo.PageInfo;

@Repository
public class BoardDao {

	public int selectListCount(SqlSessionTemplate sqlSession) {
		return sqlSession.selectOne("boardMapper.selectListCount");
	}

	public ArrayList<Board> selectListCount(PageInfo pi, SqlSessionTemplate sqlSession) {

		int limit = pi.getBoardLimit();
		int offset = (pi.getCurrentPage() - 1) * limit;
		
		RowBounds rowBounds = new RowBounds(offset, limit);
		return (ArrayList)sqlSession.selectList("boardMapper.selectList", null, rowBounds);
	}

	public int increaseCount(int bno, SqlSessionTemplate sqlSession) {
		return sqlSession.update("boardMapper.increaseCount", bno);
	}

	public Board selectBoard(int bno, SqlSessionTemplate sqlSession) {
		return sqlSession.selectOne("boardMapper.selectBoard", bno);
	}

}
