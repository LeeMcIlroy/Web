<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c"      uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="form"   uri="http://www.springframework.org/tags/form" %>
<%@ taglib prefix="ui"     uri="http://egovframework.gov/ctl/ui"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ taglib prefix="common" 	uri="/WEB-INF/tld/common.tld"%>
<!DOCTYPE html>
<html lang="ko">
<c:import url="/EgovPageLink.do?link=usr/inc/incHead"/>
<script src="<c:out value='${pageContext.request.contextPath }/assets/usr/js/language.js'/>"></script>
<script>
	$(function(){
		var message = '<c:out value="${message }"/>';
		
		if(message != ''){
			alert(message);
			opener.location.reload();
			window.close();
		}
	});
	
	function fn_save(){
		if(fn_validate("frm")){
			$("#frm").attr("action", "<c:url value='/usr/std/lecRoom/stdLecEvalUpdate.do'/>").submit();
		}
	}

	var lang = '<c:out value="${resultMap.lang }"/>';

	window.onload = function(){
		var textList;

		if(lang == 'Korean'){
			textList = Korean;
		}else if(lang == 'Vietnamese'){
			textList = Vietnames;
		}else if(lang == 'Japanese'){
			textList = Japanese;
		}else if(lang == 'English'){
			textList = English;
		}else if(lang == 'Chinese'){
			textList = Chinese;
		}else if(lang == 'Mongolian'){
			textList = Mongol;
		}

		$(".sect").html(textList[0]);
		$(".ques").html(textList[1]);
		$(".answ").html(textList[2]);
		$(".prof").html(textList[3]);

		var phrTit = document.getElementsByClassName('phrTit');

		for(var i=0; i<phrTit.length; i++){
			var title = phrTit[i];

			if(title.innerHTML == Korean[4]){
				title.innerHTML = textList[4];
			}else if(title.innerHTML == Korean[5]){
				title.innerHTML = textList[5];
			}else if(title.innerHTML == Korean[6]){
				title.innerHTML = textList[6];
			}else if(title.innerHTML == Korean[7]){
				title.innerHTML = textList[7];
			}else if(title.innerHTML == Korean[8]){
				title.innerHTML = textList[8];
			}
		}
	}
	
	function fn_close(){
		window.close();
	}
</script>
<body>
	<!-- contents -->
	<div class="content-box">
		<div class="contents">
			<div class="pop-content">
				<form:form commandName="surveyAnswVO" id="frm" name="frm">
					<!-- table -->
					<div class="list-table-box">
						<table class="normal-wmv-table">
							<colgroup>
								<col />
							</colgroup>
							<tbody>
								<tr>
									<td><c:out value="${resultMap.content }" escapeXml="false"/></td>
								</tr>
							</tbody>
						</table>
					</div>
					<c:set var="totCnt" value="0"/>
					<c:forEach items="${resultList }" var="result" varStatus="status">
						<c:if test="${result.quesType eq 'LEC' }">
							<c:set var="totCnt" value="${totCnt+1 }"/>
							<div class="list-table-box mt50">
								<table class="normal-wmv-table">
									<colgroup>
										<col width="10%"/>
										<col />
									</colgroup>
									<tbody>
											<tr>
												<th class="sect">조사구분</th>
												<td class="phrTit"><c:out value="${result.phrTitle }"/></td>
											</tr>
											<tr>
												<th class="ques">질문</th>
												<td>
													<c:out value="${result.question }"/>
													<input type="hidden" name="surveyAnswList[<c:out value='${status.index }'/>].quesSeq" value="<c:out value='${result.quesSeq }'/>"/>
													<input type="hidden" name="surveyAnswList[<c:out value='${status.index }'/>].quesNum" value="<c:out value='${result.quesNum }'/>"/>
													<input type="hidden" name="surveyAnswList[<c:out value='${status.index }'/>].quesType" value="<c:out value='${result.quesType }'/>"/>
													<input type="hidden" name="surveyAnswList[<c:out value='${status.index }'/>].surveySeq" value="<c:out value='${result.surveySeq }'/>"/>
													<input type="hidden" name="surveyAnswList[<c:out value='${status.index }'/>].surveyType" value="<c:out value='${result.surveyType }'/>"/>
												</td>
											</tr>
									</tbody>
								</table>
							</div>
							<div class="list-table-box">
								<table class="normal-wmv-table">
									<colgroup>
										<col width="10%"/>
										<col width="45%"/>
										<col />
									</colgroup>
									<tbody>
										<c:if test="${result.surveyType eq '1' }">
											<tr>
												<th rowspan="5" class="answ">답변</th>
												<td class="txt-c">1)<c:out value="${result.answer1 }"/></td>
												<td class="txt-c"><input type="radio" name="surveyAnswList[<c:out value='${status.index }'/>].answer" id="answer<c:out value='${status.index }'/>_1" class="required radio" title="답변" value="5"/></td>
											</tr>
											<tr>
												<td class="txt-c">2)<c:out value="${result.answer2 }"/></td>
												<td class="txt-c"><input type="radio" name="surveyAnswList[<c:out value='${status.index }'/>].answer" id="answer<c:out value='${status.index }'/>_2" class="required radio" title="답변" value="4"/></td>
											</tr>
											<tr>
												<td class="txt-c">3)<c:out value="${result.answer3 }"/></td>
												<td class="txt-c"><input type="radio" name="surveyAnswList[<c:out value='${status.index }'/>].answer" id="answer<c:out value='${status.index }'/>_3" class="required radio" title="답변" value="3"/></td>
											</tr>
											<tr>
												<td class="txt-c">4)<c:out value="${result.answer4 }"/></td>
												<td class="txt-c"><input type="radio" name="surveyAnswList[<c:out value='${status.index }'/>].answer" id="answer<c:out value='${status.index }'/>_4" class="required radio" title="답변" value="2"/></td>
											</tr>
											<tr>
												<td class="txt-c">5)<c:out value="${result.answer5 }"/></td>
												<td class="txt-c"><input type="radio" name="surveyAnswList[<c:out value='${status.index }'/>].answer" id="answer<c:out value='${status.index }'/>_5" class="required radio" title="답변" value="1"/></td>
											</tr>
										</c:if>
										<c:if test="${result.surveyType eq '2' }">
											<c:if test="${result.answer1 ne '' }">
												<tr>
													<th class="answ" rowspan="<c:out value="${result.answer5 ne ''?'5':result.answer4 ne ''?'4':result.answer3 ne ''?'3':result.answer2 ne ''?'2':result.answer1 ne ''?'1':'' }"/>">답변</th>
													<td><c:out value="${result.answer1 }"/></td>
													<td class="txt-c">
														<input type="radio" name="surveyAnswList[<c:out value='${status.index }'/>].answer" id="answer<c:out value='${status.index }'/>_1" class="required radio" title="답변" value="1"/>
													</td>
												</tr>
											</c:if>
											<c:if test="${result.answer2 ne '' }">
												<tr>
													<td><c:out value="${result.answer2 }"/></td>
													<td class="txt-c">
															<input type="radio" name="surveyAnswList[<c:out value='${status.index }'/>].answer" id="answer<c:out value='${status.index }'/>_2" class="required radio" title="답변" value="2"/>
													</td>
												</tr>
											</c:if>
											<c:if test="${result.answer3 ne '' }">
												<tr>
													<td><c:out value="${result.answer3 }"/></td>
													<td class="txt-c">
														<input type="radio" name="surveyAnswList[<c:out value='${status.index }'/>].answer" id="answer<c:out value='${status.index }'/>_3" class="required radio" title="답변" value="3"/>
													</td>
												</tr>
											</c:if>
											<c:if test="${result.answer4 ne '' }">
												<tr>
													<td><c:out value="${result.answer4 }"/></td>
													<td class="txt-c">
														<input type="radio" name="surveyAnswList[<c:out value='${status.index }'/>].answer" id="answer<c:out value='${status.index }'/>_4" class="required radio" title="답변" value="4"/>
													</td>
												</tr>
											</c:if>
											<c:if test="${result.answer5 ne '' }">
												<tr>
													<td><c:out value="${result.answer5 }"/></td>
													<td class="txt-c">
														<input type="radio" name="surveyAnswList[<c:out value='${status.index }'/>].answer" id="answer<c:out value='${status.index }'/>_5" class="required radio" title="답변" value="5"/>
													</td>
												</tr>
											</c:if>
										</c:if>
										<c:if test="${result.surveyType eq '3'}">
											<tr>
												<th class="answ">답변</th>
												<td colspan="3"><textarea class="w100pc required" rows="5" name="surveyAnswList[<c:out value='${status.index }'/>].answerTxt" id="answerTxt<c:out value='${status.index }'/>" title="답변"></textarea></td>
											</tr>
										</c:if>
									</tbody>
								</table>
							</div>
						</c:if>
					</c:forEach>
					<c:forEach items="${profList }" var="prof" varStatus="status">
						<p class="sub-title mt50">
							<img alt="<c:out value='${prof.imgName }'/>" src="<c:url value='/showImage.do?filePath=${prof.imgPath }'/>" style="width:113px; height:151px;">
							<span class="prof">선생님</span> : <c:out value="${prof.name }"/>
						</p>
						<c:forEach items="${resultList }" var="result" varStatus="status">
							<c:if test="${result.quesType eq 'PRF' }">
								<div class="list-table-box">
									<table class="normal-wmv-table">
										<colgroup>
											<col width="10%"/>
											<col />
										</colgroup>
										<tbody>
												<tr>
													<th class="sect">조사구분</th>
													<td class="phrTit"><c:out value="${result.phrTitle }"/></td>
												</tr>
												<tr>
													<th class="ques">질문</th>
													<td>
														<c:out value="${result.question }"/>
														<input type="hidden" name="surveyAnswList[<c:out value='${totCnt }'/>].quesSeq" value="<c:out value='${result.quesSeq }'/>"/>
														<input type="hidden" name="surveyAnswList[<c:out value='${totCnt }'/>].quesNum" value="<c:out value='${result.quesNum }'/>"/>
														<input type="hidden" name="surveyAnswList[<c:out value='${totCnt }'/>].quesType" value="<c:out value='${result.quesType }'/>"/>
														<input type="hidden" name="surveyAnswList[<c:out value='${totCnt }'/>].surveySeq" value="<c:out value='${result.surveySeq }'/>"/>
														<input type="hidden" name="surveyAnswList[<c:out value='${totCnt }'/>].surveyType" value="<c:out value='${result.surveyType }'/>"/>
														<input type="hidden" name="surveyAnswList[<c:out value='${totCnt }'/>].profCode" value="<c:out value='${prof.lectTea }'/>"/>
													</td>
												</tr>
										</tbody>
									</table>
								</div>
								<div class="list-table-box mb50-imp">
									<table class="normal-wmv-table">
										<colgroup>
											<col width="10%"/>
											<col width="45%"/>
											<col />
										</colgroup>
										<tbody>
											<c:if test="${result.surveyType eq '1' }">
												<tr>
													<th rowspan="5" class="answ">답변</th>
													<td class="txt-c">1)<c:out value="${result.answer1 }"/></td>
													<td class="txt-c"><input type="radio" name="surveyAnswList[<c:out value='${totCnt }'/>].answer" id="answer<c:out value='${totCnt }'/>_1" class="required radio" title="답변" value="5"/></td>
												</tr>
												<tr>
													<td class="txt-c">2)<c:out value="${result.answer2 }"/></td>
													<td class="txt-c"><input type="radio" name="surveyAnswList[<c:out value='${totCnt }'/>].answer" id="answer<c:out value='${totCnt }'/>_2" class="required radio" title="답변" value="4"/></td>
												</tr>
												<tr>
													<td class="txt-c">3)<c:out value="${result.answer3 }"/></td>
													<td class="txt-c"><input type="radio" name="surveyAnswList[<c:out value='${totCnt }'/>].answer" id="answer<c:out value='${totCnt }'/>_3" class="required radio" title="답변" value="3"/></td>
												</tr>
												<tr>
													<td class="txt-c">4)<c:out value="${result.answer4 }"/></td>
													<td class="txt-c"><input type="radio" name="surveyAnswList[<c:out value='${totCnt }'/>].answer" id="answer<c:out value='${totCnt }'/>_4" class="required radio" title="답변" value="2"/></td>
												</tr>
												<tr>
													<td class="txt-c">5)<c:out value="${result.answer5 }"/></td>
													<td class="txt-c"><input type="radio" name="surveyAnswList[<c:out value='${totCnt }'/>].answer" id="answer<c:out value='${totCnt }'/>_5" class="required radio" title="답변" value="1"/></td>
												</tr>
											</c:if>
											<c:if test="${result.surveyType eq '2' }">
												<c:if test="${result.answer1 ne '' }">
													<tr>
														<th rowspan="<c:out value="${result.answer5 ne ''?'5':result.answer4 ne ''?'4':result.answer3 ne ''?'3':result.answer2 ne ''?'2':result.answer1 ne ''?'1':'' }"/>">답변</th>
														<td><c:out value="${result.answer1 }"/></td>
														<td class="txt-c">
															<input type="radio" name="surveyAnswList[<c:out value='${totCnt }'/>].answer" id="answer<c:out value='${totCnt }'/>_1" class="required radio" title="답변" value="1"/>
														</td>
													</tr>
												</c:if>
												<c:if test="${result.answer2 ne '' }">
													<tr>
														<td><c:out value="${result.answer2 }"/></td>
														<td class="txt-c">
																<input type="radio" name="surveyAnswList[<c:out value='${totCnt }'/>].answer" id="answer<c:out value='${totCnt }'/>_2" class="required radio" title="답변" value="2"/>
														</td>
													</tr>
												</c:if>
												<c:if test="${result.answer3 ne '' }">
													<tr>
														<td><c:out value="${result.answer3 }"/></td>
														<td class="txt-c">
															<input type="radio" name="surveyAnswList[<c:out value='${totCnt }'/>].answer" id="answer<c:out value='${totCnt }'/>_3" class="required radio" title="답변" value="3"/>
														</td>
													</tr>
												</c:if>
												<c:if test="${result.answer4 ne '' }">
													<tr>
														<td><c:out value="${result.answer4 }"/></td>
														<td class="txt-c">
															<input type="radio" name="surveyAnswList[<c:out value='${totCnt }'/>].answer" id="answer<c:out value='${totCnt }'/>_4" class="required radio" title="답변" value="4"/>
														</td>
													</tr>
												</c:if>
												<c:if test="${result.answer5 ne '' }">
													<tr>
														<td><c:out value="${result.answer5 }"/></td>
														<td class="txt-c">
															<input type="radio" name="surveyAnswList[<c:out value='${totCnt }'/>].answer" id="answer<c:out value='${totCnt }'/>_5" class="required radio" title="답변" value="5"/>
														</td>
													</tr>
												</c:if>
											</c:if>
											<c:if test="${result.surveyType eq '3'}">
												<tr>
													<th class="answ">답변</th>
													<td colspan="3"><textarea class="w100pc required" rows="5" name="surveyAnswList[<c:out value='${totCnt }'/>].answerTxt" id="answerTxt<c:out value='${status.index }'/>" title="답변"></textarea></td>
												</tr>
											</c:if>
										</tbody>
									</table>
								</div>
								<c:set var="totCnt" value="${totCnt+1 }"/>
							</c:if>
						</c:forEach>
					</c:forEach>
				</form:form>
				<!-- table button -->
				<div class="table-button">
					<div class="btn-box">
						<button type="button" class="white btn-save" onclick="fn_save(); return false;">저장</button>
						<button type="button" class="white btn-cancel" onclick="fn_close();">취소</button>
					</div>
				</div>
				<!--// table button -->
			</div>
		</div>
	</div>
	<!--// contents -->
</body>
</html>