<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<% String ctxPath = request.getContextPath(); %>    

<link rel="stylesheet" type="text/css" href="<%=ctxPath %>/resources/css/menu.css" />		
<link rel="stylesheet" type="text/css" href="<%=ctxPath %>/resources/css/boardButtons.css">

<style type="text/css">

   table, th, td, input, textarea {border: solid gray 1px;}
   
   #editFrm{
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
      
      // 완료버튼
      $("button#btnUpdate").click(function(){
      
          // 글제목 유효성 검사
         var subjectVal = $("input#ftitle").val().trim();
         if(subjectVal == "") {
            alert("글제목을 입력하세요!!");
            return;
         }
         
         // 글내용 유효성 검사(스마트에디터 사용 안 할시)
        
         var contentVal = $("textarea#fcontent").val().trim();
         if(contentVal == "") {
            alert("글내용을 입력하세요!!");
            return;
         }
                 
         // 폼(form) 을 전송(submit)
         var frm = document.editFrm;
         frm.method = "POST";
         frm.action = "<%= ctxPath%>/formboard_editEnd.opis";
         frm.submit();   
      });
           
   });// end of $(document).ready(function(){})----------------
</script>

<div style="width: 1460px;">
	
	<!-- 게시판제목 -->
	<div style="padding: 15px; font-size: 25px; font-weight: 600; height: 60px; width: 100%; background-color: #f2f2f2; color: #555;">
	&nbsp;&nbsp;공통서식
	</div>
	
	<!-- 수정폼 -->
	<form name="editFrm" id="editFrm" enctype="multipart/form-data"> 
 
      <table id="table">

		 <tr style="display: none;"><!-- 글번호 넘기기용 -->
		 	<th>글번호</th>
		 	<td>
                <input type="text" name="form_seq" value="${requestScope.formboardvo.form_seq}" readonly/>   
            </td>
		 </tr>
         <tr>
            <th>제목</th>
            <td>
               <input type="text" name="ftitle" id="ftitle" class="long" value="${requestScope.formboardvo.ftitle}" />       
            </td>
         </tr>
         <tr>
            <th>기존 첨부파일</th>
            <td>
            <c:if test="${empty requestScope.formboardvo.orgFilename}">
            	<span style="color: red;">첨부된 파일이 없습니다</span>
            </c:if>
            <c:if test="${not empty requestScope.formboardvo.orgFilename}">
	            <a href="<%=ctxPath%>/formboard_download.opis?form_seq=${requestScope.formboardvo.form_seq}">${requestScope.formboardvo.orgFilename}</a>&nbsp;&nbsp;(<fmt:formatNumber value="${requestScope.formboardvo.fileSize}" pattern="#,###"></fmt:formatNumber>&nbsp;bytes) 	
            </c:if>
            </td>
         </tr>
         <tr>
         	<th>수정할 파일</th>
         	<td>
         		<input type="file" name="attach" />
         		<input type="hidden" name="fileName" value="${requestScope.formboardvo.fileName}"  />
         		<input type="hidden" name="orgFilename" value="${requestScope.formboardvo.orgFilename}"  />
         		<input type="hidden" name="fileSize" value="${requestScope.formboardvo.fileSize}"  />
         	</td>
         </tr>
         <tr>
            <th>내용</th>
            <td>
               <textarea rows="10" cols="100" style="width: 95%; height: 450px;" name="fcontent" id="fcontent">${requestScope.formboardvo.fcontent}</textarea>       
            </td>
         </tr>

      </table>
      
      <div style="margin: 10px;">
         <button type="button" class="btn-ok" id="btnUpdate">완료</button>
         <button type="button" class="btn-basic" onclick="javascript:history.back()">취소</button>
      </div>
   </form>
   
</div>    