package com.spring.groupware.workmanage.model;

public class TodoVO {
	private String rno;			
	private String tdno;		// 할일리스트 고유번호
	private String fk_mbr_seq;	// 사원번호
	private String subject;		// 제목
	private String contents;	// 내용
	private String registerday;	// 등록일자
	private String deadline;	// 마감일자
	private String important;	// 중요여부 (0 or 1)
	private String fk_statno; 	// 상태  
	
	private String delayday;  		// 마감일자 지난 일 수 
	private String lasteditdate; 	// 마지막으로 수정한 날짜
	
	
	public TodoVO() {}
	
	public TodoVO(String rno, String tdno, String fk_mbr_seq, String subject, String contents, String registerday, String deadline,
			String important, String fk_statno) {
		super();
		this.rno = rno;
		this.tdno = tdno;
		this.fk_mbr_seq = fk_mbr_seq;
		this.subject = subject;
		this.contents = contents;
		this.registerday = registerday;
		this.deadline = deadline;
		this.important = important;
		this.fk_statno = fk_statno;
	}

	public String getRno() {
		return rno;
	}

	public void setRno(String rno) {
		this.rno = rno;
	}

	public String getTdno() {
		return tdno;
	}

	public void setTdno(String tdno) {
		this.tdno = tdno;
	}

	public String getFk_mbr_seq() {
		return fk_mbr_seq;
	}

	public void setFk_mbr_seq(String fk_mbr_seq) {
		this.fk_mbr_seq = fk_mbr_seq;
	}

	public String getSubject() {
		return subject;
	}

	public void setSubject(String subject) {
		this.subject = subject;
	}

	public String getContents() {
		return contents;
	}

	public void setContents(String contents) {
		this.contents = contents;
	}

	public String getRegisterday() {
		return registerday;
	}

	public void setRegisterday(String registerday) {
		this.registerday = registerday;
	}

	public String getDeadline() {
		return deadline;
	}

	public void setDeadline(String deadline) {
		this.deadline = deadline;
	}

	public String getImportant() {
		return important;
	}

	public void setImportant(String important) {
		this.important = important;
	}

	public String getFk_statno() {
		return fk_statno;
	}

	public void setFk_statno(String fk_statno) {
		this.fk_statno = fk_statno;
	}

	public String getDelayday() {
		return delayday;
	}

	public void setDelayday(String delayday) {
		this.delayday = delayday;
	}

	public String getLasteditdate() {
		return lasteditdate;
	}

	public void setLasteditdate(String lasteditdate) {
		this.lasteditdate = lasteditdate;
	}
	
	
	
}
