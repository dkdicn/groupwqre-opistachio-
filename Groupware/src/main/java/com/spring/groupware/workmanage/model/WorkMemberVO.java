package com.spring.groupware.workmanage.model;


public class WorkMemberVO {
	
	// == 사원업무관리테이블 == //
	private String workmbr_seq; 	// 사원업무관리고유번호
	private String fk_wmno;			// 업무고유번호
	private String fk_wrno;			// 해당 업무에 대한 역할(발신자, 수신자, 참조자)
	private String fk_mbr_seq;		// 멤버 seq
	private String readcheckdate; 	// 읽은 날짜
	
	// == 업무처리내역테이블 == //
	private String contents;		// 처리내역
	private String workPercent;		// 개인 업무 진행 상태
	private String lasteditdate; 	// 마지막으로 수정한 날짜
	
	// == 부모 테이블의 정보 == //
	private String mbr_name;		// 멤버 이름 저장하기 위해 생성
	
	public WorkMemberVO() {}
	
	
	public WorkMemberVO(String fk_wmno, String fk_wrno, String fk_mbr_seq, String workPercent, 
			String lasteditdate, String readcheckdate) {
		super();
		this.fk_wmno = fk_wmno;
		this.fk_wrno = fk_wrno;
		this.fk_mbr_seq = fk_mbr_seq;
		this.workPercent = workPercent;
		this.lasteditdate = lasteditdate;
		this.readcheckdate = readcheckdate;
	}

	public String getFk_wmno() {
		return fk_wmno;
	}

	public void setFk_wmno(String fk_wmno) {
		this.fk_wmno = fk_wmno;
	}

	public String getFk_wrno() {
		return fk_wrno;
	}

	public void setFk_wrno(String fk_wrno) {
		this.fk_wrno = fk_wrno;
	}

	public String getFk_mbr_seq() {
		return fk_mbr_seq;
	}

	public void setFk_mbr_seq(String fk_mbr_seq) {
		this.fk_mbr_seq = fk_mbr_seq;
	}

	public String getLasteditdate() {
		return lasteditdate;
	}

	public void setLasteditdate(String lasteditdate) {
		this.lasteditdate = lasteditdate;
	}

	public String getReadcheckdate() {
		return readcheckdate;
	}

	public void setReadcheckdate(String readcheckdate) {
		this.readcheckdate = readcheckdate;
	}

	public String getWorkmbr_seq() {
		return workmbr_seq;
	}


	public void setWorkmbr_seq(String workmbr_seq) {
		this.workmbr_seq = workmbr_seq;
	}


	public String getContents() {
		return contents;
	}


	public void setContents(String contents) {
		this.contents = contents;
	}


	public String getWorkPercent() {
		return workPercent;
	}


	public void setWorkPercent(String workPercent) {
		this.workPercent = workPercent;
	}

	// == 부모테이블 관련 함수 == //	
	public String getMbr_name() {
		return mbr_name;
	}


	public void setMbr_name(String mbr_name) {
		this.mbr_name = mbr_name;
	}

	
}
