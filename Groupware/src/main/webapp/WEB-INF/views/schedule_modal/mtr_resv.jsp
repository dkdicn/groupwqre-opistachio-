<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<% String ctxPath = request.getContextPath(); %>

<meta charset="utf-8">
<meta name="viewport" content="width=device-width, initial-scale=1">

<style type="text/css">
	
	#container {margin: 25px;}
	
	table {float:right;}
	
	td {padding-bottom: 10px;}
	
	#title {
		font-weight: bolder;
		font-size:12pt;
		padding-right:15px;
		text-align:right;
	}
	
	#select_section {margin: 20px 0;}
	
	#btn_section {margin: 20px 0;}
	
	.btn {
		border:none;
		font-size:12pt;
		font-weight: bold;
		border-radius:2pt;
		width:80px;
		height:40px;
		box-shadow:2pt 2pt 2pt gray;
		cursor: pointer;
	}
	
	.btnResv {
		background: black;
		color: white;
	}
	
	#booker {border:none;}
	
	#search {
		border: none;
		background: #666;
		color:white;
		vertical-align: bottom;
		height:22px;
		border-radius:1pt;
		cursor: pointer;
	}
	
	#cancelResv {
		background: #737373;
		color: white;
	}
	
</style>

<link rel="stylesheet" href="http://code.jquery.com/ui/1.12.1/themes/base/jquery-ui.css">
<link rel="stylesheet" href="/resources/demos/style.css">
<script src="https://code.jquery.com/jquery-1.12.4.js"></script>
<script src="https://code.jquery.com/ui/1.12.1/jquery-ui.js"></script>

<script type="text/javascript" src="https://www.gstatic.com/charts/loader.js"></script>

<script type="text/javascript">
	
	$(document).ready(function(){
		
		func_resvList();
		
		$("button#btnResv").click(function(){
			
			var frm = document.mtrRegFrm;
			frm.method = "POST";
			frm.action = "<%=ctxPath%>/resvMtrEnd.opis";
			frm.submit();
		});
		
		$("button#search").click(function(){
			
		});
		
		$("#datepicker").datepicker({
	           dateFormat: 'yy-mm-dd' //달력 날짜 형태
	           ,showOtherMonths: true //빈 공간에 현재월의 앞뒤월의 날짜를 표시
	           ,showMonthAfterYear:true // 월- 년 순서가아닌 년도 - 월 순서
	           ,changeYear: true //option값 년 선택 가능
	           ,changeMonth: true //option값  월 선택 가능                
	           ,yearSuffix: "년" //달력의 년도 부분 뒤 텍스트
	           ,monthNamesShort: ['1월','2월','3월','4월','5월','6월','7월','8월','9월','10월','11월','12월'] //달력의 월 부분 텍스트
	           ,monthNames: ['1월','2월','3월','4월','5월','6월','7월','8월','9월','10월','11월','12월'] //달력의 월 부분 Tooltip
	           ,dayNamesMin: ['일','월','화','수','목','금','토'] //달력의 요일 텍스트
	           ,dayNames: ['일요일','월요일','화요일','수요일','목요일','금요일','토요일'] //달력의 요일 Tooltip
	           ,minDate: "-3Y" //최소 선택일자(-1D:하루전, -1M:한달전, -1Y:일년전)
	           ,maxDate: "+3y" //최대 선택일자(+1D:하루후, -1M:한달후, -1Y:일년후)  
	       });                    
	       
	       //초기값을 오늘 날짜로 설정해줘야 합니다.
	       $('#datepicker').datepicker('setDate', 'today'); //(-1D:하루전, -1M:한달전, -1Y:일년전), (+1D:하루후, -1M:한달후, -1Y:일년후)            
	   
		
	});// end of $(document).ready(function(){
	
	
	function func_resvList(){
		
		var mtrArr = [];
		$.ajax({
	    	url:"<%=ctxPath%>/showRegMtr.opis",
	    	dataType:"json",
	    	success:function(json) {
	    		
	    		var date = document.getElementById('datepicker').value;
	    		$.each(json,function(index,item){
	    			var starttime = item.starttime.substring(0,10);
	    			
	    			if(starttime == date){
	    				var startyear = item.starttime.substring(0,4);
		    			var startmonth = item.starttime.substring(5,7);
		    			var startday = item.starttime.substring(8,10);
		    			var starth = item.starttime.substring(11,13);
		    			
		    			var endyear = item.endtime.substring(0,4);
		    			var endmonth = item.endtime.substring(5,7);
		    			var endday = item.endtime.substring(8,10);
		    			var endh = item.endtime.substring(11,13);
		    		
	    				mtrArr.push([item.mtrname, item.mtrsubject, new Date(0,0,0,starth,0,0), new Date(0,0,0,endh,0,0)])	
	    			}

	    		});// end of $.each(json,function(index,item){})-----------
	    		
	    	},
	    	error:function(request,status,error) {
	    		  alert("code: "+request.status+"\n"+"message: "+request.responseText+"\n"+"error: "+error);
	    	}
	    });// end of $.ajax({})----------------------------------------
	 	
	    google.charts.load("current", {packages:["timeline"]});
		google.charts.setOnLoadCallback(drawChart);
		function drawChart() {
			var container = document.getElementById('example5.1');
		    var chart = new google.visualization.Timeline(container);
		    var dataTable = new google.visualization.DataTable();
		    dataTable.addColumn({ type: 'string', id: 'Room' });
		    dataTable.addColumn({ type: 'string', id: 'Subject' });
		    dataTable.addColumn({ type: 'date', id: 'Start' });
		    dataTable.addColumn({ type: 'date', id: 'End' });
		    dataTable.addRows(mtrArr);
		    
			    var options = {
			      timeline: { colorByRowLabel: true }
			    };
 
		    chart.draw(dataTable, options);
		  }// end of function drawChart() {}------------------------
		  
	}// end of function func_resvList(){}--------------------------
	
	function goCancelResv() {
		var url = "<%=ctxPath%>/CancelResv.opis";
		window.open(url, "goCancel","left=350px, top=100px, width=675px, height=360px");
	}
	
	
</script>

<div id="container">
<h2>회의실 예약하기</h2>
<hr>

	<div>
		<span style="font-size:9pt;">*회의일자 변경 시 조회 버튼을 클릭하셔야 해당 날짜의 예약 리스트가 조회됩니다.</span><br>
		<span style="font-size:9pt; color:red; font-weight:bold;">*회의실 이용가능 시간은 오전 9시 부터 오후 6시 까지 입니다.</span>
	</div>
<form name="mtrRegFrm">
	<div id="search_date" align="right" style="padding-bottom:10px">
		<span style="font-size:12pt; font-weight:bold;">예약일자</span>&nbsp;&nbsp;
		<input type="text" id="datepicker" name="regDate" size="10" autocomplete="off" readonly/>
		<button type="button" id="search">조회</button>
	</div>

	<div id="example5.1" style="height: 300px;"></div>

	<div id="select_section" align="left">
		<table>
			<tr>
				<td id="title">예약명</td>
				<td>
					
					<c:if test="${requestScope.scdno eq null}">
						<input type="text" name="mtrsubject" placeholder="예약명 입력" required/>
					</c:if>
					<c:if test="${requestScope.scdno ne null}">
						<input type="hidden" id="child" name="fk_scdno" value="${requestScope.scdno}"/>
						<input type="text" name="mtrsubject" value="${requestScope.scdsubject}" />
					</c:if>
				</td>
			</tr>
			<tr>
				<td id="title">예약자명</td>
				<td>
				<input type="text" name="booker" id="booker" value="${sessionScope.loginuser.mbr_id}" readonly/>
				</td>
			</tr>
			<tr>
				<td id="title">회의실명</td>
				<td>
					<select name="fk_mtrno">
						<option>회의실 선택</option>
						<option value="1">마포룸</option>
						<option value="2">강서룸</option>
						<option value="3">송파룸</option>
						<option value="4">구로룸</option>
						<option value="5">용산룸</option>
						<option value="6">영등포룸</option>
					</select>
				</td>
			</tr>
			<tr>
				<td id="title">예약 시간</td>
				<td>
					<select id="time1" name="starttime">
						<option>시작 시간</option>
						<c:forEach var="i" begin="9" end="17">
							<c:set var="startTm" value="${i>9?i:'0'}${i>9?'':i}"/>
							<option value="${i>9?i:'0'}${i>9?'':i}:00" <c:if test="${data.startDispTm eq startTm}">selected</c:if>>${i>9?i:'0'}${i>9?'':i}:00</option>
						</c:forEach>
					</select>	
					<span>&nbsp;~&nbsp;</span>
					<select id="time2" name="endtime">
						<option>종료 시간</option>
						<c:forEach var="i" begin="10" end="18">
							<c:set var="endTm" value="${i>9?i:'0'}${i>9?'':i}"/>
							<option value="${i>9?i:'0'}${i>9?'':i}:00" <c:if test="${data.endDispTm eq endTm}">selected</c:if>>${i>9?i:'0'}${i>9?'':i}:00</option>
						</c:forEach>
					</select>
				</td>
			</tr>
		</table>
	</div>
	<div style="clear:both;"></div>
	
	<div id="btn_section" align="right">
		<button type="button" class="btn btnResv" id="btnResv">예약하기</button>&nbsp;
		<button type="button" class="btn cancelResv" id="cancelResv" onclick="goCancelResv()">예약취소</button>&nbsp;
		<button type="button" class="btn" onclick="javascript:window.close()">닫기</button>
	</div>

</form>

</div>

