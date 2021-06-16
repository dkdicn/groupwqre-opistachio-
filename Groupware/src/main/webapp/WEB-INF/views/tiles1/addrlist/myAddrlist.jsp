<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<% String ctxPath = request.getContextPath(); %>
<% String addrgroup_seq = request.getParameter("addrgroup_seq"); %>

  <jsp:include page="./addr_sidebar.jsp" />

<link rel="stylesheet" type="text/css" href="<%=ctxPath %>/resources/css/boardButtons.css">
<script type="text/javascript">

	$(document).ready(function(){

		$("input#searchWord").bind("keydown", function(event){
			if(event.keyCode == 13){// 엔터를 했을 경우
				goSearch();
			}
		});
		
		// 검색리스트 숨기기
		$("div#displayList").hide();
		
		$("input#searchWord").keyup(function(){
			
			var wordLength = $(this).val().trim().length;
			
			if(wordLength == 0){
				$("div#displayList").hide();
			}
			else{
				$.ajax({
					url:"<%= ctxPath%>/mywordSearchShow.opis",
					type:"get",
					data:{"searchType":$("select#searchType").val()
						 ,"searchWord":$("input#searchWord").val()
						 ,"addrgroup_seq":<%=addrgroup_seq%>},
					dataType:"json",
					success:function(json){
						   if(json.length > 0){
							   // 검색된 데이터가 있는 경우
							   var html = "";
							   
							   $.each(json, function(index, item){
								   var word = item.word;
								   var index = word.toLowerCase().indexOf($("input#searchWord").val().toLowerCase());
								   var len = $("input#searchWord").val().length;
								   
								   word = word.substr(0,index) + "<span style='color:blue;'>"+word.substr(index,len)+"</span>"+word.substr(index+len);
								   
								   html += "<span style='cursor:pointer;' class='word'>"+word+"</span><br>";
							   });
							   
							   $("div#displayList").html(html);
							   $("div#displayList").show();
						   }
	
					},
					error: function(request, status, error){
		                  	alert("code: "+request.status+"\n"+"message: "+request.responseText+"\n"+"error: "+error);
		              }
				
				});
			}
		}); // end of $("input#searchWord").keyup(function(){})------------------------
		
		$(document).on("click","span.word",function(){
			$("input#searchWord").val($(this).text());// 텍스트박스에 검색된 결과의 문자열을 입력
			$("div#displayList").hide();
			goSearch();
		});
		
		// 검색시 검색조건 및 검색어값 유지
		if(${not empty requestScope.paraMap}){
			$("select#searchType").val("${requestScope.paraMap.searchType}");
			$("input#searchWord").val("${requestScope.paraMap.searchWord}");
		}
		
	}); // end of $(document).ready(function(){})---------------------------------------

	function goView(addr_seq){
		
		location.href="<%=ctxPath%>/addr_view.opis?addr_seq="+addr_seq;
		
	} // end of function goView(addr_seq)---------------------------------------------------- 
	
	function goSearch(){
		
		var frm = document.searchFrm;
		frm.method = "get";
		frm.action = "<%=ctxPath%>/myAddrlist.opis";
		frm.submit();
		
	} // end of goSearch(){}------------------------------------------------------------

	// 전체선택 체크 박스를 클릭했을 때 
	function clickAllCheckbox() {
		// input#allCheckbox ==> 전체선택 체크박스  id="allCheckbox"
		// input.oneCheckbox ==> 하위선택 체크박스  class="oneCheckbox"
		
		var stat = $("input#allCheckbox").prop("checked");
		
		$("input.oneCheckbox").each(function(index, item){
			$(item).prop("checked", stat);
		});
	}// end of function clickAllCheckbox()----------------------------
	
	// 하위 체크박스를 클릭했을 때
	function clickOneCheckbox(target) {
		// onclick="clickOneCheckbox(this)";
		
		var stat = $(target).prop("checked");
		
		if (!stat) { // 체크가 풀린 경우라면
			$("input#allCheckbox").prop("checked", false);
		}
		else {
			var check; // 다른 하위 체크박스 검사
			$("input.oneCheckbox").each(function(index, item){
				check = $(item).prop("checked");
				if (check == false) {
					return false;
				}
			});
			if (check) { // 전부 true 일 때
				$("input#allCheckbox").prop("checked", true);	
			}
		}
	}// end of function clickOneCheckbox(target)-------------------------
	
	// 개인 주소록에서 제거
	function delmyAddr(addrgroup_seq){
		
		var check = $("input[name=checkAddrSeq]");
		var len = check.length;
		var checkCnt = 0;
		
		// 체크된 총 개수 구하기
		for(var i=0; i<len; i++){
			if(check[i].checked == true){
				checkCnt++;
			}
		}
		
		if(checkCnt == 0){ // 체크된 값이 없을때
			alert("체크된 항목이 없습니다.");
			return false;
		}
		
		var checkAddrSeq = [];
		$("input[name=checkAddrSeq]:checked").each(function(){
			checkAddrSeq.push($(this).val());
		});
			
		location.href="<%=ctxPath%>/delmyAddr.opis?addrgroup_seq="+addrgroup_seq+"&checkCnt="+checkCnt+"&checkAddrSeq="+checkAddrSeq;
		
	}// end of function delmyAddr()---------------------------
	
</script>

<div style="width: 1460px"> 
	
	<!-- 게시판제목 -->
	<div style="padding: 15px; font-size: 25px; font-weight: 600; height: 60px; width: 100%; background-color: #f2f2f2; color: #555;">
	&nbsp;&nbsp;개인 주소록
	</div>
	
	<div class="container" style="float: right; width: 80%; margin-top: 30px;">        
	    
	    <!-- 개인 주소혹에서 삭제 -->
	    <button type="button" class="btn-basic" style="float:right; margin: 0 30px 30px 0; width:150px; font-size: 11px;" onclick="delmyAddr(<%=addrgroup_seq%>)">
	          주소록에서 삭제
	    </button>

		<!-- 본문(게시판) -->
		<table class="table table-striped" style="font-size: 14px; text-align: center;">
		  <thead>
		    <tr>
		      <th style="width: 1%;"><input type="checkbox" id="allCheckbox" onclick="clickAllCheckbox();" /></th>		    
		      <th style="width: 7%;">이름</th>
		      <th style="width: 10%;">전화번호</th>
		      <th style="width: 10%;">이메일</th>
		      <th style="width: 7%;">부서</th>
		      <th style="width: 7%;">직책</th>
		    </tr>
		  </thead>
		  <tbody>
		  	<c:if test="${not empty requestScope.myAddrlist}">	    	
		     		<c:forEach var="addrvo" items="${requestScope.myAddrlist}" varStatus="status">
		      	<tr align="center">
   		      		<td><input type="checkbox" class="oneCheckbox" name="checkAddrSeq" value="${addrvo.addr_seq}" onclick="clickOneCheckbox(this);"/></td>   		      	
					<td>
						<span class="name" onclick="goView('${addrvo.addr_seq}')">${addrvo.mbr_name}</span>
					</td>
					<td>${addrvo.mbr_phone_number}</td>
					<td>${addrvo.mbr_email}</td>
					<td>${addrvo.dept_name}</td>
					<td>${addrvo.position_name}</td>
		      	</tr>		      
		     	</c:forEach>
		     </c:if>
		    <c:if test="${empty requestScope.myAddrlist}">
		     	<tr>
				<td align="center" colspan="5">
					주소록에 등록된 사람이 없습니다.
				</td>
		     	</tr>
		    	</c:if>
		  </tbody>
		</table>

		<!-- 페이지바 -->  
		<c:if test="${not empty requestScope.myAddrlist}">
			<div align="center" style="width: 70%; border: solid 0px gray; margin: 20px auto;">
		   		${requestScope.pageBar}
		    </div>
		</c:if>
		
		<!-- 검색 -->
		<form name="searchFrm" style="margin-bottom: 20px;">
	      <select name="searchType" id="searchType" style="height: 26px;">
	         <option value="dept_name">부서</option>
	         <option value="mbr_name">이름</option>
	      </select>
	      <input type="text" name="searchWord" id="searchWord" size="30" autocomplete="off" /> 
	      <input type="hidden" name="addrgroup_seq" id="addrgroup_seq" value="<%=addrgroup_seq%>" />
	      <button type="submit" onclick="goSearch()" class="btn-search">검색</button>
	   	</form>
	   
	    <div id="displayList" style="border:solid 1px gray; width:170px; height: 100px; border-top: 0px; margin-left: 49px; overflow: auto; padding-top: 2px;"> 	
	    </div>
	
	</div>	  	
	
</div>
