package com.spring.groupware.workmanage.model;

import org.springframework.web.multipart.MultipartFile;

public class WorkFileVO {

	private MultipartFile attach;
	// form 태그에서 type="file" 인 파일을 받아서 저장되는 필드. 진짜파일 ==> WAS(톰캣) 디스크에 저장됨.
	// jsp 파일에서 input type="file" 인 name 의 이름(attach)과 동일해야한다.
	
	private String fileno;
	private String fileName; // WAS(톰캣)에 저장될 파일명(2020120809271535243254235235234.png)
	private String orgFilename; // 진짜 파일명(강아지.png) // 사용자가 파일을 업로드 하거나 파일을 다운로드 할때 사용되어지는 파일명
	private String fileSize; // 파일크기

	private String fk_wmno; // 부모 번호 - 업무
	private String fk_tdno; // 부모 번호 - 할일
	
	// 첨부 파일 관련 ------------------------------

	public String getFileno() {
		return fileno;
	}

	public void setFileno(String fileno) {
		this.fileno = fileno;
	}
	
	public String getFk_wmno() {
		return fk_wmno;
	}

	public void setFk_wmno(String fk_wmno) {
		this.fk_wmno = fk_wmno;
	}

	public MultipartFile getAttach() {
		return attach;
	}

	public void setAttach(MultipartFile attach) {
		this.attach = attach;
	}

	public String getFileName() {
		return fileName;
	}

	public void setFileName(String fileName) {
		this.fileName = fileName;
	}

	public String getOrgFilename() {
		return orgFilename;
	}

	public void setOrgFilename(String orgFilename) {
		this.orgFilename = orgFilename;
	}

	public String getFileSize() {
		return fileSize;
	}

	public void setFileSize(String fileSize) {
		this.fileSize = fileSize;
	}

	public String getFk_tdno() {
		return fk_tdno;
	}

	public void setFk_tdno(String fk_tdno) {
		this.fk_tdno = fk_tdno;
	}

}
