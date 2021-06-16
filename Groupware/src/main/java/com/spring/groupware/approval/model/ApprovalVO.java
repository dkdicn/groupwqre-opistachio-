package com.spring.groupware.approval.model;

import org.springframework.web.multipart.MultipartFile;

public class ApprovalVO {
	
	private String ap_seq; 			// 결재번호
	private String fk_apform_no;	// 서식번호
	private String fk_mbr_seq;  	// 작성사원번호
	private String ap_dept;			// 기안부서
	private String ap_progress;  	// 진행상태    0:진행중 / 1: 완료 / 2: 반려
	private String ap_title; 		// 문서제목
	private String ap_contents;  	// 결재요청내용
	private String ap_approver;  	// 결재라인
	private String ap_manage_approver; 	// 현재 담당 결재자
	private String ap_referrer; 		// 참조자 
	private String ap_rejecter;  	// 반려자 
	private String ap_reject; 		// 반려사유   
	private String ap_start_day;  	// 기안일자
	private String ap_end_day; 		// 완료(반려)일자 
	
	private String apform_name;		// 서식명
	private String mbr_name;
	
	private MultipartFile files;    
	
	private String fk_ap_seq; 				// 결재번호
	private String ap_filename;				// 결재첨부파일 이름
	private String ap_detail_filename;		// 구분용 결재첨부파일 이름
	private String ap_fileSize;    			// 파일크기 
	
	//////////////////////////////////////////////////////////////
	
	public ApprovalVO() {}

	public String getAp_seq() {
		return ap_seq;
	}

	public void setAp_seq(String ap_seq) {
		this.ap_seq = ap_seq;
	}

	public String getFk_apform_no() {
		return fk_apform_no;
	}

	public void setFk_apform_no(String fk_apform_no) {
		this.fk_apform_no = fk_apform_no;
	}

	public String getFk_mbr_seq() {
		return fk_mbr_seq;
	}

	public void setFk_mbr_seq(String fk_mbr_seq) {
		this.fk_mbr_seq = fk_mbr_seq;
	}

	public String getAp_dept() {
		return ap_dept;
	}

	public void setAp_dept(String ap_dept) {
		this.ap_dept = ap_dept;
	}

	public String getAp_progress() {
		return ap_progress;
	}

	public void setAp_progress(String ap_progress) {
		this.ap_progress = ap_progress;
	}

	public String getAp_title() {
		return ap_title;
	}

	public void setAp_title(String ap_title) {
		this.ap_title = ap_title;
	}

	public String getAp_contents() {
		return ap_contents;
	}

	public void setAp_contents(String ap_contents) {
		this.ap_contents = ap_contents;
	}

	public String getAp_approver() {
		return ap_approver;
	}

	public void setAp_approver(String ap_approver) {
		this.ap_approver = ap_approver;
	}

	public String getAp_manage_approver() {
		return ap_manage_approver;
	}

	public void setAp_manage_approver(String ap_manage_approver) {
		this.ap_manage_approver = ap_manage_approver;
	}

	public String getAp_referrer() {
		return ap_referrer;
	}

	public void setAp_referrer(String ap_referrer) {
		this.ap_referrer = ap_referrer;
	}

	public String getAp_rejecter() {
		return ap_rejecter;
	}

	public void setAp_rejecter(String ap_rejecter) {
		this.ap_rejecter = ap_rejecter;
	}

	public String getAp_reject() {
		return ap_reject;
	}

	public void setAp_reject(String ap_reject) {
		this.ap_reject = ap_reject;
	}

	public String getAp_start_day() {
		return ap_start_day;
	}

	public void setAp_start_day(String ap_start_day) {
		this.ap_start_day = ap_start_day;
	}

	public String getAp_end_day() {
		return ap_end_day;
	}

	public void setAp_end_day(String ap_end_day) {
		this.ap_end_day = ap_end_day;
	}

	public String getApform_name() {
		return apform_name;
	}

	public void setApform_name(String apform_name) {
		this.apform_name = apform_name;
	}

	public String getMbr_name() {
		return mbr_name;
	}

	public void setMbr_name(String mbr_name) {
		this.mbr_name = mbr_name;
	}

	public MultipartFile getFiles() {
		return files;
	}

	public void setFiles(MultipartFile files) {
		this.files = files;
	}

	public String getFk_ap_seq() {
		return fk_ap_seq;
	}

	public void setFk_ap_seq(String fk_ap_seq) {
		this.fk_ap_seq = fk_ap_seq;
	}

	public String getAp_filename() {
		return ap_filename;
	}

	public void setAp_filename(String ap_filename) {
		this.ap_filename = ap_filename;
	}

	public String getAp_detail_filename() {
		return ap_detail_filename;
	}

	public void setAp_detail_filename(String ap_detail_filename) {
		this.ap_detail_filename = ap_detail_filename;
	}

	public String getAp_fileSize() {
		return ap_fileSize;
	}

	public void setAp_fileSize(String ap_fileSize) {
		this.ap_fileSize = ap_fileSize;
	}

	
	
	
	
}
		