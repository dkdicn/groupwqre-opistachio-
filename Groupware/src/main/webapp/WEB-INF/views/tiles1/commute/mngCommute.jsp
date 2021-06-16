<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<% String ctxPath = request.getContextPath(); %>


<title>근태관리</title>
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.1/css/bootstrap.min.css">
<link rel="stylesheet" type="text/css" href="<%=ctxPath %>/resources/css/boardButtons.css">
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
<script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.1/js/bootstrap.min.js"></script>

<jsp:include page="./cmt_sidebar.jsp" />
<script type="text/javascript">

	$(document).ready(function(){
		
//		document.getElementById ( "sysdate" ).innerHTML = Date();
		
	});
	

</script>

<div style="width: 1460px"> 

	<!-- 제목 -->
	<div style="padding: 15px; font-size: 25px; font-weight: 600; height: 60px; width: 100%; background-color: #f2f2f2; color: #555;">
	&nbsp;&nbsp;근태관리
	</div>

	<!-- 본문(게시판) -->
	<div class="container" style="float: right; width: 75%; margin-top: 50px;"> 
	        
	  <table class="table table-striped">
	    <thead>
	      <tr>
	        <th style="width: 7%; text-align: center;">사원ID</th>
	        <th style="width: 7%;  text-align: center;">출근시간</th>
	        <th style="width: 7%; text-align: center;">퇴근시간</th>
	        <th style="width: 7%;  text-align: center;">출근상태</th>
	        <th style="width: 7%;  text-align: center;">퇴근상태</th>
	      </tr>
	    </thead>
	    <tbody>
	    <c:forEach var="cmtList" items="${requestScope.cmtList}" varStatus="status">    
	      	<tr>
				<td align="center">${cmtList.mbr_id}</td>
				<td align="center">${cmtList.login_day}</td>
				<td align="center">${cmtList.logout_day}</td>
				<td align="center">정상</td>
				<td align="center">정상</td>      	
	      	</tr>		
		 </c:forEach> 	    
	    </tbody>
	  </table>
	  
	<!-- 페이지바  
	<div align="center" style="width: 70%; border: solid 0px gray; margin: 20px auto;">
   		${requestScope.pageBar}
    </div>--> 
    
	</div>
</div>
