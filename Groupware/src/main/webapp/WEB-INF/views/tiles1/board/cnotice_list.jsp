<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<% String ctxPath = request.getContextPath(); %>


  <title>전체공지</title>
  <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.1/css/bootstrap.min.css">
  <link rel="stylesheet" type="text/css" href="<%=ctxPath %>/resources/css/boardButtons.css">
  <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
  <script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.1/js/bootstrap.min.js"></script>
  
  
  <jsp:include page="./board_sidebar.jsp" />
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
					url:"<%= ctxPath%>/cwordSearchShow.opis",
					type:"get",
					data:{"searchType":$("select#searchType").val()
						 ,"searchWord":$("input#searchWord").val()},
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

	function goView(cnotice_seq){
		
		location.href="<%=ctxPath%>/cnotice_view.opis?cnotice_seq="+cnotice_seq;
		
	} // end of function goView(cnotice_seq)---------------------------------------------------- 
	
	function goSearch(){
		
		var frm = document.searchFrm;
		frm.method = "get";
		frm.action = "<%=ctxPath%>/cnotice_list.opis";
		frm.submit();
		
	} // end of goSearch(){}------------------------------------------------------------
	
</script>

<div style="width: 1460px"> 

	<!-- 게시판제목 -->
	<div style="padding: 15px; font-size: 25px; font-weight: 600; height: 60px; width: 100%; background-color: #f2f2f2; color: #555;">
	&nbsp;&nbsp;전체 공지사항
	</div>

	<!-- 본문(게시판) -->
	<div class="container" style="float: right; width: 80%; margin-top: 50px;"> 
	        
	  <table class="table table-striped">
	    <thead>
	      <tr>
	        <th style="width: 5%;  text-align: center;">번호</th>
	        <th style="width: 13%; text-align: center;">제목</th>
	        <th style="width: 7%;  text-align: center;">등록자</th>
	        <th style="width: 10%; text-align: center;">등록일</th>
	        <th style="width: 5%;  text-align: center;">조회수</th>
	      </tr>
	    </thead>
	    <tbody>
	      <c:forEach var="cnoticevo" items="${requestScope.boardList}" varStatus="status">
	      	<tr>
				<td align="center">${cnoticevo.cnotice_seq}</td>
				<td align="left">
					<span class="title" onclick="goView('${cnoticevo.cnotice_seq}')">${cnoticevo.ctitle}</span>
				</td>
				<td align="center">관리자</td>
				<td align="center">${cnoticevo.cwritedate}</td>
				<td align="center">${cnoticevo.chit}</td>      	
	      	</tr>		
	      </c:forEach>
	    </tbody>
	  </table>
	  
	<!-- 페이지바 -->  
	<div align="center" style="width: 70%; border: solid 0px gray; margin: 20px auto;">
   		${requestScope.pageBar}
    </div>
	  
	<!-- 글 검색 -->
	<form name="searchFrm" style="margin-top: 20px;">
      <select name="searchType" id="searchType" style="height: 26px;">
         <option value="ctitle">글제목</option>
      </select>
      <input type="text" name="searchWord" id="searchWord" size="30" autocomplete="off" /> 
      <button type="button" class="btn-search" onclick="goSearch()">검색</button>
   	</form>
   
    <div id="displayList" style="border:solid 1px gray; width:250px; height: 100px; border-top: 0px; margin-left: 71px; overflow: auto; padding-top: 2px;"> 	
    </div>


  </div>	  	
  
</div>
