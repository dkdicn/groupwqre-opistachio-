package com.spring.groupware.sns.model;

public class TalkroomMbrVO {
	private int mbr_seq;
	private String fk_mbr_id;     
	private int fk_room_seq;
	
	
	public int getMbr_seq() {
		return mbr_seq;
	}
	public void setMbr_seq(int mbr_seq) {
		this.mbr_seq = mbr_seq;
	}
	public String getFk_mbr_id() {
		return fk_mbr_id;
	}
	public void setFk_mbr_id(String fk_mbr_id) {
		this.fk_mbr_id = fk_mbr_id;
	}
	public int getFk_room_seq() {
		return fk_room_seq;
	}
	public void setFk_room_seq(int fk_room_seq) {
		this.fk_room_seq = fk_room_seq;
	}  
	
	
}
