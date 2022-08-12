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
	function fn_add(num){
		var html = '';
		var svItem = document.getElementsByClassName('survey_info');
		var svLeng = svItem.length;

		html += '<div class="survey_info sv_div_'+svLeng+'">';
		html += '	<table class="tbl_view">';
		html += '		<colgroup>';
		html += '			<col style="width:15%" />';
		html += '			<col style="width:85%" />';
		html += '		</colgroup>';
		html += '		<tbody>';
		html += '			<tr>';
		html += '				<th scope="row">설문차수</th>';
		html += '				<td>';
		html += '					<select name="cr1000mVOList['+svLeng+'].svSeq" id="svSeq_'+svLeng+'" class="p10">';
		html += '						<option value="">선택</option>';
		<c:forEach begin="1" end="10" var="seq">
		html += '						<option value="<c:out value="${seq}"/>"><c:out value="${seq}"/></option>';
		</c:forEach>
		html += '					</select>';
		html += '					차';
		html += '					&nbsp;&nbsp;';
		html += '					<select name="cr1000mVOList['+svLeng+'].svCnt" id="svCnt_'+svLeng+'" class="p10">';
		html += '						<option value="">선택</option>';
		<c:forEach begin="1" end="10" var="cnt">
		html += '						<option value="<c:out value="${cnt}"/>"><c:out value="${cnt}"/></option>';
		</c:forEach>
		html += '					</select>';
		html += '					회';
		html += '				</td>';
		html += '			</tr>';
		html += '			<tr>';
		html += '				<th scope="row">템플릿 선택</th>';
		html += '				<td>';
		html += '					<select class="p20" id="tempType_'+svLeng+'" onchange="fn_temp(\''+svLeng+'\'); return false;">';
		html += '						<option>템플릿구분</option>';
		<c:forEach items="${typeList}" var="type">
		html += '						<option value="<c:out value="${type.cd}"/>"><c:out value="${type.cdName}"/></option>';
		</c:forEach>
		html += '					</select>';
		html += '					<select name="cr1000mVOList['+svLeng+'].tempNo" id="tempNo_'+svLeng+'" class="p40">';
		html += '						<option value="">템플릿명</option>';
		<c:forEach items="${tempList }" var="temp">
		html += '						<option value="<c:out value="${temp.tempNo}"/>"><c:out value="${temp.tempNm}"/></option>';
		</c:forEach>
		html += '					</select>';
		html += '				</td>';
		html += '			</tr>';
		html += '			<tr>';
		html += '				<th scope="row">설문명</th>';
		html += '				<td>';
		html += '					<input type="text" name="cr1000mVOList['+svLeng+'].title" id="title_'+svLeng+'" class="type02 ta_l" />';
		html += '				</td>';
		html += '			</tr>';
		html += '			<tr>';
		html += '				<th scope="row">조사내용</th>';
		html += '				<td>';
		html += '					<textarea name="cr1000mVOList['+svLeng+'].content" id="content_'+svLeng+'" class="type02"></textarea>';
		html += '				</td>';
		html += '			</tr>';
		html += '			<tr>';
		html += '				<th scope="row">참여기간</th>';
		html += '				<td>';
		html += '					<div class="date_sec">';
		html += '						<span>';
		html += '							<input type="text" name="cr1000mVOList['+svLeng+'].svStdt" id="datepicker'+svLeng+'1" class="date" readonly="true"/>';
		html += '							<label for="datepicker'+svLeng+'1" class="btn_cld">날짜검색</label>';
		html += '						</span>';
		html += '						<em>~</em>';
		html += '						<span>';
		html += '							<input type="text" name="cr1000mVOList['+svLeng+'].svEndt" id="datepicker'+svLeng+'2" class="date" readonly="true"/>';
		html += '							<label for="datepicker'+svLeng+'2" class="btn_cld">날짜검색</label>';
		html += '						</span>';
		html += '					</div>';
		html += '					<input type="checkbox" name="cr1000mVOList['+svLeng+'].mtCls" id="mtCls_'+svLeng+'" value="1"/>';
		html += '				    <label for="survey_01">방문 설문</label>';
		html += '				</td>';
		html += '			</tr>';
		html += '		</tbody>';
		html += '	</table>';
		html += '	<div class="sub_btn_area">';
		html += '		<a style="cursor:pointer;" onclick="fn_del('+svLeng+');">삭제</a>';
		html += '	</div>';
		html += '</div>';
		
		$("#survey_list").append(html);
		
		fn_date_picker('datepicker'+svLeng+'1');
		fn_date_picker('datepicker'+svLeng+'2');
	}
	
	function fn_del(num){
		var svItem = document.getElementsByClassName('sv_div_'+num);
		var svLeng = svItem.length-1;
		
		for(var i=num; i<svLeng; i++){
			$("#svSeq_"+i).val($("#svSeq_"+(i+1)).val());
			$("#svCnt_"+i).val($("#svCnt_"+(i+1)).val());
			$("#tempNo_"+i).val($("#tempNo_"+(i+1)).val());
			$("#title_"+i).val($("#title_"+(i+1)).val());
			$("#content_"+i).val($("#content_"+(i+1)).val());
			$("#datepicker"+i+"1").val($("#datepicker"+(i+1)+"1").val());
			$("#datepicker"+i+"2").val($("#datepicker"+(i+1)+"2").val());
		}
		
		svItem[svLeng].remove();
	}
	
	function fn_update(){
		$("#frm").attr("action", "<c:url value='/qxsepmny/ech0201/ech0201Update.do'/>").submit();
	}
	
	function fn_temp(num){
		var tempType = $("#tempType_"+num).val();
		var html = '<option>템플릿명</option>';
		if(tempType != ''){
			$.ajax({
				url: "<c:url value='/qxsepmny/ech0201/ajaxSelectTempList.do'/>"
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
	
	/* function fn_list(){
		location.href = "<c:out value='${pageContext.request.contextPath }/qxsepmny/ech0201/ech0201List.do'/>";
	} */
	
	//목록으로
	function fn_list(){
		$("#frm2").attr("action", "<c:url value='/qxsepmny/ech0201/ech0201List.do'/>").submit();
	}
	$(document).ready(function(){
		
		$('#tempNo_0').click(function(){
			var tempType = $("#tempType_0").val();
			if(tempType != '1020' && tempType != '1010'){
				alert("템플릿구분을 먼저 선택해주세요.")
			}
		})
		
	})
</script>
<body>
<!-- wrap -->
<div class="wrap">
	<c:import url="/EgovPageLink.do?link=adm/inc/incTopnav"/>
	<!-- 검색조건유지 설정 -->
    <form:form commandName="searchVO" id="frm2" name="frm2">
    	<form:hidden path="searchCondition1"/>
    	<form:hidden path="searchCondition2"/>
    	<form:hidden path="searchCondition3"/>
    	<form:hidden path="searchCondition4"/>
    	<form:hidden path="searchCondition5"/>
    	<form:hidden path="searchCondition6"/>
    	<form:hidden path="searchCondition7"/>
    	<form:hidden path="searchCondition8"/>
    	<form:hidden path="searchYear"/>
    	<form:hidden path="searchWord"/>
    </form:form>
    <!-- //검색조건유지 설정 -->
	<form:form commandName="rs1000mVO" id="frm" name="frm" method="post">
		<form:hidden path="rsNo"/>
		<!-- container -->
		<div class="container">
			<h2>유효성설문관리</h2>
			<!-- contents -->
			<div class="contents">
				<!-- 타이틀 -->
				<jsp:include page="/WEB-INF/jsp/ctms/adm/inc/incPageTitle.jsp">
					<jsp:param name="dept1" value="eCRF관리"/>
		            <jsp:param name="dept2" value="유효성설문관리"/>
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
					<a href="#" class="type02" onclick="fn_list(); return false;">취소</a>
					<a href="#" onclick="fn_update(); return false;">저장</a>
				</div>
				<!-- //버튼 -->
				<div id="survey_list">
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
													<form:select path="cr1000mVOList[${status.index }].svSeq" id="svSeq_${status.index }" class="p10">
														<form:option value="">선택</form:option>
														<c:forEach begin="1" end="10" var="seq">
															<form:option value="${seq }" selected="${eCRF.svSeq eq seq?'selected':'' }"><c:out value="${seq }"/></form:option>
														</c:forEach>
													</form:select>
													차
													&nbsp;&nbsp;
													<form:select path="cr1000mVOList[${status.index }].svCnt" id="svCnt_${status.index }" class="p10">
														<form:option value="">선택</form:option>
														<c:forEach begin="1" end="10" var="cnt">
															<form:option value="${cnt }" selected="${eCRF.svCnt eq cnt?'selected':'' }"><c:out value="${cnt }"/></form:option>
														</c:forEach>
													</form:select>
													회
												</td>
											</tr>					
											<tr>
												<th scope="row">템플릿 선택</th>
												<td>
													<%-- <select class="p20" id="tempType_<c:out value='${status.index }'/>" onchange="fn_temp('<c:out value='${status.index }'/>'); return false;">
														<option>템플릿구분</option>
														<c:forEach items="${typeList}" var="type">
															<option value="<c:out value='${type.cd }'/>"><c:out value="${type.cdName }"/></option>
														</c:forEach>
													</select> --%>
													<form:select path="cr1000mVOList[${status.index }].tempType" class="p20" id="tempType_${status.index }" onchange="fn_temp('${status.index} ');">
														<form:option value="">템플릿구분</form:option>
														<%-- <c:forEach items="${typeList}" var="type">
															<form:option value="${type.cd }" selected="${type.cd eq eCRF.tempType?'selected':'' }"><c:out value="${type.cdName }"/></form:option>
														</c:forEach> --%>
														<form:option value="${typeList[0].cd }" selected="${typeList[0].cd eq eCRF.tempType?'selected':'' }"><c:out value="${typeList[0].cdName }"/></form:option>
														<form:option value="${typeList[1].cd }" selected="${typeList[1].cd eq eCRF.tempType?'selected':'' }"><c:out value="${typeList[1].cdName }"/></form:option>
														
													</form:select>
													<form:select path="cr1000mVOList[${status.index }].tempNo" id="tempNo_${status.index }"  class="p40">
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
									<div class="sub_btn_area">
										<a style="cursor:pointer;" onclick="fn_del(<c:out value='${status.index }'/>);">삭제</a>
									</div>
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
												<form:select path="cr1000mVOList[0].svSeq" id="svSeq_0" class="p10">
													<form:option value="">선택</form:option>
													<c:forEach begin="1" end="10" var="seq">
														<form:option value="${seq }"><c:out value="${seq }"/></form:option>
													</c:forEach>
												</form:select>
												차
												&nbsp;&nbsp;
												<form:select path="cr1000mVOList[0].svCnt" id="svCnt_0" class="p10">
													<form:option value="">선택</form:option>
													<c:forEach begin="1" end="10" var="cnt">
														<form:option value="${cnt }"><c:out value="${cnt }"/></form:option>
													</c:forEach>
												</form:select>
												회
											</td>
										</tr>					
										<tr>
											<th scope="row">템플릿 선택</th>
											<td>
												<select class="p20" id="tempType_0" onchange="fn_temp(0);">
													<option>템플릿구분</option>
													<option value="${typeList[0].cd }" ><c:out value="${typeList[0].cdName }"/></option>
													<option value="${typeList[1].cd }" ><c:out value="${typeList[1].cdName }"/></option>
													<%-- <c:forEach items="${typeList}" var="type">
														<option value="<c:out value='${type.cd }'/>"><c:out value="${type.cdName }"/></option>
													</c:forEach> --%>
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
								<div class="sub_btn_area">
									<a style="cursor:pointer;" onclick="fn_del(0);">삭제</a>
								</div>
								<!-- //삭제버튼 -->
							</div>
							<!-- //설문지 정보 -->
						</c:otherwise>
					</c:choose>
				</div>
				<!-- 설문지 추가 버튼 -->
				<a style="cursor:pointer;" onclick="fn_add();" class="btm_btn">설문지 추가 +</a>
				<!-- //설문지 추가 버튼 -->
			</div>
			<!-- //contents -->
		</div>
		<!-- //container -->
	</form:form>
</div>	
<!-- //wrap -->
</body>
</html>