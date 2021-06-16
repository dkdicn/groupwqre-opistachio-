<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<% String ctxPath = request.getContextPath(); %>


<jsp:include page="./approval_sidebar.jsp" />  
<jsp:include page="./approvalMemberModal.jsp" /> 
<jsp:include page="./selectMemberModal.jsp" />  

<link rel="stylesheet" href="//code.jquery.com/ui/1.12.1/themes/base/jquery-ui.css">
<link rel="stylesheet" href="/resources/demos/style.css">
<script src="https://code.jquery.com/jquery-1.12.4.js"></script>
<script src="https://code.jquery.com/ui/1.12.1/jquery-ui.js"></script>


<script type="text/javascript">
	$(document).ready(function(){
		
		$("input#datepicker").datepicker({
			 dateFormat: 'yy-mm-dd', 
		      changeMonth: true,
		      changeYear: true
		});
		
		$("input#datepicker2").datepicker({
			 dateFormat: 'yy-mm-dd', 
		      changeMonth: true,
		      changeYear: true
		});
		
		$("input[name=attach]").hide();
		$("button#confirm").hide();
		$("button#delete").hide();
		$("button#reject").hide();
		
		// 특정 결재문서를 조회하는 경우
		var checkURL = document.location.href;
		if(checkURL.indexOf("?")!="-1"){
			var ap_manage_approver = "${avo.ap_manage_approver}".split(" ");
			
			// 결재를 해야하는 사용자일 때
			if("${sessionScope.loginuser.mbr_name}"==ap_manage_approver[2]
			&& "${sessionScope.loginuser.mbr_seq}"!="${avo.fk_mbr_seq}" ){	
				$("button#approvalSubmit").hide();
				$("button#delete").hide();
				$("button#confirm").show();
				$("button#reject").show();
			}
			
			// 결재를 작성한 자일때
			if("${sessionScope.loginuser.mbr_seq}"=="${avo.fk_mbr_seq}" 
			&& "${sessionScope.loginuser.mbr_name}"==ap_manage_approver[2]){	
				$("button#approvalSubmit").hide();
				$("button#delete").show();
				$("button#confirm").show();
				$("button#reject").hide();
			}
			
			$("td#fileNo").html("${avo.ap_seq}");
			$("td#today").html("${avo.ap_start_day}");
			$("td#mbr_name").html("${avo.mbr_name}");
			$("td#dept_detail").html("${avo.ap_dept}");
			$("span#selectedMember").html("${avo.ap_referrer}");
			$("input#ap_title").val("${avo.ap_title}");
			$("textarea").html("${avo.ap_contents}");
			
			var arr = "${avo.ap_contents}".split(",");
			
			for (var i=0; i<arr.length; i++) {
				html += "<td class='sign'>"+arr[i]+"</td>";		
			}
			
			
		}
		
		// 결재라인 모달창 열기
		$("button#approvalMember").click(function(){			
			$('div#myModal').show();
		});
		
		// 결재라인 모달창 끄기
		$("button#closeModal").click(function(){
			$('div#myModal').hide();
		});
		
		// 참조라인 모달창 열기
		$("button#selectMember").click(function(){			
			$('div#myModal2').show();
		});
		
		// 참조라인 모달창 끄기
		$("button#closeModal2").click(function(){
			$('div#myModal2').hide();
		});
		
		var fileCnt = document.getElementById("attach").files.length;
		$("input[name=file]").val(fileCnt);
		
		
		// 휴일기간 알려주기
		var startDate, endDate, startDateArr, endDateArrdateDiff;
		var dateDiff=0;
		var remainBreak = Number("${sessionScope.loginuser.mbr_remainBreak}");
		
		$("input#datepicker").change(function(){
			if(this.value!=null && $("input#datepicker2").val()!=null) {
				start = this.value;
				end = $("input#datepicker2").val();
				console.log(start);
				console.log(end);
				
				startDateArr = start.split('-');
				endDateArr = end.split('-');
				
				startDate = new Date(startDateArr[0], startDateArr[1], startDateArr[2]);
				endDate = new Date(endDateArr[0], endDateArr[1], endDateArr[2]);
				
				dateDiff = Math.ceil((endDate.getTime()-startDate.getTime())/(1000*3600*24))+1;
			 
			}  else if(this.value!=null && $("input#datepicker2").val()==null) {
				dateDiff = 2;
			} else if(this.value==null && $("input#datepicker2").val()!=null) {
				dateDiff = 2;
			}
			
			$("span#dateDiff").html(dateDiff);
			$("span#remainBreak").html(remainBreak-dateDiff);
		});
		$("input#datepicker2").change(function(){
			if(this.value!=null && $("input#datepicker").val()!=null) {				
				start = $("input#datepicker").val();
				end = this.value;
				console.log(start);
				console.log(end);
				startDateArr = start.split('-');
				endDateArr = end.split('-');
				
				startDate = new Date(startDateArr[0], startDateArr[1], startDateArr[2]);
				endDate = new Date(endDateArr[0], endDateArr[1], endDateArr[2]);
				
				dateDiff = Math.ceil((endDate.getTime()-startDate.getTime())/(1000*3600*24))+1;
			} else if(this.value!=null && $("input#datepicker").val()==null) {
				dateDiff = 2;
			} else if(this.value==null && $("input#datepicker").val()!=null) {
				dateDiff = 2;
			}
			$("span#dateDiff").html(dateDiff);
			$("span#remainBreak").html(remainBreak-dateDiff);
		});
		
		
		// 반차 선택시 차감일수변경
		$("select#vacationType").change(function(){
			if(dateDiff!=0 && this.value=="반차")	$("span#remainBreak").html(remainBreak-dateDiff+0.5);
			if(dateDiff!=0 && this.value=="연차")	$("span#remainBreak").html(remainBreak-dateDiff);
		});
		
		
		// 첨부파일 목록 보여주기
		$("input[type=file]").change(function(){
			fileCnt = document.getElementById("attach").files.length;
			$("input[name=file]").val(fileCnt);
			
			var files = document.getElementById("attach").files;
	        var file;
	        
	        for (var i=0; i<files.length; i++) { 
	            file = files[i];
	            $("div#attachedFile").append('<span id="del'+i+'">'+file.name+'<button type="button" class="btn formBtn2 delFile" id="del'+i+'" onclick="func_delFile(this.id)">X</button></span>');
		        if(i%2==1){
	        		$("div#attachedFile").append('<br>');
	        	}
	        }
		});
	    
		
		$("button#approvalSubmit").click(function(){	// 결제요청 버튼을 누른 경우
			// 유효성 검사
	        if($("input#ap_title").val().trim() == "") {
	           alert("문서제목을 입력해주세요!");
	           return;
	        }
	        if($("textarea").val().trim() == "") {
		           alert("제출사유를 입력해주세요!");
		           return;
		    }
	        if($("td.sign").val()==null || $("td#sign").val()=="") {
	        	alert("결재라인을 선택해주세요!");
		        return;
	        }
	        
	        var textarea = $("textarea").val();
	        textarea = textarea.replace(/<script/gi, "&lt;script"); // 스크립트 공격을 막기
	        $("textarea").val(textarea);
	        
	        // 폼 전송하기
	        var frm = document.approvalSubmitForm;
	        frm.method = "POST";
	        frm.action = "<%= ctxPath%>/approvalSubmitForm.opis";
	        frm.submit();  
		});// end of $("button#approvalSubmit").click(function() -----------------------------------
			
				
		// 결제승인 버튼을 누른 경우
		$("button#confirm").click(function(){	
			var ap_approverArr = "${avo.ap_approver}".split(",");
			var ap_manage_approver = "${avo.ap_manage_approver}";
			var ap_process="";
			var ap_next_approver="";
			
			// 결재라인에서 어디까지 왔는지 확인하기
			for (var i=0; i<ap_approverArr.length; i++) {
				if(ap_manage_approver==ap_approverArr[i] && ap_approverArr.length==i+1){
					ap_progress="1";
				} else if(ap_manage_approver==ap_approverArr[i] && ap_approverArr.length!=i+1){
					ap_progress="0";
					ap_next_approver=ap_approverArr[i+1];
				}
			}
			
			func_confirm(ap_progress, ap_next_approver);
				
		});// end of $("button#confirm").click(function() -----------------------------------			
	    
	}); // end of $(document).ready(function(){})---------------------------------------
	
	
	function func_attach() {
		 $("input[name=attach]").click();	
	}// end of function func_attach() ------------------------------------------
	
	
	function func_delFile(id) {
		 $("span#"+id).remove();
	}// end of function func_delFile(this.id) ---------------------------------------
	
	
	function func_confirm(ap_progress, ap_next_approver) {
		$.ajax({
			url:"<%=ctxPath%>/approvalConfirm.opis",
			dataType:"json",
			data:{ap_seq:"${avo.ap_seq}",ap_progress:ap_progress, ap_next_approver:ap_next_approver},
			success: function(json){	
				if(json.n){
					history.back();
				}
			},
			error: function(request, status, error){
                alert("code: "+request.status+"\n"+"message: "+request.responseText+"\n"+"error: "+error);
            }
		}); 	
	}// end of function func_confirm() ------------------------------------------
	
</script>
</head>
<body>

	<div id="approvalContainer">
		<form name="approvalSubmitForm" enctype="multipart/form-data">
			<span class="subtitle">기안문작성</span>
			<hr>
			<div id="approvalFormStyle">   
			     	
				<div id="top">
					<button type="button" class="btn btn-success formBtn3" id="approvalMember">결재선</button>
					<button type="button" class="btn btn-success formBtn3">결재요청</button>
					<button type="button" class="btn btn-default formBtn3" onclick="location.href='<%=ctxPath%>/approvalMain.opis';">취소</button>
					<br>
					<div id="signTitle">결재라인</div><br><br>
					<table id="sign">
						<tr id="sign">
							<td class="sign"></td>
						</tr>
					</table>
				</div>
				
				<div id="center">
					<span id="subject">휴가신청서</span>
					<table id="approvalForm">
						<tbody>
							<tr>
								<td>문서번호</td>
								<td>${fileNo}</td>
								<td>기안일자</td>
								<td>${today}</td>
							</tr>
							<tr>
								<td>기안자</td>
								<td>${sessionScope.loginuser.mbr_name}</td>
								<td>기안부서</td>
								<td>${sessionScope.loginuser.dept_detail}</td>
							</tr>
							<tr>
								<td>참조자</td>
								<td>
									<span id="selectedMember"></span>
									<button type="button" class="btn formBtn2" id="selectMember">선택하기</button>
								</td>
								<td>알림여부</td>
								<td></td>
							</tr>
							<tr>
								<td>문서제목</td>
								<td colspan="3">
									<input type="text" class="form-control size1" name="ap_title" autocomplete="off"/>
								</td>
							</tr>
							<tr>
								<td>휴가신청일자</td>
								<td colspan="3">
									<input type="text" class="form-control formDetail" name="vacationStartDate" id="datepicker"/>
									<span class="space">-</span>
									<input type="text" class="form-control formDetail" name="vacationEndDate" id="datepicker2"/>
									<span class="space">총<span class="space" id="dateDiff" style="color:red;"></span> 일간</span>
								</td>
							</tr>
							<tr>
								<td>구분</td>
								<td colspan="3">
									<select class="selectCommon" id="vacationType" name="vacationType" style="margin: 0">
										<option val="연차">연차</option>
										<option val="반차">반차</option>
									</select>
									<span class="space">(남은 연차:<span class="space" id="remainBreak" style="color:red;"></span>/<span class="space" >${sessionScope.loginuser.mbr_remainBreak} 일</span>)</span>
								</td>
							</tr>
							<tr>
								<td>인수인계자</td>
								<td colspan="3">
									<input type="text" class="form-control formDetail" name="takeover" autocomplete="off"/>
								</td>
							</tr>
						</tbody>
					</table>				
				</div>
				
				<div id="bottom">
					<input type="file" name="attach" id="attach" name="attach" multiple />
					<button type="button" class="btn btn-success formBtn3" id="attachBtn" onclick="func_attach()" >파일업로드</button>			
					<div id="attachedFile"></div>
				</div>
				<br>
				
				<input type="hidden" name="ap_seq" value="${fileNo}"/>
				<input type="hidden" name="fk_apform_no" value="2"/>
				<input type="hidden" name="fk_mbr_seq" value="${sessionScope.loginuser.mbr_seq}"/>
				<input type="hidden" name="ap_dept" value="${sessionScope.loginuser.dept_detail}"/>
				<input type="hidden" name="ap_approver" />
				<input type="hidden" name="ap_manage_approver" />
				<input type="hidden" name="ap_referrer" />
				<input type="hidden" name="file" />
	
			</div>
		</form>
	</div>

</body>
</html>