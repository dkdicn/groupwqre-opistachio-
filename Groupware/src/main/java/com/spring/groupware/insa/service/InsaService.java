package com.spring.groupware.insa.service;


import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;

// import javax.annotation.Resource;

import org.springframework.stereotype.Component;
import org.springframework.stereotype.Service;

import com.spring.groupware.insa.model.CertiVO;
import com.spring.groupware.insa.model.EduVO;
import com.spring.groupware.insa.model.InterInsaDAO;
import com.spring.groupware.insa.model.PayInfoVO;
import com.spring.groupware.insa.model.PaymentVO;
import com.spring.groupware.insa.model.InsaVO;


//=== #31. Service 선언 === 
//트랜잭션 처리를 담당하는곳 , 업무를 처리하는 곳, 비지니스(Business)단
@Component
@Service
public class InsaService implements InterInsaService {

	@Autowired
	private InterInsaDAO idao;

	
	// 인사정보 등록하기
	@Override
	public int insaRegister1End(InsaVO insavo) {
		int n = idao.insaRegister1End(insavo);
		return n;
	}



	@Override
	public List<InsaVO> getInsaList(Map<String, String> paraMap) {
		List<InsaVO> InsaList = idao.getInsaList(paraMap);
		return InsaList;
	}


	// 시퀀스 가져오기
	@Override
	public int getSequence() {
		int seq = idao.getSequence();
		return seq;
	}



	// view1할 멤버 정보 가져오기
	@Override
	public InsaVO getInsaView1(String seq) {
		InsaVO Insavo = idao.getInsaView1(seq);
		return Insavo;
	}



	// view2할 학력 리스트 가져오기
	@Override
	public List<EduVO> getEduList(String seq) {
		List<EduVO> eduList = idao.getEduList(seq);
		return eduList;
	}



	// 최종학력 가져오기
	@Override
	public int getMaxEduLevel(String seq) {
		int maxEduLevel = idao.getMaxEduLevel(seq);
		return maxEduLevel;
	}


	// 자격증 리스트 가져오기
	@Override
	public List<CertiVO> getCertiList(String seq) {
		List<CertiVO> certiList = idao.getCertiList(seq);
		return certiList;
	}

	// 학력정보 가져오기
	@Override
	public int getEduNum(String seq) {
		int n = idao.getEduNum(seq);
		return n;
	}


	// 자격증정보 가져오기
	@Override
	public int getCertiNum(String seq) {
		int m = idao.getCertiNum(seq);
		return m;
	}



	// 학력정보 입력하기
	@Override
	public int insaRegister2EndEdu(EduVO evo) {
		int n = idao.insaRegister2EndEdu(evo);
		return n;
	}



	// 자격증정보 입력하기
	@Override
	public int insaRegister2EndCerti(CertiVO cvo) {
		int m = idao.insaRegister2EndCerti(cvo);
		return m;
	}



	// 개인별 급여 리스트 가져오기
	@Override
	public List<PaymentVO> getPaymentList(String seq) {
		List<PaymentVO> paymentList = idao.getPaymentList(seq);
		return paymentList;
	}



    // 학력번호 가져오기
	@Override
	public int getEduSeq() {
		int edu_seq = idao.getEduSeq();
		return edu_seq;
	}



	// 학력 삭제하기
	@Override
	public int insaEduDel(String edu_seq) {
		int n = idao.insaEduDel(edu_seq);
		return n;
	}



    // 자격증번호 가져오기
	@Override
	public int getCertiSeq() {
		int certi_seq = idao.getCertiSeq();
		return certi_seq;
	}



	// 자격증 삭제하기
	@Override
	public int insaCertiDel(String certi_seq) {
		int n = idao.insaCertiDel(certi_seq);
		return n;
	}



	// 학력정보 가져오기
	@Override
	public EduVO getEduInfo(String edu_seq) {
		EduVO evo = idao.getEduInfo(edu_seq);
		return evo;
	}



    // 학력정보 수정하기
	@Override
	public int eduModify(EduVO evo) {
		int n = idao.eduModify(evo);
		return n;
	}



	// 자격증 정보 가져오기
	@Override
	public CertiVO getCertiInfo(String certi_seq) {
		CertiVO cvo = idao.getCertiInfo(certi_seq);
		return cvo;
	}



    // 자격증정보 수정하기
	@Override
	public int certiModify(CertiVO cvo) {
		int n = idao.certiModify(cvo);
		return n;
	}



    // 개인별 급여 정보 가져오기
	@Override
	public PayInfoVO getPayInfo(String seq) {
		PayInfoVO pivo = idao.getPayInfo(seq);
		return pivo;
	}



    // 개인별 이달 급여 정보 가져오기
	@Override
	public PaymentVO getPayment(String seq) {
		PaymentVO pvo = idao.getPayment(seq);
		return pvo;
	}



    // 개인 급여 정보 등록하기
	@Override
	public int payRegister(PayInfoVO pivo) {
		int n = idao.payRegister(pivo);
		return n;
	}



    // 개인 급여 정보 수정하기
	@Override
	public int payModify(PayInfoVO pivo) {
		int n = idao.payModify(pivo);
		return n;
	}



    // 개인 급여 정보 삭제하기
	@Override
	public int payDel(String seq) {
		int n = idao.payDel(seq);
		return n;
	}



    // 개인별 급여 상세 등록하기
	@Override
	public int paymentRegiEnd(PaymentVO pavo) {
		int n = idao.paymentRegiEnd(pavo);
		return n;
				
	}



     // 개인 월별 급여정보 가져오기
	@Override
	public List<PaymentVO> payModiGetInfo(String seq) {
		List<PaymentVO> payList = idao.payModiGetInfo(seq);
		return payList;
	}



	// 급여 내역 수정하기
	@Override
	public int paymentModiEnd(PaymentVO pavo) {
		int n = idao.paymentModiEnd(pavo);
		return n;
	}



    // 인사정보 수정 등록하기
	@Override
	public int insaModify1End(InsaVO insavo) {
		int n = idao.insaModify1End(insavo);
		return n;
	}



	// 급여 내역 삭제하기
	@Override
	public int paymentDelEnd(PaymentVO pavo) {
		int n = idao.paymentDelEnd(pavo);
		return n;
	}



	// 총 게시물 건수(totalCount)
	@Override
	public int getTotalCount(Map<String, String> paraMap) {
		int n = idao.getTotalCount(paraMap);
		return n;
	}




	// 개인별 월별 근무시간 가져오기
	@Override
	public int getWorkHours(Map<String, String> paraMap) {
		int n = idao.getWorkHours(paraMap);
		return n;
	}



	// 개인별 급여 기본급 수정하기  
	@Override
	public void updateBasePay(Map<String, String> paraMap) {
		idao.updateBasePay(paraMap);
		
	}



	// 기본급 등록되어있는지 알아보기
	@Override
	public int checkPayMonthExist(Map<String, String> paraMap) {
		int n = idao.checkPayMonthExist(paraMap);
		return n;
	}



	// 개인별 급여 기본급 등록하기  
	@Override
	public void insertBasePay(Map<String, String> paraMap) {
		idao.insertBasePay(paraMap);
		
	}





	
	
}
