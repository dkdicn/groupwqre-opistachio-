package com.spring.groupware.addrlist.model;

import java.util.List;
import java.util.Map;

import com.spring.groupware.member.model.MemberVO;

public interface InterAddrDAO {

	/*
		전체 주소록
	*/
	
	// 주소록 추가
	int add(AddrVO addrvo);

	// 사원번호로 등록할 주소록 사원 검색
	List<MemberVO> searchMbrList(String mbr_seq);
	
	// 총 주소록 수
	int getTotalCount(Map<String, String> paraMap);

	// 페이징 처리한 주소록 목록
	List<AddrVO> addrListSearchWithPaging(Map<String, String> paraMap);

	// 주소록 검색
	List<String> wordSearchShow(Map<String, String> paraMap);

	// 주소록 상세 
	AddrVO getView(String addr_seq);

	// 주소록 정보 수정
	int edit(AddrVO addrvo);

	// 주소록 삭제
	int del(Map<String, String> paraMap);

	// 개인 주소록에 추가
	int addmyAddr(Map<String, String> paraMap);

	// 페이징 처리 없는 개인 주소록 그룹
	List<AddrGroupVO> addrgroupListNoPaging(Map<String, String> paraMap);


	/*
		개인 주소록
	*/
	
	// 페이징 처리한 주소록그룹 상세목록
	List<AddrVO> myAddrlistSearchWithPaging(Map<String, String> paraMap);

	// 각 주소록 그룹의 주소록 개수 
	int getmyAddrTotalCount(Map<String, String> paraMap);

	// 주소록 그룹 내 검색
	List<String> mywordSearchShow(Map<String, String> paraMap);

	// 개인 주소록에서 제거
	int delmyAddr(AddrVO addrvo);
	
	/*
		개인 주소록 관리
	*/
	
	// 페이징 처리한 주소록 그룹 목록
	List<AddrGroupVO> addrgroupListWithPaging(Map<String, String> paraMap);

	// 총 주소록 그룹 수
	int getAddrgroupTotalCount(Map<String, String> paraMap);

	// 주소록 그룹 추가
	int addAddrgroup(AddrGroupVO agvo);

	// 주소록 그룹 삭제 
	int delAddrgroup(Map<String, String> paraMap);




}
