package com.spring.groupware.approval.service;

import java.util.*;

import org.springframework.beans.factory.annotation.Autowired;

import org.springframework.stereotype.Component;
import org.springframework.stereotype.Service;

import com.spring.groupware.approval.model.*;
import com.spring.groupware.member.model.MemberVO;



@Component
@Service
public class ApprovalService implements InterApprovalService {
	
	// 의존객체 주입
	@Autowired
	private InterApprovalDAO adao;

	// 문서번호 가져오기
	@Override
	public String getFileNo() {
		String fileNo = adao.getFileNo();
		return fileNo;
	}

	// 모달창에 입력될 전체 사원명 가져오기
	@Override
	public List<MemberVO> getMemberList() {
		List<MemberVO> memberList = adao.getMemberList();
		return memberList;
	}

	// 결재요청 정보 저장하기
	@Override
	public int submitApproval(ApprovalVO avo) {
		int n = adao.submitApproval(avo);
		return n;
	}

	// 첨부파일 있는 결재요청
	@Override
	public int submitAttachedApproval(List<Map<String, String>> fileInfoList) {
		int n = adao.submitAttachedApproval(fileInfoList);
		return n;
	}

	// 결재대기 문서 가져오기
	@Override
	public List<ApprovalVO> getApprovalNeededList(Map<String, String> paraMap) {
		List<ApprovalVO> approvalList = adao.getApprovalNeededList(paraMap);
		return approvalList;
	}

	// 결재요청한 문서 가져오기
	@Override
	public List<ApprovalVO> getApprovalSubmitList( Map<String, String> paraMap) {
		List<ApprovalVO> approvalList = adao.getApprovalSubmitList(paraMap);
		return approvalList;
	}

	// 결재참조된 문서 가져오기
	@Override
	public List<ApprovalVO> getApprovalReferredList(Map<String, String> paraMap) {
		List<ApprovalVO> approvalList = adao.getApprovalReferredList(paraMap);
		return approvalList;
	}

	// 결재 작성내용 불러오기
	@Override
	public ApprovalVO getApproval(String ap_seq) {
		ApprovalVO approval = adao.getApproval(ap_seq);
		return approval;
	}

	// 결재승인하기
	@Override
	public int approvalConfirm(Map<String, String> paraMap) {
		int n = adao.approvalConfirm(paraMap);
		return n;
	}

	// 결재삭제하기
	@Override
	public int approvalDelete(String ap_seq) {
		int n = adao.approvalDelete(ap_seq);
		return 0;
	}




	
	
	
	
	
}