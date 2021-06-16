<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<% String ctxPath = request.getContextPath(); %>

<!DOCTYPE html>
<html lang="en">
<head>
<title>내 일정</title>
<meta charset="utf-8">
<meta name="viewport" content="width=device-width, initial-scale=1">
  
<link rel="stylesheet" type="text/css" href="<%=request.getContextPath() %>/resources/css/menu.css" />
<link rel="stylesheet" type="text/css" href="<%=request.getContextPath()%>/resources/css/content.css" />    
<link href='<%=ctxPath%>/resources/fullcalendar-5.7.0/lib/main.css' rel='stylesheet' />

<jsp:include page="./myscd_sidebar.jsp" />

<style>

  #user_img {
  	padding: 0px 20px;
  	vertical-align: bottom; 
  }
  
</style>

	
<script src='<%=ctxPath%>/resources/fullcalendar-5.7.0/lib/main.js'></script>

<script type="text/javascript">

		document.addEventListener('DOMContentLoaded', function() {
	        var calendarEl = document.getElementById('calendar');
	        var calendar = new FullCalendar.Calendar(calendarEl, {
	        	initialView: 'dayGridMonth',
	        	timeZone:'local',
	        	headerToolbar: {
		        	left: 'prev,next today',
		        	center: 'title',
		        	right: 'dayGridMonth,timeGridWeek,timeGridDay'
	        	},
	        	editable: true,
	        	allDaySlot: false,
				contentHeight: 600,
	        	weekNumbers:true,
	        	businessHours: {
	        		  daysOfWeek: [ 1, 2, 3, 4, 5 ], // 월 - 금
					  startTime: '09:00',
	        		  endTime: '18:00',
	        	},
	        	navLinks: true,
	        	nowIndicator: true,
	        	eventLimit: true,
	            eventLimitText: "more",
	            eventLimitClick: "popover",
	            dayPopoverFormat: { year: 'numeric', month: 'long', day: 'numeric' },
	            events:function(info, successCallback, failureCallback) {
	        		 $.ajax({
	     				url:"<%=ctxPath%>/scdList.opis",
	     				dataType:"json",
	     				success:function(json){
	     					var scdArr = [];
	     						
	     						$.each(json, function(index,item){
	     							
	     							var startdate = item.scdstartdate.substring(0,10)+"T"+item.scdstartdate.substring(11,19);
	     							var enddate = item.scdenddate.substring(0,10)+"T"+item.scdenddate.substring(11,19);
	     							
	     							scdArr.push({title:item.scdsubject,
	     									start:startdate,
	     									end:enddate,
	     									url:"<%=ctxPath%>/showDetail.opis?scdno="+item.scdno})
	     						});
	     						successCallback(scdArr);
	     				},
	     				error:function(request,status,error) {
	     					alert("code: "+request.status+"\n"+"message: "+request.responseText+"\n"+"error: "+error);
	     				}
	     			});// end of $.ajax({})------------------------
	        	},
	        	eventClick: function(info) {
	        		var eventObj = info.event;
	        		if (eventObj.url) {
	        		    window.open(eventObj.url,"","left=350px, top=100px, width=700px, height=455px");
						info.jsEvent.preventDefault(); 
	        		 } else {
	        		        alert('일정명: ' + eventObj.title +'\n'+
	        		        	  '시간: ' + eventObj.start +' ~ '+ eventObj.end);
	        		 }    
	        	},
	        	dayMaxEventRows: true, 
	        	views: {
	        	    timeGrid: {
	        	      dayMaxEventRows: 6 
	        	    }
	        	},
	        	locale:'ko'
	        });
	        calendar.render();
	 });// end of document.addEventListener('DOMContentLoaded', function()----------------------
		
		 
</script>
</head>
<body>

<div class="commoncontainer" style="width:86% !important;">
   
	<div id="headerInfo">
		<table>
			<tr>
				<td id="user_img"><img src="<%=ctxPath%>/resources/images/menuuser.png" style="width:30px; height:30px;" /></td>
				<td style="padding:20px 0 0px 10px;"><span style="color:#008ae6; font-weight:bold;">${sessionScope.loginuser.mbr_name}</span>&nbsp;님의 일정</td>
			</tr>
		</table>
	</div>
	<hr>
	<div id='calendar' style="padding:10px 20px;"></div>
	
</div>
</body>
</html>
