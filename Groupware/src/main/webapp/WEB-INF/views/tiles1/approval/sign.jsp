<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<% String ctxPath = request.getContextPath(); %>

<jsp:include page="./approval_sidebar.jsp" />  

<script type="text/javascript">
	$(document).ready(function(){
	
		
	}); // end of $(document).ready(function(){})---------------------------------------
	
</script>
</head>
<body>
	
	<div id="approvalContainer">
		<span class="subtitle">서명관리</span>
		<hr>
		<div id="signForm">
			<span id="signHelp">결재에 사용할 서명 이미지(총 1개)를 업로드해주세요.</span>  
			 	
			<div id="signImg">현재 등록된 서명 이미지
				<hr>
				<c:if test="${sessionScope.loginuser.mbr_sign}==null">
					<i class="fas fa-file-signature fa-5x icon" id="basicImg"></i>
				</c:if>
				<c:if test="${sessionScope.loginuser.mbr_sign}!=null">
					<img src="<%= ctxPath%>/resources/images/sign/${sessionScope.loginuser.mbr_sign}"/>
				</c:if>
				<button type="button" class="btn btn-success signBtn">서명 변경하기</button>
				<hr>
			</div>
		</div>
	</div>
	  	
</body>
</html>
