package com.spring.groupware.insa.model;

public class EduVO {

	    private int edu_seq;
		private int mbr_seq;
		private int eduLevel;
		private String school;
		private String major;

		/////////////////////////////////////////////////////////////////////////////////////////////
		
		public EduVO() {}
		
		///////////////////////////////////////////////////////////////////////////////
	

		public int getEduLevel() {
			return eduLevel;
		}

		public void setEduLevel(int eduLevel) {
			this.eduLevel = eduLevel;
		}

		public String getSchool() {
			return school;
		}

		public void setSchool(String school) {
			this.school = school;
		}

		public String getMajor() {
			return major;
		}

		public void setMajor(String major) {
			this.major = major;
		}

		public int getMbr_seq() {
			return mbr_seq;
		}

		public void setMbr_seq(int mbr_seq) {
			this.mbr_seq = mbr_seq;
		}

		public int getEdu_seq() {
			return edu_seq;
		}

		public void setEdu_seq(int edu_seq) {
			this.edu_seq = edu_seq;
		}

		
}
