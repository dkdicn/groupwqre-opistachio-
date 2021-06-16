package com.spring.groupware.approval.service;

import java.util.*;
import com.spring.groupware.approval.model.ApprovalVO;
import com.spring.groupware.member.model.*;

public interface InterApprovalService {

	// 문서번호 가져오기
	String getFileNo();

	// 모달창에 입력될 전체 사원명 가져오기
	List<MemberVO> getMemberList();

	// 결재요청 정보 저장하기
	int submitApproval(ApprovalVO avo);

	// 첨부파일 있는 결재요청
	int submitAttachedApproval(List<Map<String, String>> fileInfoList);

	// 결재대기 문서 가져오기
	List<ApprovalVO> getApprovalNeededList(Map<String, String> paraMap);

	// 결재요청한 문서 가져오기
	List<ApprovalVO> getApprovalSubmitList(Map<String, String> paraMap);

	// 결재참조된 문서 가져오기
	List<ApprovalVO> getApprovalReferredList(Map<String, String> paraMap);

	// 결재 작성내용 불러오기
	ApprovalVO getApproval(String ap_seq);

	// 결재 승인하기
	int approvalConfirm(Map<String, String> paraMap);

	// 결재 삭제하기
	int approvalDelete(String ap_seq);

	



	
	
}