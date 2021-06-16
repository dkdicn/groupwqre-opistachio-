<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<% String ctxPath = request.getContextPath(); %>

<meta charset="utf-8">
<meta name="viewport" content="width=device-width, initial-scale=1">

<style type="text/css">

	#listup {
		overflow:auto;
		margin: 10px;
		height: 270px;
		width: 560px;
		margin-left:30px;
	}
	
	table, th, td, tr {
		text-align: center !important;
		border-collapse: collapse;
		font-size: 11pt;
	}
	
	th {padding: 10px;}
	
	td {
		text-align: center;
		padding: 10px;
	}
	
	#search {text-align: center;}
	
	#searchType {height: 25.5px;}
	
	#searchImg {
		width:20px;
		height:20px;
	}
	
	#btns {
		text-align:right;
		margin-top: 10px;
		margin-right: 50px;
	}
	
	.cbtn {
		border:none;
		border-radius: 2pt;
		font-weight: bold;
		width : 50px;
		height: 30px;
		box-shadow: 1pt 1pt 1pt gray;
	}
	
	.ok {
		background:black;
		color: white;
	}
	
	#sendBtn {padding-left: 40px;}
	
</style>

<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.1/css/bootstrap.min.css">
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
<script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.1/js/bootstrap.min.js"></script>

<script type="text/javascript" src="<%=ctxPath%>/resources/js/jquery-3.3.1.min.js"></script>
<script type="text/javascript">

	$(document).ready(function() {
		
		
		
		$("input:checkbox[name=seq]").click(function(){
			
			var seqList = "";
			var nameList= "";
			
			$("input[name=seq]:checked").each(function() {
				
				seqList += $(this).val();
				nameList += $(this).parent().next().next().next().text();
				
				seqList += ",";
				nameList += ",";
			});
			
			seqLists = seqList.substr(0, seqList.length-1);
			nameLists = nameList.substr(0, nameList.length-1);
			
			$("input.getSeq").val(seqLists);
			$("input.getName").val(nameLists);
			
			console.log(seqList);
			console.log(nameList);
		});
		
		
		$("input#searchWord").bind("keydown", function(){
			if(event.keyCode == 13) {
				goSearch();
			}
		});
		
		// 검색시 검색조건 및 검색어 값 유지시키기
		if(${not empty requestScope.paraMap}){
			$("select#searchType").val("${requestScope.paraMap.searchType}");
			$("input#searchWord").val("${requestScope.paraMap.searchWord}");
		}
		
		
			
	});// end of $(document).ready(function() {}---------------------------------- 
	
	function goSearch() {
		var frm = document.searchFrm;
		frm.action = "<%=ctxPath%>/showAddresslist_work.opis";
		frm.submit();
	}		
			
	function sendtoParent() {
		var html = "";
		var targetUl = "${requestScope.targetUl}";
		
		$("input[name=seq]:checked").each(function(index, item) {
			var seq = $(item).val();
			var name = $(item).parent().next().next().next().text();
			
			if (targetUl == "receiversUl") {
				html += '<li type="text" class="receiverName">'+name;
				html += '<input type="hidden" class="receiverName" value="'+name+'"/>';
				html += '<input type="hidden" class="receiverSeq" value="'+seq+'"/>';
				html += '<span class="close" onclick="nameDel(this);">&times;</span></li>';	
			}
			else {
				html += '<li type="text" class="referrerName">'+name;
				html += '<input type="hidden" class="referrerName" value="'+name+'"/>';
				html += '<input type="hidden" class="referrerSeq" value="'+seq+'"/>';
				html += '<span class="close" onclick="nameDel(this);">&times;</span></li>';
			}
		});
		
		opener.document.getElementById(targetUl).innerHTML = html;
		window.close();
	}
	
	
</script>

<div id="container">
<h3 style="margin-top:20px; margin-left:20px;">사원찾기</h3>
<hr>
	
	<div id="search">	
		<form name="searchFrm">
			<select name="searchType" id="searchType" >
				<option value="mbr_name">이름</option>
				<option value="dept_detail">부서</option>
			</select>
			
			<input type="text" name="searchWord" id="searchWord" size="20" autocomplete="off">
			<a href="#" onclick="goSearch()"><img src="<%=ctxPath%>/resources/images/icon_search.png" id="searchImg"/></a>
			
			<input type="hidden" name="targetUl" value="${requestScope.targetUl}"/>
		</form>
	</div>	

	<div id="listup">
		<table class="table table-striped">
			<tr>
				<th>선택</th>
				<th>번호</th>
				<th width="30%">부서</th>
				<th width="40%">이름</th>
			</tr>	
			
			<c:forEach var="member" items="${requestScope.memberList}" varStatus="status">
				<tr>
					<td><input type="checkbox" id="chkbox" name="seq" value="${member.mbr_seq}" /></td>
					<td>${status.count}</td>
					<td>${member.dept_detail}</td>
					<td>${member.mbr_name}</td>
				</tr>
			</c:forEach>
		</table>
	</div>
	<div style="margin-left: 30px;">
		선택한 사원 : 
		<input type="text" class="getName" id="mbr_name" name="mbr_name" style="border: none; width: 80%;" />
	</div>
</div>	


<div id="btns">
	<button type="button" class="cbtn ok" onclick="sendtoParent()">확인</button>
	<button type="button" class="cbtn" onclick="javascript:window.close();">닫기</button>
</div>
	