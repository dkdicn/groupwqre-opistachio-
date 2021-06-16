package com.spring.groupware.workmanage.controller;

import java.io.File;
import java.io.IOException;
import java.io.PrintWriter;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.apache.commons.collections4.map.HashedMap;
import org.json.JSONArray;
import org.json.JSONObject;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.multipart.MultipartHttpServletRequest;
import org.springframework.web.servlet.ModelAndView;

import com.spring.groupware.addrlist.model.AddrVO;
import com.spring.groupware.common.*;
import com.spring.groupware.member.model.MemberVO;
import com.spring.groupware.schedule.service.InterScheduleService;
import com.spring.groupware.workmanage.model.TodoVO;
import com.spring.groupware.workmanage.model.WorkFileVO;
import com.spring.groupware.workmanage.model.WorkMemberVO;
import com.spring.groupware.workmanage.model.WorkVO;
import com.spring.groupware.workmanage.service.InterWorkmanageService;

@Component
@Controller
public class WorkmanageController {

	@Autowired // type에 따라 자동 객체 삽입
	private InterWorkmanageService service;
	
	
	@Autowired     // Type에 따라 알아서 Bean 을 주입해준다.
	private FileManager fileManager;


	// == 업무 등록 페이지 보여주기 (할일, 요청, 보고 등록) == //
	@RequestMapping(value = "/workAdd.opis")
	public ModelAndView requiredLogin_workAdd(HttpServletRequest request, HttpServletResponse response,
			ModelAndView mav) {

		// 사이드 바가 아닌 업무리스트 페이지에서 업무 등록을 눌렀을 때 해당 타입을 전달한다.
		mav.addObject("fk_wtno", request.getParameter("fk_wtno"));

		mav.setViewName("workmanage/workAdd.tiles1");
		return mav;
	}

	// === 검색어 입력시 자동글 완성하기  === //
	@ResponseBody
	@RequestMapping(value = "/memberSearchShow.opis", method = {RequestMethod.GET }, produces = "text/plain;charset=UTF-8")
	public String memberSearchShow(HttpServletRequest request) {

		String searchWord = request.getParameter("searchWord");

		Map<String, String> paraMap = new HashMap<>();
		paraMap.put("searchWord", searchWord);

		// 담당자, 참조자 지정하기 위한 우선멤버 가져오기
		List<MemberVO> memberList = service.memberSearchShow(paraMap);

		JSONArray jsonArr = new JSONArray(); // []

		if (memberList != null) {
			for (MemberVO member : memberList) {
				JSONObject jsonObj = new JSONObject(); // {}
				jsonObj.put("seq", member.getMbr_seq());
				jsonObj.put("word", member.getMbr_name());

				jsonArr.put(jsonObj);
			}
		}

		return jsonArr.toString();
		// "[]" 또는
		// "[{"word":"글쓰기 java 연습입니다"},{"word":"글쓰기 두번째 JaVa 연습입니다"}]"
	}

	// == 업무 등록 중 나의 할일 등록하기 == //
	@RequestMapping(value = "/workAddTodoEnd.opis", method = { RequestMethod.POST })
	public ModelAndView workAddTodoEnd(ModelAndView mav, TodoVO tdvo, MultipartHttpServletRequest mrequest) {
		
		String tdno = service.getTodono();
		tdvo.setTdno(tdno);
		
		// 첨부파일이 있을 경우 첨부파일 테이블에 넣어줄 것들
		List<MultipartFile> attachList = mrequest.getFiles("attach");
		List<WorkFileVO> fileList = null;
		
		if (attachList.size() > 0) {
			fileList = new ArrayList<>();
			
			for (MultipartFile attach : attachList) {
				WorkFileVO filevo = new WorkFileVO();
				
				filevo.setFk_tdno(tdno);
				filevo.setAttach(attach);
				
				// WAS의 webapp 의 절대경로 알아오기
				HttpSession session = mrequest.getSession();
				String root = session.getServletContext().getRealPath("/");
				String path = root+"resources"+File.separator+"files"; // File.separator 는 운영체제에서 사용하는 폴더와 파일의 구분자
				
				String newFileName = ""; // WAS(톰캣)의 디스크에 저장될 파일명 
				byte[] bytes = null; // 첨부파일의 내용을 담는 것
				long fileSize = 0; // 첨부파일의 크기
				
				try {
					bytes = attach.getBytes(); // 첨부파일의 내용물을 읽기
					String originalFilename = attach.getOriginalFilename(); // originalFilename ==> "강아지.png"
					
					newFileName = fileManager.doFileUpload(bytes, originalFilename, path);
					
					filevo.setFileName(newFileName);	
					// WAS(톰캣)에 저장될 파일명(20210603123943385139567592900.png)
					
					filevo.setOrgFilename(originalFilename);
					// 게시판 페이지에서 첨부된 파일(강아지.png)을 보여줄 때 사용.
		            // 또한 사용자가 파일을 다운로드 할때 사용되어지는 파일명으로 사용.
					
					fileSize = attach.getSize(); // 첨부파일의 크기(단위는 byte)
					filevo.setFileSize(String.valueOf(fileSize));
					
					fileList.add(filevo);
					
				} catch (Exception e) {
					e.printStackTrace();
				}
			}
		}
		
		
		int n = service.workAddTodoEnd(tdvo, fileList);

		if (n == 1) {
			mav.setViewName("redirect:/workList.opis");
		} else {
			String message = "일정 등록에 실패하였습니다. 다시 시도하세요";
			String loc = "javascript:history.back()";

			mav.addObject("message", message);
			mav.addObject("loc", loc);

			mav.setViewName("msg");
		}

		return mav;
	}

	// == 나의 할 일 리스트 보여주기 (전체) == //
	@RequestMapping(value = "/todoList.opis")
	public ModelAndView todoList(HttpServletRequest request, HttpServletResponse response,
			ModelAndView mav) {

		HttpSession session = request.getSession();
		
		try {
			MemberVO loginuser = (MemberVO) session.getAttribute("loginuser");

			// 현재 로그인 되어있는 멤버의 seq를 통해 해당 멤버의 할일 리스트 가져온다.
			String fk_mbr_seq = String.valueOf(loginuser.getMbr_seq());
			List<TodoVO> todoList = service.todoList(fk_mbr_seq);
			mav.addObject("todoList", todoList);

		} catch (Exception e) {

		}

		mav.setViewName("workmanage/todoList.tiles1");
		return mav;
	}

	// == 나의 할 일 상세 조회 페이지 == //
	@RequestMapping(value = "/showDetailTodo.opis")
	public ModelAndView requiredLogin_showDetailTodo(HttpServletRequest request, HttpServletResponse response,
			ModelAndView mav) {

		// tbl_todolist 테이블에서 업무고유 번호에 해당하는 값 가져오기
		String tdno = request.getParameter("tdno");
		String fk_mbr_seq = request.getParameter("mbr_seq");
		String gobackURL = request.getParameter("gobackURL");

		Map<String, String> paraMap = new HashedMap<>();
		paraMap.put("tdno", tdno);
		paraMap.put("fk_mbr_seq", fk_mbr_seq);
		paraMap.put("gobackURL", gobackURL);
		mav.addObject("paraMap", paraMap);

		// 선택한 나의할일 정보 가져오기
		TodoVO tdvo = service.showDetailTodo(paraMap);
		mav.addObject("tdvo", tdvo);
		
		// 첨부파일 정보 가져오기
		List<WorkFileVO> fileList = service.getWorkFile(paraMap);
		mav.addObject("fileList", fileList);
		
		// 업무처리에서 해당 페이지로 다시 돌아오기 위해
		String gobackWorkDetilURL = MyUtil.getCurrentURL(request);
		mav.addObject("gobackWorkDetilURL", gobackWorkDetilURL);

		mav.setViewName("workmanage/showDetailTodo.tiles1");
		return mav;
	}

	// ㄴ 할일 작업
	///////////////////////////////////////////////////////////////////////////////
	// 업무 작업 ㄱ

	// == 업무(요청,보고) 등록하기 == //
	@RequestMapping(value = "/workAddEnd.opis", method = { RequestMethod.POST })
	public ModelAndView workAddEnd(ModelAndView mav, WorkVO workvo, MultipartHttpServletRequest mrequest) {

		String wmno = service.getWorkno(); // 채번해오기
		workvo.setWmno(wmno);
		
		// 첨부파일이 있을 경우 첨부파일 테이블에 넣어줄 것들
		List<MultipartFile> attachList = mrequest.getFiles("attach");
		List<WorkFileVO> fileList = null;
		
		if (attachList.size() > 0) {
			fileList = new ArrayList<>();
			
			for (MultipartFile attach : attachList) {
				WorkFileVO filevo = new WorkFileVO();
				
				filevo.setFk_wmno(wmno);
				filevo.setAttach(attach);
				
				// WAS의 webapp 의 절대경로 알아오기
				HttpSession session = mrequest.getSession();
				String root = session.getServletContext().getRealPath("/");
				String path = root+"resources"+File.separator+"files"; // File.separator 는 운영체제에서 사용하는 폴더와 파일의 구분자
				
				String newFileName = ""; // WAS(톰캣)의 디스크에 저장될 파일명 
				byte[] bytes = null; // 첨부파일의 내용을 담는 것
				long fileSize = 0; // 첨부파일의 크기
				
				try {
					bytes = attach.getBytes(); // 첨부파일의 내용물을 읽기
					String originalFilename = attach.getOriginalFilename(); // originalFilename ==> "강아지.png"
					
					newFileName = fileManager.doFileUpload(bytes, originalFilename, path);
					
					filevo.setFileName(newFileName);	
					// WAS(톰캣)에 저장될 파일명(20210603123943385139567592900.png)
					
					filevo.setOrgFilename(originalFilename);
					// 게시판 페이지에서 첨부된 파일(강아지.png)을 보여줄 때 사용.
		            // 또한 사용자가 파일을 다운로드 할때 사용되어지는 파일명으로 사용.
					
					fileSize = attach.getSize(); // 첨부파일의 크기(단위는 byte임)
					filevo.setFileSize(String.valueOf(fileSize));
					
					fileList.add(filevo);
					
				} catch (Exception e) {
					e.printStackTrace();
				}
			}
		}
		

		// 업무관리자 테이블에 넣어줄 것
		List<WorkMemberVO> workmbrList = new ArrayList<>();
		String requesterSeq = mrequest.getParameter("requesterSeq");
		String receiverSeqs = mrequest.getParameter("receiverSeqs");
		String referrerSeqs = mrequest.getParameter("referrerSeqs");

		// 요청자 정보 (requester)
		WorkMemberVO mbr = new WorkMemberVO();
		mbr.setFk_wrno("1");
		mbr.setFk_mbr_seq(requesterSeq);
		workmbrList.add(mbr);

		// 수신자 정보 (receivers)
		String[] mbrSeqList = receiverSeqs.split(",");
		for (String mbrSeq : mbrSeqList) {
			mbr = new WorkMemberVO();
			mbr.setFk_wrno("2");
			mbr.setFk_mbr_seq(mbrSeq);
			workmbrList.add(mbr);
		}

		// 참조자 정보 (referrers)
		if (!"".equals(referrerSeqs)) {
			mbrSeqList = referrerSeqs.split(",");
			for (String mbrSeq : mbrSeqList) {
				mbr = new WorkMemberVO();
				mbr.setFk_wrno("3");
				mbr.setFk_mbr_seq(mbrSeq);
				workmbrList.add(mbr);
			}
		}

//		System.out.println("getWmno() => "+workvo.getWmno());
//		System.out.println("getFk_wtno() => "+workvo.getFk_wtno());
//		System.out.println("getRequester() => "+workvo.getRequester());
//		System.out.println("getReceivers() => "+workvo.getReceivers());
//		System.out.println("getReferrers() => "+workvo.getReferrers());
//		System.out.println("getSubject() => "+workvo.getSubject());
//		System.out.println("getContents() => "+workvo.getContents());
//		System.out.println("getDeadline() => "+workvo.getDeadline());
		
		
		int n = service.workAddEnd(workvo, workmbrList, fileList); // 업무테이블에 삽입

		if (n == 1) {
			String fk_wrno = mrequest.getParameter("fk_wrno");
			mav.setViewName("redirect:/workList.opis?fk_wtno=" + workvo.getFk_wtno() + "&fk_wrno=" + fk_wrno);
		} else {
			String message = "업무 등록에 실패하였습니다. 다시 시도하세요";
			String loc = "javascript:history.back()";

			mav.addObject("message", message);
			mav.addObject("loc", loc);

			mav.setViewName("msg");
		}

		return mav;
	}

	// == 업무 리스트 보여주기 == //
	@RequestMapping(value = "/workList.opis")
	public ModelAndView requiredLogin_workList(HttpServletRequest request, HttpServletResponse response,
			ModelAndView mav) {
		
		// 사용자가 선택한 업무와 역할
		String fk_wtno = request.getParameter("fk_wtno");
		String fk_wrno = request.getParameter("fk_wrno");
		
		// 검색어 및 현재 페이지 번호
		String searchType = request.getParameter("searchType");
		String searchWord = request.getParameter("searchWord");
		String str_sizePerPage = request.getParameter("sizePerPage");
		String str_currentShowPageNo = request.getParameter("currentShowPageNo");
		String str_workStatus = request.getParameter("workStatus");
		String registerday = request.getParameter("registerday");
		String deadline = request.getParameter("deadline");
		
		Map<String, Object> paraMap = new HashedMap<>();
		
		boolean isTodo = false;
		// 나의 할일로 넘어온 경우
		if (fk_wtno == null || "".equals(fk_wtno) || fk_wrno == null || "".equals(fk_wrno)) {
			paraMap.put("todo", true);
			isTodo = true;
			
			fk_wtno = "";
			fk_wrno = "";
		}
		
		// 검색어를 통한 리스트 조회가 아닐 경우
		if (searchType == null || (!"subject".equals(searchType) && !"contents".equals(searchType))) {
			searchType = "";
		}
		
		if (searchWord == null || "".equals(searchWord) || searchWord.trim().isEmpty()) {
			searchWord = "";
		}
		paraMap.put("searchType", searchType);
		paraMap.put("searchWord", searchWord);
		
		// 업무 상태에 따른 검색이 없을 경우
		if (str_workStatus == null || "".equals(str_workStatus)) {
			str_workStatus = "";
		}
		String[] fk_statno = str_workStatus.split(",");
		paraMap.put("fk_statno", fk_statno);
		paraMap.put("str_workStatus", str_workStatus);
		
		// 등록일자와 마감일자가 비어있을 경우
		if (registerday == null || "".equals(registerday)) {
			registerday = "";
		}
		
		if (deadline == null || "".equals(deadline)) {
			deadline = "";
		}
		paraMap.put("registerday", registerday);
		paraMap.put("deadline", deadline);

		
		// 검색한 사용자의 정보검사를 위해 
		paraMap.put("fk_wtno", fk_wtno); // 업무요청:1, 업무보고:2
		paraMap.put("fk_wrno", fk_wrno); // 내가 발신자일때:1, 수신자일때:2, 참조자일때:3

		// 사용자 시퀀스번호 가져오기 
		try {
			HttpSession session = request.getSession();
			MemberVO loginuser = (MemberVO) session.getAttribute("loginuser");

			String userId = String.valueOf(loginuser.getMbr_seq());
			paraMap.put("fk_mbr_seq", userId);
		} catch (Exception e) {
			
		}

		// 해당 업무에 대한 정보 모두 가져오기 
//		List<WorkVO> workList = service.workList(paraMap);

		// ======= 페이징 처리해서 글 가져오기 ======= // 
		int totalCount = 0; 			// 총 업무 건수
		int sizePerPage = 3; 			// 한 페이당 보여주는 업무 건수
		int currentShowPageNo = 1; 		// 현재 보여주는 페이지 번호, 디폴트 1
		int totalPage = 0; 				// 총 페이지 수
		
		int startRno = 0; 		// 시작 행 번호 
		int endRno = 0; 		// 끝 행 번호
		
		if (str_sizePerPage != null) {
			sizePerPage = Integer.parseInt(str_sizePerPage);
		}
		
		totalCount = service.getTotalCount(paraMap);
		totalPage = (int) Math.ceil((double) totalCount / sizePerPage);

		if (str_currentShowPageNo == null) {
			// 게시판에 보여지는 초기화면
			currentShowPageNo = 1;
		}
		else {
			try {
				// 입력으로 들어오는 값이 숫자가 아닐 경우 에러 처리
				currentShowPageNo = Integer.parseInt(str_currentShowPageNo);
				
				// 숫자이지만 음수이거나 전체 페이지를 오버하는 경우 에러처리
				if (currentShowPageNo < 1 || currentShowPageNo > totalPage) {
					currentShowPageNo = 1;
				}
			} catch (NumberFormatException e) {
				currentShowPageNo = 1;
			}
		}
		
		startRno = ((currentShowPageNo - 1) * sizePerPage) + 1;
		endRno = startRno + sizePerPage - 1;
		
		paraMap.put("startRno", String.valueOf(startRno));
		paraMap.put("endRno", String.valueOf(endRno));
		mav.addObject("sizePerPage", String.valueOf(sizePerPage));
		mav.addObject("totalCount", String.valueOf(totalCount));
		
		// 할일 테이블과 구분하여 리스트 가져오기
		if (!isTodo) {
			// 페이징 처리한 글 목록 가져오기(검색이 있든지, 없든지 모두 다)
			List<WorkVO> workList = service.workListSearchWithPaging(paraMap); 
			mav.addObject("workList", workList);
		}
		else {
			List<TodoVO> todoList = service.todoListSearchWithPaging(paraMap);
			mav.addObject("todoList", todoList);
		}
		
		// 검색대상 컬럼과 검색어를 유지시키기 위해
		// if (!"".equals(searchType) && !"".equals(searchWord)) {
			mav.addObject("paraMap", paraMap);
		// }
		
		// ======= 페이지바 만들기 ======= //
		int blockSize = 10;	// 한블럭당 보여질 페이지의 개수
		int loop = 1;										// 1개의 블럭을 이루는 페이지번호의 개수
		int pageNo = ((currentShowPageNo - 1)/blockSize) * blockSize + 1;
		
		String pageBar = "<ul style='list-style: none;' >";
		String url = "workList.opis";
		
		// == [맨처음][이전] 만들기 == //
		if (pageNo != 1) {
			pageBar += "<li style='display:inline-block; width:70px; font-size:12pt;'><a href='"+url+"?fk_wtno="+fk_wtno+"&fk_wrno="+fk_wrno+"&registerday="+registerday+"&deadline="+deadline+"&workStatus="+str_workStatus+"&searchType="+searchType+"&searchWord="+searchWord+"&sizePerPage="+sizePerPage+"&currentShowPageNo=1'>[맨처음]</a></li>";
			pageBar += "<li style='display:inline-block; width:50px; font-size:12pt;'><a href='"+url+"?fk_wtno="+fk_wtno+"&fk_wrno="+fk_wrno+"&registerday="+registerday+"&deadline="+deadline+"&workStatus="+str_workStatus+"searchType="+searchType+"&searchWord="+searchWord+"&sizePerPage="+sizePerPage+"&currentShowPageNo="+(pageNo-1)+"'>[이전]</a></li>";
		}
		
		while(!(loop > blockSize || pageNo > totalPage)) {
			
			if (pageNo == currentShowPageNo) {
				pageBar += "<li style='display:inline-block; width:30px; font-size:12pt; border-radius: 50%; background-color: #e6e6e6; color:red; padding:2px 4px;'>"+pageNo+"</li>";
			}
			else {
				pageBar += "<li style='display:inline-block; width:30px; font-size:12pt;'><a href='"+url+"?fk_wtno="+fk_wtno+"&fk_wrno="+fk_wrno+"&registerday="+registerday+"&deadline="+deadline+"&workStatus="+str_workStatus+"&searchType="+searchType+"&searchWord="+searchWord+"&sizePerPage="+sizePerPage+"&currentShowPageNo="+pageNo+"'>"+pageNo+"</a></li>";
			}
			
			loop++;
			pageNo++;
		}
		
		// == [다음][마지막] 만들기 == //
		if (pageNo <= totalPage) {
			pageBar += "<li style='display:inline-block; width:50px; font-size:12pt;'><a href='"+url+"?fk_wtno="+fk_wtno+"&fk_wrno="+fk_wrno+"&registerday="+registerday+"&deadline="+deadline+"&workStatus="+str_workStatus+"&searchType="+searchType+"&searchWord="+searchWord+"&sizePerPage="+sizePerPage+"&currentShowPageNo="+pageNo+"'>[다음]</a></li>";
			pageBar += "<li style='display:inline-block; width:70px; font-size:12pt;'><a href='"+url+"?fk_wtno="+fk_wtno+"&fk_wrno="+fk_wrno+"&registerday="+registerday+"&deadline="+deadline+"&workStatus="+str_workStatus+"&searchType="+searchType+"&searchWord="+searchWord+"&sizePerPage="+sizePerPage+"&currentShowPageNo="+totalPage+"'>[마지막]</a></li>";
		}
		
		pageBar += "</ul>";
		mav.addObject("pageBar", pageBar);
		
		// 해당 정보를 다시 넘겨줘서 화면단 조정하기 위함
		mav.addObject("fk_wtno", fk_wtno);
		mav.addObject("fk_wrno", fk_wrno);
		
		// 상세 페이지에서 목록보기를 클릭했을 때 돌아갈 페이지를 알려주기 위해 
		String gobackURL = MyUtil.getCurrentURL(request);
		mav.addObject("gobackURL", gobackURL);
		
		if (!isTodo) {
			mav.setViewName("workmanage/workList.tiles1");
		}
		else {
			mav.setViewName("workmanage/todoList.tiles1");
		}
		
		return mav;
	}

	// == 업무상태 모달 페이지 보여주기 == //
	@RequestMapping(value = "/workStatusModal.opis")
	public ModelAndView workStatusModal(ModelAndView mav, HttpServletRequest request) {

		Map<String, String> paraMap = new HashedMap<>();

		String fk_statno = request.getParameter("fk_statno");
		String delayday = request.getParameter("delayday");
		String wmno = request.getParameter("wmno");

		paraMap.put("wmno", wmno);
		paraMap.put("fk_statno", fk_statno);
		paraMap.put("delayday", delayday);

		List<WorkMemberVO> workmbrList = service.getWorkStatusEachMember(wmno);

		mav.addObject("workmbrList", workmbrList);
		mav.addObject("paraMap", paraMap);
		mav.setViewName("workmanage/workStatus_modal");
		return mav;
	}

	// == 읽음 확인 모달 페이지 보여주기 == //
	@RequestMapping(value = "/readCheckModal.opis")
	public ModelAndView readCheckModal(ModelAndView mav, HttpServletRequest request) {

		Map<String, String> paraMap = new HashedMap<>();

		String fk_statno = request.getParameter("fk_statno");
		String delayday = request.getParameter("delayday");
		String wmno = request.getParameter("wmno");

		paraMap.put("wmno", wmno);
		paraMap.put("fk_statno", fk_statno);
		paraMap.put("delayday", delayday);

		List<WorkMemberVO> workmbrList = service.workmbrReadcheckdate(wmno);

		mav.addObject("workmbrList", workmbrList);
		mav.addObject("paraMap", paraMap);

		mav.setViewName("workmanage/readCheck_modal");
		return mav;
	}

	// == 내가 한 업무 상세 조회 페이지 == //
	@RequestMapping(value = "/showDetailWork.opis")
	public ModelAndView requiredLogin_showDetailWork(HttpServletRequest request, HttpServletResponse response,
			ModelAndView mav) {

		// 업무고유 번호 받아오기
		String wmno = request.getParameter("wmno");
		String fk_wrno = request.getParameter("fk_wrno");
		String fk_wtno = request.getParameter("fk_wtno");
		String gobackURL = request.getParameter("gobackURL");
		
		// 수신 업무 읽었을 때 읽음 처리하기 위해 필요한 것들
		Map<String, String> paraMap = new HashedMap<>();
		paraMap.put("wmno", wmno);
		paraMap.put("fk_wrno", fk_wrno);
		paraMap.put("fk_wtno", fk_wtno);
		paraMap.put("gobackURL", gobackURL);
		
		// 사용자 시퀀스번호
		String userId = null;
		HttpSession session = request.getSession();
		MemberVO loginuser = (MemberVO) session.getAttribute("loginuser");

		if (loginuser != null) {
			userId = String.valueOf(loginuser.getMbr_seq());
			paraMap.put("fk_mbr_seq", userId);
		}

		// 업무에 대한 상세 정보 가져오기 및 읽음 확인 업데이트
		WorkVO workvo = service.showDetailWork(paraMap);

		mav.addObject("fk_wtno", fk_wtno);
		mav.addObject("fk_wrno", fk_wrno);
		mav.addObject("workvo", workvo);
		
		// 첨부파일 정보 가져오기
		List<WorkFileVO> fileList = service.getWorkFile(paraMap);
		mav.addObject("fileList", fileList);

		// 업무의 처리내역 정보 가져오기
		List<WorkMemberVO> workmbrList = service.getWorkStatusEachMember(wmno);

		mav.addObject("workmbrList", workmbrList);
		mav.addObject("paraMap", paraMap);
		
		// 업무처리에서 해당 페이지로 다시 돌아오기 위해
		String gobackWorkDetilURL = MyUtil.getCurrentURL(request);
		mav.addObject("gobackWorkDetilURL", gobackWorkDetilURL);

		mav.setViewName("workmanage/showDetailWork.tiles1");
		return mav;
	}

	// 업무 수정하기
	@RequestMapping(value = "workEdit.opis")
	public ModelAndView requiredLogin_workEdit(HttpServletRequest request, HttpServletResponse response,
			ModelAndView mav) {

		Map<String, String> paraMap = new HashedMap<>();
		
		String tdno = request.getParameter("tdno"); // 업무고유 번호 받아오기
		String wmno = request.getParameter("wmno"); // 업무고유 번호 받아오기
		
		if (tdno != null && !"".equals(tdno)) {	// 할일
			paraMap.put("tdno", tdno);			

			// 할일 기본 정보가져오기
			TodoVO todovo = service.showDetailTodo(paraMap);
			mav.addObject("todovo", todovo);
			mav.addObject("isTodo", true);
		}
		else {	// 업무
			paraMap.put("wmno", wmno);

			// 업무 기본 정보가져오기
			WorkVO workvo = service.showDetailWork(paraMap);
			mav.addObject("workvo", workvo);
			mav.addObject("isTodo", false);
		}

		// 첨부파일 정보 가져오기
		List<WorkFileVO> fileList = service.getWorkFile(paraMap);
		mav.addObject("fileList", fileList);

		// 다시돌아오기 위해
		String gobackWorkDetilURL = request.getParameter("gobackWorkDetilURL"); 
		mav.addObject("gobackWorkDetilURL", gobackWorkDetilURL);

		mav.setViewName("workmanage/workEdit.tiles1");
		return mav;
	}

	// 업무 수정하기 마지막
	@RequestMapping(value = "workEditEnd.opis", method = { RequestMethod.POST })
	public ModelAndView workEditEnd(ModelAndView mav, WorkVO workvo, MultipartHttpServletRequest mrequest) {
		
		String wmno = workvo.getWmno();
		String gobackWorkDetilURL = mrequest.getParameter("gobackWorkDetilURL"); 
		
		// 첨부파일이 있을 경우 첨부파일 테이블에 넣어줄 것들
		List<MultipartFile> attachList = mrequest.getFiles("attach");
		List<WorkFileVO> fileList = null;
		
		if (attachList.size() > 0) {
			fileList = new ArrayList<>();
			
			for (MultipartFile attach : attachList) {
				WorkFileVO filevo = new WorkFileVO();
				
				filevo.setFk_wmno(wmno);
				filevo.setAttach(attach);
				
				// WAS의 webapp 의 절대경로 알아오기
				HttpSession session = mrequest.getSession();
				String root = session.getServletContext().getRealPath("/");
				String path = root+"resources"+File.separator+"files"; // File.separator 는 운영체제에서 사용하는 폴더와 파일의 구분자
				
				String newFileName = ""; // WAS(톰캣)의 디스크에 저장될 파일명 
				byte[] bytes = null; // 첨부파일의 내용을 담는 것
				long fileSize = 0; // 첨부파일의 크기
				
				try {
					bytes = attach.getBytes(); // 첨부파일의 내용물을 읽기
					String originalFilename = attach.getOriginalFilename(); // originalFilename ==> "강아지.png"
					
					newFileName = fileManager.doFileUpload(bytes, originalFilename, path);
					
					filevo.setFileName(newFileName);	
					// WAS(톰캣)에 저장될 파일명(20210603123943385139567592900.png)
					
					filevo.setOrgFilename(originalFilename);
					// 게시판 페이지에서 첨부된 파일(강아지.png)을 보여줄 때 사용.
		            // 또한 사용자가 파일을 다운로드 할때 사용되어지는 파일명으로 사용.
					
					fileSize = attach.getSize(); // 첨부파일의 크기(단위는 byte임)
					filevo.setFileSize(String.valueOf(fileSize));
					
					fileList.add(filevo);
					
				} catch (Exception e) {
					e.printStackTrace();
				}
			}
		}
		
		// 업무 수정시 수정한 일자를 업데이트하기 위해 필요한 정보
		String fk_wrno = mrequest.getParameter("fk_wrno");
		String fk_wtno = mrequest.getParameter("fk_wtno");
		
		Map<String,String> paraMap = new HashedMap<>();
		paraMap.put("wmno", workvo.getWmno());
		paraMap.put("fk_wtno", fk_wtno);
		paraMap.put("fk_wrno", fk_wrno);

		// 사용자 시퀀스번호
		String userId = null;
		HttpSession session = mrequest.getSession();
		MemberVO loginuser = (MemberVO) session.getAttribute("loginuser");
		
		if (loginuser != null) {
			userId = String.valueOf(loginuser.getMbr_seq());
			paraMap.put("fk_mbr_seq", userId);
		}
		
		// 업무 수정하기 및 수정일자 업데이트 하기
		int n = service.workEditEnd(workvo, paraMap, fileList);

		if (n == 1) {
			
			mav.setViewName("redirect:/"+gobackWorkDetilURL);
		} else {
			String message = "업무 수정에 실패하였습니다. 다시 시도하세요";
			String loc = "javascript:history.back()";

			mav.addObject("message", message);
			mav.addObject("loc", loc);

			mav.setViewName("msg");
		}

		return mav;
	}
	
	// 할일 수정하기 마지막
	@RequestMapping(value = "todoEditEnd.opis", method = { RequestMethod.POST })
	public ModelAndView todoEditEnd(ModelAndView mav, TodoVO todovo, MultipartHttpServletRequest mrequest) {
		
		String tdno = todovo.getTdno();
		String gobackWorkDetilURL = mrequest.getParameter("gobackWorkDetilURL"); 
		
		// 첨부파일이 있을 경우 첨부파일 테이블에 넣어줄 것들
		List<MultipartFile> attachList = mrequest.getFiles("attach");
		List<WorkFileVO> fileList = null;
		
		if (attachList.size() > 0) {
			fileList = new ArrayList<>();
			
			for (MultipartFile attach : attachList) {
				WorkFileVO filevo = new WorkFileVO();
				
				filevo.setFk_tdno(tdno);
				filevo.setAttach(attach);
				
				// WAS의 webapp 의 절대경로 알아오기
				HttpSession session = mrequest.getSession();
				String root = session.getServletContext().getRealPath("/");
				String path = root+"resources"+File.separator+"files"; // File.separator 는 운영체제에서 사용하는 폴더와 파일의 구분자
				
				String newFileName = ""; // WAS(톰캣)의 디스크에 저장될 파일명 
				byte[] bytes = null; // 첨부파일의 내용을 담는 것
				long fileSize = 0; // 첨부파일의 크기
				
				try {
					bytes = attach.getBytes(); // 첨부파일의 내용물을 읽기
					String originalFilename = attach.getOriginalFilename(); // originalFilename ==> "강아지.png"
					
					newFileName = fileManager.doFileUpload(bytes, originalFilename, path);
					
					filevo.setFileName(newFileName);	
					// WAS(톰캣)에 저장될 파일명(20210603123943385139567592900.png)
					
					filevo.setOrgFilename(originalFilename);
					// 게시판 페이지에서 첨부된 파일(강아지.png)을 보여줄 때 사용.
		            // 또한 사용자가 파일을 다운로드 할때 사용되어지는 파일명으로 사용.
					
					fileSize = attach.getSize(); // 첨부파일의 크기(단위는 byte임)
					filevo.setFileSize(String.valueOf(fileSize));
					
					fileList.add(filevo);
					
				} catch (Exception e) {
					e.printStackTrace();
				}
			}
		}
		
		// 사용자 시퀀스번호
		String userId = null;
		HttpSession session = mrequest.getSession();
		MemberVO loginuser = (MemberVO) session.getAttribute("loginuser");
		
		if (loginuser != null) {
			userId = String.valueOf(loginuser.getMbr_seq());
			todovo.setFk_mbr_seq(userId);
		}
		
		// 업무 수정하기 및 수정일자 업데이트 하기
		int n = service.todoEditEnd(todovo, fileList);

		if (n == 1) {
			
			mav.setViewName("redirect:/"+gobackWorkDetilURL);
		} else {
			String message = "업무 수정에 실패하였습니다. 다시 시도하세요";
			String loc = "javascript:history.back()";

			mav.addObject("message", message);
			mav.addObject("loc", loc);

			mav.setViewName("msg");
		}

		return mav;
	}


	// 업무 삭제하기
	@RequestMapping(value = "workDel.opis", method = { RequestMethod.POST })
	public ModelAndView requiredLogin_workDel(HttpServletRequest request, HttpServletResponse response,
			ModelAndView mav) {

		String gobackURL = request.getParameter("gobackURL");
		String wmnoStr = request.getParameter("wmnoStr"); // 삭제하려는 업무번호들
		String fk_wrno = request.getParameter("fk_wrno"); // 사용자의 역할
		String fk_wtno = request.getParameter("fk_wtno");

		// 삭제를 시도하는 사용자의 정보를 가져오기
		HttpSession session = request.getSession();
		MemberVO loginuser = (MemberVO) session.getAttribute("loginuser");

		Map<String, Object> paraMap = new HashedMap<>();

		String userId = String.valueOf(loginuser.getMbr_seq());
		paraMap.put("userId", userId);

		// 업무요청, 업무보고일 경우
		if (wmnoStr != null && !"".equals(wmnoStr)) {
			String[] wmnoList = wmnoStr.split(",");
			paraMap.put("wmnoList", wmnoList);
			paraMap.put("fk_wrno", fk_wrno);
		}
		
		// 할일로 넘어온 것일 때
		String tdnoStr = request.getParameter("tdnoStr"); // 할일번호들
		if (tdnoStr != null && !"".equals(tdnoStr)) {
			String[] tdnoList = tdnoStr.split(",");
			paraMap.put("tdnoList", tdnoList);
			
			fk_wtno = "";
			fk_wrno = "";
		}

		// 사용자의 역할에 따른 업무삭제 (실제는 yn의 상태를 0->1로 변환 시키는 작업)
		int n = service.workDel(paraMap);

		if (n >= 1) {
			if (gobackURL != null) {
				mav.setViewName("redirect:/" + gobackURL);
			} else {
				mav.setViewName("redirect:/workList.opis?fk_wtno=" + fk_wtno + "&fk_wrno=" + fk_wrno);
			}
		} else {
			String message = "업무 삭제에 실패하였습니다. 다시 시도하세요";
			String loc = "javascript:history.back()";

			mav.addObject("message", message);
			mav.addObject("loc", loc);

			mav.setViewName("msg");
		}

		return mav;
	}

	// 업무 관리자 한명의 상태 정보 가져오기
	@ResponseBody
	@RequestMapping(value = "oneMbrWorkStatus.opis", method = {RequestMethod.GET }, produces = "text/plain;charset=UTF-8")
	public String oneMbrWorkStatus(HttpServletRequest request) {

		String fk_mbr_seq = request.getParameter("fk_mbr_seq");
		String fk_wmno = request.getParameter("fk_wmno");
		String fk_wrno = request.getParameter("fk_wrno");

		Map<String, String> paraMap = new HashedMap<>();
		paraMap.put("fk_mbr_seq", fk_mbr_seq);
		paraMap.put("fk_wmno", fk_wmno);
		paraMap.put("fk_wrno", fk_wrno);

		WorkMemberVO workmbr = service.oneMbrWorkStatus(paraMap);

		JSONObject jsonObj = new JSONObject();
		jsonObj.put("workmbr_seq", workmbr.getWorkmbr_seq());
		jsonObj.put("mbr_name", workmbr.getMbr_name());
		jsonObj.put("lasteditdate", workmbr.getLasteditdate());
		jsonObj.put("workPercent", workmbr.getWorkPercent());
		jsonObj.put("contents", workmbr.getContents());

		return jsonObj.toString();
	}
	
	// 업무완료 클릭시 선택한 업무의 상태 완료로 변경하기
	@RequestMapping(value = "workStatusChangeToComplete.opis", method = { RequestMethod.POST })
	public ModelAndView requiredLogin_workStatusChangeToComplete(HttpServletRequest request, HttpServletResponse response,
			ModelAndView mav) {
		
		Map<String, Object> paraMap = new HashedMap<>();
		
		String gobackURL = request.getParameter("gobackURL");
		String wmnoStr = request.getParameter("wmnoStr"); // 업무번호들
		String fk_wrno = request.getParameter("fk_wrno"); // 사용자의 역할
		String fk_wtno = request.getParameter("fk_wtno");
		
		// 업무요청, 업무보고일 경우
		if (wmnoStr != null && !"".equals(wmnoStr)) {
			String[] wmnoList = wmnoStr.split(",");
			paraMap.put("wmnoList", wmnoList);
			paraMap.put("fk_wtno", fk_wtno);
		}
		
		// 할일로 넘어온 것일 때
		String tdnoStr = request.getParameter("tdnoStr"); // 할일번호들
		if (tdnoStr != null && !"".equals(tdnoStr)) {
			String[] tdnoList = tdnoStr.split(",");
			paraMap.put("tdnoList", tdnoList);
		}

		// 업무완료 클릭시 선택한 업무의 상태 완료로 변경하기
		int n = service.workStatusChangeToComplete(paraMap);

		if (n >= 1) {
			if (gobackURL != null) {
				mav.setViewName("redirect:/" + gobackURL);
			} else {
				mav.setViewName("redirect:/workList.opis?fk_wtno=" + fk_wtno + "&fk_wrno=" + fk_wrno);
			}
		} else {
			String message = "업무 삭제에 실패하였습니다. 다시 시도하세요";
			String loc = "javascript:history.back()";

			mav.addObject("message", message);
			mav.addObject("loc", loc);

			mav.setViewName("msg");
		}
		
		return mav;
	}
	
	// 첨부파일 다운로드 받기
	@RequestMapping(value="/download.opis", method = { RequestMethod.GET }, produces = "text/plain;charset=UTF-8")
	public void requiredLogin_download(HttpServletRequest request, HttpServletResponse response) {
		
		String fileName = request.getParameter("fileName"); // WAS(톰캣) 디스크에 저장된 파일명
		String orgFilename = request.getParameter("orgFilename");
		
		response.setContentType("text/html; charset=UTF-8");
		
		HttpSession session = request.getSession();
		String root = session.getServletContext().getRealPath("/"); // WAS 의 webapp 의 절대경로를 알아오기
		
		String path = root+"resources"+File.separator+"files"; 	// 첨부파일이 저장될 WAS(톰캣) 의 폴더
		System.out.println("path => " + path);
		
		// file 다운로드 하기  
		boolean flag = false; // file 다운로드의 성공 시 true,실패시 false 
		flag = fileManager.doFileDownload(fileName, orgFilename, path, response);
		
		PrintWriter out = null;
		
		try {
			out = response.getWriter(); // 웹브라우저상에 메시지를 쓰기 위한 객체생성
			
			if (!flag) {
				out.println("<script type='text/javascript'>alert('파일 다운로드가 실패되었습니다!!'); history.back();</script>");
			}
		} catch(IOException e) {
			e.printStackTrace();
		}
	}
	
	// 수신자 업무 처리내역 등록하기
	@RequestMapping(value="/receiverWorkAdd.opis", method = { RequestMethod.POST }, produces = "text/plain;charset=UTF-8")
	public ModelAndView requiredLogin_receiverWorkAdd(HttpServletRequest request, HttpServletResponse response, 
			ModelAndView mav, WorkMemberVO workmbrvo) {
		
		String fk_wtno = request.getParameter("fk_wtno");
		if ("2".equals(fk_wtno)) {
			workmbrvo.setWorkPercent("100");
		}
		
		int n = service.receiverWorkAdd(workmbrvo);
		
		// 기존페이지로 다시 이동
		if (n == 1) {
			String gobackWorkDetilURL = request.getParameter("gobackWorkDetilURL");
			mav.setViewName("redirect:/" + gobackWorkDetilURL);
		} else {
			String message = "업무 삭제에 실패하였습니다. 다시 시도하세요";
			String loc = "javascript:history.back()";

			mav.addObject("message", message);
			mav.addObject("loc", loc);

			mav.setViewName("msg");
		}
		
		return mav;
	}
	
	// 수신자 업무 처리내역 수정하기
	@RequestMapping(value = "/receiverWorkEdit.opis", method = {RequestMethod.POST }, produces = "text/plain;charset=UTF-8")
	public ModelAndView requiredLogin_receiverWorkEdit(HttpServletRequest request, HttpServletResponse response,
			ModelAndView mav, WorkMemberVO workmbrvo) {

		int n = service.receiverWorkEdit(workmbrvo);

		// 기존페이지로 다시 이동
		if (n == 1) {
			String gobackWorkDetilURL = request.getParameter("gobackWorkDetilURL");
			mav.setViewName("redirect:/" + gobackWorkDetilURL);
		} else {
			String message = "업무 삭제에 실패하였습니다. 다시 시도하세요";
			String loc = "javascript:history.back()";

			mav.addObject("message", message);
			mav.addObject("loc", loc);

			mav.setViewName("msg");
		}

		return mav;
	}
	
	// 회원 정보 가져오기
	@RequestMapping(value="/showAddresslist_work.opis")
	public ModelAndView showAddresslist_work(HttpServletRequest request, HttpServletResponse response, ModelAndView mav) {
		
		String searchType = request.getParameter("searchType");
		String searchWord = request.getParameter("searchWord");
		String targetUl = request.getParameter("targetUl");
		
		if(searchType == null || (!"dept_detail".equals(searchType) && !"mbr_name".equals(searchType)) ) {
			searchType= "";
		}
		
		if(searchWord == null || "".equals(searchWord) || searchWord.trim().isEmpty()) {
			searchWord= "";
		}
		
		Map<String, String> paraMap = new HashMap<>();
		paraMap.put("searchType", searchType);
		paraMap.put("searchWord", searchWord);
		
		List<MemberVO> memberList = service.getMemberList(paraMap);
		List<HashMap<String,String>> deptList = service.getDeptList();
		
		mav.addObject("memberList", memberList);
		mav.addObject("deptList", deptList);
		mav.addObject("targetUl", targetUl);
		
		// 아래는 검색대상 컬럼과 검색어를 유지
		if(!"".equals(searchType) && !"".equals(searchWord)) {
			mav.addObject("paraMap", paraMap);
		}
		
		mav.setViewName("workmanage/selectMember");
		return mav;
	}
	
	
	
	// 업무완료 클릭시 선택한 업무의 상태 완료로 변경하기
	@RequestMapping(value = "workPercentChangeToComplete.opis", method = { RequestMethod.POST })
	public ModelAndView requiredLogin_workPercentChangeToComplete(HttpServletRequest request, HttpServletResponse response,
			ModelAndView mav) {
		
		Map<String, Object> paraMap = new HashedMap<>();
		
		String gobackURL = request.getParameter("gobackURL");
		String wmnoStr = request.getParameter("wmnoStr"); // 업무번호들
		String fk_wrno = request.getParameter("fk_wrno"); // 사용자의 역할
		String fk_wtno = request.getParameter("fk_wtno");
		
		// 업무요청, 업무보고일 경우
		if (wmnoStr != null && !"".equals(wmnoStr)) {
			String[] wmnoList = wmnoStr.split(",");
			paraMap.put("wmnoList", wmnoList);
			paraMap.put("fk_wrno", fk_wrno);
		}
		
		HttpSession session = request.getSession();
		MemberVO loginuser = (MemberVO) session.getAttribute("loginuser");
		paraMap.put("fk_mbr_seq", loginuser.getMbr_seq());

		// 업무완료 클릭시 선택한 업무의 상태 완료로 변경하기
		int n = service.workPercentChangeToComplete(paraMap);

		if (n >= 1) {
			if (gobackURL != null) {
				mav.setViewName("redirect:/" + gobackURL);
			} else {
				mav.setViewName("redirect:/workList.opis?fk_wtno=" + fk_wtno + "&fk_wrno=" + fk_wrno);
			}
		} else {
			String message = "업무 완료 처리에 실패하였습니다. 다시 시도하세요";
			String loc = "javascript:history.back()";

			mav.addObject("message", message);
			mav.addObject("loc", loc);

			mav.setViewName("msg");
		}
		
		return mav;
	}
	
	
	// 업무완료 클릭시 선택한 업무의 상태 완료로 변경하기
	@RequestMapping(value = "workReadCheckChangeToComplete.opis", method = { RequestMethod.POST })
	public ModelAndView requiredLogin_workReadCheckChangeToComplete(HttpServletRequest request, HttpServletResponse response,
			ModelAndView mav) {
		
		Map<String, Object> paraMap = new HashedMap<>();
		
		String gobackURL = request.getParameter("gobackURL");
		String wmnoStr = request.getParameter("wmnoStr"); // 업무번호들
		String fk_wrno = request.getParameter("fk_wrno"); // 사용자의 역할
		String fk_wtno = request.getParameter("fk_wtno");
		
		// 업무요청, 업무보고일 경우
		if (wmnoStr != null && !"".equals(wmnoStr)) {
			String[] wmnoList = wmnoStr.split(",");
			paraMap.put("wmnoList", wmnoList);
			paraMap.put("fk_wrno", fk_wrno);
		}
		
		HttpSession session = request.getSession();
		MemberVO loginuser = (MemberVO) session.getAttribute("loginuser");
		paraMap.put("fk_mbr_seq", loginuser.getMbr_seq());

		// 업무완료 클릭시 선택한 업무의 상태 완료로 변경하기
		int n = service.workReadCheckChangeToComplete(paraMap);

		if (n >= 1) {
			if (gobackURL != null) {
				mav.setViewName("redirect:/" + gobackURL);
			} else {
				mav.setViewName("redirect:/workList.opis?fk_wtno=" + fk_wtno + "&fk_wrno=" + fk_wrno);
			}
		} else {
			String message = "읽음 처리에 실패하였습니다. 다시 시도하세요";
			String loc = "javascript:history.back()";

			mav.addObject("message", message);
			mav.addObject("loc", loc);

			mav.setViewName("msg");
		}
		
		return mav;
	}
	
	// 업무완료 클릭시 선택한 업무의 상태 완료로 변경하기
	@RequestMapping(value = "workStatusChangeToBack.opis", method = { RequestMethod.POST })
	public ModelAndView requiredLogin_workStatusChangeToBack(HttpServletRequest request, HttpServletResponse response,
			ModelAndView mav) {
		
		Map<String, Object> paraMap = new HashedMap<>();
		
		String gobackURL = request.getParameter("gobackURL");
		String wmnoStr = request.getParameter("wmnoStr"); // 업무번호들
		String fk_wrno = request.getParameter("fk_wrno"); // 사용자의 역할
		String fk_wtno = request.getParameter("fk_wtno");
		
		// 업무요청, 업무보고일 경우
		if (wmnoStr != null && !"".equals(wmnoStr)) {
			String[] wmnoList = wmnoStr.split(",");
			paraMap.put("wmnoList", wmnoList);
			paraMap.put("fk_wrno", fk_wrno);
		}
		
		HttpSession session = request.getSession();
		MemberVO loginuser = (MemberVO) session.getAttribute("loginuser");
		paraMap.put("fk_mbr_seq", loginuser.getMbr_seq());

		// 업무완료 클릭시 선택한 업무의 상태 완료로 변경하기
		int n = service.workStatusChangeToBack(paraMap);

		if (n >= 1) {
			if (gobackURL != null) {
				mav.setViewName("redirect:/" + gobackURL);
			} else {
				mav.setViewName("redirect:/workList.opis?fk_wtno=" + fk_wtno + "&fk_wrno=" + fk_wrno);
			}
		} else {
			String message = "반려 처리에 실패하였습니다. 다시 시도하세요";
			String loc = "javascript:history.back()";

			mav.addObject("message", message);
			mav.addObject("loc", loc);

			mav.setViewName("msg");
		}
		
		return mav;
	}	
}
