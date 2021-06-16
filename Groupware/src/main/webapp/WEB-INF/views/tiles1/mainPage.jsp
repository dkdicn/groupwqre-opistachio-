<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<% String ctxPath = request.getContextPath(); %>

<meta charset="utf-8">
<meta name="viewport" content="width=device-width, initial-scale=1">
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.1/css/bootstrap.min.css">
<link rel="stylesheet" type="text/css" href="<%=ctxPath %>/resources/css/menu.css" />		
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
<script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.1/js/bootstrap.min.js"></script>

<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/4.7.0/css/font-awesome.min.css">
<script src='https://kit.fontawesome.com/a076d05399.js' crossorigin='anonymous'></script>
  
<link rel="stylesheet" type="text/css" href="resources/css/mainPage.css"/>

<script>
	$(function(){
		
		if("${sessionScope.loginuser.power_detail}"=="사원" || !"${sessionScope.loginuser}"){	// 일반사원이 로그인한 경우라면
			$("div.insa").hide();
		}
		else {
			$("div.insa").show();
		}
		
	});
</script>

<div id="mainPageContainer">
	<div id="calendar">
		
	</div>
	<div id="mainMenu">
		<div class="menu" style="cursor: pointer;" onclick="location.href='<%=ctxPath%>/cnotice_list.opis';">
			<i class="fas fa-chalkboard fa-3x icon"></i>게시판
		</div>
		<div class="menu" style="cursor: pointer;" onclick="location.href='<%=ctxPath%>/workList.opis';">
			<i class="fas fa-business-time fa-3x icon"></i>업무관리
		</div>
		<div class="menu" style="cursor: pointer;" onclick="location.href='<%=ctxPath%>/myscd.opis';">
			<i class="fas fa-list fa-3x icon"></i>일정
		</div>
		<div class="menu" style="cursor: pointer;" onclick="location.href='<%=ctxPath%>/totaladdrlist.opis';">
			<i class="far fa-address-card fa-3x icon"></i>주소록
		</div>
		<div class="menu" style="cursor: pointer;" onclick="location.href='<%=ctxPath%>/mbrchart.opis';">
			<i class="fas fa-sitemap fa-3x icon"></i>조직도
		</div>
		<div class="menu" style="cursor: pointer;" onclick="location.href='<%=ctxPath%>/approvalMain.opis';">
			<i class="fas fa-file-signature fa-3x icon"></i>전자결재
		</div>
		<div class="menu insa" style="cursor: pointer;" onclick="location.href='<%=ctxPath%>/insa.opis';">
			<i class="fas fa-users fa-3x icon"></i>인사관리
		</div>
		<div class="menu insa" style="cursor: pointer;" onclick="location.href='<%=ctxPath%>/mngCommute.opis';">
			<i class="fas fa-user-clock fa-3x icon"></i>근태관리
		</div>
	</div>   
</div>   