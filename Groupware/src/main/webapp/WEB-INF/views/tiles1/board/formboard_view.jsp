<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<%
	String ctxPath = request.getContextPath();
%>
<link rel="stylesheet" type="text/css" href="<%=ctxPath %>/resources/css/menu.css" />		
<link rel="stylesheet" type="text/css" href="<%=ctxPath %>/resources/css/boardButtons.css">
<style type="text/css">

 #fb_content {
    width: 80%;
    margin: 50px 0 0 300px;
 }

 #table{
 	 margin-bottom: 30px;
 }
 
 #table td{
 	padding: 5px;
 }
 
 tr#title{
 	border-top: 3px solid black;
 	border-bottom: 1px solid lightgray;
 }
 
  div.prev_next{
 	margin-bottom: 1%; 
 	border-bottom: 1px solid lightgray; 
 	width:70%;
 }
  
   .move {cursor: pointer;}
   .moveColor {color: #660029; font-weight: bold;}
   

</style>

<jsp:include page="./board_sidebar.jsp" />
<script type="text/javascript">

	$(document).ready(function(){
		
		$("span.move").hover(function(){$(this).addClass("moveColor");},
							 function(){$(this).removeClass("moveColor");});	
		
	}); // end of $(document).ready(function(){})-----------------------------------------

	function goDelete(form_seq){
		if(confirm("정말로 삭제하시겠습니까?")==true){
        	location.href="<%=ctxPath%>/formboard_delEnd.opis?form_seq="+form_seq;
    	}
	}
	
</script>

<div style="width: 1460px;">

	<!-- 게시판제목 -->
	<div style="padding: 15px; font-size: 25px; font-weight: 600; height: 60px; width: 100%; background-color: #f2f2f2; color: #555;">
	&nbsp;&nbsp;공통서식
	</div>
	
	<!-- 글내용 -->
	<div id="fb_content">
   	<c:if test="${not empty requestScope.formboardvo}">
   	 <table id="table">
         <tr id="title">
            <td style="width: 800px;"><h3>${requestScope.formboardvo.ftitle}</h3></td>
            <td style="width: 200px;">${requestScope.formboardvo.fwritedate}</td>
            <td style="width: 100px;">조회&nbsp;${requestScope.formboardvo.fhit}</td>
         </tr>
         <tr>
         	<c:if test="${not empty requestScope.formboardvo.orgFilename}">
	            <td>
	            	<span style="font-weight: 600;">첨부파일</span>&nbsp;:&nbsp;
	            	<a href="<%=ctxPath%>/formboard_download.opis?form_seq=${requestScope.formboardvo.form_seq}">${requestScope.formboardvo.orgFilename}</a>&nbsp;&nbsp;(<fmt:formatNumber value="${requestScope.formboardvo.fileSize}" pattern="#,###"></fmt:formatNumber>&nbsp;bytes)
	            </td>
            </c:if>
         </tr>
         <tr>
            <td colspan="3" style="height: 400px; border-bottom: 1px solid black;">
            	<p style="word-break: break-all;">${requestScope.formboardvo.fcontent}</p>
            </td>
         </tr>
   	 </table>
   	 
   	 <!-- 이전글, 다음글 -->
   	 <div class="prev_next">이전글제목&nbsp;&nbsp;<span class="move" onclick="javascript:location.href='formboard_view.opis?form_seq=${requestScope.formboardvo.previousseq}'">${requestScope.formboardvo.previoustitle}</span></div>
   	 <div class="prev_next">다음글제목&nbsp;&nbsp;<span class="move" onclick="javascript:location.href='formboard_view.opis?form_seq=${requestScope.formboardvo.nextseq}'">${requestScope.formboardvo.nexttitle}</span></div>   	 
   	 
	 </c:if>
	   
	 <c:if test="${empty requestScope.formboardvo}">   		
	    <div style="padding: 50px 0; font-size: 16pt; color: red;">존재하지 않습니다</div>
	 </c:if>
	   
	 <button type="button"class="btn-basic"  onclick="javascript:location.href='<%=ctxPath%>/formboard_list.opis'">목록</button>
	 <c:if test="${sessionScope.loginuser.power_detail ne '사원'}">
		 <button type="button" class="btn-ok" onclick="javascript:location.href='<%=ctxPath%>/formboard_edit.opis?form_seq=${requestScope.formboardvo.form_seq}'">수정</button>
		 <button type="button" class="btn-basic" onclick="goDelete(${requestScope.formboardvo.form_seq})">삭제</button>
	 </c:if> 
	 
	</div> 
</div>