package com.spring.groupware.member.service;

import java.util.List;
import java.util.Map;

import com.spring.groupware.member.model.CompanyVO;
import com.spring.groupware.member.model.MemberVO;

public interface InterMemberService {

	// 로그인 뷰 회사명 가져오기
	String getCompanyName();
	
	// 로그인확인하기
	MemberVO loginCheck(Map<String, String> paraMap);

	// 회사정보 모두 가져오기
	CompanyVO getCompanyInfo();

	// 대표자 이름 가져오기
	String getCeoName();

	// 관리자 정보 가져오기
	MemberVO getAdminInfo();

	// 로그아웃 처리하기
	void logout(int mbr_seq);

	// 조직도용 정보 가져오기
	List<Map<String, String>> getChartInfo(String chartStyle);

	// 비밀번호 변경하기
	int changePwd(String newPwd1, String mbr_seq);



	




	
	
}
