package com.spring.groupware.member.model;

public class CompanyVO {
	
	private String com_name;             // 회사이름
	private String com_address;          // 회사주소
	private String registraion_num;      // 사업자등록번호
	private String business_type;        // 업태/업종
	private String com_ph;               // 회사전화번호
	private String com_email;            // 회사이메일
	
	
	
	public String getCom_name() {
		return com_name;
	}
	public void setCom_name(String com_name) {
		this.com_name = com_name;
	}
	public String getCom_address() {
		return com_address;
	}
	public void setCom_address(String com_address) {
		this.com_address = com_address;
	}
	public String getRegistraion_num() {
		return registraion_num;
	}
	public void setRegistraion_num(String registraion_num) {
		this.registraion_num = registraion_num;
	}
	public String getBusiness_type() {
		return business_type;
	}
	public void setBusiness_type(String business_type) {
		this.business_type = business_type;
	}
	public String getCom_ph() {
		return com_ph;
	}
	public void setCom_ph(String com_ph) {
		this.com_ph = com_ph;
	}
	public String getCom_email() {
		return com_email;
	}
	public void setCom_email(String com_email) {
		this.com_email = com_email;
	}

}