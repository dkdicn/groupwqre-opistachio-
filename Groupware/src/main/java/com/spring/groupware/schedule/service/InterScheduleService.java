package com.spring.groupware.schedule.service;

import java.util.List;
import java.util.Map;

import com.spring.groupware.addrlist.model.AddrVO;
import com.spring.groupware.schedule.model.MtrHistoryVO;
import com.spring.groupware.schedule.model.ScheduleVO;

public interface InterScheduleService {
	
	// 일정번호 채번하기
	int getScdno();
	
	// 주소록 가져오기
	List<AddrVO> getAddrList();
	
	// 검색한 주소 목록 보여주기
	List<AddrVO> addrList_Search(Map<String, String> paraMap);
	
	// 선택한 사람에게 회의 초대 메일 보내기
	void invitedListEmailSending(Map<String, String> paraMap) throws Exception;
	
	// 일정 등록하기
	int scdAdd(ScheduleVO schedulevo);
	
	// 수정해야할 글 1개 가져오기
	ScheduleVO getViewScd(String scdno);
	
	// 일정 수정하기
	int editScd(ScheduleVO schedulevo);
	
	// 일정 삭제하기
	int delScd(String scdno);
	
	// 일정 풀캘린더에 보여주기
	List<Map<String, String>> showScd(Map<String, String> paraMap);
	
	// 모든 일정 삭제하기
	int delAll(int mbr_seq);
	
	// 나의 일정 개수 확인하기
	int cntMyTotalScd(int mbr_seq);
	
	//////////////////////////////////////////////////////
	
	// 회의실 이용기록번호 채번하기
	int getNum();
	
	// 회의실 예약하기
	int resvMtrEnd(MtrHistoryVO mtrhvo);
	
	// 일정명 가져오기
	String getScdSubject(String scdno);
		
	// 회의실 이름 가져오기
	String getMtrName(String fk_mtrno);
	
	// 회의실 예약취소(삭제)
	int delMtrReg(String usemtrno);
	
	// 회의실 예약현황 보여주기(구글 차트) 
	List<Map<String, String>> goRegMtr();
	
	// 해당 접속자가 예약한 모든 회의실 예약 내역 가져오기
	List<MtrHistoryVO> getMtrResvList(String userid);
	
	// 체크된 예약 내역 삭제하기
	int delOneResv(String usermtrno);
	
	

}
