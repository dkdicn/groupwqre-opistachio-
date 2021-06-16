<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<% String ctxPath = request.getContextPath(); %>


<title>주소록 정보 수정</title>

<link rel="stylesheet" type="text/css" href="<%=ctxPath %>/resources/css/boardButtons.css">
<style type="text/css">

#editForm{
	width: 80%;
	margin: 50px 0 50px 350px;
	font-size: 15px;
}

#tblAddr th, td{
	padding: 5px;
}

#btns{
	margin-left: 800px;
	font-size: 12px;
}

#btnEdit{
	margin-right: 20px;
}

</style>

<jsp:include page="./addr_sidebar.jsp" />
<script src="https://t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js"></script>

<script type="text/javascript">

   $(document).ready(function(){
      
      $("span.error").hide();
      
      // ========== 이름 검사 ========== // 
      $("input#name").blur(function(){
         
         var name = $(this).val().trim();
         if(name == "") {
            // 입력하지 않거나 공백만 입력했을 경우
            $("table#tblAddr :input").prop("disabled",true);
            $(this).prop("disabled",false);
            $(this).parent().find(".error").show();
            $(this).focus();
         }
         else {
            // 공백이 아닌 글자를 입력했을 경우
            $("table#tblAddr :input").prop("disabled",false);
            $(this).parent().find(".error").hide();
         }
         
      }); // end of $("input#name").blur(function(){}--------------------------
      
   	  // ========== 이메일 검사 ========== // 
      $("input#mbr_email").blur(function(){
           $("span#emailCheckResult").html("");
            var regExp = new RegExp(/^[0-9a-zA-Z]([-_\.]?[0-9a-zA-Z])*@[0-9a-zA-Z]([-_\.]?[0-9a-zA-Z])*\.[a-zA-Z]{2,3}$/i);
         
            var bool = regExp.test($(this).val());
            
            if(!bool) {
               // 이메일이 정규표현식에 위배된 경우
               $("table#tblAddr :input").prop("disabled",true);
               $(this).prop("disabled",false);
            
               $(this).parent().find(".error").show();
               $(this).focus();
            }
            else {
               // 이메일이 정규표현식에 맞는 경우
               $("table#tblAddr :input").prop("disabled",false);
               $(this).parent().find(".error").hide();
            }
            
         }); // end of $("input#email").blur(function(){}------------------------
      
      
      // ========== 핸드폰번호 검사 ========== //  		 
      $("input#hp2").blur(function(){
         
            var regExp = /^[1-9][0-9]{3}$/i; 
            // 첫번째 숫자는 0을 제외하고 나머지 3개는 0을 포함한 숫자만 오도록 검사해주는 정규표현식 객체 생성  
         
            var bool = regExp.test($(this).val());
            
            if(!bool) {
               // 국번이 정규표현식에 위배된 경우
               $("table#tblAdder :input").prop("disabled",true);
               $(this).prop("disabled",false);
            
               $(this).parent().find(".error").show();
               $(this).focus();
            }
            else {
               // 국번이 정규표현식에 맞는 경우
               $("table#tblAdder :input").prop("disabled",false);
               $(this).parent().find(".error").hide();
            }
            
         }); // end of $("input#hp2").blur(function(){}-------------------------------------- 
         
         
         $("input#hp3").blur(function(){
            
            var regExp = /^\d{4}$/i; 
            // 숫자 4개만 오도록 검사해주는 정규표현식 객체 생성  
         
            var bool = regExp.test($(this).val());
            
            if(!bool) {
               // 마지막 전화번호 4자리가 정규표현식에 위배된 경우
               $("table#tblAddr :input").prop("disabled",true);
               $(this).prop("disabled",false);
            
               $(this).parent().find(".error").show();
               $(this).focus();
            }
            else {
               // 마지막 전화번호 4자리가 정규표현식에 맞는 경우
               $("table#tblAddr :input").prop("disabled",false);
               $(this).parent().find(".error").hide();
            }
            
         }); // end of $("input#hp3").blur(function(){}-------------------------------------- 
      
         
          // ========== 우편번호 검사 ========== //		 
	      $("button#zipcodeSearch").click(function(){
	         new daum.Postcode({
	               oncomplete: function(data) {
	                   // 팝업에서 검색결과 항목을 클릭했을때 실행할 코드를 작성하는 부분.
	                   var addr = ''; // 주소 변수
	                   var extraAddr = ''; // 참고항목 변수
	                   //사용자가 선택한 주소 타입에 따라 해당 주소 값을 가져온다.
	                   if (data.userSelectedType === 'R') { // 사용자가 도로명 주소를 선택했을 경우
	                       addr = data.roadAddress;
	                   } else { // 사용자가 지번 주소를 선택했을 경우(J)
	                       addr = data.jibunAddress;
	                   }
	                   // 사용자가 선택한 주소가 도로명 타입일때 참고항목을 조합한다.
	                   if(data.userSelectedType === 'R'){
	                       // 법정동명이 있을 경우 추가한다. (법정리는 제외)
	                       // 법정동의 경우 마지막 문자가 "동/로/가"로 끝난다.
	                       if(data.bname !== '' && /[동|로|가]$/g.test(data.bname)){
	                           extraAddr += data.bname;
	                       }
	                       // 건물명이 있고, 공동주택일 경우 추가한다.
	                       if(data.buildingName !== '' && data.apartment === 'Y'){
	                           extraAddr += (extraAddr !== '' ? ', ' + data.buildingName : data.buildingName);
	                       }
	                       // 표시할 참고항목이 있을 경우, 괄호까지 추가한 최종 문자열을 만든다.
	                       if(extraAddr !== ''){
	                           extraAddr = ' (' + extraAddr + ')';
	                       }
	                       // 조합된 참고항목을 해당 필드에 넣는다.
	                       document.getElementById("extraAddress").value = extraAddr;
	                   
	                   } else {
	                       document.getElementById("extraAddress").value = '';
	                   }
	                   // 우편번호와 주소 정보를 해당 필드에 넣는다.
	                   document.getElementById('postcode').value = data.zonecode;
	                   document.getElementById("address").value = addr;
	                   // 커서를 상세주소 필드로 이동한다.
	                   document.getElementById("detailaddress").focus();
	               }
	           }).open();
	           
	        }); // end of $("button#zipcodeSearch").click(function(){}--------------------------------
	
	        $("button#btnEdit").click(function(){
	        	var frm = document.editFrm;
	     	   	frm.action="<%=ctxPath%>/addr_editEnd.opis";
	     	   	frm.method = "POST";
	     	   	frm.submit();
	        });
	        
   }); // end of $(document).ready(function(){})------------------
  
   
</script>


	<!-- 게시판 제목 -->
	<div style="padding: 15px; font-size: 25px; font-weight: 600; height: 60px; width: 100%; background-color: #f2f2f2; color: #555;">
	&nbsp;&nbsp;주소록 정보 수정
	</div>
	
	<!-- 수정폼 내용 -->
	<div style="width:1460px;">
    
    
    <form name="editFrm" id="editFrm" enctype="multipart/form-data" > 
	<div id="editForm" >	
     <table id="tblAddr">      
        <tr>
         	<th>이름</th>
            <td>
            	<input type="hidden" name="addr_seq" value="${requestScope.addrvo.addr_seq}" />
                <input type="text" name="mbr_name" value="${requestScope.addrvo.mbr_name}" class="short"/>
                <span class="error">이름은 필수입력 사항입니다.</span>
            </td>
         </tr>		
         <tr>
         	<th>전화번호</th>
            <td>
             <input type="text" id="hp1" name="hp1" size="6" maxlength="3" value="010" readonly />&nbsp;&nbsp;
             <input type="text" id="hp2" name="hp2" size="6" maxlength="4" />&nbsp;&nbsp;
             <input type="text" id="hp3" name="hp3" size="6" maxlength="4" />
             <span class="error">휴대폰 형식이 아닙니다.</span>  
            </td>
         </tr>	
         <tr>
         	<th>이메일</th>
            <td>
                <input type="text" name="mbr_email" id="mbr_email" class="short requiredInfo" value="${requestScope.addrvo.mbr_email}" placeholder="abcd@opis.com" />
                <span id="emailCheckResult"></span> 
                <span class="error">이메일 형식에 맞지 않습니다.</span>
            </td>
         </tr>	         
         <tr>
         	<th>생일</th>
            <td>
                <input type="date" name="mbr_birthday" placeholder="yyyymmdd" class="short" value="${requestScope.addrvo.mbr_birthday}"/>       
            </td>
         </tr>	
         <tr>
         	<th>소속</th>
            <td>
                <input type="text" name="dept_name" placeholder="부서" class="short" value="${requestScope.addrvo.dept_name}"/> 
                <input type="text" name="position_name" placeholder="직책" class="short" value="${requestScope.addrvo.position_name}"/>      
            </td>
         </tr>
         <tr>
         	<td style="width: 20%; font-weight: bold;">우편번호</td>
	      	<td style="width: 80%; text-align: left;">
    	    <input type="text" id="postcode" name="postcode" size="6" maxlength="5" value="${requestScope.addrvo.postcode}"/>&nbsp;&nbsp;
        	<%-- 우편번호 찾기 --%>
         	<button type="button" id="zipcodeSearch" class="btn-basic" style="vertical-align: middle;"> 우편번호 검색 </button>
         <span class="error">우편번호 형식이 아닙니다.</span>
	      </tr>
	      <tr>
	      <td style="width: 20%; font-weight: bold;">주소</td>
	      <td style="width: 80%; text-align: left;">
	         <input type="text" id="address" name="address" size="40" placeholder="주소" value="${requestScope.addrvo.address}"/><br><br>
	         <input type="text" id="detailaddress" name="detailaddress" size="36" placeholder="상세주소" value="${requestScope.addrvo.detailaddress}"/>&nbsp;<input type="text" id="extraAddress" name="extraAddress" size="35" placeholder="참고항목" /> 
	         <span class="error">주소를 입력하세요</span>
	      </td>
	   	</tr>
	      <tr>
	      	<th>메모</th>
	         <td>
				<textarea rows="4" cols="100" style="width: 80%; height: 200px;" name="addrmemo" placeholder="메모를 입력해주세요">${requestScope.addrvo.addrmemo}</textarea>                   
			</td>
	      </tr>	 
	   </table>
   	</div>
      
      <div id="btns">
        <button type="button" class="btn-ok" id="btnEdit">등록</button>
        <button type="button" class="btn-basic" onclick="javascript:history.back()" class="btn btn-cancel">취소</button>
      </div>
  
  </form>

</div>
