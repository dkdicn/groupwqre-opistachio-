package com.spring.groupware.schedule.model;

public class MtrHistoryVO {
	private String usemtrno; 	// 이용구분번호
	private String fk_mtrno; 	//회의실번호
	private String fk_scdno; 	// 일정번호
	private String booker;		// 예약자명
	private String mtrsubject;	// 회의 이용 목적/일정
	private String regDate;		// 이용 일자
	private String starttime; 	// 시작시간
	private String endtime; 	// 종료시간
	
	private String mtrname;		// 회의실명
	
	public MtrHistoryVO() {}

	public MtrHistoryVO(String usemtrno, String fk_mtrno, String fk_scdno, String booker, String regDate,
			String starttime,String endtime, String mtrsubject, String mtrname) {
		super();
		this.usemtrno = usemtrno;
		this.fk_mtrno = fk_mtrno;
		this.fk_scdno = fk_scdno;
		this.booker = booker;
		this.mtrsubject = mtrsubject;
		this.regDate = regDate;
		this.starttime = starttime;
		this.endtime = endtime;
		this.mtrname = mtrname;
	}


	public String getUsemtrno() {
		return usemtrno;
	}

	public void setUsemtrno(String usemtrno) {
		this.usemtrno = usemtrno;
	}

	public String getFk_mtrno() {
		return fk_mtrno;
	}

	public void setFk_mtrno(String fk_mtrno) {
		this.fk_mtrno = fk_mtrno;
	}

	public String getFk_scdno() {
		return fk_scdno;
	}

	public void setFk_scdno(String fk_scdno) {
		this.fk_scdno = fk_scdno;
	}

	public String getMtrsubject() {
		return mtrsubject;
	}

	public void setMtrsubject(String mtrsubject) {
		this.mtrsubject = mtrsubject;
	}

	public String getStarttime() {
		return starttime;
	}

	public void setStarttime(String starttime) {
		this.starttime = starttime;
	}

	public String getEndtime() {
		return endtime;
	}

	public void setEndtime(String endtime) {
		this.endtime = endtime;
	}

	public String getRegDate() {
		return regDate;
	}

	public void setRegDate(String regDate) {
		this.regDate = regDate;
	}

	public String getBooker() {
		return booker;
	}

	public void setBooker(String booker) {
		this.booker = booker;
	}

	public String getMtrname() {
		return mtrname;
	}

	public void setMtrname(String mtrname) {
		this.mtrname = mtrname;
	}
	
	
	
}
