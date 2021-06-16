package com.spring.groupware.workmanage.model;

public class WorkVO {
	private String rno; 
	private String wmno; 				//업무관리고유번호
	private String fk_wtno; 			// 업무분류번호
	private String requester; 			// 요청자
	private String receivers;			// 수신자들
	private String referrers;			// 참조자들
	private String subject;				// 제목
	private String contents;			// 내용
	private String registerday;			// 등록일자
	private String deadline; 			// 마감일자
	private String checkstatus;			// 확인여부 (0 or 1)
	private String important;			// 중요여부 (0 or 1)
	private String fk_statno;  			// 업무상태번호
	
	private String delayday;  		// 마감일자 지난 일 수 
	private String lasteditdate; 	// 마지막으로 수정한 날짜
	
	
	public WorkVO() {}
	
	public WorkVO(String rno, String wmno, String fk_wtno, String requester, String receivers, String referrers, String subject,
			String contents, String registerday, String deadline, String checkstatus, String important, String lasteditdate,
			String fk_statno) {
		this.rno = rno;
		this.wmno = wmno;
		this.fk_wtno = fk_wtno;
		this.requester = requester;
		this.receivers = receivers;
		this.referrers = referrers;
		this.subject = subject;
		this.contents = contents;
		this.registerday = registerday;
		this.deadline = deadline;
		this.lasteditdate = lasteditdate;
		this.checkstatus = checkstatus;
		this.important = important;
		this.fk_statno = fk_statno;
	}

	public String getRno() {
		return rno;
	}

	public void setRno(String rno) {
		this.rno = rno;
	}

	public String getWmno() {
		return wmno;
	}

	public void setWmno(String wmno) {
		this.wmno = wmno;
	}

	public String getFk_wtno() {
		return fk_wtno;
	}

	public void setFk_wtno(String fk_wtno) {
		this.fk_wtno = fk_wtno;
	}

	
	public String getRequester() {
		return requester;
	}

	public void setRequester(String requester) {
		this.requester = requester;
	}

	public String getReceivers() {
		return receivers;
	}

	public void setReceivers(String receivers) {
		this.receivers = receivers;
	}

	public String getReferrers() {
		return referrers;
	}

	public void setReferrers(String referrers) {
		this.referrers = referrers;
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

	public String getCheckstatus() {
		return checkstatus;
	}

	public void setCheckstatus(String checkstatus) {
		this.checkstatus = checkstatus;
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

	// --------------------------------------
	
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
