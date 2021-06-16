package com.spring.groupware.insa.model;

public class CertiVO {

		/////////////////////////////////////////////////////////////////////////////////////////////

	    private int certi_seq;
		private int mbr_seq;
		private String certification;
		private String certiLevel;
		private String certiDate;


		/////////////////////////////////////////////////////////////////////////////////////////////
		

		public CertiVO() {}


		public String getCertification() {
			return certification;
		}


		public void setCertification(String certification) {
			this.certification = certification;
		}


		public String getCertiLevel() {
			return certiLevel;
		}


		public void setCertiLevel(String certiLevel) {
			this.certiLevel = certiLevel;
		}


		public String getCertiDate() {
			return certiDate;
		}


		public void setCertiDate(String certiDate) {
			this.certiDate = certiDate;
		}


		public int getMbr_seq() {
			return mbr_seq;
		}


		public void setMbr_seq(int mbr_seq) {
			this.mbr_seq = mbr_seq;
		}


		public int getCerti_seq() {
			return certi_seq;
		}


		public void setCerti_seq(int certi_seq) {
			this.certi_seq = certi_seq;
		}
		
		

		
}
