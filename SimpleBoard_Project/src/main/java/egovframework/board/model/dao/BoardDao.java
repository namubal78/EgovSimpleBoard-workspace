package egovframework.board.model.dao;

import java.util.ArrayList;

import org.apache.ibatis.session.RowBounds;
import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.stereotype.Repository;

import egovframework.board.model.vo.Board;
import egovframework.board.model.vo.Reply;
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

	public ArrayList<Reply> ajaxSelectReplyList(int bno, SqlSessionTemplate sqlSession) {
		return (ArrayList)sqlSession.selectList("boardMapper.ajaxSelectReplyList", bno);
	}

	public int ajaxInsertReply(SqlSessionTemplate sqlSession, Reply r) {
		return sqlSession.insert("boardMapper.ajaxInsertReply", r);
	}

	public int insertBoard(SqlSessionTemplate sqlSession, Board b) {
		return sqlSession.insert("boardMapper.insertBoard", b);
	}

	public int ajaxDeleteReply(SqlSessionTemplate sqlSession, int replyNo) {
		return sqlSession.update("boardMapper.ajaxDeleteReply", replyNo);
	}

	public int updateBoard(SqlSessionTemplate sqlSession, Board b) {
		return sqlSession.update("boardMapper.updateBoard", b);
	}

	public int deleteBoard(SqlSessionTemplate sqlSession, int bno) {
		return sqlSession.update("boardMapper.deleteBoard", bno);
	}

}
