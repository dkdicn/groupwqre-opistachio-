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
<script src='https://kit.fontawesome.com/a076d05399.js'></script>

<style type="text/css">
	
	.myTeam {
		margin-top:20px;
		margin-bottom: 5px;
		padding-left: 40px;
		font-weight:bold;
	}
	
	#myName {
		margin-bottom: 25px;
		text-align:center;
		color: #008ae6;
		font-weight:bold;
		font-size:14pt;
	}
	
	#myEmail {
		font-weight: bold;
	}	
	
	#teamName {
		text-align:center;
		margin-bottom:40px;	
		font-weight: bold;
		font-size: 13pt;
		color:#008ae6;
	}
		
	#btnResv {
	  	border: none;
	  	padding: 15px 45px;
	  	border-radius: 2pt;
	  	font-weight: bold;
	  	background: #8cb1d9;
  	}
  
	#btnResv:hover {color:white;}
	
	#btnDelAll {
	  	border: none;
	  	padding: 15px 36px;
	  	border-radius: 2pt;
	  	font-weight: bold;
	  	background: #b3b3b3;
	}
  
  	#btnDelAll:hover {color:white;}
		
</style>


<script type="text/javascript">
	
	function scdDelAll() {
		var bool = confirm("전체 일정을 모두 삭제하시겠습니까?\n삭제하시면 복구할 수 없습니다.");
		
		if(bool) {
			location.href = "<%=ctxPath%>/delAll.opis";
		}
	}
	
	function scdReg() {
		 var url = "<%=ctxPath%>/scd_register.opis";
		 window.open(url, "scdRegister","left=350px, top=100px, width=700px, height=455px");
	 }
	
	function mtrResv() {
		 var url = "<%=ctxPath%>/mtr_resv.opis";
		 window.open(url, "mtrResv","left=350px, top=100px, width=900px, height=680px");
	 }
	
	function goCancelResv() {
		var url = "<%=ctxPath%>/CancelResv.opis";
		window.open(url, "goCancel","left=350px, top=100px, width=675px, height=360px");
	}
	
</script>

<div id="sideMenu" style="display:inline-block; float:left;">
	  	<div id="menuTitle">일정</div>
	  	<div id="btnDiv">
	  		<button type="button" id="btnReg" onclick="scdReg()">일정 등록</button>	
	    </div>
	    
	    	<div style="text-align:center;"><span id="myName">${sessionScope.loginuser.mbr_id}</span>&nbsp;님&nbsp;/&nbsp;<span id="myEmail">${sessionScope.loginuser.mbr_email}</span></div>
	  		<br><br>
	  		<div class="myTeam">내소속</div>
	  		<div id="teamName">
				<c:choose>
					<c:when test="${sessionScope.loginuser.dept_detail == '영업팀'}">
						영업팀
					</c:when>
					<c:when test="${sessionScope.loginuser.dept_detail == '인사팀'}">
						인사팀
					</c:when>
					<c:when test="${sessionScope.loginuser.dept_detail == '홍보팀'}">
						홍보팀
					</c:when>
					<c:when test="${sessionScope.loginuser.dept_detail == 'IT팀'}">
						IT팀
					</c:when>
					<c:when test="${sessionScope.loginuser.dept_detail == '회계팀'}">
						회계팀
					</c:when>
					<c:otherwise>
						CEO
					</c:otherwise>
				</c:choose>	  			
	  		</div>
	  		
	  		<br>
	  		<div class="lside">
	  			<button class="sideBtn" style="font-weight:bold;">일정</button>
	  			<ul class="sideUl">
	  				<li><a href="#" onclick="scdDelAll()">전체 일정 삭제</a></li>
	  			</ul>
	  		</div>
	  		<div class="lside">
	  			<button class="sideBtn" style="font-weight:bold;">회의실</button>
	  			<ul class="sideUl">
	  				<li><a href="#" onclick="mtrResv()">회의실 예약</a></li>
	  				<li><a href="#" onclick="goCancelResv()">회의실 예약취소</a></li>
	  			</ul>
	  		</div>
	  			
</div>
