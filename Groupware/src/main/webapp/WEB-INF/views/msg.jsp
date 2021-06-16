<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>

<script type="text/javascript">
	alert("${requestScope.message}");
	location.href="${requestScope.loc}"; // 페이지 이동
	
	self.close();
	opener.locaion.reload(true); // 부모창 새로고침
</script>