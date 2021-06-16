package com.spring.groupware.member.controller;

import java.io.UnsupportedEncodingException;
import java.security.GeneralSecurityException;
import java.security.NoSuchAlgorithmException;
import java.util.*;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.servlet.ModelAndView;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.google.gson.*;
import com.spring.groupware.common.AES256;
import com.spring.groupware.member.model.*;
import com.spring.groupware.member.service.InterMemberService;


@Controller
public class MemberController {

   @Autowired // Type에 따라 알아서 Bean 을 주입해준다.
   private InterMemberService service;

	// 암호화 하기
	@Autowired
	private AES256 aes;
   
	   // === 로그인 메인에 회사명 띄우기 === //
	   @RequestMapping(value="/login.opis")
	   public ModelAndView login(HttpServletRequest request, ModelAndView mav) {
		 String com_name = service.getCompanyName();
		 mav.addObject("com_name",com_name);
		 mav.setViewName("login");
	 	 return mav;
	   }
	   
   
   	  // === 로그인 확인하기 === //
      @RequestMapping(value="/loginCheck.opis", method= {RequestMethod.POST})
      public ModelAndView loginCheck(HttpServletRequest request, ModelAndView mav) throws Exception {
    	  String id = request.getParameter("idInput");
    	  String pwd = request.getParameter("pwdInput");
    	  String ip = request.getRemoteAddr();
    	  
    	  Map<String, String> paraMap = new HashMap<>();
    	  paraMap.put("id", id);
    	  paraMap.put("pwd", aes.encrypt(pwd));
    	  paraMap.put("ip", ip);
    	  
    	  MemberVO loginuser = service.loginCheck(paraMap);    	     
    	  
    	  if(loginuser==null) {		// 일치하는 멤버가 없을 때
    		  mav.addObject("loginuser", loginuser);
    	      mav.setViewName("redirect:/login.opis");
    	  }
    	  else {	// 일치하는 멤버가 있을 때
    		  if(Integer.parseInt(loginuser.getPwdChangeGap())>5) {	// 비밀번호 변경한지 6개월이 넘은 경우 
    			  HttpSession session = request.getSession();	
        		  session.setAttribute("loginuser", loginuser);
        		  session.setAttribute("pwd", aes.decrypt(loginuser.getMbr_pwd()));
        		  mav.setViewName("pwdChange.tiles1");
        	  }
        	  else {
        		  HttpSession session = request.getSession();
        		  session.setAttribute("loginuser", loginuser);
    		  	  String goBackURL = (String) session.getAttribute("goBackURL");
				 
				  if(goBackURL != null) {
				      mav.setViewName("redirect:/"+goBackURL);
					  session.removeAttribute("goBackURL"); // 세션에서 반드시 제거해주어야 한다.
				  }
				  else {
					  mav.setViewName("redirect:/mainPage.opis");
				  }
        	  }
    	  }
     	  return mav;
      }      
      
      
     // === 비밀번호 변경요청 === //
      @RequestMapping(value="/pwdChange.opis")
      public ModelAndView pwdChange(ModelAndView mav)  {  
    	 mav.setViewName("pwdChange.tiles1");
    	 return mav;
      }
      
      
      // === 로그아웃 하기 === //
      @RequestMapping(value="/logout.opis")
      public ModelAndView logout(HttpServletRequest request, ModelAndView mav) {
    	  HttpSession session = request.getSession();
    	  
    	  MemberVO loginuser = (MemberVO) session.getAttribute("loginuser");

    	  int mbr_seq = loginuser.getMbr_seq();
    	  
    	  service.logout(mbr_seq);    	     	
    	  session.removeAttribute("loginuser");
    	  mav.setViewName("redirect:/login.opis");  // 로그인페이지로 이동  	  
     	  return mav;
      }      
      
      
      // === 메인페이지 === //
      @RequestMapping(value="/mainPage.opis")
      public ModelAndView mainPage(ModelAndView mav) {   	  
    	 mav.setViewName("mainPage.tiles1");
    	 return mav;
      }
      
      
      // === 개인정보설정 === //
      @RequestMapping(value="/personalInfo.opis")
      public ModelAndView personalInfo(ModelAndView mav) {   	  
    	 mav.setViewName("member/personalInfo.tiles1");
    	 return mav;
      }
   
      
      // === 회사정보설정 === //
      @RequestMapping(value="/companyInfo.opis")
      public ModelAndView companyInfo(ModelAndView mav) {   
    	 CompanyVO cvo = service.getCompanyInfo();
    	 String ceo_name = service.getCeoName();
    	 MemberVO mvo = service.getAdminInfo();
    	 
 		 mav.addObject("cvo",cvo);
 		 mav.addObject("ceo_name",ceo_name);
 		 mav.addObject("mvo",mvo);
    	 mav.setViewName("member/companyInfo.tiles1");
    	 return mav;
      }
      
      
      // === 조직도 === //
      @RequestMapping(value="/mbrchart.opis")
      public ModelAndView mbrchart(ModelAndView mav) {   	  
    	 mav.setViewName("member/mbrchart.tiles1");
    	 return mav;
      }
      
      
   
      // === 조직도용 정보 가져오기 === //
  	  @ResponseBody
  	  @RequestMapping(value="/member/getChartInfo.opis", produces="text/plain;charset=UTF-8")
      public String getChartInfo(HttpServletRequest request) {
  		  String chartStyle = request.getParameter("chartStyle");
  		  
  		  List<Map<String, String>> chartInfoList = service.getChartInfo(chartStyle);
  		  
  		  JsonArray jsonArr = new JsonArray();
  		  
  		  for(Map<String, String> map : chartInfoList) {
  			  JsonObject jsonObj = new JsonObject();
  			  jsonObj.addProperty("id", map.get("dept_detail")+" "+map.get("rank_detail"));
  			  jsonObj.addProperty("title", map.get("dept_detail")+" "+map.get("rank_detail"));
  			  jsonObj.addProperty("name", map.get("mbr_name"));
  			
  		      jsonArr.add(jsonObj);
  		  }
  		return new Gson().toJson(jsonArr);
  	}
  	  
  	  
  	// === 비밀번호 변경하기 === //
    @RequestMapping(value="/changePwd.opis")
    public ModelAndView changePwd(HttpServletRequest request, ModelAndView mav) {  
      String newPwd1 = request.getParameter("newPwd1");	
      String mbr_seq = request.getParameter("mbr_seq");	
    
      int n = service.changePwd(newPwd1, mbr_seq);
    
      mav.setViewName("changePwd.tiles1");
      return mav;
    }  

}