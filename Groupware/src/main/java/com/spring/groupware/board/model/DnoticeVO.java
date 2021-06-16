package com.spring.groupware.board.model;


public class DnoticeVO {
	
	private String dnotice_seq;     // 글번호 
	private String fk_boardno;    	// 게시판번호
	private String fk_mbr_id;       // 사원아이디
	private String fk_dept_detail;		// 부서번호
	private String dtitle;      	// 글제목
	private String dcontent;      	// 글내용 
	private String dhit;    		// 글조회수
	private String dwritedate;      // 글쓴시간
	
	private String previousseq;     // 이전글번호
	private String previoustitle;  	// 이전글제목
	private String nextseq;         // 다음글번호
	private String nexttitle;      	// 다음글제목   
	   
	public DnoticeVO() {}
	
	public DnoticeVO(String dnotice_seq, String fk_boardno, String fk_mbr_id, String fk_mbr_dept_detail, String dtitle, String dcontent, 
				   String dhit, String dwritedate) {
		super();
		this.dnotice_seq = dnotice_seq;
		this.fk_boardno = fk_boardno;
		this.fk_mbr_id = fk_mbr_id;
		this.fk_dept_detail = fk_dept_detail;
		this.dtitle = dtitle;
		this.dcontent = dcontent;
		this.dhit = dhit;
		this.dwritedate = dwritedate;
	}

	public String getDnotice_seq() {
		return dnotice_seq;
	}

	public void setDnotice_seq(String dnotice_seq) {
		this.dnotice_seq = dnotice_seq;
	}

	public String getFk_boardno() {
		return fk_boardno;
	}

	public void setFk_boardno(String fk_boardno) {
		this.fk_boardno = fk_boardno;
	}

	public String getFk_mbr_id() {
		return fk_mbr_id;
	}

	public void setFk_mbr_id(String fk_mbr_id) {
		this.fk_mbr_id = fk_mbr_id;
	}

	public String getFk_dept_detail() {
		return fk_dept_detail;
	}

	public void setFk_dept_detail(String fk_dept_detail) {
		this.fk_dept_detail = fk_dept_detail;
	}

	public String getDtitle() {
		return dtitle;
	}

	public void setDtitle(String dtitle) {
		this.dtitle = dtitle;
	}

	public String getDcontent() {
		return dcontent;
	}

	public void setDcontent(String dcontent) {
		this.dcontent = dcontent;
	}

	public String getDhit() {
		return dhit;
	}

	public void setDhit(String dhit) {
		this.dhit = dhit;
	}

	public String getDwritedate() {
		return dwritedate;
	}

	public void setDwritedate(String dwritedate) {
		this.dwritedate = dwritedate;
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

	
}
