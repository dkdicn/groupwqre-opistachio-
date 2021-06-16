<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>	
<% String ctxPath = request.getContextPath(); %> 

<link rel="stylesheet" href="//code.jquery.com/ui/1.12.1/themes/base/jquery-ui.css">
<link rel="stylesheet" type="text/css" href="<%=ctxPath%>/resources/css/content.css" />   
<link rel="stylesheet" type="text/css" href="<%=request.getContextPath()%>/resources/css/workmanage.css" />  

<script src="https://code.jquery.com/jquery-1.12.4.js"></script>
<script src="https://code.jquery.com/ui/1.12.1/jquery-ui.js"></script>
<script src="<%=ctxPath%>/resources/js/workmanage.js"></script>

<jsp:include page="./workmanage_sidebar.jsp" />

<style type="text/css">
div.tdcontainer {
	 border: 1px solid blue;
	 margin-left: 280px;
}

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
	
	// 선택한 할일 상세보러가기
	function goDetailTodo(tdno) {
		var frm = document.detailFrm;
		frm.tdno.value = tdno;
	    frm.searchType.value = "${requestScope.paraMap.searchType}";
	    frm.searchWord.value = "${requestScope.paraMap.searchWord}";
	    
		frm.method = "get";
		frm.action = "<%=ctxPath%>/showDetailTodo.opis";
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
	
	// 업무 삭제하기 힘수
	function goTodoDel() {
		var delcheck = confirm("삭제하시겠습니까?");
		if (!delcheck) {
			return; // 삭제하지 않으면 함수 종료
		}
		
		var tdnoArr = []; // 체크박스에 선택된 업무 리스트 담기
		$("input.oneCheckbox").each(function(index, item){
			if ($(item).prop("checked") == true) {
				var tdno = $(item).val();
				tdnoArr.push(tdno);	
			}
		});
		var tdnoStr = tdnoArr.join();
		$("input[name=tdnoStr]").val(tdnoStr);
		
		// 삭제할 리스트 전송하기 (POST 방식)
		var frm = document.workInfoFrm;
		frm.method = "post";
		frm.action = "<%=ctxPath%>/workDel.opis";
		frm.submit();
	}
	
	// 할일 완료 버튼 클릭시 할일 상태 변경하는 함수
	function goTodoComplete() {
		var tdnoArr = []; // 체크박스에 선택된 할일 리스트 담기
		$("input.oneCheckbox").each(function(index, item){
			if ($(item).prop("checked") == true) {
				var tdno = $(item).val();
				tdnoArr.push(tdno);	
			}
		});
		
		// 선택을 하나도 하지 않았을 경우 경고
		if (tdnoArr.length == 0) {
			alert("하나 이상의 업무를 선택해주세요!");
			return; 
		}
		
		// 리스트 담기
		var tdnoStr = tdnoArr.join();
		$("input[name=tdnoStr]").val(tdnoStr);
		
		// 재확인
		var check = confirm("할일 완료 하시겠습니까?");
		if (!check) {
			return; // 취소시 함수 종료
		}
		
		// 수정할 리스트 전송하기 (POST 방식)
		var frm = document.workInfoFrm;
		frm.method = "post";
		frm.action = "<%=ctxPath%>/workStatusChangeToComplete.opis";
		frm.submit();
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
		frm.action = "<%=ctxPath%>/workList.opis";
		frm.submit();
	}
	
	
	// 검색된 조건들 고정시키는 함수 
	function setSearchInfo() {
		// 페이지 당 만들기
		var sizePerPage = "${requestScope.sizePerPage}";
		$("select[name=sizePerPage]").val(sizePerPage);
	}
</script>

<div class="container commoncontainer">
	<h3>나의 할 일</h3>

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
		</li>
	</ul>
	<input type="hidden" name="workStatus"/>
	<input type="hidden" name="gobackURL" value="${requestScope.gobackURL}"/>
	</form>
	
	<table class="table table-striped tdtable">
		<thead>
			<tr>
				<th><input type="checkbox" id="allCheckbox" onclick="clickAllCheckbox();" /></th>
				<th>번호</th>
				<!-- <th>중요</th> -->
				<th>제목</th>
				<th>등록일</th>
				<th>마감일</th>
				<th>상태</th>
			</tr>
		</thead>
		<tbody>
			<c:forEach var="todo" items="${requestScope.todoList}" varStatus="status">
				<tr>
					<td><input type="checkbox" class="oneCheckbox" value="${todo.tdno}" onclick="clickOneCheckbox(this);"/></td>
					<td>${todo.rno}</td>
					<!-- <td><img src="" alt="" /></td> -->
					<td><span class="todoSubject" onclick="goDetailTodo('${todo.tdno}')" style="cursor: pointer;">${todo.subject}</span></td>
					<td>${todo.registerday}</td>
					<td>${todo.deadline}</td>
					<td>
						<input type="hidden" value="${todo.delayday}"/>
						<button type="button" class="workStatus" value="${todo.fk_statno}"></button>
					</td>	
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
		<button type="button" class="workEditBtn btn btn-success" onclick="javascript:location.href='<%=ctxPath%>/workAdd.opis'">할일등록</button>
		<button type="button" class="workListBtn btn btn-default" onclick="goTodoComplete();">할일완료</button>
		<button type="button" class="workDeleteBtn btn btn-danger" onclick="goTodoDel();">삭제</button>
	</div>
	
	<!-- 상세한 업무 내용 보내기 폼 -->
	<form name="detailFrm">
		<input type="hidden" name="tdno" />
		<input type="hidden" name="fk_mbr_seq" value="${sessionScope.loginuser.mbr_seq}"/>
		<input type="hidden" name="searchType" />
      	<input type="hidden" name="searchWord" />
		<input type="hidden" name="gobackURL" value="${requestScope.gobackURL}" />
	</form>	
	
	<!-- 삭제버튼, 완료버튼 클릭시 전송할 업무 번호 폼 -->
	<form name="workInfoFrm">
		<input type="hidden" name="tdnoStr" />
		<input type="hidden" name="gobackURL" value="${requestScope.gobackURL}"/>
	</form>
</div>

