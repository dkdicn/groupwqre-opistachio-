package com.spring.groupware.approval.model;

import org.springframework.stereotype.Component;
import org.springframework.stereotype.Repository;

import com.spring.groupware.member.model.MemberVO;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;

import org.mybatis.spring.SqlSessionTemplate;


@Component
@Repository
public class ApprovalDAO implements InterApprovalDAO {

	@Resource
	private SqlSessionTemplate sqlsession; // 원격 DB에 연결

	// 문서번호 가져오기
	@Override
	public String getFileNo() {
		int fileNo = sqlsession.selectOne("approval.getFileNo");
		return String.valueOf(fileNo);		
	}

	// 모달창에 입력될 전체 사원명 가져오기
	@Override
	public List<MemberVO> getMemberList() {
		List<MemberVO> memberList = sqlsession.selectList("approval.getMemberList");
		return memberList;
	}

	// 결재요청 정보 저장하기
	@Override
	public int submitApproval(ApprovalVO avo) {
		int n = sqlsession.insert("approval.submitApproval", avo);
		return n;
	}

	// 첨부파일 있는 결재요청
	@Override
	public int submitAttachedApproval(List<Map<String, String>> fileInfoList) {
		int n=0;
		for (int i=0; i<fileInfoList.size(); i++) {
			n = sqlsession.insert("approval.submitAttachedApproval", fileInfoList.get(i));
			if(n!=1) break;
		}
		return n;
	}

	// 결재대기 문서 가져오기
	@Override
	public List<ApprovalVO> getApprovalNeededList(Map<String, String> paraMap) {
		List<ApprovalVO> approvalList = sqlsession.selectList("approval.getApprovalNeededList", paraMap);		
		return approvalList;
	}

	// 결재요청한 문서 가져오기
	@Override
	public List<ApprovalVO> getApprovalSubmitList(Map<String, String> paraMap) {
		List<ApprovalVO> approvalList = sqlsession.selectList("approval.getApprovalSubmitList", paraMap);
		return approvalList;
	}

	// 결재참조된 문서 가져오기
	@Override
	public List<ApprovalVO> getApprovalReferredList(Map<String, String> paraMap) {
		List<ApprovalVO> approvalList = sqlsession.selectList("approval.getApprovalReferredList", paraMap);
		return approvalList;
	}

	// 결재 작성내용 불러오기
	@Override
	public ApprovalVO getApproval(String ap_seq) {
		ApprovalVO approval = sqlsession.selectOne("approval.getApproval", ap_seq);
		return approval;
	}

	// 결재승인하기
	@Override
	public int approvalConfirm(Map<String, String> paraMap) {
		int n = sqlsession.update("approval.approvalConfirm", paraMap);
		return n;
	}

	// 결재삭제하기
	@Override
	public int approvalDelete(String ap_seq) {
		int n = sqlsession.delete("approval.approvalDelete", ap_seq);
		return n;
	}



}