<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<% String ctxPath = request.getContextPath(); %>
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/4.7.0/css/font-awesome.min.css">


<jsp:include page="./insa_sidebar.jsp" />


<style>
	div#paymentInfoBorder{
	  display:inline-block;
	  width: 1000px;
	  height: 500px;
	  overflow: scroll;
	}
	
	button.paymentInfoBtn{
	  display:inline-block;
	  padding: 10px 20px;
	  font-size: 10px;
	  text-align: center;
	  cursor: pointer;
	  outline: none;
	  color: #fff;
	  background-color: #04AA6D;
	  border: none;
	  border-radius: 15px;
	  box-shadow: 0 9px #999;
	}
	button.paymentInfoBtn:hover{ background-color: #3e8e41}
	button.paymentInfoBtn:active{
	  background-color: #3e8e41;
	  box-shadow: 0 5px #666;
	  transform: translateY(4px);
	}
	button.btnSmall{
	  display:inline-block;
	  font-size: 8pt;
	}
	table#paymentDetailBaseInfo{
		border-collapse: collapse;
	}
	
	table#paymentDetailBaseInfo td{
		height: 35px;
		padding: 5px;
		width: 120px;
		font-size: 13pt;
		text-align: center;
		border: solid 1px gray;
		vertical-align: middle;
	}
	table#paymentInfo{
		margin-top: 30px;
		border-collapse: collapse;
	}
	
	table#paymentInfo td{
		height: 35px;
		padding: 5px;
		width: 120px;
		font-size: 13pt;
		text-align: center;
		vertical-align: middle;
	}
	table#paymentInfo tr{
		height: 35px;
		text-align: center;
		vertical-align: middle;
	}
	table#paymentInfo th{
		height: 35px;
		padding: 5px;
		font-size: 13pt;
		text-align: center;
		vertical-align: middle;
	}
	table#payRegiTbl{
		margin-top: 10px;
		border-collapse: collapse;
	}
	
	table#payRegiTbl tr{
		height: 35px;
		text-align: center;
		vertical-align: middle;
	}
	table#payRegiTbl td{
		height: 35px;
		width: 200px;
		padding: 5px;
		font-size: 13pt;
		text-align: center;
		vertical-align: middle;
	}
	table#payRegiTbl input{
		width: 180px;
		font-size: 13pt;
		text-align: center;
		vertical-align: middle;
	}
	
	th.thNum{
		width: 100px !important;
	}
	span.sort{
		display: inline-block;
		width:200px !important;
	}
	td.tdNum{
		width: 100px !important;
	}
	
	/* The Close Button */
	.close {
	  color: white;
	  float: right;
	  font-size: 28px;
	  font-weight: bold;
	}
	
	.close:hover,
	.close:focus {
	  color: black;
	  text-decoration: none;
	  cursor: pointer;
	}

	/* Modal Header */
	.modal-header {
	  padding: 2px 16px;
	  background-color: #5cb85c;
	  color: white;
	}
	
	/* Modal Body */
	.modal-body {padding: 2px 16px;}
	
	
	/* Modal Content */
	.modal {
	  display: none; /* Hidden by default */
	  position: fixed; /* Stay in place */
	  z-index: 1; /* Sit on top */
	  left: 0;
	  top: 0;
	  
	  margin: 15% auto; /* 15% from the top and centered */
	  padding: 20px;
	  border: 1px solid #888;
	  width: 60%; /* Could be more or less, depending on screen size */
	  height: 60%;
	  overflow: auto; /* Enable scroll if needed */
	  background-color: #fefefe; /* Black w/ opacity */
	  box-shadow: 0 4px 8px 0 rgba(0,0,0,0.2),0 6px 20px 0 rgba(0,0,0,0.19);
	  animation-name: animatetop;
	  animation-duration: 0.4s
	}
	
	/* Add Animation */
	@keyframes animatetop {
	  from {top: -300px; opacity: 0}
	  to {top: 0; opacity: 1}
	}	
</style>

<script type="text/javascript">
	
	$(document).ready(function(){

		
        
		var category = $("input#hiddenCategory").val();
		var seq = $("input#hiddenSeq").val();
		var searchType = $("input#hiddenSearchType").val();
		var searchWord = $("input#hiddenSearchWord").val();

		
		$("button#payUpdateBtn").click(function(){

			var seq = $("td#mbr_seqTd").text();
			
			location.href='<%=ctxPath%>/payment.opis?category='+category+'&seq='+seq+'&searchType='+searchType+'&searchWord='+searchWord;  

			$.ajax({
					url:"<%=ctxPath%>/payUpdate.opis",
					type:"get",
					data:{"seq":seq},
					dataType:"json",
					success:function(json){
							if(json==1){
								alert("업데이트 성공");
							}
							else{

								alert("업데이트 실패");
							}
					},
					error: function(request, status, error){
		            	alert("code: "+request.status+"\n"+"message: "+request.responseText+"\n"+"error: "+error);
		            }
			});	
		});
		
		//// [계] 값 등록하기 시작 //////
		
		var basePaySum = 0;
		$("td.basePay").each(function(index,item){
			console.log(item.innerHTML);
			basePaySum += Number(item.innerHTML);
		});
		$("td.basePaySum").text(basePaySum);
		
		var spePaySum = 0;
		$("td.spePay").each(function(index,item){
			console.log(item.innerHTML);
			spePaySum += Number(item.innerHTML);
		});
		$("td.spePaySum").text(spePaySum);
		
		var breakPaySum = 0;
		$("td.breakPay").each(function(index,item){
			console.log(item.innerHTML);
			breakPaySum += Number(item.innerHTML);
		});
		$("td.breakPaySum").text(breakPaySum);
		
		var mealPaySum = 0;
		$("td.mealPay").each(function(index,item){
			console.log(item.innerHTML);
			mealPaySum += Number(item.innerHTML);
		});
		$("td.mealPaySum").text(mealPaySum);
		
		var timePaySum = 0;
		$("td.timePay").each(function(index,item){
			console.log(item.innerHTML);
			timePaySum += Number(item.innerHTML);
		});
		$("td.timePaySum").text(timePaySum);
		
		var totalPaySum = 0;
		$("td.totalPay").each(function(index,item){
			console.log(item.innerHTML);
			totalPaySum += Number(item.innerHTML);
		});
		$("td.totalPaySum").text(totalPaySum);
		//// [계] 값 등록하기 끝 //////
		
		
		
		// Get the modal
		var modalRegi = document.getElementById("modalRegister");

		// Get the button that opens the modal
		var btnRegi = document.getElementById("payRegiBtn");

		// Get the <span> element that closes the modal
		var spanRegi = document.getElementById("closeRegi");

		// When the user clicks on the button, open the modal
		btnRegi.onclick = function() {
		  modalRegi.style.display = "block";
		  

			
			
		/// 급여 등록시 월 제한 두기 시작////
		
		var payList = [];
		
		$.ajax({
				url:"<%=ctxPath%>/payModiGetInfo.opis",
				type:"get",
				data:{"seq":seq},
				dataType:"json",
				success:function(json){

				   $.each(json, function(index, item){
					   payList[index] = item;
				   });	
				var html = "";
					for(var i=1 ; i<13; i++){
					var bflag = 1;
						for(var j=0; j<payList.length; j++){
							if(i==payList[j].paymonth){
								
								bflag *= 0;
							}
						}
						
						if(bflag != 0){
							html += '<option class = "paymonth" value="${count.count}">'+i+'</option>';
						}
					}
				
					$("select.paymonth").html(html);
			
				},
				error: function(request, status, error){
	            	alert("code: "+request.status+"\n"+"message: "+request.responseText+"\n"+"error: "+error);
	            }
		});	
		
		/// 급여 등록시 월 제한 두기 끝////		  
		  
		
		}

		// When the user clicks on <span> (x), close the modal
		spanRegi.onclick = function() {
		  modalRegi.style.display = "none";
		}

		// When the user clicks anywhere outside of the modal, close it
		window.onclick = function(event) {
		  if (event.target == modalRegi) {
		    modalRegi.style.display = "none";
		  }
		}
		
		

		$("button#paymentRegiEndBtn").click(function() {
			var category = $("input#hiddenCategory").val();
			var searchType = $("input#hiddenSearchType").val();
			var searchWord = $("input#hiddenSearchWord").val();

			
			
			var bflag = true;
			var spePay = $("input[name=spePay]").val();
			if(spePay == null){
				bflag = false;
			}
			var breakPay = $("input[name=breakPay]").val();
			if(breakPay == null){
				bflag = false;
			}
			var mealPay = $("input[name=mealPay]").val();
			if(mealPay == null){
				bflag = false;
			}
			var timePay = $("input[name=timePay]").val();
			if(timePay == null){
				bflag = false;
			}				

			if(!bflag){
				alert("모든 항목을 입력하세요!!");
			}
			else{
			var frm = document.payRegiFrm;
			frm.method = "POST";
			frm.action = "<%=ctxPath%>/paymentRegiEnd.opis?&seq="+${insavo.mbr_seq}+"&category="+category+'&searchType='+searchType+'&searchWord='+searchWord; 
			frm.submit(); 
			}
		});
		
	});// end of $(document).ready(function(){})----------------------------------------
	
	
	function goModiPage(){
		
		var seq = $("td#mbr_seqTd").text();
		var payList = [];
 
		var category = $("input#hiddenCategory").val();
		var seq = $("input#hiddenSeq").val();
		var searchType = $("input#hiddenSearchType").val();
		var searchWord = $("input#hiddenSearchWord").val();


		$.ajax({
				url:"<%=ctxPath%>/payModiGetInfo.opis",
				type:"get",
				data:{"seq":seq},
				dataType:"json",
				success:function(json){

				   $.each(json, function(index, item){
					   payList[index] = item;
				   });	
				   
				   var html = "";
					 html = '<button id="payModiBackBtn" class="paymentInfoBtn" onclick="goModiBack()" type="button">완료</button>';
							
						   
			       html = html + '<table id="paymentInfo" class="paymentTbl table table-striped tdtable">'+
								'<thead>'+
									'<tr>'+
										'<th class="thNum"><br><br><span style="display: inline-block; width: 40px;">순번</span></th>'+
										'<th><br><br><span class="sort">항목명</span></th>';
					
										
					
						for(var i=0; i<payList.length; i++){
							html += '<th style="text-align:center;"><span style="display: inline-block; width:110px;"><button class="btnSmall" onclick="goPayModi('+payList[i].paymonth+')" type="button">수정</button>&nbsp;<button class="btnSmall" onclick="goPayDel('+payList[i].paymonth+')" type="button">삭제</button></span>';
							html +=	'<br><br><span style="display: inline-block; width: 100px;">'+payList[i].paymonth+'월</span></th>';
						}
						html = html +
									'</tr>'+
								'</thead>'+
								'<tbody>'+
									'<tr>'+
										'<td class="tdNum">1</td>'+
										'<td><span class="sort">기본급</span></td>';

						for(var i=0; i<payList.length; i++){
							html +=	'<td><span style="display: inline-block; width: 100px;">'+payList[i].basePay+'</span></td>';
						}				
						
						html = html +			
									'</tr>'+
									'<tr>'+
										'<td class="tdNum">2</td>'+
										'<td><span class="sort">상여</span></td>';

						for(var i=0; i<payList.length; i++){
							html +=	'<td><span style="display: inline-block; width: 100px;">'+payList[i].spePay+'</span></td>';
						}	
										

						html = html +	
									'</tr>'+
									'<tr>'+
										'<td class="tdNum">3</td>'+
										'<td><span class="sort">연차수당</span></td>';

						for(var i=0; i<payList.length; i++){
							html +=	'<td><span style="display: inline-block; width: 100px;">'+payList[i].breakPay+'</span></td>';
						}	
						
						html = html +	
									'</tr>'+
									'<tr>'+
										'<td class="tdNum">4</td>'+
										'<td><span class="sort">식대</span></td>';

						for(var i=0; i<payList.length; i++){
							html +=	'<td><span style="display: inline-block; width: 100px;">'+payList[i].mealPay+'</span></td>';
						}
						
						html = html +								
									'</tr>'+
									'<tr>'+
										'<td class="tdNum">5</td>'+
										'<td><span class="sort">시간 외 근무 수당</span></td>';

						for(var i=0; i<payList.length; i++){
							html +=	'<td><span style="display: inline-block; width: 100px;">'+payList[i].timePay+'</span></td>';
						}
						
						html = html +
									'</tr>'+
								'</tbody>'+
							'</table>'; 

					$("div#paymentInfoBorder").html(html);	
			
				},
				error: function(request, status, error){
	            	alert("code: "+request.status+"\n"+"message: "+request.responseText+"\n"+"error: "+error);
	            }
		});	
		

	}
	
	
	function goModiBack(){
		var category = $("input#hiddenCategory").val();
		var seq = $("input#hiddenSeq").val();
		var searchType = $("input#hiddenSearchType").val();
		var searchWord = $("input#hiddenSearchWord").val();
		location.href='<%=ctxPath%>/paymentDetail.opis?category='+category+'&seq='+seq+'&searchType='+searchType+'&searchWord='+searchWord; 
	}
	
	function goPayModi(month){
		
        
		var category = $("input#hiddenCategory").val();
		var searchType = $("input#hiddenSearchType").val();
		var searchWord = $("input#hiddenSearchWord").val();

		
		var seq = $("td#mbr_seqTd").text();
		var payList = [];
		
		$.ajax({
				url:"<%=ctxPath%>/payModiGetInfo.opis",
				type:"get",
				data:{"seq":seq},
				dataType:"json",
				success:function(json){

				   $.each(json, function(index, item){
					   payList[index] = item;
				   });	
				   
				   var html = "";
					 
						   
						   
			html = html + '<form name="payModiEndFrm">'+				
							'<table id="paymentInfo" class="paymentTbl table table-striped tdtable">'+
								'<thead>'+
									'<tr>'+
										'<th class="thNum"><span style="display: inline-block; width: 40px;"><br><br>순번</span></th>'+
										'<th><br><br><span class="sort">항목명</span></th>';
					
										
					
						for(var i=0; i<payList.length; i++){
								
							if(payList[i].paymonth==month){
									html += '<th style="text-align:center;"><span style="display: inline-block; width:150px;"><button class="btnSmall" onclick="goModiEnd('+payList[i].paymonth+')" type="button">수정완료</button><button class="btnSmall" onclick="goModiPage()" type="button">취소</button></span>';
							}
							else{
									html += '<th style="text-align:center;"><span style="display: inline-block; width:110px;"></span>';
							}
							
							html +=	'<br><br><span style="display: inline-block; width: 100px;">'+payList[i].paymonth+'</span></th>';

						}
						html = html +
									'</tr>'+
								'</thead>'+
								'<tbody>'+
									'<tr>'+
										'<td class="tdNum">1</td>'+
										'<td><span class="sort">기본급</span></td>';


						for(var i=0; i<payList.length; i++){
								html +=	'<td><span style="display: inline-block; width: 100px;">'+payList[i].basePay+'</span></td>';
					
						}				
						
						html = html +			
									'</tr>'+
									'<tr>'+
										'<td class="tdNum">2</td>'+
										'<td><span class="sort">상여</span></td>';


						for(var i=0; i<payList.length; i++){
							if(payList[i].paymonth != month){
								html +=	'<td><span style="display: inline-block; width: 100px;">'+payList[i].spePay+'</span></td>';
								}
							else{
								html +=	'<td><span style="display: inline-block; width: 100px;"><input name = "spePay" style="display: inline-block; width: 80px;" value="'+payList[i].spePay+'"/></span></td>';
							}
						}	
										

						html = html +	
									'</tr>'+
									'<tr>'+
										'<td class="tdNum">3</td>'+
										'<td><span class="sort">연차수당</span></td>';


						for(var i=0; i<payList.length; i++){
							if(payList[i].paymonth != month){
								html +=	'<td><span style="display: inline-block; width: 100px;">'+payList[i].breakPay+'</span></td>';
								}
							else{
								html +=	'<td><span style="display: inline-block; width: 100px;"><input name = "breakPay" style="display: inline-block; width: 80px;" value="'+payList[i].breakPay+'"/></span></td>';
							}
						}
						
						html = html +	
									'</tr>'+
									'<tr>'+
										'<td class="tdNum">4</td>'+
										'<td><span class="sort">식대</span></td>';


						for(var i=0; i<payList.length; i++){
							if(payList[i].paymonth != month){
								html +=	'<td><span style="display: inline-block; width: 100px;">'+payList[i].mealPay+'</span></td>';
								}
							else{
								html +=	'<td><span style="display: inline-block; width: 100px;"><input name = "mealPay" style="display: inline-block; width: 80px;" value="'+payList[i].mealPay+'"/></span></td>';
							}
						}
						
						html = html +								
									'</tr>'+
									'<tr>'+
										'<td class="tdNum">5</td>'+
										'<td><span class="sort">시간 외 근무 수당</span></td>';


						for(var i=0; i<payList.length; i++){
							if(payList[i].paymonth != month){
								html +=	'<td><span style="display: inline-block; width: 100px;">'+payList[i].timePay+'</span></td>';
								}
							else{
								html +=	'<td><span style="display: inline-block; width: 100px;"><input name = "timePay" style="display: inline-block; width: 80px;" value="'+payList[i].timePay+'"/></span></td>';
							}
						}
						
						html = html +
									'</tr>'+
								'</tbody>'+
							'</form>'+
							'</table>'; 

					$("div#paymentInfoBorder").html(html);	
			
				},
				error: function(request, status, error){
	            	alert("code: "+request.status+"\n"+"message: "+request.responseText+"\n"+"error: "+error);
	            }
		});
					 
	}
	
	
	function goModiEnd(month){
	
		
		var category = $("input#hiddenCategory").val();
		var seq = $("input#hiddenSeq").val();
		var searchType = $("input#hiddenSearchType").val();
		var searchWord = $("input#hiddenSearchWord").val();
		
		
		var bflag = true;

		var spePay = $("input[name=spePay]").val();
		if(spePay == null){
			bflag = false;
		}
		var breakPay = $("input[name=breakPay]").val();
		if(breakPay == null){
			bflag = false;
		}
		var mealPay = $("input[name=mealPay]").val();
		if(mealPay == null){
			bflag = false;
		}
		var timePay = $("input[name=timePay]").val();
		if(timePay == null){
			bflag = false;
		}				

		if(!bflag){
			alert("모든 항목을 입력하세요!!");
		}
		else{
			var frm = document.payModiEndFrm;
			frm.method = "POST";
			frm.action = '<%=ctxPath%>/paymentModiEnd.opis?category='+category+'&seq='+seq+'&month='+month+'&searchType='+searchType+'&searchWord='+searchWord; 
			frm.submit();
		}
		
		
		 
	}
	
	function goBackPayment(){
	
		
		var category = $("input#hiddenCategory").val();
		var seq = $("input#hiddenSeq").val();
		var searchType = $("input#hiddenSearchType").val();
		var searchWord = $("input#hiddenSearchWord").val();

		location.href='<%=ctxPath%>/payment.opis?category='+category+'&seq='+seq+'&searchType='+searchType+'&searchWord='+searchWord;  
	}
	
	function goPayDel(month){

		var category = $("input#hiddenCategory").val();
		var seq = $("input#hiddenSeq").val();
		var searchType = $("input#hiddenSearchType").val();
		var searchWord = $("input#hiddenSearchWord").val();
		
		

		location.href = '<%=ctxPath%>/paymentDelEnd.opis?category='+category+'&seq='+seq+'&month='+month+'&searchType='+searchType+'&searchWord='+searchWord; 

			
	}
</script>

<div id="insa" style="width: 80%; display: inline-block; margin-top: 70px; padding-left: 30px;">
						
			<div class="paymentInfoDiv" style="vertical-align: top;">
				<table id="paymentDetailBaseInfo">
					<tr>
						<td id="mbr_seqTd">${insavo.mbr_seq}</td>
						<td>${insavo.mbr_name}</td>
						
						<c:if test="${insavo.fk_dept_no == 0}">
						<td>영업</td>
						</c:if>
						<c:if test="${insavo.fk_dept_no == 1}">
							<td>인사</td>
						</c:if>
						<c:if test="${insavo.fk_dept_no == 2}">
							<td>홍보</td>
						</c:if>
						<c:if test="${insavo.fk_dept_no == 3}">
							<td>IT</td>
						</c:if>
						<c:if test="${insavo.fk_dept_no == 4}">
							<td>회계</td>
						</c:if>
						<c:if test="${!(insavo.fk_dept_no == 4 || insavo.fk_dept_no == 3 || insavo.fk_dept_no == 2 || insavo.fk_dept_no == 1 || insavo.fk_dept_no == 0)}">
							<td>기타</td>
						</c:if>
					
						<c:if test="${insavo.fk_rank_no == 0}">
							<td>팀장</td>
						</c:if>						
						<c:if test="${insavo.fk_rank_no == 1}">
							<td>팀원</td>
						</c:if>						
						<c:if test="${insavo.fk_rank_no == 2}">
							<td style="color: red;">대표</td>
						</c:if>	
					</tr>
				</table>
				<br>
				<input id="hiddenSeq" type="hidden" value="${insavo.mbr_seq}" />
				<input id="hiddenCategory" type="hidden" value="${category}" />
				<input id="hiddenSearchType" type="hidden" value="${searchType}" />
				<input id="hiddenSearchWord" type="hidden" value="${searchWord}" />
			</div>
			<div class="paymentInfoDiv" style="vertical-align: top; float: left;">
				<button id="closeBtn" style="background-color: gray; " class="paymentInfoBtn" onclick="goBackPayment()">급여목록으로</button>
			</div>

			<div id='paymentInfoBorder' class='paymentBorder' style="margin-top: 30px;" >
				<button id="payRegiBtn"  type="button">급여 추가</button>
				<button id="payModiBtn" type="button" onclick="goModiPage()">수정</button>
								
				<table id='paymentInfo' class='paymentTbl table table-striped tdtable'>
					<thead>
						<tr>
							<th class="thNum"><span style="display: inline-block; width: 40px;">순번</span></th>
							<th><span class="sort">항목명</span></th>
							<th>계</th>
							<c:forEach var="pList" items="${paymentList}">
							<th><span style="display: inline-block; width: 100px;">${pList.paymonth}월</span></th>
							</c:forEach>
						</tr>
					</thead>
					<tbody>
						<tr>
							<td class="tdNum">1</td>
							<td><span class="sort">기본급</span></td>
							<td class="basePaySum"></td>
							<c:forEach var="pList" items="${paymentList}">
							<td class="basePay">${pList.basePay}</td>
							</c:forEach>
						</tr>
						<tr>
							<td class="tdNum">2</td>
							<td><span class="sort">상여</span></td>
							<td class="spePaySum"></td>
							<c:forEach var="pList" items="${paymentList}">
							<td class="spePay">${pList.spePay}</td>
							</c:forEach>
						</tr>
						<tr>
							<td class="tdNum">3</td>
							<td><span class="sort">연차수당</span></td>
							<td class="breakPaySum"></td>
							<c:forEach var="pList" items="${paymentList}">
							<td class="breakPay">${pList.breakPay}</td>
							</c:forEach>
						</tr>
						<tr>
							<td class="tdNum">4</td>
							<td ><span class="sort">식대</span></td>
							<td class="mealPaySum"></td>
							<c:forEach var="pList" items="${paymentList}">
							<td class="mealPay">${pList.mealPay}</td>
							</c:forEach>
						</tr>
						<tr>
							<td class="tdNum">5</td>
							<td><span class="sort">시간 외 근무 수당</span></td>
							<td class="timePaySum"></td>
							<c:forEach var="pList" items="${paymentList}">
							<td class="timePay">${pList.timePay}</td>
							</c:forEach>
						</tr>
						<tr>
							<td class="tdNum"></td>
							<td><span class="sort">총 계</span></td>
							<td class="totalPaySum"></td>
							<c:forEach var="pList" items="${paymentList}">
							<td class="totalPay">${pList.totalPay}</td>
							</c:forEach>
						</tr>
					</tbody>
				</table>
			</div>
		
		
		<!-- 등록 Modal content -->
		<div id="modalRegister" class="modal">
		  <div class="modal-header">
		    <span class="close" id="closeRegi">&times;</span>
		    <h2 style="font-size: 10pt; font-weight: bold;">급여 등록</h2>
		  </div>
		  <div class="modal-body">
		  	  <form name="payRegiFrm">
				  <div style="display: inline;">
					   <select class="paymonth" name="paymonth" style="margin-top: 10px;">
			       	   </select><a>월</a>
					  
					  <table id="payRegiTbl" class="table table-striped tdtable">
					    <tr>
					    	<td>상여</td><td><input name="spePay" /></td>
					    </tr>
					    <tr>
					    	<td>연차수당</td><td><input name="breakPay" /></td>
					    </tr>
					    <tr>
					    	<td>식대</td><td><input name="mealPay" /></td>
					    </tr>
					    <tr>
					    	<td>시간 외 근무 수당</td><td><input name="timePay" /></td>
					    </tr>
					  </table>		  
				  </div>
				  <div style="display: inline;">
				  <button id="paymentRegiEndBtn" class="paymentInfoBtn"  type="button" style="vertical-align: top; margin-top: 30px;">등록</button>
				  </div>
			  </form>
		  </div>
		</div>
		
		
		
		
		
		
</div>



