package com.spring.groupware.approval.controller;

import java.io.File;
import java.util.*;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.json.JSONArray;
import org.json.JSONObject;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.multipart.MultipartHttpServletRequest;
import org.springframework.web.servlet.ModelAndView;

import com.spring.groupware.approval.model.ApprovalVO;
import com.spring.groupware.approval.service.InterApprovalService;
import com.spring.groupware.common.FileManager;
import com.spring.groupware.common.MyUtil;
import com.spring.groupware.member.model.MemberVO;

@Controller
public class ApprovalController {

	   @Autowired 
	   private InterApprovalService service;
	   
	   @Autowired     
	   private FileManager fileManager;   
        
   
	  // === 기안문작성 메인 === //
	  @RequestMapping(value="/approvalMain.opis")
	  public ModelAndView approvalMain(ModelAndView mav) {   	  
		 mav.setViewName("approval/approvalMain.tiles1");
		 return mav;
	  }
	  
	  
	  // === 일반결의서 === //
	  @RequestMapping(value="/approvalForm1.opis")
	  public ModelAndView requiredLogin_approvalForm1(HttpServletRequest request, HttpServletResponse response, ModelAndView mav) {
		 String ap_seq = "";
		 if(request.getParameter("ap_seq")!=null) {
			 ap_seq = request.getParameter("ap_seq");
			 ApprovalVO avo = service.getApproval(ap_seq);	 // 결재 작성내용 불러오기
			 mav.addObject("avo",avo);
		 }
		
		 String today = MyUtil.getToday();
		 String fileNo = service.getFileNo(); 
		 List<MemberVO> memberList = service.getMemberList(); 
		 
		 mav.addObject("today",today);
		 mav.addObject("fileNo",fileNo);	// 문서번호 가져오기
		 mav.addObject("memberList",memberList);
		 mav.setViewName("approval/approvalForm1.tiles1");
		 return mav;
	  }
	  
	  
	  // === 지출결의서 === //
	  @RequestMapping(value="/approvalForm2.opis")
	  public ModelAndView requiredLogin_approvalForm2(HttpServletRequest request, HttpServletResponse response, ModelAndView mav) { 
		 String ap_seq = "";
		 if(request.getParameter("ap_seq")!=null) {
			 ap_seq = request.getParameter("ap_seq");
			 ApprovalVO avo = service.getApproval(ap_seq);	 // 결재 작성내용 불러오기
			 mav.addObject("avo",avo);
		 }
		 
		 String today = MyUtil.getToday();
		 String fileNo = service.getFileNo(); 	// 문서번호 가져오기
		 List<MemberVO> memberList = service.getMemberList(); 
		 
		 mav.addObject("today",today);
		 mav.addObject("fileNo",fileNo);
		 mav.addObject("memberList",memberList); 
		 mav.setViewName("approval/approvalForm2.tiles1");
		 return mav;
	  }
	  
	  
	  // === 휴가계획서 === //
	  @RequestMapping(value="/approvalForm3.opis")
	  public ModelAndView requiredLogin_approvalForm3(HttpServletRequest request, HttpServletResponse response, ModelAndView mav) {   	  
		 HttpSession session = request.getSession();
		 MemberVO loginuser = (MemberVO) session.getAttribute("loginuser");
		 
		 String ap_seq = "";
		 if(request.getParameter("ap_seq")!=null) {
			 ap_seq = request.getParameter("ap_seq");
			 ApprovalVO avo = service.getApproval(ap_seq);	 // 결재 작성내용 불러오기
			 mav.addObject("avo",avo);
		 }
		 
		 String today = MyUtil.getToday();
		 String fileNo = service.getFileNo(); 	// 문서번호 가져오기
		 List<MemberVO> memberList = service.getMemberList(); 
		 
		 mav.addObject("today",today);
		 mav.addObject("fileNo",fileNo);
		 mav.addObject("memberList",memberList); 
		 mav.setViewName("approval/approvalForm3.tiles1");
		 return mav;
	  }
	    
	  
	  // === 모달창에 입력될 전체 사원명 가져오기  === //
	  @RequestMapping(value="/getMemberList.opis")
	  public String getMemberList(HttpServletRequest request) {
		 List<MemberVO> memberList = service.getMemberList(); 
		 JSONObject jsonObj = new JSONObject();
		 jsonObj.put("memberList", memberList); 		
		 return jsonObj.toString();    		 
	  }
	  
	  
	  // 결재요청 정보 저장하기 
	  @RequestMapping(value="/approvalSubmitForm.opis", method= {RequestMethod.POST})
	  public ModelAndView approvalSubmitForm(MultipartHttpServletRequest mrequest, ApprovalVO avo, ModelAndView mav) {
		
		String ap_seq = mrequest.getParameter("ap_seq");
		String fk_apform_no = mrequest.getParameter("fk_apform_no");
		String fk_mbr_seq = mrequest.getParameter("fk_mbr_seq");
		String ap_dept = mrequest.getParameter("ap_dept");
		String ap_approver = mrequest.getParameter("ap_approver");
		String ap_manage_approver = mrequest.getParameter("ap_manage_approver");
		String ap_referrer = mrequest.getParameter("ap_referrer");
		String ap_title = mrequest.getParameter("ap_title");
		String ap_contents = "";
		
		if("0".equals(fk_apform_no)) {
			ap_contents = mrequest.getParameter("ap_contents");
		} else if ("1".equals(fk_apform_no)) {
			ap_contents = mrequest.getParameter("payDate")+"%%%"+
						  mrequest.getParameter("payAmount")+"%%%"+
						  mrequest.getParameter("payReason");
		} else {
			ap_contents = mrequest.getParameter("vacationStartDate")+"%%%"+
					      mrequest.getParameter("vacationEndDate")+"%%%"+
					      mrequest.getParameter("vacationType")+"%%%"+
					      mrequest.getParameter("takeover");
		}


		avo.setAp_seq(ap_seq);
		avo.setFk_mbr_seq(fk_mbr_seq);
		avo.setAp_dept(ap_dept);
		avo.setFk_apform_no(fk_apform_no);
		avo.setAp_approver(ap_approver);
		avo.setAp_manage_approver(ap_manage_approver);
		avo.setAp_referrer(ap_referrer);
		avo.setAp_title(ap_title);
		avo.setAp_contents(ap_contents);
		
		
		List<MultipartFile> fileList = mrequest.getFiles("attach");	// 실제 등록된 파일정보를 받아오는 리스트
		
		List<Map<String, String>> fileInfoList = new ArrayList<>();	// 파일정보를 넘기기 위한 리스트
				
		String message="", loc="";
		int fileCnt = Integer.parseInt(mrequest.getParameter("file"));
		
		if(fileCnt>0) {	// 첨부파일이 있는 경우
			
			HttpSession session = mrequest.getSession();
			String root = session.getServletContext().getRealPath("/"); 			
			String path = root+"resources"+File.separator+"files";
			String ap_detail_filename = "";	
			byte[] bytes = null;
			
			long ap_fileSize = 0;
			
			for (MultipartFile mf : fileList) {
				Map<String, String> paraMap = new HashMap<>();
				
				try {
					bytes = mf.getBytes(); // 첨부파일의 내용물을 읽어오는 것
					
					String ap_filename = mf.getOriginalFilename();					
					ap_detail_filename = fileManager.doFileUpload(bytes, ap_filename, path);				
					ap_fileSize = mf.getSize();
							
					paraMap.put("fk_ap_seq", ap_seq);
					paraMap.put("ap_filename", ap_filename);
					paraMap.put("ap_detail_filename", ap_detail_filename);
					paraMap.put("ap_fileSize", String.valueOf(ap_fileSize));
					
					fileInfoList.add(paraMap);
					
				} catch (Exception e) {
					e.printStackTrace();
				}
			}
			
			int n1 = service.submitApproval(avo); 
			int n2 = service.submitAttachedApproval(fileInfoList); 
			
			if(n1==1 && n2==1) {	// 결재요청 성공시
				message = "결재요청에 성공!";
				loc = mrequest.getContextPath()+"/approvalNeeded.opis";	    
			}
			else {	// 결재요청 실패시
				message = "결재요청에 실패!";
				loc = mrequest.getContextPath()+"/approvalMain.opis";
			}
					
		}
		else {	// 첨부파일이 없는 경우라면
		
			int n1 = service.submitApproval(avo); 
			
			if(n1==1) {	// 결재요청 성공시
				message = "결재요청에 성공!";
				loc = mrequest.getContextPath()+"/approvalNeeded.opis";   
			}
			else {	// 결재요청 실패시
				message = "결재요청에 실패!";
				loc = mrequest.getContextPath()+"/approvalMain.opis";
			}
		} 		

		mav.addObject("message", message);
		mav.addObject("loc", loc);
		mav.setViewName("msg");
	 	return mav; 
		
	  }
	  
	 
		 // === 결재대기문서  === //
		 @RequestMapping(value="/approvalNeeded.opis")
		 public ModelAndView requiredLogin_approvalNeeded(HttpServletRequest request, HttpServletResponse response, ModelAndView mav) {    	  
			mav.setViewName("approval/approvalNeeded.tiles1");
			return mav;
		 }
		  
		 // === 결재대기문서 리스트 가져오기 === //
		 @ResponseBody
		 @RequestMapping(value="/approvalNeededList.opis", produces="text/plain;charset=UTF-8")
		 public String approvalNeededList(HttpServletRequest request) { 	
			 String managePerson = request.getParameter("managePerson");
			 String s_listCnt = request.getParameter("listCnt").substring(0,request.getParameter("listCnt").indexOf('개'));
			 String writer = request.getParameter("writer");
			 String submitStartDate = request.getParameter("submitStartDate");
			 String submitEndDate = request.getParameter("submitEndDate");
			 String word = request.getParameter("word");
			 String s_currentPage = request.getParameter("currentPage");
			 
			 int totalCount = 0;         // 총 게시물 건수
			 int currentPage = Integer.parseInt(s_currentPage);  // 현재 보여주는 페이지 번호 
			 int startRno = 0;           // 시작 행번호
			 int endRno = 0;             // 끝 행번호 
			 int totalPage = 0;
			 int listCnt = Integer.parseInt(s_listCnt);
			 
			 startRno = ((currentPage - 1 ) * listCnt) + 1;
			 endRno = startRno + listCnt - 1;
			  
			 Map<String, String> paraMap = new HashMap<>();
			 paraMap.put("managePerson", managePerson);
			 paraMap.put("writer", writer);
			 paraMap.put("submitStartDate", submitStartDate);
			 paraMap.put("submitEndDate", submitEndDate);
			 paraMap.put("word", word);	 
			 paraMap.put("startRno", String.valueOf(startRno));
			 paraMap.put("endRno", String.valueOf(endRno));
			 
			 List<ApprovalVO> approvalList = service.getApprovalNeededList(paraMap); 
			 totalCount = approvalList.size();
			 totalPage = (int) Math.ceil((double)totalCount/listCnt); 
			 
			 JSONArray jsonArr = new JSONArray(); 
			 
			 if(approvalList.size() != 0) {
				 int n=0;
				 
			     for(ApprovalVO avo : approvalList) {
			    	 	JSONObject jsonObj = new JSONObject();	
						jsonObj.put("apform_name", avo.getApform_name());
						jsonObj.put("ap_title", avo.getAp_title());
						jsonObj.put("mbr_name", avo.getMbr_name());
						jsonObj.put("ap_dept", avo.getAp_dept());
						jsonObj.put("ap_start_day", avo.getAp_start_day());
						jsonObj.put("ap_seq", avo.getAp_seq());
		
						jsonArr.put(jsonObj);
						
						if(n==0) n=n+1;
			      }
			  } 
			  return jsonArr.toString(); 
	  }

  
	  // === 결재요청한 문서  === //
	  @RequestMapping(value="/approvalSubmit.opis")
	  public ModelAndView requiredLogin_approvalSubmit(HttpServletRequest request, HttpServletResponse response, ModelAndView mav) {    	  
		 mav.setViewName("approval/approvalSubmit.tiles1");
		 return mav;
	  }
	  
	  // === 결재요청한 문서 리스트 가져오기 === //
	  @ResponseBody
	  @RequestMapping(value="/approvalSubmitList.opis", produces="text/plain;charset=UTF-8")
	  public String approvalSubmitList(HttpServletRequest request) { 	
		 String fk_mbr_seq = request.getParameter("fk_mbr_seq");
		 String s_listCnt = request.getParameter("listCnt").substring(0,request.getParameter("listCnt").indexOf('개'));
		 String status = request.getParameter("status");
		 String submitStartDate = request.getParameter("submitStartDate");
		 String submitEndDate = request.getParameter("submitEndDate");
		 String word = request.getParameter("word");
		 
		 int totalCount = 0;         // 총 게시물 건수
		 int currentShowPageNo = 1;  // 현재 보여주는 페이지 번호 
		 int startRno = 0;           // 시작 행번호
		 int endRno = 0;             // 끝 행번호 
		 int totalPage = 0;
		 int listCnt = Integer.parseInt(s_listCnt);
		 
		 startRno = ((currentShowPageNo - 1 ) * listCnt) + 1;
		 endRno = startRno + listCnt - 1;
		  
		 Map<String, String> paraMap = new HashMap<>();
		 paraMap.put("fk_mbr_seq", fk_mbr_seq);
		 paraMap.put("status", status);
		 paraMap.put("submitStartDate", submitStartDate);
		 paraMap.put("submitEndDate", submitEndDate);
		 paraMap.put("word", word);	 
		 paraMap.put("startRno", String.valueOf(startRno));
		 paraMap.put("endRno", String.valueOf(endRno));
		 
		 List<ApprovalVO> approvalList = service.getApprovalSubmitList(paraMap); 	
		 totalCount = approvalList.size();
		 totalPage = (int) Math.ceil((double)totalCount/listCnt); 
		
		 
		 JSONArray jsonArr = new JSONArray(); 
		 
		 if(approvalList.size() != 0) {
		     for(ApprovalVO avo : approvalList) {
		    	 	JSONObject jsonObj = new JSONObject();	
					jsonObj.put("apform_name", avo.getApform_name());
					jsonObj.put("ap_title", avo.getAp_title());
					jsonObj.put("ap_start_day", avo.getAp_start_day());
					jsonObj.put("ap_manage_approver", avo.getAp_manage_approver());
					jsonObj.put("ap_seq", avo.getAp_seq());
					
					if(avo.getAp_end_day()==null) {
						jsonObj.put("ap_end_day", "");
					}
					else {
						jsonObj.put("ap_end_day", avo.getAp_end_day());
					}
					jsonObj.put("ap_progress", avo.getAp_progress());

					jsonArr.put(jsonObj);
		      }
		  } 
		  return jsonArr.toString(); 
	  }
  
	  
	  // === 결재참조된 문서  === //
	  @RequestMapping(value="/approvalReferred.opis")
	  public ModelAndView requiredLogin_approvalReferred(HttpServletRequest request, HttpServletResponse response, ModelAndView mav) {    	  
		 mav.setViewName("approval/approvalReferred.tiles1");
		 return mav;
	  }
	  
	  // === 결재참조된 문서 리스트 가져오기 === //
	  @ResponseBody
	  @RequestMapping(value="/approvalReferredList.opis", produces="text/plain;charset=UTF-8")
	  public String approvalReferredList(HttpServletRequest request) { 	
		 String managePerson = request.getParameter("managePerson");
		 String s_listCnt = request.getParameter("listCnt").substring(0,request.getParameter("listCnt").indexOf('개'));
		 String writer = request.getParameter("writer");
		 String submitStartDate = request.getParameter("submitStartDate");
		 String submitEndDate = request.getParameter("submitEndDate");
		 String word = request.getParameter("word");
		 
		 int totalCount = 0;         // 총 게시물 건수
		 int currentShowPageNo = 1;  // 현재 보여주는 페이지 번호 
		 int startRno = 0;           // 시작 행번호
		 int endRno = 0;             // 끝 행번호 
		 int totalPage = 0;
		 int listCnt = Integer.parseInt(s_listCnt);
		 
		 startRno = ((currentShowPageNo - 1 ) * listCnt) + 1;
		 endRno = startRno + listCnt - 1;
		  
		 Map<String, String> paraMap = new HashMap<>();
		 paraMap.put("managePerson", managePerson);
		 paraMap.put("writer", writer);
		 paraMap.put("submitStartDate", submitStartDate);
		 paraMap.put("submitEndDate", submitEndDate);
		 paraMap.put("word", word);	 
		 paraMap.put("startRno", String.valueOf(startRno));
		 paraMap.put("endRno", String.valueOf(endRno));
		 
		 List<ApprovalVO> approvalList = service.getApprovalReferredList(paraMap); 
		 totalCount = approvalList.size();
		 totalPage = (int) Math.ceil((double)totalCount/listCnt);  
		 
		 JSONArray jsonArr = new JSONArray(); 

		 if(approvalList.size() != 0) {
		     for(ApprovalVO avo : approvalList) {
		    	 	JSONObject jsonObj = new JSONObject();	
		    	 	jsonObj.put("apform_name", avo.getApform_name());
					jsonObj.put("ap_title", avo.getAp_title());
					jsonObj.put("mbr_name", avo.getMbr_name());
					jsonObj.put("ap_dept", avo.getAp_dept());
					jsonObj.put("ap_seq", avo.getAp_seq());
					jsonObj.put("ap_start_day", avo.getAp_start_day());

					jsonArr.put(jsonObj);
		      }
		  } 
		  return jsonArr.toString(); 
	  }
	
	  
	  // === 결재승인하기 === //
	  @ResponseBody
	  @RequestMapping(value="/approvalConfirm.opis", produces="text/plain;charset=UTF-8")
	  public String approvalConfirm(HttpServletRequest request) {
		 String ap_seq = request.getParameter("ap_seq");
		 String ap_progress = request.getParameter("ap_progress");
		 String ap_next_approver = request.getParameter("ap_next_approver");

		 Map<String, String> paraMap = new HashMap<>();
		 paraMap.put("ap_seq", ap_seq);
		 paraMap.put("ap_progress", ap_progress);
		 paraMap.put("ap_next_approver", ap_next_approver);
		 
		 int n = service.approvalConfirm(paraMap); 	
		 JSONObject jsonObj = new JSONObject();
		 jsonObj.put("n", n);
		 
		 return jsonObj.toString(); 
	  }
	  
	  
	  // === 결재삭제하기 === //
	  @ResponseBody
	  @RequestMapping(value="/approvalDelete.opis", produces="text/plain;charset=UTF-8")
	  public String approvalDelete(HttpServletRequest request) {
		 String ap_seq = request.getParameter("ap_seq");		
		 int n = service.approvalDelete(ap_seq); 	
		 JSONObject jsonObj = new JSONObject();
		 jsonObj.put("n", n);
		 
		 return jsonObj.toString(); 
	  }
		  
	  
	  // === 서명관리 === //
	  @RequestMapping(value="/sign.opis")
	  public ModelAndView sign(ModelAndView mav) {   	  
		 mav.setViewName("approval/sign.tiles1");
		 return mav;
	  }
	  

}