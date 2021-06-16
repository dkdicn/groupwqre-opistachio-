<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<%
	String ctxPath = request.getContextPath();
%>

<link rel="stylesheet" type="text/css" href="<%=ctxPath %>/resources/css/menu.css" />		
<link rel="stylesheet" type="text/css" href="<%=ctxPath %>/resources/css/boardButtons.css">
<style type="text/css">

 #cntc_content {
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

	function goDelete(cnotice_seq){
		if(confirm("정말로 삭제하시겠습니까?")==true){
        	location.href="<%=ctxPath%>/cnotice_delEnd.opis?cnotice_seq="+cnotice_seq;
    	}
	}
	
</script>

<div style="width: 1460px;">
	
	<!-- 게시판제목 -->
	<div style="padding: 15px; font-size: 25px; font-weight: 600; height: 60px; width: 100%; background-color: #f2f2f2; color: #555;">
	&nbsp;&nbsp;전체 공지사항
	</div>
	
	<!-- 글내용 -->
	<div id="cntc_content">
	   	<c:if test="${not empty requestScope.cnoticevo}">
	   	 <table id="table">
	         <tr id="title">
	            <td style="width: 800px;"><h3>${requestScope.cnoticevo.ctitle}</h3></td>
	            <td style="width: 200px;">${requestScope.cnoticevo.cwritedate}</td>
	            <td style="width: 100px;">조회&nbsp;${requestScope.cnoticevo.chit}</td>
	         </tr>
	         <tr>
	            <td colspan="3" style="height: 400px; border-bottom: 1px solid black;">
	            	<p style="word-break: break-all;">${requestScope.cnoticevo.ccontent}</p>
	            </td>
	         </tr>
	   	 </table>
	   	 
	   	 <!-- 이전글, 다음글 -->
	   	 <div class="prev_next">이전글&nbsp;&nbsp;&nbsp;<span class="move" onclick="javascript:location.href='cnotice_view.opis?cnotice_seq=${requestScope.cnoticevo.previousseq}'">${requestScope.cnoticevo.previoustitle}</span></div>
	   	 <div class="prev_next">다음글&nbsp;&nbsp;&nbsp;<span class="move" onclick="javascript:location.href='cnotice_view.opis?cnotice_seq=${requestScope.cnoticevo.nextseq}'">${requestScope.cnoticevo.nexttitle}</span></div>   	 
	   	 
	   </c:if>
	   
	   <c:if test="${empty requestScope.cnoticevo}">   		
	      <div style="padding: 50px 0; font-size: 16pt; color: red;">존재하지 않습니다</div>
	   </c:if>
   
	   <button type="button" class="btn-basic" onclick="javascript:location.href='<%=ctxPath%>/cnotice_list.opis'">목록</button>
	   <c:if test="${sessionScope.loginuser.power_detail ne '사원'}">
	   		<button type="button" class="btn-ok" onclick="javascript:location.href='<%=ctxPath%>/cnotice_edit.opis?cnotice_seq=${requestScope.cnoticevo.cnotice_seq}'">수정</button>
	   		<button type="button" class="btn-basic" onclick="goDelete(${requestScope.cnoticevo.cnotice_seq})">삭제</button>
	   </c:if>

   </div>
</div>