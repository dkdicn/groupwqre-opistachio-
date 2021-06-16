<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<% String ctxPath = request.getContextPath(); %>

<meta name="viewport" content="width=device-width, initial-scale=1">
<link rel="stylesheet" href="/resources/demos/style.css">	

<jsp:include page="./insa_sidebar.jsp" />

<style type="text/css">
	
	
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
	table#insaListaTbl td{
		text-align: center;
	}
	table#insaListaTbl th{
		text-align: center;
	}
</style>

<script type="text/javascript">
	/* When the user clicks on the button,
	toggle between hiding and showing the dropdown content */
	
	function myFunction() {
	  document.getElementById("myDropdown").classList.toggle("show");
	}
	
	
	// Close the dropdown menu if the user clicks outside of it
	window.onclick = function(event) {
	  if (!event.target.matches('.dropbtn')) {
	    var dropdowns = document.getElementsByClassName("dropdown-content");
	    var i;
	    for (i = 0; i < dropdowns.length; i++) {
	      var openDropdown = dropdowns[i];
	      if (openDropdown.classList.contains('show')) {
	        openDropdown.classList.remove('show');
	      }
	    }
	  }
	}
	

	window.onclick = function(event) {
		  if (!event.target.matches('.dropbtn') && !event.target.matches('.dropdown-content')) {
			    var dropdowns = document.getElementsByClassName("dropdown-content");
			    var i;
			    for (i = 0; i < dropdowns.length; i++) {
			      var openDropdown = dropdowns[i];
			        openDropdown.classList.remove('show');
			    }
			  var html = '<div onclick="myFunction()" class="dropbtn" id="dropbtn" style="width: 50px; height: 35px;">'+event.target.text+'</div>';
			  document.getElementById("dropbtn").innerHTML = html;
			  //document.getElementsByClassName("a#dropbtnA").innerHTML = html;
			  //console.log(document.getElementsByClassName("dropbtn").innerHTML());
			  
		  }
		} 
	

	function goSearch(){

		var searchType = $(".searchType option:selected").val();
		var searchWord= $("input.searchWord").val();
		var category = $("input#hiddenCategory").val();

		location.href='<%=ctxPath%>/insa.opis?category='+category+'&searchType='+searchType+'&searchWord='+searchWord; 
	}	
	
	function goInsaDetail(seq){

		var searchType = $("input#hiddenSearchType").val();
		var searchWord= $("input#hiddenSearchWord").val();
		var category = $("input#hiddenCategory").val();
		location.href='<%=ctxPath%>/insaView1.opis?category='+category+'&seq='+seq+'&searchType='+searchType+'&searchWord='+searchWord; 
	}
</script>

<div id="insa" style="width: 80%; display: inline-block; margin-top: 70px; padding-left: 30px;">
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
			<table id="insaListaTbl" class="table table-striped tdtable">
					<thead>
					<tr>
						<th style="width: 15%; ">사원번호</th>
						<th style="width: 13%; ">사원명</th>
						<th style="width: 13%; ;">부서</th>
						<th style="width: 13%; ">직책</th>
						<th style="width: 20%; ">입사일자</th>
						<th style="width: 13%; ">학력</th>
						<th style="width: 13%; ">재직상태</th>
					</tr>
					</thead>
					<tbody>
					<c:forEach var="insaList" items="${requestScope.insaList}">
					<tr onclick="goInsaDetail(${insaList.mbr_seq})" class="memberInfo">
						<td>${insaList.mbr_seq}</td>
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
						<td>${insaList.mbr_registerday}</td>	
									
						<c:if test="${insaList.eduLevel == 0}">
							<td>초졸</td>
						</c:if>	
						<c:if test="${insaList.eduLevel == 1}">
							<td>중졸</td>
						</c:if>	
						<c:if test="${insaList.eduLevel == 2}">
							<td>고졸</td>
						</c:if>	
						<c:if test="${insaList.eduLevel == 3}">
							<td>초대졸</td>
						</c:if>	
						<c:if test="${insaList.eduLevel == 4}">
							<td>학사</td>
						</c:if>	
						<c:if test="${insaList.eduLevel == 5}">
							<td>석사</td>
						</c:if>
						<c:if test="${insaList.eduLevel == 6}">
							<td>박사</td>
						</c:if>
						<c:if test="${insaList.mbr_status == 1}">
							<td style="color: blue;">재직</td>
						</c:if>
						<c:if test="${insaList.mbr_status == 0}">
							<td style="color: red;">퇴사</td>
						</c:if>
					</tr>
					</c:forEach>
				</tbody>
			</table>
			
				
	    <br><br>
	    <div align="center" style="width: 70%; border: solid 0px gray; margin: 20px auto;">
	    	${requestScope.pageBar}
	    </div>
			
			<input id="hiddenSeq" type="hidden" value="${seq}"/>
			<input id="hiddenCategory" type="hidden" value="${category}" />
			<input id="hiddenSearchType" type="hidden" value="${searchType}" />
			<input id="hiddenSearchWord" type="hidden" value="${searchWord}" />
</div>



