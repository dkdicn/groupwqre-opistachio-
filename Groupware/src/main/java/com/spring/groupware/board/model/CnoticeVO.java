package com.spring.groupware.board.model;


public class CnoticeVO {
	
	private String cnotice_seq;     // 글번호 
	private String fk_boardno;    	// 게시판번호
	private String fk_mbr_seq;      // 사원번호
	private String ctitle;      	// 글제목
	private String ccontent;      	// 글내용 
	private String chit;    		// 글조회수
	private String cwritedate;      // 글쓴시간
	
	private String previousseq;     // 이전글번호
	private String previoustitle;  	// 이전글제목
	private String nextseq;         // 다음글번호
	private String nexttitle;      	// 다음글제목   
	   
	public CnoticeVO() {}
	
	public CnoticeVO(String cnotice_seq, String fk_boardno, String fk_mbr_seq, String ctitle, String ccontent, 
				   String chit, String cwritedate) {
		super();
		this.cnotice_seq = cnotice_seq;
		this.fk_boardno = fk_boardno;
		this.fk_mbr_seq = fk_mbr_seq;
		this.ctitle = ctitle;
		this.ccontent = ccontent;
		this.chit = chit;
		this.cwritedate = cwritedate;
	}

	public String getCnotice_seq() {
		return cnotice_seq;
	}

	public void setCnotice_seq(String cnotice_seq) {
		this.cnotice_seq = cnotice_seq;
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

	public String getCtitle() {
		return ctitle;
	}

	public void setCtitle(String ctitle) {
		this.ctitle = ctitle;
	}

	public String getCcontent() {
		return ccontent;
	}

	public void setCcontent(String ccontent) {
		this.ccontent = ccontent;
	}

	public String getChit() {
		return chit;
	}

	public void setChit(String chit) {
		this.chit = chit;
	}

	public String getCwritedate() {
		return cwritedate;
	}

	public void setCwritedate(String cwritedate) {
		this.cwritedate = cwritedate;
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
