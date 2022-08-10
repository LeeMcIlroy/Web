<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c"      uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="form"   uri="http://www.springframework.org/tags/form" %>
<%@ taglib prefix="ui"     uri="http://egovframework.gov/ctl/ui"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml" lang="ko" xml:lang="ko">
<c:import url="/EgovPageLink.do?link=adm/inc/incHead" />
<script>

	$(function(){
		<c:if test="${empty askNoCnt}">
			$("#question").val(1);
		</c:if>

		$('#brdContent').on('keyup', function() {
	        if($(this).val().length > 2000) {
	            $(this).val($(this).val().substring(0, 1300));
	        }
			var content = $(this).val();
			$('#counter').html(content.length + '/1300');
		});
		
		
		$(document).on("change", "select[name$=askType]", function(){
			
			console.log("askType change!!");
	
			if($(this).val() == "3"){
				$(this.parentElement.parentElement.nextElementSibling.nextElementSibling).css("display", "none");
				/*새로추가 2021-12-30 필수여부 란 표시여부 주관식을 제외한 나머지는 필수체크 변경못하도록*/
			}else{
				$(this.parentElement.parentElement.nextElementSibling.nextElementSibling).css("display", "");
			}
		});
		
	});

	// 답변 항목 추가
	function fn_itemAdd(tableNo){
		var table = "#questionTable"+tableNo+" > tbody > tr > #rep"+tableNo;
		var value = $(table+" > #item"+tableNo).val()*1;
		value = value + 1;
		$(table+" > #item"+tableNo).val(value);
		var tag = " <p id='itemContent"+value+"'>"
				+ " <label id='label"+value+"'>항목 "+value+"</label> "
				+ "<input type='hidden' name='askList["+(tableNo-1)+"].repList["+(value-1)+"].repChoiceCount' value='0'/>"
				+ "<input type='text' style='width:70%;' name='askList["+(tableNo-1)+"].repList["+(value-1)+"].repContent' maxlength='1000'/>"
				+ " <a href='#' id='sub"+value+"' class='add_in' onclick='fn_itemSub("+value+", "+tableNo+"); return false;'>X</a>"
				+ " <input type='hidden' name='askList["+(tableNo-1)+"].repList["+(value-1)+"].repNo' value='"+value+"'/></p>";
		
		$(table).append(tag);
	}
	
	// 답변 항목 삭제
	function fn_itemSub(item, tableNo){
		item = item*1;
		tableNo = tableNo*1;
		var table = "#questionTable"+tableNo+" > tbody > tr > #rep"+tableNo;
		
		$(table+" > #itemContent"+item).remove();
		
		itemMax = $(table+" > #item"+tableNo).val()
		for(i=item+1; i <= itemMax; i++){
			$(table+" > #itemContent"+i+" > #label"+i).attr("id","label"+(i-1)).text("항목 "+(i-1));
			$(table+" > #itemContent"+i+" > input[name='askList["+(tableNo-1)+"].repList["+(i-1)+"].repChoiceCount']").attr("name","askList["+(tableNo-1)+"].repList["+(i-2)+"].repChoiceCount");
			$(table+" > #itemContent"+i+" > input[name='askList["+(tableNo-1)+"].repList["+(i-1)+"].repContent']").attr("name","askList["+(tableNo-1)+"].repList["+(i-2)+"].repContent");
			$(table+" > #itemContent"+i+" > #sub"+i).attr("id","sub"+(i-1)).attr("onclick","fn_itemSub("+(i-1)+","+tableNo+"); return false;");
			$(table+" > #itemContent"+i+" > input[name='askList["+(tableNo-1)+"].repList["+(i-1)+"].repNo']").attr("name","askList["+(tableNo-1)+"].repList["+(i-2)+"].repNo").val(i-1);
			$(table+" > #itemContent"+i).attr("id","itemContent"+(i-1));
			
		}
		$(table+" > #item"+tableNo).val(itemMax-1);
		 
	}
	
	// 질문 추가
	function fn_questionAdd(){
		var value = $("#question").val()*1;
		$("#question").val(value+1);
		
		var tag = "<table class='view_tbl_03 mb30' summary='설문 내용' id='questionTable"+$("#question").val()+"'>"
				+ "<caption>설문 내용</caption>"
				+ "<colgroup>"
				+ "<col width='20%' />"
				+ "<col width='*' />"
				+ "</colgroup>"
				+ "<tbody>"
				+ "<tr class='first'>"
				+ "<th scope='row'>질문유형 </th>"
				+ "<td>"
				+ "<input type='hidden' name='askList["+value+"].askNo' value='"+$("#question").val()+"'/>"
				+ "<select class='se_base' name='askList["+value+"].askType'>"
				+ "<option value='1'>단답형</option>"
				+ "<option value='2'>복수형</option>"
				+ "<option value='3'>주관식</option>"
				+ "</select>"
				+ "<a href='#' style='display:inline-block; padding:4px 10px; font-weight:bold; color:#fff; background-color:#0c4da2;'id='qstDelete"+$("#question").val()+"' onclick='fn_questionSub("+$("#question").val()+"); return false;'>질문삭제</a>"
				+ "</td>"
				+ "<th scope='row' id='askChkTh'>필수체크</th>"
				+ "<td id='askChkTd'>"
				+ "<select class='se_base' name='askList["+value+"].askChk'>"
				+ "<option value='Y'>Y</option>"
				+ "<option value='N'>N</option>"
				+ "</select>"
				+ "</td>"
				+ "</tr>"
				+ "<tr>"
				+ "<th scope='row' id='qst"+$("#question").val()+"'>질문"+$("#question").val()+"</th>"
				+ "<td><input type='text' style='width:100%;' name='askList["+value+"].askContent' maxlength='1000'/></td>"
				+ "</tr>"
				+ "<tr>"
				+ "<th scope='row' id='ans"+$("#question").val()+"'>답변"+$("#question").val()+"</th>"
				+ "<td class='aw' id='rep"+$("#question").val()+"'>"
				+ "<input type='hidden' id='item"+$("#question").val()+"' value='1'/>"
				+ "<p id='itemContent1'><label>항목 1</label> "
				+ "<input type='hidden' name='askList["+value+"].repList[0].repChoiceCount' value='0'/> "
				+ "<input type='text' style='width:70%;' name='askList["+value+"].repList[0].repContent' />"
				+ " <a href='#' id='add"+$("#question").val()+"' class='add_in' onclick='fn_itemAdd("+$("#question").val()+"); return false;'>항목추가</a>"
				+ "<input type='hidden' name='askList["+value+"].repList[0].repNo' value='1'/></p>"
				+ "</td>"
				+ "</tr>"
				+ "</tbody>"
				+ "</table>";
			
				
		$("#questionDiv").append(tag);
		/*2021-12-30 새로추가  질문추가시 필수여부 란 안보이게처리   */
		if($("select[name ='askList["+value+"].askType'] option:selected").val() != '3'){
			
		   $("#askChkTd").attr('style','display:none;')
		   $("#askChkTh").attr('style','display:none;')

		}
	}
	
	// 질문삭제
	function fn_questionSub(askNo){
		$("#questionTable"+askNo).remove();
		for(i=askNo+1;i<=$("#question").val();i++){
			$("#questionTable"+i).attr("id","questionTable"+(i-1));
			$("input[name='askList["+(i-1)+"].askNo']").attr("name","askList["+(i-2)+"].askNo").val(i-1);
		
			$("select[name='askList["+(i-1)+"].askType']").attr("name","askList["+(i-2)+"].askType");
			$("input[name='askList["+(i-1)+"].askContent']").attr("name","askList["+(i-2)+"].askContent");
			$("#rep"+i).attr("id","rep"+(i-1));
			$("#item"+i).attr("id","item"+(i-1));
			$("#qst"+i).attr("id","qst"+(i-1)).text("질문"+(i-1));
			$("#ans"+i).attr("id","ans"+(i-1)).text("답변"+(i-1));
			
			for(j=0;j<$("#item"+(i-1)).val();j++){
				$("input[name='askList["+(i-1)+"].repList["+j+"].repChoiceCount']").attr("name","askList["+(i-2)+"].repList["+j+"].repChoiceCount");
				$("input[name='askList["+(i-1)+"].repList["+j+"].repContent']").attr("name","askList["+(i-2)+"].repList["+j+"].repContent");
				$("input[name='askList["+(i-1)+"].repList["+j+"].repNo']").attr("name","askList["+(i-2)+"].repList["+j+"].repNo");
				$("#rep"+(i-1)+" > p > #add"+i).attr("id","add"+(i-1)).attr("onclick","fn_itemAdd("+(i-1)+"); return false;");				
				$("#rep"+(i-1)+" > p > #sub"+(j+1)).attr("onclick","fn_itemSub("+(j+1)+","+(i-1)+"); return false;");				
			}
			$("#qstDelete"+i).attr("id","qstDelete"+(i-1)).attr("onclick","fn_questionSub("+(i-1)+"); return false;");
		}
		
		var value = $("#question").val()*1;
		$("#question").val(value-1);
		
	}
	
	// 목록으로
	function fn_list(){
		location.href="<c:url value='/xabdmxgr/qestnar/admQuestionaireList.do'/>";
	}
	
	// 저장하기
	function fn_update(){
		if($("#smtrSeq").val() == ''){
			alert("학기 강의실을 선택해주세요");
			return false;
		}
		if($("#qstnrTitle").val() == ''){
			alert("설문 구분 제목을 입력해 주세요");
			return false;
		}
		if($("#qstnrSubTitle").val() == ''){
			alert("설문 제목을 입력해 주세요");
			return false;
		}
		if($("#qstnrContent").val() == ''){
			alert("설문 내용을 입력해 주세요");
			return false;
		}
		if($("#qstnrStartDate").val() == ''){
			alert("설문기간을 선택해주세요.");
			return false;
	<c:if test="${empty cnsltScheduleVO.schSeq }">
		}else if($("#qstnrStartDate").val() > $("#qstnrEndDate").val()){
			alert("종료일이 시작일보다 과거에 있습니다.\n종료일을 다시 선택해주세요.");
			return false;
	</c:if>
		}
		
		for(i=0;i<$("#question").val();i++){
			if($("input[name='askList["+i+"].askContent']").val()==''){
				alert("입력되지 않은 질문이 있습니다.\n질문을 입력해 주세요");
				return false;
			}
			
			if($("select[name='askList["+i+"].askType']").val() != 3){
				for(j=0;j<$("#item"+$("#question").val()).val();j++){
					if($("input[name='askList["+i+"].repList["+j+"].repContent']").val()==''){
						alert("답변에 입력되지 않은 항목이 있습니다.\n항목을 입력해주세요");
						$("input[name='askList["+i+"].repList["+j+"].repContent']").focus();
						
						return false;
					}
				}
			}
		}
		
		$("#frm").attr("method","post").attr("action","<c:url value='/xabdmxgr/qestnar/admQuestionaireUpdate.do'/>").submit();
	}
</script>
<body>
<form:form commandName="qestnarVO" id="frm">

<form:hidden path="qstnrSeq" />
<form:hidden path="qstnrRespCount" />

<input type="hidden" id="question" value="${askNoCnt }"/>

<div class="wrap">
	<!-- 스킵 네비게이션 -->
	<div id="skip_navigation">
		<ul>
			<li><a href="#gnb">주 메뉴 바로가기</a></li>
			<li><a href="#content">본문 바로가기</a></li>
		</ul>
	</div>
	<!-- header -->
	<c:import url="/EgovPageLink.do?link=adm/inc/incTopnav" />
	<!--// header -->
	<hr />
	<p class="container_top_bg"></p>
	<!-- container -->
	<div class="container">
		<!-- lnb -->
		<c:import url="/EgovPageLink.do?link=adm/inc/incLeftmenu"/>
		<!--// lnb -->
		<!-- content -->
		<div class="content" id="content">
			<!-- 타이틀 영역 -->
			<div class="title_area">
				<jsp:include page="/WEB-INF/jsp/writer/adm/inc/incPageTitle.jsp">
					<jsp:param name="dept1" value="설문조사"/>
		            <jsp:param name="dept2" value="설문조사"/>
            	</jsp:include>
			</div>
			<div class="cont_box">
			<!-- content -->
				<div class="section_top_area mt30">
					<h4>설문 구분</h4>
				</div>
				<table class="view_tbl_03 mb30" summary="설문조사">
					<caption>설문조사</caption>
					<colgroup>
						<col width="20%" />
						<col width="*" />
					</colgroup>
					<tbody>
						<tr class="first">
							<th scope="row">학기 강의실</th>
							<td>
								<form:select path="smtrSeq" class="se_base">
									<form:option value="">학기 강의실 선택</form:option>
									<form:options items="${smtrList }" itemLabel="smtrTitle" itemValue="smtrSeq" />
								</form:select>
							</td>
						</tr>
						<tr>
							<th scope="row">설문 구분 제목</th>
							<td><form:input path="qstnrTitle" style="width:100%;" maxlength="150"/></td>
						</tr>
						<tr>
							<th scope="row">설문 제목</th>
							<td><form:input path="qstnrSubTitle" style="width:100%;" maxlength="150"/></td>
						</tr>
						<tr>
							<th scope="row">설문 내용</th>
							<td>
								<form:textarea path="qstnrContent" cols="5" rows="5" style="width:100%; height:100px;" /><div id="counter" style="text-align: right;">0/1300</div>
							</td>
						</tr>
						<tr>
							<th scope="row">설문 기간</th>
							<td>
								<form:input path="qstnrStartDate" readonly="true" class="datepicker w100"/> ~ <form:input path="qstnrEndDate" readonly="true" class="datepicker w100" />
							</td>
						</tr>
					</tbody>
				</table>
				<div class="btm_area">
					<div class="btn_box">
						<div class="btn_c">
							<a href="#" class="b_type03" onclick="fn_questionAdd(); return false;">질문추가</a>
						</div>
					</div>
				</div>
				<div class="section_top_area mt30">
					<h4>설문 내용</h4>
				</div>
				<div id="questionDiv">

					<c:if test="${empty qestnarAskVO }">
						<table class="view_tbl_03 mb30" summary="설문 내용" id="questionTable1">
							<caption>설문 내용</caption>
							<colgroup>
								<col width="20%" />
								<col width="*" />
							</colgroup>
							<tbody>
								<tr class="first">
									<th scope="row">질문유형 </th>
									<td>
										<input type="hidden" name="askList[0].askNo" value="1"/>
										<select class="se_base" name="askList[0].askType">
											<option value="1">단답형</option>
											<option value="2">복수형</option>
											<option value="3">주관식</option>
										</select>
										
									
									
									</td>
								
										<th scope="row">필수체크 </th>
										
										<td>
											<select class="se_base" name="askList[0].askChk" >
												<option value="Y">Y</option>
												<option value="N">N</option>
											</select>
										
										</td>
									
								</tr>
								<tr>
									<th scope="row" id="qst1">질문1</th>
									<td><input type="text" style="width:100%;" name="askList[0].askContent" maxlength="1000" /></td>
								</tr>
								<tr>
									<th scope="row" id="ans1">답변1</th>
									<td class="aw" id="rep1">
										<input type="hidden" id="item1" value="1"/>
										<p id="itemContent1">
											<label id="label1">항목 1</label>
											<input type="hidden" name="askList[0].repList[0].repChoiceCount" value="0"/> 
											<input type="text" style="width:70%;" name="askList[0].repList[0].repContent" maxlength="1000"/> 
											<a href="#" id="add1" class="add_in" onclick="fn_itemAdd(1); return false;">항목추가</a>
											<input type="hidden" id="askList[0].repList[0].repNo" name="askList[0].repList[0].repNo" value="1"/>
										</p>
									</td>
								</tr>
							</tbody>
						</table>
					</c:if>
				
					<c:if test="${!empty qestnarAskVO }">
						<c:forEach var="askList" items="${qestnarAskVO }" varStatus="status">
						<table class="view_tbl_03 mb30" summary="설문 내용" id="questionTable<c:out value='${askList.askNo }'/>">
							<caption>설문 내용</caption>
							<colgroup>
								<col width="20%" />
								<col width="*" />
							</colgroup>
							<tbody>
								<tr class="first">
									<th scope="row">질문유형</th>
									<td>
										<input type="hidden" name="askList[<c:out value='${askList.askNo-1 }'/>].askNo" value="<c:out value='${askList.askNo }'/>" />
										<select class="se_base" name="askList[<c:out value='${askList.askNo-1 }'/>].askType" >
											<option value="1" <c:if test="${askList.askType eq 1 }">selected</c:if> >단답형</option>
											<option value="2" <c:if test="${askList.askType eq 2 }">selected</c:if> >복수형</option>
											<option value="3" <c:if test="${askList.askType eq 3 }">selected</c:if> >주관식</option>
										</select>
										
									
								
										<c:if test="${askList.askNo ne 1 }">
											<c:if test="${qestnarVO.qstnrRespCount eq 0 }">
												<a href="#" style="display:inline-block; padding:4px 10px; font-weight:bold; color:#fff; background-color:#0c4da2;" id="qstDelete<c:out value='${askList.askNo }'/>" onclick="fn_questionSub(<c:out value='${askList.askNo }'/>); return false;">질문삭제</a>
											</c:if>
										</c:if>
									</td>
									
									
										<th scope="row">필수체크</th>
										
										<td>
										
										<select class="se_base" name="askList[<c:out value='${askList.askNo-1 }'/>].askChk" >
												<option value="Y" <c:if test="${askList.askChk eq 'Y' }">selected</c:if> >Y</option>
												<option value="N" <c:if test="${askList.askChk eq 'N' }">selected</c:if> >N</option>
											</select>
										</td>
									
									
								</tr>
								<tr>
									<th scope="row" id="qst<c:out value='${askList.askNo }'/>">질문<c:out value='${askList.askNo }'/></th>
									<td><input type="text" style="width:100%;" name="askList[<c:out value='${askList.askNo-1 }'/>].askContent" value="<c:out value='${askList.askContent }'/>" maxlength="1000"/></td>
								</tr>
								<c:if test="${askList.askType ne '3' }">
									<tr>
										<th scope="row" id="ans<c:out value='${askList.askNo }'/>">답변<c:out value='${askList.askNo }'/></th>
										<td class="aw" id="rep<c:out value='${askList.askNo }'/>">
											<input type="hidden" id="item<c:out value='${askList.askNo }'/>" value="<c:out value='${askList.repCnt }'/>"/>
											<c:forEach var="replyList" items="${qestnarReplyVO }">
											<c:if test="${askList.askNo eq replyList.askNo }">
											<p id="itemContent<c:out value='${replyList.repNo }'/>"> 
												<label id="label<c:out value='${replyList.repNo }'/>">항목 <c:out value="${replyList.repNo }"/></label> 
												<input type="hidden" name="askList[<c:out value='${askList.askNo-1 }'/>].repList[<c:out value='${replyList.repNo-1 }'/>].repChoiceCount" value="<c:out value='${replyList.repChoiceCount }'/>"/>
												<input type="text" style="width:70%;" name="askList[<c:out value='${askList.askNo-1 }'/>].repList[<c:out value='${replyList.repNo-1 }'/>].repContent" value="<c:out value='${replyList.repContent }'/>" maxlength="1000"/> 
												<c:if test="${replyList.repNo eq 1 }">
													<a href="#" id="add<c:out value='${replyList.repNo }'/>" class="add_in" onclick="fn_itemAdd(<c:out value='${askList.askNo }'/>); return false;">항목추가</a>
												</c:if>
												<c:if test="${qestnarVO.qstnrRespCount eq 0 }">
													<c:if test="${replyList.repNo ne 1 }">
														<a href="#" id="sub<c:out value='${replyList.repNo }'/>" class="add_in" onclick="fn_itemSub('<c:out value='${replyList.repNo }'/>', '<c:out value='${askList.askNo }'/>'); return false;">X</a>
													</c:if>
												</c:if>
												<input type="hidden" id="askList[<c:out value='${askList.askNo-1 }'/>].repList[<c:out value='${replyList.repNo-1 }'/>].repNo" name="askList[<c:out value='${askList.askNo-1 }'/>].repList[<c:out value='${replyList.repNo-1 }'/>].repNo" value="<c:out value='${replyList.repNo }'/>"/>
											</p>
											</c:if>
											</c:forEach>
										</td>
									</tr>
								</c:if>
								<c:if test="${askList.askType eq '3' }">
									<tr style="display: none;">
										<th scope="row" id="ans<c:out value='${status.count }'/>">답변<c:out value='${status.count }'/></th>
										<td class="aw" id="rep<c:out value='${status.count }'/>">
											<input type="hidden" id="item<c:out value='${status.count }'/>" value="1"/>
											<p id="itemContent<c:out value='${status.count }'/>">
												<label id="label1">항목 1</label>
												<input type="hidden" name="askList[<c:out value='${status.index }'/>].repList[0].repChoiceCount" value="0"/> 
												<input type="text" style="width:70%;" name="askList[<c:out value='${status.index }'/>].repList[0].repContent" maxlength="1000"/> 
												<a href="#" id="add<c:out value='${status.count }'/>" class="add_in" onclick="fn_itemAdd(<c:out value='${status.count }'/>); return false;">항목추가</a>
												<input type="hidden" id="askList[<c:out value='${status.index }'/>].repList[0].repNo" name="askList[<c:out value='${status.index }'/>].repList[0].repNo" value="1"/>
											</p>
										</td>
									</tr>
								</c:if>
							</tbody>
						</table>
						</c:forEach>						
					</c:if>				
				</div>
				<div class="btm_area">
					<div class="btn_box">
						<div class="btn_r">
							<a href="#" class="b_type02" onclick="fn_update(); return false;">저장</a>
							<a href="#" class="b_type03" onclick="fn_list(); return false;">목록</a>
						</div>
					</div>
				</div>
			<!-- //content -->
			</div>
		</div>
		<!--// content -->
	</div>
	<!--// container -->
	<hr />
	<!-- footer -->
	<c:import url="/EgovPageLink.do?link=adm/inc/incFooter" />
	<!--// footer -->
</div>
<input type="hidden" id="message" value="${message}" />
</form:form>
</body>
</html>