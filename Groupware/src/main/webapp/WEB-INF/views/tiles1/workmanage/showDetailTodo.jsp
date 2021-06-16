<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>	   
<% String ctxPath = request.getContextPath(); %>   

<link rel="stylesheet" href="//code.jquery.com/ui/1.12.1/themes/base/jquery-ui.css">
<link rel="stylesheet" href="/resources/demos/style.css">
<link rel="stylesheet" type="text/css" href="<%=request.getContextPath()%>/resources/css/workmanage.css" />
<link rel="stylesheet" type="text/css" href="<%=request.getContextPath()%>/resources/css/content.css" />    

<script src="https://code.jquery.com/jquery-1.12.4.js"></script>
<script src="https://code.jquery.com/ui/1.12.1/jquery-ui.js"></script>
<script src="<%=ctxPath%>/resources/js/workmanage.js"></script>

<jsp:include page="./workmanage_sidebar.jsp" />

<style type="text/css">
</style>

<script type="text/javascript">
	$(document).ready(function(){
		// 버튼 색상 적용하는 js 함수 호출
		$("button.workStatus").each(function(index, item){
			var delayday = $(item).prev().val();
			
			setworkStatusBtn(item, delayday);
		});	
	});
	
	// 할일 삭제하기 
	function goTodoDel() {
		var delcheck = confirm("삭제하시겠습니까?");
		if (!delcheck) {
			return; // 삭제하지 않으면 함수 종료
		}
		
		// 삭제할 업무 전송하기 (POST 방식)
		var frm = document.delFrm;
		frm.method = "post";
		frm.action = "<%=ctxPath%>/workDel.opis";
		frm.submit();
	}
	
	// 할일 수정하기
	function goTodoEdit() {
		var frm = document.editFrm;
		frm.method = "post";
		frm.action = "<%=ctxPath%>/workEdit.opis";
		frm.submit();
	}
</script>

<div class="container workcontainer commoncontainer">
	<h3>업무 조회</h3>

	<br>
	
	<table class="table table-striped workShowtable">
		<tbody>
			<tr>
				<td>제목</td>
				<td>${tdvo.subject}</td>
				<td>상태</td>
				<td>
					<input type="hidden" value="${tdvo.delayday}"/>
					<button type="button" class="workStatus" value="${tdvo.fk_statno}"></button>
				</td>
			</tr>
			<tr>
				<td>업무기한</td>
				<td colspan="3">${tdvo.registerday} ~ ${tdvo.deadline}</td>
			</tr>
			<tr>
				<td>내용</td>
				<td colspan="3"><div style="height:120px; overflow: auto;">${tdvo.contents}</div></td>
			</tr>
			<tr>
				<td>첨부파일</td>
				<td colspan="3">
					<c:forEach var="file" items="${requestScope.fileList}" varStatus="status">
						<c:if test="${sessionScope.loginuser != null}">
							<a href="<%=ctxPath%>/download.opis?orgFilename=${file.orgFilename}&fileName=${file.fileName}">${file.orgFilename}</a>
						</c:if>
						<br>
					</c:forEach>
				</td>
			</tr>
		</tbody>
	</table>
	
	<!-- 삭제할 업무 번호 폼 -->
	<form name="delFrm">
		<input type="hidden" name="tdnoStr" value="${tdvo.tdno}"/>
		<input type="hidden" name="gobackURL" value="${requestScope.paraMap.gobackURL}"/>
	</form>
	
	<!-- 수정할 업무 번호 폼 -->
	<form name="editFrm">
		<input type="hidden" name="tdno" value="${tdvo.tdno}"/>
		<input type="hidden" name="gobackWorkDetilURL" value="${gobackWorkDetilURL}"/>
	</form>
	
	<div align="right">
		<button type="button" class="workEditBtn btn btn-success" onclick="goTodoEdit();">수정</button>
		<button type="button" class="workDeleteBtn btn btn-danger" onclick="goTodoDel();">삭제</button>
		<button type="button" class="workListBtn btn btn-default" onclick="javascript:location.href='${requestScope.paraMap.gobackURL}'">목록</button>
	</div>
</div>

