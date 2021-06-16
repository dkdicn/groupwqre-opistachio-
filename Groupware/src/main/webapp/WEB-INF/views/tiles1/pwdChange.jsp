<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<% String ctxPath = request.getContextPath(); %>

<meta charset="utf-8">
<meta name="viewport" content="width=device-width, initial-scale=1">
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.1/css/bootstrap.min.css">
<link rel="stylesheet" type="text/css" href="<%=ctxPath %>/resources/css/menu.css" />		
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
<script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.1/js/bootstrap.min.js"></script>
  
<link rel="stylesheet" href="resources/css/login.css"/>

<script type="text/javascript">		
	var b_check = false;
	$(function(){
		if(self.name!='reload'){
			self.name='reload'
			self.location.reload();
		} else self.name="";
		
		$("span.confirm").hide();
		
		$("button#changePwd").click(function(){
			goConfirm();
		
			if(b_check) {
				var real_id = "${sessionScope.loginuser.mbr_id}";
				$("input#real_id").val(real_id);  

				var frm = document.changePwdFrm;
				frm.action="<%= ctxPath%>/changePwd.opis";
				frm.method="POST";
				frm.submit();
			}	
		});
		
		$("button#laterChangePwd").click(function(){	
			location.href = "<%=ctxPath%>/mainPage.opis";
		});
	});// end of $(function() ------------------------------------------------------------
	
			
	function goConfirm() {	// 비밀번호 변경을 누른 경우		
		
		// 현재 비밀번호 입력란 체크
		var currentPwd = $("input#currentPwd").val();
		if(currentPwd==""){
			$("div#currentPwd").show();
			$("div#currentPwd").html("현재 비밀번호를 입력해주세요.");
			b_check=false;
			return;
		} else if(currentPwd!="${sessionScope.loginuser.mbr_pwd}"){
				$("div#currentPwd").show();
				$("div#currentPwd").html("현재 비밀번호와 다릅니다. 다시 입력해주세요.");
				b_check=false;
				return;
		} else {
			$("div#currentPwd").hide();
			b_check=true;
		}
		
		// 변경 비밀번호란 체크
		var newPwd1 = $("input#newPwd1").val();
		if(newPwd1==""){
			$("div#newPwd1").show();
			$("div#newPwd1").html("변경할 비밀번호를 입력해주세요.");
			b_check=false;
			return;
		} else {
			if(newPwd1=="${sessionScope.loginuser.mbr_pwd}"){
				$("div#newPwd1").show();
				$("div#newPwd1").html("현재 비밀번호 같은 비밀번호로 변경은 불가합니다.");
				b_check=false;
				return;
			} else {
				// 비밀번호 8-15자리, 영문자,숫자,특수기호 혼합 정규표현식
				var regExp= /^.*(?=^.{8,15}$)(?=.*\d)(?=.*[a-zA-Z])(?=.*[^a-zA-Z0-9]).*$/g;
				var bool = regExp.test(newPwd1);
				if(!bool){
					$("div#newPwd1").show();
					$("div#newPwd1").html("비밀번호는 8-15자리의 영문자, 숫자, 특수기호를 혼합해야 합니다.");
					b_check=false;
					return;
				} else {
					$("div#newPwd1").hide();
					b_check=true;
				}
			}			
		}
		
		// 변경 비밀번호 확인란 체크
		var newPwd2 = $("input#newPwd2").val();
		if(newPwd2==""){
			$("div#newPwd2").show();
			$("div#newPwd2").html("변경 비밀번호 확인란를 입력해주세요.");
			b_check=false;
			return;
		} else if(newPwd2!=newPwd1){
				$("div#newPwd2").show();
				$("div#newPwd2").html("변경 비밀번호가 일치하지 않습니다. 다시 입력해주세요.");
				b_check=false;
				return;
		} else {
			$("div#newPwd2").hide();
			b_check=true;
		}
		
			
	}// end of function goConfirm() ----------------------------------------------------------
</script> 


<div id="changePwdContainer">
	<form name="changePwdFrm" id="changePwdFrm">
		<div id="alert">회원님의 소중한 개인정보보호와 안전한 서비스 이용을 위해 주기적으로 <br> 비밀번호를 변경해주시기 바랍니다.</div>
		<div id="changePwd">
			<input type="hidden" name="real_id" id="real_id"/>
			<label for="currentPwd" id="letter" >현재 비밀번호</label>	
	  	   	<input type="password" name="currentPwd" id="currentPwd" class="loginWidth" placeholder="현재 비밀번호"/>
	  	   	<div id="currentPwd" class="confirm"></div><br>
	  	   	<label for="newPwd" id="letter">변경 비밀번호</label>
		    <input type="password" name="newPwd1" id="newPwd1" class="loginWidth" placeholder="변경 비밀번호"/>
		    <div id="newPwd1" class="confirm"></div><br>
		    <label for="newPwd" id="letter">변경 비밀번호 확인</label>
		    <input type="password" name="newPwd2" id="newPwd2" class="loginWidth" placeholder="변경 비밀번호 확인"/> 
		    <div id="newPwd2" class="confirm"></div><br>	 	      	 	
	  	    <button type="button" name="changePwd" id="changePwd" class="btn btn-success loginWidth changePwd" >비밀번호 변경하기</button><br>
	  	    <button type="button" name="changePwd" id="laterChangePwd" class="btn btn-outline-secondary loginWidth changePwd" >다음에 변경하기</button> 
	   </div> 
	   <input type="hidden" name="mbr_seq" value="${sessionScope.loginuser.mbr_seq}"/>	
	</form>        	   
</div>   
 