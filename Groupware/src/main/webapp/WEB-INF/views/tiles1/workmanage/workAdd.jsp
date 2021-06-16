<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>	
<% String ctxPath = request.getContextPath(); %>

<link rel="stylesheet" href="//code.jquery.com/ui/1.12.1/themes/base/jquery-ui.css">
<link rel="stylesheet" href="/resources/demos/style.css">
<link rel="stylesheet" type="text/css" href="<%=ctxPath%>/resources/css/workmanage.css" />
<link rel="stylesheet" type="text/css" href="<%=ctxPath%>/resources/css/content.css" />     

<script src="https://code.jquery.com/jquery-1.12.4.js"></script>
<script src="https://code.jquery.com/ui/1.12.1/jquery-ui.js"></script>
<script type="text/javascript" src="<%=ctxPath%>/resources/smarteditor/js/HuskyEZCreator.js" charset="utf-8"></script>

<jsp:include page="./workmanage_sidebar.jsp" />
<jsp:include page="../approval/selectMemberModal.jsp" />  

<style type="text/css">
div#displayList {
	border: solid 1px gray;
	border-top: 100;
	width: 206px;
	height: 100px;
	padding: 2px;
	overflow: auto;
	position: absolute;
	z-index: 1000;
	background-color: white;
}
.receiverName, .referrerName {
	width: 80px;
}

.close {
  cursor: pointer;
  position: absolute;
  top: 50%;
  right: 0%;
  /* padding: 12px 16px; */
  transform: translate(0%, -50%);
}
.close:hover {background: #bbb;}

ul#receiversUl, ul#referrersUl {
  list-style-type: none;
  padding: 0;
  margin: 0;
  display: inline-block;
}

ul#receiversUl li.receiverName,
ul#referrersUl li.referrerName {
  border: 1px solid #ddd;
  margin-top: -1px; /* Prevent double borders */
  margin-right: 5px;
  background-color: #f6f6f6;
  /* padding: 12px; */
  text-decoration: none;
  /* font-size: 18px; */
  color: black;
  display: inline-block;
  position: relative;
}

ul#receiversUl li.receiverName:hover
ul#referrersUl li.referrerName:hover {
  background-color: #eee;
}
</style>

<script type="text/javascript">
	var obj = [];	// 스마트에디터 전역변수
	
	$(document).ready(function(){
		
		$("input[name=fk_wtno]").each(function(index, item){
			if (index == "${fk_wtno}") {
				$(item).attr("checked",true);
			}
		});
		
		$("#datepicker_deadline").datepicker({
			showOn : "button",
			buttonImage : "<%=ctxPath%>/resources/images/icon_calendar.png",
			buttonImageOnly : true,
			buttonText : "Select date",
			dateFormat: 'yy-mm-dd'
		});

		var checkRadio = $("input[name=fk_wtno]:checked");
		onlyWorkInput(checkRadio);
		
		<%-- === 검색어 입력시 자동글 완성하기  === --%>
		$("div#displayList").hide();
		
		$("input#searchWord").keyup(function(event){
			var wordlen = $(this).val().trim().length;
			
			if (wordlen == 0) {
				$("div#displayList").hide();
			}
			else {
				$.ajax({
					url:"<%=ctxPath%>/memberSearchShow.opis",
					type:"get",
					data:{"searchWord":$("input#searchWord").val()},
					dataType:"json",
					success:function(json){
						if (json.length > 0) {
							
							var html = "";
							
							$.each(json, function(index, item) {
								var word = item.word;
								// word ==> "글쓰기 첫번째  java 연습입니다"
								// word ==> "글쓰기 두번째 JaVa 연습입니다"
								
								var index = word.toLowerCase().indexOf($("input#searchWord").val().toLowerCase());
								// word ==> "글쓰기 첫번째 java 연습입니다"
								// word ==> "글쓰기 두번째 java 연습입니다"
								// 만약에 검색어가 "jAVa" 이라면 index 는 8 이 된다.
								
								var len = $("input#searchWord").val().length;
								// 검색어의 길이 len = 4
								
								word = word.substr(0,index) + "<span style='color:blue;'>"+ word.substr(index,len) +"</span>" + word.substr(index+len);
								
								html += "<span style='cursor:pointer;' class='word'>"+ word +"</span><span hidden>"+item.seq+"</span><br>";
							});
							$("div#displayList").html(html);
							$("div#displayList").show();
						}	
					},
					error: function(request, status, error){
	                	alert("code: "+request.status+"\n"+"message: "+request.responseText+"\n"+"error: "+error);
	                }
				});
			}
			
		});
		
		<%-- === 검색어 입력시 자동글 완성하기 === --%>
		$(document).on("click", "span.word", function(){
			// 텍스트박스에 검색된 결과의 문자열을 입력해준다.
			var html = "";
			html += '<li type="text" class="receiverName">'+$(this).text();
			html += '<input type="hidden" class="receiverName" value="'+$(this).text()+'"/>';
			html += '<input type="hidden" class="receiverSeq" value="'+$(this).next().text()+'"/>';
			html += '<span class="close" onclick="nameDel(this);">&times;</span></li>';
			$("ul#receiversUl").append(html);
			
			$("input#searchWord").val("").focus();
			$("div#displayList").hide();
		});
		
		
		// 파일첨부 숨기기
		$("input[name=attach]").hide();
		
		// 첨부파일 목록 보여주기
		$("input[type=file]").change(function(){
			var files = document.getElementById("attach").files;
	        var file;
	        
	        $("div#attachedFile").html("");
	        
	        for (var i=0; i<files.length; i++) { 
	            file = files[i];
	            $("div#attachedFile").append('<span>'+file.name+'&nbsp;&nbsp;</span><br>');
	        }
		});
		   
	    // == 스마트에디터 구현 프레임생성 == //
		nhn.husky.EZCreator.createInIFrame({
	          oAppRef: obj,
	          elPlaceHolder: "contents",
	          sSkinURI: "<%=ctxPath%>/resources/smarteditor/SmartEditor2Skin.html",
	          htParams : {
	              // 툴바 사용 여부 (true:사용/ false:사용하지 않음)
	              bUseToolbar : true,            
	              // 입력창 크기 조절바 사용 여부 (true:사용/ false:사용하지 않음)
	              bUseVerticalResizer : true,    
	              // 모드 탭(Editor | HTML | TEXT) 사용 여부 (true:사용/ false:사용하지 않음)
	              bUseModeChanger : true,
	          }
		});
	    
		
	});
	
	function nameDel(item) {
		$(item).parent().remove();
	} 
	
	
	// == 업무 요청, 업무 보고 일 경우에만 담당자, 참조자  input 보여주기 == //
	function onlyWorkInput(item) {
		var checkVal = $(item).val();
		
		if (checkVal == 0) {
			$("tr.onlyWorkInput").hide();
		} 
		else {
			$("tr.onlyWorkInput").show();
		}
	}
	
	// == 필수 입력 사항 작성했는지 확인 하기 == //
	function checkStar() {
		// 제목 확인
		var subject = $("input[name=subject]").val().trim();
		if (subject == "") {
			alert("제목을 입력하세요");
			return;
		}
		
		// 업무기한
		var deadline = $("input[name=deadline]").val().trim();
		if (deadline == "") {
			alert("업무기한을 입력하세요");
			return;
		}
		
		// 담당자
		var fk_wtno = $("input[name=fk_wtno]:checked").val();
		if (fk_wtno != 0) {
			var rcvlen = $("input.receiverName").length;
			
			if (rcvlen == 0) {
				alert("담당자를 한명 이상 지정해주세요");
				return;
			}
		}
		
		// == 스마트 에디터 검사하기 == //
		//id가 content인 textarea에 에디터에서 대입
		obj.getById["contents"].exec("UPDATE_CONTENTS_FIELD", []);

		// 글내용 유효성 검사
		var contentval = $("#contents").val();		
		if (contentval == "" || contentval == "<p>&nbsp;</p>") {
			alert("글내용을 입력하세요!!");
			return;
		}

		// 스마트에디터 사용시 무의미하게 생기는 p태그 제거하기
		contentval = $("#contents").val().replace(/<p><br><\/p>/gi, "<br>"); 	//<p><br></p> -> <br>로 변환
		contentval = contentval.replace(/<\/p><p>/gi, "<br>"); 					//</p><p> -> <br>로 변환  
		contentval = contentval.replace(/(<\/p><br>|<p><br>)/gi, "<br><br>"); 	//</p><br>, <p><br> -> <br><br>로 변환 
		contentval = contentval.replace(/(<p>|<\/p>)/gi, ""); 					//<p> 또는 </p> 모두 제거시

		$("#contents").val(contentval);
		
		$("input[name=fk_statno]").val("1");
		
		if (fk_wtno == 2) {
			$("input[name=fk_statno]").val("3");
		}
		
		if (fk_wtno == 0) submitTodoRegFrm(); 
		else submitWorkRegFrm();
	}
	
	// == ToDo 정보 폼 전송하기 == //
	function submitTodoRegFrm() {
		var frm = document.workRegFrm;
		
		frm.action = "<%=ctxPath%>/workAddTodoEnd.opis";
		frm.method = "post";
		frm.submit();
	}
	
	// == 업무 정보 폼 전송하기 == //
	function submitWorkRegFrm() {
		// reciever의 name, seq 문자열로 보내기
		var receiverNames = [];
		var receiverSeqs = [];
		
		$("input.receiverName").each(function(index, item){
			receiverNames.push($(item).val());
		});
		$("input.receiverSeq").each(function(index, item){
			receiverSeqs.push($(item).val());
		});
		
		$("input[name=receivers]").val(receiverNames.join());
		$("input[name=receiverSeqs]").val(receiverSeqs.join());
		
		// referrer의 name, seq 문자열 보내기
		var referrerNames = [];
		var referrerSeqs = [];
		
		$("input.referrerName").each(function(index, item){
			referrerNames.push($(item).val());
		});
		$("input.referrerSeq").each(function(index, item){
			referrerSeqs.push($(item).val());
		});
		
		$("input[name=referrers]").val(referrerNames.join());
		$("input[name=referrerSeqs]").val(referrerSeqs.join());
		
		var frm = document.workRegFrm;
		frm.action = "<%=ctxPath%>/workAddEnd.opis";
		frm.method = "post";
		frm.submit();
	}
	
	// 파일업로드 버튼클릭시
	function func_attach() {
		 $("input[name=attach]").click();	
	}
	
	// 주소록으로 이동
	function goAddress(targetUl) {
		var url = "<%=ctxPath%>/showAddresslist_work.opis?targetUl="+targetUl;
		window.open(url,"showAddress","left=350px, top=100px, width=600px, height=500px");
	}
	
	
</script>

<div class="container commoncontainer">
	<h3>업무 등록</h3>
	
	<br>
	
	<form name="workRegFrm" enctype="multipart/form-data">
		<table class="table table-striped workRegtable">
			<tbody>
				<tr>
					<td style="width: 10%;"><span class="star">*</span>제목</td>
					<td style="width: 70%;"><input name="subject"/></td>
				</tr>
				<tr>
					<td><span class="star">*</span>업무형태</td>
					<td>
						<input type="radio" id="mytodo" value="0" name="fk_wtno" onclick="onlyWorkInput(this);"/> 
						<label for="mytodo">나의 할일</label> 
							
						<input type="radio" id="workRequest" value="1" name="fk_wtno" onclick="onlyWorkInput(this);"/> 
						<label for="workRequest">업무 요청</label>
	
						<input type="radio" id="workReport" value="2" name="fk_wtno" onclick="onlyWorkInput(this);"/>
						<label for="workReport">업무 보고</label>
					</td>
				</tr>
				<tr>
					<td><span class="star">*</span>업무기한</td>
					<td><input type="text" name="deadline" id="datepicker_deadline" /></td>
				</tr>
				
				<tr class="onlyWorkInput">
					<td><span class="star">*</span>담당자</td>
					<td>
						<!-- <input type="text" id="searchWord" name="searchWord" placeholder="사용자"  autocomplete="off" /> -->
						<button type="button" onclick="goAddress('receiversUl')">사원찾기</button>
						<ul id="receiversUl"></ul>
					</td>
				</tr>
				
				<tr class="onlyWorkInput">
					<td>참조자</td>
					<td>
						<button type="button" onclick="goAddress('referrersUl')">사원찾기</button>
						<ul id="referrersUl"></ul>
					</td>
				</tr>
			
				<tr>
					<td>파일 업로드</td>
					<td>
						<!-- <input multiple="multiple" type="file" name="attach" /> -->
						<input type="file" name="attach" id="attach" name="attach" multiple />
						<button type="button" class="btn btn-success formBtn" id="attachBtn" onclick="func_attach()" >파일업로드</button>			
						<div id="attachedFile"></div>
					</td>
				</tr>
				<tr>
					<td>내용</td>
					<td><textarea name="contents" id="contents" rows="10" cols="100" style="width: 95%;"></textarea></td>
				</tr>
				<tr id="workRegBtn">
					<td colspan="2">
						<button type="button" onclick="checkStar()" class="btn btn-success">저장</button>
						<button type="button" onclick="javascript:location.href='<%=ctxPath%>/workList.opis'" class="btn btn-default">취소</button>
					</td>
				</tr>
			</tbody>
		</table>	
		<input type="hidden" name="requester" value="${sessionScope.loginuser.mbr_name}"/><input type="hidden" name="requesterSeq" value="${sessionScope.loginuser.mbr_seq}"/>
		<input type="hidden" name="receivers" id="receivers"/><input type="hidden" name="receiverSeqs" id="receiverSeqs"/>
		<input type="hidden" name="referrers" id="referrers"/><input type="hidden" name="referrerSeqs" id="referrerSeqs"/>
		<input type="hidden" name="fk_mbr_seq" value="${sessionScope.loginuser.mbr_seq}"/>
		<input type="hidden" name="fk_wrno" value="1"/>
		<!-- <input type="hidden" name="fk_wtno" /> -->
		<input type="hidden" name="fk_statno" />
	</form>
</div>

