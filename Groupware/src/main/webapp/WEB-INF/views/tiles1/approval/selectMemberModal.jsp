<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<% String ctxPath = request.getContextPath(); %>


<script type="text/javascript">
	$(document).ready(function(){
		
		// 왼쪽 체크박스 처리하기 
		
		$("input#allLeftCheckbox2").click(function(){	// 왼쪽에서 모두 선택/해제 체크박스을 클릭한 경우
			if($("input#allLeftCheckbox2").is(":checked")){
				$("input.rightCheckbox2").prop("checked",true);
			} else {
				$("input.rightCheckbox2").prop("checked",false);
			}			
		});
		
		$("input#salesCheckbox2").click(function(){	// 왼쪽에서 영업팀을 클릭한 경우
			if($("input#salesCheckbox2").is(":checked")){
				$("input.salesmemberCheckbox22").prop("checked",true);
			} else {
				$("input.salesmemberCheckbox22").prop("checked",false);
			}			
		});
		
		$("input#HRCheckbox2").click(function(){		// 왼쪽에서 인사팀을 클릭한 경우
			if($("input#HRCheckbox2").is(":checked")){
				$("input.HRmemberCheckbox22").prop("checked",true);
			} else {
				$("input.HRmemberCheckbox22").prop("checked",false);
			}			
		});
		
		$("input#PRCheckbox2").click(function(){		// 왼쪽에서 홍보팀을 클릭한 경우
			if($("input#PRCheckbox2").is(":checked")){
				$("input.PRmemberCheckbox22").prop("checked",true);
			} else {
				$("input.PRmemberCheckbox22").prop("checked",false);
			}			
		});
		
		$("input#ITCheckbox2").click(function(){		// 왼쪽에서 IT팀을 클릭한 경우
			if($("input#ITCheckbox2").is(":checked")){
				$("input.ITmemberCheckbox22").prop("checked",true);
			} else {
				$("input.ITmemberCheckbox22").prop("checked",false);
			}			
		});
		
		$("input#accountCheckbox2").click(function(){	// 왼쪽에서 회계팀을 클릭한 경우
			if($("input#accountCheckbox2").is(":checked")){
				$("input.accountmemberCheckbox22").prop("checked",true);
			} else {
				$("input.accountmemberCheckbox22").prop("checked",false);
			}			
		});
		
		
		var isChecked = true;
		
		$("input.rightCheckbox2").click(function(){	// 모두 선택된 경우 모두 선택/해제 체크박스 체크설정하기
			if($("input.rightCheckbox2:checked").length == $("input.rightCheckbox2").length){ 
				$("input#allLeftCheckbox2").prop("checked",true);
			} else {
				$("input#allLeftCheckbox2").prop("checked",false);
			}	
		});
		
		$("input.salesmemberCheckbox22").click(function(){	// 영업팀원이 모두 선택된 경우 영업팀 체크박스 체크설정하기
			if($("input.salesmemberCheckbox22:checked").length == $("input.salesmemberCheckbox22").length){ 
				$("input#salesCheckbox2").prop("checked",true);
			} else {
				$("input#salesCheckbox2").prop("checked",false);
			}	
		});
		
		$("input.HRmemberCheckbox22").click(function(){	// 인사팀원이 모두 선택된 경우 인사팀 체크박스 체크설정하기
			if($("input.HRmemberCheckbox22:checked").length == $("input.HRmemberCheckbox22").length){ 
				$("input#HRCheckbox2").prop("checked",true);
			} else {
				$("input#HRCheckbox2").prop("checked",false);
			}	
		});
		
		$("input.PRmemberCheckbox22").click(function(){	// 홍보팀원이 모두 선택된 경우 홍보팀 체크박스 체크설정하기
			if($("input.PRmemberCheckbox22:checked").length == $("input.PRmemberCheckbox22").length){ 
				$("input#PRCheckbox2").prop("checked",true);
			} else {
				$("input#PRCheckbox2").prop("checked",false);
			}	
		});
		
		$("input.ITmemberCheckbox22").click(function(){	// IT팀원이 모두 선택된 경우 IT팀 체크박스 체크설정하기
			if($("input.ITmemberCheckbox22:checked").length == $("input.ITmemberCheckbox22").length){ 
				$("input#ITCheckbox2").prop("checked",true);
			} else {
				$("input#ITCheckbox2").prop("checked",false);
			}	
		});
		
		$("input.accountmemberCheckbox22").click(function(){	// 회계팀원이 모두 선택된 경우 회계팀 체크박스 체크설정하기
			if($("input.accountmemberCheckbox22:checked").length == $("input.accountmemberCheckbox22").length){ 
				$("input#accountCheckbox2").prop("checked",true);
			} else {
				$("input#accountCheckbox2").prop("checked",false);
			}	
		});
			
		//////////////////////////////////////////////////////////////////////////////
		
		// 오른쪽 체크박스 처리하기
		
		$("input#allrightCheckbox2").click(function(){	// 오른쪽에서 모두 선택/해제 체크박스를 클릭한 경우
			if($("input#allrightCheckbox2").is(":checked")){
				$("input.checkedMember2").prop("checked",true);
			} else {
				$("input.checkedMember2").prop("checked",false);
			}			
		});
		
		
		// 수정해야할 부분
		$(document).on("cilck", "input.checkedMember2", function(){	// 참조자이 모두 선택된 경우 모두 선택/해제 체크박스 체크설정하기
			console.log("하하");
			if($("input.checkedMember2:checked").length == $("input.checkedMember2").length){ 
				$("input#allrightCheckbox2").prop("checked",true);
			} else {
				$("input#allrightCheckbox2").prop("checked",false);
			}	
		});
		
	}); // end of $(document).ready(function(){})---------------------------------------
	
	
	var movedMember2 = [];	// 선택된 참조자 멤버 값의 value
	
	function func_rightMove2(){	// 오른쪽 방향 화살표 클릭시
			 
	     $('input.memberCheckbox2').each(function() {
	         if($(this).is(':checked') && !movedMember2.includes($(this).val()))	{
	        	 $("div#checkedMember2").append(
	     				"<label class='checkedMember2'><input type='checkbox' class='checkedMember2' checked='on' value='"+$(this).val()+"'/>"+
	     	        	"&nbsp;&nbsp;"+$(this).val()+"</label><br>"
	     		 ); 
	        	 movedMember2.push($(this).val());
	         }
	     });

		
	}// end of function func_rightMove2() ----------------------------------
	
	
	function func_clear2(){	// 삭제하기 버튼클릭시
		
		$('input.checkedMember2').each(function() {
			if($(this).is(':checked')) {
				const idx = movedMember2.indexOf($(this).val());
				if(idx>-1) movedMember2.splice(idx,1);
	         } 
		});
		
		$("div#checkedMember2").html("");
				
		for (var i=0; i<movedMember2.length; i++) {
			$("div#checkedMember2").append(
     				"<label class='checkedMember2'><input type='checkbox' class='checkedMember2' checked='on' value='"+movedMember2[i]+"'/>"+
     	        	"&nbsp;&nbsp;"+movedMember2[i]+"</label><br>"
     		 ); 
		}
		
	}// end of function func_clear2() ----------------------------------
	
	
	function func_choose2(){	// 선택하기 버튼클릭시
		
		var chooseMemberName2=[];		// 선택된 사원 결재페이지에 보이기 위한 변수
		
		for (var i=0; i<movedMember2.length; i++) {
			var member = movedMember2[i];
			chooseMemberName2.push(member.substr(7));
		}
		$('span#selectedMember').html(movedMember2.toString());
		$('span#selectedMember').append("&nbsp;");
		
		// form 으로 넘길 input 값 저장
		$("input[name=ap_referrer]").val(movedMember2.toString());

		$('#myModal2').hide();
		
	}// end of function func_choose2() ----------------------------------

	
</script>


 <div id="myModal2" class="modal">

   <div class="modal-content">
       <div style="text-align: left;">
	       <span style="font-size: 12pt; font-weight: bold;">참조자 선택하기</span>
	       <span><button type="button" class="btn formBtn2" id="closeModal">X</button></span>
	       <hr>
       </div>
       
       <div id="modal" style="line-height: 1.5;">
       
		   <div class="memberModal" id="memberModal1" >
		   		<label><input type="checkbox" id="allLeftCheckbox2"/>&nbsp;&nbsp;모두 선택/해제하기</label>
		   		<hr style="margin: 0 0 15px 0;"> 	
		   		
		   		<div style="border: solid 1px #f2f2f2; padding: 2%; overflow: scroll; height: 380px;" >	   
			   		<c:forEach var="memberVO" items="${memberList}" varStatus="status">
			   			<c:if test="${memberVO.dept_detail eq 'CEO'}">
				        	<label><input type="checkbox" class="rightCheckbox2 memberCheckbox2" value="${memberVO.dept_detail} ${memberVO.rank_detail} ${memberVO.mbr_name}" />
				        		&nbsp;&nbsp;${memberVO.dept_detail}&nbsp;${memberVO.mbr_name}
				        	</label><br>
			   			</c:if>
			   		</c:forEach>
			   		<hr class="division"> 
			   		
			   		<label><input type="checkbox" class="rightCheckbox2" id="salesCheckbox2"/>&nbsp;&nbsp;영업팀</label><br>		   		
			   		<c:forEach var="memberVO" items="${memberList}" varStatus="status">
			   			<c:if test="${memberVO.dept_detail eq '영업팀'}">
				        	<label><input type="checkbox" class="rightCheckbox2 salesmemberCheckbox22 memberCheckbox2" value="${memberVO.dept_detail} ${memberVO.rank_detail} ${memberVO.mbr_name}"/>
				        		&nbsp;&nbsp;└─&nbsp;${memberVO.rank_detail}&nbsp;${memberVO.mbr_name}
				        	</label><br>
			   			</c:if>
			   		</c:forEach>	
			   		<hr class="division">
			   		
			   		<label><input type="checkbox" class="rightCheckbox2" id="HRCheckbox2"/>&nbsp;&nbsp;인사팀</label><br>		   		
			   		<c:forEach var="memberVO" items="${memberList}" varStatus="status">
			   			<c:if test="${memberVO.dept_detail eq '인사팀'}">
				        	<label><input type="checkbox" class="rightCheckbox2 HRmemberCheckbox22 memberCheckbox2" value="${memberVO.dept_detail} ${memberVO.rank_detail} ${memberVO.mbr_name}"/>
				        		&nbsp;&nbsp;└─&nbsp;${memberVO.rank_detail}&nbsp;${memberVO.mbr_name}
				        	</label><br>
			   			</c:if>
			   		</c:forEach>
			   		<hr class="division">
			   		
			   		<label><input type="checkbox" class="rightCheckbox2" id="PRCheckbox2"/>&nbsp;&nbsp;홍보팀</label><br>		   		
			   		<c:forEach var="memberVO" items="${memberList}" varStatus="status">
			   			<c:if test="${memberVO.dept_detail eq '홍보팀'}">
				        	<label><input type="checkbox" class="rightCheckbox2 PRmemberCheckbox22 memberCheckbox2" value="${memberVO.dept_detail} ${memberVO.rank_detail} ${memberVO.mbr_name}"/>
				        		&nbsp;&nbsp;└─&nbsp;${memberVO.rank_detail}&nbsp;${memberVO.mbr_name}
				        	</label><br>
			   			</c:if>
			   		</c:forEach>
			   		<hr class="division">
			   		
			   		<label><input type="checkbox" class="rightCheckbox2" id="ITCheckbox2"/>&nbsp;&nbsp;IT팀</label><br>		   		
			   		<c:forEach var="memberVO" items="${memberList}" varStatus="status">
			   			<c:if test="${memberVO.dept_detail eq 'IT팀'}">
				        	<label><input type="checkbox" class="rightCheckbox2 ITmemberCheckbox22 memberCheckbox2" value="${memberVO.dept_detail} ${memberVO.rank_detail} ${memberVO.mbr_name}"/>
				        		&nbsp;&nbsp;└─&nbsp;${memberVO.rank_detail}&nbsp;${memberVO.mbr_name}
				        	</label><br>
			   			</c:if>
			   		</c:forEach>
			   		<hr class="division">
			   		
			   		<label><input type="checkbox" class="rightCheckbox2" id="accountCheckbox2"/>&nbsp;&nbsp;회계팀</label><br>		   		
			   		<c:forEach var="memberVO" items="${memberList}" varStatus="status">
			   			<c:if test="${memberVO.dept_detail eq '회계팀'}">
				        	<label><input type="checkbox" class="rightCheckbox2 accountmemberCheckbox22 memberCheckbox2" value="${memberVO.dept_detail}&nbsp;${memberVO.rank_detail}&nbsp;${memberVO.mbr_name}"/>
				        		&nbsp;&nbsp;└─&nbsp;${memberVO.rank_detail}&nbsp;${memberVO.mbr_name}
				        	</label><br>
			   			</c:if>
			   		</c:forEach>
				</div>
		   </div>
		   
		   <%-- 사원선택해서 이동하기 --%>
		   <div id="memberMove" 
		        style="width: 10%;  height: 90%; display: inline-block; text-align: center; align-items: center;">
		   		<i class="fas fa-arrow-right fa-2x" id="rightMove" onclick="func_rightMove2()"></i><br>
		   		<div style="height: 180px;"></div><br>
		   </div>
		   
		   <div class="memberModal" id="memberModal2" >
		   		<label><input type="checkbox" id="allrightCheckbox2" />&nbsp;&nbsp;참조자 모두 선택/해제하기</label>
		   		<hr style="margin: 0 0 15px 0;"> 	
		   		
		   		<%-- 사원선택해서 참조자 순서 조정하기 --%>
		   		<div id="memberOrder">
			        <button type="button" class="operate" ><i class="fas fa-chevron-up fa-1x"  id="upMove" onclick=""></i></button>
			   		<button type="button" class="operate" ><i class="fas fa-chevron-down fa-1x" id="downMove" onclick=""></i></button>
		  		</div>
		   		
		   		<div style="border: solid 1px #f2f2f2; padding: 2%; overflow: scroll; height: 320px;" id="checkedMember2">
		   		</div>
		   		
		   		<hr style="margin: 0 0 15px 0;"> 
		   		<button type="button" class="operate" id="clear" onclick="func_clear2()" >삭제하기</button>
		   		<button type="button" class="operate" id="choose" style="background-color: #5cb85c; color: white;" onclick="func_choose2()">선택하기</button>

		   </div>
	   </div>

   </div>

 </div>