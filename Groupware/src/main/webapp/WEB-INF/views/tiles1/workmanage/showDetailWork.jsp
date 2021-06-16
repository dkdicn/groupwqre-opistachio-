
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<% String ctxPath = request.getContextPath(); %>  

<link rel="stylesheet" href="//code.jquery.com/ui/1.12.1/themes/base/jquery-ui.css">
<link rel="stylesheet" type="text/css" href="<%=ctxPath%>/resources/css/content.css" />   
<link rel="stylesheet" type="text/css" href="<%=request.getContextPath()%>/resources/css/workmanage.css" />  

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
		
		var fk_wrno = "${requestScope.fk_wrno}";
		if (fk_wrno != 2) {
			mbrWorkStatusChange();	
		}
		else {
			$("input[name=gobackWorkDetilURL]").val("${requestScope.gobackWorkDetilURL}");
			getMyWorkStatus();	
		}
	});
	
	// 담당자별 업무처리 확인하기 
	function mbrWorkStatusChange() {
		var fk_mbr_seq = $("select#mbrListSelect").val();
		
		$.ajax({
			url:"<%=ctxPath%>/oneMbrWorkStatus.opis",
			data:{
				"fk_mbr_seq": fk_mbr_seq,
				"fk_wmno": "${workvo.wmno}",
				"fk_wrno":2},
			dataType:"json",
			success:function(json) {
				$("td#mbr_name").html(json.mbr_name);
				$("td#lasteditdate").html(json.lasteditdate);
				$("span#workPercent").html(json.workPercent);
				$("textarea.contents").html(json.contents);
				
				if (json.workPercent == null) $("span#workPercent").html("");
				if (json.contents == null) $("textarea.contents").html("");
			},
			error: function(request, status, error){
               	alert("code: "+request.status+"\n"+"message: "+request.responseText+"\n"+"error: "+error);
            }
		});
	}
	
	// 업무 삭제하기 
	function goWorkDel() {
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
	
	// 나의 업무처리내역 가져오기 
	function getMyWorkStatus() {
		var fk_mbr_seq = ${sessionScope.loginuser.mbr_seq};
		
		$.ajax({
			url:"<%=ctxPath%>/oneMbrWorkStatus.opis",
			data:{
				"fk_mbr_seq": fk_mbr_seq,
				"fk_wmno": "${workvo.wmno}",
				"fk_wrno":2},
			dataType:"json",
			success:function(json) {
				$("input[name=workmbr_seq]").val(json.workmbr_seq);
				$("input[name=workPercent]").val(json.workPercent);
				
				var lasteditdate = json.lasteditdate;
				
				// 이미 처리한 내역이 있다면 수정하기로 진행해야한다.
				if (lasteditdate == null) {
					$("button.recworkAddBtn").show();
					return;
				}
				else {
					$("button.recworkEditBtn").show();
					$("span#contentsText").hide();
					$("textarea[name=contents]").show();	// 내용입력보이기
				}
				
				// 수정한 날짜 넣어주기
				$("td#lasteditdate").html(json.lasteditdate);
				
				// 업무진행상황체크해주기
				var workPercent = json.workPercent;
				$("#processBtn > button").each(function(index, item){
					if ($(item).val() == workPercent) {
						$(item).css({"background-color": "#ffcccc"});
						$("input[name=workPercent]").val(workPercent);
						return false;
					}
				});
				$("span#processText").html(workPercent+"%");
				
				// 처리내역 넣어주기
				$("textarea[name=contents]").html(json.contents);
			},
			error: function(request, status, error){
               	alert("code: "+request.status+"\n"+"message: "+request.responseText+"\n"+"error: "+error);
            }
		});
	}
	
	// 업무처리하기버튼 클릭시
	function goRecworkAdd() {
		$("button.recworkAddBtn").hide(); 		// 업무처리하기버튼숨기기
		// $("span#processText").hide();
		$("span#contentsText").hide();
		
		$("#processBtn > button").show();
		$("textarea[name=contents]").prop("readonly", false);
		$("button.recworkAddEndBtn").show();	// 처리버튼보이기
		$("textarea[name=contents]").show();	// 내용입력보이기
	}
	
	// 업무수정하기버튼 클릭시
	function goRecworkEdit() {
		$("button.recworkEditBtn").hide(); 		// 업무수정하기버튼숨기기
		$("span#processText").hide();
		
		$("#processBtn > button").show();
		$("textarea[name=contents]").prop("readonly", false);
		$("button.recworkEditEndBtn").show();	// 수정버튼보이기
	}
	
	// 처리버튼 클릭시 form 전송 (insert)
	function goRecworkAddEnd() {
		var frm = document.workRegFrm;
		frm.method = "post";
		frm.action = "<%=ctxPath%>/receiverWorkAdd.opis";
		frm.submit();
	}
	
	// 수정버튼 클릭시 form 전송 (update)
	function goRecworkEditEnd() {
		var frm = document.workRegFrm;
		frm.method = "post";
		frm.action = "<%=ctxPath%>/receiverWorkEdit.opis";
		frm.submit();
	}
	
	// 내가 요청한 업무에 대해 수정하기 할 때
	function goWorkEdit() {
		var frm = document.editFrm;
		frm.method = "post";
		frm.action = "<%=ctxPath%>/workEdit.opis";
		frm.submit();
	}
</script>


<div class="container commoncontainer">
	<c:if test="${fk_wtno == 1}">
		<c:if test="${fk_wrno == 1}"><h3>내가 한 업무 요청 조회</h3></c:if>
		<c:if test="${fk_wrno == 2}"><h3>수신 업무 요청 조회</h3></c:if>
		<c:if test="${fk_wrno == 3}"><h3>참조 업무 요청 조회</h3></c:if>
	</c:if>
	
	<c:if test="${fk_wtno == 2}">
		<c:if test="${fk_wrno == 1}"><h3>내가 한 업무 보고 조회</h3></c:if>
		<c:if test="${fk_wrno == 2}"><h3>수신 업무 보고 조회</h3></c:if>
		<c:if test="${fk_wrno == 3}"><h3>참조 업무 보고 조회</h3></c:if>
	</c:if>

	<br>
	
	<div style="height:630px; overflow: auto; padding-right: 10px;">
	<table class="table table-striped workShowtable">
		<tbody>
			<tr>
				<td>제목</td>
				<td>${workvo.subject}</td>
				
				<td>상태</td>
				<td>
					<input type="hidden" value="${workvo.delayday}"/>
					<button type="button" class="workStatus" value="${workvo.fk_statno}"></button>	
				</td>
			</tr>
			<tr>
				<td>지시자</td>
				<td colspan="3">${workvo.requester}</td>
			</tr>
			<tr>
				<td>업무기한</td>
				<td colspan="3">${workvo.registerday} ~ ${workvo.deadline}</td>
			</tr>
			<tr>
				<td>등록일</td>
				<td>${workvo.registerday}</td>
				
				<td>수정일</td>
				<td>${workvo.lasteditdate}</td>
			</tr>
			<tr>
				<td>수신자</td>
				<td colspan="3">${workvo.receivers}</td>
			</tr>
			<tr>
				<td>참조자</td>
				<td colspan="3">${workvo.referrers}</td>
			</tr>
			<tr>
				<td>내용</td>
				<td colspan="3"><div style="height:120px; overflow: auto;">${workvo.contents}</div></td>
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
		<input type="hidden" name="wmnoStr" value="${workvo.wmno}"/>
		<input type="hidden" name="fk_wtno" value="${fk_wtno}"/>
		<input type="hidden" name="fk_wrno" value="${fk_wrno}"/>
		<input type="hidden" name="gobackURL" value="${requestScope.paraMap.gobackURL}"/>
	</form>
	
	<!-- 수정할 업무 번호 폼 -->
	<form name="editFrm">
		<input type="hidden" name="wmno" value="${workvo.wmno}"/>
		<input type="hidden" name="gobackWorkDetilURL" value="${gobackWorkDetilURL}"/>
	</form>
	
	<!-- 처리내역 테이블 페이지 -->
	<c:if test="${requestScope.fk_wrno ne 2}"><jsp:include page="./readDetail.jsp" /></c:if>
	<c:if test="${requestScope.fk_wrno eq 2}"><jsp:include page="./writeDetail.jsp" /></c:if>
	</div>
	
	<!-- 업무 관련 버튼 -->
	<div align="right">
		<c:if test="${requestScope.fk_wrno eq 1}">
			<button type="button" class="workEditBtn btn btn-success" onclick="goWorkEdit();">업무수정</button>
			<button type="button" class="workDeleteBtn btn btn-danger" onclick="goWorkDel();">삭제</button>
			<button type="button" class="workListBtn btn btn-default" onclick="javascript:location.href='${requestScope.paraMap.gobackURL}'">목록</button>
		</c:if>
		
		<c:if test="${requestScope.fk_wrno eq 2}">
			<button type="button" class="recworkAddBtn btn btn-success" onclick="goRecworkAdd();" hidden>업무처리하기</button>
			<button type="button" class="recworkEditBtn btn btn-success" onclick="goRecworkEdit();" hidden>처리내역수정하기</button>
			<button type="button" class="recworkAddEndBtn btn btn-success" onclick="goRecworkAddEnd();" hidden>처리</button>
			<button type="button" class="recworkEditEndBtn btn btn-success" onclick="goRecworkEditEnd();" hidden>수정</button>
			<button type="button" class="workListBtn btn btn-default" onclick="javascript:location.href='${requestScope.paraMap.gobackURL}'">목록</button>
		</c:if>
		
		<c:if test="${requestScope.fk_wrno eq 3}">
			<button type="button" class="workDeleteBtn btn btn-danger" onclick="goWorkDel();">삭제</button>
			<button type="button" class="workListBtn btn btn-default" onclick="javascript:location.href='${requestScope.paraMap.gobackURL}'">목록</button>
		</c:if>
	</div>
	
	
</div>

