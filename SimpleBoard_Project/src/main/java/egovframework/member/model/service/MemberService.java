package egovframework.member.model.service;

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

}
