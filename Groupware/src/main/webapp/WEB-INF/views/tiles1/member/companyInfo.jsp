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

<div id="companyInfoContainer">
	<span class="subtitle" id="personal" style="cursor: pointer;">개인정보설정</span>
	<span class="subtitle">|</span>
	<span class="subtitle" id="company" style="color:#04AA6D; cursor: pointer;" >회사정보보기</span>
	<hr>
	<table>
		<tbody>
			<tr>
				<td>회사명</td>
				<td id="com_name">${cvo.com_name}</td>
				<td>대표자명</td>
				<td id="mbr_name">${ceo_name}</td>
			</tr>
			<tr>
				<td>회사주소</td>
				<td id="com_address" colspan="3">${cvo.com_address}</td>
			</tr>
			<tr>
				<td>사업자등록번호</td>
				<td id="registraion_num">${cvo.registraion_num}</td>
				<td>업태 / 업종</td>
				<td id="business_type">${cvo.business_type}</td>
			</tr>
			<tr>
				<td>담당자명</td>
				<td id="mbr_name">${mvo.mbr_name}</td>
				<td>담당자 부서</td>
				<td id="mbr_dept">${mvo.dept_detail}</td>
			</tr>
			<tr>
				<td>담당자 이메일</td>
				<td id="mbr_email">${mvo.mbr_email}</td>
				<td>담당자 연락처</td>
				<td id="mbr_phone_number">${mvo.mbr_phone_number}</td>
			</tr>
			<tr>
				<td>회사전화</td>
				<td id="com_ph">${cvo.com_ph}</td>
				<td>회사이메일</td>
				<td id="com_email">${cvo.com_email}</td>
			</tr>
		</tbody>
	</table>
</div>   



 