<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<% String ctxPath = request.getContextPath(); %>
    

<title>주소록 상세</title>

<link rel="stylesheet" type="text/css" href="<%=ctxPath %>/resources/css/boardButtons.css">
<script src="https://kit.fontawesome.com/16816a49c3.js" crossorigin="anonymous"></script>

<style type="text/css">

#content {
    width: 80%;
    margin: 50px 0 0 400px;
    font-size: 15px;
 }

#addr_table{
	width: 80%;
	margin-bottom: 50px;
	border-top: 3px solid black;
 	border-bottom: 3px solid black;
}

#addr_table th, td{
	border-top: 1px solid lightgray;
	border-bottom: 1px solid lightgray;
 	padding: 5px;
 }

td#name{
	font-size: 20px; 
	font-weight: 600;
	height: 100px;
	background-color: lightgray;
}

.btnaddr{
	margin-right: 20px;
}

.title{
	font-size: 17px;
	font-weight: 600;
}

</style>

<jsp:include page="./addr_sidebar.jsp" />
<script type="text/javascript">

function goDelete(addr_seq){
	if(confirm("정말로 삭제하시겠습니까?")==true){
    	location.href="<%=ctxPath%>/addr_delEnd.opis?addr_seq="+addr_seq;
	}
}

</script>

<div style="width: 1460px;">

	<!-- 게시판 제목 -->
	<div style="padding: 15px; font-size: 25px; font-weight: 600; height: 60px; width: 100%; background-color: #f2f2f2; color: #555;">
	&nbsp;&nbsp;주소록 상세
	</div>
	
	<!-- 주소록 내용 -->
	<div id="content">
		<table id="addr_table">
			<tr>
				<td colspan="2" id="name" style="border-bottom: none;">${requestScope.addrvo.mbr_name}</td>				
			</tr>
			<tr>
				<td colspan="2" style="border-top: none;">
                	<input type="hidden" name="addr_seq" value="${requestScope.addrvo.addr_seq}" />   
            	</td>
			</tr>
			<tr>
				<th class="title">번호</th>
				<td>${requestScope.addrvo.mbr_phone_number}</td>
			</tr>
			<tr>
				<th class="title">이메일</th>
				<td>${requestScope.addrvo.mbr_email}&nbsp;&nbsp;<a href="mailto:'${requestScope.addrvo.mbr_email}'"><i class="far fa-paper-plane fa-2x" style="font-size: 14px; "></i></a></td>
			</tr>
			<tr>
				<th class="title">부서</th>
				<td>${requestScope.addrvo.dept_name}</td>
			</tr>
			<tr>
				<th class="title">직책</th>
				<td>${requestScope.addrvo.position_name}</td>
			</tr>
			<tr>
				<th class="title">생년월일</th>
				<td>${requestScope.addrvo.mbr_birthday}</td>
			</tr>
			<tr>
				<th class="title">주소</th>
				<td>${requestScope.addrvo.address}</td>
			</tr>
			<tr>
				<th class="title">상세주소</th>
				<td>${requestScope.addrvo.detailaddress}</td>
			</tr>
			<tr>
				<td colspan="2" class="title">메모</td>
			</tr>
			<tr>
				<td colspan="2">${requestScope.addrvo.addrmemo}</td>
			</tr>
		</table>
		
		<div style="margin-left: 350px;">
			<button type="button" class="btnaddr btn-basic" onclick="javascript:location.href='<%=ctxPath%>/totaladdrlist.opis'">목록</button>
		    <button type="button" class="btnaddr btn-ok" onclick="javascript:location.href='<%=ctxPath%>/addr_edit.opis?addr_seq=${requestScope.addrvo.addr_seq}'">수정</button>
		    <button type="button" class="btnaddr btn-basic" onclick="goDelete(${requestScope.addrvo.addr_seq})">삭제</button>
	  	</div>
	</div>
</div>