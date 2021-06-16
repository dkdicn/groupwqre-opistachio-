package com.spring.groupware.board.model;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;

import org.mybatis.spring.SqlSessionTemplate;
// import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;
import org.springframework.stereotype.Repository;

//=== #32. DAO 선언 ===
@Component
@Repository
public class DnoticeDAO implements InterDnoticeDAO {	
	
	@Resource
	private SqlSessionTemplate sqlsession; // 로컬 DB에 연결

	@Resource
	private SqlSessionTemplate sqlsession2; // 원격 DB에 연결
	
	@Resource
	private SqlSessionTemplate sqlsession3; // 로컬 DB에 hr로 연결

	// === 글쓰기(파일첨부가 없는 글쓰기) === //
	@Override
	public int add(DnoticeVO dnoticevo) {
		int n = sqlsession.insert("board.deptAdd", dnoticevo);
		return n;
	}

	// === 페이징 처리를 안한 검색어가 없는 전체 글목록 보여주기 == //
	@Override
	public List<DnoticeVO> boardListNoSearch() {
		List<DnoticeVO> boardList = sqlsession.selectList("board.deptListNoSearch");
		return boardList;
	}

	// === 글 조회수 1 증가하기 === //
	@Override
	public void setAddReadCount(String dnotice_seq) {
		sqlsession.update("board.setDeptAddHit", dnotice_seq);
	}

	// === 글 1개 조회하기 === //
	@Override
	public DnoticeVO getView(String dnotice_seq) {
		DnoticeVO dnoticevo = sqlsession.selectOne("board.getDeptView", dnotice_seq);
		return dnoticevo;
	}

	// === 1개글 삭제하기 === //
	@Override
	public int del(Map<String, String> paraMap) {
		int n = sqlsession.delete("board.delDept",paraMap);		
		return n;
	}

	// === 1개글 수정하기 === //
	@Override
	public int edit(DnoticeVO dnoticevo) {
		int n = sqlsession.update("board.editDept",dnoticevo);		
		return n;
	}

	// === 총 게시물 수 === //
	@Override
	public int getTotalCount(Map<String, String> paraMap) {
		int n = sqlsession.selectOne("board.getDeptTotalCount", paraMap);
		return n;
	}

	// === 페이징 처리한 글 목록 === //
	@Override
	public List<DnoticeVO> boardListSearchWithPaging(Map<String, String> paraMap) {
		List<DnoticeVO> boardList = sqlsession.selectList("board.deptListSearchWithPaging", paraMap);		
		return boardList;
	}

	// === 글 검색 === //
	@Override
	public List<String> wordSearchShow(Map<String, String> paraMap) {
		List<String> boardList = sqlsession.selectList("board.deptWordSearchShow", paraMap);
		return boardList;
	}
}
