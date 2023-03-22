package egovframework.member.model.service;

import java.util.ArrayList;

import egovframework.common.model.vo.CommonVo;
import egovframework.member.model.vo.Member;

public interface MemberService {

	// 아이디 중복 체크
	int idCheck(String checkId);

	// 회원 가입
	int insertMember(Member m);

	// 로그인
	Member loginMember(Member m);

	// 회원 정보 수정
	int updateMember(Member m);

	// 회원 탈퇴
	int deleteMember(Member m);

	// 관리자 회원 전체조회 리스트 카운트
	int selectMemberListCount(CommonVo cvPi);

	// 관리자 회원 전체조회
	ArrayList<Member> selectMemberList(CommonVo cv);

	// 관리자 회원 탈퇴
	int deleteAdminMember(int mno);

	// 관리자 회원 정보 수정
	Member selectMemberPage(int mno);

}
