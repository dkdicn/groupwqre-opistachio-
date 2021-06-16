package com.spring.groupware.board.model;

import org.springframework.web.multipart.MultipartFile;

public class FormboardVO {

	private String form_seq;	// 공지사항순번
	private String fk_boardno;	// 게시판번호   
	private String fk_mbr_seq;	// 작성자
	private String ftitle;		// 제목
	private String fwritedate;	// 등록일자
	private String fhit;		// 조회수
	private String fcontent;	// 내용
	
	private String previousseq;     // 이전글번호
	private String previoustitle;  	// 이전글제목
	private String nextseq;         // 다음글번호
	private String nexttitle;      	// 다음글제목   
	   
    private MultipartFile attach; 	//form 태그에서 type="file" 인 파일을 받아서 저장되는 필드
    private String fileName;    	// WAS에 저장될 파일명 
    private String orgFilename; 	// 사용자가 파일을 업로드 하거나 파일을 다운로드 할때 사용되어지는 파일명
    private String fileSize;    	// 파일크기 
    
	public String getForm_seq() {
		return form_seq;
	}
	
	public void setForm_seq(String form_seq) {
		this.form_seq = form_seq;
	}
	
	public String getFk_boardno() {
		return fk_boardno;
	}
	
	public void setFk_boardno(String fk_boardno) {
		this.fk_boardno = fk_boardno;
	}
	
	public String getFk_mbr_seq() {
		return fk_mbr_seq;
	}
	
	public void setFk_mbr_seq(String fk_mbr_seq) {
		this.fk_mbr_seq = fk_mbr_seq;
	}
	
	public String getFtitle() {
		return ftitle;
	}
	
	public void setFtitle(String ftitle) {
		this.ftitle = ftitle;
	}
	
	public String getFwritedate() {
		return fwritedate;
	}
	
	public void setFwritedate(String fwritedate) {
		this.fwritedate = fwritedate;
	}
	
	public String getFhit() {
		return fhit;
	}
	
	public void setFhit(String fhit) {
		this.fhit = fhit;
	}
	
	public String getFcontent() {
		return fcontent;
	}
	
	public void setFcontent(String fcontent) {
		this.fcontent = fcontent;
	}
	
	public String getPreviousseq() {
		return previousseq;
	}

	public void setPreviousseq(String previousseq) {
		this.previousseq = previousseq;
	}

	public String getPrevioustitle() {
		return previoustitle;
	}

	public void setPrevioustitle(String previoustitle) {
		this.previoustitle = previoustitle;
	}

	public String getNextseq() {
		return nextseq;
	}

	public void setNextseq(String nextseq) {
		this.nextseq = nextseq;
	}

	public String getNexttitle() {
		return nexttitle;
	}

	public void setNexttitle(String nexttitle) {
		this.nexttitle = nexttitle;
	}

	public MultipartFile getAttach() {
		return attach;
	}

	public void setAttach(MultipartFile attach) {
		this.attach = attach;
	}

	public String getFileName() {
		return fileName;
	}

	public void setFileName(String fileName) {
		this.fileName = fileName;
	}

	public String getOrgFilename() {
		return orgFilename;
	}

	public void setOrgFilename(String orgFilename) {
		this.orgFilename = orgFilename;
	}

	public String getFileSize() {
		return fileSize;
	}

	public void setFileSize(String fileSize) {
		this.fileSize = fileSize;
	}

	
	
}
