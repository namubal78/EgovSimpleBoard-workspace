package egovframework.member.model.dao;

import java.util.ArrayList;

import org.apache.ibatis.session.RowBounds;
import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.stereotype.Repository;

import egovframework.common.model.vo.CommonVo;
import egovframework.common.model.vo.PageInfo;
import egovframework.member.model.vo.Member;

@Repository
public class MemberDao {

	public int idCheck(SqlSessionTemplate sqlSession, String checkId) {
		return sqlSession.selectOne("memberMapper.idCheck", checkId);
	}

	public int insertMember(SqlSessionTemplate sqlSession, Member m) {
		return sqlSession.insert("memberMapper.insertMember", m);
	}

	public Member loginMember(SqlSessionTemplate sqlSession, Member m) {
		return sqlSession.selectOne("memberMapper.loginMember", m);
	}

	public int updateMember(SqlSessionTemplate sqlSession, Member m) {
		return sqlSession.update("memberMapper.updateMember", m);
	}

	public int deleteMember(SqlSessionTemplate sqlSession, Member m) {
		return sqlSession.update("memberMapper.deleteMember", m);
	}

	public int selectMemberListCount(SqlSessionTemplate sqlSession, CommonVo cvPi) {
		return sqlSession.selectOne("memberMapper.selectMemberListCount", cvPi);
	}

	public ArrayList<Member> selectMemberList(SqlSessionTemplate sqlSession, CommonVo cv) {
		
		int limit = cv.getBoardLimit();
		int offset = (cv.getCurrentPage() - 1) * limit;
		
		RowBounds rowBounds = new RowBounds(offset, limit);
		
		return (ArrayList)sqlSession.selectList("memberMapper.selectMemberList", cv, rowBounds);
	}

	public int deleteAdminMember(SqlSessionTemplate sqlSession, int mno) {
		return sqlSession.update("memberMapper.deleteAdminMember", mno);
	}

	public Member selectMemberPage(SqlSessionTemplate sqlSession, int mno) {
		return sqlSession.selectOne("memberMapper.selectMemberPage", mno);
	}

}
