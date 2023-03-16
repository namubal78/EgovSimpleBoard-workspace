package egovframework.member.model.service;

import java.util.ArrayList;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import egovframework.common.model.vo.PageInfo;
import egovframework.member.model.dao.MemberDao;
import egovframework.member.model.vo.Member;

@Service
public class MemberServiceImpl implements MemberService {

	@Autowired
	private MemberDao memberDao;
	
	@Autowired
	private SqlSessionTemplate sqlSession;
	
	@Override
	public int idCheck(String checkId) {
		return memberDao.idCheck(sqlSession, checkId);
	}

	@Override
	public int insertMember(Member m) {
		return memberDao.insertMember(sqlSession, m);
	}

	@Override
	public Member loginMember(Member m) {
		return memberDao.loginMember(sqlSession, m);
	}

	@Override
	public int updateMember(Member m) {
		return memberDao.updateMember(sqlSession, m);
	}

	@Override
	public int deleteMember(Member m) {
		return memberDao.deleteMember(sqlSession, m);
	}

	@Override
	public int selectMemberListCount() {
		return memberDao.selectMemberListCount(sqlSession);
	}

	@Override
	public ArrayList<Member> selectMemberList(PageInfo pi) {
		return memberDao.selectMemberList(sqlSession, pi);
	}

	@Override
	public int deleteAdminMember(int mno) {
		return memberDao.deleteAdminMember(sqlSession, mno);
	}

}
