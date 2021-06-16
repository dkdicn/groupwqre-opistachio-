package com.spring.groupware.schedule.controller;

import java.util.*;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.json.JSONArray;
import org.json.JSONObject;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import com.google.gson.Gson;
import com.google.gson.JsonArray;
import com.google.gson.JsonObject;
import com.spring.groupware.addrlist.model.AddrVO;
import com.spring.groupware.member.model.MemberVO;
import com.spring.groupware.schedule.model.MtrHistoryVO;
import com.spring.groupware.schedule.model.ScheduleVO;
import com.spring.groupware.schedule.service.InterScheduleService;

@Component
@Controller
public class ScheduleController {

	@Autowired	// Type에 따라 알아서 Bean 을 주입해준다.
	private InterScheduleService service;
	
	// 접속자별 일정페이지 보여주기
	@RequestMapping(value="/myscd.opis")
	public ModelAndView requiredLogin_myscd(HttpServletRequest request, HttpServletResponse response, ModelAndView mav) {
		
		mav.setViewName("schedule/myscd.tiles1");
		// /WEB-INF/views/tiles1/schedule/myscd.jsp
		return mav;
	}
	
	// 일정 등록 페이지 보여주기
	@RequestMapping(value="/scd_register.opis")
	public ModelAndView requiredLogin_scdRegister(HttpServletRequest request, HttpServletResponse response, ModelAndView mav, ScheduleVO schedulevo) {
		
		int scdno = service.getScdno(); // 채번하기
		schedulevo.setScdno(String.valueOf(scdno));
		
		HttpSession session = request.getSession();
		MemberVO loginuser = (MemberVO) session.getAttribute("loginuser");
		
		mav.addObject("scdno",scdno);
		mav.addObject("loginuser",loginuser);
		mav.setViewName("schedule_modal/scd_register");
		return mav;
	}
	
	// 주소록 불러오기
	@RequestMapping(value="/show_addresslist.opis")
	public ModelAndView requiredLogin_showAddrList(HttpServletRequest request, HttpServletResponse response, ModelAndView mav) {
		
		// 주소록 리스트 가져오기
		List<AddrVO> addrList = service.getAddrList();
		
		String emailList = request.getParameter("mbr_email");
		String mbrName = request.getParameter("mbr_name");
		String myName = request.getParameter("myName");
		
		Map<String, String> paraMap = new HashMap<>();
		
		if(emailList != null && !"".equals(emailList)) {
			paraMap.put("emailList", emailList);
			paraMap.put("mbrName", mbrName);
			paraMap.put("myName", myName);
		}
		
		try {
			service.invitedListEmailSending(paraMap);
		} catch (Exception e) {
			String message = "메일전송에 실패하였습니다.";
			String loc = "javascript:history.back()";
	        
	        mav.addObject("message", message);
	        mav.addObject("loc",loc);
	        mav.setViewName("error");
		}
		
		mav.addObject("emailList",emailList);
		mav.addObject("addrList", addrList);
		mav.setViewName("schedule_modal/addressList");
		
		return mav;
	}
	
	// 검색으로 원하는 정보 찾기
	@RequestMapping(value="/scd_searchAddr.opis")
	public ModelAndView scd_searchAddr(ModelAndView mav, HttpServletRequest request) {
		
		List<AddrVO> addrList = null;
		addrList = service.getAddrList();
		
		String searchType = request.getParameter("searchType");
		String searchWord = request.getParameter("searchWord");
		
		if(searchType == null || (!"dept_name".equals(searchType) && !"mbr_name".equals(searchType)) ) {
			searchType= "";
		}
		
		if(searchWord == null || "".equals(searchWord) || searchWord.trim().isEmpty()) {
			searchType= "";
		}
		
		Map<String, String> paraMap = new HashMap<>();
		paraMap.put("searchType", searchType);
		paraMap.put("searchWord", searchWord);
		
		addrList = service.addrList_Search(paraMap);
		
		// 아래는 검색대상 컬럼과 검색어를 유지시키기 위한 것임.
		if(!"".equals(searchType) && !"".equals(searchWord)) {
			mav.addObject("searchType", searchType);
			mav.addObject("searchWord", searchWord);
		}
		
		mav.addObject("addrList",addrList);
		mav.setViewName("schedule_modal/addressList");
		
		return mav;
	}
	
	// 일정 등록하기
	@RequestMapping(value="/scdRegEnd.opis", method = {RequestMethod.POST})
	public ModelAndView requiredLogin_scdRegEnd(HttpServletRequest request, HttpServletResponse response, ModelAndView mav, ScheduleVO schedulevo) {
		
		int n = service.scdAdd(schedulevo);	// 일정 등록하기
		
		if(n==1) {	// 일정 등록 성공
			mav.addObject("schedulevo",schedulevo);
			mav.setViewName("schedule_modal/scdDetail");
		}
		
		else {	// 일정 등록 실패
			String message = "일정 등록에 실패하였습니다. 다시 시도하세요";
			String loc = "javascript:history.back()";
			
			mav.addObject("message",message);
			mav.addObject("loc",loc);
			
			mav.setViewName("msg");
		}
		return mav;
	}
	
	// 캘린더 상의 일정 클릭시 상세 내용 보여주기
	@RequestMapping(value="/showDetail.opis", method= {RequestMethod.GET})
	public ModelAndView requiredLogin_showDetail(HttpServletRequest request, HttpServletResponse response, ModelAndView mav) {
		
		String scdno = request.getParameter("scdno");
		
		ScheduleVO schedulevo = service.getViewScd(scdno);
		
		mav.addObject("schedulevo", schedulevo);
		mav.setViewName("schedule_modal/scdDetail");
		
		return mav;
	}
	
	// 일정 수정 페이지 요청
	@RequestMapping(value="/editScd.opis")
	public ModelAndView requiredLogin_editScd(HttpServletRequest request, HttpServletResponse response, ModelAndView mav) {
		
		String scdno = request.getParameter("scdno");
		
		ScheduleVO schedulevo = service.getViewScd(scdno); // 수정해야할 글 1개 가져오기
		
		HttpSession session = request.getSession();
	    MemberVO loginuser = (MemberVO) session.getAttribute("loginuser");
		
		if(loginuser.getMbr_seq() != Integer.parseInt(schedulevo.getFk_mbr_seq())) {
			 String message = "다른 사용자의 일정은 수정이 불가합니다.";
	         String loc = "javascript:history.back()";
	         
	         mav.addObject("message", message);
	         mav.addObject("loc", loc);
	         mav.setViewName("msg");
		}
		else {
			mav.addObject("schedulevo", schedulevo);
			mav.setViewName("schedule_modal/scdEdit");
		}
		
		return mav;
	}
	
	// 일정 수정 페이지 완료하기
	@RequestMapping(value="/editEndScd.opis", method={RequestMethod.POST})
	public ModelAndView requiredLogin_editEndScd(HttpServletRequest request, HttpServletResponse response, ModelAndView mav, ScheduleVO schedulevo) {
		
		
			int n = service.editScd(schedulevo);
			
			if(n == 1) {
				mav.addObject("schedulevo", schedulevo);
				mav.setViewName("schedule_modal/scdDetail");
			}
			else {
				mav.addObject("message", "일정 수정 실패");
				mav.addObject("loc","javascript:history.back()");
				mav.setViewName("msg");
			}
		
		return mav;
	}
	
	// 일정 삭제하기
	@RequestMapping(value="/delScd.opis", method={RequestMethod.POST})
	public ModelAndView delScd(HttpServletRequest request, ModelAndView mav, ScheduleVO schedulevo) {
		
		String scdno = request.getParameter("scdno");
		String fk_mbr_seq = request.getParameter("fk_mbr_seq");
		
		HttpSession session = request.getSession();
		MemberVO loginuser = (MemberVO) session.getAttribute("loginuser");
		
		if(loginuser.getMbr_seq() == Integer.parseInt(fk_mbr_seq)) {
			int n = service.delScd(scdno);
			
			if(n==1) {
				mav.setViewName("redirect:/scd_register.opis");
			}
			else {
				String message = "일정 삭제에 실패하였습니다.";
		        mav.addObject("message", message);
		        mav.setViewName("msg");
			}
		}
		else {
			String message = "다른 사용자의 일정은 삭제가 불가합니다.";
	        String loc = "javascript:history.back()";
	        
	        mav.addObject("message", message);
	        mav.addObject("loc", loc);
	        mav.setViewName("msg");
		}
		return mav;
	}
	
	// 풀캘린더 상에 일정 보여주기
	@ResponseBody
	@RequestMapping(value="/scdList.opis", produces="text/plain;charset=UTF-8")
	public String showScd(HttpServletRequest request) {
		
		HttpSession session = request.getSession();
		MemberVO loginuser = (MemberVO) session.getAttribute("loginuser");
		
		String userid = loginuser.getMbr_id();
		String dept_detail = loginuser.getDept_detail();
		
		Map<String, String> paraMap = new HashMap<>();
		paraMap.put("userid", userid);
		paraMap.put("dept_detail", dept_detail);
		
		List<Map<String, String>> scdList = service.showScd(paraMap);
		
		JsonArray jsonArr = new JsonArray();
		
		for(Map<String, String> map: scdList) {
			
			JsonObject jsonObj = new JsonObject();
			jsonObj.addProperty("scdno", map.get("scdno"));
			jsonObj.addProperty("fk_scdno2", map.get("fk_scdno2"));
			jsonObj.addProperty("scdsubject", map.get("scdsubject"));
			jsonObj.addProperty("scdstartdate", map.get("scdstartdate"));
			jsonObj.addProperty("scdenddate", map.get("scdenddate"));
			
			jsonArr.add(jsonObj);
		}
		
		return new Gson().toJson(jsonArr);
	}
	
	// 모든 일정 삭제하기
	@RequestMapping(value="/delAll.opis")
	public ModelAndView requiredLogin_delAll(HttpServletRequest request, HttpServletResponse response, ModelAndView mav) {
		
		HttpSession session = request.getSession();
		MemberVO loginuser = (MemberVO) session.getAttribute("loginuser");
		
		int mbr_seq = loginuser.getMbr_seq();
		
		// 나의 일정 개수 확인하기
		int totalCnt = service.cntMyTotalScd(mbr_seq);
		
		int n = service.delAll(mbr_seq);
		
		if(n == totalCnt) {
			mav.setViewName("schedule/myscd.tiles1");
		}
		else {
			String message = "전체 삭제에 실패하였습니다.";
			String loc = "javascript:history.back()";
	        
	        mav.addObject("message", message);
	        mav.addObject("loc",loc);
	        mav.setViewName("error");
		}
		
		return mav;
	}
	
	//////////////////////////////////////////////////////////////////////////////////////////////////////////////
	
	// 회의실 예약 페이지 보여주기
	@RequestMapping(value="/mtr_resv.opis")
	public ModelAndView requiredLogin_mtrResv(HttpServletRequest request, HttpServletResponse response, ModelAndView mav) {
		
		String scdno = request.getParameter("scdno");
		
		if(scdno != null) {
			
			// 일정명 가져오기
			String scdsubject = service.getScdSubject(scdno);
			
			mav.addObject("scdno",scdno);
			mav.addObject("scdsubject", scdsubject);
		}
		
		mav.setViewName("schedule_modal/mtr_resv");
		return mav;
	}
	
	// 회의실 예약하기
	@RequestMapping(value="/resvMtrEnd.opis", method = {RequestMethod.POST})
	public ModelAndView requiredLogin_resvMtrEnd(HttpServletRequest request, HttpServletResponse response, ModelAndView mav, MtrHistoryVO mtrhvo) {
		
		int usemtrno = service.getNum(); // 채번하기
		
		mtrhvo.setUsemtrno(String.valueOf(usemtrno));
		
		if(mtrhvo.getFk_scdno() == null) {
			String fk_scdno = "";
			mtrhvo.setFk_scdno(fk_scdno);
 		}
		
		int n = service.resvMtrEnd(mtrhvo);
		
		String mtrname = service.getMtrName(mtrhvo.getFk_mtrno());	// 회의실 이름 가져오기
		
		if(n==1) {
			mav.addObject("usemtrno",usemtrno);
			mav.addObject("mtrname",mtrname); 
			mav.addObject("mtrhvo", mtrhvo);
			mav.setViewName("schedule_modal/mtrDetail");
		}
		else {
			String message = "회의실 예약에 실패하였습니다. 다시 시도하세요";
			String loc = "javascript:history.back()";
			
			mav.addObject("message",message);
			mav.addObject("loc",loc);
			
			mav.setViewName("msg");
		}
		return mav;
	}
	
	// 회의실 예약현황 보여주기(구글 차트)
	@ResponseBody
	@RequestMapping(value="/showRegMtr.opis", produces="text/plain;charset=UTF-8") 
	public String goRegMtr() {
		
		List<Map<String,String>> regDetailList = service.goRegMtr();
		JsonArray jsonArr = new JsonArray();
			 
		for(Map<String,String> map:regDetailList) { 
			JsonObject jsonObj = new JsonObject();
			jsonObj.addProperty("mtrname", map.get("mtrname"));
			jsonObj.addProperty("mtrsubject", map.get("mtrsubject"));
			jsonObj.addProperty("mbr_name", map.get("mbr_name"));
			jsonObj.addProperty("starttime", map.get("starttime"));
			jsonObj.addProperty("endtime", map.get("endtime"));
			
			jsonArr.add(jsonObj);
		}
	 
	 return new Gson().toJson(jsonArr); 
	 
	}
	
	// 회의실 예약 바로취소(삭제)
	@RequestMapping(value="/mtrCancel.opis", method= {RequestMethod.POST})
	public ModelAndView mtrCancel(HttpServletRequest request, ModelAndView mav, MtrHistoryVO mtrhvo) {
		
		String usemtrno = request.getParameter("usemtrno");
		
		int n = service.delMtrReg(usemtrno);
		
		// System.out.println(usemtrno);
		
		if(n==1) {
			mav.setViewName("redirect:/mtr_resv.opis");
		}
		else {
			String message = "예약 취소에 실패하였습니다.";
			String loc = "javascript:history.back()";
			
			mav.addObject("message",message);
			mav.addObject("loc",loc);
			
			mav.setViewName("msg");
		}
		
		return mav;
	}
	
	// 회의실 예약 취소 페이지 보여주기
	@RequestMapping(value="/CancelResv.opis")
	public ModelAndView requiredLogin_cancelResv(HttpServletRequest request, HttpServletResponse response, ModelAndView mav) {
		
		mav.setViewName("schedule_modal/mtrMyResv");
		return mav;
	}
	
	// 내 회의실 예약 내역 가져오기
	@ResponseBody
	@RequestMapping(value="/showMtrResv.opis", produces="text/plain;charset=UTF-8")
	public String showMtrResv(HttpServletRequest request) {
		
		HttpSession session = request.getSession();
		MemberVO loginuser = (MemberVO) session.getAttribute("loginuser");
		
		String userid = loginuser.getMbr_id();
		List<MtrHistoryVO> mtrResvList = service.getMtrResvList(userid);
		
		JSONArray jsonArr = new JSONArray();
		
		if(mtrResvList != null) {
			for(MtrHistoryVO mtrhvo : mtrResvList) {
				JSONObject jsonObj = new JSONObject();
				jsonObj.put("usemtrno", mtrhvo.getUsemtrno());
				jsonObj.put("mtrname", mtrhvo.getMtrname());
				jsonObj.put("booker", mtrhvo.getBooker());
				jsonObj.put("mtrsubject", mtrhvo.getMtrsubject());
				jsonObj.put("starttime", mtrhvo.getStarttime());
				jsonObj.put("endtime", mtrhvo.getEndtime());
				
				jsonArr.put(jsonObj);
			}// end of for-----------------------
		}
		return jsonArr.toString();
	}
	
	// 선택된 예약 건 취소하기
	@ResponseBody
	@RequestMapping(value="/delMtrResv.opis", method= {RequestMethod.GET})
	public String delMtrResv(HttpServletRequest request, @RequestParam(value="checkArr[]") List<String> checkArr ) {
		
		int totalCnt = Integer.parseInt(request.getParameter("totalCnt"));
		
		JSONObject jsonObj = new JSONObject();	
		
		int m = 0;
		
		for(int i=0; i<checkArr.size(); i++) {
			String usermtrno = checkArr.get(i);
			int n = service.delOneResv(usermtrno);
			
			if(n==1) {
				m = n/totalCnt;
			}
		}
		jsonObj.put("m", m);
		
		return jsonObj.toString();
	}
	
	
}
