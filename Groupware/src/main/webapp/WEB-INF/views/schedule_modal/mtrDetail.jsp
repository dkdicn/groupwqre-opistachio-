<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<% String ctxPath = request.getContextPath(); %>    

<style>

	h2 {
		margin-top:15px;
		margin-left:10px;
	}
	
	
	table {
		margin-top:20px;
		margin-left:280px;
		margin-bottom:40px;
		border: solid 1px #e6e6e6;
	}
	
	table, tr, td {
		border-collapse: collapse;
	}
	
	#title {
		padding: 10px 20px 10px 50px;
		text-align: right;
		font-weight: bold;
	}
	
	#content {padding:0 50px 0 20px;}
	
	#icon {
		text-align: center;
	}
	
	#img {
		width:150px;
		height:150px;
	}
	
	#btns {
		text-align: center;
	}
	
	.btn {
		border:none;
		height:40px;
		border-radius:2pt;
		box-shadow:2pt 2pt 2pt grey;
		font-weight:bold;
	}
	
	.del {
		width: 100px;
		background:black;
		color:white;
	}
	
	.close {width: 50px;}
	.return {vertical-align:bottom;}
	
</style>

<script type="text/javascript">

	$(document).ready(function(){
		
	});

	function goDelReg() {
		var bool = confirm("예약을 취소하시겠습니까?");
		var frm = document.sendNum;
		
		if(bool) {
			
			frm.method = "POST";
			frm.action = "<%=ctxPath%>/mtrCancel.opis";
			frm.submit();
		}
	}// end of function goDelReg() {}--------------------
	
</script>

<div>
	<h2>회의실 예약 내역</h2>
	<hr>
	<br>
	<div id="icon">
		<img src="<%=ctxPath%>/resources/images/conversation.png" id="img"/>
	</div>
	<br>
	
	<c:if test="${not empty requestScope.mtrhvo}">
			<table>
				<tr>
					<td id="title">예약명</td>
					<td id="content">${requestScope.mtrhvo.mtrsubject}</td>
				</tr>
				<tr>
					<td id="title">회의실명</td>
					<td id="content">${requestScope.mtrname}</td>
				</tr>
				<tr>
					<td id="title">예약일자</td>
					<td id="content">${requestScope.mtrhvo.regDate}</td>
				</tr>
				<tr>
					<td id="title">예약시간</td>
					<td id="content">${requestScope.mtrhvo.starttime}&nbsp;-&nbsp;${requestScope.mtrhvo.endtime}</td>
				</tr>
			</table>
	</c:if>

	<c:if test="${empty requestScope.mtrhvo}">
		<div>해당 예약 내역은 존재 하지 않습니다.</div>
	</c:if>
	
	<form name="sendNum">
		<input type="hidden" name="usemtrno" value="${requestScope.usemtrno}"/>
	</form>
	
	<div id="btns">
		<button type="button" class="btn del" onclick="goDelReg()">예약취소하기</button>&nbsp;
		<button type="button" class="btn close" onclick="javascript:window.close();">닫기</button>&nbsp;
		<button type="button" class="btn return" onclick="javascript:location.href='<%=ctxPath%>/mtr_resv.opis'"><img id="returnimg" src="<%=ctxPath%>/resources/images/return.png"/></button>
	</div>
</div>