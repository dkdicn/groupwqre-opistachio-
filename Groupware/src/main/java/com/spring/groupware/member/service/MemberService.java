package com.spring.groupware.member.service;

import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;

// import javax.annotation.Resource;

import org.springframework.stereotype.Component;
import org.springframework.stereotype.Service;

import com.spring.groupware.member.model.CompanyVO;
import com.spring.groupware.member.model.InterMemberDAO;
import com.spring.groupware.member.model.MemberVO;


@Component
@Service
public class MemberService implements InterMemberService {
	
	// 의존객체 주입
	@Autowired
	private InterMemberDAO mdao;

	// 로그인 뷰 회사명 가져오기
	@Override
	public String getCompanyName() {
		String com_name = mdao.getCompanyName();
		return com_name;
	}

	// 로그인 확인하기
	@Override
	public MemberVO loginCheck(Map<String, String> paraMap) {
		MemberVO loginuser = mdao.loginCheck(paraMap);
		return loginuser;
	}


	// 회사정보 모두 가져오기
	@Override
	public CompanyVO getCompanyInfo() {
		CompanyVO cvo = mdao.getCompanyInfo();
		return cvo;
	}

	// 대표이름 가져오기
	@Override
	public String getCeoName() {
		String ceo_name = mdao.getCeoName();
		return ceo_name;
	}

	// 관리자 정보 가져오기
	@Override
	public MemberVO getAdminInfo() {
		MemberVO mvo = mdao.getAdminInfo();
		return mvo;
	}

	
	// 로그아웃 처리하기
	@Override
	public void logout(int mbr_seq) {
		mdao.logout(mbr_seq);
	}

	
	// 조직도용 정보 가져오기
	@Override
	public List<Map<String, String>> getChartInfo(String chartStyle) {
		List<Map<String, String>> chartInfoList = mdao.getChartInfo(chartStyle);
		return chartInfoList;
	}

	// 비밀번호 변경하기
	@Override
	public int changePwd(String newPwd1, String mbr_seq) {
		int n = mdao.changePwd(newPwd1,mbr_seq);
		return n;
	}

	
	
	
	
	
}
