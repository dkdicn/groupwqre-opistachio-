<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<% String ctxPath = request.getContextPath(); %>

<meta name="viewport" content="width=device-width, initial-scale=1">

<jsp:include page="./insa_sidebar.jsp" />


<style>

	
select:hover{
	cursor: pointer;
}
tr.memberInfo:hover{
	cursor: pointer;
}



	/* Dropdown Button */
	.dropbtn {
	  background-color: #68b658;
	  color: white;
	  padding: 16px;
	  font-size: 16px;
	  border: none;
	  cursor: pointer;
	}
	
	/* Dropdown button on hover & focus */
	.dropbtn:hover, .dropbtn:focus {
	  background-color: #41a441;
	}
	
	/* The container <div> - needed to position the dropdown content */
	.dropdown {
	  position: relative;
	  display: inline-block;
	}
	
	/* Dropdown Content (Hidden by Default) */
	.dropdown-content {
	  display: none;
	  position: absolute;
	  background-color: #f1f1f1;
	  min-width: 160px;
	  box-shadow: 0px 8px 16px 0px rgba(0,0,0,0.2);
	  z-index: 1;
	}
	
	/* Links inside the dropdown */
	.dropdown-content a {
	  color: black;
	  padding: 12px 16px;
	  text-decoration: none;
	  display: block;
	}
	
	/* Change color of dropdown links on hover */
	.dropdown-content a:hover {background-color: #ddd}
	
	/* Show the dropdown menu (use JS to add this class to the .dropdown-content container when the user clicks on the dropdown button) */
	.show {display:block;}
	
	button.paymentInfoBtn{
	  display:inline-block;
 	  margin-left: 20px;
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
	table#insaSearchTbl tr{
		display: inline-block;
		height: 50px;
	}
	
	table#insaSearchTbl td{
		display: inline-block;
		height: 50px;
		padding: 10px;
	}
	form.example{
		display: inline-block;
		float: none;
		height: 50px;
	}
	button#insaSearchButton{
		width: 50px;
		height: 35px;
		font-size: 12pt;
	}
	
	table.paymentTbl{
		border-collapse: collapse;
		
	}
	div.paymentBorder{
		display: inline-block;
		margin-top: 20px;
		
	}
	table.paymentTbl td {
		border: solid 1px black;
		font-size: 10pt;
		height: 50px;	
	}
	td.tdNarrow{
		width: 100px;	
	}
	td.tdWide{
		width: 150px;	
	}
	
	table.paymentTbl tr{
		border: solid 1px black;
		vertical-align: middle;
	}
	table.paymentTbl input{
		height: 30px;
	}
	table#memberListTbl{
		margin-left:10px;
	}
	table.paymentTbl{
		margin-left: 10px;
	}
	div.paymentBorder{
		display: inline-block;
		border: solid 3px gray;
		background-color: white;
		width: 50%;
		height: 450px;
		padding-top: 15px;
		text-align: center;
	}
	div.paymentInfoDiv{
		display: inline-block;
	}
	.green{
		background-color: #68b658; 
		font-size: 15pt;
		font-weight: bold;
	}
	input.payInput{
		width: 90px;
	}
</style>

<script type="text/javascript">
	/* When the user clicks on the button,
	toggle between hiding and showing the dropdown content */
	
	function myFunction() {
	  document.getElementById("myDropdown").classList.toggle("show");
	}
	
	
	// Close the dropdown menu if the user clicks outside of it
	
	$(document).ready(function(){
		$("div#paymentInfoBorder").hide();
		$("div#registerDiv").hide();
		$("div#registerModiDiv").hide();
		
		var seq = $("input#hiddenSeqVal").val();
		if(seq != 0){
			memberInfoView(seq);
		}
		
	});
	
	function memberInfoView(seq){
		
		$("div#registerDiv").hide();

		$("tr.clickMemberPay").children().removeClass("green");

		$("tr.clickMemberPay").each(function(index, item){
			if($(item).children(".seq").text() == seq){
				$(item).children().addClass("green");
			}
		});
		
		$("input#hiddenSeq").text(seq);
		
		$.ajax({
			url:"<%=ctxPath%>/memberPayInfo.opis",
			type:"get",
			data:{"seq":seq},
			dataType:"json",
			success:function(json){
				if (json.status == 1){
					html = 	'<div class="paymentInfoDiv" style="width: 100%; ">'+
								'<div id="buttons" style="float: right; margin-right: 15px;">'+
								'<button id="payModiBtn" onclick="goModifyPayment()" type="button">수정</button>&nbsp;&nbsp;'+
								'<button id="payDelBtn" onclick="goPaymentDel()" type="button">삭제</button>'+
								'<br><br>'+
								'</div>'+
								'<table id="paymentInfo" class="paymentTbl" style="clear: both;">'+
									'<tr>'+
										'<td class="tdNarrow">주민등록번호</td><td colspan="3" id="idNo">'+json.idNo+'</td>'+
									'</tr>'+
									'<tr>'+
										'<td class="tdNarrow">급여계정과목</td><td class="tdWide">직원급여</td><td class="tdNarrow">이달급여</td><td class="tdWide" id="basePay">'+json.basePay+'</td>'+
									'</tr>'+
									'<tr>'+
										'<td class="tdNarrow">상여계정과목</td><td class="tdWide">상여금</td><td class="tdNarrow">상여금</td><td class="tdWide" id="spePay">'+json.spePay+'</td>'+
									'</tr>'+
									'<tr>'+
										'<td class="tdNarrow">은행</td><td class="tdWide">계좌번호</td><td class="tdNarrow">예금주</td><td class="tdWide"></td>'+
									'</tr>'+
									'<tr>'+
										'<td class="tdNarrow" id="bank">'+json.bank+'</td><td class="tdWide" id="accountNo">'+json.accountNo+'</td><td class="tdNarrow" id="mbr_name">'+json.mbr_name+'</td><td class="tdWide"></td>'+
									'</tr>'+
								'</table>'+
							'</div>'+
							'<div class="paymentInfoDiv" style="margin-top: 15px;">'+
								'<button id="closeBtn" onclick="goBackPayment()">닫기</button>&nbsp;&nbsp;'+
								'<button id="payDetailBtn" onclick="goPaymentDetail()">자세히</button>'+
							'</div>';	
					
					var parameter = json.idNo + "," + json.basePay + "," + json.spePay + "," + json.bank + "," + json.accountNo + "," + json.mbr_name;
					$("input#hiddenParameter").text(parameter);	
							
				}
				else{
						html = 	'<div class="paymentInfoDiv" style="width: 100%; ">'+
						'<div id="buttons" style="float: right; margin-right: 15px;">&nbsp;&nbsp;'+
						'<button id="payModiBtn" onclick="goPaymentRegister()" type="button">등록</button>'+
						'<br><br>'+
						'</div>'+
						'<table id="paymentInfo" class="paymentTbl" style="clear: both;">'+
							'<tr>'+
								'<td class="tdNarrow">주민등록번호</td><td colspan="3" id="idNo"></td>'+
							'</tr>'+
							'<tr>'+
								'<td class="tdNarrow">급여계정과목</td><td class="tdWide">직원급여</td><td class="tdNarrow">이달급여</td><td class="tdWide" id="basePay"></td>'+
							'</tr>'+
							'<tr>'+
								'<td class="tdNarrow">상여계정과목</td><td class="tdWide">상여금</td><td class="tdNarrow">상여금</td><td class="tdWide" id="spePay"></td>'+
							'</tr>'+
							'<tr>'+
								'<td class="tdNarrow">은행</td><td class="tdWide">계좌번호</td><td class="tdNarrow">예금주</td><td class="tdWide"></td>'+
							'</tr>'+
							'<tr>'+
								'<td class="tdNarrow" id="bank"></td><td class="tdWide" id="accountNo"></td><td class="tdNarrow" id="mbr_name"></td><td class="tdWide"></td>'+
							'</tr>'+
						'</table>'+
					'</div>'+
					'<div class="paymentInfoDiv" style="margin-top: 15px;">'+
						'<button id="closeBtn" onclick="goBackPayment()">닫기</button>&nbsp;&nbsp;'+
						'<button id="payDetailBtn" onclick="goPaymentDetail()">자세히</button>'+
					'</div>';	
				}

				$("div#paymentInfoBorder").html(html);	
			},
			error: function(request, status, error){
            	alert("code: "+request.status+"\n"+"message: "+request.responseText+"\n"+"error: "+error);
            }
		});
		
		$("div#paymentInfoBorder").show();
	}
	
	function goBackPayment(){
		$("div#paymentInfoBorder").hide();
		$("tr.clickMemberPay").children().removeClass("green");
	}
	function goBackPaymentInfo(){
		$("div#registerDiv").hide();
		$("div#registerModiDiv").hide();
		$("div#paymentInfoBorder").show();
	}
	function goPaymentDetail(){
		var seq = $("input#hiddenSeq").text();
		var category = $("input#hiddenCategory").val();
		var searchType = $("input#hiddenSearchType").val();
		var searchWord = $("input#hiddenSearchWord").val();
		location.href='<%=ctxPath%>/paymentDetail.opis?category='+category+'&seq='+seq+'&searchType='+searchType+'&searchWord='+searchWord; 
	}
	function goRegisterEnd(){
		var seq = $("input#hiddenSeq").text();

		var bflag = true;
		
		var idNo = $("input#idNo").val();
		var accountNo = $("input#accountNo").val();
		var bank = $("input#bank").val();
		
		if(idNo.trim()==""){
			bflag = false;
		}
		if(accountNo.trim()==""){
			bflag = false;
		}
		if(bank.trim()==""){
			bflag = false;
		}
		

		if(!bflag){
			alert("모든 항목을 입력하세요!!");
		}
		else{
			$.ajax({
				url:"<%=ctxPath%>/payRegisterEnd.opis",
				type:"get",
				data:{"seq":seq,
					  "idNo":idNo,
					  "accountNo":accountNo,
					  "bank":bank
					  },
				dataType:"json",
				success:function(json){

					if(json == 1){
						$("div#registerDiv").hide();
						$("div#paymentInfoBorder").show();
						alert("등록성공!!");

						memberInfoView(seq);
					}
					else{
						alert("등록실패!!");
						

						memberInfoView(seq);
					}
				},
				error: function(request, status, error){
	            	alert("code: "+request.status+"\n"+"message: "+request.responseText+"\n"+"error: "+error);
	            }
			});			
		}
		

		
	}
	
	function goPaymentRegister(){
		$("div#paymentInfoBorder").hide();
		var html = 	'<div class="paymentInfoDiv" style="width: 100%; ">'+
						'<button id="payRegisterEndBtn" type="button" onClick="goRegisterEnd()">저장</button>'+
						'<br><br>'+
						'</div>'+
						'<table id="paymentInfo" class="paymentTbl" style="clear: both;">'+
							'<tr>'+
								'<td class="tdNarrow">주민등록번호</td><td colspan="3"><input id="idNo" class="payInput"/></td>'+
							'</tr>'+
							'<tr>'+
								'<td class="tdNarrow">급여계정과목</td><td class="tdWide">직원급여</td><td class="tdNarrow">이달급여</td><td class="tdWide"></td>'+
							'</tr>'+
							'<tr>'+
								'<td class="tdNarrow">상여계정과목</td><td class="tdWide">상여금</td><td class="tdNarrow">상여금</td><td class="tdWide"></td>'+
							'</tr>'+
							'<tr>'+
								'<td class="tdNarrow">은행</td><td class="tdWide">계좌번호</td><td class="tdNarrow">예금주</td><td class="tdWide"></td>'+
							'</tr>'+
							'<tr>'+
								'<td class="tdNarrow"><input id="bank" class="payInput"/></td><td class="tdWide"><input id="accountNo" class="payInput"/></td><td class="tdNarrow"></td><td class="tdWide"></td>'+
							'</tr>'+
						'</table>'+
					  '</div>'+
					  '<div class="paymentInfoDiv" style="margin-top: 15px;">'+
						'<button id="closeBtn" onclick="goBackPaymentInfo()">닫기</button>'+
					  '</div>';
		$("div#registerDiv").html(html);
		$("div#registerDiv").show();
		
	}
	
	function goModifyPayment(){
		var parameter = $("input#hiddenParameter").text()
		var data = parameter.split(",");
		
		$("div#paymentInfoBorder").hide();

		var seq = $("input#hiddenSeq").text();
		
				
		var html = 	'<div class="paymentInfoDiv" style="width: 100%; ">'+
						'<button id="payModifyEndBtn" type="button" onClick="goModifyEnd()">저장</button>'+
						'<br><br>'+
						'</div>'+
						'<table id="paymentInfo" class="paymentTbl" style="clear: both;">'+
							'<tr>'+
								'<td class="tdNarrow">주민등록번호</td><td colspan="3"><input id="idNoModi" class="payInput" value="'+data[0]+'"/></td>'+
							'</tr>'+
							'<tr>'+
								'<td class="tdNarrow">급여계정과목</td><td class="tdWide">직원급여</td><td class="tdNarrow">이달급여</td><td class="tdWide">'+data[1]+'</td>'+
							'</tr>'+
							'<tr>'+
								'<td class="tdNarrow">상여계정과목</td><td class="tdWide">상여금</td><td class="tdNarrow">상여금</td><td class="tdWide">'+data[2]+'</td>'+
							'</tr>'+
							'<tr>'+
								'<td class="tdNarrow">은행</td><td class="tdWide">계좌번호</td><td class="tdNarrow">예금주</td><td class="tdWide"></td>'+
							'</tr>'+
							'<tr>'+
								'<td class="tdNarrow"><input id="bankModi" class="payInput" value="'+data[3]+'"/></td><td class="tdWide"><input id="accountNoModi" class="payInput" value="'+data[4]+'"/></td><td class="tdNarrow"></td><td class="tdWide">'+data[5]+'</td>'+
							'</tr>'+
						'</table>'+
					  '</div>'+
					  '<div class="paymentInfoDiv" style="margin-top: 15px;">'+
						'<button id="closeBtn" onclick="goBackPaymentInfo()">닫기</button>'+
					  '</div>';
		$("div#registerModiDiv").html(html);
		$("div#registerModiDiv").show();

	}
	
	function goModifyEnd(){
		
	var seq = $("input#hiddenSeq").text();

		
		$.ajax({
			url:"<%=ctxPath%>/payModifyEnd.opis",
			type:"get",
			data:{"seq":seq,
				  "idNo":$("input#idNoModi").val(),
				  "accountNo":$("input#accountNoModi").val(),
				  "bank":$("input#bankModi").val(),
				  },
			dataType:"json",
			success:function(json){
				if(json == 1){
					$("div#registerModiDiv").hide();
					$("div#paymentInfoBorder").show();
					alert("수정성공!!");
					memberInfoView(seq);
				}
				else{
					alert("수정실패!!");
					memberInfoView(seq);
				}
			},
			error: function(request, status, error){
            	alert("code: "+request.status+"\n"+"message: "+request.responseText+"\n"+"error: "+error);
            }
		});
		
	}
	
	
	function goPaymentDel(){

		var seq = $("input#hiddenSeq").text();

		$.ajax({
				url:"<%=ctxPath%>/payDelEnd.opis",
				type:"get",
				data:{"seq":seq},
				dataType:"json",
				success:function(json){
					if(json == 1){
						alert("삭제성공!!");
						memberInfoView(seq);
					}
					else{
						alert("삭제실패!!");
						memberInfoView(seq);
					}
				},
				error: function(request, status, error){
	            	alert("code: "+request.status+"\n"+"message: "+request.responseText+"\n"+"error: "+error);
	            }
			});
					
	}
	
	function goSearch(){

		var searchType = $(".searchType option:selected").val();
		var searchWord= $("input.searchWord").val();
		var seq = $("input#hiddenSeq").text();
		var category = $("input#hiddenCategory").val();

		location.href='<%=ctxPath%>/payment.opis?category='+category+'&seq='+seq+'&searchType='+searchType+'&searchWord='+searchWord; 
	}
</script>

<div id="insa" style="width: 80%; display: inline-block; margin-top: 70px; padding-left: 30px;" >
			<table style="margin-bottom: 30px;">
				<tr>
					<td>
				 			<select name="searchType" class="searchType" id="subject">
				 				<c:if test="${searchType == 'mbr_seq' }" >
							    	<option value="mbr_seq" selected="selected">사원번호</option>
							    	<option value="mbr_name">사원명</option>
				 				</c:if>
				 				<c:if test="${searchType == 'mbr_name' }" >
							    	<option value="mbr_seq">사원번호</option>
							    	<option value="mbr_name" selected="selected">사원명</option>
				 				</c:if>
				 				<c:if test="${searchType == '' }" >
							    	<option value="mbr_seq" selected="selected">사원번호</option>
							    	<option value="mbr_name">사원명</option>
				 				</c:if>
						  	</select>
						  	
			 				<c:if test="${searchWord != '' }" >
			 					<input type="text" class="searchWord" placeholder="Search.." value="${searchWord}" name="search" style="height: 20px;">
						 	</c:if>
			 				<c:if test="${searchWord == '' }" >
						 		<input type="text" class="searchWord" placeholder="Search.." name="search" style="height: 20px;">
						 	</c:if>
								<input type="submit" onclick="goSearch()" value="검색">

					</td>
				</tr>
			</table>
			<div style="display:inline-block; width: 48%; vertical-align: top;">
			<table id="insaListaTbl" class="table table-striped tdtable">
					<thead>
					<tr>
						<th style="width: 25%; ">사원번호</th>
						<th style="width: 25%; ">사원명</th>
						<th style="width: 25%; ;">부서</th>
						<th style="width: 25%; ">직책</th>
					</tr>
					</thead>
					<tbody>
					<c:forEach var="insaList" items="${requestScope.insaList}">
					<tr class="clickMemberPay memberInfo" onclick="memberInfoView(${insaList.mbr_seq})">
						<td class="seq">${insaList.mbr_seq}</td>
						<td>${insaList.mbr_name}</td>
						<c:if test="${insaList.fk_dept_no == 0}">
							<td>영업</td>
						</c:if>
						<c:if test="${insaList.fk_dept_no == 1}">
							<td>인사</td>
						</c:if>
						<c:if test="${insaList.fk_dept_no == 2}">
							<td>홍보</td>
						</c:if>
						<c:if test="${insaList.fk_dept_no == 3}">
							<td>IT</td>
						</c:if>
						<c:if test="${insaList.fk_dept_no == 4}">
							<td>회계</td>
						</c:if>
						<c:if test="${!(insaList.fk_dept_no == 4 || insaList.fk_dept_no == 3 || insaList.fk_dept_no == 2 || insaList.fk_dept_no == 1 || insaList.fk_dept_no == 0)}">
							<td>기타</td>
						</c:if>
						
						<c:if test="${insaList.fk_rank_no == 0}">
							<td>팀장</td>
						</c:if>						
						<c:if test="${insaList.fk_rank_no == 1}">
							<td>팀원</td>
						</c:if>						
						<c:if test="${insaList.fk_rank_no == 2}">
							<td style="color: red;">대표</td>
						</c:if>	
					</tr>
					</c:forEach>
				</tbody>
			</table>
			
		   <br>
	    <div align="center" style="width: 80%; border: solid 0px gray; margin-right: 20px;">
	    	${requestScope.pageBar}
	    </div>
			<input id="hiddenSeq" type="hidden"/>
			<input id="hiddenSeqVal" type="hidden" value="${seq}"/>
			<input id="hiddenCategory" type="hidden" value="${category}" />
			<input id="hiddenSearchType" type="hidden" value="${searchType}" />
			<input id="hiddenSearchWord" type="hidden" value="${searchWord}" />
			<input id="hiddenParameter" type="hidden" />
			</div>
			&nbsp;&nbsp;
			<div id='paymentInfoBorder' class='paymentBorder' >

			</div>
			
			<div id="registerDiv" class="paymentBorder">
			</div>
			
			<div id="registerModiDiv" class="paymentBorder">
			</div>
	   
	
</div>



