<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<% String ctxPath = request.getContextPath(); %>

<jsp:include page="./approval_sidebar.jsp" /> 

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
	
		
		showList();	// 결재대기 문서 리스트 가져오기
		
		
		// 모두 선택 체크박스 처리
		$("input#alllList").click(function(){	
			if($("input#alllList").is(":checked")){
				$("input.approvalList").prop("checked",true);
			} else {
				$("input.approvalList").prop("checked",false);
			}			
		});
		$("input.approvalList").click(function(){	
			if($("input.approvalList:checked").length == $("input.approvalList").length){ 
				$("input#alllList").prop("checked",true);
			} else {
				$("input#alllList").prop("checked",false);
			}	
		});
		
		
		// 조회하기 버튼을 클릭한 경우
		$("button#search").click(function(){	
			$("input[name=writer]").val("$('input#searchWriter').val()");
			$("input[name=submitStartDate]").val("$('input#datepicker').val()");
			$("input[name=submitEndDate]").val("$('input#datepicker2').val()");
			$("input[name=word]").val("$('input#searchWord').val()");			
			showList();
		});
		
		
	}); // end of $(document).ready(function(){})---------------------------------------
	
	// 리스트 목록 가져오기
	function showList() {
		var managePerson = '${sessionScope.loginuser.dept_detail} ${sessionScope.loginuser.rank_detail}'
			  			 +' ${sessionScope.loginuser.mbr_name}';

		$.ajax({
			url:"<%=ctxPath%>/approvalNeededList.opis",
			dataType:"json",
			data:{managePerson:managePerson, listCnt:$("select[name=listCnt]").val(),
				  writer:$("input[name=writer]").val(), submitStartDate:$("input[name=submitStartDate]").val(),
				  submitEndDate:$("input[name=submitEndDate]").val(), word:$("input[name=word]").val(),
				  currentPage:$("input[name=currentPage]").val()},
			success: function(json){	
				var html="";
				
				if(json.length>0){	
					$.each(json, function(index, item){
						if(index==0) $("div#pageBar").append(item.pageBar);
						
						html += "<tr>"+
								"<td><input type='checkbox' class='approvalList' /></td>"+
								"<td id='"+item.ap_seq+" "+item.apform_name+"' style='cursor:pointer;' onclick='func_show(this.id)'>"+item.apform_name+"</td>"+
								"<td id='"+item.ap_seq+" "+item.apform_name+"' style='cursor:pointer;' onclick='func_show(this.id)'>"+item.ap_title+"</td>"+
								"<td id='"+item.ap_seq+" "+item.apform_name+"' style='cursor:pointer;' onclick='func_show(this.id)'>"+item.mbr_name+"</td>"+
								"<td id='"+item.ap_seq+" "+item.apform_name+"' style='cursor:pointer;' onclick='func_show(this.id)'>"+item.ap_dept+"</td>"+
								"<td id='"+item.ap_seq+" "+item.apform_name+"' style='cursor:pointer;' onclick='func_show(this.id)'>"+item.ap_start_day+"</td>"+
							    "</tr>";
					});
					
				}
				else {
					html += "<tr><td></td><td>결재 대기중인 문서가 없습니다.</td><td></td><td></td><td></td><td></td></tr>"
				}
					
				$("tbody#list").append(html);
			},
			error: function(request, status, error){
                alert("code: "+request.status+"\n"+"message: "+request.responseText+"\n"+"error: "+error);
            }
		}); 

		
	}// end of function showList() ---------------------------------------
	
	
	// 세부 결재내용 보여주기
	function func_show(id){
		var arr = id.split(" ");
		
		if(arr[1]=='일반기안서'){
			location.href="<%= ctxPath%>/approvalForm1.opis?ap_seq="+arr[0];
		} else if(arr[1]=='지출결의서'){
			location.href="<%= ctxPath%>/approvalForm2.opis?ap_seq="+arr[0];
		} else {
			location.href="<%= ctxPath%>/approvalForm3.opis?ap_seq="+arr[0];
		}
		
	}
	
	
	function func_allApproval() {
		var ap_seqArr=[];
		
		console.log();
		for (var i=0; i<$("input.approvalList").length; i++) {
			$("input.approvalList:checked").id
			ap_seqArr.push();
		}
		
		$.ajax({
			url:"<%=ctxPath%>/allApproval.opis",
			dataType:"json",
			data:{},
			success: function(json){	
				if(json.n=="1"){
					history.back();
				}
			},
			error: function(request, status, error){
                alert("code: "+request.status+"\n"+"message: "+request.responseText+"\n"+"error: "+error);
            }
		}); 	
	}// end of function func_allApproval() ------------------------------------------
	
	
</script>
</head>
<body>

	<div id="approvalContainer">
		<span class="subtitle">결재 대기중인 문서</span>
		<hr> 	
		<div id="searchOption">
			<table>
				<tr>
					<td>기안자</td>
					<td><input type="text" class="form-control searchInput" style="width: 50%;" id="searchWriter" value=""/></td>
					<td>기안일</td>
					<td>
						<input type="text" class="form-control searchInput" id="datepicker" value=""/>
						<span>-</span>
						<input type="text" class="form-control searchInput" id="datepicker2" value=""/>
					</td>
				</tr>
				<tr>
					<td>문서내용</td>
					<td colspan="3">
						<input type="text" class="form-control searchInput" id="search" value=""/>
						<button type="button" class="btn formBtn4" id="search">조회하기</button>
					</td>
				</tr>
			</table>
		</div>
		<div id="searchList">
			<select name="listCnt" class="selectCommon" name="listCnt" id="listCnt">
				<option>10개</option>
				<option>8개</option>
				<option>4개</option>
			</select>
			<button type="button" class="btn btn-success formBtn4" id="approval" onclick="func_allApproval">일괄결재</button>
			<table class="table table-striped">
				<thead>
					<tr>
						<th><input type="checkbox" id="alllList"/></th>
						<th>종류</th>
						<th>문서제목</th>
						<th>기안자</th>
						<th>기안부서</th>
						<th>기안일</th>
					</tr>
				</thead>
				<tbody id="list" ></tbody>
			</table> 					
		</div>
		<br>
		<input type="hidden" name="word" value="" />
		<input type="hidden" name="writer" value="" />
		<input type="hidden" name="submitStartDate" value="" />
		<input type="hidden" name="submitEndDate" value="" />

		<input type="hidden" name="currentPage" value="1" />
		
	</div>

</body>
</html>