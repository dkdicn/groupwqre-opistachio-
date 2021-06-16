package com.spring.groupware.board.service;

import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;
import org.springframework.stereotype.Service;

import com.spring.groupware.board.model.DnoticeVO;
import com.spring.groupware.board.model.InterDnoticeDAO;


//=== Service 선언 === 
//트랜잭션 처리를 담당하는곳 , 업무를 처리하는 곳, 비지니스(Business)단
@Component
@Service
public class DnoticeService implements InterDnoticeService {

	@Autowired
	private InterDnoticeDAO ddao;

	// === 글쓰기(파일첨부가 없는 글쓰기) === //
	@Override
	public int add(DnoticeVO dnoticevo) {
		int n = ddao.add(dnoticevo);
		return n;
	}

	// == 페이징 처리를 안한 검색어가 없는 전체 글목록 보여주기 == //
	@Override
	public List<DnoticeVO> boardListNoSearch() {
		List<DnoticeVO> boardList = ddao.boardListNoSearch();
		return boardList;
	}

	// === 글조회수 증가와 함께 글1개를 조회해주는 것 === //
	@Override
	public DnoticeVO getView(String dnotice_seq, String login_userid) {
		
		DnoticeVO dnoticevo = ddao.getView(dnotice_seq); // 글1개 조회하기
		
		if(login_userid != null && dnoticevo != null && 
		   !login_userid.equals("admin") ) {// 관리자가 로그인하지 않았을 경우에는 조회수 증가
			
			ddao.setAddReadCount(dnotice_seq); // 글 조회수 1 증가하기	
			dnoticevo = ddao.getView(dnotice_seq);
		}
		
		return dnoticevo; 
	}

	// 글조회수 증가는 없고 단순히 글1개 조회만을 해주는 것
	@Override
	public DnoticeVO getViewWithNoAddCount(String dnotice_seq) {
		DnoticeVO dnoticevo = ddao.getView(dnotice_seq); // 글1개 조회하기
		return dnoticevo;
	}

	// === 1개글 삭제하기 === //
	@Override
	public int del(Map<String, String> paraMap) {
		int n = ddao.del(paraMap);
		return n;
	}

	// === 1개글 수정하기 === //
	@Override
	public int edit(DnoticeVO dnoticevo) {
		int n = ddao.edit(dnoticevo);
		return n;
	}

	// === 총 게시물 수 === //
	@Override
	public int getTotalCount(Map<String, String> paraMap) {
		int n = ddao.getTotalCount(paraMap);
		return n;
	}

	// === 페이징 처리한 글 목록 === //
	@Override
	public List<DnoticeVO> boardListSearchWithPaging(Map<String, String> paraMap) {
		List<DnoticeVO> boardList = ddao.boardListSearchWithPaging(paraMap);
	    return boardList;
	}

	// === 글 검색 === //
	@Override
	public List<String> wordSearchShow(Map<String, String> paraMap) {
		List<String> wordList = ddao.wordSearchShow(paraMap);
		return wordList;
	}
	
}
