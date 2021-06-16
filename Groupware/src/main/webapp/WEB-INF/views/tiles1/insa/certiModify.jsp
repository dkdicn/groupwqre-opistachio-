<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<% String ctxPath = request.getContextPath(); %>
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/4.7.0/css/font-awesome.min.css">

<jsp:include page="./insa_sidebar.jsp" />

<style>
		
	.registerBtn{
	  padding: 10px 20px;
	  font-size: 15px;
	  text-align: center;
	  cursor: pointer;
	  outline: none;
	  color: #fff;
	  background-color: #04AA6D;
	  border: none;
	  border-radius: 15px;
	  box-shadow: 0 9px #999;
	}
	.modifyBtnSmall{
	  padding: 5px 10px;
	  font-size: 10px;
	  text-align: center;
	  cursor: pointer;
	  outline: none;
	  color: #fff;
	  background-color: #04AA6D;
	  border: none;
	  border-radius: 10px;
	  box-shadow: 0 9px #999;
	  margin-left: 3px;
	  margin-bottom: 11px;
	  vertical-align: bottom;
	}
	.registerBtn:hover{ background-color: #3e8e41 !important;}
	.registerBtn:active{
	  background-color: #3e8e41 !important;
	  box-shadow: 0 5px #666;
	  transform: translateY(4px);
	}
	.modifyBtnSmall:hover{ background-color: #3e8e41 !important;}
	.modifyBtnSmall:active{
	  background-color: #3e8e41 !important;
	  box-shadow: 0 5px #666;
	  transform: translateY(4px);
	}
	table#insaDetail1{
	  display: inline;
	    vertical-align: bottom;
	
	}
	table#insaDetail1 tr{
	  height: 15px;
	    vertical-align: middle;
	}
	table#insaDetail1 td{
	  height: 15px;
	    vertical-align: middle;
	}
	table#insaDetail2{
	  display: inline;
	    vertical-align: bottom;
	}
	table#insaDetail2 tr{
	  height: 15px;
	    vertical-align: middle;
	}
	table#insaDetail2 td{
	  height: 15px;
	    vertical-align: middle;
	}
	div.insaDetailDiv{
		display: inline-block;
	    vertical-align: top;
	}
	
</style>

  <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
<script type="text/javascript">
	$(document).ready(function(){
			

		var searchType = $("input#hiddenSearchType").val();
		var searchWord= $("input#hiddenSearchWord").val();
		var seq = $("input#hiddenSeq").val();
		var category = $("input#hiddenCategory").val();
		
		var yearOptionHtml = "";
		for(var i=1950; i<2050; i++){
			if(i == ${certiyy}){
				yearOptionHtml+='<option selected="selected" class = "certiyy" value="'+i+'">'+i+'</option>';
			}
			else{
				yearOptionHtml+='<option class = "certiyy" value="'+i+'">'+i+'</option>';
			}
		}
		$("select.certiyy").html(yearOptionHtml);
		
	         var bflag = true;
			

				
				// 등록하기2
				$("button#modifyBtn2").click(function(){
					bflag = true;
					
					var certification = $("input#certification").val();
					if(certification==" "){
							bflag = false;
						}
					
					
					
					var certiLevel = $("input#certiLevel").val();
					
					if( certiLevel==" "){
							bflag = false;
						}

				 	var certiyy = $("#certiyy option:selected").val();
					var certimm = $("#certimm option:selected").val();
					var certidd = $("#certidd option:selected").val();
					if(certimm <10){
						certimm = "0"+certimm;
					}
					if(certidd <10){
						certidd = "0"+certidd;
					}
					var certi = certiyy+"-"+certimm+"-"+certidd;
					var htmlCerti =  '<input name = "certiDate" type="hidden" value="'+certi+'"/>';
					$("div#certiDiv").html(htmlCerti);		
		
					if(!bflag){
						alert("먼저 모든 항목을 입력하세요!!");
					}
					else{
						
						var frm = document.certiModifyFrm;
						frm.method = "POST";
						frm.action = "<%=ctxPath%>/certiModifyEnd.opis?certification="+certification+"&certiLevel="+certiLevel+"&certiyy="+certiyy+"&certimm="+certimm+"&certidd="+certidd+"&certi_seq="+${certi_seq}+"&seq="+seq+"&searchType="+searchType+"&searchWord="+searchWord+"&category="+category; 
						frm.submit(); 
					}
				});
			
			
			
			
			
	});
</script>



<div id="insa" style="width: 80%; display: inline-block; margin-top: 70px; padding-left: 30px;">

<table style="margin-bottom: 50px;">
		<tr id="insaDetailButton">
			<td><button class="registerBtn" style="background-color: #e6e6e6; " onclick="javascript:location.href='<%=ctxPath%>/insaView1.opis?seq=${seq}&category=${category}&searchType=${searchType}&searchWord=${searchWord}'">인적사항</button></td>
			<td style="width: 10px;"></td>
			<td><button class="registerBtn" >서류정보</button></td>
			<td style="width: 360px;"></td>
			<td><button class="registerBtn" style="background-color: gray; " onclick="javascript:location.href='<%=ctxPath%>/insa.opis?seq=${seq}&category=${category}&searchType=${searchType}&searchWord=${searchWord}'">회원목록으로</button></td>
		</tr>
		</table> 
			<div>
				<table id="memberBasicInfo">
					
				</table>
			</div>
		<div class="insaDetailDiv" style="width: 45%;">
				<table id="insaDetail1" class="table table-striped tdtable">
					<thead>
						<tr>
							<th>최종학력</th>
							<c:if test="${maxEduLevel == null }">
								<th colspan="2">미입력</th>
							</c:if>
							<c:if test="${maxEduLevel == 0 }">
								<th colspan="2">초졸</th>
							</c:if>
							<c:if test="${maxEduLevel == 1 }">
								<th colspan="2">중졸</th>
							</c:if>
							<c:if test="${maxEduLevel == 2 }">
								<th colspan="2">고졸</th>
							</c:if>
							<c:if test="${maxEduLevel == 3 }">
								<th colspan="2">초대졸</th>
							</c:if>
							<c:if test="${maxEduLevel == 4 }">
								<th colspan="2">학사</th>
							</c:if>
							<c:if test="${maxEduLevel == 5 }">
								<th colspan="2">석사</th>
							</c:if>
							<c:if test="${maxEduLevel == 6 }">
								<th colspan="2">박사</th>
							</c:if>
						</tr>
							</thead>
				<tbody id="insaDetail1tbody">
				<c:if test="${not empty eduList}">
					<c:forEach var="edu" items="${eduList}">
						<tr>
							<c:if test="${edu.eduLevel == 0 }">
								<td>초등학교</td>
							</c:if>
							<c:if test="${edu.eduLevel == 1 }">
								<td>중학교</td>
							</c:if>
							<c:if test="${edu.eduLevel == 2 }">
								<td>고등학교</td>
							</c:if>
							<c:if test="${edu.eduLevel == 3 }">
								<td>전문대학교</td>
							</c:if>
							<c:if test="${edu.eduLevel == 4 }">
								<td>대학교(학사)</td>
							</c:if>
							<c:if test="${edu.eduLevel == 5 }">
								<td>대학원(석사)</td>
							</c:if>
							<c:if test="${edu.eduLevel == 6 }">
								<td>대학원(박사)</td>
							</c:if>
							<td>${edu.school}<input type="hidden" value="${edu.edu_seq}" /></td>
							<td>${edu.major}</td>
						</tr>						
					</c:forEach>
				</c:if>
					</tbody>
		   		</table>
			</div>
			
			
			<div class="insaDetailDiv" style="width: 50%;">
			<form name="certiModifyFrm">
				<table id="insaDetail2" class="table table-striped tdtable">
					<thead>
						<tr>
							<th colspan="3" style="text-align: center;">자격증</th>
						</tr>
						<tr>
							<th>자격증명</th>
							<th>점수/급수</th>
							<th width="500px;">취득일자</th>
						</tr>
					</thead>
					<tbody id="insaDetail2tbody">
					<c:if test="${not empty certiList}">					
						<c:forEach var="certi" items="${certiList}">
						<c:if test="${certi.certi_seq != certi_seq}">
						<tr>
							<td>${certi.certification}</td>
							<td>${certi.certiLevel}</td>
							<td>${certi.certiDate}<input type="hidden" value="${certi.certi_seq}" />
							</td>
						</tr>
						</c:if>	
						<c:if test="${certi.certi_seq == certi_seq}">
						<tr>
							<td><input id="certification" class="certiInput" style="width: 80px;" value="${certi.certification}"/></td>
							<td><input id="certiLevel" class="certiInput" style="width: 70px;" value="${certi.certiLevel}"/></td>
							<td style="width: 270px;">
								<select class = "certiyy" id="certiyy" name="certiyy" style="width: 75px; padding: 4px;">
				           			
					            </select>년
								<select class = "certimm" id="certimm" name="certimm" style="margin-left: 2%; width: 55px; padding: 4px;">
					           		<c:forEach begin="1" end="12" varStatus="count" >
					           			<c:if test="${count.count == certimm}">
					           			<option class = "certimm" selected="selected" value="${count.count}">${count.count}</option>
					           			</c:if>
					           			<c:if test="${count.count != certimm}">
					           			<option class = "certimm" value="${count.count}">${count.count}</option>
					           			</c:if>
					           		</c:forEach>
					            </select>월
					            <select class = "certidd" id="certidd" name="certidd" style="margin-left: 2%; width: 55px; padding: 4px;">
						            	<c:forEach begin="1" end="31" varStatus="count" >
					           			<c:if test="${count.count == certidd}">
						           			<option class = "certidd" selected="selected" value="${count.count}">${count.count}</option>
						           		</c:if>
					           			<c:if test="${count.count != certidd}">
						           			<option class = "certidd" value="${count.count}">${count.count}</option>
						           		</c:if>
						           		</c:forEach>
				        		</select>일 
			        			 <div id="certiDiv"></div>	
				        		<button class="modifyBtnSmall" id="modifyBtn2"  type="button">수정완료</button>
							</td>
						</tr>
						</c:if>
						</c:forEach>
					</c:if>
					</tbody>
				</table>
				</form>
			</div>
			<input id="hiddenSeq" type="hidden" value="${seq}"/>
			<input id="hiddenCategory" type="hidden" value="${category}" />
			<input id="hiddenSearchType" type="hidden" value="${searchType}" />
			<input id="hiddenSearchWord" type="hidden" value="${searchWord}" />
		
</div>



