<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c"      uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="form"   uri="http://www.springframework.org/tags/form" %>
<%@ taglib prefix="fmt"		uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="ui"     uri="http://egovframework.gov/ctl/ui"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ taglib prefix="common" 	uri="/WEB-INF/tld/common.tld"%>
<!DOCTYPE html>
<html lang="ko">
<c:import url="/EgovPageLink.do?link=adm/inc/incHead"/>
<script type="text/javascript">
	function fn_add(){
		var cnt = $(".answer-div").length;
		
		var html = '';
		
		html += '<div class="list-table-box answer-div">';
		html += '	<input type="hidden" name="surveyQuesList['+cnt+'].quesNum" value="'+cnt+'"/>';
		html += '	<table class="normal-wmv-table">';
		html += '		<colgroup>';
		html += '			<col style="width:10%;" />';
		html += '			<col />';
		html += '		</colgroup>';
		html += '		<tbody>';
		html += '			<tr>';
		html += '				<th><sup>*</sup>조사유형</th>';
		html += '				<td>';
		html += '					<select name="surveyQuesList['+cnt+'].phrSeq">';
		html += '						<c:forEach items="${quesPhrList }" var="quesPhr">';
		html += '							<option value="<c:out value="${quesPhr.phrSeq }"/>"><c:out value="${quesPhr.phrTitle }"/></option>';
		html += '						</c:forEach>';
		html += '					</select>';
		html += '				</td>';
		html += '			</tr>';
		html += '			<tr>';
		html += '				<th><sup>*</sup>조사유형</th>';
		html += '				<td>';
		html += '					<select name="surveyQuesList['+cnt+'].surveyType">';
		html += '						<option value="1">오점척도</option>';
		html += '						<option value="2">단답형</option>';
		html += '						<option value="3">자유기재형</option>';
		html += '					</select>';
		html += '				</td>';
		html += '			</tr>';
		html += '			<tr>';
		html += '				<th><sup>*</sup>질문</th>';
		html += '				<td>';
		html += '					<input type="text" class="w100pc" name="surveyQuesList['+cnt+'].question"/>';
		html += '				</td>';
		html += '			</tr>';
		html += '			<tr>';
		html += '				<th><sup>*</sup>답변</th>';
		html += '				<td id="answerList'+cnt+'">';
		html += '					<p class="file-upload" name="answer'+cnt+'">';
		html += '						<span>항목1</span>	<input type="text" class="input-data" name="surveyQuesList['+cnt+'].answer1"/> <button type="button" onclick="fn_addAnswer('+cnt+',1); return false;">+</button>';
		html += '					</p>';
		html += '				</td>';
		html += '			</tr>';
		html += '		</tbody>';
		html += '	</table>';
		html += '</div>';
		
		$("#ques").append(html);
	}
	
	function fn_addAnswer(cnt){
		var index = $("p[name=answer"+cnt+"]").length;
		if(index < 5){
			index++;
			var html = '<p class="file-upload" name="answer'+cnt+'" id="answer_p'+cnt+index+'"><span>항목'+index+'</span>	<input type="text" class="input-data" name="surveyQuesList['+cnt+'].answer'+index+'" id="answer'+cnt+index+'"/> <button type="button" onclick="fn_remove('+cnt+','+index+'); return false;">x</button></p>';
			$("#answerList"+cnt).append(html);
		}else{
			alert('질문은 최대 5개까지 추가하실 수 있습니다.');
			return;
		}
	}
	
	function fn_remove(cnt, idx){
		var index = $("p[name=answer"+cnt+"]").length;
		if(index != 1){
			for(i=idx; i<index; i++){
				$("#answer"+cnt+i).val($("#answer"+cnt+(i+1)).val());
			}
			$("#answer_p"+cnt+index).remove();
		}
	}
	
	function fn_save(){
		$("#content").val(CKEDITOR.instances.content.getData());
		$("#frm").attr("action", "<c:url value='/qxsepmny/curr/admSatisUpdate.do'/>").submit();
	}
</script>
<body>
    <c:import url="/EgovPageLink.do?link=adm/inc/incTopnav"/>
	<!-- contents -->
	<div class="content-box">
		<div class="contents">
			<c:import url="/EgovPageLink.do?link=adm/inc/incLeftmenu"/>
			<div class="main-content">
				<jsp:include page="/WEB-INF/jsp/lcms/adm/inc/incPageTitle.jsp">
					<jsp:param name="dept1" value="교육과정"/>
		            <jsp:param name="dept2" value="수업만족도항목"/>
	           	</jsp:include>
				<p class="sub-title">기본 정보</p>
				<!-- table -->
				<form:form commandName="surveyVO" id="frm" name="frm">
				<form:hidden path="surveySeq"/>
				<div class="list-table-box">
					<table class="normal-wmv-table">
						<colgroup>
							<col style="width:10%;" />
							<col />
							<col style="width:10%;" />
							<col style="width:20%;" />
						</colgroup>
						<tbody>
							<tr>
								<th><sup>*</sup>학기</th>
								<td>
									<form:select path="year">
										<form:options items="${yearList }"/>
									</form:select>
									<form:select path="seme">
										<c:forEach items="${semeList }" var="seme">
											<form:option value="${seme.semester }"><c:out value="${seme.semeNm }"/></form:option>
										</c:forEach>
									</form:select>
								</td>
								<th><sup>*</sup>Language</th>
								<td>
									<form:select path="lang">
										<form:option value="Korean">Korean</form:option>
										<form:option value="English">English</form:option>
										<form:option value="Chinese">Chinese</form:option>
										<form:option value="Mongolian">Mongolian</form:option>
										<form:option value="Japanese">Japanese</form:option>
										<form:option value="Vietnamese">Vietnamese</form:option>
									</form:select>
								</td>
							</tr>
							<tr>
								<th><sup>*</sup>조사제목</th>
								<td>
									<form:input path="title" class="input-data w100pc"/>
								</td>
								<th><sup>*</sup>게시여부</th>
								<td>
									<form:radiobutton path="useYn" value="Y"/> <label for="useYn1">게시</label> &nbsp;&nbsp;&nbsp;&nbsp;
									<form:radiobutton path="useYn" value="N"/> <label for="useYn2">게시 안함</label>
								</td>
							</tr>
							<tr>
								<th><sup>*</sup>조사내용</th>
								<td colspan="3">
									<form:textarea path="content"/>
									<script type="text/javascript">
										CKEDITOR.replace( 'content', {
											height: 300,
											filebrowserImageUploadUrl: "<c:url value='/cmmn/ckeditor/uploadCkeditorFile.do'/>"
										});
									</script>
								</td>
							</tr>
							<%-- <tr>
								<th><sup>*</sup>조사기간</th>
								<td colspan="3">
									<form:input path="stDate" class="input-data w100px" id="datepicker01" />&nbsp;&nbsp;
									<form:select path="stHour">
										<c:forEach begin="0" end="23" var="hour">
											<form:option value="${hour }">
												<c:out value='${hour }'/>
											</form:option>
										</c:forEach>
									</form:select> 시&nbsp;&nbsp;
									<form:select path="stMinu">
										<c:forEach begin="0" end="59" var="minute">
											<form:option value="${minute }">
												<c:out value='${minute }'/>
											</form:option>
										</c:forEach>
									</form:select> 분
									&nbsp;&nbsp;ㅡ&nbsp;&nbsp;
									<form:input path="edDate" class="input-data w100px" id="datepicker02" />&nbsp;&nbsp;
									<form:select path="edHour">
										<c:forEach begin="0" end="23" var="hour">
											<form:option value="${hour }">
												<c:out value='${hour }'/>
											</form:option>
										</c:forEach>
									</form:select> 시&nbsp;&nbsp;
									<form:select path="edMinu">
										<c:forEach begin="0" end="59" var="minute">
											<form:option value="${minute }">
												<c:out value='${minute }'/>
											</form:option>
										</c:forEach>
									</form:select> 분
								</td>
							</tr> --%>
						</tbody>
					</table>
				</div>
				<!--// table -->
				<!-- <div class="table-button">
					<div class="btn-box">
						<button type="button" class="white btn-save">질문추가</button>
					</div>
				</div> -->
				<p class="sub-title">조사항목 <button type="button" class="normal-btn" onclick="fn_add(); return false;">질문 추가 +</button></p>
				<!-- table -->
				<div id="ques">
					<c:forEach items="${surveyQuesList }" var="result" varStatus="status">
						<input type="hidden" name="surveyQuesList[<c:out value='${status.index }'/>].quesSeq" value="<c:out value='${result.quesSeq }'/>"/>
						<input type="hidden" name="surveyQuesList[<c:out value='${status.index }'/>].quesNum" value="<c:out value='${status.index }'/>"/>
						<div class="list-table-box">
							<table class="normal-wmv-table answer-div">
								<colgroup>
									<col style="width:10%;" />
									<col />
								</colgroup>
								<tbody>
									<tr>
										<th><sup>*</sup>조사유형</th>
										<td>
											<select name="surveyQuesList[<c:out value='${status.index }'/>].phrSeq">
												<c:forEach items="${quesPhrList }" var="quesPhr">
													<option value="<c:out value="${quesPhr.phrSeq }"/>" <c:out value="${quesPhr.phrSeq == result.phrSeq?'selected':''}"/>><c:out value="${quesPhr.phrTitle }"/></option>
												</c:forEach>
											</select>
										</td>
									</tr>
									<tr>
										<th><sup>*</sup>조사유형</th>
										<td>
											<select name="surveyQuesList[<c:out value='${status.index }'/>].surveyType">
												<option value="1" <c:out value="${result.surveyType == 1?'selected':''}"/>>오점척도</option>
												<option value="2" <c:out value="${result.surveyType == 2?'selected':''}"/>>단답형</option>
												<option value="3" <c:out value="${result.surveyType == 3?'selected':''}"/>>자유기재형</option>
											</select>
										</td>
									</tr>
									<tr>
										<th><sup>*</sup>질문</th>
										<td>
											<input type="text" class="w100pc" name="surveyQuesList[<c:out value='${status.index }'/>].question" value="<c:out value='${result.question }'/>"/>
										</td>
									</tr>
									<tr>
										<th><sup>*</sup>답변</th>
										<td id="answerList<c:out value='${status.index }'/>">
											<p class="file-upload" name="answer<c:out value='${status.index }'/>">
												<span>항목1</span>	<input type="text" class="input-data" name="surveyQuesList[<c:out value='${status.index }'/>].answer1" value="<c:out value='${result.answer1 }'/>"/> <button type="button">+</button>
											</p>
											<p class="file-upload" name="answer<c:out value='${status.index }'/>" id="answer_p<c:out value='${status.index }'/>2">
												<span>항목2</span>	<input type="text" class="input-data" name="surveyQuesList[<c:out value='${status.index }'/>].answer2" id="answer02" value="<c:out value='${result.answer2 }'/>"/> <button type="button">x</button>
											</p>
											<p class="file-upload" name="answer<c:out value='${status.index }'/>" id="answer_p<c:out value='${status.index }'/>3">
												<span>항목3</span>	<input type="text" class="input-data" name="surveyQuesList[<c:out value='${status.index }'/>].answer3" id="answer03" value="<c:out value='${result.answer3 }'/>"/> <button type="button">x</button>
											</p>
											<p class="file-upload" name="answer<c:out value='${status.index }'/>" id="answer_p<c:out value='${status.index }'/>4">
												<span>항목4</span>	<input type="text" class="input-data" name="surveyQuesList[<c:out value='${status.index }'/>].answer4" id="answer04" value="<c:out value='${result.answer4 }'/>"/> <button type="button">x</button>
											</p>
											<p class="file-upload" name="answer<c:out value='${status.index }'/>" id="answer_p<c:out value='${status.index }'/>5">
												<span>항목5</span>	<input type="text" class="input-data" name="surveyQuesList[<c:out value='${status.index }'/>].answer5" id="answer05" value="<c:out value='${result.answer5 }'/>"/> <button type="button">x</button>
											</p>
										</td>
									</tr>
								</tbody>
							</table>
						</div>
					</c:forEach>
					<c:if test="${surveyQuesList.size() == 0 || surveyQuesList == null }">
						<div class="list-table-box answer-div">
							<input type="hidden" name="surveyQuesList[0].quesNum" value="0"/>
							<table class="normal-wmv-table">
								<colgroup>
									<col style="width:10%;" />
									<col />
								</colgroup>
								<tbody>
									<tr>
										<th><sup>*</sup>조사유형</th>
										<td>
											<select name="surveyQuesList[0].phrSeq">
												<c:forEach items="${quesPhrList }" var="quesPhr">
													<option value="<c:out value="${quesPhr.phrSeq }"/>"><c:out value="${quesPhr.phrTitle }"/></option>
												</c:forEach>
											</select>
										</td>
									</tr>
									<tr>
										<th><sup>*</sup>조사유형</th>
										<td>
											<select name="surveyQuesList[0].surveyType">
												<option value="1">오점척도</option>
												<option value="2">단답형</option>
												<option value="3">자유기재형</option>
											</select>
										</td>
									</tr>
									<tr>
										<th><sup>*</sup>질문</th>
										<td>
											<input type="text" class="w100pc" name="surveyQuesList[0].question"/>
										</td>
									</tr>
									<tr>
										<th><sup>*</sup>답변</th>
										<td id="answerList0">
											<p class="file-upload" name="answer0">
												<span>항목1</span>	<input type="text" class="input-data" name="surveyQuesList[0].answer1"/> <button type="button" onclick="fn_addAnswer(0); return false;">+</button>
											</p>
										</td>
									</tr>
								</tbody>
							</table>
						</div>
					</c:if>
				</div>
				<!--// table -->
				</form:form>
				<div class="table-button">
					<div class="btn-box">
						<a href="<c:out value='${pageContext.request.contextPath }/qxsepmny/curr/admSatisList.do'/>" class="white btn-list">목록</a>
						<button type="button" class="white btn-save" onclick="fn_save(); return false;">저장</button>
					</div>
				</div>
			</div>
		</div>
	</div>
	<!--// contents -->
	<!-- footer -->
    <c:import url="/EgovPageLink.do?link=adm/inc/incFooter"/>
	<!--// footer -->
</body>
</html>