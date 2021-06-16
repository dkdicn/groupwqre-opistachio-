package com.spring.groupware.insa.model;

import java.util.Collection;
import java.util.Iterator;
import java.util.List;
import java.util.ListIterator;
import java.util.Map;

import javax.annotation.Resource;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.stereotype.Component;
import org.springframework.stereotype.Repository;

@Component
@Repository
public class InsaDAO implements InterInsaDAO {

	@Resource
	private SqlSessionTemplate sqlsession; // 로컬 DB에 연결
	
	// 인사정보 등록하기
	@Override
	public int insaRegister1End(InsaVO insavo) {
		int n=0;

		n = sqlsession.insert("insa.insaRegisterEnd", insavo);
			
	//	System.out.println("mem=>"+insavo.getMbr_id());
		return n;
	}



	// 멤버정보 불러오기
	@Override
	public List<InsaVO> getInsaList(Map<String, String> paraMap) {
		List<InsaVO> insaList= sqlsession.selectList("insa.insaList",paraMap);
		return insaList;
	}


	@Override
	public int getSequence() {
		int seq = Integer.parseInt(sqlsession.selectOne("insa.getInsaSequence"));
		return seq;
	}


	// view1할 멤버 정보 가져오기
	@Override
	public InsaVO getInsaView1(String seq) {
		InsaVO insavo = sqlsession.selectOne("insa.getInsaView1", seq);
		return insavo;
	}

	// view2할 멤버 정보 가져오기@Override
	public List<EduVO> getEduList(String seq) {
		List<EduVO> eduList = sqlsession.selectList("insa.getEduList", seq);
		
		return eduList;
	}


	// 최종학력 가져오기
	@Override
	public int getMaxEduLevel(String seq) {
		int maxEduLevel=0;
		try {
			maxEduLevel = sqlsession.selectOne("insa.getMaxEduLevel", seq);
		} catch (Exception e) {
			maxEduLevel = 7;
		}
		return maxEduLevel;
	}


	// 자격증 리스트 가져오기
	@Override
	public List<CertiVO> getCertiList(String seq) {
		List<CertiVO> certiList = sqlsession.selectList("insa.getCertiList", seq);
		return certiList;
	}


	// 학력정보 가져오기
	@Override
	public int getEduNum(String seq) {
		int n = sqlsession.selectOne("insa.getEduNum", seq);
		return n;
	}



	// 자격증정보 가져오기
	@Override
	public int getCertiNum(String seq) {
		int m = sqlsession.selectOne("insa.getCertiNum", seq);
		return m;
	}



	// 학력정보 입력하기
	@Override
	public int insaRegister2EndEdu(EduVO evo) {
		int n = sqlsession.insert("insa.insaRegister2EndEdu", evo);
		return n;
	}


	// 자격증정보 입력하기
	@Override
	public int insaRegister2EndCerti(CertiVO cvo) {
		int m = sqlsession.insert("insa.insaRegister2EndCerti", cvo);
		return m;
	}



	// 개인별 급여 리스트 가져오기
	@Override
	public List<PaymentVO> getPaymentList(String seq) {
		List<PaymentVO> paymentList = sqlsession.selectList("insa.getPaymentList", seq);
		return paymentList;
	}



    // 학력번호 가져오기
	@Override
	public int getEduSeq() {
		int edu_seq = sqlsession.selectOne("insa.getEduSeq");
		return edu_seq;
	}



	// 학력 삭제하기
	@Override
	public int insaEduDel(String edu_seq) {
		int n = sqlsession.delete("insa.insaEduDel", edu_seq);
		return n;
	}



    // 자격증번호 가져오기
	@Override
	public int getCertiSeq() {
		int certi_seq = sqlsession.selectOne("insa.getCertiSeq");
		return certi_seq;
	}



	// 자격증 삭제하기
	@Override
	public int insaCertiDel(String certi_seq) {
		int n = sqlsession.delete("insa.insaCertiDel", certi_seq);
		return n;
	}



	// 학력정보 가져오기
	@Override
	public EduVO getEduInfo(String edu_seq) {

		EduVO evo = sqlsession.selectOne("insa.getEduInfo", edu_seq);
		
		return evo;
	}



    // 학력정보 수정하기
	@Override
	public int eduModify(EduVO evo) {
		int n = sqlsession.update("insa.eduModify", evo);
		return n;
	}



	// 자격증 정보 가져오기
	@Override
	public CertiVO getCertiInfo(String certi_seq) {

    	CertiVO cvo = sqlsession.selectOne("insa.getCertiInfo", certi_seq);
		
		return cvo;
	}



    // 자격증정보 수정하기
	@Override
	public int certiModify(CertiVO cvo) {
		int n = sqlsession.update("insa.certiModify", cvo);
		return n;
	}



    // 개인별 급여 정보 가져오기
	@Override
	public PayInfoVO getPayInfo(String seq) {
		PayInfoVO pivo = sqlsession.selectOne("insa.getPayInfo",seq);
		return pivo;
	}



    // 개인별 이달 급여 정보 가져오기
	@Override
	public PaymentVO getPayment(String seq) {
		 PaymentVO pvo = sqlsession.selectOne("insa.getPayment", seq);
		return pvo;
	}



    // 개인 급여 정보 등록하기
	@Override
	public int payRegister(PayInfoVO pivo) {
		int n = sqlsession.insert("insa.payRegister", pivo);
		return n;
	}



    // 개인 급여 정보 수정하기
	@Override
	public int payModify(PayInfoVO pivo) {
		int n = sqlsession.update("insa.payModify", pivo);
		return n;
	}



    // 개인 급여 정보 삭제하기
	@Override
	public int payDel(String seq) {
		int n = sqlsession.delete("insa.payDel", seq);
		return n;
	}



    // 개인별 급여 상세 등록하기
	@Override
	public int paymentRegiEnd(PaymentVO pavo) {
		int n = sqlsession.insert("insa.paymentRegiEnd", pavo);
		return n;
	}



    // 개인 월별 급여정보 가져오기
	@Override
	public List<PaymentVO> payModiGetInfo(String seq) {
		List<PaymentVO> payList = sqlsession.selectList("insa.payModiGetInfo", seq);
		return payList;
	}



	// 급여 내역 수정하기
	@Override
	public int paymentModiEnd(PaymentVO pavo) {
		int n = sqlsession.update("insa.paymentModiEnd", pavo);
		return n;
	}



    // 인사정보 수정 등록하기
	@Override
	public int insaModify1End(InsaVO insavo) {
		int n = sqlsession.update("insa.insaModify1End", insavo);
		return n;
	}



	// 급여 내역 삭제하기
	@Override
	public int paymentDelEnd(PaymentVO pavo) {
		int n = sqlsession.delete("insa.paymentDelEnd", pavo);
		return n;
	}



	// 총 게시물 건수(totalCount)
	@Override
	public int getTotalCount(Map<String, String> paraMap) {
		int n = Integer.parseInt(sqlsession.selectOne("insa.getTotalCount", paraMap));
		return n;
	}



	// 개인별 월별 근무시간 가져오기
	@Override
	public int getWorkHours(Map<String, String> paraMap) {
		int n = sqlsession.selectOne("insa.getWorkHours", paraMap);
		return n;
	}



	// 개인별 급여 기본급 수정하기  
	@Override
	public void updateBasePay(Map<String, String> paraMap) {
		sqlsession.update("insa.updateBasePay", paraMap);
		
	}



	// 기본급 등록되어있는지 알아보기
	@Override
	public int checkPayMonthExist(Map<String, String> paraMap) {
		int n = sqlsession.selectOne("insa.checkPayMonthExist",paraMap);
		return n;
	}



	// 개인별 급여 기본급 등록하기  
	@Override
	public void insertBasePay(Map<String, String> paraMap) {
		sqlsession.insert("insa.insertBasePay", paraMap);
		
	}






}
