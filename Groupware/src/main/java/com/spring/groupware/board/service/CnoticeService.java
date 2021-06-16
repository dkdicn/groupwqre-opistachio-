package com.spring.groupware.board.service;

import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;
import org.springframework.stereotype.Service;

import com.spring.groupware.board.model.CnoticeVO;
import com.spring.groupware.board.model.InterCnoticeDAO;

//=== Service 선언 === 
//트랜잭션 처리를 담당하는곳 , 업무를 처리하는 곳, 비지니스(Business)단
@Component
@Service
public class CnoticeService implements InterCnoticeService {

	@Autowired
	private InterCnoticeDAO cdao;

	// === 글쓰기(파일첨부가 없는 글쓰기) === //
	@Override
	public int add(CnoticeVO cnoticevo) {
		int n = cdao.add(cnoticevo);
		return n;
	}

	// == 전체 글목록 보여주기 == //
	@Override
	public List<CnoticeVO> boardListSearch(Map<String, String> paraMap) {
		List<CnoticeVO> boardList = cdao.boardListSearch(paraMap);
		return boardList;
	}
	
	// === 글조회수 증가와 함께 글1개를 조회해주는 것 === //
	@Override
	public CnoticeVO getView(String cnotice_seq, String login_userid) {
		
		CnoticeVO cnoticevo = cdao.getView(cnotice_seq); // 글1개 조회하기
		
		if(login_userid != null && cnoticevo != null && 
		   !login_userid.equals("admin") ) {// 관리자가 로그인하지 않았을 경우에는 조회수 증가
			
			cdao.setAddReadCount(cnotice_seq); // 글 조회수 1 증가하기	
			cnoticevo = cdao.getView(cnotice_seq);
		}
		
		return cnoticevo; 
	}

	// 글조회수 증가는 없고 단순히 글1개 조회만을 해주는 것
	@Override
	public CnoticeVO getViewWithNoAddCount(String cnotice_seq) {
		CnoticeVO cnoticevo = cdao.getView(cnotice_seq); // 글1개 조회하기
		return cnoticevo;
	}

	// === 1개글 삭제하기 === //
	@Override
	public int del(Map<String, String> paraMap) {
		int n = cdao.del(paraMap);
		return n;
	}

	// === 1개글 수정하기 === //
	@Override
	public int edit(CnoticeVO cnoticevo) {
		int n = cdao.edit(cnoticevo);
		return n;
	}

	// === 글 검색하기 === //
	@Override
	public List<String> wordSearchShow(Map<String, String> paraMap) {
		List<String> wordList = cdao.wordSearchShow(paraMap);
		return wordList;
	}

	// === 총 게시물 수 === //
	@Override
	public int getTotalCount(Map<String, String> paraMap) {
		int n = cdao.getTotalCount(paraMap);
		return n;
	}

	// === 페이징 처리한 글 목록 === //
	@Override
	public List<CnoticeVO> boardListSearchWithPaging(Map<String, String> paraMap) {
		List<CnoticeVO> boardList = cdao.boardListSearchWithPaging(paraMap);
	    return boardList;
	}
	
	
}
