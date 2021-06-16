<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<% String ctxPath = request.getContextPath(); %>


  <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.1/css/bootstrap.min.css">
  <link rel="stylesheet" type="text/css" href="<%=ctxPath %>/resources/css/boardButtons.css">
  
  <script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.1/js/bootstrap.min.js"></script>
  <script src="https://kit.fontawesome.com/16816a49c3.js" crossorigin="anonymous"></script> 
  <jsp:include page="./addr_sidebar.jsp" />
  
	<script type="text/javascript">

	$(document).ready(function(){
		console.log("addr_setting");
	}); // end of $(document).ready(function(){})---------------------------------------

	function goAdd(){
		
		var form_data =  $("form[name=addAddrGRFrm]").serialize();
		
		$.ajax({
			type:"POST",
			url:"<%=ctxPath%>/addAddrgroup.opis",
			data:form_data,
			dataType:"json",
			success: function(json){
				var n = json.n;  
				
				if(n==0){
					alert("주소록 그룹 추가를 실패했습니다.");
				}
				else{
					location.reload();
				}
			},
			error: function(request, status, error){
                alert("code: "+request.status+"\n"+"message: "+request.responseText+"\n"+"error: "+error);
            }		
		});	
		
	}// end of function goAdd()----------------------------------------	
	
	
	function goDelete(addrgroup_seq){
		if(confirm("정말로 삭제하시겠습니까? 삭제한 주소록은 복구 불가능합니다.")==true){
        	location.href="<%=ctxPath%>/addrgroup_delEnd.opis?addrgroup_seq="+addrgroup_seq;
    	}
	}// end of function goDelete(addrgroup_seq)------------------------
	
</script>

<div style="width: 1460px"> 
	
	<!-- 게시판 제목 -->
	<div style="padding: 15px; font-size: 25px; font-weight: 600; height: 60px; width: 100%; background-color: #f2f2f2; color: #555;">
	&nbsp;&nbsp;개인 주소록 관리
	</div>
	
	<div class="container" style="float: right; width: 80%; margin-top: 50px; font-size: 14px;">        

  		<!-- 등록 -->
		<form name="addAddrGRFrm" style="margin: 0 0 40px 0;">
		  <span>추가&nbsp;&nbsp;</span>	
		  <input type="hidden" name="fk_mbr_seq" id="fk_mbr_seq" value="${sessionScope.loginuser.mbr_seq}" />
	      <input type="text" name="groupname" id="groupname" size="20" placeholder="그룹명" /> 
	      <input type="text" name="groupdetail" id="groupdetail" size="40" placeholder="그룹 설명" /> 
	      <button type="button" id="addAddrGr" class="btn-ok" onclick="goAdd()">추가</button>
	   	</form>
	   
		<!-- 본문(게시판) -->
		<table class="table table-striped">
		    <thead>
		      <tr style="text-align: center;">
		        <th style="width: 7%;">그룹명</th>
		        <th style="width: 20%;">그룹설명</th>
		        <th style="width: 5%;">삭제</th>
		      </tr>
		    </thead>
		    <tbody>
		    	<c:forEach var="addrgroupvo" items="${requestScope.addrgroupList}" varStatus="status">
		    
			    	<c:if test="${not empty addrgroupvo.addrgroup_seq}">
			      	<tr>
						<td style="text-align: center;">
							<span class="name">${addrgroupvo.groupname}</span>&nbsp;&nbsp;
							<span style="font-size: 7px; color: #3d5c5c;" onclick="javascript:location.href='<%=ctxPath%>/myAddrlist.opis?addrgroup_seq='+${addrgroupvo.addrgroup_seq}"><i class="fas fa-search fa-2x"></i></span>

						</td>
						<td>
							<span class="detail" style="text-align: left;">${addrgroupvo.groupdetail}</span>
						</td>  
						<td style="text-align: center;">
							<button type="button" class="btn-basic" onclick="goDelete('${addrgroupvo.addrgroup_seq}')">삭제</button>
						</td>	
			      	</tr>		
			      	</c:if>
				</c:forEach>
		    </tbody>
		</table>
		
		<!-- 페이지바 -->  
		<div id="pageBar" align="center" style="width: 70%; border: solid 0px gray; margin: 20px auto; color: gray;">
	   		${requestScope.pageBar}
	    </div>

  	</div>	  	
	
	
</div>
