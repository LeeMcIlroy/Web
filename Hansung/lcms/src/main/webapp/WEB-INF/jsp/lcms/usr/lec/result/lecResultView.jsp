<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c"      uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="form"   uri="http://www.springframework.org/tags/form" %>
<%@ taglib prefix="ui"     uri="http://egovframework.gov/ctl/ui"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ taglib prefix="common" 	uri="/WEB-INF/tld/common.tld"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<!DOCTYPE html>
<html lang="ko">
<c:import url="/EgovPageLink.do?link=usr/inc/incHead"/>

<script type="text/javascript">

	function fn_view(){
		$("#frm").attr("action", "<c:url value='/usr/lec/result/lecResultView.do'/>").submit();
	}
	
	function fn_avg(idx){
		var speak = Number($("input[name='gradeList["+idx+"].gradeExprSpeak']").val());
		var write = Number($("input[name='gradeList["+idx+"].gradeExprWrite']").val());
		var listen = Number($("input[name='gradeList["+idx+"].gradeCompListen']").val());
		var read = Number($("input[name='gradeList["+idx+"].gradeCompRead']").val());
		var avg = Math.round((speak+write+listen+read)/4);
		
		$("#avg"+idx).html(avg);
	}

	function fn_save(){
		$("#frm").attr("action", "<c:url value='/usr/lec/result/lecResultUpdate.do'/>").submit();
	}
	
</script>
<body>
	<c:import url="/EgovPageLink.do?link=usr/inc/incTopnavLec"/>
	<!-- contents -->
	<div class="content-box">
		<div class="contents">
			<!-- left menu -->
			<c:import url="/EgovPageLink.do?link=usr/inc/incLeftmenuLec"/>
			<!--// left menu -->
			<div class="main-content">
				<div class="title-area">
					<p class="page-lv01">성적</p>
					<div class="navi web"> <!-- 모바일 수정 -->
						<span class="icon-home">Home</span>
						<span>강의실</span>
						<span>성적</span>
					</div>
				</div>
				<form:form commandName="gradeVO" id="frm" name="frm">
					<p class="sub-title">대상성적</p>
					<!-- table -->
					<div class="list-table-box web">
						<table class="normal-wmv-table">
							<colgroup>
								<col style="width:12%;" />
								<col style="width:12%;" />
								<col style="width:13%;" />
								<col style="width:12%;" />
								<col style="width:13%;" />
								<col style="width:12%;" />
								<col />
							</colgroup>
							<tbody>
								<tr>
									<th><sup>*</sup>학기</th>
									<td colspan="2">
										<form:select path="semYear" onchange="fn_search_seme(this); return false;">
											<form:option value="${semester.semYear }"/>
											<!-- <option>2019</option> -->
										</form:select>
										<form:select path="semEster">
											<form:option value="${semester.semester }"><c:out value="${semester.semeNm }"/></form:option>
										</form:select>
									</td>
									<th><sup>*</sup>시험구분</th>
									<td colspan="3">
										<form:select path="gradeGubun" onchange="fn_view(); return false;">
											<form:option value="1">중간시험</form:option>
											<form:option value="2">기말시험</form:option>
										</form:select>
									</td>
								</tr>
							</tbody>
						</table>
					</div>
					<div class="list-table-box mob w100pc">
						<table class="normal-wmv-table">
							<colgroup>
								<col style="width:12%;" />
								<col />
							</colgroup>
							<tbody>
								<tr>
									<th><sup>*</sup>학기</th>
									<td>
										<form:select path="semYear" onchange="fn_search_seme(this); return false;">
											<form:options items="${yearList }"/>
											<!-- <option>2019</option> -->
										</form:select>
										<form:select path="semEster">
											<c:forEach items="${semeList }" var="seme">
											<form:option value="${seme.semester }"><c:out value="${seme.semeNm }"/></form:option>
											</c:forEach>
										</form:select>
										<form:select path="gradeGubun" onchange="fn_view(); return false;">
											<form:option value="1">중간시험</form:option>
											<form:option value="2">기말시험</form:option>
										</form:select>
									</td>
								</tr>
							</tbody>
						</table>
					</div>
					<div class="list-table-box web">
						<table class="normal-list-table">
							<colgroup>
								<col style="width:12%;" />
								<col style="width:12%;" />
								<col style="width:39%;" />
								<col style="width:8%;" />
								<col style="width:8%;" />
								<col style="width:8%;" />
								<col style="width:8%;" />
								<col style="width:15%;" />
							</colgroup>
							<thead>
								<tr>
									<th rowspan="2">No.</th>
									<th rowspan="2">학번</th>
									<th rowspan="2">이름</th>
									<th colspan="2">표현능력</th>
									<th colspan="2">이행능력</th>
									<th rowspan="2">평균</th>
								</tr>
								<tr>
									<th>말하기</th>
									<th>쓰기</th>
									<th>듣기</th>
									<th>읽기</th>
								</tr>
							</thead>
							<tbody>
								<c:forEach items="${resultList }" var="result" varStatus="status">
								<tr onkeyup="fn_avg(<c:out value='${status.index }'/>); return false;">
									<td>
										<c:out value="${resultList.size() - status.index }"/>
										<input type="hidden" name="gradeList[<c:out value='${status.index }'/>].gradeSeq" value="<c:out value='${result.gradeSeq }'/>"/>
									</td>
									<td>
										<c:out value="${result.memberCode }"/>
										<input type="hidden" name="gradeList[<c:out value='${status.index }'/>].memberCode" value="<c:out value="${result.memberCode }"/>"/>
									</td>
									<td><c:out value="${result.name }"/></td>
									<td><input type="number" name="gradeList[<c:out value='${status.index }'/>].gradeExprSpeak" value="<c:out value='${result.gradeExprSpeak }'/>"/></td>
									<td><input type="number" name="gradeList[<c:out value='${status.index }'/>].gradeExprWrite" value="<c:out value='${result.gradeExprWrite }'/>"/></td>
									<td><input type="number" name="gradeList[<c:out value='${status.index }'/>].gradeCompListen" value="<c:out value='${result.gradeCompListen }'/>"/></td>
									<td><input type="number" name="gradeList[<c:out value='${status.index }'/>].gradeCompRead" value="<c:out value='${result.gradeCompRead }'/>"/></td>
									<td id="avg<c:out value='${status.index }'/>"><c:out value="${result.gradeAvg }"/></td>
								</tr>
								</c:forEach>
							</tbody>
						</table>
						<p>* 성적을 입력하고 반드시 '저장' 버튼을 눌러주세요.</p>
					</div>
					<div class="list-table-box mob w100pc">
						<table class="normal-list-table">
							<colgroup>
								<col style="width:5%;" />
								<col />
								<col />
								<col style="width:8%;" />
								<col style="width:8%;" />
								<col style="width:8%;" />
								<col style="width:8%;" />
								<col />
							</colgroup>
							<thead>
								<tr>
									<th rowspan="2">No.</th>
									<th rowspan="2">학번</th>
									<th rowspan="2">이름</th>
									<th colspan="2">표현능력</th>
									<th colspan="2">이행능력</th>
									<th rowspan="2">평균</th>
								</tr>
								<tr>
									<th>말하기</th>
									<th>쓰기</th>
									<th>듣기</th>
									<th>읽기</th>
								</tr>
							</thead>
							<tbody>
								<c:forEach items="${resultList }" var="result" varStatus="status">
								<tr onkeyup="fn_avg(<c:out value='${status.index }'/>); return false;">
									<td>
										<c:out value="${resultList.size() - status.index }"/>
										<input type="hidden" name="gradeList[<c:out value='${status.index }'/>].gradeSeq" value="<c:out value='${result.gradeSeq }'/>"/>
									</td>
									<td>
										<c:out value="${result.memberCode }"/>
										<input type="hidden" name="gradeList[<c:out value='${status.index }'/>].memberCode" value="<c:out value="${result.memberCode }"/>"/>
									</td>
									<td><c:out value="${result.name }"/></td>
									<td><input type="number" class="w50px" name="gradeList[<c:out value='${status.index }'/>].gradeExprSpeak" value="<c:out value='${result.gradeExprSpeak }'/>"/></td>
									<td><input type="number" class="w50px" name="gradeList[<c:out value='${status.index }'/>].gradeExprWrite" value="<c:out value='${result.gradeExprWrite }'/>"/></td>
									<td><input type="number" class="w50px" name="gradeList[<c:out value='${status.index }'/>].gradeCompListen" value="<c:out value='${result.gradeCompListen }'/>"/></td>
									<td><input type="number" class="w50px" name="gradeList[<c:out value='${status.index }'/>].gradeCompRead" value="<c:out value='${result.gradeCompRead }'/>"/></td>
									<td id="avg<c:out value='${status.index }'/>"><c:out value="${result.gradeAvg }"/></td>
								</tr>
								</c:forEach>
							</tbody>
						</table>
						<p>* 성적을 입력하고 반드시 '저장' 버튼을 눌러주세요.</p>
					</div>
					<!-- table button -->
					<div class="table-button">
						<div class="btn-box">
							<a href="<c:out value='${pageContext.request.contextPath }/usr/lec/result/lecResultList.do'/>" class="white btn-list">목록</a>
							<c:set var="now" value="<%=new java.util.Date()%>" />
							<c:set var="nowDate"><fmt:formatDate value="${now}" pattern="yyyyMMdd" /></c:set>
							<c:if test="${lecSession.gradeYn ne 'Y' && fn:replace(semester.gradeS, '-', '') <= nowDate && fn:replace(semester.gradeE, '-', '') >= nowDate }">
								<button type="button" class="white btn-save" onclick="fn_save(); return false;">저장</button>
							</c:if>
						</div>
					</div>
					<!--// table button -->
				</form:form>
			</div>
		</div>
	</div>
	<!--// contents -->
	<!-- footer -->
	<c:import url="/EgovPageLink.do?link=usr/inc/incFooter"/>
	<!--// footer -->

	<!-- 모바일 수정 -->
	<div class="black"></div>
	<!--// 모바일 수정 -->

</body>
</html>