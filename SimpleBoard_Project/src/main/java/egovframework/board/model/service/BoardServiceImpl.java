package egovframework.board.model.service;

import java.util.ArrayList;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import egovframework.board.model.dao.BoardDao;
import egovframework.board.model.vo.Board;
import egovframework.board.model.vo.Reply;
import egovframework.common.model.vo.PageInfo;

@Service
public class BoardServiceImpl implements BoardService {

	@Autowired
	private BoardDao boardDao;
	
	@Autowired
	private SqlSessionTemplate sqlSession;
	
	@Override
	public int selectListCount() {
		return boardDao.selectListCount(sqlSession);
	}

	@Override
	public ArrayList<Board> selectList(PageInfo pi) {
		return boardDao.selectListCount(pi, sqlSession);
	}

	@Override
	public int increaseCount(int bno) {
		return boardDao.increaseCount(bno, sqlSession);
	}

	@Override
	public Board selectBoard(int bno) {
		return boardDao.selectBoard(bno, sqlSession);
	}

	@Override
	public ArrayList<Reply> ajaxSelectReplyList(int bno) {
		return boardDao.ajaxSelectReplyList(bno, sqlSession);
	}

	@Override
	public int ajaxInsertReply(Reply r) {
		return boardDao.ajaxInsertReply(sqlSession, r);
	}

	@Override
	public int insertBoard(Board b) {
		return boardDao.insertBoard(sqlSession, b);
	}

	@Override
	public int ajaxDeleteReply(int replyNo) {
		return boardDao.ajaxDeleteReply(sqlSession, replyNo);
	}

	@Override
	public int updateBoard(Board b) {
		return boardDao.updateBoard(sqlSession, b);
	}

	@Override
	public int deleteBoard(int bno) {
		return boardDao.deleteBoard(sqlSession, bno);
	}

}
