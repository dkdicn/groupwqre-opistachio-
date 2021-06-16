<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<% String ctxPath = request.getContextPath(); %>

<link rel="stylesheet" type="text/css" href="<%=ctxPath %>/resources/css/boardButtons.css">
<style type="text/css">

#searchMbr_table{
	width: 90%;
	margin: 20px 0 0 20px;
    font-size: 15px;
	border-top: 3px solid black;
 	border-bottom: 3px solid black;
}

#searchMbr_table th, td{
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
	margin: 20px 0 0 0;
}

.title{
	font-size: 17px;
	font-weight: 600;
}

</style>

<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>

<script type="text/javascript">

	function addMbrAddr(){
		
		var hpArr = $("#sMbr_phone_number").val().split("-");
		
		$("#mbrSeq", opener.document).val($("#sMbr_seq").val());
		$("#mbr_name", opener.document).val($("#sMbr_name").val());
		$("#hp2", opener.document).val(hpArr[1]);
		$("#hp3", opener.document).val(hpArr[2]);
		$("#mbr_email", opener.document).val($("#sMbr_email").val());
		$("#dept_name", opener.document).val($("#sMbr_dept_name").val());
		$("#position_name", opener.document).val($("#sMbr_position_name").val());
		$("#mbr_birthday", opener.document).val($("#sMbr_birthday").val());

		window.close();
		
	}// end of addMbrAddr()------------------------------------------

</script>

<div>
	<table id="searchMbr_table">
	<c:forEach var="sMbrList" items="${searchMbrList}">
		<c:if test="${not empty searchMbrList}">
			<tr>
				<td colspan="2" id="name" style="border-bottom: none;">
					${sMbrList.mbr_name}
					<input type="hidden" id="sMbr_name" value="${sMbrList.mbr_name}" />
				</td>				
			</tr>
			<tr>
				<td colspan="2" style="border-top: none;">
	               	<input type="hidden" id="sMbr_seq" value="${sMbrList.mbr_seq}" />   
	           	</td>
			</tr>
			<tr>
				<th class="title">번호</th>
				<td>
					${sMbrList.mbr_phone_number}
					<input type="hidden" id="sMbr_phone_number" value="${sMbrList.mbr_phone_number}" />
				</td>
			</tr>
			<tr>
				<th class="title">이메일</th>
				<td>
					${sMbrList.mbr_email}
					<input type="hidden" id="sMbr_email" value="${sMbrList.mbr_email}" />
				</td>
			</tr>
			<tr>
				<th class="title">부서</th>
				<td>
					${sMbrList.dept_detail}
					<input type="hidden" id="sMbr_dept_name" value="${sMbrList.dept_detail}" />
				</td>
			</tr>
			<tr>
				<th class="title">직책</th>
				<td>
					${sMbrList.rank_detail}
					<input type="hidden" id="sMbr_position_name" value="${sMbrList.rank_detail}" />
				</td>
			</tr>
			<tr>
				<th class="title">생년월일</th>
				<td>
					${sMbrList.mbr_birthday}
					<input type="hidden" id="sMbr_birthday" value="${sMbrList.mbr_birthday}" />
				</td>
			</tr>
		</c:if>
	</c:forEach>
	<c:if test="${empty searchMbrList}">
		<tr>
			<td><span>해당 사원번호의 사원이 존재하지 않습니다.</span></td>
		</tr>
	</c:if>
	
	</table>	
	<div align="center">
		<button type="button" class="btn-ok btnaddr" onclick="addMbrAddr()">확인</button>
	   	<button type="button" class="btn-basic btnaddr" onclick="window.close()">취소</button>
	</div>
</div>