<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<% String ctxPath = request.getContextPath(); %>
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/4.7.0/css/font-awesome.min.css">

<link rel="stylesheet" type="text/css" href="<%=ctxPath %>/resources/css/menu.css" />	
<link rel="stylesheet" href="/resources/demos/style.css">	
<jsp:include page="./insa_sidebar.jsp" />
<style>
	
	  .modifyBtn{
	  padding: 10px 20px;
	  font-size: 15px;
	  text-align: center;
	  cursor: pointer;
	  outline: none;
	  color: #fff;
	  background-color: #04AA6D;
	  border: none;
	  border-radius: 15px;
	  box-shadow: 0 5px #999;
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
	  box-shadow: 0 5px #999;
	  margin-left: 3px;
	}
	.modifyBtn:hover{ background-color: #3e8e41 !important;}
	.modifyBtn:active{
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

	});
</script>


<div id="insa" style="width: 80%; display: inline-block; margin-top: 70px; padding-left: 30px;">
		<table style="margin-bottom: 50px;">
		<tr id="insaDetailButton">
			<td><button class="modifyBtn" style="background-color: #e6e6e6;" onclick="javascript:location.href='<%=ctxPath%>/insaView1.opis?seq=${seq}&category=${category}&searchType=${searchType}&searchWord=${searchWord}'" >인적사항</button></td>
			<td style="width: 10px;"></td>
			<td><button class="modifyBtn">서류정보</button></td>
			<td style="width: 580px;"></td>
			<td><button class="modifyBtn" style="background-color: gray; " onclick="javascript:location.href='<%=ctxPath%>/insa.opis?seq=${seq}&category=${category}&searchType=${searchType}&searchWord=${searchWord}'">회원목록으로</button></td>
		</tr>
		</table> 
		
	
			<div class="insaDetailDiv" style="width: 45%;">
			<table id="insaDetail1" class="table table-striped tdtable">
				<tr>
					<th>최종학력</th>
					<c:if test="${maxEduLevel == 7 }">
						<td colspan="2">미입력</td>
					</c:if>
					<c:if test="${maxEduLevel == 0 }">
						<td colspan="2">초졸</td>
					</c:if>
					<c:if test="${maxEduLevel == 1 }">
						<td colspan="2">중졸</td>
					</c:if>
					<c:if test="${maxEduLevel == 2 }">
						<td colspan="2">고졸</td>
					</c:if>
					<c:if test="${maxEduLevel == 3 }">
						<td colspan="2">초대졸</td>
					</c:if>
					<c:if test="${maxEduLevel == 4 }">
						<td colspan="2">학사</td>
					</c:if>
					<c:if test="${maxEduLevel == 5 }">
						<td colspan="2">석사</td>
					</c:if>
					<c:if test="${maxEduLevel == 6 }">
						<td colspan="2">박사</td>
					</c:if>
				</tr>
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
							<td>${edu.major}&nbsp;&nbsp;
								<button id="modifyBtn1"  type="button" onclick="javascript:location.href='<%=ctxPath%>/insaEduModi.opis?edu_seq=${edu.edu_seq}&seq=${seq}&category=${category}&searchType=${searchType}&searchWord=${searchWord}'">수정</button>
								<button id="modifyBtn1"  type="button" onclick="javascript:location.href='<%=ctxPath%>/insaEduDel.opis?edu_seq=${edu.edu_seq}&seq=${seq}&category=${category}&searchType=${searchType}&searchWord=${searchWord}'">삭제</button></td>
						</tr>
					</c:forEach>
				</c:if>
				<c:if test="${empty eduList}">
				
				</c:if>
			</table>
					<br>
					<br>
					<button id="modifyBtn1"  type="submit" onclick="javascript:location.href='<%=ctxPath%>/insaRegister2.opis?insaType=1&seq=${seq}&category=${category}&searchType=${searchType}&searchWord=${searchWord}'">+추가</button>
			</div>	
				
			<div class="insaDetailDiv" style="width: 50%; margin-left: 35px;">
			<table id="insaDetail2" class="table table-striped tdtable">
				<thead>
					<tr>
						<th colspan="3">자격증</th>
					</tr>
					<tr>
						<th>자격증명</th>
						<th>점수/급수</th>
						<th>취득일자</th>
					</tr>
				</thead>
				<tbody>
					<c:if test="${empty certiList}">
					
					</c:if>
					<c:if test="${not empty certiList}">					
						<c:forEach var="certi" items="${certiList}">
						<tr>
							<td>${certi.certification}</td>
							<td>${certi.certiLevel}</td>
							<td>${certi.certiDate}<input type="hidden" value="${certi.certi_seq}" />&nbsp;&nbsp;
							<button id="modifyBtn2"  type="button" onclick="javascript:location.href='<%=ctxPath%>/insaCertiModi.opis?certi_seq=${certi.certi_seq}&seq=${seq}&category=${category}&searchType=${searchType}&searchWord=${searchWord}'">수정</button>
							<button id="modifyBtn2"  type="button" onclick="javascript:location.href='<%=ctxPath%>/insaCertiDel.opis?certi_seq=${certi.certi_seq}&seq=${seq}&category=${category}&searchType=${searchType}&searchWord=${searchWord}'">삭제</button>
							</td>
						</tr>
						</c:forEach>
					</c:if>

				</tbody>
			</table>
					<br>
					<br>
					<button id="modifyBtn2"  type="submit" onclick="javascript:location.href='<%=ctxPath%>/insaRegister2.opis?insaType=2&seq=${seq}&category=${category}&searchType=${searchType}&searchWord=${searchWord}'">+추가</button>
			</div>
</div>



