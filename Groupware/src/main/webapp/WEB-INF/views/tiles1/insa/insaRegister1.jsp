<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<% String ctxPath = request.getContextPath(); %>
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/4.7.0/css/font-awesome.min.css">

<jsp:include page="./insa_sidebar.jsp" />
<style>
	
	.registerBtn{`
 	  margin-left: 10px;
	  padding: 10px 20px;
	  font-size: 15px;
	  text-align: center;
	  cursor: pointer;
	  outline: none;
	  color: #fff;
	  background-color: #04AA6D;
	  border: none;
	  border-radius: 15px;
	  box-shadow: 0 9px #999;
	}
	.registerBtn:hover{ background-color: #3e8e41 !important;}
	.registerBtn:active{
	  background-color: #3e8e41 !important;
	  box-shadow: 0 5px #666;
	  transform: translateY(4px);
	}

	table#insaDetail1{
		display: inline;
		width: 45%;
		 vertical-align: top;
		 margin-right: 60px;
	}
	table#insaDetail1 td{
		width: 300px;
	}
	table#insaDetail2 td{
		width: 300px;
	}
	table#insaDetail2{
		display: inline;
		width: 45%;
	    vertical-align: top;
		 margin-right: 60px;
	}
</style>

<script type="text/javascript">
	$(document).ready(function(){

		var searchType = $("input#hiddenSearchType").val();
		var searchWord= $("input#hiddenSearchWord").val();
		var category = $("input#hiddenCategory").val();
		

		var htmlYear = "";
		for(var i=1950;i<2050;i++){
			htmlYear += '<option class="enteryy" id="enteryy">'+i+'</option><br>';
		}
			$("select#enteryy").html(htmlYear);
			
		htmlYear = "";
		for(var i=1950;i<2050;i++){
			htmlYear += '<option class="quityy" id="quityy">'+i+'</option><br>';
		}
			$("select#quityy").html(htmlYear);
			
		htmlYear = "";
		for(var i=1950;i<2050;i++){
			htmlYear += '<option class="birthyy" id="birthyy">'+i+'</option><br>';
		}
			$("select#birthyy").html(htmlYear);
		
		
		
		$("button#registerBtn").click(function(){
			

			var bflag = true;

			var name = $("input[name=mbr_name]").val();
				if(name.trim()==""){
					bflag = false;
				}
			var id = $("input[name=mbr_id]").val();
				if(id.trim()==""){
					bflag = false;
				}	
			var pwd = $("input[name=mbr_pwd]").val();
				if(pwd.trim()==""){
					bflag = false;
				}	
			var com_number = $("input[name=mbr_com_number]").val();
				if(com_number.trim()==""){
					bflag = false;
				}		
			var phone_number = $("input[name=mbr_phone_number]").val();
				if(phone_number.trim()==""){
					bflag = false;
				}		
			var email = $("input[name=mbr_email]").val();
				if(email.trim()==""){
					bflag = false;
				}
			
			
			


		 	var enteryy = $("#enteryy option:selected").val();
			var entermm = $("#entermm option:selected").val();
			var enterdd = $("#enterdd option:selected").val();
			if(entermm <10){
				entermm = "0"+entermm;
			}
			if(enterdd <10){
				enterdd = "0"+enterdd;
			}
			var enter = enteryy+"-"+entermm+"-"+enterdd;
			var htmlEnter =  '<input name = "mbr_registerday" type="hidden" value="'+enter+'"/>';
			$("div#enterDiv").html(htmlEnter);
			


		 	var birthyy = $("#birthyy option:selected").val();
			var birthmm = $("#birthmm option:selected").val();
			var birthdd = $("#birthdd option:selected").val();
			if(birthmm <10){
				birthmm = "0"+birthmm;
			}
			if(birthdd <10){
				birthdd = "0"+birthdd;
			}
			var birth = birthyy+"-"+birthmm+"-"+birthdd;
			var htmlBirth =  '<input name = "mbr_birthday" type="hidden" value="'+birth+'"/>';
			$("div#birthDiv").html(htmlBirth);
			

			if(!bflag){
				alert("모든 항목을 입력하세요!!");
			}
			else{
			var frm = document.insaRegister1Frm;
			frm.method = "POST";
			frm.action = '<%=ctxPath%>/insaRegister1End.opis';  
			frm.submit(); 
			}
		});
		
	});
</script>



<div id="insa" style="width: 80%; display: inline-block; margin-top: 70px; padding-left: 30px;">

		<form name="insaRegister1Frm">
		<table style="margin-bottom: 50px;">
		<tr id="insaDetailButton">
			<td><button class="registerBtn" id="registerBtn"  type="submit" style="display: inline-block; vertical-align: top;">등록</button></td>
			<td style="width: 10px;"></td>
			<td><button class="registerBtn" style="background-color: gray; " onclick="javascript:location.href='<%=ctxPath%>/insa.opis?seq=${seq}&category=${category}&searchType=${searchType}&searchWord=${searchWord}'">회원목록으로</button></td>
		</tr>
		</table> 

	
	
			<table id="insaDetail1" class="table table-striped tdtable">
				<tr>
					<th>사원번호</th>
					<td></td>
				</tr>
				<tr>
					<th>사원명</th>
					<td><input name="mbr_name"  /></td>
				</tr>
				<tr>
					<th>아이디</th>
					<td><input name="mbr_id"  /></td>
				</tr>
				<tr>
					<th>비밀번호</th>
					<td><input name="mbr_pwd"  /></td>
				</tr>
				<tr>
					<th>부서</th>
					<td>  <input type="radio" id="business" name="fk_dept_no" value="0">
						  <label for="business">영업</label>
						  <input type="radio" id="insateam" name="fk_dept_no" value="1">
						  <label for="insateam">인사</label>
						  <input type="radio" id="adv" name="fk_dept_no" value="2">
						  <label for="adv">홍보</label>
						  <input type="radio" id="it" name="fk_dept_no" value="3">
						  <label for="it">IT</label>
					      <input type="radio" id="accounting" name="fk_dept_no" value="4">
						  <label for="accounting">회계</label>
					</td>
				</tr>
				<tr>
					<th>직책</th>
					<td>  <input type="radio" id="boss" name="fk_rank_no" value="0">
						  <label for="boss">팀장</label>
						  <input type="radio" id="team" name="fk_rank_no" value="1">
						  <label for="team">팀원</label>
					</td>
				</tr>
				<tr>
					<th>권한</th>
					<td>  <input type="radio" id="admin" name="fk_power_no" value="0">
						  <label for="admin">관리자</label>
						  <input type="radio" id="genMem" name="fk_power_no" value="1">
						  <label for="genMem">일반사원</label>
					</td>
				</tr>
				<tr>
					<th>입사일자</th>
					<td>
			             <select id="enteryy" style=" width: 80px; padding: 4px;">
			           		
			            </select>년
						<select id="entermm" style="margin-left: 2%; width: 55px; padding: 4px;">
			           		<c:forEach begin="1" end="12" varStatus="count" >
			           			<option >${count.count}</option>
			           		</c:forEach>
			            </select>월
			            <select id="enterdd" style="margin-left: 2%; width: 55px; padding: 4px;">
				            	<c:forEach begin="1" end="31" varStatus="count" >
				           			<option>${count.count}</option>
				           		</c:forEach>
			         </select>일 
			         <div id="enterDiv"></div> 	
					</td>
				</tr>
				<tr>
					<th>학력</th>
					<td> 
					</td>
				</tr>
			</table>
			<table id="insaDetail2" class="table table-striped tdtable">
				<tr>
					<th>회사연락처</th>
					<td><input name="mbr_com_number"  /></td>
				</tr>
				<tr>
					<th>개인연락처</th>
					<td><input name="mbr_phone_number"  /></td>
				</tr>
				<tr>
					<th>회사이메일</th>
					<td><input name="mbr_email"  /></td>
				</tr> 
				<tr>
					<th>생년월일</th>
					<td>
			            <select id="birthyy" style=" width: 80px; padding: 4px;">
			           		
			            </select>년
						<select id="birthmm" style="margin-left: 2%; width: 55px; padding: 4px;">
			           		<c:forEach begin="1" end="12" varStatus="count" >
			           			<option>${count.count}</option>
			           		</c:forEach>
			            </select>월
			            <select id="birthdd" style="margin-left: 2%; width: 55px; padding: 4px;">
				            	<c:forEach begin="1" end="31" varStatus="count" >
				           			<option>${count.count}</option>
				           		</c:forEach>
			         </select>일 
			         <div id="birthDiv"></div>		
					</td>
				</tr>
				 
				<tr>
					<th>성별</th>
					<td>  <input type="radio" id="female" name="mbr_gender" value="0">
						  <label for="female">여</label>
						  <input type="radio" id="male" name="mbr_gender" value="1">
						  <label for="male">남</label>
					</td>
				</tr>
			</table>
			</form>
			<input id="hiddenSeq" type="hidden" value="${seq}"/>
			<input id="hiddenCategory" type="hidden" value="${category}" />
			<input id="hiddenSearchType" type="hidden" value="${searchType}" />
			<input id="hiddenSearchWord" type="hidden" value="${searchWord}" />
	
</div>



