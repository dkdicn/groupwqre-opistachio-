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

<link rel="stylesheet" type="text/css" href="resources/css/mbrchart.css"/>



<div id="sideMenu">
	<div id="menuTitle">조직도</div>
		
	<div class="lside">
		<button class="sideBtn" onclick=location.href="<%=ctxPath%>/mbrchart.opis">전체 조직도</button>	
		<ul class="sideUl">
			<li><a href="<%=ctxPath%>/mbrchart.opis?dept=0">영업팀</a></li>
			<li><a href="<%=ctxPath%>/mbrchart.opis?dept=1">인사팀</a></li>
			<li><a href="<%=ctxPath%>/mbrchart.opis?dept=2">홍보팀</a></li>
			<li><a href="<%=ctxPath%>/mbrchart.opis?dept=3">IT팀</a></li>
			<li><a href="<%=ctxPath%>/mbrchart.opis?dept=4">회계팀</a></li>
		</ul>
	</div>
</div>




