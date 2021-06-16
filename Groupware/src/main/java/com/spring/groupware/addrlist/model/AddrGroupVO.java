package com.spring.groupware.addrlist.model;

public class AddrGroupVO {

	private int addrgroup_seq;
	private int fk_mbr_seq;
	private String groupname;
	private String groupdetail;
	
	
	public int getAddrgroup_seq() {
		return addrgroup_seq;
	}
	
	public void setAddrgroup_seq(int addrgroup_seq) {
		this.addrgroup_seq = addrgroup_seq;
	}
	
	public int getFk_mbr_seq() {
		return fk_mbr_seq;
	}

	public void setFk_mbr_seq(int fk_mbr_seq) {
		this.fk_mbr_seq = fk_mbr_seq;
	}

	public String getGroupname() {
		return groupname;
	}
	
	public void setGroupname(String groupname) {
		this.groupname = groupname;
	}
	
	public String getGroupdetail() {
		return groupdetail;
	}
	
	public void setGroupdetail(String groupdetail) {
		this.groupdetail = groupdetail;
	}
	
	
}
