<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>   
 <%
String ctxPath = request.getContextPath();
%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>snsmain 페이지</title>

<link rel="stylesheet" type="text/css" href="<%= ctxPath%>/resources/css/snsmain.css"/>
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.3.1/jquery.min.js"></script>
<script type="text/javascript">
	
	$(document).ready(function(){
		
		/* func_hide_talkroom_list(); */
		
		$("input#searchWord").bind("keydown", function(event){
			if(event.keyCode == 13) {
				/* func_hide_talkroom_list(); */
				func_show_mbr_list();
				goSearch();
			}
			
		});
		
		$("select#mbr_stsconnect").bind("change", function(){
			func_select($(this).val());
		});
		
		$("img#btn_mbr_list").bind("click", function(){
			 func_show_mbr_list();
			/*  func_hide_talkroom_list(); */
		});
		
		$("img#btn_talkroom_list").bind("click", function(){
			/* func_hide_mbr_list(); 
			 func_show_talkroom_list();
			 goRoomlist(); */
			window.open("<%=ctxPath%>/sns/talkroom.opis","ë©ì ì ","width=401, height=601, toolbar=no, menubar=no, scrollbars=no, resizable=yes");
		});
		
		/* $("img#x").bind("click", function(){
			 /* func_hide_mbr_list(); 
			 func_show_talkroom_list();
			 goDelRoomlist();
		}); */
		
		
		
	});


	function goSearch() {
		var frm = document.searchFrm;
		frm.method = "get";
		frm.action = "<%= ctxPath%>/sns/snsmain.opis";
		frm.submit();
	}
	
	function func_select(mbr_stsconnect) {
		var frm = document.statusFrm;
		frm.method = "get";
		frm.action = "<%= ctxPath%>/sns/status.opis"
		frm.submit();
	}
	
	<%-- function goRoomlist(){
		$.ajax({
			url:"<%= ctxPath%>/talkroomlist.opis",
			data:{"fk_mbr_id":"${sessionScope.loginuser.mbr_id}"},
			type:"GET",
			dataType:"json",
			success:function(json){ 
				var html = "";
				
				$.each(json, function(index, item){
					
				html +=	"<div class='memberList'>";
				html += 	"<div class='constatus'>";
				html +=			"<img class='mainuserimg' src='<%= ctxPath%>/resources/images/nomaluserimg.png'  style='margin-left: 20px;'/>";
				html +=		"</div>";
				html +=		"<div class='userinforightside'>";
				html +=			"<span class='name'>"+item.room_name+"</span>";
				html +=		"</div>";
				html +=	"</div>";
				
				});
			
				$("div#talkroom_list").html(html);
			},
			error: function(request, status, error){
				alert("code: "+request.status+"\n"+"message: "+request.responseText+"\n"+"error: "+error);
		 	}
		});
	} --%>
	
	
	
	/* function func_hide_mbr_list() {
		$("div#mbr_list").hide();
	} */
	
	function func_show_mbr_list() {
		$("div#mbr_list").show();
	}
	
	/* function func_hide_talkroom_list() {
		$("div#talkroom_list").hide();
		$("img#plus").hide();
		$("img#x").hide();
		
	}
	
	function func_show_talkroom_list() {
		$("div#talkroom_list").show();
		$("img#x").show();
		$("img#plus").show();
	} */



</script>

<meta name="viewport" content="width=device-width, initial-scale=1">
  <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.1/css/bootstrap.min.css">
  <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
  <script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.1/js/bootstrap.min.js"></script>
  
</head>
<body>
	<!-- 주소는 <span style="color: blue;">${requestScope.address}</span> 입니다. -->
	<div class="snsmaincontainer">
		<div class="userinfo">
			<div class="userinfoside">
			<c:if test="${sessionScope.loginuser.mbr_img == 'nomaluserimg.png'}">
				<img class="mainuserimg" src="<%= ctxPath%>/resources/images/nomaluserimg.png"  style="margin-top: 20px; margin-left: 20px;"/>
			</c:if>
			<c:if test="${sessionScope.loginuser.mbr_img != 'nomaluserimg.png'}">
				<img class="mainuserimg" src="<%= ctxPath%>/resources/images/files/${sessionScope.loginuser.mbr_img}"  style="margin-top: 20px; margin-left: 20px;"/>
			</c:if>
			</div>
			<div class="userinfotop">
				<span class="username" >${sessionScope.loginuser.mbr_name}</span>
				<c:if test="${sessionScope.loginuser.fk_rank_no == 0}"><span class=userjobgrade> 팀원</span></c:if>
				<c:if test="${sessionScope.loginuser.fk_rank_no == 1}"><span class=userjobgrade> 팀장</span></c:if>
				<c:if test="${sessionScope.loginuser.fk_rank_no == 2}"><span class=userjobgrade> 대표</span></c:if> 
			    <form name="statusFrm" class="select" >
					<select name="mbr_stsconnect" id="mbr_stsconnect" style="height: 25px;">
						<option value="">
							<c:if test="${sessionScope.loginuser.mbr_stsconnect == 0}">오프라인 </c:if>
				    		<c:if test="${sessionScope.loginuser.mbr_stsconnect == 1}">온라인 </c:if>
				    		<c:if test="${sessionScope.loginuser.mbr_stsconnect == 2}">자리비움 </c:if>
				    		<c:if test="${sessionScope.loginuser.mbr_stsconnect == 3}">회의중 </c:if>
				    	</option>
						<option value="1">온라인</option>
						<option value="0">오프라인</option>
						<option value="2">자리비움</option>
						<option value="3">회의중</option>
					</select>
					<input type="hidden" class="form-control" id="mbr_id" name="mbr_id" value='${sessionScope.loginuser.mbr_id}'>
				</form>
				<img src="<%= ctxPath%>/resources/images/pencel.png" onclick="javascript:location.href='<%= ctxPath%>/sns/infochange.opis'" style="margin-left:8px; width: 25px; height: 25px; float: left;"/>
				
			</div>
			<div class=userinfobottom>
				<div class="well">${sessionScope.loginuser.mbr_stsmsg}</div>
			</div>
			
			
		</div>
		
		<div class="menu">
			<img class="menuimg" id="btn_mbr_list" src="<%= ctxPath%>/resources/images/menuuser.png" />
			<img class="menuimg" id="btn_talkroom_list" src="<%= ctxPath%>/resources/images/chat.png" />
			<%-- <img id = "x" src="<%= ctxPath%>/resources/images/x.png" style="margin-top:8px; margin-left:8px; width: 25px; height: 25px; float: right;"/>
			<img id = "plus" src="<%= ctxPath%>/resources/images/+.png" style="margin-top:8px; margin-left:8px; width: 25px; height: 25px; float: right;"/> --%>
		</div>
		
		<form name="searchFrm">
			<div class="input-group">
		      <input type="text" class="form-control" placeholder="사원검색" id="searchWord" name="searchWord" style="width:299px;">
		      <div class="input-group-btn">
		        <button class="btn btn-default" type="submit" onclick="goSearch()"><i class="glyphicon glyphicon-search"></i></button>
		      </div>
		    </div>
		</form>
		
		<div class="tflist" id="mbr_list">
			<c:forEach var="membervo" items="${requestScope.memberList}" varStatus="status"> 
				<div class="memberList">
					<div class="constatus">
					<c:if test="${membervo.mbr_stsconnect == 0}"><img class="constatus" src="<%= ctxPath%>/resources/images/offline.PNG" /></c:if>
					<c:if test="${membervo.mbr_stsconnect == 1}"><img class="constatus" src="<%= ctxPath%>/resources/images/online.PNG" /></c:if>
					<c:if test="${membervo.mbr_stsconnect == 2}"><img class="constatus" src="<%= ctxPath%>/resources/images/leave.PNG" /></c:if> 
					<c:if test="${membervo.mbr_stsconnect == 3}"><img class="constatus" src="<%= ctxPath%>/resources/images/conference.PNG" /></c:if>
						<c:if test="${membervo.mbr_img == 'nomaluserimg.png'}">
							<img class="mainuserimg" src="<%= ctxPath%>/resources/images/nomaluserimg.png"  style=" margin-left: 20px;"/>
						</c:if>
						<c:if test="${membervo.mbr_img != 'nomaluserimg.png'}">
							<img class="mainuserimg" src="<%= ctxPath%>/resources/images/files/${sessionScope.loginuser.mbr_img}"  style=" margin-left: 20px;"/>
						</c:if>
					</div>
					
					<div class="userinforightside">
						<span class="name">${membervo.mbr_name}</span> <span class="rank">${membervo.rank_detail}</span> <span class="stsmsg">${membervo.mbr_stsmsg}</span>
					</div>
					<div class="userinfobottom2" >
						<span class="dept">${membervo.dept_detail}</span>
					</div>
				</div>
			</c:forEach>
		</div>
		
		<div class="tflist" id="talkroom_list">
			
		</div>
		
	</div>
	
</body>
</html>