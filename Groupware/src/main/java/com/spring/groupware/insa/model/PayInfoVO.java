package com.spring.groupware.insa.model;

public class PayInfoVO {

	private int mbr_seq;
	private String idNo;
	private String bank;
	private String accountNo;
	private int BASEPAY;
	private int SPEPAY;
	private String mbr_name;
	
	
	public int getMbr_seq() {
		return mbr_seq;
	}
	public void setMbr_seq(int mbr_seq) {
		this.mbr_seq = mbr_seq;
	}
	public String getIdNo() {
		return idNo;
	}
	public void setIdNo(String idNo) {
		this.idNo = idNo;
	}
	public String getBank() {
		return bank;
	}
	public void setBank(String bank) {
		this.bank = bank;
	}
	public String getAccountNo() {
		return accountNo;
	}
	public void setAccountNo(String accountNo) {
		this.accountNo = accountNo;
	}
	public int getBASEPAY() {
		return BASEPAY;
	}
	public void setBASEPAY(int bASEPAY) {
		BASEPAY = bASEPAY;
	}
	public int getSPEPAY() {
		return SPEPAY;
	}
	public void setSPEPAY(int sPEPAY) {
		SPEPAY = sPEPAY;
	}
	public String getMbr_name() {
		return mbr_name;
	}
	public void setMbr_name(String mbr_name) {
		this.mbr_name = mbr_name;
	}
	
	
	
	
}
