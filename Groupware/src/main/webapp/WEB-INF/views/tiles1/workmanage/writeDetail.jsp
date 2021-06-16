<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>	
<% String ctxPath = request.getContextPath(); %>

<style type="text/css">
#processBtn > button {
	width: 80px;
	height: 25px;
	border: solid 1px black;
	background-color: white;
}
</style>

<script type="text/javascript">
	$(document).ready(function(){
		$("#processBtn > button").click(function(){
			$("#processBtn > button").each(function(index, item){
				$(item).css({"background-color": "#ffffff"});	
			});
			
			$(this).css({"background-color": "#ffcccc"});
			$("input[name=workPercent]").val($(this).val());
		});
		
		// 버튼 숨겨두기
		$("#processBtn > button").hide();
		$("textarea[name=contents]").hide();
	});
	
	
</script>



<form name="workRegFrm">
	<table class="table table-striped workShowtable">
		<thead>
			<tr style="background: #f2f2f2;">
				<th colspan="4">처리내역</th>
			</tr>
		</thead>
		<tbody>
			<tr>
				<td>수신자</td>
				<td>${sessionScope.loginuser.mbr_name}</td>
				
				<td>최종수정일</td>
				<td id="lasteditdate"></td>
			</tr>
			<c:if test="${fk_wtno == 1}">
				<tr>
					<td>진척률</td>
					<td colspan="3" id="processBtn">
						<button type="button" value="0">0%</button>
						<button type="button" value="20">20%</button>
						<button type="button" value="40">40%</button>
						<button type="button" value="60">60%</button>
						<button type="button" value="80">80%</button>
						<button type="button" value="100">100%</button>
						<span id="processText"></span>
					</td>
				</tr>
			</c:if>
			<tr>
				<td>내용</td>
				<td colspan="3">
					<textarea cols="70" rows="5" name="contents" readonly="readonly"></textarea>
					<span id="contentsText">처리내역이 없습니다.</span>
				</td>
			</tr>
		</tbody>
	</table>
	<input type="hidden" name="workPercent" />
	<input type="hidden" name="workmbr_seq"/>
	<input type="hidden" name="fk_wtno" value="${fk_wtno}"/>
	<input type="hidden" name="gobackWorkDetilURL" value="${requestScope.gobackWorkDetilURL}"/>
</form>

	 