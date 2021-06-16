package com.spring.groupware.board.service;

import java.util.List;
import java.util.Map;

import com.spring.groupware.board.model.DnoticeVO;

public interface InterDnoticeService {

	// 글쓰기(파일첨부가 없는 글쓰기)
	int add(DnoticeVO dnoticevo);

	// == 페이징 처리를 안한 검색어가 없는 전체 글목록 보여주기 == //
	List<DnoticeVO> boardListNoSearch();

	// 글조회수 증가와 함께 글1개를 조회해주는 것
	DnoticeVO getView(String dnotice_seq, String login_userid);

	// 글조회수 증가는 없고 단순히 글1개 조회만을 해주는 것이다.
	DnoticeVO getViewWithNoAddCount(String dnotice_seq);

	// 글 삭제
	int del(Map<String, String> paraMap);

	// 글 수정
	int edit(DnoticeVO dnoticevo);

	// 총 게시물 수
	int getTotalCount(Map<String, String> paraMap);

	// 페이징 처리한 글 목록
	List<DnoticeVO> boardListSearchWithPaging(Map<String, String> paraMap);

	// 글 검색
	List<String> wordSearchShow(Map<String, String> paraMap); 
}
