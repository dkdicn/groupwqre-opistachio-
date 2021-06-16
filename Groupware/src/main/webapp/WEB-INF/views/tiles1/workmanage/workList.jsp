<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>	
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>

<% String ctxPath = request.getContextPath(); %>

<link rel="stylesheet" href="//code.jquery.com/ui/1.12.1/themes/base/jquery-ui.css">
<link rel="stylesheet" href="/resources/demos/style.css">
<link rel="stylesheet" type="text/css" href="<%=ctxPath%>/resources/css/content.css" />   

<script src="https://code.jquery.com/jquery-1.12.4.js"></script>
<script src="https://code.jquery.com/ui/1.12.1/jquery-ui.js"></script>
<script src="<%=ctxPath%>/resources/js/workmanage.js"></script>

<jsp:include page="./workmanage_sidebar.jsp" />

<style type="text/css">
ul#todoSelectCondition {
	list-style-type: none;
	display: table;
}

ul#todoSelectCondition>li {
	display: inline-block;
	margin-right: 20px;
	vertical-align: middle;
}

ul#todoSelectCondition input[type=text] {
	width: 150px;
}

div.checkWorkStatus>label, div.checkWorkStatus>input {
	width: 50px;
	text-align: center;
}

.ui-datepicker-trigger, .searchImg {
	width: 25px;
	height: 25px;
	margin-left: 5px;
}

button.workStatus {
	width: 100px;
	height: 25px;
	color: white;
	border: none;
}

button.readCheck {
	background-color: white;
	border-style: groove;
	border: solid 1px;
}
</style>


<script>
	$(document).ready(function() {
		setSearchInfo();
		
		$("#datepicker_reg").datepicker({
			showOn : "button",
			buttonImage : "<%=request.getContextPath()%>/resources/images/icon_calendar.png",
			buttonImageOnly : true,
			buttonText : "Select date",
			dateFormat: 'yy-mm-dd'
		});
		
		$("#datepicker_dead").datepicker({
			showOn : "button",
			buttonImage : "<%=request.getContextPath()%>/resources/images/icon_calendar.png",
			buttonImageOnly : true,
			buttonText : "Select date",
			dateFormat: 'yy-mm-dd'
		});
		
		// 버튼 색상 적용하는 js 함수 호출
		$("button.workStatus").each(function(index, item){
			var delayday = $(item).prev().val();
			
			setworkStatusBtn(item, delayday);
		});
		
		$(document).on("click", ".workStatus", function () {
		     var subject = $(this).data('subject');
		     var wmno = $(this).data('wmno');
		     var fk_statno = $(this).data('stat');
		     var delayday = $(this).data('delay');
		     
		     $("h4#workStatus-title").text( subject );
		     $("#workStatusModal").find("iframe").attr("src", "workStatusModal.opis?wmno="+wmno+"&fk_statno="+fk_statno+"&delayday="+delayday);
		});
		
		$(document).on("click", ".readCheck", function () {
		     var subject = $(this).data('subject');
		     var wmno = $(this).data('wmno');
		     var fk_statno = $(this).data('stat');
		     var delayday = $(this).data('delay');
		     
		     $("h4#readCheck-title").text( subject );
		     $("#readCheckModal").find("iframe").attr("src", "readCheckModal.opis?wmno="+wmno+"&fk_statno="+fk_statno+"&delayday="+delayday);
		});
		
		
		// 검색시 검색조건 및 검색어 값 유지시키기
		if (${not empty requestScope.paraMap}) {
			// 검색조건 및 검색어
			$("select#searchType").val("${requestScope.paraMap.searchType}");
			$("input#searchWord").val("${requestScope.paraMap.searchWord}");
			
			// 검색 날짜 조건 
			$("input#datepicker_reg").val("${requestScope.paraMap.registerday}");
			$("input#datepicker_dead").val("${requestScope.paraMap.deadline}");
			
			// 업무 상태 조건
			var workStatusArr = "${requestScope.paraMap.str_workStatus}".split(",");
			for (var i=0; i<workStatusArr.length; i++) {
				$("input.searchWorkStatus").each(function(index, item){
					if ($(item).val() == workStatusArr[i]) {
						$(item).prop("checked", true);
					}
				});
			}
		}
	});
	
	// 업무 상세보기 함수
	function goDetailWork(wmno) {
		<%-- location.href="<%=request.getContextPath()%>/showDetailWork.opis?fk_wtno="+${fk_wtno}+"&fk_wrno="+${fk_wrno}+"&wmno="+wmno; --%>
		var frm = document.detailFrm;
		frm.wmno.value = wmno;
	    frm.searchType.value = "${requestScope.paraMap.searchType}";
	    frm.searchWord.value = "${requestScope.paraMap.searchWord}";
	    
		frm.method = "get";
		frm.action = "<%=ctxPath%>/showDetailWork.opis";
		frm.submit();
	}
	
	// 업무 삭제하기 힘수
	function goWorkDel() {
		var delcheck = confirm("삭제하시겠습니까?");
		if (!delcheck) {
			return; // 삭제하지 않으면 함수 종료
		}
		
		var wmnoArr = []; // 체크박스에 선택된 업무 리스트 담기
		$("input.oneCheckbox").each(function(index, item){
			if ($(item).prop("checked") == true) {
				var wmno = $(item).val();
				wmnoArr.push(wmno);	
			}
		});
		var wmnoStr = wmnoArr.join();
		$("input[name=wmnoStr]").val(wmnoStr);
		
		// 삭제할 업무 리스트 전송하기 (POST 방식)
		var frm = document.workInfoFrm;
		frm.method = "post";
		frm.action = "<%=ctxPath%>/workDel.opis";
		frm.submit();
	}
	
	// 업무 완료 버튼 클릭시 업무 상태 변경하는 함수
	function goWorkComplete() {
		var wmnoArr = []; // 체크박스에 선택된 업무 리스트 담기
		$("input.oneCheckbox").each(function(index, item){
			if ($(item).prop("checked") == true) {
				var wmno = $(item).val();
				wmnoArr.push(wmno);	
			}
		});
		
		// 업무 선택을 하나도 하지 않았을 경우 경고
		if (wmnoArr.length == 0) {
			alert("하나 이상의 업무를 선택해주세요!");
			return; 
		}
		
		// 업무 리스트 담기
		var wmnoStr = wmnoArr.join();
		$("input[name=wmnoStr]").val(wmnoStr);
		
		// 업무완료 재확인
		var check = confirm("업무 완료 하시겠습니까?");
		if (!check) {
			return; // 취소시 함수 종료
		}
		
		// 수정할 업무 리스트 전송하기 (POST 방식)
		var frm = document.workInfoFrm;
		frm.method = "post";
		frm.action = "<%=ctxPath%>/workStatusChangeToComplete.opis";
		frm.submit();
	}
	
	
	// 전체선택 체크 박스를 클릭했을 때 
	function clickAllCheckbox() {
		// input#allCheckbox ==> 전체선택 체크박스  id="allCheckbox"
		// input.oneCheckbox ==> 하위선택 체크박스  class="oneCheckbox"
		
		var stat = $("input#allCheckbox").prop("checked");
		
		$("input.oneCheckbox").each(function(index, item){
			$(item).prop("checked", stat);
		});
	}
	
	// 하위 체크박스를 클릭했을 때
	function clickOneCheckbox(target) {
		// onclick="clickOneCheckbox(this)";
		
		var stat = $(target).prop("checked");
		
		if (!stat) { // 체크가 풀린 경우라면
			$("input#allCheckbox").prop("checked", false);
		}
		else {
			var check; // 다른 하위 체크박스 검사
			$("input.oneCheckbox").each(function(index, item){
				check = $(item).prop("checked");
				if (check == false) {
					return false;
				}
			});
			if (check) { // 전부 true 일 때
				$("input#allCheckbox").prop("checked", true);	
			}
		}
	}
	
	// 검색 조건을 가지고 검색하러 가는 함수 
	function goSearch() {
		// 업무 검색을 위한 체크박스 중 선택한 것들 담기
		var searchWorkStatusArr = []; 
		$("input.searchWorkStatus").each(function(index, item) {
			if ($(item).prop("checked") == true) {
				searchWorkStatusArr.push($(item).val());
			}
		});
		var str_searchWorkStatus = searchWorkStatusArr.join();
		$("input[name=workStatus]").val(str_searchWorkStatus);
		
		var frm = document.searchFrm;
		frm.method = "get";
		frm.action = "<%=ctxPath%>/workList.opis";
		frm.submit();
	}
	
	
	// 검색된 조건들 고정시키는 함수 
	function setSearchInfo() {
		// 페이지 당 만들기
		var sizePerPage = "${requestScope.sizePerPage}";
		$("select[name=sizePerPage]").val(sizePerPage);
	}
	
	// 업무일괄 처리 100%로 상태 변경
	function goWorkPercentComplete() {
		var wmnoArr = []; // 체크박스에 선택된 업무 리스트 담기
		$("input.oneCheckbox").each(function(index, item){
			if ($(item).prop("checked") == true) {
				var wmno = $(item).val();
				wmnoArr.push(wmno);	
			}
		});
		
		// 업무 선택을 하나도 하지 않았을 경우 경고
		if (wmnoArr.length == 0) {
			alert("하나 이상의 업무를 선택해주세요!");
			return; 
		}
		
		// 업무 리스트 담기
		var wmnoStr = wmnoArr.join();
		$("input[name=wmnoStr]").val(wmnoStr);
		
		// 업무완료 재확인
		var check = confirm("업무 처리 하시겠습니까?");
		if (!check) {
			return; // 취소시 함수 종료
		}
		
		// 수정할 업무 리스트 전송하기 (POST 방식)
		var frm = document.workInfoFrm;
		frm.method = "post";
		frm.action = "<%=ctxPath%>/workPercentChangeToComplete.opis";
		frm.submit();
	}
	
	// 읽음 처리 버튼 클릭시 
	function goReadCheckComplete() {
		var wmnoArr = []; // 체크박스에 선택된 업무 리스트 담기
		$("input.oneCheckbox").each(function(index, item){
			if ($(item).prop("checked") == true) {
				var wmno = $(item).val();
				wmnoArr.push(wmno);	
			}
		});
		
		// 업무 선택을 하나도 하지 않았을 경우 경고
		if (wmnoArr.length == 0) {
			alert("하나 이상의 업무를 선택해주세요!");
			return; 
		}
		
		// 업무 리스트 담기
		var wmnoStr = wmnoArr.join();
		$("input[name=wmnoStr]").val(wmnoStr);
		
		// 업무완료 재확인
		var check = confirm("읽음 처리 하시겠습니까?");
		if (!check) {
			return; // 취소시 함수 종료
		}
		
		// 수정할 업무 리스트 전송하기 (POST 방식)
		var frm = document.workInfoFrm;
		frm.method = "post";
		frm.action = "<%=ctxPath%>/workReadCheckChangeToComplete.opis";
		frm.submit();
	}
	
	function goWorkStatusChangeToBack() {
		var wmnoArr = []; // 체크박스에 선택된 업무 리스트 담기
		$("input.oneCheckbox").each(function(index, item){
			if ($(item).prop("checked") == true) {
				var wmno = $(item).val();
				wmnoArr.push(wmno);	
			}
		});
		
		// 업무 선택을 하나도 하지 않았을 경우 경고
		if (wmnoArr.length == 0) {
			alert("하나 이상의 업무를 선택해주세요!");
			return; 
		}
		
		// 업무 리스트 담기
		var wmnoStr = wmnoArr.join();
		$("input[name=wmnoStr]").val(wmnoStr);
		
		// 업무완료 재확인
		var check = confirm("반려 처리 하시겠습니까?");
		if (!check) {
			return; // 취소시 함수 종료
		}
		
		// 수정할 업무 리스트 전송하기 (POST 방식)
		var frm = document.workInfoFrm;
		frm.method = "post";
		frm.action = "<%=ctxPath%>/workStatusChangeToBack.opis";
		frm.submit();
	}
</script>

<div class="container commoncontainer">
	<c:if test="${fk_wtno == 1}">
		<c:choose>
			<c:when test="${fk_wrno == 1}"><h3>내가 한 업무 요청</h3></c:when>
			<c:when test="${fk_wrno == 2}"><h3>수신 업무 요청</h3></c:when>
			<c:when test="${fk_wrno == 3}"><h3>참조 업무 요청</h3></c:when>
		</c:choose>
	</c:if>
	
	<c:if test="${fk_wtno == 2}">
		<c:choose>
			<c:when test="${fk_wrno == 1}"><h3>내가 한 업무 보고</h3></c:when>
			<c:when test="${fk_wrno == 2}"><h3>수신 업무 보고</h3></c:when>
			<c:when test="${fk_wrno == 3}"><h3>참조 업무 보고</h3></c:when>
		</c:choose>
	</c:if>
	<hr>

	<form name="searchFrm">
	<ul id="todoSelectCondition">
		<li>
			<select id="selectViewCount" name="sizePerPage" onchange="goSearch();">
				<option value="3">3줄</option>
				<option value="5">5줄</option>
				<option value="10">10줄</option>
			</select>
		</li>

		<li>전체 <span>${requestScope.totalCount}</span></li>
		
		<li>
			<div class="checkWorkStatus">
				<label for="delay">지연</label> 
				<label for="noncomplete">미완료</label> 
				<label for="complete">완료</label>
			</div>
			<div class="checkWorkStatus">
				<input type="checkbox" id="delay" class="searchWorkStatus" value="0"/> 
				<input type="checkbox" id="noncomplete" class="searchWorkStatus" value="1"/>
				<input type="checkbox" id="complete" class="searchWorkStatus" value="2"/>
			</div>
		</li>

		<li>
			<input type="text" id="datepicker_reg" name="registerday"/> ~ 
			<input type="text" id="datepicker_dead" name="deadline" />
		</li>
		
		<li>
			<select id="searchType" name="searchType" >
				<option value="">선택</option>
				<option value="subject">제목</option>
				<option value="contents">내용</option>
			</select>
		</li>

		<li>
			<input type="text" id="searchWord" name="searchWord" />
			<button type="button" onclick="goSearch();" >검색</button>
			<%-- <img class="searchImg" src="<%=request.getContextPath()%>/resources/images/icon_search.png" alt="searchImg" /> --%>
		</li>
	</ul>
	<input type="hidden" name="fk_wtno" value="${fk_wtno}"/>
	<input type="hidden" name="fk_wrno" value="${fk_wrno}"/>
	<input type="hidden" name="workStatus"/>
	</form>
	
	<table class="table table-striped tdtable">
		<thead>
			<tr>
				<th><input type="checkbox" id="allCheckbox" onclick="clickAllCheckbox();" /></th>
				<th>번호</th>
				<th>제목</th>
				<c:if test="${fk_wrno == 1}">
					<c:if test="${fk_wtno == 1}"><th>담당자</th></c:if>
					<c:if test="${fk_wtno == 2}"><th>수신자</th></c:if>
				</c:if>
				<c:if test="${fk_wrno == 2 or fk_wrno == 3}">
					<c:if test="${fk_wtno == 1}"><th>요청자</th></c:if>
					<c:if test="${fk_wtno == 2}"><th>보고자</th></c:if>
				</c:if>
				<th>등록일</th>
				<th>마감일</th>
				<th>상태</th>
				<th>확인</th>
			</tr>
		</thead>
		<tbody>
			
			<c:forEach var="work" items="${requestScope.workList}" varStatus="status">
				<tr>
					<td><input type="checkbox" class="oneCheckbox" value="${work.wmno}" onclick="clickOneCheckbox(this);"/></td>
					<td>${work.rno}</td>
					<td><span class="workSubject" onclick="goDetailWork('${work.wmno}')" style="cursor: pointer;">${work.subject}</span></td>
					
					<c:if test="${fk_wrno == 1}"><td>${work.receivers}</td></c:if>
					<c:if test="${fk_wrno == 2 or fk_wrno == 3}"><td>${work.requester}</td></c:if>
					
					<td>${work.registerday}</td>
					<td>${work.deadline}</td>
					<td>
						<input type="hidden" value="${work.delayday}"/>
						<button type="button" class="workStatus" value="${work.fk_statno}" data-toggle="modal" data-target="#workStatusModal"
										data-subject="${work.subject}" data-wmno="${work.wmno}" data-delay="${work.delayday}" data-stat="${work.fk_statno}"></button>
					</td>
					
					<c:if test="${work.checkstatus == 0}">
						<td><button type="button" class="readCheck" data-toggle="modal" data-target="#readCheckModal"
									data-subject="${work.subject}" data-wmno="${work.wmno}" data-delay="${work.delayday}" data-stat="${work.fk_statno}">읽음확인</button></td>
					</c:if>
					<c:if test="${work.checkstatus == 1}">
						<td><button type="button" class="readCheck" data-toggle="modal" data-target="#readCheckModal"
									data-subject="${work.subject}" data-wmno="${work.wmno}" data-delay="${work.delayday}" data-stat="${work.fk_statno}">미확인</button></td>
					</c:if>
				</tr>
			</c:forEach>
		</tbody>
	</table>
	
	<!-- 페이지바 보여주기 -->
	<div align="center" style="width:70%; border:solid 0px gray; margin:20px auto;">
		${requestScope.pageBar}
	</div>
	
	
	<!-- 업무 관련 버튼 -->
	<div align="right">
		<c:if test="${fk_wrno == 1}">
			<button type="button" class="workEditBtn btn btn-success" onclick="javascript:location.href='<%=ctxPath%>/workAdd.opis'">업무등록</button>
			<button type="button" class="workListBtn btn btn-default" onclick="goWorkComplete();">업무완료</button>
		</c:if>
		<c:if test="${fk_wrno == 2 and fk_wtno == 1}"><button type="button" class="workListBtn btn btn-success" onclick="goWorkPercentComplete()">업무처리</button></c:if>
		<c:if test="${fk_wrno == 2 and fk_wtno == 2}"><button type="button" class="workListBtn btn btn-success" onclick="goWorkStatusChangeToBack()">반려처리</button></c:if>
		<c:if test="${fk_wrno == 2 or fk_wrno == 3}"><button type="button" class="workListBtn btn btn-default" onclick="goReadCheckComplete()">읽음처리</button></c:if>
		<button type="button" class="workDeleteBtn btn btn-danger" onclick="goWorkDel();">삭제</button>
	</div>
	
	<!-- 상세한 업무 내용 보내기 폼 -->
	<form name="detailFrm">
		<input type="hidden" name="wmno" />
		<input type="hidden" name="searchType" />
      	<input type="hidden" name="searchWord" />
      	<input type="hidden" name="fk_wtno" value="${fk_wtno}"/>
		<input type="hidden" name="fk_wrno" value="${fk_wrno}"/>
		<input type="hidden" name="gobackURL" value="${requestScope.gobackURL}" />
	</form>	
	
	<!-- 삭제버튼, 완료버튼 클릭시 전송할 업무 번호 폼 -->
	<form name="workInfoFrm">
		<input type="hidden" name="wmnoStr" />
		<input type="hidden" name="fk_wtno" value="${fk_wtno}"/>
		<input type="hidden" name="fk_wrno" value="${fk_wrno}"/>
		<input type="hidden" name="gobackURL" value="${requestScope.gobackURL}"/>
	</form>
	
	<!-- Modal -->
	<div id="workStatusModal" class="modal fade" role="dialog">
		<div class="modal-dialog">

			<!-- Modal content-->
			<div class="modal-content">
				<div class="modal-header">
					<button type="button" class="close" data-dismiss="modal">&times;</button>
					<h4 class="modal-title" id="workStatus-title"></h4>
				</div>
				<div class="modal-body">
					<iframe style="border:none; width: 100%; height: 250px;" src="" ></iframe>
				</div>
				<div class="modal-footer">
					<button type="button" class="btn btn-default" data-dismiss="modal">Close</button>
				</div>
			</div>
		</div>
	</div>
	
	<!-- Modal -->
	<div id="readCheckModal" class="modal fade" role="dialog">
		<div class="modal-dialog">

			<!-- Modal content-->
			<div class="modal-content">
				<div class="modal-header">
					<button type="button" class="close" data-dismiss="modal">&times;</button>
					<h4 class="modal-title"  id="readCheck-title">\</h4>
				</div>
				<div class="modal-body">
					<iframe style="border:none; width: 100%; height: 250px;" src="" ></iframe>
				</div>
				<div class="modal-footer">
					<button type="button" class="btn btn-default" data-dismiss="modal">Close</button>
				</div>
			</div>
		</div>
	</div>	
</div>

