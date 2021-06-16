<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<% String ctxPath = request.getContextPath(); %>


<link rel="stylesheet" href="https://www.w3schools.com/w3css/4/w3.css">

<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.1/css/bootstrap.min.css">
<link rel="stylesheet" type="text/css" href="<%=ctxPath %>/resources/css/menu.css" />
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
<script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.1/js/bootstrap.min.js"></script>

<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/4.7.0/css/font-awesome.min.css">
<script src='https://kit.fontawesome.com/a076d05399.js' crossorigin='anonymous'></script>

<script type="text/javascript">

</script>


<div id="sideMenu">
	<div id="menuTitle">근태 관리</div>
	<div id="btnDiv">
		<button type="button" id="btnReg">등록</button>
	</div>

	<div class="lside">
		<button class="sideBtn" onclick="javascript:location.href='<%=ctxPath%>/mngCommute.opis'">출퇴근관리</button>
	</div>
	<div class="lside">
		<button class="sideBtn" onclick="javascript:location.href='<%=ctxPath%>/totalCommute.opis'">출퇴근조회</button>
	</div>
</div>
