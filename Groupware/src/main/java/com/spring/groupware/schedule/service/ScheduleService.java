package com.spring.groupware.schedule.service;

import java.util.*;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;
import org.springframework.stereotype.Service;

import com.spring.groupware.addrlist.model.AddrVO;
import com.spring.groupware.common.GoogleMail;
import com.spring.groupware.schedule.model.InterScheduleDAO;
import com.spring.groupware.schedule.model.MtrHistoryVO;
import com.spring.groupware.schedule.model.ScheduleVO;

@Component
@Service
public class ScheduleService implements InterScheduleService{
	
	// === 의존객체 주입하기(DI: Dependency Injection) ===
	@Autowired
	private InterScheduleDAO dao;
	
	@Autowired
    private GoogleMail mail;
	
	// 일정번호 채번해오기
	@Override
	public int getScdno() {
		int scdno = dao.getScdno();
		return scdno;
	}
	
	// 주소록 가져오기
	@Override
	public List<AddrVO> getAddrList() {
		List<AddrVO> addrList = dao.getAddrList();
		return addrList;
	}
	
	// 검색한 주소 목록 보여주기
	@Override
	public List<AddrVO> addrList_Search(Map<String, String> paraMap) {
		List<AddrVO> addrList = dao.addrList_Search(paraMap);
		return addrList;
	}
	
	// 일정 등록하기
	@Override
	public int scdAdd(ScheduleVO schedulevo) {
		int n = dao.scdAdd(schedulevo);
		return n;
	}
	
	// 수정해야할 글 1개 가져오기
	@Override
	public ScheduleVO getViewScd(String scdno) {
		ScheduleVO schedulevo = dao.getViewScd(scdno);
		return schedulevo;
	}
	
	// 일정 수정하기
	@Override
	public int editScd(ScheduleVO schedulevo) {
		int n = dao.editScd(schedulevo);
		return n;
	}
	
	// 일정 삭제하기
	@Override
	public int delScd(String scdno) {
		int n = dao.delScd(scdno);
		return n;
	}
	
	// 캘린더에 일정 보여주기
	@Override
	public List<Map<String, String>> showScd(Map<String, String> paraMap) {
		List<Map<String, String>> scdList = dao.showScd(paraMap);
		return scdList;
	}
	
	// 모든 일정 삭제하기
	@Override
	public int delAll(int mbr_seq) {
		int n = dao.delAll(mbr_seq);
		return n;
	}
	
	// 선택한 사람에게 회의 초대 메일 보내기
	@Override
	public void invitedListEmailSending(Map<String, String> paraMap) throws Exception {
		
		String emailList = paraMap.get("emailList");
		String nameList = paraMap.get("mbrName");
		
		if( emailList != null && !"".equals(emailList)) {
			String[] emailArr = emailList.split(",");
			String[] nameArr = nameList.split(",");
			
			for(int i=0; i<emailArr.length; i++) {
				String contents = "<span style='color:#002db3; font-weight:bold;'>"+nameArr[i] + "</span>&nbsp;님, " + paraMap.get("myName") + " 님께서 회의에 초대하셨습니다."
								+ "<br>&nbsp;<span style='font-weight:bold;'>주최자 :</span> " + paraMap.get("myName")
								+ "<br>&nbsp;<span style='font-weight:bold;'>참석자 :</span> " + nameList;
				mail.sendmail(emailArr[i], contents);
			}
		}
	}
	
	// 나의 일정 개수 확인하기
	@Override
	public int cntMyTotalScd(int mbr_seq) {
		int totalCnt = dao.cntMyTotalScd(mbr_seq);
		return totalCnt;
	}

	
	///////////////////////////////////////////////////////////일정끝
	
	// 회의실 이용기록번호 채번하기
	@Override
	public int getNum() {
		int usemtrno = dao.getNum();
		return usemtrno;
	}

	// 회의실 예약하기
	@Override
	public int resvMtrEnd(MtrHistoryVO mtrhvo) {
		int n = dao.resvMtrEnd(mtrhvo);
		return n;
	}
	
	// 일정명 가져오기
	@Override
	public String getScdSubject(String scdno) {
		String scdsubject = dao.getScdSubject(scdno); 
		return scdsubject;
	}
		
	// 회의실 이름 가져오기
	@Override
	public String getMtrName(String fk_mtrno) {
		String mtrname = dao.getMtrName(fk_mtrno);
		return mtrname;
	}
	
	// 회의실 예약취소(삭제)
	@Override
	public int delMtrReg(String usemtrno) {
		int n = dao.delMtrReg(usemtrno);
		return n;
	}
	
	// 회의실 예약현황 보여주기(구글 차트)
	@Override 
	public List<Map<String, String>> goRegMtr() { 
		 List<Map<String,String>> regDetailList = dao.goRegMtr(); 
		 return regDetailList; 
	}

	// 해당 접속자가 예약한 모든 회의실 예약 내역 가져오기
	@Override
	public List<MtrHistoryVO> getMtrResvList(String userid) {
		List<MtrHistoryVO> mtrResvList = dao.getMtrResvList(userid);
		return mtrResvList;
	}
	
	// 체크된 예약 내역 삭제하기
	@Override
	public int delOneResv(String usermtrno) {
		int n = dao.delOneResv(usermtrno);
		return n;
	}
	
}
