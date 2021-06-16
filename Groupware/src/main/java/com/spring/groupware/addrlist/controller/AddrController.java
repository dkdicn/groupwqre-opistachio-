package com.spring.groupware.addrlist.controller;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

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
import org.springframework.web.servlet.ModelAndView;

import com.spring.groupware.addrlist.model.AddrGroupVO;
import com.spring.groupware.addrlist.model.AddrVO;
import com.spring.groupware.addrlist.service.InterAddrService;
import com.spring.groupware.common.MyUtil;
import com.spring.groupware.member.model.MemberVO;

@Controller
public class AddrController {

   @Autowired // Type에 따라 알아서 Bean 을 주입해준다.
   private InterAddrService service;
   
   @RequestMapping(value="/addAddrModal.opis", method= {RequestMethod.GET})
   public String addAddrModal() {
	   return "/tiles1/addrlist/addAddrModal";
   }
   
   
   // ============================ 전체 주소록 ============================ //
   
   // === 사원번호로 주소록 검색 === //
   
   // === 주소록 추가 === //
   @RequestMapping(value="/addr_addEnd.opis", method= {RequestMethod.POST})
   public ModelAndView requiredLogin_addEnd(HttpServletRequest request, HttpServletResponse response, ModelAndView mav, AddrVO addrvo) {
 
 	  HttpSession session = request.getSession();
	  MemberVO loginuser = (MemberVO) session.getAttribute("loginuser");
	  
	  String hp1 = request.getParameter("hp1"); 
	  String hp2 = request.getParameter("hp2"); 
	  String hp3 = request.getParameter("hp3");
	  
	  String mbr_phone_number = hp1 + hp2 + hp3;
	  
	  addrvo.setMbr_phone_number(mbr_phone_number);
	  
	  int fk_mbr_seq = Integer.parseInt(request.getParameter("mbr_seq"));
	  addrvo.setFk_mbr_seq(fk_mbr_seq);

 	  if( "사원".equals(loginuser.getPower_detail()) ) {
          String message = "관리자 외 주소록 추가는 불가능합니다.";
          String loc = "javascript:history.back()";
          
          mav.addObject("message", message);
          mav.addObject("loc", loc);
          mav.setViewName("msg");
       }
       else {	
	 	  int n = service.add(addrvo);
	 	  
	 	  if(n==1) {
	 		  mav.setViewName("redirect:/totaladdrlist.opis");
	 		  
	 	  }
	 	  else {
	 		  mav.setViewName("board/error/add_error.tiles1");
	 	  }
       }
 	  
 	  return mav;
   }
   
   // === 사원번호로 등록할 주소록 사원 검색 === //
   @RequestMapping(value="/searchMbr.opis")
   public ModelAndView searchMbrList(HttpServletRequest request, ModelAndView mav) {
	   
	   List<MemberVO> searchMbrList = null; 
	   
	   String mbr_seq = request.getParameter("mbr_seq");
//	   System.out.println("확인용 mbr_seq : "+mbr_seq);
	   
	   try {
		   searchMbrList = service.searchMbr(mbr_seq);
	   } catch (NumberFormatException e1) {
		   e1.printStackTrace();
	   } catch (Exception e2) {
		   e2.printStackTrace();
	   } 
	   
	   mav.addObject("searchMbrList", searchMbrList);
	   mav.setViewName("tiles1/addrlist/searchMbr");
	   
	   return mav;
   }
   
   // === 주소록 목록 === //
   @RequestMapping(value="/totaladdrlist.opis")
   public ModelAndView requiredLogin_addrlist(HttpServletRequest request, HttpServletResponse response, ModelAndView mav) {

 	  List<AddrVO> addrList = null; 
 	  List<AddrGroupVO> addrgroupList = null;
 	  
 	  HttpSession session = request.getSession();
	  MemberVO loginuser = (MemberVO) session.getAttribute("loginuser");
 	  
 	  String searchType = request.getParameter("searchType");
 	  String searchWord = request.getParameter("searchWord");    	  
 	  String str_currentShowPageNo = request.getParameter("currentShowPageNo");
 	  int fk_mbr_seq = loginuser.getMbr_seq();
 	  
 	  if(searchType == null || (!"dept_name".contentEquals(searchType) && !"mbr_name".contentEquals(searchType)) ) {
 		  searchType="";
 	  }
 	  
 	  if(searchWord == null || "".equals(searchWord) || searchWord.trim().isEmpty()) {
 		  searchWord="";
 	  }
 	  
 	  Map<String,String> paraMap = new HashMap<>();    	  
 	  paraMap.put("searchType", searchType);
 	  paraMap.put("searchWord", searchWord);
 	  paraMap.put("fk_mbr_seq", String.valueOf(fk_mbr_seq));
 	  
 	  int totalCount = 0; 			// 총 게시물 건수
 	  int sizePerPage = 10;       	// 한 페이지당 보여줄 게시물 건수     	  
 	  int currentShowPageNo = 0;  	// 현재 보여주는 페이지 번호로서, 초기치로는 1페이지로 설정
 	  int totalPage = 0;          	// 총 페이지수
 	  
 	  int startRno = 0;           	// 시작 행번호
      int endRno = 0;             	// 끝 행번호 
       
      // 총 주소록 건수(totalCount)
      totalCount = service.getTotalCount(paraMap);
       
      totalPage = (int)Math.ceil((double)totalCount/sizePerPage);	
       
 	  if(str_currentShowPageNo == null) {
 		  currentShowPageNo = 1;
 	  }
 	  else {
 		  try {
 			currentShowPageNo = Integer.parseInt(str_currentShowPageNo);
 			if(currentShowPageNo < 1 || currentShowPageNo > totalPage) {
 				currentShowPageNo = 1;
 			}
 		  } catch (NumberFormatException e) {
				currentShowPageNo = 1;
			}
 	  }

 	  
 	  startRno = ((currentShowPageNo - 1 ) * sizePerPage) + 1;
      endRno = startRno + sizePerPage - 1;
 	  
      paraMap.put("startRno", String.valueOf(startRno));
      paraMap.put("endRno", String.valueOf(endRno));
       
 	  addrList = service.addrListSearchWithPaging(paraMap);
 	  // 페이징 처리한 주소록 목록 가져오기(검색이 있든지, 검색이 없든지 모두 다 포함한 것)
	  
 	  addrgroupList = service.addrgroupListNoPaging(paraMap);
 	  // 개인주소록 목록 가져오기
 	  
 	  // 검색대상 컬럼과 검색어 유지
 	  if(!"".equals(searchType) && !"".equals(searchWord)) {
 		  mav.addObject("paraMap", paraMap);
 	  }

 	  int blockSize = 5;
 	  int loop=1;
 	  
 	  int pageNo = ((currentShowPageNo - 1)/blockSize) * blockSize + 1;

 	  String pageBar = "<ul style='list-style: none;'>";
 	  String url = "totaladdrlist.opis";
 	  
 	  // === [맨처음][이전] 만들기 ===
 	  if(pageNo != 1) {
 		  pageBar += "<li style='display:inline-block; width:70px; font-size:12pt;'><a href='"+url+"?searchType="+searchType+"&searchWord="+searchWord+"&currentShowPageNo=1'>[맨처음]</a></li>";
 		  pageBar += "<li style='display:inline-block; width:50px; font-size:12pt;'><a href='"+url+"?searchType="+searchType+"&searchWord="+searchWord+"&currentShowPageNo="+(pageNo-1)+"'>[이전]</a></li>";
 	  }
 	  
 	  while(!(loop > blockSize || pageNo > totalPage )) {
 		
 		  if(pageNo == currentShowPageNo) {
 			  pageBar += "<li style='display:inline-block; width:30px; font-size:12pt; background-color: #F2F2F2; border-radius: 15px; color:red; padding:2px 4px;'>"+pageNo+"</li>";
 		  }
 		  else {
 			  pageBar += "<li style='display:inline-block; width:30px; font-size:12pt;'><a href='"+url+"?searchType="+searchType+"&searchWord="+searchWord+"&currentShowPageNo="+pageNo+"'>"+pageNo+"</a></li>";
 		  }
 		  
 		  loop++;
 		  pageNo++;
 	  }// end of while----------------------------------
 	  
 	  // === [다음][마지막] 만들기 ===
 	  if(pageNo <= totalPage) {
 		  pageBar += "<li style='display:inline-block; width:50px; font-size:12pt;'><a href='"+url+"?searchType="+searchType+"&searchWord="+searchWord+"&currentShowPageNo="+pageNo+"'>[다음]</a></li>";
 		  pageBar += "<li style='display:inline-block; width:70px; font-size:12pt;'><a href='"+url+"?searchType="+searchType+"&searchWord="+searchWord+"&currentShowPageNo="+totalPage+"'>[마지막]</a></li>";
 	  }
 	  
 	  pageBar += "</ul>";
 	  
 	  mav.addObject("pageBar", pageBar);
 	  
 	  String gobackURL = MyUtil.getCurrentURL(request);

 	  mav.addObject("gobackURL", gobackURL);
 	  mav.addObject("addrList", addrList);
 	  mav.addObject("addrgroupList", addrgroupList);
 	  mav.setViewName("addrlist/totaladdrlist.tiles1");
 	 
 	  return mav;
   }
   
   // === 주소록 검색 === //
   @ResponseBody
   @RequestMapping(value="/wordSearchShow.opis", produces="text/plain;charset=UTF-8")
   public String wordSearchShow(HttpServletRequest request) {
	   
 	  String searchType = request.getParameter("searchType");
 	  String searchWord = request.getParameter("searchWord");

 	  Map<String,String> paraMap = new HashMap<>();
 	  paraMap.put("searchType",searchType);
 	  paraMap.put("searchWord",searchWord);
 	  	  
 	  List<String> wordList = service.wordSearchShow(paraMap);
 	  
 	  JSONArray jsonArr = new JSONArray();
 	  
 	  if(wordList != null) {
 		  for(String word : wordList) {
 			  JSONObject jsonObj = new JSONObject();
 			  jsonObj.put("word", word); 
 			  
 			  jsonArr.put(jsonObj);
 		  }
 	  }
 	  
 	  return jsonArr.toString();
   }
   
   // === 주소록 1개를 보여주는 페이지 요청 === //
   @RequestMapping(value="/addr_view.opis")
   public ModelAndView view(HttpServletRequest request, ModelAndView mav) {
 	  
 	  // 조회하고자 하는 주소혹 번호 받아오기
 	  String addr_seq = request.getParameter("addr_seq");

 	  AddrVO addrvo = service.getView(addr_seq);

 	  mav.addObject("addrvo", addrvo);
 	  mav.setViewName("addrlist/addr_view.tiles1");
 	  
 	  return mav;
   }  
   
   // === 주소록 수정 페이지 요청 === //
   @RequestMapping(value="/addr_edit.opis")
   public ModelAndView requiredLogin_edit(HttpServletRequest request, HttpServletResponse response, ModelAndView mav) {
//   public ModelAndView edit(HttpServletRequest request, HttpServletResponse response, ModelAndView mav) {

 	  // 수정해야 할 글번호 가져오기
 	  String addr_seq = request.getParameter("addr_seq");
 	  
 	  // 글조회수(readCount) 증가 없이 단순히 글1개만 조회 해주는 것이다.
 	  AddrVO addrvo = service.getView(addr_seq);

 	  HttpSession session = request.getSession();
 	  MemberVO loginuser = (MemberVO) session.getAttribute("loginuser");
       
 	  if( "사원".equals(loginuser.getPower_detail()) ) {
          String message = "관리자 외 수정 불가합니다.";
          String loc = "javascript:history.back()";
          
          mav.addObject("message", message);
          mav.addObject("loc", loc);
          mav.setViewName("msg");
       }
       else {	
     	 // 자신의 글을 수정할 경우
     	 // 가져온 1개글을 글수정할 폼이 있는 view 단으로 보내준다.
     	 mav.addObject("addrvo", addrvo);
     	 mav.setViewName("addrlist/addr_edit.tiles1");

       }
 	  return mav;
   }
   
   // === 주소록 수정 페이지 완료하기 === //
   @RequestMapping(value="/addr_editEnd.opis", method= {RequestMethod.POST}) 
   public ModelAndView editEnd(ModelAndView mav, AddrVO addrvo, HttpServletRequest request) {

	  String hp1 = request.getParameter("hp1"); 
	  String hp2 = request.getParameter("hp2"); 
	  String hp3 = request.getParameter("hp3");
	  
	  String mbr_phone_number = hp1 + hp2 + hp3;
	  
	  addrvo.setMbr_phone_number(mbr_phone_number);
 	  	   
 	  int n = service.edit(addrvo);
 	  
 	  if(n == 0) {
         mav.addObject("message", "주소록 정보 수정을 실패했습니다.");
      }
      else {
         mav.addObject("message", "주소록 정보를 성공적으로 수정했습니다.");
      }
	  
       mav.addObject("loc", request.getContextPath()+"/addr_view.opis?addr_seq="+addrvo.getAddr_seq());
       mav.setViewName("msg");
 	  
       return mav;
   }

   // === 주소록 삭제  === // 
   @RequestMapping(value="/addr_delEnd.opis", method= {RequestMethod.GET})
   public ModelAndView delEnd(ModelAndView mav, HttpServletRequest request) {
 	  
 	  // 삭제해야 할 주소록 번호 가져오기
 	  String addr_seq = request.getParameter("addr_seq");
       
       Map<String,String> paraMap = new HashMap<>();
       paraMap.put("addr_seq", addr_seq);
       
       int n = service.del(paraMap); 
       // n 이 1 이라면 정상적으로 삭제, n 이 0 이라면 글삭제 실패
       
       if(n == 0) {
           mav.addObject("message", "주소록 정보 삭제를 실패했습니다.");
           mav.addObject("loc", request.getContextPath()+"/addr_view.opis?addr_seq="+addr_seq);
       }
       else {
          mav.addObject("message", "주소록 정보를 성공적으로 삭제했습니다.");
          mav.addObject("loc", request.getContextPath()+"/totaladdrlist.opis");
       }
       
       mav.setViewName("msg");

       return mav;
   }
   
   
   //=== 개인 주소록에 추가 === //
   @RequestMapping(value="/addmyAddr.opis")
   public ModelAndView addmyAddr(HttpServletRequest request, ModelAndView mav) {
   	
	   String[] checkAddrSeq = request.getParameterValues("checkAddrSeq");
	   String[] addrSeqArr = checkAddrSeq[0].toString().split(","); // 가져온 addr_seq 분리해서 배열에 담기
	   int checkCnt = Integer.parseInt(request.getParameter("checkCnt")); // 총 체크개수 가져오기
	   String addrgroup_seq = request.getParameter("addrgroup_seq"); // 선택한 주소록 그룹 번호 가져오기

	   // 추가할 주소록 번호 map에 담기
	   Map<String,String> paraMap = new HashMap<>();
 	   paraMap.put("addrgroup_seq",addrgroup_seq);
	
 	   int n = 0,i = 0;
 	   for(i=0; i<checkCnt; i++) { // 선택한 주소록 번호 맵에 넣고 추가하기
   			paraMap.put("addrSeq",addrSeqArr[i]);
   			n = service.addmyAddr(paraMap);
 	   }
 	   
// 	   System.out.println("확인용 N : "+n+"확인용 i :"+i+"확인용 checkCnt : "+checkCnt);
   		
	   	if(n==1 && i==checkCnt) { // n값이 1 이고 총 반복횟수가 체크개수와 같다면 성공
	   		mav.setViewName("redirect:/myAddrlist.opis?addrgroup_seq="+addrgroup_seq);  
	   	}
	   	else {
	   	    mav.setViewName("board/error/add_error.tiles1");
	   	}
	   	  
	   	return mav;
   		
   }
   

   
   // ============================ 개인 주소록 ============================ //  
   // === 주소록 목록 === //
   @RequestMapping(value="/myAddrlist.opis")
   public ModelAndView requiredLogin_myAddrlist(HttpServletRequest request, HttpServletResponse response, ModelAndView mav) {

 	  List<AddrVO> myAddrlist = null; 
 	   	  
 	  String searchType = request.getParameter("searchType");
 	  String searchWord = request.getParameter("searchWord");    	  
 	  String str_currentShowPageNo = request.getParameter("currentShowPageNo");
 	  
 	  HttpSession session = request.getSession();
	  MemberVO loginuser = (MemberVO) session.getAttribute("loginuser");
	  
	  // 로그인한 사원의 사원번호 가져오기
	  int fk_mbr_seq = loginuser.getMbr_seq();
	  String addrgroup_seq = request.getParameter("addrgroup_seq");
	  String fk_addrgroup_seq = addrgroup_seq;
// 	  System.out.println("확인용 : "+fk_mbr_seq+"/"+addrgroup_seq);
	  
	  if(searchType == null || (!"dept_name".contentEquals(searchType) && !"mbr_name".contentEquals(searchType)) ) {
 		  searchType="";
 	  }
 	  
 	  if(searchWord == null || "".equals(searchWord) || searchWord.trim().isEmpty()) {
 		  searchWord="";
 	  }
 	  
 	  Map<String,String> paraMap = new HashMap<>();    	  
 	  paraMap.put("searchType", searchType);
 	  paraMap.put("searchWord", searchWord);
 	  paraMap.put("addrgroup_seq", addrgroup_seq);
      paraMap.put("fk_addrgroup_seq", fk_addrgroup_seq);
 	  
 	  int totalCount = 0; 			// 총 게시물 건수
 	  int sizePerPage = 10;       	// 한 페이지당 보여줄 게시물 건수     	  
 	  int currentShowPageNo = 0;  	// 현재 보여주는 페이지 번호로서, 초기치로는 1페이지로 설정
 	  int totalPage = 0;          	// 총 페이지수
 	  
 	  int startRno = 0;           	// 시작 행번호
      int endRno = 0;             	// 끝 행번호 
       
      // 총 주소록 건수(totalCount)
      totalCount = service.getmyAddrTotalCount(paraMap);      
      totalPage = (int)Math.ceil((double)totalCount/sizePerPage);	
       
 	  if(str_currentShowPageNo == null) {
 		  currentShowPageNo = 1;
 	  }
 	  else {
 		  try {
 			currentShowPageNo = Integer.parseInt(str_currentShowPageNo);
 			if(currentShowPageNo < 1 || currentShowPageNo > totalPage) {
 				currentShowPageNo = 1;
 			}
 		  } catch (NumberFormatException e) {
				currentShowPageNo = 1;
			}
 	  }
	  
 	  startRno = ((currentShowPageNo - 1 ) * sizePerPage) + 1;
      endRno = startRno + sizePerPage - 1;
 	  
      paraMap.put("startRno", String.valueOf(startRno));
      paraMap.put("endRno", String.valueOf(endRno));
      paraMap.put("fk_mbr_seq", String.valueOf(fk_mbr_seq));
      
      
      myAddrlist = service.myAddrlistSearchWithPaging(paraMap);
 	  // 페이징 처리한 주소록 목록 가져오기(검색이 있든지, 검색이 없든지 모두 다 포함한 것)
	  
 	  // 검색대상 컬럼과 검색어 유지
 	  if(!"".equals(searchType) && !"".equals(searchWord)) {
 		  mav.addObject("paraMap", paraMap);
 	  }

 	  int blockSize = 5;
 	  int loop=1;
 	  
 	  int pageNo = ((currentShowPageNo - 1)/blockSize) * blockSize + 1;

 	  String pageBar = "<ul style='list-style: none;'>";
 	  String url = "myAddrlist.opis?addrgroup_seq="+addrgroup_seq;
 	  
 	  // === [맨처음][이전] 만들기 ===
 	  if(pageNo != 1) {
 		  pageBar += "<li style='display:inline-block; width:70px; font-size:12pt;'><a href='"+url+"&searchType="+searchType+"&searchWord="+searchWord+"&currentShowPageNo=1'>[맨처음]</a></li>";
 		  pageBar += "<li style='display:inline-block; width:50px; font-size:12pt;'><a href='"+url+"&searchType="+searchType+"&searchWord="+searchWord+"&currentShowPageNo="+(pageNo-1)+"'>[이전]</a></li>";
 	  }
 	  
 	  while(!(loop > blockSize || pageNo > totalPage )) {
 		
 		  if(pageNo == currentShowPageNo) {
 			  pageBar += "<li style='display:inline-block; width:30px; font-size:12pt; background-color: #F2F2F2; border-radius: 15px; color:red; padding:2px 4px;'>"+pageNo+"</li>";
 		  }
 		  else {
 			  pageBar += "<li style='display:inline-block; width:30px; font-size:12pt;'><a href='"+url+"&searchType="+searchType+"&searchWord="+searchWord+"&currentShowPageNo="+pageNo+"'>"+pageNo+"</a></li>";
 		  }
 		  
 		  loop++;
 		  pageNo++;
 	  }// end of while----------------------------------
 	  
 	  // === [다음][마지막] 만들기 ===
 	  if(pageNo <= totalPage) {
 		  pageBar += "<li style='display:inline-block; width:50px; font-size:12pt;'><a href='"+url+"&searchType="+searchType+"&searchWord="+searchWord+"&currentShowPageNo="+pageNo+"'>[다음]</a></li>";
 		  pageBar += "<li style='display:inline-block; width:70px; font-size:12pt;'><a href='"+url+"&searchType="+searchType+"&searchWord="+searchWord+"&currentShowPageNo="+totalPage+"'>[마지막]</a></li>";
 	  }
 	  
 	  pageBar += "</ul>";
 	  
 	  mav.addObject("pageBar", pageBar);
 	  
 	  String gobackURL = MyUtil.getCurrentURL(request);

 	  mav.addObject("gobackURL", gobackURL);
 	  mav.addObject("myAddrlist", myAddrlist);
 	  mav.setViewName("addrlist/myAddrlist.tiles1");
 	 
 	  return mav;
   }
   
   // === 주소록 그룹 내 검색 === //
   @ResponseBody
   @RequestMapping(value="/mywordSearchShow.opis", produces="text/plain;charset=UTF-8")
   public String mywordSearchShow(HttpServletRequest request) {
	   
 	  String searchType = request.getParameter("searchType");
 	  String searchWord = request.getParameter("searchWord");
 	  String addrgroup_seq = request.getParameter("addrgroup_seq");

// 	  System.out.println("확인용 : "+addrgroup_seq);
 	  
 	  
 	  Map<String,String> paraMap = new HashMap<>();
 	  paraMap.put("searchType", searchType);
 	  paraMap.put("searchWord", searchWord);	
 	  paraMap.put("addrgroup_seq", addrgroup_seq);
  	  
 	  List<String> mywordList = service.mywordSearchShow(paraMap);
 	  
 	  JSONArray jsonArr = new JSONArray();
 	  
 	  if(mywordList != null) {
 		  for(String word : mywordList) {
 			  JSONObject jsonObj = new JSONObject();
 			  jsonObj.put("word", word); 
 			  
 			  jsonArr.put(jsonObj);
 		  }
 	  }
 	  
 	  return jsonArr.toString();
   }
   
   //=== 개인 주소록에서 삭제 === //
   @RequestMapping(value="/delmyAddr.opis")
   public ModelAndView delmyAddr(HttpServletRequest request, AddrVO addrvo, ModelAndView mav) {
   	
	   String[] checkAddrSeq = request.getParameterValues("checkAddrSeq");
	   String[] addrSeqArr = checkAddrSeq[0].toString().split(","); // 가져온 addr_seq 분리해서 배열에 담기
	   int checkCnt = Integer.parseInt(request.getParameter("checkCnt")); // 총 체크개수 가져오기
	   String addrgroup_seq = request.getParameter("addrgroup_seq"); // 선택한 주소록 그룹 번호 가져오기

 	   int n = 0,i = 0;
 	   for(i=0; i<checkCnt; i++) { // 선택한 주소록 번호 맵에 넣고 추가하기
 		   int addr_seq = Integer.parseInt(addrSeqArr[i]);
 		   
 		   addrvo.setAddr_seq(addr_seq);
   		   n = service.delmyAddr(addrvo);
 	   }
 	   
// 	   System.out.println("확인용 N : "+n+"확인용 i :"+i+"확인용 checkCnt : "+checkCnt);
   		
	   	if(n==1 && i==checkCnt) { // n값이 1 이고 총 반복횟수가 체크개수와 같다면 성공
	   		mav.setViewName("redirect:/myAddrlist.opis?addrgroup_seq="+addrgroup_seq);  
	   	}
	   	else {
	   	    mav.setViewName("board/error/add_error.tiles1");
	   	}
	   	  
	   	return mav;
   		
   }
   
   // ============================ 개인 주소록 관리 ============================ //
   // === 주소록 목록 === //
   @RequestMapping(value="/addr_setting.opis")
   public ModelAndView requiredLogin_addrgroupList(HttpServletRequest request, HttpServletResponse response, ModelAndView mav) {

 	  List<AddrGroupVO> addrgroupList = null; 

 	  HttpSession session = request.getSession();
	  MemberVO loginuser = (MemberVO) session.getAttribute("loginuser");
	  
 	  // 로그인한 사원의 사원번호 가져오기
 	  int fk_mbr_seq = loginuser.getMbr_seq();
// 	  System.out.println("확인용: "+fk_mbr_seq);
 	  
 	  int totalCount = 0; 			// 총 게시물 건수
 	  int sizePerPage = 10;       	// 한 페이지당 보여줄 게시물 건수     	  
 	  int currentShowPageNo = 0;  	// 현재 보여주는 페이지 번호로서, 초기치로는 1페이지로 설정
 	  int totalPage = 0;          	// 총 페이지수
 	  
 	  int startRno = 0;           	// 시작 행번호
      int endRno = 0;             	// 끝 행번호 

 	  String str_currentShowPageNo = request.getParameter("currentShowPageNo");
 	  
 	  Map<String,String> paraMap = new HashMap<>();    	  

      // 총 주소록 건수(totalCount)
      totalCount = service.getAddrgroupTotalCount(paraMap);
      totalPage = (int)Math.ceil((double)totalCount/sizePerPage);	
       
 	  if(str_currentShowPageNo == null) {
 		  currentShowPageNo = 1;
 	  }
 	  else {
 		  try {
 			currentShowPageNo = Integer.parseInt(str_currentShowPageNo);
 			if(currentShowPageNo < 1 || currentShowPageNo > totalPage) {
 				currentShowPageNo = 1;
 			}
 		  } catch (NumberFormatException e) {
				currentShowPageNo = 1;
			}
 	  }

 	  startRno = ((currentShowPageNo - 1 ) * sizePerPage) + 1;
      endRno = startRno + sizePerPage - 1;
 	  
      paraMap.put("startRno", String.valueOf(startRno));
      paraMap.put("endRno", String.valueOf(endRno));
      paraMap.put("fk_mbr_seq", String.valueOf(fk_mbr_seq));
      
 	  addrgroupList = service.addrgroupListWithPaging(paraMap);
 	  // 페이징 처리한 주소록 목록 가져오기

 	  int blockSize = 5;
 	  int loop=1;
 	  
 	  int pageNo = ((currentShowPageNo - 1)/blockSize) * blockSize + 1;

 	  String pageBar = "<ul style='list-style: none;'>";
 	  String url = "addr_setting.opis";
 	  
 	  // === [맨처음][이전] 만들기 ===
 	  if(pageNo != 1) {
 		  pageBar += "<li style='display:inline-block; width:70px; font-size:12pt;'><a href='"+url+"?currentShowPageNo=1'>[맨처음]</a></li>";
 		  pageBar += "<li style='display:inline-block; width:50px; font-size:12pt;'><a href='"+url+"?currentShowPageNo="+(pageNo-1)+"'>[이전]</a></li>";
 	  }
 	  
 	  while(!(loop > blockSize || pageNo > totalPage )) {
 		
 		  if(pageNo == currentShowPageNo) {
 			  pageBar += "<li style='display:inline-block; width:30px; font-size:12pt; background-color: #F2F2F2; border-radius: 15px; color:red; padding:2px 4px;'>"+pageNo+"</li>";
 		  }
 		  else {
 			  pageBar += "<li style='display:inline-block; width:30px; font-size:12pt;'><a href='"+url+"?currentShowPageNo="+pageNo+"'>"+pageNo+"</a></li>";
 		  }
 		  
 		  loop++;
 		  pageNo++;
 	  }// end of while----------------------------------
 	  
 	  // === [다음][마지막] 만들기 ===
 	  if(pageNo <= totalPage) {
 		  pageBar += "<li style='display:inline-block; width:50px; font-size:12pt;'><a href='"+url+"?currentShowPageNo="+pageNo+"'>[다음]</a></li>";
 		  pageBar += "<li style='display:inline-block; width:70px; font-size:12pt;'><a href='"+url+"?currentShowPageNo="+totalPage+"'>[마지막]</a></li>";
 	  }
 	  
 	  pageBar += "</ul>";
 	  
 	  mav.addObject("pageBar", pageBar);
 	  
 	  String gobackURL = MyUtil.getCurrentURL(request);

 	  mav.addObject("gobackURL", gobackURL);
 	  mav.addObject("addrgroupList", addrgroupList);
 	  mav.setViewName("addrlist/addr_setting.tiles1");
 	 
 	  return mav;
   }
   
   // === 주소록 목록 추가 === //
   @ResponseBody
   @RequestMapping(value="/addAddrgroup.opis", method= {RequestMethod.POST})
   public String addAddrgroup(AddrGroupVO agvo) {
  
	  int n = 0;
	  
	  try {
		  n = service.addAddrgroup(agvo);
	  }	catch (Throwable e) {
			
	  }
	  
	  JSONObject jsonObj = new JSONObject();
	  jsonObj.put("n", n);
	  jsonObj.put("groupname", agvo.getGroupname());
	  
	  return jsonObj.toString();
   }
   
   // === 주소록 목록 삭제  === // 
   @RequestMapping(value="/addrgroup_delEnd.opis", method= {RequestMethod.GET})
   public ModelAndView addrgroup_delEnd(ModelAndView mav, HttpServletRequest request) {
 	  
 	  // 삭제해야 할 주소록 번호 가져오기
 	  String addrgroup_seq = request.getParameter("addrgroup_seq");
       
       Map<String,String> paraMap = new HashMap<>();
       paraMap.put("addrgroup_seq", addrgroup_seq);
       
       int n = service.delAddrgroup(paraMap); 
       // n 이 1 이라면 정상적으로 삭제, n 이 0 이라면 글삭제 실패
       
       if(n == 0) {
           mav.addObject("message", "삭제를 실패했습니다.");
           mav.addObject("loc", request.getContextPath()+"/addr_setting.opis");
       }
       else {
          mav.addObject("message", "성공적으로 삭제했습니다.");
          mav.addObject("loc", request.getContextPath()+"/addr_setting.opis");
       }
       
       mav.setViewName("msg");

       return mav;
   }
   
}