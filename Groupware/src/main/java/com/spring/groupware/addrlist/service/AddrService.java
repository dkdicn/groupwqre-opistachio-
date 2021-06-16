package com.spring.groupware.addrlist.service;


import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;
import org.springframework.stereotype.Service;

import com.spring.groupware.addrlist.model.AddrGroupVO;
import com.spring.groupware.addrlist.model.AddrVO;
import com.spring.groupware.addrlist.model.InterAddrDAO;
import com.spring.groupware.member.model.MemberVO;

@Component
@Service
public class AddrService implements InterAddrService {

	@Autowired
	private InterAddrDAO adao;
	
	/*
	 	전체 주소록
	 */
	
	// === 주소록 추가 === //
	@Override
	public int add(AddrVO addrvo) {
		int n = adao.add(addrvo);
		return n;
	}

	// === 사원번호로 등록할 주소록 사원 검색 === //
	@Override
	public List<MemberVO> searchMbr(String mbr_seq) {
		List<MemberVO> searchMbrList = adao.searchMbrList(mbr_seq);
	    return searchMbrList;
	}
	
	// === 총 주소록 수 === //
	@Override
	public int getTotalCount(Map<String, String> paraMap) {
		int n = adao.getTotalCount(paraMap);
		return n;
	}

	// === 페이징 처리한 주소록 목록 === //
	@Override
	public List<AddrVO> addrListSearchWithPaging(Map<String, String> paraMap) {
		List<AddrVO> addrList = adao.addrListSearchWithPaging(paraMap);
	    return addrList;
	}

	// === 주소록 검색 === //
	@Override
	public List<String> wordSearchShow(Map<String, String> paraMap) {
		List<String> wordList = adao.wordSearchShow(paraMap);
		return wordList;
	}

	// === 주소록 상세 보기 === //
	@Override
	public AddrVO getView(String addr_seq) {
		AddrVO addrvo = adao.getView(addr_seq);
		return addrvo;
	}

	// === 주소록 정보 수정 === //
	@Override
	public int edit(AddrVO addrvo) {
		int n = adao.edit(addrvo);
		return n;
	}

	// === 주소록 삭제 === //
	@Override
	public int del(Map<String, String> paraMap) {
		int n = adao.del(paraMap);
		return n;
	}

	// === 개인 주소록에 추가 === //
	@Override
	public int addmyAddr(Map<String,String> paraMap) {
		int n = adao.addmyAddr(paraMap);
		return n;
	}

	// === 페이징 처리 없는 개인 주소록 그룹 === //
	@Override
	public List<AddrGroupVO> addrgroupListNoPaging(Map<String, String> paraMap) {
		List<AddrGroupVO> addrgroupList = adao.addrgroupListNoPaging(paraMap);
	    return addrgroupList;
	}
	
	/*
		개인 주소록
	*/
	
	// === 페이징 처리한 주소록 그룹 상세목록 === //
	@Override
	public List<AddrVO> myAddrlistSearchWithPaging(Map<String, String> paraMap) {
		List<AddrVO> myAddrlist = adao.myAddrlistSearchWithPaging(paraMap);
	    return myAddrlist;
	}	

	// === 각 주소록 그룹의 주소록 개수 === //
	@Override
	public int getmyAddrTotalCount(Map<String, String> paraMap) {
		int n = adao.getmyAddrTotalCount(paraMap);
		return n;
	}	
	
	// === 주소록 그룹 내 검색  === //
	@Override
	public List<String> mywordSearchShow(Map<String, String> paraMap) {
		List<String> mywordList = adao.mywordSearchShow(paraMap);
		return mywordList;
	}

	// === 개인 주소록에서 제거 === //
	@Override
	public int delmyAddr(AddrVO addrvo) {
		int n = adao.delmyAddr(addrvo);
		return n;
	}
	
	/*
		개인 주소록 관리
	*/
	
	// === 페이징 처리한 주소록 그룹 목록 === //
	@Override
	public List<AddrGroupVO> addrgroupListWithPaging(Map<String, String> paraMap) {
		List<AddrGroupVO> addrgroupList = adao.addrgroupListWithPaging(paraMap);
	    return addrgroupList;
	}

	// === 총 주소록 그룹수 === //
	@Override
	public int getAddrgroupTotalCount(Map<String, String> paraMap) {
		int n = adao.getAddrgroupTotalCount(paraMap);
		return n;
	}

	// === 주소록 그룹 추가 == //
	@Override
	public int addAddrgroup(AddrGroupVO agvo) {
		
		int n = adao.addAddrgroup(agvo);
		
		return n;
	}

	// === 주소록 그룹 삭제 === //
	@Override
	public int delAddrgroup(Map<String, String> paraMap) {
		int n = adao.delAddrgroup(paraMap);
		return n;
	}

	
}
