<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>

<script type="text/javascript">
	alert("${requestScope.message}");
	location.href="${requestScope.loc}"; // ������ �̵�
	
	self.close();
	opener.locaion.reload(true); // �θ�â ���ΰ�ħ
</script>