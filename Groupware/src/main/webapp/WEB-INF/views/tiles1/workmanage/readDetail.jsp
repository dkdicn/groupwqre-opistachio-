<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>	

<%-- 업무요청 처리내역 --%>
<c:if test="${fk_wtno == 1}">
	<table class="table table-striped workShowtable">
		<thead>
			<tr style="background: #f2f2f2;">
				<th colspan="4">담당자 처리내역&nbsp;
					<select id="mbrListSelect" onchange="mbrWorkStatusChange();">
					<c:forEach var="workmbr" items="${requestScope.workmbrList}" varStatus="status">
						<option value="${workmbr.fk_mbr_seq}">${workmbr.mbr_name}</option>
					</c:forEach>	
					</select>
				</th>
			</tr>		
		</thead>
		<tbody>
			<tr>
				<td>담당자</td>
				<td id="mbr_name"></td>
				
				<td>최종수정일</td>
				<td id="lasteditdate"></td>
			</tr>
			<tr>
				<td>진척률</td>
				<td colspan="3"><span id="workPercent"></span>%</td>
			</tr>
			<tr>
				<td>내용</td>
				<td colspan="3"><textarea cols="70" rows="5" class="contents" readonly="readonly"></textarea></td>
			</tr>
		</tbody>
	</table>
</c:if>
	
<%-- 업무보고 처리내역 --%>
<c:if test="${fk_wtno == 2}">
	<table class="table table-striped workShowtable">
		<thead>
			<tr style="background: #f2f2f2;">
				<th colspan="4">담당자 확인내역&nbsp;
					<select id="mbrListSelect" onchange="mbrWorkStatusChange();">
					<c:forEach var="workmbr" items="${requestScope.workmbrList}" varStatus="status">
						<option value="${workmbr.fk_mbr_seq}">${workmbr.mbr_name}</option>
					</c:forEach>	
					</select>
				</th>
			</tr>		
		</thead>
		<tbody>
			<tr>
				<td>수신자</td>
				<td id="mbr_name"></td>
				
				<td>최종수정일</td>
				<td id="lasteditdate"></td>
			</tr>
			<tr>
				<td>의견</td>
				<td colspan="3"><textarea cols="70" rows="5" class="contents" readonly="readonly"></textarea></td>
			</tr>
		</tbody>
	</table>
</c:if>