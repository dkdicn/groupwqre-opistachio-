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
		width: 350px;
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
		var seq = $("input#hiddenSeq").val();
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
		
			
		///// 퇴사일자 행 띄우기 여부 [시작] //////////////////	
		
		var retireYN = $("input#hiddenRetire").val();
		if(retireYN == 0){
			$("tr#retireDayTr").show();

		     $("input#retire_y").prop("checked",true);
		     $("input#retire_n").prop("checked",false);
		
		}
		if(retireYN != 0){
			$("tr#retireDayTr").hide();
		     $("input#retire_n").prop("checked",true);
		     $("input#retire_y").prop("checked",false);
		}
						
		///// 퇴사일자 행 띄우기 여부 [끝] //////////////////		
		
		
		
		///// 퇴사여부 클릭시 [시작] //////////////////	
			
		 // "재직" 클릭시
	     $("input#retire_n").click(function(){
		     $("input#retire_y").prop("checked",false);
			 $("tr#retireDayTr").hide();
	     });
			
		 // "퇴사" 클릭시
	     $("input#retire_y").click(function(){
		     $("input#retire_n").prop("checked",false);
			 $("tr#retireDayTr").show();
	     });
		
		///// 퇴사여부 클릭시 [끝] //////////////////	
		
		
		
		///////// select / radio 선택 유지시키기 ////[시작]////////////////////
			
		     $("input:radio[name=fk_dept_no]").each(function(){
		    
				if($(this).val() == "${insavo.fk_dept_no}"){
					$(this).prop("checked",true);
		
				}
            });

		     $("input:radio[name=fk_power_no]").each(function(){
		    
				if($(this).val() == "${insavo.fk_power_no}"){
					$(this).prop("checked",true);
		
				}
            });
		
		     $("input:radio[name=fk_rank_no]").each(function(){
		    
				if($(this).val() == "${insavo.fk_rank_no}"){
					$(this).prop("checked",true);
		
				}
            });
		
		     $("input:radio[name=mbr_gender]").each(function(){
		    
				if($(this).val() == "${insavo.mbr_gender}"){
					$(this).prop("checked",true);
		
				}
            });
		     // 입사일자//
			 var enterdate ="${insavo.mbr_registerday}";
		     var enteryy = enterdate.substr(0,4);
		     $("option.enteryy").each(function(){
				    
						if($(this).val() == enteryy){
							$(this).prop("selected",true);
				
						}

	            });
		     var entermm_0 = enterdate.substr(5,2);
		     $("option.entermm").each(function(){
				    
		    	 	if($(this).val()<10){
						if("0"+$(this).val() == entermm_0){
							$(this).prop("selected",true);
				
						}
		    	 	}
		    	 	else{
						if($(this).val() == entermm_0){
							$(this).prop("selected",true);
				
						}
		    	 	}
	            });
		     var enterdd_0 = enterdate.substr(8,2);
		     $("option.enterdd").each(function(){

		    	 	if($(this).val()<10){
						if("0"+$(this).val() == enterdd_0){
							$(this).prop("selected",true);
				
						}
		    	 	}
		    	 	else{
						if($(this).val() == enterdd_0){
							$(this).prop("selected",true);
				
						}
		    	 	}
	            });
		     // 
		     
		     
		     
		     // 퇴사일자//
			 var quitdate ="${insavo.mbr_retireday}";
		     var quityy_0 = quitdate.substr(0,4);
		     $("option.quityy").each(function(){
				    
						if($(this).val() == quityy_0){
							$(this).prop("selected",true);
				
						}

	            });
		     var quitmm_0 = quitdate.substr(5,2);
		     $("option.quitmm").each(function(){
				    
		    	 	if($(this).val()<10){
						if("0"+$(this).val() == quitmm_0){
							$(this).prop("selected",true);
				
						}
		    	 	}
		    	 	else{
						if($(this).val() == quitmm_0){
							$(this).prop("selected",true);
				
						}
		    	 	}
	            });
		     var quitdd_0 = quitdate.substr(8,2);
		     $("option.quitdd").each(function(){

		    	 	if($(this).val()<10){
						if("0"+$(this).val() == quitdd_0){
							$(this).prop("selected",true);
				
						}
		    	 	}
		    	 	else{
						if($(this).val() == quitdd_0){
							$(this).prop("selected",true);
				
						}
		    	 	}
	            });
		     //
		     
		     
		     // 생일//
			 var birthdate ="${insavo.mbr_birthday}";
		     var birthyy_0 = birthdate.substr(0,4);
		     $("option.birthyy").each(function(){
				    
						if($(this).val() == birthyy_0){
							$(this).prop("selected",true);
				
						}

	            });
		     var birthmm_0 = birthdate.substr(5,2);
		     $("option.birthmm").each(function(){
				    
		    	 	if($(this).val()<10){
						if("0"+$(this).val() == birthmm_0){
							$(this).prop("selected",true);
				
						}
		    	 	}
		    	 	else{
						if($(this).val() == birthmm_0){
							$(this).prop("selected",true);
				
						}
		    	 	}
	            });
		     var birthdd_0 = birthdate.substr(8,2);
		     $("option.birthdd").each(function(){

		    	 	if($(this).val()<10){
						if("0"+$(this).val() == birthdd_0){
							$(this).prop("selected",true);
				
						}
		    	 	}
		    	 	else{
						if($(this).val() == birthdd_0){
							$(this).prop("selected",true);
				
						}
		    	 	}
	            });
		     //
	
		
		
		///////// select / radio 선택 유지시키기 ////[끝]////////////////////
		
		
		
		$("button#modifyBtn").click(function(){
			
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
			

		 	var quityy = $("#quityy option:selected").val();
			var quitmm = $("#quitmm option:selected").val();
			var quitdd = $("#quitdd option:selected").val();
			if(quitmm <10){
				quitmm = "0"+quitmm;
			}
			if(quitdd <10){
				quitdd = "0"+quitdd;
			}
			var quit = quityy+"-"+quitmm+"-"+quitdd;
			var htmlQuit =  '<input name = "mbr_retireday" type="hidden" value="'+quit+'"/>';
			$("div#quitDiv").html(htmlQuit);



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

			if(!bflag){
				alert("모든 항목을 입력하세요!!");
			}
			else{
				var frm = document.insaModify1Frm;
				frm.method = "POST";
				frm.action = '<%=ctxPath%>/insaModify1End.opis?seq='+seq+'&searchType='+searchType+'&searchWord='+searchWord+'&category='+category;  
				frm.submit(); 
			}
			
			
		});
		
	});
</script>



<div id="insa" style="width: 80%; display: inline-block; margin-top: 70px; padding-left: 30px;">

		<form name="insaModify1Frm">
		<table style="margin-bottom: 50px;">
		<tr id="insaDetailButton">
			<td><button class="registerBtn" id="modifyBtn" type="button">수정완료</button></td>
			<td style="width: 10px;"></td>
			<td><button class="registerBtn" style="background-color: gray;">돌아가기</button></td>
		</tr>
		</table> 

	
	
			<table id="insaDetail1" class="table table-striped tdtable">
				<tr>
					<th>사원번호</th>
					<td>${insavo.mbr_seq}</td>
				</tr>
				<tr>
					<th>사원명</th>
					<td><input name="mbr_name"  value="${insavo.mbr_name}"/></td>
				</tr>
				<tr>
					<th>아이디</th>
					<td><input name="mbr_id"  value="${insavo.mbr_id}"/></td>
				</tr>
				<tr>
					<th>비밀번호</th>
					<td><input name="mbr_pwd"  /><a style="font-size: 7; color: red;"> *다시입력하세요</a></td>
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
			           			<option class="entermm">${count.count}</option>s
			           		</c:forEach>
			            </select>월
			            <select id="enterdd" style="margin-left: 2%; width: 55px; padding: 4px;">
				            	<c:forEach begin="1" end="31" varStatus="count" >
				           			<option class="enterdd">${count.count}</option>
				           		</c:forEach>
			         </select>일 
			         <div id="enterDiv"></div> 	
					</td>
				</tr>
				<tr>
					<th>퇴사여부</th>
					<td>
						<input class="retire" name="mbr_status" type="radio" id="retire_n" value="1">
					    <label for="retire_n">재직</label>
						<input class="retire" name="mbr_status" type="radio" id="retire_y" value="0">
						<label for="retire_y">퇴사</label>
					</td>
				</tr>
				<tr id="retireDayTr">
					<th>퇴사일자</th>
					<td>
			            <select id="quityy" style=" width: 80px; padding: 4px;">
			           		
			            </select>년
						<select id="quitmm" style="margin-left: 2%; width: 55px; padding: 4px;">
			           		<c:forEach begin="1" end="12" varStatus="count" >
			           			<option class="quitmm">${count.count}</option>
			           		</c:forEach>
			            </select>월
			            <select id="quitdd" style="margin-left: 2%; width: 55px; padding: 4px;">
				            	<c:forEach begin="1" end="31" varStatus="count" >
				           			<option class="quitdd">${count.count}</option>
				           		</c:forEach>
			         </select>일 
			         <div id="quitDiv"></div> 	
					</td>
				</tr>
			 <input id="hiddenRetire" type="hidden" value="${insavo.mbr_status}" />
				<tr>
					<th>학력</th>
					<td> 
					</td>
				</tr>
			</table>
			<table id="insaDetail2" class="table table-striped tdtable">
				<tr>
					<th>회사연락처</th>
					<td><input name="mbr_com_number"   value="${insavo.mbr_com_number}"/></td>
				</tr>
				<tr>
					<th>개인연락처</th>
					<td><input name="mbr_phone_number"  value="${insavo.mbr_phone_number}"/></td>
				</tr>
				<tr>
					<th>회사이메일</th>
					<td><input name="mbr_email"  value="${insavo.mbr_email}"/></td>
				</tr> 
				<tr>
					<th>생년월일</th>
					<td>
			            <select id="birthyy" style=" width: 80px; padding: 4px;">
			           		
			            </select>년
						<select id="birthmm" style="margin-left: 2%; width: 55px; padding: 4px;">
			           		<c:forEach begin="1" end="12" varStatus="count" >
			           			<option class="birthmm">${count.count}</option>
			           		</c:forEach>
			            </select>월
			            <select id="birthdd" style="margin-left: 2%; width: 55px; padding: 4px;">
				            	<c:forEach begin="1" end="31" varStatus="count" >
				           			<option class="birthdd">${count.count}</option>
				           		</c:forEach>
			         </select>일 
			         <div id="birthDiv" name="mbr_birthday"></div>		
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



