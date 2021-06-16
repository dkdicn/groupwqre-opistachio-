package com.spring.groupware.sns.controller;

import java.io.File;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;


import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.multipart.MultipartHttpServletRequest;
import org.springframework.web.servlet.ModelAndView;

import com.spring.groupware.common.FileManager;
import com.spring.groupware.member.model.MemberVO;
import com.spring.groupware.sns.service.IntersnsMemberService;


@Component
@Controller
public class GroupwareSnsController {

	@Autowired	// Type에 따라 알아서 Bean 을 주입해준다.
	private IntersnsMemberService service;
	
	@Autowired     // Type에 따라 알아서 Bean 을 주입해준다.
	private FileManager fileManager;
	
	// sns메인페이지 요청
	@RequestMapping(value="/sns/snsmain.opis")
	public ModelAndView requiredLogin_sns_main(HttpServletRequest request, HttpServletResponse response, ModelAndView mav, MemberVO membervo) {
		
		
		List<MemberVO> memberList = null;
		
		String searchWord = request.getParameter("searchWord");
		
		if(searchWord == null || "".equals(searchWord) || searchWord.trim().isEmpty()) {
			searchWord = "";
		}
		
		Map<String, String> paraMap = new HashMap<>();
		paraMap.put("searchWord", searchWord);
				
		memberList = service.memberListSearch(paraMap);
		
		if(!"".equals(searchWord)) {
			mav.addObject("paraMap", paraMap);
		}
		
		mav.addObject("memberList", memberList);
		mav.setViewName("sns/snsmain");
		
		return mav;
	}
	
	// 대화방 요청
	@RequestMapping(value="/sns/snstalkroom.opis")
	public ModelAndView requiredLogin_snstalkroom(HttpServletRequest request, HttpServletResponse response, ModelAndView mav) {
		
		
		
		mav.setViewName("sns/talkroom");
		return mav;
	}
	
	// 유저정보 수정 페이지 요청하기
	@RequestMapping(value="/sns/infochange.opis")
	public ModelAndView requiredLogin_infochange(HttpServletRequest request, HttpServletResponse response, ModelAndView mav) {
		
		mav.setViewName("sns/infochange");
		return mav;
	}
	
	// 유저정보 수정 완료하기
	@RequestMapping(value="/infochangeend.opis", method= {RequestMethod.POST})
	public ModelAndView editEnd(ModelAndView mav, MemberVO membervo, MultipartHttpServletRequest mrequest) {
	
			MultipartFile mbr_photo = membervo.getMbr_photo();
			HttpSession session = mrequest.getSession();
			String path = "C:\\FinalProject\\GroupwareProgram\\Groupware\\src\\main\\webapp\\resources\\images"+File.separator+"files";
			String mbr_img = "";
			byte[] bytes = null;
			try {
				bytes = mbr_photo.getBytes();
				String originalFilename = mbr_photo.getOriginalFilename();
				mbr_img = fileManager.doFileUpload(bytes, originalFilename, path);
				membervo.setMbr_photo(mbr_photo);
				membervo.setMbr_img(mbr_img);
				
			} catch (Exception e) {
				e.printStackTrace();
			}
					
			int n = service.infochange(membervo);
			
			
			if(n==1) {
				session = mrequest.getSession();
				
				MemberVO loginuser = (MemberVO) session.getAttribute("loginuser");
				loginuser.setMbr_name(membervo.getMbr_name());
				loginuser.setMbr_stsmsg(membervo.getMbr_stsmsg());
				
				mav.setViewName("redirect:/sns/snsmain.opis");
		
			}
			return mav;
	}

	// 접속상태 수정하기
	  @RequestMapping(value="/sns/status.opis") 
	  public ModelAndView status(ModelAndView mav, MemberVO membervo, HttpServletRequest request) {
	  
	  int n = service.statuschange(membervo);
	  
	  if(n==1) { 
		  HttpSession session = request.getSession();
	  
		  MemberVO loginuser = (MemberVO) session.getAttribute("loginuser");
		  loginuser.setMbr_stsconnect(membervo.getMbr_stsconnect());
		  
		  mav.setViewName("redirect:/sns/snsmain.opis"); 
		  }
	  else {
		  mav.setViewName("redirect:/sns/snsmain.opis");
	  }
	  return mav; 
	  }
	  
	  
	  //채팅방 호출
	  @RequestMapping(value="/sns/talkroom.opis", method= {RequestMethod.GET})
	   public String requiredLogin_multichat(HttpServletRequest request, HttpServletResponse response) {
		   
		   return "/sns/talkroom";
	   }
	  
		/*
		 * // 채팅방 리스트 출력하기 ajax
		 * 
		 * @ResponseBody
		 * 
		 * @RequestMapping(value="/talkroomlist.opis", method= {RequestMethod.GET},
		 * produces="text/plain;charset=UTF-8") public String
		 * talkroomlist(HttpServletRequest request) {
		 * 
		 * String fk_mbr_id = request.getParameter("fk_mbr_id");
		 * 
		 * List<TalkroomVO> talkroomlist = service.getTalkroomlist(fk_mbr_id);
		 * 
		 * JSONArray jsonArr = new JSONArray();
		 * 
		 * if(talkroomlist != null) { for(TalkroomVO troomvo : talkroomlist ) {
		 * JSONObject jsonObj = new JSONObject(); jsonObj.put("room_name",
		 * troomvo.getRoom_name()); jsonObj.put("room_seq", troomvo.getRoom_seq());
		 * 
		 * jsonArr.put(jsonObj); } }
		 * 
		 * return jsonArr.toString(); }
		 */
	  
	  
		/*
		 * // 채팅방 삭제하고 리스트 출력하기 ajax
		 * 
		 * @ResponseBody
		 * 
		 * @RequestMapping(value="/talkroomlistDel.opis", method= {RequestMethod.GET},
		 * produces="text/plain;charset=UTF-8") public String
		 * talkroomlistDel(HttpServletRequest request) {
		 * 
		 * String fk_mbr_id = request.getParameter("fk_mbr_id");
		 * 
		 * List<TalkroomVO> talkroomlist = service.delTalkroomlist(fk_mbr_id);
		 * 
		 * JSONArray jsonArr = new JSONArray();
		 * 
		 * if(talkroomlist != null) { for(TalkroomVO troomvo : talkroomlist ) {
		 * JSONObject jsonObj = new JSONObject(); jsonObj.put("room_name",
		 * troomvo.getRoom_name()); jsonObj.put("room_seq", troomvo.getRoom_seq());
		 * 
		 * jsonArr.put(jsonObj); } }
		 * 
		 * return jsonArr.toString(); }
		 */
	  
}	

