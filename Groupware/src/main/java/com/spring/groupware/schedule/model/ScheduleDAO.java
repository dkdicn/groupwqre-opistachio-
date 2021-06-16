package com.spring.groupware.schedule.model;

import java.util.List;
import java.util.Map;

import javax.annotation.Resource;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.stereotype.Component;
import org.springframework.stereotype.Repository;

import com.spring.groupware.addrlist.model.AddrVO;

@Component
@Repository
public class ScheduleDAO implements InterScheduleDAO {
	
	@Resource
	private SqlSessionTemplate sqlsession;
	
	// 일정번호 채번해오기
	@Override
	public int getScdno() {
		int scdno = sqlsession.selectOne("schedule.goScdno");
		return scdno;
	}
	
	// 주소록 가져오기
	@Override
	public List<AddrVO> getAddrList() {
		List<AddrVO> addrList = sqlsession.selectList("schedule.getAddrList");
		return addrList;
	}

	// 검색한 주소 목록 보여주기
	@Override
	public List<AddrVO> addrList_Search(Map<String, String> paraMap) {
		List<AddrVO> addrList = sqlsession.selectList("schedule.addrList_Search", paraMap);
		return addrList;
	}
	
	// 일정 등록하기
	@Override
	public int scdAdd(ScheduleVO schedulevo) {
		int n = sqlsession.insert("schedule.scdAdd", schedulevo);
		return n;
	}
	
	// 수정해야할 글 1개 가져오기
	@Override
	public ScheduleVO getViewScd(String scdno) {
		ScheduleVO schedulevo = sqlsession.selectOne("schedule.getViewScd",scdno);
		return schedulevo;
	}
	
	// 일정 수정하기
	@Override
	public int editScd(ScheduleVO schedulevo) {
		int n = sqlsession.update("schedule.editScd", schedulevo);
		return n;
	}
	
	//일정 삭제하기
	@Override
	public int delScd(String scdno) {
		int n = sqlsession.delete("schedule.delScd", scdno);
		return n;
	}
	
	// 캘린더에 일정 보여주기
	@Override
	public List<Map<String, String>> showScd(Map<String, String> paraMap) {
		List<Map<String, String>> scdList = sqlsession.selectList("schedule.showScd", paraMap);
		return scdList;
	}
	
	// 모든 일정 삭제하기
	@Override
	public int delAll(int mbr_seq) {
		int n = sqlsession.delete("schedule.delAll", mbr_seq);
		return n;
	}
	
	// 나의 일정 개수 확인하기
	@Override
	public int cntMyTotalScd(int mbr_seq) {
		int totalCnt = sqlsession.selectOne("schedule.cntMyTotalScd", mbr_seq);
		return totalCnt;
	}
	
	///////////////////////////////////////////////////////////////////
	
	// 회의실 이용기록번호 채번하기
	@Override
	public int getNum() {
		int usemtrno = sqlsession.selectOne("schedule.getNum");
		return usemtrno;
	}
	
	// 회의실 예약하기
	@Override
	public int resvMtrEnd(MtrHistoryVO mtrhvo) {
		int n = sqlsession.insert("schedule.resvMtrEnd", mtrhvo);
		return n;
	}
	
	// 회의실 예약취소(삭제)
	@Override
	public int delMtrReg(String usemtrno) {
		int n = sqlsession.delete("schedule.delMtrReg", usemtrno);
		return n;
	}
	
	// 일정명 가져오기
	@Override
	public String getScdSubject(String scdno) {
		String scdsubject = sqlsession.selectOne("schedule.getScdSubject",scdno);
		return scdsubject;
	}
	
	// 회의실명 가져오기
	@Override
	public String getMtrName(String fk_mtrno) {
		String mtrname = sqlsession.selectOne("schedule.getMtrName", fk_mtrno);
		return mtrname;
	}
	
	// 회의실 예약현황 보여주기(구글 차트)
	@Override 
	public List<Map<String, String>> goRegMtr() { 
		List<Map<String,String>> regDetailList = sqlsession.selectList("schedule.goRegMtr"); 
		return regDetailList; 
	}
	
	// 해당 접속자가 예약한 모든 회의실 예약 내역 가져오기
	@Override
	public List<MtrHistoryVO> getMtrResvList(String userid) {
		List<MtrHistoryVO> mtrResvList = sqlsession.selectList("schedule.getMtrResvList", userid);
		return mtrResvList;
	}
	
	// 체크된 예약 내역 삭제하기
	@Override
	public int delOneResv(String usermtrno) {
		int n = sqlsession.delete("schedule.delOneResv", usermtrno);
		return n;
	}
	
	
	

	
	
}
