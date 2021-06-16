package com.spring.groupware.member.model;

import org.springframework.stereotype.Component;
import org.springframework.stereotype.Repository;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;

import org.mybatis.spring.SqlSessionTemplate;


@Component
@Repository
public class MemberDAO implements InterMemberDAO {

	@Resource
	private SqlSessionTemplate sqlsession; // 원격 DB에 연결
	
	// 로그인 뷰 회사명 가져오기
	@Override
	public String getCompanyName() {
		String com_name = sqlsession.selectOne("member.companyName_select");		
		return com_name;
	}

	// 회사정보 모두 가져오기
	@Override
	public CompanyVO getCompanyInfo() {
		CompanyVO cvo = sqlsession.selectOne("member.companyInfo_select");		
		return cvo;
	}

	// 대표이름 가져오기
	@Override
	public String getCeoName() { 
		String ceo_name = sqlsession.selectOne("member.ceoName_select");
		return ceo_name;
	}

	// 관리자 정보 가져오기
	@Override
	public MemberVO getAdminInfo() {
		MemberVO mvo = sqlsession.selectOne("member.adminInfo_select");		
		return mvo;
	}

	
	// 로그인 확인하기
	@Override
	public MemberVO loginCheck(Map<String, String> paraMap) {
		MemberVO loginuser = sqlsession.selectOne("member.loginCheck",paraMap);	
		if(loginuser!=null) {	// 로그인이 된다면, 로그인 히스토리에 기록하기
			paraMap.put("mbr_seq", String.valueOf(loginuser.getMbr_seq()));
			sqlsession.insert("member.loginHistory",paraMap);
		}	
		return loginuser;
	}


	// 로그아웃 처리하기, 로그아웃 히스토리에 기록하기
	@Override
	public void logout(int mbr_seq) {
		sqlsession.insert("member.logoutHistory",mbr_seq);	
	}
	
	
	// 조직도용 정보가져오기
	@Override
	public List<Map<String, String>> getChartInfo(String chartStyle) {
		List<Map<String, String>> chartInfoList = sqlsession.selectList("member.getChartInfo",chartStyle);	
		return chartInfoList;
	}

	// 비밀번호 변경하기
	@Override
	public int changePwd(String newPwd1, String mbr_seq) {
		Map<String, String> paraMap = new HashMap<>();
		int n = sqlsession.update("member.changePwd",paraMap);
		return n;
	}

}
