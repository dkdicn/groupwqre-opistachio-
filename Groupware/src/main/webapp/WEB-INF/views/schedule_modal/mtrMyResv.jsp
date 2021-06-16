<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<% String ctxPath = request.getContextPath(); %>
    
<meta charset="utf-8">
<meta name="viewport" content="width=device-width, initial-scale=1">

<style>
	
	#resvList {
		margin-top:30px;
		overflow: auto;
		width:650px;
		height:160px;
	}
	
	table, tr, th, td {
		font-size: 11pt;
		text-align:center !important;
	}
	
	#mtrBtns {
		margin-top: 30px;
		text-align:right;
		padding-right: 20px;
	}

	.cbtn {
		border: none;
		border-radius: 2pt;
		margin-right:5px;
		width:70px;
		height:30px;
		box-shadow: 1pt 1pt 1pt gray;
		font-weight: bold;
		cursor:pointer;
	}
	
	.btnCancel {
		background:#737373;
		color: white;
	}
	

	
</style>

<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.1/css/bootstrap.min.css">
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
<script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.1/js/bootstrap.min.js"></script>

<script type="text/javascript" src="<%=ctxPath%>/resources/js/jquery-3.3.1.min.js"></script>
<script type="text/javascript">
	
	$(document).ready(function(){
		
		func_select();
		
	});
	
	function func_cancel() {
	
		var checkArr = [];
		
		$("input#usemtrno[name=usemtrno]:checked").each(function(){
			checkArr.push($(this).val());
		});
		
		var totalCnt = checkArr.length;
		
		$.ajax({
			url:"<%=ctxPath%>/delMtrResv.opis",
		//	type:"post",
			data: {"checkArr":checkArr,
				   "totalCnt":totalCnt},
			dataType:"json",
			success:function(json) {
				if(json.m==1){
					alert("삭제되었습니다.");
					func_select();
				}
				else {
					alert("삭제에 실패하였습니다. 다시 시도해주세요.");
				}
			},
			error:function(request, status, error) {
				alert("code: "+request.status+"\n"+"message: "+request.responseText+"\n"+"error: "+error);
			}
		});
	}// end of function cancelMtr() {}----------------------------
	
	
	function func_select(){
		
		$("div#resvList").empty();
		var today = new Date();
		
		$.ajax({
			url:"<%=ctxPath%>/showMtrResv.opis",
			dataType:"json",
			success:function(json) {
				var html = 	"<table class='table table-striped'>" +
							"<thead>" +
							"<tr>" +
							"<th>선택</th>" +
							"<th>회의실명</th>" +
							"<th>예약자</th>" +
							"<th>예약명</th>" +
							"<th>시작시간</th>" +
							"<th>종료시간</th>" +
							"</tr>" +
							"</thead>";
				
				$.each(json,function(index, item){
					var starttime = item.starttime.substring(0,16);
					var endtime = item.endtime.substring(0,16);
					
					var endTm = new Date(item.endtime);
					
					if(today <= endTm){
					html += "<tbody id='listBody'>" +
							"<tr>"+
							"<td><input type='checkbox' name='usemtrno' id='usemtrno' value='"+item.usemtrno+"'/></td>"+
							"<td>"+item.mtrname+"</td>"+
							"<td>"+item.booker+"</td>"+
							"<td>"+item.mtrsubject+"</td>"+
							"<td>"+starttime+"</td>"+
							"<td>"+endtime+"</td>"+
							"</tr>" +
							"</tbody>";
					}
				});
				
				html += "</table>"
				
				$("div#resvList").html(html);
	
			},
			error:function(request, status, error) {
				alert("code: "+request.status+"\n"+"message: "+request.responseText+"\n"+"error: "+error);
			}
		});
	}// end of function func_select(){}------------------------
	 
	
</script>

<div id="container" class="container">
<h3 style="font-weight:bold;">${sessionScope.loginuser.mbr_name} 님의 예약내역</h3>
<hr>
	<div id="resvList"></div>
</div>

<div id="mtrBtns">
	<button type="button" class="cbtn btnCancel" onclick="func_cancel()">취소하기</button>
	<button type="button" class="cbtn" onclick="javascript:window.close();">닫기</button>
</div>