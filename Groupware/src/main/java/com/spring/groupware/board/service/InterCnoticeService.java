package com.spring.groupware.board.service;

import java.util.List;
import java.util.Map;

import com.spring.groupware.board.model.CnoticeVO;

public interface InterCnoticeService {

	// 글쓰기(파일첨부가 없는 글쓰기)
	int add(CnoticeVO cnoticevo);

	// == 페이징 처리를 안한 검색어가 없는 전체 글목록 보여주기 == //
	List<CnoticeVO> boardListSearch(Map<String, String> paraMap);

	// 글조회수 증가와 함께 글1개를 조회해주는 것
	CnoticeVO getView(String seq, String login_userid);

	// 글조회수 증가는 없고 단순히 글1개 조회만을 해주는 것이다.
	CnoticeVO getViewWithNoAddCount(String cnotice_seq);

	// 글 삭제
	int del(Map<String, String> paraMap);

	// 글 수정
	int edit(CnoticeVO cnoticevo);

	// 글 검색
	List<String> wordSearchShow(Map<String, String> paraMap);

	// 총 게시물 수
	int getTotalCount(Map<String, String> paraMap);

	// 페이징 처리한 글 목록
	List<CnoticeVO> boardListSearchWithPaging(Map<String, String> paraMap);

}
