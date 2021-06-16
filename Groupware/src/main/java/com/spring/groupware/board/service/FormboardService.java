package com.spring.groupware.board.service;

import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;
import org.springframework.stereotype.Service;

import com.spring.groupware.board.model.FormboardVO;
import com.spring.groupware.board.model.InterFormboardDAO;
import com.spring.groupware.common.FileManager;


//=== Service 선언 === 
//트랜잭션 처리를 담당하는곳 , 업무를 처리하는 곳, 비지니스(Business)단
@Component
@Service
public class FormboardService implements InterFormboardService {

	@Autowired
	private InterFormboardDAO fdao;

	@Autowired    
    private FileManager fileManager;
	
	// === 글쓰기(파일첨부가 없는 글쓰기) === //
	@Override
	public int add(FormboardVO formboardvo) {
		int n = fdao.add(formboardvo);
		return n;
	}

	// == 페이징 처리를 안한 검색어가 없는 전체 글목록 보여주기 == //
	@Override
	public List<FormboardVO> boardListNoSearch() {
		List<FormboardVO> boardList = fdao.boardListNoSearch();
		return boardList;
	}

	// === 글조회수 증가와 함께 글1개를 조회해주는 것 === //
	@Override
	public FormboardVO getView(Map<String, String> paraMap, String login_userid) {
		
		FormboardVO formboardvo = fdao.getView(paraMap); // 글1개 조회하기
		
		if(login_userid != null && formboardvo != null && 
		   !login_userid.equals("admin") ) {// 관리자가 로그인하지 않았을 경우에는 조회수 증가
			
			fdao.setAddReadCount(formboardvo.getForm_seq()); // 글 조회수 1 증가하기	
			formboardvo = fdao.getView(paraMap);
		}
		
		return formboardvo; 
	}

	// 글조회수 증가는 없고 단순히 글1개 조회만을 해주는 것
	@Override
	public FormboardVO getViewWithNoAddCount(Map<String, String> paraMap) {
		FormboardVO formboardvo = fdao.getView(paraMap);
		return formboardvo;
	}

	// === 1개글 삭제하기 === //
	@Override
	public int del(Map<String, String> paraMap) {
		int n = fdao.del(paraMap);
		
		if(n==1) {
			String fileName = paraMap.get("fileName");
			String path = paraMap.get("path");
			
			if(fileName != null && !"".equals(fileName)) {
				try {
					fileManager.doFileDelete(fileName, path);
				} catch (Exception e) {
					e.printStackTrace();
				}
			}
		}
		
		return n;
	}

	// === 1개글 수정하기 === //
	@Override
	public int edit(FormboardVO formboardvo) {
		int n = fdao.edit(formboardvo);
		return n;
	}

	// === 글 검색하기 === //
	@Override
	public List<String> wordSearchShow(Map<String, String> paraMap) {
		List<String> wordList = fdao.wordSearchShow(paraMap);
		return wordList;
	}

	// === 총 게시물 수 === //
	@Override
	public int getTotalCount(Map<String, String> paraMap) {
		int n = fdao.getTotalCount(paraMap);
		return n;
	}
	
	// === 페이징 처리한 글 목록 === //
	@Override
	public List<FormboardVO> boardListSearchWithPaging(Map<String, String> paraMap) {
		List<FormboardVO> boardList = fdao.boardListSearchWithPaging(paraMap);
	    return boardList;
	}

	// === 파일첨부가 있는 글쓰기 === //
	@Override
	public int add_withFile(FormboardVO formboardvo) {
		int n = fdao.add_withFile(formboardvo);
		return n;
	}
	
}
