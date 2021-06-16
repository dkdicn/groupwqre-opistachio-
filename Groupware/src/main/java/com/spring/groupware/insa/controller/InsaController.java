package com.spring.groupware.insa.controller;

import static org.springframework.test.web.servlet.result.MockMvcResultMatchers.status;

import java.io.UnsupportedEncodingException;
import java.net.URLEncoder;
import java.security.GeneralSecurityException;
import java.security.NoSuchAlgorithmException;
import java.sql.SQLException;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;

import org.json.JSONArray;
import org.json.JSONObject;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.bind.annotation.RestController;
import org.springframework.web.servlet.ModelAndView;
import com.spring.groupware.insa.service.InterInsaService;
import com.spring.groupware.common.AES256;
import com.spring.groupware.common.MyUtil;
import com.spring.groupware.insa.model.CertiVO;
import com.spring.groupware.insa.model.EduVO;
import com.spring.groupware.insa.model.InsaVO;
import com.spring.groupware.insa.model.PayInfoVO;
import com.spring.groupware.insa.model.PaymentVO;
@Component
@RestController
public class InsaController { 
		@Autowired   // Type에 따라 알아서 Bean 을 주입해준다.
		private InterInsaService service;

		// 암호화 하기
		@Autowired
		private AES256 aes;

	   // === insa 페이지 요청 === //
	   @RequestMapping(value="/insa.opis")
	   public ModelAndView insa(ModelAndView mav, HttpServletRequest request) {
	      String category = request.getParameter("category");

	       String searchType = request.getParameter("searchType");
	       String searchWord = request.getParameter("searchWord");

		   String str_currentShowPageNo = request.getParameter("currentShowPageNo");

	       if(category == null) {
	          category="6";
	       }
	       if(searchType == null) {
	    	   searchType="";
		       }
	       if(searchWord == null) {
	    	   searchWord="";
		       }
	       
	       Map<String,String> paraMap = new HashMap<>();
	       paraMap.put("category", category);
	       paraMap.put("searchType", searchType);
	       paraMap.put("searchWord", searchWord);
	       
	      

		// 먼저 총 게시물 건수(totalCount)를 구해와야 한다.
			// 총 게시물 건수(totalCount)는 검색조건이 있을때와 없을때로 나뉘어진다.
			int totalCount = 0;         // 총 게시물 건수
			int sizePerPage = 10;       // 한 페이지당 보여줄 게시물 건수
			int currentShowPageNo = 0;  // 현재 보여주는 페이지 번호로서, 초기치로는 1페이지로 설정함.
			int totalPage = 0;          // 총 페이지수(웹브라우저상에서 보여줄 총 페이지 개수, 페이지바)  
			
			int startRno = 0;           // 시작 행번호
			int endRno = 0;             // 끝 행번호 
			
			// 총 게시물 건수(totalCount)
			totalCount = service.getTotalCount(paraMap);
		//	System.out.println("~~~~ 확인용 totalCount : " + totalCount);
			
			// 만약에 총 게시물 건수(totalCount)가 127개 이라면 
			// 총 페이지수(totalPage)는 13개가 되어야 한다.
			
			totalPage = (int) Math.ceil( (double)totalCount/sizePerPage ); 
			// (double)127/10 ==> 12.7 ==> Math.ceil(12.7) ==> 13.0 ==> (int)13.0 ==> 13
			// (double)120/10 ==> 12.0 ==> Math.ceil(12.0) ==> 12.0 ==> (int)12.0 ==> 12
			
			
			if(str_currentShowPageNo == null) {
				// 게시판에 보여지는 초기화면 
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
			
			
			// **** 가져올 게시글의 범위를 구한다.(공식임!!!) **** 
			/*
			     currentShowPageNo      startRno     endRno
			    --------------------------------------------
			         1 page        ===>     1          10
			         2 page        ===>    11          20
			         3 page        ===>    21          30
			         4 page        ===>    31          40
			         ......                ...         ...
			 */
			
			startRno = ((currentShowPageNo - 1 ) * sizePerPage) + 1;
			endRno = startRno + sizePerPage - 1;
			paraMap.put("startRno", String.valueOf(startRno));
			paraMap.put("endRno", String.valueOf(endRno));
			
		    List <InsaVO> insaList = service.getInsaList(paraMap);
			// 페이징 처리한 글목록 가져오기(검색이 있든지, 검색이 없든지 모두 다 포함한것)
					
			// 아래는 검색대상 컬럼과 검색어를 유지시키기 위한 것임.
			if(!"".equals(searchType) && !"".equals(searchWord)) {
				mav.addObject("paraMap", paraMap);
			}
			
			
			// === #121. 페이지바 만들기 === //
			int blockSize = 4;
		//	int blockSize = 3;
			// blockSize 는 1개 블럭(토막)당 보여지는 페이지번호의 개수 이다.
			/*
			                1  2  3  4  5  6  7  8  9  10 [다음][마지막]  -- 1개블럭
			  [맨처음][이전]  11 12 13 14 15 16 17 18 19 20 [다음][마지막]  -- 1개블럭
			  [맨처음][이전]  21 22 23
			*/
			
			int loop = 1;
			/*
		    	loop는 1부터 증가하여 1개 블럭을 이루는 페이지번호의 개수[ 지금은 10개(== blockSize) ] 까지만 증가하는 용도이다.
		    */
			
			int pageNo = ((currentShowPageNo - 1)/blockSize) * blockSize + 1;
			// *** !! 공식이다. !! *** //
		
			String pageBar = "<ul style='list-style: none;'>";
			String url = "insa.opis";
			// === [맨처음][이전] 만들기 === 
			if(pageNo != 1) {
				pageBar += "<li style='display:inline-block; width:70px; font-size:12pt;'><a href='"+url+"?searchType="+searchType+"&searchWord="+searchWord+"&category="+category+"&currentShowPageNo=1'>[맨처음]</a></li>";
				pageBar += "<li style='display:inline-block; width:50px; font-size:12pt;'><a href='"+url+"?searchType="+searchType+"&searchWord="+searchWord+"&category="+category+"&currentShowPageNo="+(pageNo-1)+"'>[이전]</a></li>";
			}
			
			while( !(loop > blockSize || pageNo > totalPage) ) {
				
				if(pageNo == currentShowPageNo) {
					pageBar += "<li style='display:inline-block; width:30px; font-size:12pt; border:solid 1px gray; color:red; padding:2px 4px;'>"+pageNo+"</li>";
				}
				else {
					pageBar += "<li style='display:inline-block; width:30px; font-size:12pt;'><a href='"+url+"?searchType="+searchType+"&searchWord="+searchWord+"&category="+category+"&currentShowPageNo="+pageNo+"'>"+pageNo+"</a></li>";
				}
				
				loop++;
				pageNo++;
			}// end of while------------------------
			
			
			// === [다음][마지막] 만들기 === 
			if(pageNo <= totalPage) {
				pageBar += "<li style='display:inline-block; width:50px; font-size:12pt;'><a href='"+url+"?searchType="+searchType+"&searchWord="+searchWord+"&category="+category+"&currentShowPageNo="+pageNo+"'>[다음]</a></li>";
				pageBar += "<li style='display:inline-block; width:70px; font-size:12pt;'><a href='"+url+"?searchType="+searchType+"&searchWord="+searchWord+"&category="+category+"&currentShowPageNo="+totalPage+"'>[마지막]</a></li>";
			}
			
			pageBar += "</ul>";
			
			mav.addObject("pageBar",pageBar);
					
			// === #123. 페이징 처리되어진 후 특정 글제목을 클릭하여 상세내용을 본 이후
			//           사용자가 목록보기 버튼을 클릭했을때 돌아갈 페이지를 알려주기 위해
			//           현재 페이지 주소를 뷰단으로 넘겨준다.
			String gobackURL = MyUtil.getCurrentURL(request);
		//	System.out.println("~~~ 확인용 gobackURL : " + gobackURL);
			// ~~~ 확인용 gobackURL : list.action?searchType=subject&searchWord=java&currentShowPageNo=2 
			mav.addObject("gobackURL", gobackURL);
			
			// ==== 페이징 처리를 한 검색어가 있는 전체 글목록 보여주기 끝 ==== //
			/////////////////////////////////////////////////////////
			
			  mav.addObject("insaList", insaList);
		      mav.addObject("category", category);
		      mav.addObject("searchType", searchType);
		      mav.addObject("searchWord", searchWord);
		      mav.setViewName("insa/insa.tiles1");
		      
		      return mav;
	   }
	   
	   
	   
	   
	   
	   
	   
	   
	   // === insa 등록페이지 요청 === //
	   @RequestMapping(value="/insaRegister1.opis")
	   public ModelAndView insaRegister1(ModelAndView mav) {


	      mav.setViewName("insa/insaRegister1.tiles1");
	      return mav;
	   }
	   // === insa1 등록완료페이지 요청 === //
	   @RequestMapping(value="/insaRegister1End.opis", method= {RequestMethod.POST})
	   public ModelAndView insaRegister1End(ModelAndView mav, HttpServletRequest request, InsaVO insavo) throws Exception{
	   //   System.out.println("인사끝");
		   
		   int seq = service.getSequence();
		      insavo.setMbr_seq(seq);
		      insavo.setMbr_pwd( aes.encrypt(insavo.getMbr_pwd()) );
		      
		   int n = service.insaRegister1End(insavo);


		      if(n==1) {
		   //      System.out.println("등록성공");
		         mav.setViewName("redirect:/insaView1.opis?seq="+seq);
		      }
		      else {
		      //   System.out.println("n => "+n);
		      //   System.out.println("등록실패");
		         mav.setViewName("insa/insa.tiles1");
		      }

		      return mav;
		   }


		// === insa2 등록페이지 요청 === //
		   @RequestMapping(value="/insaRegister2.opis")
		   public ModelAndView insaRegister2(ModelAndView mav, HttpServletRequest request) {

		       String category = request.getParameter("category");
		       String seq = request.getParameter("seq");
		       String searchType = request.getParameter("searchType");
		       String searchWord = request.getParameter("searchWord");
		       
		      String insaType = request.getParameter("insaType");
		      String maxEduLevel = String.valueOf(service.getMaxEduLevel(seq));

		      System.out.println("항 => "+seq);

		      if(maxEduLevel != "7") {
			      List<EduVO> eduList = service.getEduList(seq);
			      mav.addObject("eduList", eduList);
		      }
		      
		      
		      List<CertiVO> certiList = service.getCertiList(seq);

		      mav.addObject("insaType", insaType);
		      mav.addObject("certiList", certiList);
		      mav.addObject("maxEduLevel", maxEduLevel);

   		      mav.addObject("seq", seq);
		      mav.addObject("category", category);
		      mav.addObject("searchType", searchType);
		      mav.addObject("searchWord", searchWord);

		      mav.setViewName("insa/insaRegister2.tiles1");
		      return mav;
		   }


		   // === insa2  학력 등록완료페이지 요청 === //
		   @RequestMapping(value="/insaRegister2EduEnd.opis", method= {RequestMethod.POST})
		   public ModelAndView insaRegister2EduEnd(ModelAndView mav, HttpServletRequest request,EduVO evo ) {
			   
			   String category = request.getParameter("category");
		       String seq = request.getParameter("seq");
		       String searchType = request.getParameter("searchType");
		       String searchWord = request.getParameter("searchWord");
		       
		       
		       if(category == null) {
		          category="6";
		       }
		       if(seq == "") {
			          seq="0";
			       }
		       if(searchType == null) {
		    	   searchType="";
			       }
		       if(searchWord == null) {
		    	   searchWord="";
			       }
			      

			         evo.setMbr_seq(Integer.parseInt(seq));
			         
			         // 학력번호 가져오기
			         int edu_seq = service.getEduSeq();
			         evo.setEdu_seq(edu_seq);
			         

		 			String encodedParam = "";
		 			try {
						encodedParam = URLEncoder.encode(searchWord, "UTF-8");
					} catch (UnsupportedEncodingException e) {
						e.printStackTrace();
					}      
			         // 학력정보 입력하기
			         int n = service.insaRegister2EndEdu(evo);
			         if(n==1) { 
				          System.out.println("등록성공");   
				            List<EduVO> eduList = service.getEduList(seq);
				            List<CertiVO> certiList = service.getCertiList(seq);
				            String maxEduLevel = String.valueOf(service.getMaxEduLevel(seq));

				            mav.addObject("eduList", eduList);
				            mav.addObject("maxEduLevel", maxEduLevel);
				            mav.addObject("certiList", certiList);
						    mav.addObject("seq", seq);
						    mav.addObject("category", category);
						    mav.addObject("searchType", searchType);
						    mav.addObject("searchWord", encodedParam);
						    mav.setViewName("redirect:/insaView2.opis");
							   

				       } 
				       else {
				          System.out.println("등록실패");

					      mav.addObject("seq", seq);
					      mav.addObject("category", category);
					      mav.addObject("searchType", searchType);
					      mav.addObject("searchWord", searchWord);
						    mav.setViewName("redirect:/insa.opis");
				          }
			
			      return mav;
			   }


		   // === insa2 자격증 등록완료페이지 요청 === //
		      @RequestMapping(value="/insaRegister2CertiEnd.opis", method= {RequestMethod.POST})
		      public ModelAndView insaRegister2CertiEnd(ModelAndView mav, HttpServletRequest request, CertiVO cvo) {
		
		    	  String category = request.getParameter("category");
			       String seq = request.getParameter("seq");
			       String searchType = request.getParameter("searchType");
			       String searchWord = request.getParameter("searchWord");
			       
			       
			       if(category == null) {
			          category="6";
			       }
			       if(seq == "") {
				          seq="0";
				       }
			       if(searchType == null) {
			    	   searchType="";
				       }
			       if(searchWord == null) {
			    	   searchWord="";
				       }
			       

		               cvo.setMbr_seq(Integer.parseInt(seq));

		               // 자격증번호 가져오기
				         int certi_seq = service.getCertiSeq();
				         cvo.setCerti_seq(certi_seq);
				         
		               
		               // 자격증정보 입력하기
		               int m = service.insaRegister2EndCerti(cvo);



		             if(m==1) { 
		                System.out.println("등록성공"); 
		                  List<EduVO> eduList = service.getEduList(seq);
		                  
		                  List<CertiVO> certiList = service.getCertiList(seq);
		                  String maxEduLevel = String.valueOf(service.getMaxEduLevel(seq));



		                  mav.addObject("eduList", eduList);
		                  mav.addObject("maxEduLevel", maxEduLevel);
		                  mav.addObject("certiList", certiList);
			   		      mav.addObject("seq", seq);
					      mav.addObject("category", category);
					      mav.addObject("searchType", searchType);
					      mav.addObject("searchWord", searchWord);
						    mav.setViewName("redirect:/insaView2.opis");
		             } 
		             else {
		                System.out.println("등록실패");

		  		      mav.addObject("seq", seq);
		  		      mav.addObject("category", category);
		  		      mav.addObject("searchType", searchType);
		  		      mav.addObject("searchWord", searchWord); 
					    mav.setViewName("redirect:/insa.opis");
		                }

		         return mav;
		      }



			   // === insa view1페이지 요청 === //
			   @RequestMapping(value="/insaView1.opis")
			   public ModelAndView insaView1(ModelAndView mav, HttpServletRequest request) throws Exception {
			       String category = request.getParameter("category");
			       String seq = request.getParameter("seq");
			       String searchType = request.getParameter("searchType");
			       String searchWord = request.getParameter("searchWord");
			       
			      InsaVO insavo = service.getInsaView1(seq);


			       if(category == null) {
			          category="6";
			       }
			       if(searchType == null) {
			    	   searchType="";
				       }
			       if(searchWord == null) {
			    	   searchWord="";
				       }
			      insavo.setMbr_pwd( aes.decrypt(insavo.getMbr_pwd()) );
			      mav.addObject("insavo", insavo);
	   		      mav.addObject("seq", seq);
			      mav.addObject("category", category);
			      mav.addObject("searchType", searchType);
			      mav.addObject("searchWord", searchWord);
			      mav.setViewName("insa/insaView1.tiles1");
			      return mav;
			   }
			   
			   
			// === insa2 학력 삭제 요청 === //
			   @RequestMapping(value="/insaEduDel.opis")
			   public ModelAndView insaEduDel(ModelAndView mav, HttpServletRequest request) {
				   		
				   String edu_seq = request.getParameter("edu_seq");

			       String category = request.getParameter("category");
			       String seq = request.getParameter("seq");
			       String searchType = request.getParameter("searchType");
			       String searchWord = request.getParameter("searchWord");
			       
				   
				   // 학력 삭제하기
				   int n = service.insaEduDel(edu_seq);
			   
				   

		 			String encodedParam = "";
		 			try {
						encodedParam = URLEncoder.encode(searchWord, "UTF-8");
					} catch (UnsupportedEncodingException e) {
						e.printStackTrace();
					}
				   
				   if(n==1) {
					  System.out.println("삭제성공");
				         mav.setViewName("redirect:/insaView2.opis?seq="+seq+"&category="+category+"&searchType="+searchType+"&searchWord="+ encodedParam);
				   }
				   else {
					  System.out.println("삭제실패");
				         mav.setViewName("redirect:/insaView2.opis?seq="+seq+"&category="+category+"&searchType="+searchType+"&searchWord="+ encodedParam);
				   }
				   
				   return mav;
			   }

			   
			   
			// === insa2 자격증 삭제 요청 === //
			   @RequestMapping(value="/insaCertiDel.opis")
			   public ModelAndView insaCertiDel(ModelAndView mav, HttpServletRequest request) {
				   		
				   String certi_seq = request.getParameter("certi_seq");

			       String category = request.getParameter("category");
			       String seq = request.getParameter("seq");
			       String searchType = request.getParameter("searchType");
			       String searchWord = request.getParameter("searchWord");
			       
				   
				   // 자격증 삭제하기
				   int n = service.insaCertiDel(certi_seq);
			   

		 			String encodedParam = "";
		 			try {
						encodedParam = URLEncoder.encode(searchWord, "UTF-8");
					} catch (UnsupportedEncodingException e) {
						e.printStackTrace();
					}
				   
				   if(n==1) {
					  System.out.println("삭제성공");
				         mav.setViewName("redirect:/insaView2.opis?seq="+seq+"&category="+category+"&searchType="+searchType+"&searchWord="+ encodedParam);
				   }
				   else {
					  System.out.println("삭제실패");
				         mav.setViewName("redirect:/insaView2.opis?seq="+seq+"&category="+category+"&searchType="+searchType+"&searchWord="+ encodedParam);
				   }
				   
				   return mav;
			   }
				   
			   
			   // === insa view2페이지 요청 === //
			   @RequestMapping(value="/insaView2.opis")
			   public ModelAndView insaView2(ModelAndView mav, HttpServletRequest request) {
			       String category = request.getParameter("category");
			       String seq = request.getParameter("seq");
			       String searchType = request.getParameter("searchType");
			       String searchWord = request.getParameter("searchWord");
			       

			       if(category == null) {
			          category="6";
			       }
			       if(searchType == null) {
			    	   searchType="";
				       }
			       if(searchWord == null) {
			    	   searchWord="";
				       }
			       
			       
			      // 학력 리스트 가져오기
			      List<EduVO> eduList = service.getEduList(seq);

			      // 자격증 리스트 가져오기
			      List<CertiVO> certiList = service.getCertiList(seq);
			      
			     // 학력정보 가져오기
			      int n = service.getEduNum(seq);
			      // 자격증정보 가져오기
			      int m = service.getCertiNum(seq);
			      
			      String maxEduLevel= "";
			      if(n!=0) {
				      // 최종학력 가져오기
			    	  maxEduLevel = String.valueOf(service.getMaxEduLevel(seq));
			      }
			      else {
			    	  maxEduLevel = "7"; 
			      }
			      
		  
			          mav.addObject("seq", seq);
			          mav.addObject("maxEduLevel", maxEduLevel);
			          mav.addObject("eduList", eduList);
			          mav.addObject("certiList",certiList);
				       mav.addObject("category", category);
				       mav.addObject("searchType", searchType);
				       mav.addObject("searchWord", searchWord);
			          mav.setViewName("insa/insaView2.tiles1");
			
			       return mav;
			    }



			    // === 급여 페이지 요청 === //
			    @RequestMapping(value="/payment.opis")
			    public ModelAndView payment(ModelAndView mav, HttpServletRequest request) {
			       String category = request.getParameter("category");
			       String seq = request.getParameter("seq");
			       String searchType = request.getParameter("searchType");
			       String searchWord = request.getParameter("searchWord");
			       
			       

				   String str_currentShowPageNo = request.getParameter("currentShowPageNo");

			       if(category == null) {
			          category="6";
			       }
			       if(searchType == null) {
			    	   searchType="";
				       }
			       if(searchWord == null) {
			    	   searchWord="";
				       }
			       
			       Map<String,String> paraMap = new HashMap<>();
			       paraMap.put("category", category);
			       paraMap.put("searchType", searchType);
			       paraMap.put("searchWord", searchWord);
			       
			      

				// 먼저 총 게시물 건수(totalCount)를 구해와야 한다.
					// 총 게시물 건수(totalCount)는 검색조건이 있을때와 없을때로 나뉘어진다.
					int totalCount = 0;         // 총 게시물 건수
					int sizePerPage = 10;       // 한 페이지당 보여줄 게시물 건수
					int currentShowPageNo = 0;  // 현재 보여주는 페이지 번호로서, 초기치로는 1페이지로 설정함.
					int totalPage = 0;          // 총 페이지수(웹브라우저상에서 보여줄 총 페이지 개수, 페이지바)  
					
					int startRno = 0;           // 시작 행번호
					int endRno = 0;             // 끝 행번호 
					
					// 총 게시물 건수(totalCount)
					totalCount = service.getTotalCount(paraMap);
				//	System.out.println("~~~~ 확인용 totalCount : " + totalCount);
					
					// 만약에 총 게시물 건수(totalCount)가 127개 이라면 
					// 총 페이지수(totalPage)는 13개가 되어야 한다.
					
					totalPage = (int) Math.ceil( (double)totalCount/sizePerPage ); 
					// (double)127/10 ==> 12.7 ==> Math.ceil(12.7) ==> 13.0 ==> (int)13.0 ==> 13
					// (double)120/10 ==> 12.0 ==> Math.ceil(12.0) ==> 12.0 ==> (int)12.0 ==> 12
					
					
					if(str_currentShowPageNo == null) {
						// 게시판에 보여지는 초기화면 
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
					
					
					// **** 가져올 게시글의 범위를 구한다.(공식임!!!) **** 
					/*
					     currentShowPageNo      startRno     endRno
					    --------------------------------------------
					         1 page        ===>     1          10
					         2 page        ===>    11          20
					         3 page        ===>    21          30
					         4 page        ===>    31          40
					         ......                ...         ...
					 */
					
					startRno = ((currentShowPageNo - 1 ) * sizePerPage) + 1;
					endRno = startRno + sizePerPage - 1;
					paraMap.put("startRno", String.valueOf(startRno));
					paraMap.put("endRno", String.valueOf(endRno));
					
				    List <InsaVO> insaList = service.getInsaList(paraMap);
					// 페이징 처리한 글목록 가져오기(검색이 있든지, 검색이 없든지 모두 다 포함한것)
							
					// 아래는 검색대상 컬럼과 검색어를 유지시키기 위한 것임.
					if(!"".equals(searchType) && !"".equals(searchWord)) {
						mav.addObject("paraMap", paraMap);
					}
					
					
					// === #121. 페이지바 만들기 === //
					int blockSize = 3;
				//	int blockSize = 3;
					// blockSize 는 1개 블럭(토막)당 보여지는 페이지번호의 개수 이다.
					/*
					                1  2  3  4  5  6  7  8  9  10 [다음][마지막]  -- 1개블럭
					  [맨처음][이전]  11 12 13 14 15 16 17 18 19 20 [다음][마지막]  -- 1개블럭
					  [맨처음][이전]  21 22 23
					*/
					
					int loop = 1;
					/*
				    	loop는 1부터 증가하여 1개 블럭을 이루는 페이지번호의 개수[ 지금은 10개(== blockSize) ] 까지만 증가하는 용도이다.
				    */
					
					int pageNo = ((currentShowPageNo - 1)/blockSize) * blockSize + 1;
					// *** !! 공식이다. !! *** //
				
					String pageBar = "<ul style='list-style: none;'>";
					String url = "payment.opis";
					// === [맨처음][이전] 만들기 === 
					if(pageNo != 1) {
						pageBar += "<li style='display:inline-block; width:70px; font-size:12pt;'><a href='"+url+"?searchType="+searchType+"&searchWord="+searchWord+"&category="+category+"&currentShowPageNo=1'>[맨처음]</a></li>";
						pageBar += "<li style='display:inline-block; width:50px; font-size:12pt;'><a href='"+url+"?searchType="+searchType+"&searchWord="+searchWord+"&category="+category+"&currentShowPageNo="+(pageNo-1)+"'>[이전]</a></li>";
					}
					
					while( !(loop > blockSize || pageNo > totalPage) ) {
						
						if(pageNo == currentShowPageNo) {
							pageBar += "<li style='display:inline-block; width:30px; font-size:12pt; border:solid 1px gray; color:red; padding:2px 4px;'>"+pageNo+"</li>";
						}
						else {
							pageBar += "<li style='display:inline-block; width:30px; font-size:12pt;'><a href='"+url+"?searchType="+searchType+"&searchWord="+searchWord+"&category="+category+"&currentShowPageNo="+pageNo+"'>"+pageNo+"</a></li>";
						}
						
						loop++;
						pageNo++;
					}// end of while------------------------
					
					
					// === [다음][마지막] 만들기 === 
					if(pageNo <= totalPage) {
						pageBar += "<li style='display:inline-block; width:50px; font-size:12pt;'><a href='"+url+"?searchType="+searchType+"&searchWord="+searchWord+"&category="+category+"&currentShowPageNo="+pageNo+"'>[다음]</a></li>";
						pageBar += "<li style='display:inline-block; width:70px; font-size:12pt;'><a href='"+url+"?searchType="+searchType+"&searchWord="+searchWord+"&category="+category+"&currentShowPageNo="+totalPage+"'>[마지막]</a></li>";
					}
					
					pageBar += "</ul>";
					
					mav.addObject("pageBar",pageBar);
							
					// === #123. 페이징 처리되어진 후 특정 글제목을 클릭하여 상세내용을 본 이후
					//           사용자가 목록보기 버튼을 클릭했을때 돌아갈 페이지를 알려주기 위해
					//           현재 페이지 주소를 뷰단으로 넘겨준다.
					String gobackURL = MyUtil.getCurrentURL(request);
				//	System.out.println("~~~ 확인용 gobackURL : " + gobackURL);
					// ~~~ 확인용 gobackURL : list.action?searchType=subject&searchWord=java&currentShowPageNo=2 
					mav.addObject("gobackURL", gobackURL);
					
					// ==== 페이징 처리를 한 검색어가 있는 전체 글목록 보여주기 끝 ==== //
					/////////////////////////////////////////////////////////
					
					  mav.addObject("insaList", insaList);
				      mav.addObject("category", category);
				      mav.addObject("searchType", searchType);
				      mav.addObject("searchWord", searchWord);
				      mav.setViewName("insa/payment.tiles1");
				      
				      return mav;
			    }

			// === 인사정보 수정 요청 === //
			   @RequestMapping(value="/insaModify1.opis")
			   public ModelAndView insaModify1(ModelAndView mav, HttpServletRequest request) {
				   		
			       String category = request.getParameter("category");
			       String seq = request.getParameter("seq");
			       String searchType = request.getParameter("searchType");
			       String searchWord = request.getParameter("searchWord");
			       

			       // 개인 인사정보 가져오기
			       InsaVO insavo = service.getInsaView1(seq);

			       if(category == null) {
			          category="6";
			       }
			       if(searchType == null) {
			    	   searchType="";
				       }
			       if(searchWord == null) {
			    	   searchWord="";
				       }


	   		       mav.addObject("seq", seq);
			       mav.addObject("category", category);
			       mav.addObject("searchType", searchType);
			       mav.addObject("searchWord", searchWord);

		           mav.addObject("insavo",insavo);
			       mav.setViewName("insa/insaModify.tiles1");

				   
				   
				   return mav;
			   }			    

			   
			   // === insa1 수정완료페이지 요청 === //
			   @RequestMapping(value="/insaModify1End.opis", method= {RequestMethod.POST})
			   public ModelAndView insaModify1End(ModelAndView mav, HttpServletRequest request, InsaVO insavo) throws Exception {

				   String category = request.getParameter("category");
			       String seq = request.getParameter("seq");
			       String searchType = request.getParameter("searchType");
			       String searchWord = request.getParameter("searchWord");
			       

			       if(category == null) {
			          category="6";
			       }
			       if(searchType == null) {
			    	   searchType="";
				       }
			       if(searchWord == null) {
			    	   searchWord="";
				       }
			       
			       
			       insavo.setMbr_seq(Integer.parseInt(seq));
			       if(insavo.getMbr_status() == "1") {
			    	   insavo.setMbr_retireday("");
			       }
			       
			       insavo.setMbr_pwd(aes.encrypt(insavo.getMbr_pwd()));
			       
			       // 인사정보 수정 등록하기
				      int n = service.insaModify1End(insavo);


				      if(n==1) {
				       System.out.println("수정성공");
				       	 mav.addObject("category", category);
				         mav.addObject("searchType", searchType);
				         mav.addObject("searchWord", searchWord);
				         mav.setViewName("redirect:/insaView1.opis?seq="+seq);
				      }
				      else {
				      //   System.out.println("n => "+n);
				        System.out.println("수정실패");
				         mav.setViewName("insa/insa.tiles1");
				      }

				      return mav;
				   }
			   
			   
			   
			 // === insa 학력 수정 요청 === //
		   @RequestMapping(value="/insaEduModi.opis")
		   public ModelAndView insaEduModi(ModelAndView mav, HttpServletRequest request) {
			    
			   String edu_seq = request.getParameter("edu_seq");

		       String category = request.getParameter("category");
		       String seq = request.getParameter("seq");
		       String searchType = request.getParameter("searchType");
		       String searchWord = request.getParameter("searchWord");
		       

		       String maxEduLevel = String.valueOf(service.getMaxEduLevel(seq));

		       List<EduVO> eduList = service.getEduList(seq);
		       List<CertiVO> certiList = service.getCertiList(seq);
		       
			   // 학력정보 가져오기
			   EduVO evo = service.getEduInfo(edu_seq);

		       mav.addObject("evo", evo);
	           mav.addObject("edu_seq", edu_seq);

	   		      mav.addObject("seq", seq);
			      mav.addObject("category", category);
			      mav.addObject("searchType", searchType);
			      mav.addObject("searchWord", searchWord);
	           mav.addObject("maxEduLevel", maxEduLevel);
	           mav.addObject("eduList", eduList);
	           mav.addObject("certiList",certiList);
		       mav.setViewName("insa/eduModify.tiles1");
			   
			   return mav;
		   }
			
		   
		   
		   // === insa2  학력 수정완료페이지 요청 === //
		   @RequestMapping(value="/eduModifyEnd.opis", method= {RequestMethod.POST})
		   public ModelAndView eduModifyEnd(ModelAndView mav, HttpServletRequest request) {
			   

		       String category = request.getParameter("category");
		       String seq = request.getParameter("seq");
		       String searchType = request.getParameter("searchType");
		       String searchWord = request.getParameter("searchWord");
		       
			  String edu_seq = request.getParameter("edu_seq");

		      String eduLevel= request.getParameter("eduLevel");
		      String school= request.getParameter("school");
		      String major= request.getParameter("major");
		      
		      EduVO evo = new EduVO();

		      evo.setEdu_seq(Integer.parseInt(edu_seq));
	          evo.setMbr_seq(Integer.parseInt(seq));
	          evo.setEduLevel(Integer.parseInt(eduLevel));
	          evo.setSchool(school);
	          evo.setMajor(major);

	         
	                 
	          // 학력정보 수정하기
	          int n = service.eduModify(evo);
	          if(n==1) { 
		          System.out.println("수정성공");   
		          List<EduVO> eduList = service.getEduList(seq);
		          List<CertiVO> certiList = service.getCertiList(seq);
		          String maxEduLevel = String.valueOf(service.getMaxEduLevel(seq));

		          mav.addObject("eduList", eduList);
		          mav.addObject("maxEduLevel", maxEduLevel);
		          mav.addObject("certiList", certiList);

	   		      mav.addObject("seq", seq);
			      mav.addObject("category", category);
			      mav.addObject("searchType", searchType);
			      mav.addObject("searchWord", searchWord);
		          mav.setViewName("insa/insaView2.tiles1");

		       } 
		       else {
		          System.out.println("수정실패");

	   		      mav.addObject("seq", seq);
			      mav.addObject("category", category);
			      mav.addObject("searchType", searchType);
			      mav.addObject("searchWord", searchWord);
		          mav.setViewName("insa/insa.tiles1"); 
		          }
	
			      return mav;
			   }		   

		   

		   
		    
			
				 // === insa 자격증 수정 요청 === //
			   @RequestMapping(value="/insaCertiModi.opis")
			   public ModelAndView insaCertiModi(ModelAndView mav, HttpServletRequest request) {
				    
				   String certi_seq = request.getParameter("certi_seq");

			       String category = request.getParameter("category");
			       String seq = request.getParameter("seq");
			       String searchType = request.getParameter("searchType");
			       String searchWord = request.getParameter("searchWord");
			       

			       String maxEduLevel = String.valueOf(service.getMaxEduLevel(seq));

			       List<EduVO> eduList = service.getEduList(seq);
			       List<CertiVO> certiList = service.getCertiList(seq);
			       
				   // 자격증 정보 가져오기
				   CertiVO cvo = service.getCertiInfo(certi_seq);
				   
				   String certiyy = cvo.getCertiDate().substring(0, 4);
				   String certimm = cvo.getCertiDate().substring(5, 7);
				   String certidd = cvo.getCertiDate().substring(8, 10);
				   
			       mav.addObject("cvo", cvo);
		           mav.addObject("certi_seq", certi_seq);

		   		      mav.addObject("seq", seq);
				      mav.addObject("category", category);
				      mav.addObject("searchType", searchType);
				      mav.addObject("searchWord", searchWord);
		           mav.addObject("maxEduLevel", maxEduLevel);
		           mav.addObject("certiyy", certiyy);
		           mav.addObject("certimm", certimm);
		           mav.addObject("certidd", certidd);
		           mav.addObject("eduList", eduList);
		           mav.addObject("certiList",certiList);
			       mav.setViewName("insa/certiModify.tiles1");
				   
				   return mav;
			   }
				
			   
			   
			   // === insa2  자격증 수정완료페이지 요청 === //
			   @RequestMapping(value="/certiModifyEnd.opis", method= {RequestMethod.POST})
			   public ModelAndView certiModifyEnd(ModelAndView mav, HttpServletRequest request) {
				   

			       String category = request.getParameter("category");
			       String seq = request.getParameter("seq");
			       String searchType = request.getParameter("searchType");
			       String searchWord = request.getParameter("searchWord");
			       
				  String certi_seq = request.getParameter("certi_seq");

				  String certification = request.getParameter("certification");
				  String certiLevel = request.getParameter("certiLevel");
				  String year = request.getParameter("certiyy");
	              String month = request.getParameter("certimm");
	              String day = request.getParameter("certidd");
	               
	              CertiVO cvo = new CertiVO();

	    	      cvo.setCerti_seq(Integer.parseInt(certi_seq));
	              cvo.setMbr_seq(Integer.parseInt(seq));
	              cvo.setCertification(certification);
	              cvo.setCertiLevel(certiLevel);

	              if(Integer.parseInt(month)<10) {
	                  month = "0"+month;
	              }
	              if(Integer.parseInt(day)<10) {   
	                  day = "0"+day;
	              }
	              cvo.setCertiDate(year+"-"+month+"-"+day);


		
		                 
		          // 자격증정보 수정하기
		          int n = service.certiModify(cvo);
		          if(n==1) { 
			          System.out.println("수정성공");   
			          List<EduVO> eduList = service.getEduList(seq);
			          List<CertiVO> certiList = service.getCertiList(seq);
			          String maxEduLevel = String.valueOf(service.getMaxEduLevel(seq));

			          mav.addObject("eduList", eduList);
			          mav.addObject("maxEduLevel", maxEduLevel);
			          mav.addObject("certiList", certiList);

		   		      mav.addObject("seq", seq);
				      mav.addObject("category", category);
				      mav.addObject("searchType", searchType);
				      mav.addObject("searchWord", searchWord);
			          mav.setViewName("insa/insaView2.tiles1");

			       } 
			       else {
			          System.out.println("수정실패");

		   		      mav.addObject("seq", seq);
				      mav.addObject("category", category);
				      mav.addObject("searchType", searchType);
				      mav.addObject("searchWord", searchWord);
			          mav.setViewName("insa/insa.tiles1"); 
			          }
		
				      return mav;
				   }		   
			   
			   
			   
		    // === 급여 상세 페이지 요청 === //
		    @RequestMapping(value="/paymentDetail.opis", produces = "text/plain;charset=UTF-8")
		    public ModelAndView paymentDetail(ModelAndView mav, HttpServletRequest request) {

		    	 String category = request.getParameter("category");
			       String seq = request.getParameter("seq");
			       String searchType = request.getParameter("searchType");
			       String searchWord = request.getParameter("searchWord");
			       
			       
			       if(category == null) {
			          category="6";
			       }
			       if(seq == "") {
				          seq="0";
				       }
			       if(searchType == null) {
			    	   searchType="";
				       }
			       if(searchWord == null) {
			    	   searchWord="";
				       }

		       

			   // 개인별 급여 기본급 등록하기    
		       
		       for(int i =1; i<13; i++) {
		    	   String paymonth = String.valueOf(i);
		    	   if(i<10) {
		    		   paymonth = "0"+i;
		    	   }
			       Map<String,String> paraMap = new HashMap<>();
			       paraMap.put("seq", seq);
			       paraMap.put("paymonth", paymonth);
		    	   // 기본급 등록되어있는지 알아보기
		    	   int check = service.checkPayMonthExist(paraMap);

	    		   // 개인별 월별 근무시간 가져오기
	    		   int basePay = service.getWorkHours(paraMap)*10000;
			       paraMap.put("basePay", String.valueOf(basePay));		    	   
		    	   
		    	   // 등록되어 있는 경우
		    	   if(check == 1) {
					   // 개인별 급여 기본급 수정하기  
		    		   service.updateBasePay(paraMap);
		    	   }
		    	   else if(check == 0 && basePay != 0){ // 등록 안된 경우
					   // 개인별 급여 기본급 등록하기  
		    		   service.insertBasePay(paraMap);
		    	   }
		    	   else {
		    		   
		    	   }
		       }

		       	
		       // 개인별 급여 상세 리스트 가져오기
		       List <PaymentVO> paymentList = service.getPaymentList(seq); 
		       
		       // 개인 인사정보 가져오기
		       InsaVO insavo = service.getInsaView1(seq);

		       
		       mav.addObject("paymentList", paymentList);
		       mav.addObject("insavo", insavo);
		       mav.addObject("seq", seq);
		       mav.addObject("category", category);
		       mav.addObject("searchType", searchType);
		       mav.addObject("searchWord", searchWord);

		       mav.setViewName("insa/paymentDetail.tiles1");
		       return mav;
		    }
		    

			   
		    // 개인별 급여 정보 등록 완료		 
			@ResponseBody   
		    @RequestMapping(value="/memberPayInfo.opis", method = {RequestMethod.GET }, produces = "text/plain;charset=UTF-8")
		    public String memberPayInfo(HttpServletRequest request) {
			       
			   String seq = request.getParameter("seq");
		       // 개인별 급여 정보 가져오기
		       PayInfoVO pivo = service.getPayInfo(seq);
		       // 개인별 이달 급여 정보 가져오기
		       PaymentVO pvo = service.getPayment(seq);
		       
		       // 개인별 급여 상세 리스트 가져오기
		       List <PaymentVO> paymentList = service.getPaymentList(seq);
		       
		       // 개인 인사정보 가져오기
		       InsaVO insavo = service.getInsaView1(seq);

		       JSONObject jsonObj = new JSONObject();
		       if(pivo != null) {
				   jsonObj.put("bank", pivo.getBank());
				   jsonObj.put("accountNo", pivo.getAccountNo());
				   jsonObj.put("idNo", pivo.getIdNo());
				   jsonObj.put("status", 1);
		       }
		       else {
				   jsonObj.put("bank", "");
				   jsonObj.put("accountNo", "");
				   jsonObj.put("idNo", "");
				   jsonObj.put("status", 0);
		       }
		      
		       if(pvo != null) {
					   jsonObj.put("basePay", pvo.getBasePay());
					   jsonObj.put("spePay", pvo.getSpePay());
			       }
			       else {
			    	  // System.out.println("모모");
					   jsonObj.put("basePay", "");
					   jsonObj.put("spePay", "");
			       }

			   jsonObj.put("mbr_name", insavo.getMbr_name());
		       return jsonObj.toString();
		    }
		     

		    // 개인별 급여 정보 등록 완료	
			@ResponseBody   
		    @RequestMapping(value="/payRegisterEnd.opis", method = {RequestMethod.GET }, produces = "text/plain;charset=UTF-8")
		    public String payRegisterEnd(ModelAndView mav, HttpServletRequest request, PayInfoVO pivo) {


			   String seq = request.getParameter("seq");

			       
		       String idNo = request.getParameter("idNo");
		       String accountNo = request.getParameter("accountNo");
		       String bank = request.getParameter("bank");
		       
		       pivo.setMbr_seq(Integer.parseInt(seq));
		       pivo.setIdNo(idNo);
		       pivo.setAccountNo(accountNo);
		       pivo.setBank(bank);
		       
		       // 개인 급여 정보 등록하기
		       int n = service.payRegister(pivo);
		       
		       String result = "";
		       if(n==1) {
		    	   result = "1";
		       }
		       else {
		    	   result = "2";
		       }
		       
		       return result;
		    }
		    
			
			// 개인별 급여 정보 수정 완료	
			@ResponseBody   
		    @RequestMapping(value="/payModifyEnd.opis", method = {RequestMethod.GET }, produces = "text/plain;charset=UTF-8")
		    public String payModifyEnd(ModelAndView mav, HttpServletRequest request, PayInfoVO pivo) {

			   String seq = request.getParameter("seq");


			       
		       String idNo = request.getParameter("idNo");
		       String accountNo = request.getParameter("accountNo");
		       String bank = request.getParameter("bank");
		       
		       pivo.setMbr_seq(Integer.parseInt(seq));
		       pivo.setIdNo(idNo);
		       pivo.setAccountNo(accountNo);
		       pivo.setBank(bank);
		       
		       // 개인 급여 정보 수정하기
		       int n = service.payModify(pivo);
		       
		       String result = "";
		       if(n==1) {
		    	   result = "1";
		       }
		       else {
		    	   result = "2";
		       }
		       
		       return result;
		    }
			
			
			
			
			// 개인별 급여 정보 삭제 완료	
			@ResponseBody   
		    @RequestMapping(value="/payDelEnd.opis", method = {RequestMethod.GET }, produces = "text/plain;charset=UTF-8")
		    public String payDelEnd(ModelAndView mav, HttpServletRequest request, PayInfoVO pivo) {

			   String seq = request.getParameter("seq");


		       // 개인 급여 정보 삭제하기
		       int n = service.payDel(seq);
		       
		       String result = "";
		       if(n==1) {
		    	   result = "1";
		       }
		       else {
		    	   result = "2";
		       }
		       
		       return result;
		    }			
			
			
			
		    // === 급여 상세 등록하기 === //
		    @RequestMapping(value="/paymentRegiEnd.opis", produces = "text/plain;charset=UTF-8")
		    public ModelAndView paymentRegiEnd(ModelAndView mav, HttpServletRequest request, PaymentVO pavo) {

		    	 String category = request.getParameter("category");
			       String seq = request.getParameter("seq");
			       String searchType = request.getParameter("searchType");
			       String searchWord = request.getParameter("searchWord");
			       
			       
			       if(category == null) {
			          category="6";
			       }
			       if(seq == "") {
				          seq="0";
				       }
			       if(searchType == null) {
			    	   searchType="";
				       }
			       if(searchWord == null) {
			    	   searchWord="";
				       }
			       
		       pavo.setMbr_seq(Integer.parseInt(seq));
		       pavo.setTotalPay(pavo.getBasePay()+pavo.getSpePay()+pavo.getBreakPay()+pavo.getMealPay()+pavo.getTimePay());
		       
		       // 개인별 급여 상세 등록하기
		       int n = service.paymentRegiEnd(pavo);
		       
		       if(n==1) {

			       // 개인별 급여 상세 리스트 가져오기
			       List <PaymentVO> paymentList = service.getPaymentList(seq);
			       
			       // 개인 인사정보 가져오기
			       InsaVO insavo = service.getInsaView1(seq);
			       mav.addObject("paymentList", paymentList);
			       mav.addObject("insavo", insavo);
			       		
			       mav.setViewName("redirect:/paymentDetail.opis?seq="+seq+"&category="+category+"&searchType="+searchType+"&searchWord="+searchWord);
		       }
		       else {
		    	   System.out.println("등록실패");
		       }
		       
		       return mav;
		    }
		  
		    
		    
		    
		 // 개인별 급여 정보 가져오기(input에 넣어주기)	
 			@ResponseBody   
 		    @RequestMapping(value="/payModiGetInfo.opis", method = {RequestMethod.GET }, produces = "text/plain;charset=UTF-8")
 		    public String payModiGetInfo(HttpServletRequest request) {

			       String seq = request.getParameter("seq");
			       
 		       
 		       

 		       List<PaymentVO> payList = service.payModiGetInfo(seq);

 		       

  	    	  JSONArray jsonArr = new JSONArray(); // []
  	    	  
  	    	  if(payList != null) {
  	    		  for(PaymentVO pay : payList) {
  	    			  JSONObject jsonObj = new JSONObject();
  	    			  jsonObj.put("mbr_seq", pay.getMbr_seq());
	  				  jsonObj.put("paymonth", pay.getPaymonth());
	  				  jsonObj.put("basePay", pay.getBasePay());
	  				  jsonObj.put("spePay", pay.getSpePay());
	  				  jsonObj.put("breakPay", pay.getBreakPay());
	  				  jsonObj.put("mealPay", pay.getMealPay());
	  				  jsonObj.put("timePay", pay.getTimePay());
	  				  jsonObj.put("totalPay", pay.getTotalPay()); 
  	    			  
  	    			  jsonArr.put(jsonObj);
  	    		  }
  	    	  }
		      

		       return jsonArr.toString();
 		    }	
 			
 			
 	 
 		// 개인 급여 목록 수정 완료하기
 		@RequestMapping(value="/paymentModiEnd.opis", method = {RequestMethod.POST}, produces = "text/plain;charset=UTF-8")
  		public ModelAndView paymentModiEnd(ModelAndView mav, HttpServletRequest request, PaymentVO pavo) {
 			
 			String seq = request.getParameter("seq");
 			String category = request.getParameter("category");
 			String month = request.getParameter("month");
		    String searchType = request.getParameter("searchType");
		    String searchWord = request.getParameter("searchWord");
		       
		       
		       if(category == null) {
		          category="6";
		       }
		       if(seq == "") {
			          seq="0";
			       }
		       if(searchType == null) {
		    	   searchType="";
			       }
		       if(searchWord == null) {
		    	   searchWord="";
			       }

 			pavo.setMbr_seq(Integer.parseInt(seq));
 			pavo.setPaymonth(Integer.parseInt(month));
 			
 			pavo.setTotalPay(pavo.getBasePay()+pavo.getSpePay()+pavo.getBreakPay()+pavo.getMealPay()+pavo.getTimePay());
 			
 			// 급여 내역 수정하기
 			int n = service.paymentModiEnd(pavo);
 			
 			if(n==1) {
 				System.out.println("수정완료");
 			}
 			else {
 				System.out.println("수정실패");
 			}
 			
 			String encodedParam = "";
 			try {
				encodedParam = URLEncoder.encode(searchWord, "UTF-8");
			} catch (UnsupportedEncodingException e) {
				e.printStackTrace();
			}
  
 			
 			 mav.setViewName("redirect:/paymentDetail.opis?seq="+seq+"&category="+category+"&searchType="+searchType+"&searchWord="+ encodedParam);
		      
	 			
 			return mav;
 		}

 		// 개인별 상세 급여 삭제하기 
		@RequestMapping(value="/paymentDelEnd.opis")
  		public ModelAndView paymentDelEnd(ModelAndView mav, HttpServletRequest request, PaymentVO pavo) {
 			
 			String seq = request.getParameter("seq");
 			String category = request.getParameter("category");
 			String month = request.getParameter("month");
		    String searchType = request.getParameter("searchType");
		    String searchWord = request.getParameter("searchWord");
		       
		       
		       if(category == null) {
		          category="6";
		       }
		       if(seq == "") {
			          seq="0";
			       }
		       if(searchType == null) {
		    	   searchType="";
			       }
		       if(searchWord == null) {
		    	   searchWord="";
			       }

 			pavo.setMbr_seq(Integer.parseInt(seq));
 			pavo.setPaymonth(Integer.parseInt(month));
 			
 			// 급여 내역 삭제하기
 			int n = service.paymentDelEnd(pavo);
 			
 			if(n==1) {
 				System.out.println("삭제완료");
 			}
 			else {
 				System.out.println("삭제실패");
 			}
 			
 			String encodedParam = "";
 			try {
				encodedParam = URLEncoder.encode(searchWord, "UTF-8");
			} catch (UnsupportedEncodingException e) {
				e.printStackTrace();
			}
  
 			
 			 mav.setViewName("redirect:/paymentDetail.opis?seq="+seq+"&category="+category+"&searchType="+searchType+"&searchWord="+ encodedParam);
		      
	 			
 			return mav;
 		}
 	 			
		
	}
