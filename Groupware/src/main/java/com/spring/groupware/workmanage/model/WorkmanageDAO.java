package com.spring.groupware.workmanage.model;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;
import org.springframework.stereotype.Repository;

import com.spring.groupware.member.model.MemberVO;

@Component
@Repository
public class WorkmanageDAO implements InterWorkmanageDAO {

	@Resource
	private SqlSessionTemplate sqlsession;
	
	// == 업무 등록 페이지에서 나의 할일 등록하기 == // 
	@Override
	public int workAddTodoEnd(TodoVO tdvo) {
		int n = sqlsession.insert("workmanage.workAddTodoEnd", tdvo);
		return n;
	}
	
	// == 나의 할일 리스트 페이지 보여주기 (전체) == // 
	@Override
	public List<TodoVO> todoList(String fk_mbr_seq) {
		List<TodoVO> todoList = sqlsession.selectList("workmanage.todoList", fk_mbr_seq);
		return todoList;
	}

	// == 선택한 나의 할일 상세 보기 == // 
	@Override
	public TodoVO showDetailTodo(Map<String, String> paraMap) {
		TodoVO tdvo = sqlsession.selectOne("workmanage.showDetailTodo", paraMap);
		return tdvo;
	}

	// == 업무(요청,보고) 등록하기 == //   
	@Override
	public int workAddEnd(WorkVO workvo) {
		int n = sqlsession.insert("workmanage.workAddEnd", workvo);
		return n;
	}

	// == 업무(요청,보고) 리스트 조회하기 == //  
	@Override
	public List<WorkVO> workList(Map<String, String> paraMap) {
		List<WorkVO> workList = sqlsession.selectList("workmanage.workList", paraMap);
		return workList;
	}

	// == 참조 업무 리스트(요청,보고) 보여주기  == //
	@Override
	public List<WorkVO> workListForRefer(Map<String, String> paraMap) {
		List<WorkVO> workList = sqlsession.selectList("workmanage.workListForRefer", paraMap);
		return workList;
	}

	// == 페이징 처리 - 총 게시물 건수 가져오기 == //
	@Override
	public int getTotalCount(Map<String, Object> paraMap) {
		int n = 0;
		
		if (paraMap.get("todo") != null) {
			n = sqlsession.selectOne("workmanage.getTotalCount_todo", paraMap);
		}
		else {
			n = sqlsession.selectOne("workmanage.getTotalCount", paraMap);
		}
		return n;
	}

	// == 선택한 업무(요청,보고) 상세 보기 == // 
	@Override
	public WorkVO showDetailWork(Map<String, String> paraMap) {
		WorkVO workvo = sqlsession.selectOne("workmanage.showDetailWork", paraMap);  
		return workvo;
	}

	// 담당자, 참조자 지정하기 위한 우선멤버 가져오기
	@Override
	public List<MemberVO> memberSearchShow(Map<String, String> paraMap) {
		List<MemberVO> memberList = sqlsession.selectList("workmanage.memberSearchShow", paraMap);
		return memberList;
	}

	// 업무번호 채번해오기
	@Override
	public String getWorkno() {
		String wmno = sqlsession.selectOne("workmanage.getWorkno");
		return wmno;
	}

	// 업무에 해당하는 멤버 seq저장
	@Override
	public int workAddMember(WorkMemberVO workmbr) {
		int n = sqlsession.insert("workmanage.workAddMember", workmbr);
		return n;
	}

	// 마감일자지난 업무상태 변경
	@Override
	public int updateWorkStatusByTime() {
		int n = sqlsession.update("workmanage.updateWorkStatusByTime");
		return n;
	}

	// 담당자들의 업무 정보 가져오기
	@Override
	public List<WorkMemberVO> getWorkStatusEachMember(String wmno) {
		List<WorkMemberVO> workmbrList = sqlsession.selectList("workmanage.getWorkStatusEachMember", wmno);
		return workmbrList;
	}

	// 업무 수정하기
	@Override
	public int workEditEnd(WorkVO workvo) {
		int n = sqlsession.update("workmanage.workEditEnd", workvo);
		return n;
	}

	// 업무 삭제하기
	@Override
	public int workDel(Map<String, Object> paraMap) {
		int n = sqlsession.update("workmanage.workDel", paraMap);
		return n;
	}

	// 담당자 한명의 업무 정보 가져오기
	@Override
	public WorkMemberVO oneMbrWorkStatus(Map<String, String> paraMap) {
		WorkMemberVO workmbr = sqlsession.selectOne("workmanage.oneMbrWorkStatus", paraMap);
		return workmbr;
	}

	// 담당자, 참조자 지정하기 위한 우선멤버 가져오기
	@Override
	public List<WorkVO> workListSearchWithPaging(Map<String, Object> paraMap) {
		List<WorkVO> workList = sqlsession.selectList("workmanage.workListSearchWithPaging", paraMap);
		return workList;
	}

	// 업무 첨부 파일 등록
	@Override
	public int workAddFile(WorkFileVO filevo) {
		int n = sqlsession.insert("workmanage.workAddFile", filevo);
		return n;
	}

	// 수신자가 읽었을 때 읽음확인 업데이트 하기 
	@Override
	public int updateReadcheckdate(Map<String, String> paraMap) {
		int n = sqlsession.update("workmanage.updateReadcheckdate", paraMap);
		return n;
	}

	// 수정일자 업데이트 하기
	@Override
	public int updateLasteditdate(Map<String, String> paraMap) {
		int n = sqlsession.update("workmanage.updateLasteditdate", paraMap);
		return n;
	}

	// 업무완료 클릭시 선택한 업무의 상태 완료로 변경하기
	@Override
	public int workStatusChangeToComplete(Map<String, Object> paraMap) {
		int n = sqlsession.update("workmanage.workStatusChangeToComplete", paraMap);
		return n;
	}

	// 첨부파일 정보 가져오기
	@Override
	public List<WorkFileVO> getWorkFile(Map<String, String> paraMap) {
		List<WorkFileVO> fileList = sqlsession.selectList("workmanage.getWorkFile", paraMap);
		return fileList;
	}

	// 담당자들의 읽음확인 정보 가져오기
	@Override
	public List<WorkMemberVO> workmbrReadcheckdate(String wmno) {
		List<WorkMemberVO> workmbrList = sqlsession.selectList("workmanage.workmbrReadcheckdate", wmno);
		return workmbrList;
	}

	// 수신자 업무 처리내역 등록하기
	@Override
	public int receiverWorkAdd(WorkMemberVO workmbrvo) {
		int n = sqlsession.insert("workmanage.receiverWorkAdd", workmbrvo);
		return n;
	}

	// 수신자 업무 처리내역 수정하기
	@Override
	public int receiverWorkEdit(WorkMemberVO workmbrvo) {
		int n = sqlsession.insert("workmanage.receiverWorkEdit", workmbrvo);
		return n;
	}

	// 사원 정보 가져오기
	@Override
	public List<MemberVO> getMemberList(Map<String, String> paraMap) {
		List<MemberVO> memberList = sqlsession.selectList("workmanage.getMemberList", paraMap);
		return memberList;
	}
	
	// 부서 정보 가져오기
	@Override
	public List<HashMap<String, String>> getDeptList() {
		List<HashMap<String, String>> deptList = sqlsession.selectList("workmanage.getDeptList");
		return deptList;
	}

	// 페이징 처리한 글 목록 가져오기(검색이 있든지, 없든지 모두 다) - todo 테이블
	@Override
	public List<TodoVO> todoListSearchWithPaging(Map<String, Object> paraMap) {
		List<TodoVO> todoList = sqlsession.selectList("workmanage.todoListSearchWithPaging", paraMap);
		return todoList;
	}

	// 마감일자지난 todo 업무상태 변경
	@Override
	public int updateWorkStatusByTime_todo() {
		int n = sqlsession.update("workmanage.updateWorkStatusByTime_todo");
		return n;
	}

	// 첨부파일 정보 가져오기 - todo
	@Override
	public List<WorkFileVO> getWorkFile_todo(Map<String, String> paraMap) {
		List<WorkFileVO> fileList = sqlsession.selectList("workmanage.getWorkFile_todo", paraMap);
		return fileList;
	}

	// 첨부파일 등록하기 - todo
	@Override
	public int workAddFile_todo(WorkFileVO filevo) {
		int n = sqlsession.insert("workmanage.workAddFile_todo", filevo);
		return n;
	}

	// 할일 번호 채번하기
	@Override
	public String getTodono() {
		String tdno = sqlsession.selectOne("workmanage.getTodono");
		return tdno;
	}

	// 할일완료 클릭시 선택한 할일의 상태를 완료로 변경하기
	@Override
	public int workStatusChangeToComplete_todo(Map<String, Object> paraMap) {
		int n = sqlsession.update("workmanage.workStatusChangeToComplete_todo", paraMap);
		return n;
	}

	// 할일 삭제하기
	@Override
	public int todoDel(Map<String, Object> paraMap) {
		int n = sqlsession.update("workmanage.todoDel", paraMap);
		return n;
	}

	// 할일 수정하기
	@Override
	public int todoEditEnd(TodoVO todovo) {
		int n = sqlsession.update("workmanage.todoEditEnd", todovo);
		return n;
	}

	// 업무완료 클릭시 선택한 업무의 상태 완료로 변경하기
	@Override
	public int workPercentChangeToComplete(Map<String, Object> paraMap) {
		int n = sqlsession.update("workmanage.workPercentChangeToComplete", paraMap);
		return n;
	}

	// 일괄 읽음 처리하기
	@Override
	public int updateReadcheckdate_many(Map<String, Object> paraMap) {
		int n = sqlsession.update("workmanage.updateReadcheckdate_many", paraMap);
		return n;
	}

	// 반려처리하기
	@Override
	public int workStatusChangeToBack(Map<String, Object> paraMap) {
		int n = sqlsession.update("workmanage.workStatusChangeToBack", paraMap);
		return n;
	}
	

}
