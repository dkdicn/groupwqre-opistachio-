<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<% String ctxPath = request.getContextPath(); %>
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/4.7.0/css/font-awesome.min.css">

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
	.modifyBtn:hover{ background-color: #3e8e41 !important;}
	.modifyBtn:active{
	  background-color: #3e8e41 !important;
	  box-shadow: 0 5px #666;
	  transform: translateY(4px);
	}

	table#insaDetail1{
		width: 40%;
		display: inline-block;
		 vertical-align: top;
	}
	table#insaDetail2{
		margin-left: 20px;
		width: 45%;
		display: inline-block;
	    vertical-align: top;
	}
	table.table td{
		width: 300px;
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
			<td><button class="modifyBtn">인적사항</button></td>
			<td style="width: 10px;"></td>
			<td><button class="modifyBtn" style="background-color: #e6e6e6; " onclick="javascript:location.href='<%=ctxPath%>/insaView2.opis?seq=${insavo.mbr_seq}&category=${category}&searchType=${searchType}&searchWord=${searchWord}'">서류정보</button></td>
			<td style="width: 580px;"></td>
			<td><button class="modifyBtn" style="background-color: gray; " onclick="javascript:location.href='<%=ctxPath%>/insa.opis?seq=${insavo.mbr_seq}&category=${category}&searchType=${searchType}&searchWord=${searchWord}'">회원목록으로</button></td>
		</tr>
		</table> 

		<button id="modifyBtn" type="submit" style="display: inline-block; vertical-align: top;" onclick="javascript:location.href='<%=ctxPath%>/insaModify1.opis?seq=${seq}&category=${category}&searchType=${searchType}&searchWord=${searchWord}'">수정하기</button>
		<br><br>	
			
	
			<table id="insaDetail1" class="table table-striped tdtable">
				<tr>
					<td>사원번호</td>
					<td>${insavo.mbr_seq}</td>
				</tr>
				<tr>
					<td>사원명</td>
					<td>${insavo.mbr_name}</td>
				</tr>
				<tr>
					<td>아이디</td>
					<td>${insavo.mbr_id}</td>
				</tr>
				<tr>
					<td>비밀번호</td>
					<td>${insavo.mbr_pwd}</td>
				</tr>
				<tr>
					<td>부서</td>
					<c:if test="${insavo.fk_dept_no == 0}">
					<td>영업</td>
					</c:if>
					<c:if test="${insavo.fk_dept_no == 1}">
						<td>인사</td>
					</c:if>
					<c:if test="${insavo.fk_dept_no == 2}">
						<td>홍보</td>
					</c:if>
					<c:if test="${insavo.fk_dept_no == 3}">
						<td>IT</td>
					</c:if>
					<c:if test="${insavo.fk_dept_no == 4}">
						<td>회계</td>
					</c:if>
					<c:if test="${!(insavo.fk_dept_no == 4 || insavo.fk_dept_no == 3 || insavo.fk_dept_no == 2 || insavo.fk_dept_no == 1 || insavo.fk_dept_no == 0)}">
						<td>기타</td>
					</c:if>
				</tr>
				<tr>
					<td>직책</td>
					<c:if test="${insavo.fk_rank_no == 0}">
						<td>팀장</td>
					</c:if>						
					<c:if test="${insavo.fk_rank_no == 1}">
						<td>팀원</td>
					</c:if>						
					<c:if test="${insavo.fk_rank_no == 2}">
						<td style="color: red;">대표</td>
					</c:if>	
				</tr>
				<tr>
					<td>권한</td>
					<c:if test="${insavo.fk_power_no == 0}">
						<td>관리자</td>
					</c:if>
					<c:if test="${insavo.fk_power_no == 1}">
						<td>일반사원</td>
					</c:if>
				</tr>
				<tr>
					<td>입사일자</td>
					<td>${insavo.mbr_registerday}</td>
				</tr>
				<tr>
				<c:if test="${insavo.mbr_status == 0}">
				<tr>
					<td>퇴사일자</td>
					<td>${insavo.mbr_retireday}</td>
				</tr>
				</c:if>
			
				<tr>
					<td>학력</td>
					<c:if test="${insavo.eduLevel == 0}">
						<td>초졸</td>
					</c:if>	
					<c:if test="${insavo.eduLevel == 1}">
						<td>중졸</td>
					</c:if>	
					<c:if test="${insavo.eduLevel == 2}">
						<td>고졸</td>
					</c:if>	
					<c:if test="${insavo.eduLevel == 3}">
						<td>초대졸</td>
					</c:if>	
					<c:if test="${insavo.eduLevel == 4}">
						<td>학사</td>
					</c:if>	
					<c:if test="${insavo.eduLevel == 5}">
						<td>석사</td>
					</c:if>
					<c:if test="${insavo.eduLevel == 6}">
						<td>박사</td>
					</c:if>
				</tr>
			</table>
			<table id="insaDetail2" class="table table-striped tdtable">
				<tr>
					<td>회사연락처</td>
					<td>${insavo.mbr_com_number}</td>
				</tr>
				<tr>
					<td>개인연락처</td>
					<td>${insavo.mbr_phone_number}</td>
				</tr>
				<tr>
					<td>회사이메일</td>
					<td>${insavo.mbr_email}</td>
				</tr>
				<tr>
					<td>생년월일</td>
					<td>${insavo.mbr_birthday}</td>
				</tr>
				<tr>
					<td>성별</td>
					<c:if test="${insavo.mbr_gender == 0}">
						<td>여</td>
					</c:if>
					<c:if test="${insavo.mbr_gender == 1}">
						<td>남</td>
					</c:if>
				</tr>
			</table>
			
			<input id="hiddenSeq" type="hidden" value="${seq}"/>
			<input id="hiddenCategory" type="hidden" value="${category}" />
			<input id="hiddenSearchType" type="hidden" value="${searchType}" />
			<input id="hiddenSearchWord" type="hidden" value="${searchWord}" />

	
</div>



