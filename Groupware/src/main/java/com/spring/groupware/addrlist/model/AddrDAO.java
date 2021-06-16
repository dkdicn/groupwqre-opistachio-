package com.spring.groupware.addrlist.model;

import java.util.List;
import java.util.Map;

import javax.annotation.Resource;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.stereotype.Component;
import org.springframework.stereotype.Repository;

import com.spring.groupware.member.model.MemberVO;

@Component
@Repository
public class AddrDAO implements InterAddrDAO {	
	
	@Resource
	private SqlSessionTemplate sqlsession; // 로컬 DB에 연결

	@Resource
	private SqlSessionTemplate sqlsession2; // 원격 DB에 연결
	
	@Resource
	private SqlSessionTemplate sqlsession3; // 로컬 DB에 hr로 연결

	
	/*
		전체 주소록
	*/
	
	
	// === 주소록 추가 === //
	@Override
	public int add(AddrVO addrvo) {
		int n =  sqlsession.insert("address.addrAdd", addrvo);
		return n;
	}
	
	// === 사원번호로 등록할 주소록 사원 검색 === //
	@Override
	public List<MemberVO> searchMbrList(String mbr_seq) {
		List<MemberVO> searchMbrList = sqlsession.selectList("address.searchMbr", mbr_seq);
		return searchMbrList;
	}
	
	// === 총 등록 주소록 수 === //
	@Override
	public int getTotalCount(Map<String, String> paraMap) {
		int n = sqlsession.selectOne("address.getAddrTotalCount", paraMap);
		return n;
	}

	// === 페이징 처리한 주소록 목록 === //
	@Override
	public List<AddrVO> addrListSearchWithPaging(Map<String, String> paraMap) {
		List<AddrVO> addrList = sqlsession.selectList("address.addrListSearchWithPaging", paraMap);		
		return addrList;
	}

	// === 주소록 검색 === //
	@Override
	public List<String> wordSearchShow(Map<String, String> paraMap) {
		List<String> addrList = sqlsession.selectList("address.addrWordSearchShow", paraMap);
		return addrList;
	}

	// === 주소록 상세 조회 === //
	@Override
	public AddrVO getView(String addr_seq) {
		AddrVO addrvo = sqlsession.selectOne("address.getAddrView", addr_seq);
		return addrvo;
	}

	// === 주소록 정보 수정 === //
	@Override
	public int edit(AddrVO addrvo) {
		int n = sqlsession.update("address.editAddr", addrvo);		
		return n;
	}

	// === 주소록 삭제 === //
	@Override
	public int del(Map<String, String> paraMap) {
		int n = sqlsession.delete("address.delAddr", paraMap);		
		return n;
	}
	
	// === 개인 주소록에 추가 === //
	@Override
	public int addmyAddr(Map<String, String> paraMap) {
		int n = sqlsession.update("address.addmyAddr", paraMap);
		return n;
	}
	
	// === 페이징 처리 없는 개인 주소록 그룹 === //
	@Override
	public List<AddrGroupVO> addrgroupListNoPaging(Map<String, String> paraMap) {
		List<AddrGroupVO> addrgroupList = sqlsession.selectList("address.addrgroupListNoPaging", paraMap);		
		return addrgroupList;
	}

	
	/*
		개인 주소록
	*/
	

	// === 페이징 처리한 주소록 상세목록 === //
	@Override
	public List<AddrVO> myAddrlistSearchWithPaging(Map<String, String> paraMap) {
		List<AddrVO> myAddrlist = sqlsession.selectList("address.myAddrlistSearchWithPaging", paraMap);		
		return myAddrlist;
	}

	// === 각 주소록 그룹의 주소록 개수 === //
	@Override
	public int getmyAddrTotalCount(Map<String, String> paraMap) {
		int n = sqlsession.selectOne("address.getmyAddrTotalCount", paraMap);
		return n;
	}
	
	// === 주소록 그룹 내 검색 === //
	@Override
	public List<String> mywordSearchShow(Map<String, String> paraMap) {
		List<String> mysearchList = sqlsession.selectList("address.myaddrWordSearchShow", paraMap);
		return mysearchList;
	}
	
	// === 주소록 그룹에서 제거 === //
	@Override
	public int delmyAddr(AddrVO addrvo) {
		int n = sqlsession.update("address.delmyAddr", addrvo);
		return n;
	}
	
	/*
		개인 주소록 관리
	*/
	
	// === 페이징 처리한 주소록 그룹 목록 === //
	@Override
	public List<AddrGroupVO> addrgroupListWithPaging(Map<String, String> paraMap) {
		List<AddrGroupVO> addrgroupList = sqlsession.selectList("address.addrgroupListWithPaging", paraMap);		
		return addrgroupList;
	}

	// === 총 등록 주소록 그룹 수 === //
	@Override
	public int getAddrgroupTotalCount(Map<String, String> paraMap) {
		int n = sqlsession.selectOne("address.getAddrgroupTotalCount", paraMap);
		return n;
	}

	// === 주소록 그룹 등록하기 === //
	@Override
	public int addAddrgroup(AddrGroupVO agvo) {
		int n =  sqlsession.insert("address.addAddrgroup", agvo);
		return n;
	}

	// === 주소록 그룹 삭제 === //
	@Override
	public int delAddrgroup(Map<String, String> paraMap) {
		int n = sqlsession.delete("address.delAddrgroup", paraMap);		
		return n;
	}





}
