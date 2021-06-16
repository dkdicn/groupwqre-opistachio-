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
  
<link rel="stylesheet" type="text/css" href="<%=ctxPath %>/resources/css/mainPage.css"/>

<script type="text/javascript">
	$(document).ready(function(){
		$("span#personal").click(function(){
			location.href="<%=ctxPath%>/personalInfo.opis";
		});
		$("span#company").click(function(){
			location.href="<%=ctxPath%>/companyInfo.opis";
		});
	}); // end of $(document).ready(function(){})---------------------------------------
</script>

<div id="personalInfoContainer">
	<span class="subtitle" id="personal" style="color:#04AA6D; cursor: pointer;" >개인정보설정</span>
	<span class="subtitle">|</span>
	<span class="subtitle" id="company" style="cursor: pointer;">회사정보보기</span>
	<hr>
	<table>
		<tbody>
			<tr>
				<td>아이디</td>
				<td id="mbr_id">${sessionScope.loginuser.mbr_id}</td>
				<td rowspan="3">사진</td>
				<td id="mbr_photo" rowspan="3"><i class="fas fa-portrait fa-5x infoIcon"></i></td>
			</tr>
			<tr>
				<td>성명</td>
				<td id="mbr_name">${sessionScope.loginuser.mbr_name}</td>
			</tr>
			<tr>
				<td>소속</td>
				<td id="dept_power">${sessionScope.loginuser.dept_detail}&nbsp;${sessionScope.loginuser.rank_detail}</td>
			</tr>
			<tr>
				<td>비밀번호</td>
				<td id="mbr_pwd"><input type="password" /></td>
				<td>이메일</td>
				<td id="mbr_email"><input type="text" value="${sessionScope.loginuser.mbr_email}"/></td>
			</tr>
			<tr>
				<td>비밀번호 확인</td>
				<td id="mbr_pwd_check"><input type="password" /></td>
				<td>회사번호</td>
				<td id="mbr_com_number"><input type="text" value="${sessionScope.loginuser.mbr_com_number}" /></td>
			</tr>
			<tr>
				<td>생년월일</td>
				<td id="mbr_birthday"><input type="text" value="${sessionScope.loginuser.mbr_birthday}"/></td>
				<td>핸드폰</td>
				<td id="mbr_phone_number"><input type="text" value="${sessionScope.loginuser.mbr_phone_number}"/></td>
			</tr>
		</tbody>
	</table>
</div>   



 