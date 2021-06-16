<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<% String ctxPath = request.getContextPath(); %>


<jsp:include page="./mbrchart_sidebar.jsp" />  

<script src="https://code.highcharts.com/highcharts.js"></script>
<script src="https://code.highcharts.com/modules/sankey.js"></script>
<script src="https://code.highcharts.com/modules/organization.js"></script>
<script src="https://code.highcharts.com/modules/exporting.js"></script>
<script src="https://code.highcharts.com/modules/accessibility.js"></script>

<link rel="stylesheet" type="text/css" href="<%=ctxPath %>/resources/css/mbrchart.css"/>

<script type="text/javascript">
	$(document).ready(function(){
		
		// 현재 URL 주소
		var checkURL = document.location.href;
		
		// 선택된 조직도 형태(기본값 전체 조직도)
		var chartStyle = "";	
		if(checkURL.indexOf("?")!="-1"){	// 특정 조직도를 선택한 경우
			chartStyle += document.location.href.substr(checkURL.length-1);
		}
		
		var node;	// 조직도 연결방식
		var memberInfoArr; // 조직도에 기록될 사원정보		
 		
 		$.ajax({
			url:"<%=ctxPath%>/member/getChartInfo.opis",
			dataType:"json",
			data: {chartStyle:chartStyle},
			success: function(json){	
				
				if(chartStyle=="") {	// 전체 조직도
					node = [], memberInfoArr = [];	// 초기화
					
					$("span.subtitle").html("전체 조직도"); 
					node = [['CEO 대표', '영업팀 팀장'],['CEO 대표', '인사팀 팀장'],['CEO 대표', '홍보팀 팀장'],['CEO 대표', 'IT팀 팀장'],['CEO 대표', '회계팀 팀장']
				          ,['영업팀 팀장', '영업팀 팀원'],['인사팀 팀장', '인사팀 팀원'], ['홍보팀 팀장', '홍보팀 팀원']
				          ,['IT팀 팀장', 'IT팀 팀원'],['회계팀 팀장', '회계팀 팀원']];
					
					$.each(json, function(index, item){					
						memberInfoArr.push({id: item.id,
									        title: item.title,
									        name: item.name});
					});
					
					
				} else {	// 세부 조직도
					node = [], memberInfoArr = [];	// 초기화
					
					$("p.highcharts-description").append("<span>이하 구성 팀원들</span>");
				  	
					switch (chartStyle) {
					case "0": $("span.subtitle").html("영업팀 조직도"); break;
					case "1": $("span.subtitle").html("인사팀 조직도"); break;
					case "2": $("span.subtitle").html("홍보팀 조직도"); break;
					case "3": $("span.subtitle").html("IT팀 조직도"); break;
					case "4": $("span.subtitle").html("회계팀 조직도"); break;
					}
				
					$.each(json, function(index, item){	// 팀장 node 연결				
						if(item.id.indexOf('팀장')!='-1'){
							node.push(['CEO 대표', item.id+index]);	
						}
					});
					
					$.each(json, function(index, item){ 				
						if(item.id.indexOf('팀원')!='-1'){
							$("p.highcharts-description").append("<div class='memberName'>"+item.name+"</div>");
						}
						
						memberInfoArr.push({id: item.id+index,
									        title: item.title,
									        name: item.name});
					});
				}
				
				
				/////////////////////////////////////////////////////////////////////////////
				Highcharts.chart('container', {
					  chart: {
					    height: 400,
					    inverted: true
					  },
					  title : {
						  text:""
					  },
					  accessibility: {
					    point: {
					      descriptionFormatter: function (point) {
					        var nodeName = point.toNode.name,
					          nodeId = point.toNode.id,
					          nodeDesc = nodeName === nodeId ? nodeName : nodeName + ', ' + nodeId,
					          parentDesc = point.fromNode.id;
					        return point.index + '. ' + nodeDesc + ', reports to ' + parentDesc + '.';
					      }
					    }
					  },
					  series: [{
					    type: 'organization',
					    name: 'Highsoft',
					    keys: ['from', 'to'],
					    data: node,
					    levels: [{
					      level: 0,
					      color: '#04AA6D',
					      dataLabels: {
					        color: 'white'
					      },
					      height: 10
					    }, {
					      level: 1,
					      color: '#e4fae6',
					      dataLabels: {
					        color: 'black'
					      },
					      height: 10
					    }, {
					      level: 2,
					      color: 'silver'
					    }],
					    nodes: memberInfoArr,
					    colorByPoint: false,
					    color: '#007ad0',
					    dataLabels: {
					      color: 'black'
					    },
					    borderColor: 'white',
					    nodeWidth: 65
					  }],
					  tooltip: {
					    outside: true
					  },
					  exporting: {
					    allowHTML: true,
					    sourceWidth: 800,
					    sourceHeight: 600
					  }
				 });
				/////////////////////////////////////////////////////////////////////////////
			
			},
			error: function(request, status, error){
                  alert("code: "+request.status+"\n"+"message: "+request.responseText+"\n"+"error: "+error);
            }
	 	 }); // end of $.ajax({}) --------------------------------------------------
	}); // end of $(document).ready(function(){})---------------------------------------
</script>

</head>
<body>
	<div id="mbrchartContainer">
		<span class="subtitle"></span>
		<hr>
		<figure class="highcharts-figure"  style="height: 300px !important;">
		  <div id="container"></div>
		  <p class="highcharts-description" >
		  </p>
		</figure>
	</div>
</body>
</html>
