<%@page import="egovframework.rte.psl.dataaccess.util.EgovMap"%>
<%@page import="lcms.valueObject.UsrVO"%>
<%@page import="java.text.SimpleDateFormat"%>
<%@page import="java.util.*, java.text.*"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c"      uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="form"   uri="http://www.springframework.org/tags/form" %>
<%@ taglib prefix="ui"     uri="http://egovframework.gov/ctl/ui"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ taglib prefix="common" 	uri="/WEB-INF/tld/common.tld"%>
<!DOCTYPE html>
<html lang="ko">
<c:import url="/EgovPageLink.do?link=usr/inc/incHead"/>

<script>
	function fn_update(){
		$("#frm").attr("action", "<c:out value='${pageContext.request.contextPath}/usr/lec/clss/lecClssMeetUpdate.do'/>").submit();
	}
	
	function fn_submis(){
		if(confirm('해당 급별회의록을 제출하시겠습니까?\r\n제출 후에는 수정이 불가합니다.')){
			$.ajax({
				url: "<c:url value='/usr/lec/clss/lecClssMeetLogSubmis.do'/>"
				, type: "post"
				, data: "meetSeq="+$("#meetSeq").val()
				, dataType:"json"
				, success: function(data){
					alert(data.message);
					$("#frm").attr("action", "<c:out value='${pageContext.request.contextPath}/usr/lec/clss/lecClssMeetList.do'/>").submit();
				}, error: function(){
					alert("오류가 발생하였습니다.");
				}
			});
		}
	}
	
	function fn_copy(grade, lectSeq, week, cnt){
		if(confirm('현재까지 입력하신 내용이 모두 지워집니다.\r\n전주 내용을 복사하시겠습니까?')){
			$.ajax({
				url: "<c:url value='/usr/lec/clss/lecClssMeetProfCopy.do'/>"
				, type: "post"
				, data: "grade="+grade+"&lectSeq="+lectSeq+"&week="+week
				, dataType:"json"
				, success: function(data){
					var resultList = data.resultList;
					
					if(resultList != null){
						for(var i=0; i<resultList.length; i++){
							$("#monProfCode_"+cnt).val(resultList[i].monProfCode).change();
							$("#tueProfCode_"+cnt).val(resultList[i].tueProfCode);
							$("#wedProfCode_"+cnt).val(resultList[i].wedProfCode);
							$("#thuProfCode_"+cnt).val(resultList[i].thuProfCode);
							$("#friProfCode_"+cnt).val(resultList[i].friProfCode);
							cnt++;
						}
					}
					
					alert(data.message);
				}, error: function(){
					alert("오류가 발생하였습니다.");
				}
			});
		}
	}
</script>
<body>
<form:form commandName="meetLogVO" id="frm" name="frm" method="post">
	<form:hidden path="meetSeq"/>
	<form:hidden path="year"/>
	<form:hidden path="semester"/>
	<form:hidden path="week"/>
	<form:hidden path="grade"/>
	<form:hidden path="prog"/>
	<c:import url="/EgovPageLink.do?link=usr/inc/incTopnavLec"/>
	<!-- contents -->
	<div class="content-box">
		<div class="contents">
			<!-- left menu -->
			<c:import url="/EgovPageLink.do?link=usr/inc/incLeftmenuLec"/>
			<!--// left menu -->
			<div class="main-content">
				<div class="title-area">
					<p class="page-lv01">급별회의록</p>
					<div class="navi web"> <!-- 모바일 수정 -->
						<span class="icon-home">Home</span>
						<span>강의실</span>
						<span>수업</span>
						<span>급별회의록</span>
					</div>
				</div>
				<!-- table -->
				<div class="list-table-box web">
					<table class="normal-wmv-table">
						<colgroup>
							<col style="width:10%;" />
							<col />
							<col style="width:10%;" />
							<col />
							<col style="width:10%;" />
							<col />
						</colgroup>
						<tbody>
							<tr>
								<th>급</th>
								<td><c:out value="${weekMap.lectGrade }"/></td>
								<th>주차</th>
								<td><c:out value="${weekMap.week }"/></td>
								<th>일정</th>
								<td><c:out value="${weekMap.monday }"/> ~ <c:out value="${weekMap.friday }"/></td>
							</tr>
							<tr>
								<th>참가 교사</th>
								<td colspan="5"><form:input path="partProf" class="w100pc"/></td>
							</tr>
						</tbody>
					</table>
				</div>
				<p class="sub-title">수업 담당 교사</p>
				<c:forEach items="${lectList }" var="lect" varStatus="sts">
					<c:set value="${timeList.size()* sts.index }" var="cnt"/>
					<div class="btn-box">
						<button type="button" class="white" onclick="fn_copy('<c:out value="${lect.lectGrade }"/>', '<c:out value="${lect.lectSeq }"/>', '<c:out value="${weekMap.week }"/>', '<c:out value="${cnt }"/>'); return false;">전주 복사</button>
					</div>
					<p><<c:out value="${lect.lectGrade }"/>급<c:out value="${lect.lectDivi }"/>반></p>
					<div class="list-table-box web">
						<table class="normal-wmv-table">
							<colgroup>
								<col />
								<col />
								<col />
								<col />
								<col />
								<col />
							</colgroup>
							<tbody>
								<tr>
									<td class="backslash"><div>요일</div>교시</td>
									<td class="txt-c"><c:out value="${weekMap.monday } (월)"/></td>
									<td class="txt-c"><c:out value="${weekMap.tuesday } (화)"/></td>
									<td class="txt-c"><c:out value="${weekMap.wednesday } (수)"/></td>
									<td class="txt-c"><c:out value="${weekMap.thursday } (목)"/></td>
									<td class="txt-c"><c:out value="${weekMap.friday } (금)"/></td>
								</tr>
								<c:forEach items="${timeList }" var="time" varStatus="status">
								<input type="hidden" value="${meetLogVO.meetProfList[(status.index+cnt)].mprofSeq }" id="meetProfList[<c:out value='${status.index+cnt }'/>].mprofSeq" name="meetProfList[<c:out value='${status.index+cnt }'/>].mprofSeq"/>
								<input type="hidden" value="${lect.lectSeq }" id="meetProfList[<c:out value='${status.index+cnt }'/>].lectSeq" name="meetProfList[<c:out value='${status.index+cnt }'/>].lectSeq"/>
								<input type="hidden" value="${time.clstmCode }" id="meetProfList[<c:out value='${status.index+cnt }'/>].classNum" name="meetProfList[<c:out value='${status.index+cnt }'/>].classNum"/>
								<tr>
									<td class="txt-c"><c:out value="${time.clstmCode }교시"/></td>
									<td class="txt-c">
										<select class="w74pc" id="monProfCode_<c:out value='${status.index+cnt }'/>" name="meetProfList[<c:out value='${status.index+cnt }'/>].monProfCode">
											<c:forEach items="${profList }" var="prof">
												<c:if test="${lect.lectSeq eq prof.lectSeq }">
													<option value="<c:out value='${prof.lectTea }'/>" <c:out value="${prof.lectTea eq meetLogVO.meetProfList[(status.index+cnt)].monProfCode ?'selected':'' }"/>>
														<c:out value="${prof.name }"/>
													</option>
												</c:if>
											</c:forEach>
										</select>
									</td>
									<td class="txt-c">
										<select class="w74pc" id="tueProfCode_<c:out value='${status.index+cnt }'/>" name="meetProfList[<c:out value='${status.index+cnt }'/>].tueProfCode">
											<c:forEach items="${profList }" var="prof">
												<c:if test="${lect.lectSeq eq prof.lectSeq }">
													<option value="<c:out value='${prof.lectTea }'/>" <c:out value="${prof.lectTea eq meetLogVO.meetProfList[status.index+cnt].tueProfCode ?'selected':'' }"/>><c:out value="${prof.name }"/></option>
												</c:if>
											</c:forEach>
										</select>
									</td>
									<td class="txt-c">
										<select class="w74pc" id="wedProfCode_<c:out value='${status.index+cnt }'/>" name="meetProfList[<c:out value='${status.index+cnt }'/>].wedProfCode">
											<c:forEach items="${profList }" var="prof">
												<c:if test="${lect.lectSeq eq prof.lectSeq }">
													<option value="<c:out value='${prof.lectTea }'/>" <c:out value="${prof.lectTea eq meetLogVO.meetProfList[status.index+cnt].wedProfCode ?'selected':'' }"/>><c:out value="${prof.name }"/></option>
												</c:if>
											</c:forEach>
										</select>
									</td>
									<td class="txt-c">
										<select class="w74pc" id="thuProfCode_<c:out value='${status.index+cnt }'/>" name="meetProfList[<c:out value='${status.index+cnt }'/>].thuProfCode">
											<c:forEach items="${profList }" var="prof">
												<c:if test="${lect.lectSeq eq prof.lectSeq }">
													<option value="<c:out value='${prof.lectTea }'/>" <c:out value="${prof.lectTea eq meetLogVO.meetProfList[status.index+cnt].thuProfCode ?'selected':'' }"/>><c:out value="${prof.name }"/></option>
												</c:if>
											</c:forEach>
										</select>
									</td>
									<td class="txt-c">
										<select class="w74pc" id="friProfCode_<c:out value='${status.index+cnt }'/>" name="meetProfList[<c:out value='${status.index+cnt }'/>].friProfCode">
											<c:forEach items="${profList }" var="prof">
												<c:if test="${lect.lectSeq eq prof.lectSeq }">
													<option value="<c:out value='${prof.lectTea }'/>" <c:out value="${prof.lectTea eq meetLogVO.meetProfList[status.index+cnt].friProfCode ?'selected':'' }"/>><c:out value="${prof.name }"/></option>
												</c:if>
											</c:forEach>
										</select>
									</td>
								</tr>
								</c:forEach>
							</tbody>
						</table>
					</div>
				</c:forEach>
				<p class="sub-title">이번 주 수업 진행 상황</p>
				<div class="list-table-box web">
					<table class="normal-wmv-table">
						<colgroup>
							<col style="width:10%;" />
							<col />
						</colgroup>
						<tbody>
							<tr>
								<th></th>
								<th>문제점 및 특기사항</th>
							</tr>
							<tr>
								<th>교과</th>
								<td><form:textarea path="thisSubject" class="w100pc" rows="2"/></td>
							</tr>
							<tr>
								<th>학생 관리</th>
								<td><form:textarea path="thisStdMng" class="w100pc" rows="2"/></td>
							</tr>
							<tr>
								<th>기타</th>
								<td><form:textarea path="thisEtc" class="w100pc" rows="2"/></td>
							</tr>
						</tbody>
					</table>
				</div>
				<p class="sub-title">다음 주 수업 계획</p>
				<div class="list-table-box web">
					<table class="normal-wmv-table">
						<colgroup>
							<col style="width:10%;" />
							<col />
						</colgroup>
						<tbody>
							<tr>
								<th>교과</th>
								<td><form:textarea path="nextSubject" class="w100pc" rows="2"/></td>
							</tr>
							<tr>
								<th>학생 관리</th>
								<td><form:textarea path="nextStdMng" class="w100pc" rows="2"/></td>
							</tr>
							<tr>
								<th>기타</th>
								<td><form:textarea path="nextEtc" class="w100pc" rows="2"/></td>
							</tr>
						</tbody>
					</table>
				</div>
				<p class="sub-title">공지사항 및 교사 전달사항</p>
				<div class="list-table-box web">
					<table class="normal-wmv-table">
						<colgroup>
							<col />
						</colgroup>
						<tbody>
							<tr>
								<td><form:textarea path="notice" class="w100pc" rows="5"></form:textarea></td>
							</tr>
						</tbody>
					</table>
				</div>
				<!--// table -->
				<div class="mob mb20">
					<div class="mob-write">
						<dl>
							<dt><sup>*</sup>공지구분</dt>
							<dd>
								<ul>
									<li>
										<select id="lcnotiGubun" name="lcnotiGubun">
											<option value="전체" <c:if test="${lecClssNoticeVO.lcnotiGubun eq '전체'}"></c:if> >전체</option>
										</select>
									</li>
								</ul>
							</dd>
						</dl>
					</div>
				</div>
				<div class="table-button">
					<div class="btn-box">
						<a href="<c:out value='${pageContext.request.contextPath }/usr/lec/clss/lecClssMeetList.do'/>" class="white btn-list">목록</a>
						<c:if test="${meetLogVO.meetSeq ne '' && meetLogVO.meetSeq != null }">
							<button type="button" class="white btn-save" onclick="fn_submis(); return false;">제출</button>
						</c:if>
						<button type="button" class="white btn-save" onclick="fn_update(); return false;">저장</button>
					</div>
				</div>
			</div>
		</div>
		<div id="delAtt"></div>
	</div>
	<!--// contents -->
	<!-- footer -->
	<c:import url="/EgovPageLink.do?link=usr/inc/incFooter"/>
	<!--// footer -->

	<!-- 모바일 수정 -->
	<div class="black"></div>
	<!--// 모바일 수정 -->
</form:form>
</body>
</html>