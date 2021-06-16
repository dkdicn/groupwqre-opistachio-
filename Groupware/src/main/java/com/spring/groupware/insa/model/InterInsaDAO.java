package com.spring.groupware.insa.model;

import java.util.List;
import java.util.Map;


public interface InterInsaDAO {

	// 인사정보 등록하기
	int insaRegister1End(InsaVO insavo);

	// 멤버 리스트 가져오기
	List<InsaVO> getInsaList(Map<String, String> paraMap);

	// 시퀀스 가져오기
	int getSequence();
	
	// view1할 멤버 정보 가져오기
	InsaVO getInsaView1(String seq);

	// view2할 멤버 정보 가져오기
	List<EduVO> getEduList(String seq);

	// 최종학력 가져오기
	int getMaxEduLevel(String seq);

	// 학력정보 가져오기
	int getEduNum(String seq);

	// 자격증정보 가져오기
	int getCertiNum(String seq);

	// 학력정보 입력하기
	int insaRegister2EndEdu(EduVO evo);
	
	// 자격증정보 입력하기
	int insaRegister2EndCerti(CertiVO cvo);

	// 자격증 리스트 가져오기
	List<CertiVO> getCertiList(String seq);

	// 개인별 급여 리스트 가져오기
	List<PaymentVO> getPaymentList(String seq);

    // 학력번호 가져오기
	int getEduSeq();

	// 학력 삭제하기
	int insaEduDel(String edu_seq);

    // 자격증번호 가져오기
	int getCertiSeq();

	// 자격증 삭제하기
	int insaCertiDel(String certi_seq);

	// 학력정보 가져오기
	EduVO getEduInfo(String edu_seq);

    // 학력정보 수정하기
	int eduModify(EduVO evo);

	// 자격증 정보 가져오기
	CertiVO getCertiInfo(String certi_seq);

    // 자격증정보 수정하기
	int certiModify(CertiVO cvo);

    // 개인별 급여 정보 가져오기
	PayInfoVO getPayInfo(String seq);

    // 개인별 이달 급여 정보 가져오기
	PaymentVO getPayment(String seq);

    // 개인 급여 정보 등록하기
	int payRegister(PayInfoVO pivo);

    // 개인 급여 정보 수정하기
	int payModify(PayInfoVO pivo);

    // 개인 급여 정보 삭제하기
	int payDel(String seq);

    // 개인별 급여 상세 등록하기
	int paymentRegiEnd(PaymentVO pavo);

     // 개인 월별 급여정보 가져오기
	List<PaymentVO> payModiGetInfo(String seq);

	// 급여 내역 수정하기
	int paymentModiEnd(PaymentVO pavo);

    // 인사정보 수정 등록하기
	int insaModify1End(InsaVO insavo);

	// 급여 내역 삭제하기
	int paymentDelEnd(PaymentVO pavo);

	// 총 게시물 건수(totalCount)
	int getTotalCount(Map<String, String> paraMap);


    // 개인별 월별 근무시간 가져오기
	int getWorkHours(Map<String, String> paraMap);

	// 개인별 급여 기본급 수정하기  
	void updateBasePay(Map<String, String> paraMap);

	// 기본급 등록되어있는지 알아보기
	int checkPayMonthExist(Map<String, String> paraMap);

	// 개인별 급여 기본급 등록하기  
	void insertBasePay(Map<String, String> paraMap);


}
