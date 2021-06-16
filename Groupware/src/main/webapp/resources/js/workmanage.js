function setworkStatusBtn(item, delayday) {
	var statno = $(item).val();
	// console.log("statno : " + statno);
	
	if (statno == "0") {
		$(item).css({"background-color":"#ff3300"});
		$(item).text('지연+'+delayday);
	}
	else if (statno == "1") {
		$(item).css({"background-color":"#66ccff"});
		$(item).text('미완료');
	}
	else if (statno == "2") {
		$(item).css({"background-color":"white", "border":"1px solid black", "color":"black"});
		$(item).text('완료');
	}
	else if (statno == "3") {
		$(item).css({"background-color":"#66ccff"});
		$(item).text('미확인');
	}
	else if (statno == "4") {
		$(item).css({"background-color":"white", "border":"1px solid black", "color":"black"});
		$(item).text('승인완료');			
	}
	else if (statno == "5") {
		$(item).css({"background-color":"#ffcc00"});
		$(item).text('반려');
	}
	else {
		$(item).css({"background-color":"#999"});
		$(item).text('알수없음');
	}
}
	
function setworkStatusMbrBtn() {
	$("button.workStatusMbr").each(function(index, item){
		var percent = $(item).val();
		// console.log(percent);
		
		if (percent == 0) {
			$(item).css({"background-color":"#66ccff"});
			$(item).text('미처리');
		}
		else if (percent == 100) {
			$(item).css({"background-color":"white", "border":"1px solid black", "color":"black"});
			$(item).text('완료');
		}
		else if (percent == -1) {
			$(item).css({"background-color":"white", "border":"1px solid black", "color":"black"});
			$(item).text('확인');
		}
		else {
			$(item).css({"background-color":"#ff3300"});
			$(item).text('처리중 '+percent+'%');
		}
	});
}