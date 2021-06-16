package com.spring.groupware.schedule.model;

public class ScheduleVO {
	
	private String scdno; 			// 일정번호
	private String fk_scdno2; 		// 일정구분번호
	private String fk_mbr_seq; 		// 사원번호
	private String scdsubject;		// 일정제목
	private String scdstartdate;	// 일정시작일
	private String scdenddate;		// 일정종료일
	private String place;			// 장소
	private String attendance; 		// 참석자
	
	private String scdstartTm;		// 시작시간
	private String scdendTm;		// 종료시간
	
	public ScheduleVO() {}

	public ScheduleVO(String scdno, String fk_scdno2, String fk_mbr_seq, String scdsubject, String scdstartdate,
			String scdenddate, String attendance, String place) {
		super();
		this.scdno = scdno;
		this.fk_scdno2 = fk_scdno2;
		this.fk_mbr_seq = fk_mbr_seq;
		this.scdsubject = scdsubject;
		this.scdstartdate = scdstartdate;
		this.scdenddate = scdenddate;
		this.place = place;
		this.attendance = attendance;
	}

	public String getScdno() {
		return scdno;
	}

	public void setScdno(String scdno) {
		this.scdno = scdno;
	}

	public String getFk_scdno2() {
		return fk_scdno2;
	}

	public void setFk_scdno2(String fk_scdno2) {
		this.fk_scdno2 = fk_scdno2;
	}

	public String getFk_mbr_seq() {
		return fk_mbr_seq;
	}

	public void setFk_mbr_seq(String fk_mbr_seq) {
		this.fk_mbr_seq = fk_mbr_seq;
	}

	public String getScdsubject() {
		return scdsubject;
	}

	public void setScdsubject(String scdsubject) {
		this.scdsubject = scdsubject;
	}

	public String getScdstartdate() {
		return scdstartdate;
	}

	public void setScdstartdate(String scdstartdate) {
		this.scdstartdate = scdstartdate;
	}

	public String getScdenddate() {
		return scdenddate;
	}

	public void setScdenddate(String scdenddate) {
		this.scdenddate = scdenddate;
	}

	public String getAttendance() {
		return attendance;
	}

	public void setAttendance(String attendance) {
		this.attendance = attendance;
	}

	public String getScdstartTm() {
		return scdstartTm;
	}

	public void setScdstartTm(String scdstartTm) {
		this.scdstartTm = scdstartTm;
	}

	public String getScdendTm() {
		return scdendTm;
	}

	public void setScdendTm(String scdendTm) {
		this.scdendTm = scdendTm;
	}

	public String getPlace() {
		return place;
	}

	public void setPlace(String place) {
		this.place = place;
	}
	
	
}
