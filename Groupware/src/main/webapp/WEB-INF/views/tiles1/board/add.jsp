<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<% String ctxPath = request.getContextPath(); %>  
  
<link rel="stylesheet" type="text/css" href="<%=ctxPath %>/resources/css/menu.css" />		
<link rel="stylesheet" type="text/css" href="<%=ctxPath %>/resources/css/boardButtons.css">

<style type="text/css">

 table, th, td, input, textarea {border: solid gray 1px;}
 
 #add{
  	 margin: 30px 0 0 350px; 	
 }
 #table {
	 border-collapse: collapse;
  	 width: 1000px;
        }
 #table th, #table td{padding: 5px;}
 #table th{width: 120px; background-color: #DDDDDD;}
 #table td{width: 880px;}
 .long {width: 470px;}
 .short {width: 120px;}


</style>

<jsp:include page="./board_sidebar.jsp" />
<script type="text/javascript">
   $(document).ready(function(){
	  
	  $("#addFile").hide();
	  
	  // 공통서식을 선택할 때만 첨부파일 칸이 보이게 하기
	  $("select#boardType").change(function(){
		  if($("select#boardType").val()=="formboard"){
	     	 $("#addFile").show();
		  }
		  else{
			 $("#addFile").hide();
		  }
	  });
	  
      // 쓰기버튼
      $("button#btnWrite").click(function(){
         
          // 글제목 유효성 검사
         var subjectVal = $("input#title").val().trim();
         if(subjectVal == "") {
            alert("제목을 입력하세요!!");
            return;
         }
         
         // 글내용 유효성 검사(스마트에디터 사용 안 할시)
        
         var contentVal = $("textarea#content").val().trim();
         if(contentVal == "") {
            alert("내용을 입력하세요!!");
            return;
         }
         
         // 게시판 선택
         var frm = document.addFrm;
         frm.method = "POST";
         
         if($("select#boardType").val()=="cnotice"){ // 전체공지
	         frm.action = "<%= ctxPath%>/cnotice_addEnd.opis";
	         frm.submit();   
         }
         else if($("select#boardType").val()=="dnotice"){ // 부서공지
	         frm.action = "<%= ctxPath%>/dnotice_addEnd.opis";
	         frm.submit();   
         }
         else if($("select#boardType").val()=="formboard"){ // 공통서식
        	 frm.action = "<%= ctxPath%>/formboard_addEnd.opis";
	         frm.submit();   
         }
         else if($("select#boardType").val()=="default"){ // 게시판 선택 안할시
	         alert("작성하실 게시판을 선택하세요.");
	         return;
         }
      });
           
   });// end of $(document).ready(function(){})----------------
</script>

<div style="width: 1460px;">
	
	<!-- 게시판제목 -->
	<div style="padding: 15px; font-size: 25px; font-weight: 600; height: 60px; width: 100%; background-color: #f2f2f2; color: #555;">
	&nbsp;&nbsp;글쓰기
	</div>	
	
	<div id="add">
	<!-- insert할 게시판 선택 -->
 	<div id="selectBoard">
 		<c:choose>
	 	<%-- 로그인한 유저가 관리자가 아니면 부서공지 게시판에만 작성 가능 --%>
	 	    <c:when test="${sessionScope.loginuser.power_detail eq '사원'}">
			   	<select name="boardType" id="boardType" style="height: 26px;">
			   		<option value="default" selected="selected">&nbsp;게시판을 선택해주세요 &nbsp;</option>
			  		<option value="dnotice">부서 공지사항</option>
				</select>			   	
			</c:when>
		<%-- 로그인한 유저가 관리자면 세 게시판에 작성 가능 --%>
			<c:otherwise>
				<select name="boardType" id="boardType" style="height: 26px;">
			   		<option value="default" selected="selected">&nbsp;게시판을 선택해주세요 &nbsp;</option>
			  		<option value="cnotice">전체 공지사항</option>
			  		<option value="dnotice">부서 공지사항</option>
			  		<option value="formboard">공통서식</option>
				</select>
			</c:otherwise>
		</c:choose>
	</div>
 	
 	<form name="addFrm" id="addFrm" enctype="multipart/form-data"> 
 			
      <table id="table">      
         <tr>
         	<th>작성자</th>
            <td>
            	<input type="hidden" name="fk_mbr_seq" value="${sessionScope.loginuser.mbr_seq}">
                <input type="hidden" name="fk_dept_detail" value="${sessionScope.loginuser.dept_detail}">
                <input type="text" name="fk_mbr_id" value="${sessionScope.loginuser.mbr_id}" class="short" readonly />       
            </td>
         </tr>		

         <tr>
            <th>제목</th>
            <td>
               <input type="text" name="title" id="title" class="long" />       
            </td>
         </tr>
		
         <tr id="addFile">
         	<th>파일첨부</th>
         	<td>
         		<input type="file" name="attach" />
         	</td>
         </tr>
         
         <tr>
            <th>내용</th>
            <td>
               <textarea rows="10" cols="100" style="width: 95%; height: 450px;" name="content" id="content"></textarea>       
            </td>
         </tr>    
      </table>
      
      <div style="margin: 10px;">
         <button type="button" class="btn-ok" id="btnWrite">등록</button>
         <button type="button" class="btn-basic" onclick="javascript:history.back()">취소</button>
      </div>
         
   </form>
  </div> 
</div>    