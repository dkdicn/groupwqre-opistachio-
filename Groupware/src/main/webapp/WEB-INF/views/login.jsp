<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<% String ctxPath = request.getContextPath(); %>

<meta name="viewport" content="width=device-width, initial-scale=1">

<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.1/css/bootstrap.min.css">
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
<script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.1/js/bootstrap.min.js"></script>

<link rel="stylesheet" type="text/css" href="resources/css/login.css"/>

<script type="text/javascript">
	
	$(function(){
		$("div#result").hide();
		
		if("${loginuser}"==null){	// 로그인 실패문구 출력
			$("div#result").html("일치하는 회원이 없습니다. 다시 로그인해주세요!");
			$("div#result").show();
		}
	});// end of $(function() ------------------------------------------------------------
	
			
	function loginCheck() {

		var frm = document.loginfrm;
	
		// 아이디가 입력이 안된 경우
		if($("input#idInput").val().trim()==null || $("input#idInput").val().trim()=="") {
			$("div#result").show();
			$("div#result").html("아이디를 입력해주세요!");
			return false;
		}

		// 비밀번호가 입력이 안된 경우
		if($("input#pwdInput").val().trim()==null || $("input#pwdInput").val().trim()=="") {
			$("div#result").show();
			$("div#result").html("비밀번호를 입력해주세요!");
			return false;
		}
	
		frm.action="<%=ctxPath%>/loginCheck.opis";
		frm.method="POST";
		frm.submit();

	}// end of loginCheck() ----------------------------------------------------------
	
</script>

<html>

<head> 
<title>::: Opistachio :::</title>
</head>

<body>
	<div id="login_container">
		<form name="loginfrm">
		
		<h1>Opistachio</h1>
		
		<label for="companyInput" class="inputName">COMPANY</label>
		<input type="text" id="companyInput" name="companyInput" class="form-control input" value="${com_name}" readonly />
		<br>
		<label for="idInput" class="inputName">ID</label>
		<input type="text" id="idInput" name="idInput" class="form-control input"/>
		<br>
		<label for="pwdInput" class="inputName">PASSWORD</label>
		<input type="password" id="pwdInput" name="pwdInput" class="form-control input"
		onkeypress="if(event.keyCode == 13){loginCheck()}"/>
		<br>
	
		<div id="result"></div>
		
		<button type="button" class="btn btn-success" onclick="loginCheck()">Opistachio 시작하기</button>
		
		</form>
	</div>
</body>

</html>