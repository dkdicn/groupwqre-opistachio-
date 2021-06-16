<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ page session="false" %>
<% String ctxPath = request.getContextPath();   %>
<html>
<meta name="viewport" content="width=device-width, initial-scale=1">
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/4.7.0/css/font-awesome.min.css">


<script src='https://kit.fontawesome.com/a076d05399.js' crossorigin='anonymous'></script>

<script type="text/javascript">
	$(function(){
		
		$("a#snsmain").click(function(){
			window.open("<%=ctxPath%>/sns/snsmain.opis","Ã«Â©ÂÃ¬ÂÂ Ã¬Â Â","width=401, height=601, toolbar=no, menubar=no, scrollbars=no, resizable=yes");
		});
		
	});// end of $(function(){ -------------------------------------
		
	
</script>

<body>

<div class="icon-bar">
  <a class="active" href="<%=ctxPath%>/index.opis"><i class="fab fa-pinterest-square"></i></a> 
  <a id="logout" href="<%=ctxPath%>/logout.opis"><i class="fas fa-user-slash"></i></a> 
  <a href="<%=ctxPath%>/mainPage.opis"><i class="fa fa-home"></i></a> 
  <a id="snsmain" href="#"><i class="fas fa-comments"></i></a> 
  <a href="<%=ctxPath%>/personalInfo.opis"><i class="fas fa-user-circle"></i></a> 
</div>

</body>
</html> 