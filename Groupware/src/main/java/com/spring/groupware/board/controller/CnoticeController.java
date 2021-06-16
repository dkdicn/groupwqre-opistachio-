package com.spring.groupware.board.controller;

import java.io.IOException;
import java.io.PrintWriter;
import java.util.*;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.json.JSONArray;
import org.json.JSONObject;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.ExceptionHandler;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import com.spring.groupware.board.model.CnoticeVO;
import com.spring.groupware.board.service.InterCnoticeService;
import com.spring.groupware.common.MyUtil;
import com.spring.groupware.member.model.MemberVO;

@Controller
public class CnoticeController {

   @Autowired // Type에 따라 알아서 Bean 을 주입해준다.
   private InterCnoticeService service;
      
      // === 게시판 글쓰기 폼 페이지 요청 === //
      @RequestMapping(value="/add.opis")
      public ModelAndView requiredLogin_add(HttpServletRequest request, HttpServletResponse response, ModelAndView mav) {
//      public ModelAndView add(HttpServletRequest request, HttpServletResponse response, ModelAndView mav) {
    	  
    	  mav.setViewName("board/add.tiles1");
    	  
    	  return mav;
      }
      
      
      // === 게시판 글쓰기 폼 페이지 요청 === //
      @RequestMapping(value="/cnotice_addEnd.opis", method= {RequestMethod.POST})
      public ModelAndView addEnd(HttpServletRequest request, ModelAndView mav, CnoticeVO cnoticevo) {
    	  
    	  String ctitle = request.getParameter("title");
    	  String ccontent = request.getParameter("content");
    	  
    	  cnoticevo.setCtitle(ctitle);
    	  cnoticevo.setCcontent(ccontent);
    	  
    	  int n = service.add(cnoticevo); // <== 파일첨부가 없는 글쓰기
    	  
    	  if(n==1) {
    		  mav.setViewName("redirect:/cnotice_list.opis");
    		  
    	  }
    	  else {
    		  mav.setViewName("board/error/add_error.tiles1");
    	  }
    	  
    	  return mav;
      }
  
      
      // === 글목록 보기 페이지 요청 === //
      @RequestMapping(value="/cnotice_list.opis")
      public ModelAndView list(ModelAndView mav, HttpServletRequest request) {

    	  List<CnoticeVO> boardList = null; 
    	  
    	  HttpSession session = request.getSession();
    	  session.setAttribute("readCountPermission", "yes");

    	  
    	  String searchType = request.getParameter("searchType");
    	  String searchWord = request.getParameter("searchWord");    	  
    	  String str_currentShowPageNo = request.getParameter("currentShowPageNo");
    	  
    	  if(searchType == null || (!"ctitle".contentEquals(searchType)) ) {
    		  searchType="";
    	  }
    	  
    	  if(searchWord == null || "".equals(searchWord) || searchWord.trim().isEmpty()) {
    		  searchWord="";
    	  }
    	  
    	  Map<String,String> paraMap = new HashMap<>();    	  
    	  paraMap.put("searchType", searchType);
    	  paraMap.put("searchWord", searchWord);
    	  
    	  int totalCount = 0; 			// 총 게시물 건수
    	  int sizePerPage = 10;       	// 한 페이지당 보여줄 게시물 건수     	  
    	  int currentShowPageNo = 0;  	// 현재 보여주는 페이지 번호로서, 초기치로는 1페이지로 설정
    	  int totalPage = 0;          	// 총 페이지수
    	  
    	  int startRno = 0;           	// 시작 행번호
          int endRno = 0;             	// 끝 행번호 
          
          // 총 게시물 건수(totalCount)
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
          
    	  boardList = service.boardListSearchWithPaging(paraMap);
    	  // 페이징 처리한 글목록 가져오기(검색이 있든지, 검색이 없든지 모두 다 포함한 것)
  	  
    	  // 검색대상 컬럼과 검색어 유지
    	  if(!"".equals(searchType) && !"".equals(searchWord)) {
    		  mav.addObject("paraMap", paraMap);
    	  }

    	  int blockSize = 5;
    	  int loop=1;
    	  
    	  int pageNo = ((currentShowPageNo - 1)/blockSize) * blockSize + 1;

    	  String pageBar = "<ul style='list-style: none;'>";
    	  String url = "cnotice_list.opis";
    	  
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
    	  mav.addObject("boardList", boardList);
    	  mav.setViewName("board/cnotice_list.tiles1");
    	 
    	  return mav;
      }
      
      // === 글1개를 보여주는 페이지 요청 === //
      @RequestMapping(value="/cnotice_view.opis")
      public ModelAndView requiredLogin_view(HttpServletRequest request, HttpServletResponse response, ModelAndView mav) {
    	  
    	  // 조회하고자 하는 글번호 받아오기
    	  String cnotice_seq = request.getParameter("cnotice_seq");
    	  
    	  String login_mbrid = null;
    	  
    	  HttpSession session = request.getSession();
    	  MemberVO loginuser = (MemberVO) session.getAttribute("loginuser");
    	  
    	  if(loginuser != null) {
    		  login_mbrid = loginuser.getMbr_id();
    	  }   	  
    	  
    	  CnoticeVO cnoticevo = null;
    	  
    	  if("yes".equals(session.getAttribute("readCountPermission"))) {// 글목록보기를 클릭한 다음에 특정글을 조회해온 경우
    		
    		  cnoticevo = service.getView(cnotice_seq, login_mbrid);
        	  // 글조회수 증가와 함께 글1개를 조회
        	  
    		  session.removeAttribute("readCountPermission");
    		  // session 에 저장된 readCountPermission 을 삭제
    	  }
    	  else {// 웹브라우저에서 새로고침(F5)을 클릭한 경우    		  
    		  cnoticevo = service.getViewWithNoAddCount(cnotice_seq);
    		  // 글조회수 증가는 없고 단순히 글1개 조회만을 해주는 것이다.
    	  }
    	  
    	  mav.addObject("cnoticevo", cnoticevo);
    	  mav.setViewName("board/cnotice_view.tiles1");
    	  
    	  return mav;
      }

      @ExceptionHandler(java.lang.Throwable.class)
      public void handleThrowable(Throwable e, HttpServletRequest request, HttpServletResponse response) {
         
         try {
            response.setContentType("text/html; charset=UTF-8");
            
            PrintWriter out = response.getWriter();
            
            out.println("<html>");
            out.println("<head><title>오류메시지 출력하기</title></head>");
            out.println("<body>");
            out.println("<h1>오류발생</h1>");
            out.printf("<div><span style='font-weight: bold;'>오류메시지</span><br><span style='color: red;'>%s</span></div>", e.getMessage());
            out.printf("<div style='margin: 20px; color: blue; font-weight: bold; font-size: 26pt;'>%s</div>", "장난금지");
            out.println("<a href='/groupware/index.opis'>홈페이지로 가기</a>");
            out.println("</body>");
            out.println("</html>");
            

         } catch (IOException e1) {
            e1.printStackTrace();
         }
         
      }
      
      // === 글수정 페이지 요청 === //
      @RequestMapping(value="/cnotice_edit.opis")
      public ModelAndView requiredLogin_edit(HttpServletRequest request, HttpServletResponse response, ModelAndView mav) {
//      public ModelAndView edit(HttpServletRequest request, HttpServletResponse response, ModelAndView mav) {

    	  // 수정해야 할 글번호 가져오기
    	  String cnotice_seq = request.getParameter("cnotice_seq");
    	  
    	  // 글조회수(readCount) 증가 없이 단순히 글1개만 조회 해주는 것이다.
    	  CnoticeVO cnoticevo = service.getViewWithNoAddCount(cnotice_seq);

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
        	 // 관리자가 수정할 경우
        	 mav.addObject("cnoticevo", cnoticevo);
        	 mav.setViewName("board/cnotice_edit.tiles1");
   
          }
    	  return mav;
      }
      
      // === 글 수정 페이지 완료하기 === //
      @RequestMapping(value="/cnotice_editEnd.opis", method= {RequestMethod.POST})
      public ModelAndView editEnd(ModelAndView mav, CnoticeVO cnoticevo, HttpServletRequest request) {
    	  
    	  int n = service.edit(cnoticevo);
    	  // n 이 1 이라면 정상적으로 변경됨, n 이 0 이라면 글수정에 필요한 글암호가 틀린경우 
    	  
    	  if(n == 0) {
	         mav.addObject("message", "글 수정을 실패했습니다.");
	      }
	      else {
	         mav.addObject("message", "글을 성공적으로 수정했습니다.");
	      }
	  
          mav.addObject("loc", request.getContextPath()+"/cnotice_view.opis?cnotice_seq="+cnoticevo.getCnotice_seq());
          mav.setViewName("msg");
    	  
          return mav;
      }

      // === 글 삭제  === // 
      @RequestMapping(value="/cnotice_delEnd.opis", method= {RequestMethod.GET})
      public ModelAndView delEnd(ModelAndView mav, HttpServletRequest request) {
    	  
    	  // 삭제해야 할 글번호 가져오기
    	  String cnotice_seq = request.getParameter("cnotice_seq");
          
          Map<String,String> paraMap = new HashMap<>();
          paraMap.put("cnotice_seq", cnotice_seq);
          
          int n = service.del(paraMap); 
          // n 이 1 이라면 정상적으로 삭제, n 이 0 이라면 글삭제 실패
          
          if(n == 0) {
              mav.addObject("message", "글 삭제를 실패했습니다.");
              mav.addObject("loc", request.getContextPath()+"/cnotice_view.opis?cnotice_seq="+cnotice_seq);
          }
          else {
             mav.addObject("message", "글을 성공적으로 삭제했습니다.");
             mav.addObject("loc", request.getContextPath()+"/cnotice_list.opis");
          }
          
          mav.setViewName("msg");

          return mav;
      }
      
      // === 글 검색 === //
      @ResponseBody
      @RequestMapping(value="/cwordSearchShow.opis", produces="text/plain;charset=UTF-8")
      public String wordSearchShow(HttpServletRequest request) {
    	  String searchType = request.getParameter("searchType");
    	  String searchWord = request.getParameter("searchWord");
    	  
    	  Map<String,String> paraMap = new HashMap<>();
    	  paraMap.put("searchType",searchType);
    	  paraMap.put("searchWord",searchWord);
    	  
    	  List<String> wordList = service.wordSearchShow(paraMap);
    	  
    	  JSONArray jsonArr = new JSONArray(); // []
    	  
    	  if(wordList != null) {
    		  for(String word : wordList) {
    			  JSONObject jsonObj = new JSONObject();
    			  jsonObj.put("word", word); // 
    			  
    			  jsonArr.put(jsonObj);
    		  }
    	  }
    	  
    	  return jsonArr.toString();
      }
}