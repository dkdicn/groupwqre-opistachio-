<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

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
         var subjectVal = $("input#dtitle").val().trim();
         if(subjectVal == "") {
            alert("글제목을 입력하세요!!");
            return;
         }
         
         // 글내용 유효성 검사(스마트에디터 사용 안 할시)
        
         var contentVal = $("textarea#dcontent").val().trim();
         if(contentVal == "") {
            alert("글내용을 입력하세요!!");
            return;
         }
                 
         // 폼(form) 을 전송(submit)
         var frm = document.editFrm;
         frm.method = "POST";
         frm.action = "<%= ctxPath%>/dnotice_editEnd.opis";
         frm.submit();   
      });
           
   });// end of $(document).ready(function(){})----------------
</script>

<div style="width: 1460px;">

	<!-- 게시판제목 -->
	<div style="padding: 15px; font-size: 25px; font-weight: 600; height: 60px; width: 100%; background-color: #f2f2f2; color: #555;">
	&nbsp;&nbsp;전체 공지사항
	</div>
	
	<!-- 수정폼 -->
	<form name="editFrm" id="editFrm"> 
 
      <table id="table">

		 <tr style="display: none;"><!-- 글번호 넘기기용 -->
		 	<th>글번호</th>
		 	<td>
                <input type="text" name="dnotice_seq" value="${requestScope.dnoticevo.dnotice_seq}" readonly/>   
            </td>
		 </tr>
         <tr>
            <th>제목</th>
            <td>
               <input type="text" name="dtitle" id="dtitle" class="long" value="${requestScope.dnoticevo.dtitle}" />       
            </td>
         </tr>
         <tr>
            <th>내용</th>
            <td>
               <textarea rows="10" cols="100" style="width: 95%; height: 450px;" name="dcontent" id="dcontent">${requestScope.dnoticevo.dcontent}</textarea>       
            </td>
         </tr>

      </table>
      
      <div style="margin: 10px;">
         <button type="button" id="btnUpdate" class="btn-ok">완료</button>
         <button type="button" onclick="javascript:history.back()" class="btn-basic">취소</button>
      </div>
   </form>
   
</div>    