<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<% String ctxPath = request.getContextPath(); %>

<link rel="stylesheet" type="text/css" href="<%=ctxPath %>/resources/css/menu.css" />
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css">

<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
<script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.16.0/umd/popper.min.js"></script>
<script src="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/js/bootstrap.min.js"></script>
<script src="https://t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js"></script>

<script type="text/javascript">

   $(document).ready(function(){
      
		$('#myModal').on('show.bs.modal', function(e) {
			
			var button = $(e.relatedTarget);
			var modal = $(this);
			
			modal.find('.modal-content').load(button.data("remote"));
	
		});
		
   }); // end of $(document).ready(function(){})------------------
   
</script>

<div id="sideMenu">
	<div id="menuTitle">주소록</div>
	
	<div class="container">
		<!-- 주소록 등록 버튼 -->
		<div id="btnDiv">
		<button type="button" data-remote="<%=ctxPath%>/addAddrModal.opis" id="btnReg" class="btn btn-primary" data-toggle="modal" data-target="#myModal" style="color:black;" value="주소록 등록">
		  주소록 등록
		</button>
		</div>
		<!-- ========== 주소록 등록 모달창 ========== -->
		<div class="modal fade" id="myModal">
		  <div class="modal-dialog modal-lg">
		    <div class="modal-content">
			<!-- content from addAddrModal.jsp -->
		    </div>
		  </div>
		</div>
	</div>

	<div class="lside">
		<button class="sideBtn" onclick="javascript:location.href='<%=ctxPath%>/totaladdrlist.opis'">전체 주소록</button>
	</div>
	<div class="lside">
		<button class="sideBtn" onclick="javascript:location.href='<%=ctxPath%>/addr_setting.opis'">개인 주소록</button>
	</div>
</div>
