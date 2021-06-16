<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<% String ctxPath = request.getContextPath(); %>


<script type="text/javascript">
	$(document).ready(function(){
		
		// 왼쪽 체크박스 처리하기 
		
		$("input#allLeftCheckbox").click(function(){	// 왼쪽에서 모두 선택/해제 체크박스을 클릭한 경우
			if($("input#allLeftCheckbox").is(":checked")){
				$("input.rightCheckbox").prop("checked",true);
			} else {
				$("input.rightCheckbox").prop("checked",false);
			}			
		});
		
		$("input#salesCheckbox").click(function(){	// 왼쪽에서 영업팀을 클릭한 경우
			if($("input#salesCheckbox").is(":checked")){
				$("input.salesMemberCheckbox").prop("checked",true);
			} else {
				$("input.salesMemberCheckbox").prop("checked",false);
			}			
		});
		
		$("input#HRCheckbox").click(function(){		// 왼쪽에서 인사팀을 클릭한 경우
			if($("input#HRCheckbox").is(":checked")){
				$("input.HRMemberCheckbox").prop("checked",true);
			} else {
				$("input.HRMemberCheckbox").prop("checked",false);
			}			
		});
		
		$("input#PRCheckbox").click(function(){		// 왼쪽에서 홍보팀을 클릭한 경우
			if($("input#PRCheckbox").is(":checked")){
				$("input.PRMemberCheckbox").prop("checked",true);
			} else {
				$("input.PRMemberCheckbox").prop("checked",false);
			}			
		});
		
		$("input#ITCheckbox").click(function(){		// 왼쪽에서 IT팀을 클릭한 경우
			if($("input#ITCheckbox").is(":checked")){
				$("input.ITMemberCheckbox").prop("checked",true);
			} else {
				$("input.ITMemberCheckbox").prop("checked",false);
			}			
		});
		
		$("input#accountCheckbox").click(function(){	// 왼쪽에서 회계팀을 클릭한 경우
			if($("input#accountCheckbox").is(":checked")){
				$("input.accountMemberCheckbox").prop("checked",true);
			} else {
				$("input.accountMemberCheckbox").prop("checked",false);
			}			
		});
		
		
		var isChecked = true;
		
		$("input.rightCheckbox").click(function(){	// 모두 선택된 경우 모두 선택/해제 체크박스 체크설정하기
			if($("input.rightCheckbox:checked").length == $("input.rightCheckbox").length){ 
				$("input#allLeftCheckbox").prop("checked",true);
			} else {
				$("input#allLeftCheckbox").prop("checked",false);
			}	
		});
		
		$("input.salesMemberCheckbox").click(function(){	// 영업팀원이 모두 선택된 경우 영업팀 체크박스 체크설정하기
			if($("input.salesMemberCheckbox:checked").length == $("input.salesMemberCheckbox").length){ 
				$("input#salesCheckbox").prop("checked",true);
			} else {
				$("input#salesCheckbox").prop("checked",false);
			}	
		});
		
		$("input.HRMemberCheckbox").click(function(){	// 인사팀원이 모두 선택된 경우 인사팀 체크박스 체크설정하기
			if($("input.HRMemberCheckbox:checked").length == $("input.HRMemberCheckbox").length){ 
				$("input#HRCheckbox").prop("checked",true);
			} else {
				$("input#HRCheckbox").prop("checked",false);
			}	
		});
		
		$("input.PRMemberCheckbox").click(function(){	// 홍보팀원이 모두 선택된 경우 홍보팀 체크박스 체크설정하기
			if($("input.PRMemberCheckbox:checked").length == $("input.PRMemberCheckbox").length){ 
				$("input#PRCheckbox").prop("checked",true);
			} else {
				$("input#PRCheckbox").prop("checked",false);
			}	
		});
		
		$("input.ITMemberCheckbox").click(function(){	// IT팀원이 모두 선택된 경우 IT팀 체크박스 체크설정하기
			if($("input.ITMemberCheckbox:checked").length == $("input.ITMemberCheckbox").length){ 
				$("input#ITCheckbox").prop("checked",true);
			} else {
				$("input#ITCheckbox").prop("checked",false);
			}	
		});
		
		$("input.accountMemberCheckbox").click(function(){	// 회계팀원이 모두 선택된 경우 회계팀 체크박스 체크설정하기
			if($("input.accountMemberCheckbox:checked").length == $("input.accountMemberCheckbox").length){ 
				$("input#accountCheckbox").prop("checked",true);
			} else {
				$("input#accountCheckbox").prop("checked",false);
			}	
		});
			
		//////////////////////////////////////////////////////////////////////////////
		
		// 오른쪽 체크박스 처리하기
		
		$("input#allRightCheckbox").click(function(){	// 오른쪽에서 모두 선택/해제 체크박스를 클릭한 경우
			if($("input#allRightCheckbox").is(":checked")){
				$("input.checkedMember").prop("checked",true);
			} else {
				$("input.checkedMember").prop("checked",false);
			}			
		});
		
		
		// 수정해야할 부분
		$(document).on("cilck", "input.checkedMember", function(){	// 결재라인이 모두 선택된 경우 모두 선택/해제 체크박스 체크설정하기
			
			if($("input.checkedMember:checked").length == $("input.checkedMember").length){ 
				$("input#allRightCheckbox").prop("checked",true);
			} else {
				$("input#allRightCheckbox").prop("checked",false);
			}	
		});
		
	}); // end of $(document).ready(function(){})---------------------------------------
	
	
	var movedMember = [];	// 선택된 결재라인 멤버 값의 value
	
	function func_rightMove(){	// 오른쪽 방향 화살표 클릭시
			 
	     $('input.memberCheckbox').each(function() {
	         if($(this).is(':checked') && !movedMember.includes($(this).val()))	{
	        	 $("div#checkedMember").append(
	     				"<label class='checkedMember'><input type='checkbox' class='checkedMember' checked='on' value='"+$(this).val()+"'/>"+
	     	        	"&nbsp;&nbsp;"+$(this).val()+"</label><br>"
	     		 ); 
	        	 movedMember.push($(this).val());
	         }
	     });

		
	}// end of function func_rightMove() ----------------------------------
	
	
	function func_clear(){	// 삭제하기 버튼클릭시
		
		$('input.checkedMember').each(function() {
			if($(this).is(':checked')) {
				const idx = movedMember.indexOf($(this).val());
				if(idx>-1) movedMember.splice(idx,1);
	         } 
		});
		
		$("div#checkedMember").html("");
				
		for (var i=0; i<movedMember.length; i++) {
			$("div#checkedMember").append(
     				"<label class='checkedMember'><input type='checkbox' class='checkedMember' checked='on' value='"+movedMember[i]+"'/>"+
     	        	"&nbsp;&nbsp;"+movedMember[i]+"</label><br>"
     		 ); 
		}
		
	}// end of function func_clear() ----------------------------------
	
	
	function func_choose(){	// 선택하기 버튼클릭시
		
		var chooseMemberName=[];		// 선택된 사원 결재페이지에 보이기 위한 변수
		
		for (var i=0; i<movedMember.length; i++) {
			var member = movedMember[i];
			chooseMemberName.push(member.substr(4));
		}
		
		var html = "";
		for (var i=0; i<chooseMemberName.length; i++) {
			html += "<td class='sign'>"+chooseMemberName[i]+"</td>";		
		}
		
		$('tr#sign').html(html);
		
		var newWidth = chooseMemberName.length*90;	
		$('div#signTitle').css({'width':newWidth})
		$('table#sign').css({'width':newWidth})
		
		// form 으로 넘길 input 값 저장
		$("input[name=ap_approver]").val(movedMember.toString());
		$("input[name=ap_manage_approver]").val(movedMember[0]);
		
		$('#myModal').hide();
		
	}// end of function func_choose() ----------------------------------
	
</script>


 <div id="myModal" class="modal">

   <div class="modal-content">
       <div style="text-align: left;">
	       <span style="font-size: 12pt; font-weight: bold;">결재라인 선택하기</span>
	       <span><button type="button" class="btn formBtn2" id="closeModal">X</button></span>
	       <hr>
       </div>
       
       <div id="modal" style="line-height: 1.5;">
       
		   <div class="memberModal" id="memberModal1">
		   		<label><input type="checkbox" id="allLeftCheckbox"/>&nbsp;&nbsp;모두 선택/해제하기</label>
		   		<hr style="margin: 0 0 15px 0;"> 	
		   		
		   		<div style="border: solid 1px #f2f2f2; padding: 2%; overflow: scroll; height: 380px;" >	   
			   		<c:forEach var="memberVO" items="${memberList}" varStatus="status">
			   			<c:if test="${memberVO.dept_detail eq 'CEO'}">
				        	<label><input type="checkbox" class="rightCheckbox memberCheckbox" value="${memberVO.dept_detail} ${memberVO.rank_detail} ${memberVO.mbr_name}" />
				        		&nbsp;&nbsp;${memberVO.dept_detail}&nbsp;${memberVO.mbr_name}
				        	</label><br>
			   			</c:if>
			   		</c:forEach>
			   		<hr class="division"> 
			   		
			   		<label><input type="checkbox" class="rightCheckbox" id="salesCheckbox"/>&nbsp;&nbsp;영업팀</label><br>		   		
			   		<c:forEach var="memberVO" items="${memberList}" varStatus="status">
			   			<c:if test="${memberVO.dept_detail eq '영업팀'}">
				        	<label><input type="checkbox" class="rightCheckbox salesMemberCheckbox memberCheckbox" value="${memberVO.dept_detail} ${memberVO.rank_detail} ${memberVO.mbr_name}"/>
				        		&nbsp;&nbsp;└─&nbsp;${memberVO.rank_detail}&nbsp;${memberVO.mbr_name}
				        	</label><br>
			   			</c:if>
			   		</c:forEach>	
			   		<hr class="division">
			   		
			   		<label><input type="checkbox" class="rightCheckbox" id="HRCheckbox"/>&nbsp;&nbsp;인사팀</label><br>		   		
			   		<c:forEach var="memberVO" items="${memberList}" varStatus="status">
			   			<c:if test="${memberVO.dept_detail eq '인사팀'}">
				        	<label><input type="checkbox" class="rightCheckbox HRMemberCheckbox memberCheckbox" value="${memberVO.dept_detail} ${memberVO.rank_detail} ${memberVO.mbr_name}"/>
				        		&nbsp;&nbsp;└─&nbsp;${memberVO.rank_detail}&nbsp;${memberVO.mbr_name}
				        	</label><br>
			   			</c:if>
			   		</c:forEach>
			   		<hr class="division">
			   		
			   		<label><input type="checkbox" class="rightCheckbox" id="PRCheckbox"/>&nbsp;&nbsp;홍보팀</label><br>		   		
			   		<c:forEach var="memberVO" items="${memberList}" varStatus="status">
			   			<c:if test="${memberVO.dept_detail eq '홍보팀'}">
				        	<label><input type="checkbox" class="rightCheckbox PRMemberCheckbox memberCheckbox" value="${memberVO.dept_detail} ${memberVO.rank_detail} ${memberVO.mbr_name}"/>
				        		&nbsp;&nbsp;└─&nbsp;${memberVO.rank_detail}&nbsp;${memberVO.mbr_name}
				        	</label><br>
			   			</c:if>
			   		</c:forEach>
			   		<hr class="division">
			   		
			   		<label><input type="checkbox" class="rightCheckbox" id="ITCheckbox"/>&nbsp;&nbsp;IT팀</label><br>		   		
			   		<c:forEach var="memberVO" items="${memberList}" varStatus="status">
			   			<c:if test="${memberVO.dept_detail eq 'IT팀'}">
				        	<label><input type="checkbox" class="rightCheckbox ITMemberCheckbox memberCheckbox" value="${memberVO.dept_detail} ${memberVO.rank_detail} ${memberVO.mbr_name}"/>
				        		&nbsp;&nbsp;└─&nbsp;${memberVO.rank_detail}&nbsp;${memberVO.mbr_name}
				        	</label><br>
			   			</c:if>
			   		</c:forEach>
			   		<hr class="division">
			   		
			   		<label><input type="checkbox" class="rightCheckbox" id="accountCheckbox"/>&nbsp;&nbsp;회계팀</label><br>		   		
			   		<c:forEach var="memberVO" items="${memberList}" varStatus="status">
			   			<c:if test="${memberVO.dept_detail eq '회계팀'}">
				        	<label><input type="checkbox" class="rightCheckbox accountMemberCheckbox memberCheckbox" value="${memberVO.dept_detail} ${memberVO.rank_detail} ${memberVO.mbr_name}"/>
				        		&nbsp;&nbsp;└─&nbsp;${memberVO.rank_detail}&nbsp;${memberVO.mbr_name}
				        	</label><br>
			   			</c:if>
			   		</c:forEach>
				</div>
		   </div>
		   
		   <%-- 사원선택해서 이동하기 --%>
		   <div id="memberMove" 
		        style="width: 10%;  height: 90%; display: inline-block; text-align: center; align-items: center;">
		   		<i class="fas fa-arrow-right fa-2x" id="rightMove" onclick="func_rightMove()"></i>
		   		<div style="height: 180px;"></div><br>
		   </div>
		   
		   <div class="memberModal" id="memberModal2">
		   		<label><input type="checkbox" id="allRightCheckbox" />&nbsp;&nbsp;결재라인 모두 선택/해제하기</label>
		   		<hr style="margin: 0 0 15px 0;"> 	
		   		
		   		<%-- 사원선택해서 결재라인 순서 조정하기 --%>
		   		<div id="memberOrder">
			        <button type="button" class="operate" ><i class="fas fa-chevron-up fa-1x"  id="upMove" onclick=""></i></button>
			   		<button type="button" class="operate" ><i class="fas fa-chevron-down fa-1x" id="downMove" onclick=""></i></button>
		  		</div>
		   		
		   		<div style="border: solid 1px #f2f2f2; padding: 2%; overflow: scroll; height: 320px;" id="checkedMember">
		   		</div>
		   		
		   		<hr style="margin: 0 0 15px 0;"> 
		   		<button type="button" class="operate" id="clear" onclick="func_clear()" >삭제하기</button>
		   		<button type="button" class="operate" id="choose" style="background-color: #5cb85c; color: white;" onclick="func_choose()">선택하기</button>

		   </div>
	   </div>

   </div>

 </div>