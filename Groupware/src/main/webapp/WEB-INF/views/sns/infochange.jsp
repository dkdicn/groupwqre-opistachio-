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
<title>정보수정페이지</title>
<link rel="stylesheet" type="text/css" href="<%= ctxPath%>/resources/css/infochange.css"/>
<script type="text/javascript" src="<%= ctxPath%>/resources/js/jquery-3.3.1.min.js"></script>
<meta charset="utf-8">
<meta name="viewport" content="width=device-width, initial-scale=1">
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.1/css/bootstrap.min.css">
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
<script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.1/js/bootstrap.min.js"></script>
<script type="text/javascript">
	var fileButton = section.querySelector(".file-button");
	var file = section.querySelector("input[type=file]");
	
	// 파일 받기
	fileVutton.onclick = function(e) {
		var event = new MouseEvent("click", {
			'view':window,
			'bubbleds':true,
			'cancelable':true
		});
	}
	
	// 수정하기 버튼 클릭시
	function goinfochangeend() {
		var usernameVal = $("input#mbr_name").val().trim();
		var userstatemsgVal = $("input#mbr_stsmsg").val().trim();
		
		if(usernameVal == "") {
			alert("이름을 입력하세요!!");
			return;
		}
		
		var frm = document.changeFrm;
		frm.method="POST";
		frm.action = "<%= ctxPath%>/infochangeend.opis";
		frm.submit(); 
	}
	
</script>
</head>
<body>
<form name="changeFrm" enctype="multipart/form-data">
	<div class=snsmaincontainer style="background-color: white;">
		<div class="form-group">
		  <label for="usr" class="lform">이름: </label>
		  <input type="text" class="form-control" id="mbr_name" name="mbr_name" value='${sessionScope.loginuser.mbr_name}'>
		  <input type="hidden" class="form-control" id="mbr_id" name="mbr_id" value='${sessionScope.loginuser.mbr_id}'>
		</div>
		<div class="form-group" >
		  <label for="usr" class="lform">상태메시지 : </label>
		  <input type="text" class="form-control" id="mbr_stsmsg" name="mbr_stsmsg" value='${sessionScope.loginuser.mbr_stsmsg}'>
		</div>
		<div class="form-group" >
		  <label for="usr" class="lform">프로필사진: </label>
		  <input type="file" class="form-control" id="file" name="mbr_photo">
		</div>
		<div class="form-group" style="padding-left: 100px;" >
		  <button type="button" class="btn btn-success" onclick="goinfochangeend()" >수정하기</button>
		  <button type="button" class="btn btn-danger" onclick="javascript:location.href='<%= ctxPath%>/sns/snsmain.opis'" >수정취소</button>
		</div>
		
		
	</div>
</form>
</body>
</html>