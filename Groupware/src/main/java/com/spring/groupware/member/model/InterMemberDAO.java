package com.spring.groupware.member.model;

import java.util.List;
import java.util.Map;

public interface InterMemberDAO {

	// 로그인 뷰 회사명 가져오기
	String getCompanyName();

	// 회사정보 모두 가져오기
	CompanyVO getCompanyInfo();

	// 대표이름 가져오기
	String getCeoName();

	// 관리자 정보 가져오기
	MemberVO getAdminInfo();

	// 로그인 확인하기
	MemberVO loginCheck(Map<String, String> paraMap);

	// 로그아웃 처리하기
	void logout(int mbr_seq);

	// 조직도용 정보가져오기
	List<Map<String, String>> getChartInfo(String chartStyle);

	// 비밀번호 변경하기
	int changePwd(String newPwd1, String mbr_seq);

}