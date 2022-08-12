<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c"      uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="form"   uri="http://www.springframework.org/tags/form" %>
<%@ taglib prefix="ui"     uri="http://egovframework.gov/ctl/ui"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ taglib prefix="common" 	uri="/WEB-INF/tld/common.tld"%>
<!doctype html>
<html>
<c:import url="/EgovPageLink.do?link=adm/inc/incHead"/>
<script type="text/javascript">
	$(function(){
		//IRB승인여부
		/* var ynirbsmYn = '<c:out value="${rs1000mVO.irbsmYn}"/>';
		switch(ynirbsmYn) {
		case "Y" :  
			$("#irbsmYn1").attr('checked', 'checked');
			break;
		case "N" :  
			$("#irbsmYn2").attr('checked', 'checked');
			break;
		default :
			$("#irbsmYn1").attr('checked', 'checked');	
		} */
				
		// 사용여부 Y 사용, N 사용안함
		var ynuseYn = '<c:out value="${cr2020mVO.useYn}"/>';		
		switch (ynuseYn) {
		case 'Y':
			$("#useY").attr('checked', 'checked');
			
	    	break;
		case 'N':
			$("#useN").attr('checked', 'checked');
			break;
		default:
			console.log(`Sorry, we are out of ${expr}.`);
		}
		
		// 사용시기 0 상시 1 사전 2 사후
		/* var yntermType = '<c:out value="${cr2020mVO.termType}"/>';		
		switch (yntermType) {
		case '0':
			$("#termType0").attr('checked', 'checked');
	    	break;
		case '1':
			$("#termType1").attr('checked', 'checked');
			break;
		case '2':
			$("#termType2").attr('checked', 'checked');
			break;	
		default:
			console.log(`Sorry, we are out of ${expr}.`);
		} */
		
	});

	function fn_ques_add(){
		var html = '';
		var quesItem = document.getElementsByClassName('question_info');
		var quesLeng = quesItem.length;

		//연구대상자특성은 질문을 최대10개까지 제한
		var tempType = $("#tempType").val();
		if(tempType == '1030' && quesLeng > 9) {
				alert('연구대상자특성 질문항목은 최대 10개까지 추가하실 수 있습니다.');
			
		}else {
		
		html += '<div class="question_info" id="ques_div_'+quesLeng+'">';
		html += '	<p>질문'+(quesLeng+1)+'</p>';
		html += '	<table class="tbl_view">';
		html += '		<colgroup>';
		html += '			<col style="width:15%" />';
		html += '			<col style="width:85%" />';
		html += '		</colgroup>';
		html += '		<tbody>';
		html += '			<tr>';
		html += '				<th scope="row"><i>*</i>유형</th>';
		html += '				<td>';
		html += '					<input type="radio" name="cr2050mVOList['+quesLeng+'].quesType" id="answerType'+quesLeng+'_01" value="S"/>';
		html += '				    <label for="answerType'+quesLeng+'_01">단일응답</label>';
		html += '				    <input type="radio" name="cr2050mVOList['+quesLeng+'].quesType" id="answerType'+quesLeng+'_02" value="M"/>';
		html += '				    <label for="answerType'+quesLeng+'_02">복수응답</label>';
		html += '				    <input type="radio" name="cr2050mVOList['+quesLeng+'].quesType" id="answerType'+quesLeng+'_03" value="F"/>';
		html += '				    <label for="answerType'+quesLeng+'_03">자유기재형</label>';
		html += '					&nbsp;&nbsp;&nbsp;';
		html += '					<select class="p60" id="ajaxQues_'+quesLeng+'" onchange="fn_ques('+quesLeng+'); return false;">';
		html += '						<option>질문/답변 불러오기</option>';
		<c:forEach items="${cr2030mList }" var="cr2030m">
		html += '						<option value="<c:out value='${cr2030m.quesNo }'/>"><c:out value="${cr2030m.quesNm }"/></option>';
		</c:forEach>
		html += '					</select>';
		html += '				</td>';
		html += '			</tr>';					
		html += '			<tr>';
		html += '				<th scope="row"><i>*</i>질문</th>';
		html += '				<td>';
		html += '					<input type="text" name="cr2050mVOList['+quesLeng+'].quesCon" id="quesCon_'+quesLeng+'" class="ta_l"/>';
		html += '					<input type="text" name="cr2050mVOList['+quesLeng+'].quesAbb" id="quesAbb_'+quesLeng+'" class="ta_l"/>';
		html += '				</td>';
		html += '			</tr>';
		html += '			<tr>';
		html += '				<th scope="row"><i>*</i>답변</th>';
		html += '				<td id="answTd_'+quesLeng+'">';
		html += '					<div class="que_item ques_div_'+quesLeng+'">';
		html += '						<span>항목1</span>';
		html += '						<input type="text" name="cr2050mVOList['+quesLeng+'].cr2060mVOList[0].answCon" id="answCon_'+quesLeng+'_0" class="ta_l p70" />';
		html += '						<a style="cursor:pointer;" onclick="fn_answ_add('+quesLeng+');" class="btn_add">추가</a>';
		html += '					</div>';
		html += '				</td>';
		html += '			</tr>';
		html += '		</tbody>';
		html += '	</table>';
		html += '	<div class="sub_btn_area type02">';
		html += '		<a style="cursor:pointer;" onclick="fn_ques_del('+quesLeng+');">삭제</a>';
		html += '	</div>';
		html += '</div>';
		
		$("#ques_box").append(html);
		}
	}
	
	function fn_ques_del(num){
		var quesItem = document.getElementsByClassName('question_info');
		var quesLeng = quesItem.length-1;
		
		for(var i=num; i<quesLeng; i++){
			if(document.getElementById("answerType"+(i+1)+"_01").checked){
				document.getElementById("answerType"+i+"_01").checked = true;
			}else if(document.getElementById("answerType"+(i+1)+"_02").checked){
				document.getElementById("answerType"+i+"_02").checked = true;
			}else if(document.getElementById("answerType"+(i+1)+"_03").checked){
				document.getElementById("answerType"+i+"_03").checked = true;
			}
			
			$("#quesCon_"+i).val($("#quesCon_"+(i+1)).val());
			$("#quesAbb_"+i).val($("#quesAbb_"+(i+1)).val());
			
			var answItem = document.getElementsByClassName('ques_div_'+(i+1));
			var answLeng = answItem.length;
			var html = '';
			
			for(var j=0; j<answLeng; j++){
				var answCon = document.getElementById("answCon_"+i+'_'+j);
				var answConAf = $("#answCon_"+(i+1)+'_'+j).val();
				
				if(answCon != null){
					answCon.value = answConAf;
				}else{
					html += '<div class="que_item ques_div_'+i+'">';
					html += '	<span>항목'+(j+1)+'</span>';
					html += '	<input type="text" name="cr2050mVOList['+i+'].cr2060mVOList['+j+'].answCon" id="answCon_'+i+'_'+j+'" value="'+answConAf+'" class="ta_l p70 required" />';
					html += '	<a style="cursor:pointer;" class="btn_subtract" onclick="fn_answ_del('+i+','+j+');">삭제</a>';
					html += '</div>';
				}
			}
			
			$("#answTd_"+i).append(html);
		}
		
		quesItem[quesLeng].remove();
	}

	function fn_answ_add(num){
		var html = '';
		var queItem = document.getElementsByClassName('ques_div_'+num);
		var queLeng = queItem.length;
		
		if(queLeng < 6){
			html += '<div class="que_item ques_div_'+num+'">';
			html += '	<span>항목'+(queLeng+1)+'</span>';
			html += '	<input type="text" name="cr2050mVOList['+num+'].cr2060mVOList['+queLeng+'].answCon" id="answCon_'+num+'_'+queLeng+'" class="ta_l p70 required" />';
			html += '	<a style="cursor:pointer;" class="btn_subtract" onclick="fn_answ_del('+num+','+queLeng+');">삭제</a>';
			html += '</div>';
			
			$("#answTd_"+num).append(html);
		}else{
			alert('항목은 최대 6개까지 추가하실 수 있습니다.');
		}
	}
	
	function fn_answ_del(num, answNum){
		var queItem = document.getElementsByClassName('ques_div_'+num);
		var queLeng = queItem.length-1;
		
		for(var i=answNum; i<queLeng; i++){
			$("#answCon_"+num+'_'+i).val($("#answCon_"+num+'_'+(i+1)).val());
		}
		
		queItem[queLeng].remove();
	}
	
	function fn_list(){
		$("#frm").attr("action", "<c:out value='${pageContext.request.contextPath}/qxsepmny/ech0202/ech0202List.do'/>").submit();
	}
	
	function fn_update(){
		if(fn_validate('frm')){
			var tempType = $('#tempType').val();
			
			// termType '0' 기본값 설정
			var termType = '0';
			
			/* var termType = $('input[name="termType"]:checked').val();
			//alert(termType);
			
			//alert(tempType);
			if(termType==''){
				alert('사용시기를 입력해주세요.');
				$('#termType').focus();
				return;
			}else {
				if(tempType=='1010' && termType == '0'){
					alert('사용성설문 시기(사전, 사후)를 선택해주세요.');
					$('#termType').focus();
					return;
				}else if(tempType=='1020' && termType == '0'){
					alert('효능설문 시기(사전, 사후)를 선택해주세요.');
					$('#termType').focus();
					return;
				}
			} */
			$("#frm").attr("action", "<c:out value='${pageContext.request.contextPath}/qxsepmny/ech0202/ech0202Update.do'/>").submit();
		}
	}
	
	function fn_pop(){
		window.open("<c:out value='${pageContext.request.contextPath }/qxsepmny/tmp/ech020203.do'/>"
					, '템플릿관리미리보기', 'width=1000, height=500, menubar=no, status=no, toolbar=no, scrollbars=1');
	}
	
	function fn_ques(num){
		var quesNo = $("#ajaxQues_"+num).val();
		//alert(quesNo);
		
		if(quesNo != null && quesNo != ''){
			$.ajax({
				url: "<c:url value='/qxsepmny/ech0202/ajaxSelectQues.do'/>"
				, type: "post"
				, data: "quesNo="+quesNo
				, dataType:"json"
				, success: function(data){
					var result = data.result;
					
					if(result == 'true'){
						var cr2030mVO = data.cr2030mVO;
						var cr2040mList = data.cr2040mList;
						var quesType = cr2030mVO.quesType;
						var quesAbb = cr2030mVO.quesAbb;
						var html = '';
						
						switch (quesType) {
						case 'S':
							document.getElementById('answerType'+num+'_01').checked = true;
							break;
						case 'M':
							document.getElementById('answerType'+num+'_02').checked = true;
							break;
						case 'F':
							document.getElementById('answerType'+num+'_03').checked = true;
							break;
						}
						
						$("#quesCon_"+num).val(cr2030mVO.quesCon);
						$("#quesAbb_"+num).val(cr2030mVO.quesAbb);
						
						if(cr2040mList.length != null && cr2040mList.length != 0){
							for(var i=0; i<cr2040mList.length; i++){
								var cr2040mVO = cr2040mList[i];
								
								html += '<div class="que_item ques_div_'+num+'">';
								html += '	<span>항목'+(i+1)+'</span>';
								html += '	<input type="text" name="cr2050mVOList['+num+'].cr2060mVOList['+i+'].answCon" id="answCon_'+num+'_'+i+'" value="'+cr2040mVO.answCon+'" class="ta_l p70 required" />';
								if(i == 0){
									html += '	<a style="cursor:pointer;" onclick="fn_answ_add('+num+');" class="btn_add">추가</a>';
								}else{
									html += '	<a style="cursor:pointer;" class="btn_subtract" onclick="fn_answ_del('+num+','+i+');">삭제</a>';
								}
								html += '</div>';
							}
						}else{
							html += '<div class="que_item ques_div_'+num+'">';
							html += '	<span>항목1</span>';
							html += '	<input type="text" name="cr2050mVOList['+num+'].cr2060mVOList[0].answCon" id="answCon_'+num+'_0" class="ta_l p70 required" />';
							html += '	<a style="cursor:pointer;" onclick="fn_answ_add('+num+');" class="btn_add">추가</a>';
							html += '</div>';
						}
						
						$("#answTd_"+num).html(html);
					}else{
						alert("");
					}
				}, error: function(){
					alert("오류가 발생하였습니다.");
				}
			});
		}
	}
</script>
<body>
<!-- wrap -->
<div class="wrap">
	<c:import url="/EgovPageLink.do?link=adm/inc/incTopnav"/>
	<!-- container -->
	<div class="container">
		<h2>eCRF관리</h2>
		<!-- contents -->
		<div class="contents">
			<!-- 타이틀 -->
			<jsp:include page="/WEB-INF/jsp/ctms/adm/inc/incPageTitle.jsp">
				<jsp:param name="dept1" value="eCRF관리"/>
	            <jsp:param name="dept2" value="템플릿관리"/>
           	</jsp:include>
			<!-- //타이틀 -->
			<!-- 서브타이틀 -->
			<div class="sub_title_area type02">
				<h4>기본정보</h4>
			</div>
			<!-- //서브타이틀 -->
			<form:form commandName="searchVO" id="searchFrm" name="searchFrm" method="post">
				<form:hidden path="searchCondition1"/>
				<form:hidden path="searchCondition2"/>
				<form:hidden path="searchCondition3"/>
				<form:hidden path="startDate"/>
				<form:hidden path="endDate"/>
				<form:hidden path="searchType"/>
				<form:hidden path="searchWord"/>
			</form:form>
			<form:form commandName="cr2020mVO" id="frm" name="frm" method="post">
				<form:hidden path="tempNo"/>
	            <!-- 기본정보 -->
				<table class="tbl_view">
					<colgroup>
						<col style="width:15%" />
						<col style="width:35%" />
						<col style="width:15%" />
						<col style="width:35%" />
					</colgroup>
					<tbody>
						<tr>
							<th scope="row">템플릿코드</th>
							<td>
								<input type="text" disabled="disabled" path="tempNo"/>
							</td>
							<th scope="row" class="bl">템플릿구분</th>
							<td>
								<form:select path="tempType">
									<form:option value="">선택</form:option>
									<c:forEach items="${typeList }" var="type">
										<form:option value="${type.cd }"><c:out value="${type.cdName }"/></form:option>
									</c:forEach>
								</form:select>
							</td>
						</tr>
						<tr>
							<th scope="row">템플릿명</th>
							<td>
								<form:input path="tempNm"/>
							</td>
							<th scope="row" class="bl">사용기간</th>
							<td>
								<div class="date_sec">
									<span>
										<form:input path="stDate" class="date" id="datepicker01" readonly="true"/>
										<label for="stDate" class="btn_cld">날짜검색</label>
									</span>
									<em>~</em>
									<span>
										<form:input path="edDate" class="date" id="datepicker02" readonly="true"/>
										<label for="edDate" class="btn_cld">날짜검색</label>
									</span>
								</div>
							</td>
						</tr>
						<tr>
							<th scope="row">사용여부</th>
							<td colspan='3'>
								<form:radiobutton path="useYn" id="useY" value="Y" checked="checked"/>
							    <label for="useY">사용</label>
							    <form:radiobutton path="useYn" id="useN" value="N"/>
							    <label for="useN">미사용</label>
							</td>
							<%-- <th scope="row" class="bl">사용시기</th>
							<td>
								<form:radiobutton path="termType" id="termType0" value="0" checked="checked"/>
							    <label for="termType0">상시</label>
							    <form:radiobutton path="termType" id="termType1" value="1"/>
							    <label for="termType1">사전</label>
							    <form:radiobutton path="termType" id="termType2" value="2"/>
							    <label for="termType2">사후</label>
							</td> --%>
						</tr>
					</tbody>
				</table>
	            <!-- //기본정보 -->
	            <!-- 버튼 -->
				<div class="btn_area">
					<a href="#" onclick="fn_list();" class="type02">취소</a>
					<a href="#" onclick="fn_update();">저장</a>
					<!-- 미리보기 -->
					<div>
						<!-- <a onclick="fn_pop(); return false;" class="btn_sub type02">미리보기</a> -->
					</div>
					<!-- //미리보기 -->
				</div>
				<span style="color:red;"><i>*설문(연구자대상자특성,사용성,효능설문)템플릿의 구성쪽수(페이지수)는 CRF설정관리에서 템플릿선택시 자동 적용됩니다.</i></span>
				<!-- //버튼 -->
				<div id="ques_box">
					<c:if test="${cr2050List != null && cr2050List.size() != 0 }">
						<c:forEach items="${cr2050List }" var="cr2050m" varStatus="status">
							<!-- 질문 정보 -->
							<div class="question_info" id="ques_div_<c:out value='${status.index }'/>">
								<p>질문<c:out value='${status.count }'/></p>
								<table class="tbl_view">
									<colgroup>
										<col style="width:15%" />
										<col style="width:85%" />
									</colgroup>
									<tbody>
										<tr>
											<th scope="row"><i>*</i>유형</th>
											<td>
												<form:radiobutton path="cr2050mVOList[${status.index }].quesType" id="answerType${status.index }_01" value="S" checked="${cr2050m.quesType eq 'S'?'true':'' }"/>
											    <label for="answerType<c:out value='${status.index }'/>_01">단일응답</label>
											    <form:radiobutton path="cr2050mVOList[${status.index }].quesType" id="answerType${status.index }_02" value="M" checked="${cr2050m.quesType eq 'M'?'true':'' }"/>
											    <label for="answerType<c:out value='${status.index }'/>_02">복수응답</label>
											    <form:radiobutton path="cr2050mVOList[${status.index }].quesType" id="answerType${status.index }_03" value="F" checked="${cr2050m.quesType eq 'F'?'true':'' }"/>
											    <label for="answerType<c:out value='${status.index }'/>_03">자유기재형</label>
												&nbsp;&nbsp;&nbsp;
												<select class="p60" id="ajaxQues_<c:out value='${status.index }'/>" onchange="fn_ques(<c:out value='${status.index }'/>); return false;">
													<option>질문/답변 불러오기</option>
													<c:forEach items="${cr2030mList }" var="cr2030m">
														<option value="<c:out value='${cr2030m.quesNo }'/>"><c:out value="${cr2030m.quesNm }"/></option>
													</c:forEach>
												</select>
											</td>
										</tr>					
										<tr>
											<th scope="row"><i>*</i>질문</th>
											<td>
												<form:input path="cr2050mVOList[${status.index }].quesCon" id="quesCon_${status.index }" value="${cr2050m.quesCon }" class="ta_l"/>
												<form:input path="cr2050mVOList[${status.index }].quesAbb" id="quesAbb_${status.index }" value="${cr2050m.quesAbb }" class="ta_l"/>
											</td>
										</tr>
										<tr>
											<th scope="row"><i>*</i>답변</th>
											<td id="answTd_<c:out value='${status.index }'/>">
												<c:set var="quesNo" value="${cr2050m.quesNo }"/>
												<c:set var="cr2060List" value="${cr2060Map[quesNo] }"/>
												<c:if test="${cr2060List != null && cr2060List.size() != 0 }">
													<c:forEach items="${cr2060List }" var="cr2060m" varStatus="statusAnsw">
														<div class="que_item ques_div_<c:out value='${status.index }'/>">
															<span>항목<c:out value="${statusAnsw.count }"/></span>
															<form:input path="cr2050mVOList[${status.index }].cr2060mVOList[${statusAnsw.index }].answCon" id="answCon_${status.index }_${statusAnsw.index }" value="${cr2060m.answCon }" class="ta_l p70" />
															<c:if test="${statusAnsw.first }">
																<a onclick="fn_answ_add('<c:out value="${status.index }"/>');" style="cursor:pointer;" class="btn_add">추가</a>
															</c:if>
															<c:if test="${!statusAnsw.first }">
																<a style="cursor:pointer;" class="btn_subtract" onclick="fn_answ_del(<c:out value='${status.index }'/>,<c:out value='${statusAnsw.index }'/>);">삭제</a>
															</c:if>
														</div>
													</c:forEach>
												</c:if>
												<c:if test="${cr2060List == null || cr2060List.size() == 0 }">
													<div class="que_item ques_div_<c:out value="${status.index }"/>">
														<div class="que_item ques_div_<c:out value="${status.index }"/>">
															<span>항목1</span>
															<form:input path="cr2050mVOList[${status.index }].cr2060mVOList[0].answCon" id="answCon_${status.index }_0" class="ta_l p70" />
															<a onclick="fn_answ_add('0');" style="cursor:pointer;" class="btn_add">추가</a>
														</div>
													</div>
												</c:if>
											</td>
										</tr>
									</tbody>
								</table>
								<!-- 삭제버튼 -->
								<div class="sub_btn_area type02">
									<a style="cursor:pointer;" onclick="fn_ques_del(<c:out value='${status.index }'/>);">삭제</a>
								</div>
								<!-- //삭제버튼 -->
							</div>
							<!-- //질문 정보 -->
						</c:forEach>
					</c:if>
					<c:if test="${cr2050List == null || cr2050List.size() == 0 }">
						<!-- 질문 정보 -->
						<div class="question_info" id="ques_div_0">
							<p>질문1</p>
							<table class="tbl_view">
								<colgroup>
									<col style="width:15%" />
									<col style="width:85%" />
								</colgroup>
								<tbody>
									<tr>
										<th scope="row"><i>*</i>유형</th>
										<td>
											<form:radiobutton path="cr2050mVOList[0].quesType" id="answerType0_01" value="S"/>
										    <label for="answerType0_01">단일응답</label>
										    <form:radiobutton path="cr2050mVOList[0].quesType" id="answerType0_02" value="M"/>
										    <label for="answerType0_02">복수응답</label>
										    <form:radiobutton path="cr2050mVOList[0].quesType" id="answerType0_03" value="F"/>
										    <label for="answerType0_03">자유기재형</label>
											&nbsp;&nbsp;&nbsp;
											<select class="p60" id="ajaxQues_0" onchange="fn_ques(0); return false;">
												<option>질문/답변 불러오기</option>
												<c:forEach items="${cr2030mList }" var="cr2030m">
													<option value="<c:out value='${cr2030m.quesNo }'/>"><c:out value="${cr2030m.quesNm }"/></option>
												</c:forEach>
											</select>
										</td>
									</tr>					
									<tr>
										<th scope="row"><i>*</i>질문</th>
										<td>
											<form:input path="cr2050mVOList[0].quesCon" id="quesCon_0" class="ta_l"/>
											<form:input path="cr2050mVOList[0].quesAbb" id="quesAbb_0" class="ta_l"/>
										</td>
									</tr>
									<tr>
										<th scope="row"><i>*</i>답변</th>
										<td id="answTd_0">
											<div class="que_item ques_div_0">
												<span>항목1</span>
												<form:input path="cr2050mVOList[0].cr2060mVOList[0].answCon" id="answCon_0_0" class="ta_l p70" />
												<a onclick="fn_answ_add('0');" style="cursor:pointer;" class="btn_add">추가</a>
											</div>
										</td>
									</tr>
								</tbody>
							</table>
							<!-- 삭제버튼 -->
							<div class="sub_btn_area type02">
								<a style="cursor:pointer;" onclick="fn_ques_del(0);">삭제</a>
							</div>
							<!-- //삭제버튼 -->
						</div>
						<!-- //질문 정보 -->
					</c:if>
				</div>
				<!-- 설문지 추가 버튼 -->
				<a style="cursor:pointer;" onclick="fn_ques_add();" class="btm_btn">질문 추가 +</a>
				<!-- //설문지 추가 버튼 -->
			</form:form>
		</div>
		<!-- //contents -->
	</div>
	<!-- //container -->
</div>	
<!-- //wrap -->
</body>
</html>