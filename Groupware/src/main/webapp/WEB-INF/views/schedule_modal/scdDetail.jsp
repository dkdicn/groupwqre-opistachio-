<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<% String ctxPath = request.getContextPath(); %>

<meta charset="utf-8">
<meta name="viewport" content="width=device-width, initial-scale=1">


<style>
	
	h2 {
		margin-top: 15px;
		margin-left:10px;
	}
	
	table, td, tr {
		border-top: solid 1px #e6e6e6;
		border-bottom: solid 1px #e6e6e6;
		border-collapse: collapse;
		margin-left: 100px;
	}
	
	#title {
		border-right:solid 3px #006080;
		padding: 10px 20px 10px 10px;
		text-align: right;
		font-weight: bold;
	}
	
	#content {padding:0 30px 0 30px;}
	
	#btns {padding: 10px 40px 0 0;}
	
	.btn {
		margin-right: 3px;
		border: none;
		box-shadow: 2px 2px 2px gray;
		width: 50px;
		height:30px;
		border-radius: 2pt;
		cursor: pointer;
		font-size: 10pt;
		font-weight: bold;
	}
	
	.modify {
		background:#ffd633;
		color: white;
	}
	
	.modify:hover {
		border: solid 2px #ffd633;
		background:white;
		color: #ffd633;
	}
	
	.del {
		background:#0099cc;
		color: white;
	}
	
	.del:hover {
		border: solid 2px #0099cc;
		background:white;
		color: #2d5986;
	}
	
	#btnMtrResv {
		border: none;
		background:#006080;
		font-weight:bold;
		color:white;
		height:25px;
		cursor:pointer;
		border-radius:2pt;
		box-shadow: 1pt 1pt 1pt gray;
	}
	
	#btnMtrResv:hover {
		border: solid 2px #006080;
		background: white;
		color: #006080;
	}
	
	.return {
		vertical-align:bottom;
		background:#f2f2f2;
	}
	
</style>

<script type="text/javascript" src="<%=ctxPath%>/resources/js/jquery-3.3.1.min.js"></script>
<script type="text/javascript">

	$(document).ready(function(){
		
		var startdate= '${requestScope.schedulevo.scdstartdate}';
		var enddate = '${requestScope.schedulevo.scdenddate}';
		
		var sdate = startdate.substring(0,16);
		var edate = enddate.substring(0,16);
		
		
		$("span#sTime").html(sdate);
		$("span#eTime").html(edate);
		
	});


	function goDelScd() {
		var bool = confirm("정말 삭제하시겠습니까?");
		
		if(bool) {
			
			var frm = document.scdDetail;
			frm.method = "POST";
			frm.action = "<%=ctxPath%>/delScd.opis";
			frm.submit();
			
		}
		
	}// end of function goDelScd() {}----------------------
	
	function goClose() {
		window.close();
	}
	
	function goResvMtr() {
		
		var url = "<%=ctxPath%>/mtr_resv.opis";
		window.open(url, "sendParentsVal","left=350px, top=100px, width=900px, height=650px");
		
		var sendfrm = document.sendParentsVal;
		sendfrm.action = url;
		sendfrm.method = "post";
		sendfrm.target = "sendParentsVal";
		sendfrm.submit();
	}
	
</script>


<div>
	<h2>일정 상세 내역</h2>
	<hr align="left" style="margin-left:10px; width:600px;">
	
	<div style="text-align:center;">
		<img src="<%=ctxPath%>/resources/images/checkall.png" style="width:110px; height:110px;"/>
	</div>
	
	<c:if test="${not empty requestScope.schedulevo}">
	<div class="container">
		<form name="scdDetail">
			<table>
				<tr>
					<td id="title">일정구분</td>
					<td id="content">
						<input type="hidden" name="scdno" value="${requestScope.schedulevo.scdno}"/>
						<input type="hidden" name="fk_mbr_seq" value="${requestScope.schedulevo.fk_mbr_seq}" />
						<c:if test="${requestScope.schedulevo.fk_scdno2 eq 0}">전체일정</c:if>
						<c:if test="${requestScope.schedulevo.fk_scdno2 eq 1}">부서일정</c:if> 
						<c:if test="${requestScope.schedulevo.fk_scdno2 eq 2}">개인일정</c:if>
					</td>
				</tr>	
				<tr>
					<td id="title">일정명</td>
					<td id="content">${requestScope.schedulevo.scdsubject}</td>
				</tr>
				<tr>
					<td id="title">일자</td>
					<td id="content">
						<c:choose>
							<c:when test="${requestScope.schedulevo.scdstartTm != null and requestScope.schedulevo.scdendTm != null}">
								${requestScope.schedulevo.scdstartdate}&nbsp;${requestScope.schedulevo.scdstartTm} ~ ${requestScope.schedulevo.scdenddate}&nbsp;${requestScope.schedulevo.scdendTm}
							</c:when>
							<c:otherwise>
								<span id="sTime"></span>&nbsp;~&nbsp;<span id="eTime"></span>
							</c:otherwise>
						</c:choose>
					</td>
				</tr>
				<tr>	
					<td id="title">위치</td>
					<td id="content">
						<c:if test="${requestScope.schedulevo.place eq null || requestScope.schedulevo.place eq ''}"><span>미정</span></c:if>
						<c:if test="${requestScope.schedulevo.place ne null && requestScope.schedulevo.place ne ''}">${requestScope.schedulevo.place}</c:if>
						<button type="button" id="btnMtrResv" onclick="goResvMtr()">회의실 예약하기</button>
					</td>
				</tr>
				<tr>
					<td id="title">참석자</td>
					<td id="content">
						<c:if test="${requestScope.schedulevo.attendance eq null || requestScope.schedulevo.attendance eq ''}"><span>없음</span></c:if>
						<c:if test="${requestScope.schedulevo.attendance ne null && requestScope.schedulevo.attendance ne ''}">${requestScope.schedulevo.attendance}</c:if>
					</td>
				</tr>
			</table>
		</form>
	</div>
	</c:if>
	
	<c:if test="${empty requestScope.schedulevo}">
		<div>해당 일정은 존재 하지 않습니다.</div>
	</c:if>
	
		<div align="right" id="btns">
			
			<button type="button" class="btn modify" onclick="javascript:location.href='<%=ctxPath%>/editScd.opis?scdno=${requestScope.schedulevo.scdno}'">수정</button>
			<button type="button" class="btn del" onclick="goDelScd()">삭제</button>
			
			<button type="button" class="btn return" onclick="javascript:location.href='<%=ctxPath%>/scd_register.opis'"><img id="returnimg" src="<%=ctxPath%>/resources/images/return.png"/></button>
			<button type="button" class="btn close" onclick="goClose()">닫기</button> 
		</div>

	<form name="sendParentsVal">
		<input type="hidden" id="parent" name="scdno" value="${requestScope.schedulevo.scdno}"/>
	</form>

</div>