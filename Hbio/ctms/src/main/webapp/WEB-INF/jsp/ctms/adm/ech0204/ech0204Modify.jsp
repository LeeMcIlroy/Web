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
	function fn_update(){
		$("#frm").attr("action", "<c:url value='/qxsepmny/ech0204/ech0204Update.do'/>").submit();
	}

	function fn_temp(num){
		
		var tempType = $("#tempType_"+num).val();
		var html = '<option>템플릿명</option>';
		if(tempType != ''){
			$.ajax({
				url: "<c:url value='/qxsepmny/ech0204/ajaxSelectTempList.do'/>"
				, type: "post"
				, data: "tempType="+tempType
				, dataType:"json"
				, success: function(data){
					var tempList = data.tempList;
					
					for(var i=0; i<tempList.length; i++){
						html += '<option value="'+tempList[i].tempNo+'">'+tempList[i].tempNm+'</option>';
					}
					
					$("#tempNo_"+num).html(html);
				}, error: function(){
					alert("오류가 발생하였습니다.");
				}
			});
		}else{
			$("#tempNo_"+num).html(html);
		}
	}
	$(document).ready(function(){
		
		$('#tempNo_0').click(function(){
			var tempType = $("#tempType_0").val();
			if(tempType != '1030'){
				alert("템플릿구분을 먼저 선택해주세요.")
			}
		})
		
	})
	
</script>
<body>
<!-- wrap -->
<div class="wrap">
	<c:import url="/EgovPageLink.do?link=adm/inc/incTopnav"/>
	<form:form commandName="rs1000mVO" id="frm" name="frm" method="post">
		<form:hidden path="rsNo"/>
		<!-- container -->
		<div class="container">
			<h2>eCRF관리</h2>
			<!-- contents -->
			<div class="contents">
				<!-- 타이틀 -->
				<jsp:include page="/WEB-INF/jsp/ctms/adm/inc/incPageTitle.jsp">
					<jsp:param name="dept1" value="eCRF관리"/>
		            <jsp:param name="dept2" value="피부특성관리"/>
	           	</jsp:include>
				<!-- //타이틀 -->
				<!-- 서브타이틀 -->
				<div class="sub_title_area type02">
					<h4>기본정보</h4>
				</div>
				<!-- //서브타이틀 -->
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
							<th scope="row">연구코드</th>
							<td><c:out value="${rs1000mVO.rsCd }"/></td>
							<th scope="row" class="bl">연구명</th>
							<td><c:out value="${rs1000mVO.rsName }"/></td>
						</tr>
						<tr>
							<th scope="row">eCRF상태</th>
							<td colspan="3">
								<c:forEach items="${stateList }" var="state" varStatus="status">
									<form:radiobutton path="ecrfState" id="ecrfState_${status.count }" value="${state.cd }"/>
								    <label for="ecrfState_${status.count }"><c:out value="${state.cdName }"/></label>
							    </c:forEach>
							</td>
						</tr>
					</tbody>
				</table>
				<!-- //기본정보 -->
	            <!-- 버튼 -->
				<div class="btn_area">
					<a href="#" class="type02" onclick="javascript:history.back();">취소</a>
					<a href="#" onclick="fn_update(); return false;">저장</a>
				</div>
				<!-- //버튼 -->
				<!-- 피부특성관리 정보 -->
				<c:choose>
					<c:when test="${eCrfList != null && eCrfList.size() != 0 }">
						<c:forEach items="${eCrfList }" var="eCRF" varStatus="status">
							<!-- 설문지 정보 -->
							<div class="survey_info sv_div_<c:out value='${status.index }'/>">
								<table class="tbl_view">
									<colgroup>
										<col style="width:15%" />
										<col style="width:85%" />
									</colgroup>
									<tbody>
										<tr>
											<th scope="row">설문차수</th>
											<td>
												피부특성관리
												<form:hidden path="cr1000mVOList[${status.index }].svSeq" value="${eCRF.svSeq }"/>
												<form:hidden path="cr1000mVOList[${status.index }].svCnt" value="${eCRF.svCnt }"/>
											</td>
										</tr>					
										<tr>
											<th scope="row">템플릿 선택</th>
											<td>
												<select class="p20" id="tempType_<c:out value='${status.index }'/>" onchange="fn_temp('<c:out value='${status.index }'/>'); return false;">
													<option>템플릿구분</option>
														<option value="<c:out value='${typeList[2].cd }'/>"><c:out value="${typeList[2].cdName }"/></option>
													
													<%-- <c:forEach items="${typeList}" var="type">
														<option value="<c:out value='${type.cd }'/>"><c:out value="${type.cdName }"/></option>
													</c:forEach> --%>
												</select>
												<form:select path="cr1000mVOList[${status.index }].tempNo" id="tempNo_${status.index }" class="p40">
													<form:option value="">템플릿명</form:option>
													<c:forEach items="${tempList }" var="temp">
														<form:option value="${temp.tempNo }" selected="${temp.tempNo eq eCRF.tempNo?'selected':'' }"><c:out value="${temp.tempNm }"/></form:option>
													</c:forEach>
												</form:select>
											</td>
										</tr>
										<tr>
											<th scope="row">설문명</th>
											<td>
												<form:input path="cr1000mVOList[${status.index }].title" id="title_${status.index }" value="${eCRF.title }" class="type02 ta_l" />
											</td>
										</tr>
										<tr>
											<th scope="row">조사내용</th>
											<td>
												<form:textarea path="cr1000mVOList[${status.index }].content" id="content_${status.index }" class="type02"/>
												<script type="text/javascript">
													$("#content_<c:out value='${status.index}'/>").val('<c:out value="${eCRF.content }"/>');
												</script>
											</td>
										</tr>
										<tr>
											<th scope="row">참여기간</th>
											<td>
												<div class="date_sec">
													<span>
														<form:input path="cr1000mVOList[${status.index }].svStdt" id="datepicker${status.index }1" value="${eCRF.svStdt }" class="date" readonly="true"/>
														<label for="datepicker<c:out value='${status.index }'/>1" class="btn_cld">날짜검색</label>
													</span>
													<em>~</em>
													<span>
														<form:input path="cr1000mVOList[${status.index }].svEndt" id="datepicker${status.index }2" value="${eCRF.svEndt }" class="date" readonly="true"/>
														<label for="datepicker<c:out value='${status.index }'/>2" class="btn_cld">날짜검색</label>
													</span>
													<script type="text/javascript">
														fn_date_picker('datepicker<c:out value="${status.index }"/>1');
														fn_date_picker('datepicker<c:out value="${status.index }"/>2');
													</script>
												</div>
												<form:checkbox path="cr1000mVOList[${status.index }].mtCls" id="mtCls_${status.index }" checked="${eCRF.mtCls eq '1'?'checked':'' }" value="1"/>
											    <label for="mtCls_<c:out value='${status.index }'/>">방문 설문</label>
											</td>
										</tr>
									</tbody>
								</table>
								<!-- 삭제버튼 -->
								<%-- <div class="sub_btn_area">
									<a style="cursor:pointer;" onclick="fn_del(<c:out value='${status.index }'/>);">삭제</a>
								</div> --%>
								<!-- //삭제버튼 -->
							</div>
							<!-- //설문지 정보 -->
						</c:forEach>
					</c:when>
					<c:otherwise>
						<!-- 설문지 정보 -->
						<div class="survey_info sv_div_0">
							<table class="tbl_view">
								<colgroup>
									<col style="width:15%" />
									<col style="width:85%" />
								</colgroup>
								<tbody>
									<tr>
										<th scope="row">설문차수</th>
										<td>
											피부특성관리
											<form:hidden path="cr1000mVOList[0].svSeq" value="0"/>
											<form:hidden path="cr1000mVOList[0].svCnt" value="0"/>
										</td>
									</tr>					
									<tr>
										<th scope="row">템플릿 선택</th>
										<td>
											<select class="p20" id="tempType_0" onchange="fn_temp('0'); return false;">
												<option>템플릿구분</option>
											<%--  	<c:forEach items="${typeList}" var="type">
													<option value="<c:out value='${type.cd }'/>"><c:out value="${type.cdName }"/></option>
												</c:forEach> --%>
											  <option value="<c:out value='${typeList[2].cd }'/>"><c:out value="${typeList[2].cdName }"/></option>
											</select>
											<form:select path="cr1000mVOList[0].tempNo" id="tempNo_0" class="p40">
												<form:option value="">템플릿명</form:option>
												
												
													 <c:forEach items="${tempList }" var="temp">
													 
														<form:option value="${temp.tempNo }"><c:out value="${temp.tempNm }"/></form:option>
													</c:forEach> 
													
											
											</form:select>
										</td>
									</tr>
									<tr>
										<th scope="row">설문명</th>
										<td>
											<form:input path="cr1000mVOList[0].title" id="title_0" class="type02 ta_l" />
										</td>
									</tr>
									<tr>
										<th scope="row">조사내용</th>
										<td>
											<form:textarea path="cr1000mVOList[0].content" id="content_0" class="type02"/>
										</td>
									</tr>
									<tr>
										<th scope="row">참여기간</th>
										<td>
											<div class="date_sec">
												<span>
													<form:input path="cr1000mVOList[0].svStdt" id="datepicker01" class="date" readonly="true"/>
													<label for="datepicker01" class="btn_cld">날짜검색</label>
												</span>
												<em>~</em>
												<span>
													<form:input path="cr1000mVOList[0].svEndt" id="datepicker02" class="date" readonly="true"/>
													<label for="datepicker02" class="btn_cld">날짜검색</label>
												</span>
											</div>
											<form:checkbox path="cr1000mVOList[0].mtCls" id="mtCls_0" value="1"/>
										    <label for="mtCls_0">방문 설문</label>
										</td>
									</tr>
								</tbody>
							</table>
							<!-- 삭제버튼 -->
							<!-- <div class="sub_btn_area">
								<a style="cursor:pointer;" onclick="fn_del(0);">삭제</a>
							</div> -->
							<!-- //삭제버튼 -->
						</div>
						<!-- //설문지 정보 -->
					</c:otherwise>
				</c:choose>
				<!-- //피부특성관리 정보 -->
			</div>
			<!-- //contents -->
		</div>
		<!-- //container -->
	</form:form>
</div>	
<!-- //wrap -->
</body>
</html>