// PDF 다운로드
function fn_pdf_download(target, type, type2){
	$(".box_div_option").css("display", "none");
	if(type == 'line'){
		// 일반 선 그래프 속성 - start
    	d3.selectAll(".c3[id="+target+"] svg text").style({ 'font-size':'10px'});
    	d3.selectAll(".c3[id="+target+"] path, line").style({ 'fill':'none' });
    	d3.selectAll(".c3[id="+target+"] .c3-axis-x path, .c3-axis-x line").style({ 'stroke':'#000' });
    	d3.selectAll(".c3[id="+target+"] .c3-axis-y path, .c3-axis-y line").style({ 'stroke':'#000' });
    	d3.selectAll(".c3[id="+target+"] .c3-axis-y2 path, .c3-axis-y2 line").style({ 'stroke':'#000' });
    	// 일반 선 그래프 속성 - end
	}else if(type == 'scatter'){
		// 점 그래프 속성 - start
    	d3.selectAll(".c3[id="+target+"] svg text").style({ 'font-size':'10px'});
    	d3.selectAll(".c3[id="+target+"] path, line").style({ 'fill':'none' });
    	d3.selectAll(".c3[id="+target+"] .c3-axis-x path, .c3-axis-x line").style({ 'stroke':'#000' });
    	d3.selectAll(".c3[id="+target+"] .c3-axis-y path, .c3-axis-y line").style({ 'stroke':'#000' });
    	d3.selectAll(".c3[id="+target+"] .c3-axis-y2 path, .c3-axis-y2 line").style({ 'stroke':'#000' });
    	d3.selectAll(".c3[id="+target+"] .scatter_x_label line").style({ 'stroke':'#aaa' });
    	d3.selectAll(".c3[id="+target+"] .c3-xgrid-line").style({ 'stroke':'#aaa', 'stroke-dasharray': '3 3' });
    	d3.selectAll(".c3[id="+target+"] .c3-ygrid").style({ 'stroke':'#aaa', 'stroke-dasharray': '3 3' });
    	// 점 그래프 속성 - end
	}else if(type == 'lineandbar'){
		// 선+막대 그래프 속성 - start
		var color1 = $(".c3-shapes.c3-shapes-data0.c3-lines.c3-lines-data0 path").css("stroke"); // line
		var color2 = $(".c3-shapes.c3-shapes-data1.c3-bars.c3-bars-data1 path").css("fill"); // bar1
		var color3 = $(".c3-shapes.c3-shapes-data2.c3-bars.c3-bars-data2 path").css("fill"); // bar2
		
    	d3.selectAll(".c3[id="+target+"] svg text").style({ 'font-size':'10px'});
    	d3.selectAll(".c3[id="+target+"] path, line").style({ 'fill':'none' });
    	
    	d3.selectAll(".c3[id="+target+"] .c3-shapes.c3-shapes-data0.c3-lines.c3-lines-data0 path").style({ 'stroke': color1 });
    	d3.selectAll(".c3[id="+target+"] .c3-shapes.c3-shapes-data1.c3-bars.c3-bars-data1 path").style({ 'fill': color2, 'stroke': color2});
    	d3.selectAll(".c3[id="+target+"] .c3-shapes.c3-shapes-data2.c3-bars.c3-bars-data2 path").style({ 'fill': color3, 'stroke': color3});
    	
    	d3.selectAll(".c3[id="+target+"] .c3-axis-x path, .c3-axis-x line").style({ 'stroke':'#000' });
    	d3.selectAll(".c3[id="+target+"] .c3-axis-y path, .c3-axis-y line").style({ 'stroke':'#000' });
    	d3.selectAll(".c3[id="+target+"] .c3-axis-y2 path, .c3-axis-y2 line").style({ 'stroke':'#000' });
    	// 선+막대 그래프 속성 - end
	}else if(type == 'bar'){
		// 막대 그래프 속성 - start
    	d3.selectAll(".c3[id="+target+"] svg text").style({ 'font-size':'10px'});
    	// d3.selectAll(".c3[id="+target+"] .c3-bars path").style({ 'fill':'rgb(31, 119, 180)', 'stroke':'rgb(31, 119, 180)' });
    	
    	var arr = new Array();
    	
    	var barCount = $(".c3[id="+target+"] .c3-chart-bars .c3-chart-bar").length;
    	for(var i = 0; i < barCount; i++){
    		var color = $(".c3[id="+target+"] .c3-chart-bars .c3-chart-bar:nth-child("+(i+1)+")").children().children().css("fill");
    		arr.push(color);
    		//d3.selectAll(".c3[id="+target+"] .c3-chart-bars .c3-chart-bar:nth-child("+(i+1)+")").style({ 'fill' : color });
    	}
    	
    	d3.selectAll(".c3[id="+target+"] path, line").style({ 'fill':'none' });
    	
    	for(var i = 0; i < arr.length; i++){
    		d3.selectAll(".c3[id="+target+"] .c3-chart-bars .c3-chart-bar:nth-child("+(i+1)+") path").style({ 'fill' : arr[i] });
    	}
    	
    	d3.selectAll(".c3[id="+target+"] .c3-axis-x path, .c3-axis-x line").style({ 'stroke':'#000' });
    	d3.selectAll(".c3[id="+target+"] .c3-axis-y path, .c3-axis-y line").style({ 'stroke':'#000' });
    	d3.selectAll(".c3[id="+target+"] .c3-axis-y2 path, .c3-axis-y2 line").style({ 'stroke':'#000' });
    	// 막대 그래프 속성 - end
	}else if(type == 'gauge'){
		// 게이지 그래프 속성 - start
    	d3.selectAll(".c3[id="+target+"] .c3-chart-arcs .c3-chart-arcs-background").style({ 'fill':'#e0e0e0' });
    	d3.selectAll(".c3[id="+target+"] .c3-target-출력 > text").style({ 'font-size':'30px !important' });
    	d3.selectAll(".c3[id="+target+"] .c3-chart-arcs .c3-chart-arcs-gauge-min, .c3-chart-arcs-gauge-max").style({ 'font-size':'10px' });
    	d3.selectAll(".c3[id="+target+"] .c3-gauge-value").style({ 'font-size':'20px' });
    	// 게이지 그래프 속성 - end
	}
	
	var t;
	if(type2 == "A" || type2 == "D"){
		t = $("#"+target).parent();
	}else if(type2 == "B" || type2 == "C"){
		t = $("#"+target).parent().parent();
	}
	
	html2canvas(t, {
        onrendered: function(canvas) {
        	//document.getElementById("result").appendChild(canvas);
            if (typeof FlashCanvas != "undefined") {
                FlashCanvas.initElement(canvas);
            }
            var image = canvas.toDataURL("image/png");
            $("#frm").append('<input type="hidden" id="imgData" name="imgData"/>');
            $("#frm").append('<input type="hidden" id="imgType" name="imgType"/>');
            
            $("#imgData").val(image);
            $("#imgType").val(type2);
            
            fn_loading_on();
			$.fileDownload("/cmmn/pdfDownload.do", {
				httpMethod : "POST"
				, data : $("#frm").serialize()
			}).done(function(){
				fn_loading_off();
			});
			
            //$("#frm").attr("method", "post").attr("action", "/cmmn/pdfDownload.do").submit();
        }
    });
	$("#imgData").remove();
    $("#imgType").remove();
	$(".box_div_option").css("display", "");
}