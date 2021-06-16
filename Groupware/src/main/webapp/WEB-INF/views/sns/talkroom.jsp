<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.net.InetAddress"%>    
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%
	String ctxPath = request.getContextPath();

	// 서버 ip 알아오기
	InetAddress inet = InetAddress.getLocalHost(); 
	String serverIP = inet.getHostAddress();
	// 서버 포트 번호 알아오기
	int portnumber = request.getServerPort();
	String serverName = "http://"+serverIP+":"+portnumber; 
	System.out.println("serverName : " + serverName);
%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<link rel="stylesheet" type="text/css" href="<%= ctxPath%>/resources/css/snsmain.css"/>
<style type="text/css">

div.snsmaincontainer {
	border: 1px solid black;
	display: inline-block;
	width: 400px;
	height: 600px;
	background-color:#b0c4d5;
}

div.roominfo {
	<!--border: 1px solid blue;-->
	display: inline-block;
	width:400px;
	height: 100px;
	background-color:#8aa9c1;
}

div.talk {
	width:400px;
	height: 400px;
}

div.talkinput {
	border: 1px solid black;
	display: inline-block;
	width:400px;
	height: 100px;
	background-color:white;
	float: bottom;
}

img.iconimg {
	width: 20px; 
	height: 20px; 
	float: left; 
	margin-left:  10px; 
	margin-top: 10px;
}

div.icon {
	<!--border: 1px solid red;-->
	float: top;
	height: 35px;
}

textarea.tArea {
	<!--border: 1px solid blue;-->
	resize: none;
	float: left;
	height: 65px;
	width: 300px;
	
}

input.inputsearch {
	width:180px; 
	float: left;
	margin-top: 20px;
	height: 30px;
}

button.btn-success {
	float: right;
	margin-top: 10px; 
	margin-right: 20px;
}

</style>
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.3.1/jquery.min.js"></script>
<script type="text/javascript">

	$(document).ready(function(){  
	   var url = window.location.host; // 웹브라우저의 주소창의 포트까지 가져옴 
	   var pathname = window.location.pathname; // '/'부터 오른쪽에 있는 모든 경로
	   var appCtx = pathname.substring(0, pathname.lastIndexOf("/"));  // "전체 문자열".lastIndexOf("검사할 문자"); 
	   var root = url+appCtx;
	   var wsUrl = "ws://"+root+"/talkroomstart.opis"; 
	 
	   var websocket = new WebSocket(wsUrl);
	
	    
	   var messageObj = {}; 
	    
	   websocket.onopen = function(){
		  	        
	    };
	    
	    
	    // === 메시지 수신시 콜백함수 정의하기 === 
	    websocket.onmessage = function(event) {
			if(event.data.substr(0,1)=="「" && event.data.substr(event.data.length-1)=="」") { 
				$("div#connectingUserList").html(event.data);
			}
			else {
	          $("div#talk").append(event.data);
	          $("div#talk").append("<br/>");
	          $("div#talk").scrollTop(99999999);
			}
	    };
		    
		    
		 // === 웹소캣 연결 해제시 콜백함수 정의하기 === 
	     websocket.onclose = function() {
	     }
		    
		    
	     // 메시지 입력후 엔터하기 
	     $("textarea#talkuser").keyup(function (key) {
	         if (key.keyCode == 13) {
	             $("input#btnSendMessage").click();
	         }
	     });
		    
	     
	     // 메시지 보내기
	     $("button#btnSendMessage").click(function() {
	         if( $("textarea#talkuser").val() != "") {
	             
	             var messageVal = $("textarea#talkuser").val();
	             messageVal = messageVal.replace(/<script/gi, "&lt;script"); 
	             // 크로스사이트 스크립트 공격을 막으려고 한 것임.
	         	
	             messageObj = {};
	             messageObj.message = messageVal;
	             messageObj.type = "all";
	             messageObj.to = "all";
	           
	             websocket.send(JSON.stringify(messageObj));
	             // JSON.stringify() 는 값을 그 값을 나타내는 JSON 표기법의 문자열로 변환한다
	             
	             $("div#talk").append("<span style='color: black; font-weight:bold; float: right; margin-right: 5px;'>" + messageVal + "</span><br/>");
	             $("div#talk").scrollTop(99999999);
	              
	             $("textarea#talkuser").val("");
	         }
	     });
	});

</script>

<meta name="viewport" content="width=device-width, initial-scale=1">
  <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.1/css/bootstrap.min.css">
  <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
  <script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.1/js/bootstrap.min.js"></script>
</head>
<body>

<div class="snsmaincontainer">
	<div class="roominfo">
		<div class=userinfoside>
			<img class=mainuserimg src="<%= ctxPath%>/resources/images/nomaluserimg.png" style="margin-top: 20px; margin-left: 20px;"/>			
		</div>
		<div class=userinfotop style="height: 79px;">
			<span class=username >Opistachio</span>
			<img src="<%= ctxPath%>/resources/images/search.png" style="width: 20px; height: 20px; float: right; margin-right:  10px;"/>
			<img src="<%= ctxPath%>/resources/images/bell.png" style="width: 20px; height: 20px; float: right; margin-right:  10px;"/>
			<img src="<%= ctxPath%>/resources/images/pencel.png" style="width: 20px; height: 20px; float: right; margin-right:  60px;"/>
			 <!-- <input type="text" class="inputsearch" placeholder="대화내용 검색" name="Search">
	     	<button class="btn btn-default" type="submit" style="margin-top: 20px; margin-right: 80px;"><i class="glyphicon glyphicon-search"></i></button> -->
	    </div>
	    

	</div>
	
	<div class="talk" id="talk">
	
	</div>
	
	<div class="talkinput">
		<div class="icon">
			<img class="iconimg" src="<%= ctxPath%>/resources/images/file.png" />
			<img class="iconimg" src="<%= ctxPath%>/resources/images/emoticon.png" />
		</div>
		 	<textarea class="tArea" rows="5" id="talkuser" style="resize: none;"></textarea>
		 	<button type="button" class="btn btn-success" id="btnSendMessage">전송</button>
	</div>
	
</div>

</body>
</html>