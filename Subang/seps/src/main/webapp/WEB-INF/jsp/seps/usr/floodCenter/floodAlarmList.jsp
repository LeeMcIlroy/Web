<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c"      uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="form"   uri="http://www.springframework.org/tags/form" %>
<%@ taglib prefix="ui"     uri="http://egovframework.gov/ctl/ui"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ taglib prefix="common" 	uri="/WEB-INF/tld/common.tld"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<!doctype html>
<html lang="kr">
<c:import url="/EgovPageLink.do?link=inc/incHead" />
<body class="sub_page">
<form:form commandName="searchVO" id="frm" name="frm">
<!-- top menu - start -->
<c:import url="${pageContext.request.contextPath }/EgovPageLink.do?link=usr/inc/incTopnav"/>
<!-- top menu - end -->
	<div class="m_body" >
		<!-- left menu - start -->
		<c:import url="${pageContext.request.contextPath }/EgovPageLink.do?link=usr/inc/incLeftnav"/>
		<!-- left menu - end -->
		<div class="main_content">
			<div class="content">
				<div class="m_title">
					<div class="title">기간별알람현황</div>
					<div class="navi">
						<ul>
							<li>HOME</li>
							<li>수방매뉴얼</li>
							<li>기간별알람현황</li>
						</ul>
					</div>
				</div>
				<fieldset>
					<legend>검색하기</legend>
					<div class="top_sh_box">
						<div class="sh_box">
							<dl>
								<dt>대상</dt>
								<dd>
									<form:select path="searchCondition1" style="text-indent:0;" class="select_box">
										<form:option value="">전체</form:option>
										<form:option value="wl">수위</form:option>
										<form:option value="FC">수방단계</form:option>
										<form:option value="K">SNS공유</form:option>
										<form:option value="D">수방근무현황</form:option>
										<form:option value="NC">특보코드</form:option>
									</form:select>
								</dd>
							</dl>
							<dl>
								<dt></dt>
								<dd>
									<form:input path="startDate" class="start_day input_date" autocomplete="off"/>
									&nbsp;~&nbsp;
									<form:input path="endDate" class="finish_day input_date" autocomplete="off"/>
								</dd>
							</dl>
						</div>
						<div class="btn_sh"><button onclick="fn_list(1); return false;">검색</button></div>
						<div class="excel"><a href="#" onclick="fn_excelDownload(); return false;"><img src="<c:out value='${pageContext.request.contextPath}/assets/img/excel_icon.png'/>" alt="엑셀파일 다운로드" /></a></div>
					</div>
				</fieldset>
				<div class="cont_box ptb_50">
					<div class="transform_table notice_type2">
						<ul class="tbl_th">
							<li>구분</li>
							<li>알람내용</li>
							<li>발생일시</li>
						</ul>
						<div class="tbl_td2">
							<c:forEach items="${resultList }" var="result" varStatus="status">
								<ul>
									<li class="tbl_ntc">
										<span>
											<c:choose>
												<c:when test="${result.tType == 'fa' }">${fn:split(result.content, ' ')[0]}</c:when>											
												<c:when test="${result.tType == 'FC' }">수방단계</c:when>
												<c:when test="${result.tType == 'wl' }">수위</c:when>
												<c:when test="${result.tType == 'K' }">SNS공유</c:when>
												<c:when test="${result.tType == 'D' }">수방근무현황</c:when>
												<c:when test="${result.tType == 'NC' }">특보코드</c:when>
											</c:choose>
										</span>
									</li>
									<li class="txt_left">
										<c:choose>
											<c:when test="${result.tType == 'fa' }"><c:out value="${result.content }"/></c:when>									
											<c:when test="${result.tType == 'FC' }"><c:out value="${result.content }"/> <c:out value="${result.issueDate } ${result.issueTime }"/> 발령</c:when>
											<c:when test="${result.tType == 'wl' }"><c:out value="${result.content }"/></c:when>
											<c:when test="${result.tType == 'K' }"><c:out value="${result.title }"/> <c:out value="${result.content }"/></c:when>
											<c:when test="${result.tType == 'D' }"><c:out value="${result.content }"/></c:when>
											<c:when test="${result.tType == 'NC' }"><c:out value="${result.content }"/></c:when>
										</c:choose>
									</li>
									<li>
										<c:choose>
											<c:when test="${result.tType == 'fa' }"><c:out value="${result.issueDate } ${result.issueTime }"/></c:when>
											<c:otherwise>
												<c:out value="${result.regDttm } "/>
											</c:otherwise>
										</c:choose>
									</li>
								</ul>
							</c:forEach>
						</div>

					</div>
					<div class="pager">
						<!-- 웹페이징 -->
							<ui:pagination paginationInfo="${paginationInfo }" type="image" jsFunction="fn_list"/>
							<form:hidden path="pageIndex"/>
						<!-- // 웹페이징 -->
					</div>
				</div>
			</div>
		</div>
	</div>
	<!-- footer -->
	<c:import url="${pageContext.request.contextPath }/EgovPageLink.do?link=usr/inc/incFooter"/>
	<!-- footer -->
</form:form>
<script type="text/javascript">

	// 검색
	function fn_list(pageNo){
		$('#pageIndex').val(pageNo);
		$('#frm').attr('method', 'post').attr('action', '<c:out value="${pageContext.request.contextPath}/usr/floodCenter/floodAlarmList.do"/>').submit();
	}
	
	// 엑셀다운로드
	function fn_excelDownload(){
		if(confirm("엑셀다운로드를 하시겠습니까?\n데이터양에 따라 시간이 오래걸릴 수 있습니다.")){
			fn_loading_on();
			$.fileDownload("<c:out value='${pageContext.request.contextPath }/usr/floodCenter/floodAlarmListExcelDownload.do'/>", {
				httpMethod : "POST"
				, data : $("#frm").serialize()
			}).done(function(){
				fn_loading_off();
			});
		}
	}
</script>
</body>
</html>
