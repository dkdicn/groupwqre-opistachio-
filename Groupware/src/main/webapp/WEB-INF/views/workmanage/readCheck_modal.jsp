<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<meta name="viewport" content="width=device-width, initial-scale=1">
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.1/css/bootstrap.min.css">
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
<script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.1/js/bootstrap.min.js"></script>
<script src="<%=request.getContextPath()%>/resources/js/workmanage.js"></script>

<style type="text/css">
li {
	margin-bottom: 10px;
}

button {
	color: white;
	width: 100px; 
	border: none;
	font-size: 10pt;
}	
</style>

<script type="text/javascript">
	$(document).ready(function() {
		
		$("button.workStatus").each(function(index, item){
			var delayday = ${requestScope.paraMap.delayday};
			setworkStatusBtn(item, delayday)
		});
		
		setworkStatusMbrBtn();
	});
</script>

<div class="container">
	<ul style="list-style: none; padding: 0;">
		<li>■ 업무상태 : <button type="button" class="workStatus" value="${requestScope.paraMap.fk_statno}"></button></li>
		<li>■ 담당자 별 처리 현황</li>
	</ul>    
	
	<table class="table table-striped">
		<thead>
			<tr style="border-top: solid 2px #f2f2f2;">
				<th>담당자</th>
				<th>구분</th>
				<th>확인일시</th>
			</tr>
		</thead>
		<tbody>
			<c:forEach var="workmbr" items="${requestScope.workmbrList}">
				<tr>
					<td>${workmbr.mbr_name}</td>
					<td>
						<c:if test="${workmbr.fk_wrno == 2}">담당자</c:if>
						<c:if test="${workmbr.fk_wrno == 3}">참조자</c:if>
					</td>
					<td>${workmbr.readcheckdate}</td>
				</tr>
			</c:forEach>
		</tbody>
	</table>
</div>