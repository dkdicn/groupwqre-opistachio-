<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<% String ctxPath = request.getContextPath(); %>


<link rel="stylesheet" href="https://www.w3schools.com/w3css/4/w3.css">

<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.1/css/bootstrap.min.css">
<link rel="stylesheet" type="text/css" href="<%=ctxPath %>/resources/css/menu.css" />		
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
<script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.1/js/bootstrap.min.js"></script>

<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/4.7.0/css/font-awesome.min.css">
<script src='https://kit.fontawesome.com/a076d05399.js' crossorigin='anonymous'></script>

<link rel="stylesheet" type="text/css" href="resources/css/approval.css"/>

<script type="text/javascript">

	$(document).ready(function(){
		
		$("button#btnReg").click(function(){
			location.href="<%=ctxPath%>/approvalMain.opis";
		});
		
	}); 

</script>


<div id="sideMenu">
	<div id="menuTitle">전자결재</div>
	<div id="btnDiv">
		<button type="button" id="btnReg">결재문서 작성</button>
	</div>
	
	<div class="lside">
		<button class="sideBtn">기안문 작성</button>	
		<ul class="sideUl">
			<li><a href="<%=ctxPath%>/approvalForm1.opis">일반기안서</a></li>
			<li><a href="<%=ctxPath%>/approvalForm2.opis">지출결의서</a></li>
			<li><a href="<%=ctxPath%>/approvalForm3.opis">휴가신청서</a></li>
		</ul> 
	</div>
	<div class="lside">
		<button class="sideBtn">진행상황</button>
		<ul class="sideUl">
			<li><a href="<%=ctxPath%>/approvalNeeded.opis">결재 대기중인 문서</a></li>
			<li><a href="<%=ctxPath%>/approvalSubmit.opis">결재요청한 문서</a></li>
			<li><a href="<%=ctxPath%>/approvalReferred.opis">결재참조된 문서</a></li>
		</ul>
	</div>
	<div class="lside">
		<button class="sideBtn">설정</button>
		<ul class="sideUl">
			<li><a href="<%=ctxPath%>/sign.opis?">서명관리</a></li>
		</ul>
	</div>
</div>




