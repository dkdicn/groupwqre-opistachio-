package com.spring.groupware.board.model;

import java.util.List;
import java.util.Map;

public interface InterFormboardDAO {
	
	// 글쓰기(파일첨부가 없는 글쓰기)
	int add(FormboardVO formboardvo);

	// == 페이징 처리를 안한 검색어가 없는 전체 글목록 보여주기 == //
	List<FormboardVO> boardListNoSearch();

	// 글 조회수 1 증가하기
	void setAddReadCount(String form_seq);

	// 글 1개 조회하기
	FormboardVO getView(Map<String, String> paraMap);

	// 1개글 삭제하기
	int del(Map<String, String> paraMap);

	// 1개글 수정하기
	int edit(FormboardVO formboardvo);

	// 글 검색
	List<String> wordSearchShow(Map<String, String> paraMap);

	// 총 게시물 수 
	int getTotalCount(Map<String, String> paraMap);

	// 페이징 처리한 글 목록
	List<FormboardVO> boardListSearchWithPaging(Map<String, String> paraMap);

	// 파일첨부가 있는 글쓰기
	int add_withFile(FormboardVO formboardvo);
	
}
