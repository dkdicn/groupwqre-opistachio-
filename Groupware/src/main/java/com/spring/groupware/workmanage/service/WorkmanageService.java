package com.spring.groupware.workmanage.service;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.scheduling.annotation.Scheduled;
import org.springframework.stereotype.Component;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Isolation;
import org.springframework.transaction.annotation.Propagation;
import org.springframework.transaction.annotation.Transactional;

import com.spring.groupware.member.model.MemberVO;
import com.spring.groupware.workmanage.model.InterWorkmanageDAO;
import com.spring.groupware.workmanage.model.TodoVO;
import com.spring.groupware.workmanage.model.WorkFileVO;
import com.spring.groupware.workmanage.model.WorkMemberVO;
import com.spring.groupware.workmanage.model.WorkVO;

@Component
@Service
public class WorkmanageService implements InterWorkmanageService {

	@Autowired
	private InterWorkmanageDAO dao;
	
	// == 업무 등록 페이지에서 나의 할일 등록하기 (트랜잭션 처리)== // 
	@Override
	@Transactional(propagation=Propagation.REQUIRED, isolation=Isolation.READ_COMMITTED, rollbackFor= {Throwable.class})
	public int workAddTodoEnd(TodoVO tdvo, List<WorkFileVO> fileList) {
		// todo 테이블에 정보 insert
		int n = dao.workAddTodoEnd(tdvo); 
		int m = 0;
		
		// 첨부파일이 있을 때 첨부파일 테이블에 파일 insert
		if (n != 0 && fileList.get(0).getFileName() != null) {
			for (WorkFileVO filevo : fileList) {
				m = dao.workAddFile_todo(filevo);
				
				if (m == 0) break;
			}
		}
		return n;
	}

	// == 나의 할일 리스트 페이지 보여주기 (전체) == // 
	@Override
	public List<TodoVO> todoList(String fk_mbr_seq) {
		List<TodoVO> todoList = dao.todoList(fk_mbr_seq);
		return todoList;
	}

	// == 선택한 나의 할일 상세 보기 == // 
	@Override
	public TodoVO showDetailTodo(Map<String, String> paraMap) {
		TodoVO tdvo = dao.showDetailTodo(paraMap);
		return tdvo;
	}

	
	// == 업무(요청,보고) 등록하기 트랜잭션 처리  == //
	@Override
	@Transactional(propagation=Propagation.REQUIRED, isolation=Isolation.READ_COMMITTED, rollbackFor= {Throwable.class})
	public int workAddEnd(WorkVO workvo, List<WorkMemberVO> workmbrList, List<WorkFileVO> fileList) {
		int n = dao.workAddEnd(workvo); // 업무테이블에 업무 정보 insert 
		int m = 0, k = 1;
		
		// 업무관련 회원테이블에 정보 insert
		if (n == 1) {	 
			for (WorkMemberVO workmbr: workmbrList) {
				workmbr.setFk_wmno(workvo.getWmno());
				m = dao.workAddMember(workmbr);
				
				if (m == 0) break;
			}
			
			// 첨부파일이 있을 때 첨부파일 테이블에 파일 insert
			if (m != 0 && fileList.get(0).getFileName() != null) {
				for (WorkFileVO filevo : fileList) {
					k = dao.workAddFile(filevo);
					
					if (k == 0) break;
				}
			}
		}
		
		return n*m*k;
	}

	// == 업무 리스트(요청,보고) 보여주기 == // 
	@Override
	public List<WorkVO> workList(Map<String, String> paraMap) {
		List<WorkVO> workList = dao.workList(paraMap);
		return workList;
	}

	// == 참조 업무 리스트(요청,보고) 보여주기  == // 
	@Override
	public List<WorkVO> workListForRefer(Map<String, String> paraMap) {
		List<WorkVO> workList = dao.workListForRefer(paraMap);
		return workList;
	}

	// == 페이징 처리 - 총 게시물 건수 가져오기 == //
	@Override
	public int getTotalCount(Map<String, Object> paraMap) {
		int n = dao.getTotalCount(paraMap);
		return n;
	}

	// == 선택한 업무(요청,보고) 상세 보기  == //
	@Override
	@Transactional(propagation=Propagation.REQUIRED, isolation=Isolation.READ_COMMITTED, rollbackFor= {Throwable.class})
	public WorkVO showDetailWork(Map<String, String> paraMap) {
		WorkVO workvo = dao.showDetailWork(paraMap);
		
		// 수신함에 있는 업무를 클릭해서 보게될 경우 읽은 날짜로 업데이트 해주기 
		String fk_wrno = paraMap.get("fk_wrno");
		if ("2".equals(fk_wrno) || "3".equals(fk_wrno)) {
			dao.updateReadcheckdate(paraMap);
		}
		
		return workvo;
	}

	// 담당자, 참조자 지정하기 위한 우선멤버 가져오기
	@Override
	public List<MemberVO> memberSearchShow(Map<String, String> paraMap) {
		List<MemberVO> memberList = dao.memberSearchShow(paraMap);
		return memberList;
	}

	// 채번 해오기
	@Override
	public String getWorkno() {
		String wmno = dao.getWorkno();
		return wmno;
	}

	// 담당자들의 업무 정보 가져오기
	@Override
	public List<WorkMemberVO> getWorkStatusEachMember(String wmno) {
		List<WorkMemberVO> workmbrList = dao.getWorkStatusEachMember(wmno);
		return workmbrList;
	}

	// 업무 수정하기 및 수정일자 업데이트 하기
	@Override
	@Transactional(propagation=Propagation.REQUIRED, isolation=Isolation.READ_COMMITTED, rollbackFor= {Throwable.class})
	public int workEditEnd(WorkVO workvo, Map<String,String> paraMap, List<WorkFileVO> fileList) {
		int n = dao.workEditEnd(workvo);
		int m = 0, k = 1;
		
		if (n == 1) {
			m = dao.updateLasteditdate(paraMap);
			
			// 첨부파일이 있을 때 첨부파일 테이블에 파일 insert
			if (m != 0 && fileList.get(0).getFileName() != null) {
				for (WorkFileVO filevo : fileList) {
					k = dao.workAddFile(filevo);
					
					if (k == 0) break;
				}
			}
		}
		
		return n*m;
	}

	// 업무 삭제하기
	@Override
	public int workDel(Map<String, Object> paraMap) {
		int n = 0;
		
		if (paraMap.get("tdnoList") == null) { 	
			n = dao.workDel(paraMap); // 업무
		}
		else { 
			n = dao.todoDel(paraMap); // 할일
		}
		
		return n;
	}

	// 담당자 한명의 업무 정보 가져오기
	@Override
	public WorkMemberVO oneMbrWorkStatus(Map<String, String> paraMap) {
		WorkMemberVO workmbr = dao.oneMbrWorkStatus(paraMap);
		return workmbr;
	}

	// 페이징 처리한 글 목록 가져오기(검색이 있든지, 없든지 모두 다)
	@Override
	public List<WorkVO> workListSearchWithPaging(Map<String, Object> paraMap) {
		List<WorkVO> workList = dao.workListSearchWithPaging(paraMap);
		return workList;
	}

	// 업무완료 클릭시 선택한 업무의 상태 완료로 변경하기
	@Override
	public int workStatusChangeToComplete(Map<String, Object> paraMap) {
		int n = 0;
		
		if (paraMap.get("tdnoList") == null) { 	
			n = dao.workStatusChangeToComplete(paraMap); // 업무
		}
		else { 
			n = dao.workStatusChangeToComplete_todo(paraMap); // 할일
		}
		
		return n;
	}

	// 첨부파일 정보 가져오기
	@Override
	public List<WorkFileVO> getWorkFile(Map<String, String> paraMap) {
		String todoNo = paraMap.get("tdno");
		List<WorkFileVO> fileList;
		
		// todo 와 work 첨부파일 구분하기
		if (todoNo == null || "".equals(todoNo)) {
			fileList = dao.getWorkFile(paraMap);
		}
		else {
			fileList = dao.getWorkFile_todo(paraMap);
		}
		
		return fileList;
	}

	// 담당자들의 읽음확인 정보 가져오기
	@Override
	public List<WorkMemberVO> workmbrReadcheckdate(String wmno) {
		List<WorkMemberVO> workmbrList = dao.workmbrReadcheckdate(wmno);
		return workmbrList;
	}

	// 수신자 업무 처리내역 등록하기
	@Override
	public int receiverWorkAdd(WorkMemberVO workmbrvo) {
		int n = dao.receiverWorkAdd(workmbrvo);
		return n;
	}

	// 수신자 업무 처리내역 수정하기
	@Override
	public int receiverWorkEdit(WorkMemberVO workmbrvo) {
		int n = dao.receiverWorkEdit(workmbrvo);
		return n;
	}
	
	// 마감 지난 업무상태 변경하기
	@Override
	@Scheduled(cron="0 0 0 * * ?")
//	@Scheduled(cron="*/10 * * * * *") // 10초마다변경
	public void updateWorkStatusByTime() { // 스케줄러로 사용되어지는 메소드는 반드시 파라미터가 없어야 함

		dao.updateWorkStatusByTime(); // 마감 지난 업무상태 변경하기
		dao.updateWorkStatusByTime_todo(); // 마감 지난 업무상태 변경하기
	}

	// 사원 정보 가져오기
	@Override
	public List<MemberVO> getMemberList(Map<String, String> paraMap) {
		List<MemberVO> memberList = dao.getMemberList(paraMap);
		return memberList;
	}

	// 부서 정보 가져오기
	@Override
	public List<HashMap<String,String>> getDeptList() {
		List<HashMap<String,String>> deptList = dao.getDeptList();
		return deptList;
	}

	// 페이징 처리한 글 목록 가져오기(검색이 있든지, 없든지 모두 다) - todo 테이블
	@Override
	public List<TodoVO> todoListSearchWithPaging(Map<String, Object> paraMap) {
		List<TodoVO> todoList = dao.todoListSearchWithPaging(paraMap);
		return todoList;
	}

	// 할일 번호 채번하기
	@Override
	public String getTodono() {
		String tdno = dao.getTodono();
		return tdno;
	}

	// 할일 수정하기
	@Override
	public int todoEditEnd(TodoVO todovo, List<WorkFileVO> fileList) {
		int n = dao.todoEditEnd(todovo);
		int m = 1;
		
		if (n == 1) {
			// 첨부파일이 있을 때 첨부파일 테이블에 파일 insert
			if (fileList.get(0).getFileName() != null) {
				for (WorkFileVO filevo : fileList) {
					m = dao.workAddFile_todo(filevo);
					
					if (m == 0) break;
				}
			}
		}
		
		return n*m;
	}

	// 업무완료 클릭시 선택한 업무의 상태 완료로 변경하기
	@Override
	public int workPercentChangeToComplete(Map<String, Object> paraMap) {
		int n = dao.workPercentChangeToComplete(paraMap);
		return n;
	}

	// 일괄 읽음 처리하기
	@Override
	public int workReadCheckChangeToComplete(Map<String, Object> paraMap) {
		int n =  0;
		
		// 수신함에 있는 업무를 클릭해서 보게될 경우 읽은 날짜로 업데이트 해주기 
		String fk_wrno = (String) paraMap.get("fk_wrno");
		if ("2".equals(fk_wrno) || "3".equals(fk_wrno)) {
			n = dao.updateReadcheckdate_many(paraMap);
		}
		
		return n;
	}

	// 반려처리하기
	@Override
	public int workStatusChangeToBack(Map<String, Object> paraMap) {
		int n = dao.workStatusChangeToBack(paraMap);
		return n;
	}
}
