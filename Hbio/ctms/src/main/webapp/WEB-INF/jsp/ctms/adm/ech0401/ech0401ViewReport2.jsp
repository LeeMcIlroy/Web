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
	function fn_view(){
		$("#detailForm").attr("action", "<c:url value='/qxsepmny/ech0401/ech0401ViewIcf.do'/>").submit();
	}
	function fn_view2(){
		$("#detailForm").attr("action", "<c:url value='/qxsepmny/ech0401/ech0401ViewCrf.do'/>").submit();
	}
	function fn_view3(){
		$("#detailForm").attr("action", "<c:url value='/qxsepmny/ech0401/ech0401ViewSkinProp.do'/>").submit();
	}
	function fn_view4(){
		$("#detailForm").attr("action", "<c:url value='/qxsepmny/ech0401/ech0401ViewSkinStim.do'/>").submit();
	}
	function fn_view5(){
		$("#detailForm").attr("action", "<c:url value='/qxsepmny/ech0401/ech0401ViewItemUse.do'/>").submit();
	}
	function fn_view6(){
		$("#detailForm").attr("action", "<c:url value='/qxsepmny/ech0401/ech0401ViewReport.do'/>").submit();
	}
	
	function fn_pop_icf1(){
		window.open("<c:out value='${pageContext.request.contextPath }/qxsepmny/tmp/ech040401.do'/>"
					, '개인정보동의서출력팝업', 'width=1000, height=500, menubar=no, status=no, toolbar=no, scrollbars=1');
	}
	function fn_pop_icf2(){
		window.open("<c:out value='${pageContext.request.contextPath }/qxsepmny/tmp/ech040402.do'/>"
					, '연구참여동의서출력팝업', 'width=1000, height=500, menubar=no, status=no, toolbar=no, scrollbars=1');
	}
	
	//목록으로
	function fn_list(){
		$("#detailForm").attr("action", "<c:url value='/qxsepmny/ech0401/ech0401List.do'/>").submit();
	}
	
	//수정페이지로
	function fn_update(){
		$("#detailForm").attr("action", "<c:url value='/qxsepmny/ech0401/ech0401Modify.do'/>").submit();
	}
	
	//연구동의서 삭제
	function fn_delete(){
		if (confirm("연구동의서 정보를 삭제하시겠습니까?")) {
		$("#detailForm").attr("action", "<c:url value='/qxsepmny/ech0401/ech0401Delete.do'/>").submit();
			
		}
	}
	
	//파일 다운로드
	function fn_filedownload(attachSeq, boardType){
		location.href = "<c:out value='${pageContext.request.contextPath}/cmmn/file/downloadFile.do'/>?fileId="+attachSeq+"&type="+boardType;
	}
	
</script>
<body>
<!-- wrap -->
<div class="wrap">
	<c:import url="/EgovPageLink.do?link=adm/inc/incTopnav"/>
	<!-- container -->
	<div class="container">
		<h2>자료추출</h2>
		<!-- contents -->
		<div class="contents">
			<!-- 타이틀 -->
			<jsp:include page="/WEB-INF/jsp/ctms/adm/inc/incPageTitle.jsp">
				<jsp:param name="dept1" value="자료추출"/>
	            <jsp:param name="dept2" value="시험결과추출(결과보고서)"/>
           	</jsp:include>
			<!-- //타이틀 -->
			<!-- 서브타이틀 -->
			<div class="sub_title_area type02">
				<h4>연구정보</h4>
			</div>
			<!-- //서브타이틀 -->
			<form:form commandName="searchVO" id="detailForm" name="detailForm" method="post" enctype="multipart/form-data">
			<input type="hidden" id="corpCd" name="corpCd" value="${rs1000mVO.corpCd eq ''?corpCd:rs1000mVO.corpCd}">
			<input type="hidden" id="rsNo" name="rsNo" value="${rs1000mVO.rsNo eq ''?rsNo:rs1000mVO.rsNo}">
			<input type="hidden" id="pageIndex" name="pageIndex" value="${pageIndex }"/>
			<input type="hidden" id="file" name="file"/>
            <!-- 연구정보 -->
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
						<td>
							<c:choose>
                          		<c:when test="${rs1000mVO.dataLockYn eq 'Y' }"><c:out value="${rs1000mVO.rsCd }" /><span style="color:red;">(Data Locked)</span></c:when>
                          		<c:when test="${rs1000mVO.dataLockYn eq 'N' }"><c:out value="${rs1000mVO.rsCd }" /></c:when>
                          	</c:choose>
						</td>					
						<th scope="row" class="bl">연구명</th>
						<td><c:out value="${rs1000mVO.rsName }" /></td>
					</tr>
					<tr>
						<th scope="row">연구상태</th>
						<td><c:out value="${rs1000mVO.rsstClsNm }" /></td>
						<th scope="row" class="bl">연구기간</th>
						<td><c:out value="${rs1000mVO.rsStdt }" />~<c:out value="${rs1000mVO.rsEndt }" /></td>
					</tr>
					<%-- <tr>
						<th scope="row">고객사명</th>
						<td><c:out value="${rs1000mVO.vendName }" /></td>
						<th scope="row" class="bl">담당자</th>
						<td><c:out value="${rs1000mVO.vmngName }" />,<c:out value="${rs1000mVO.vmnghpNo }" />,<c:out value="${rs1000mVO.vmngEmail }" /></td>
					</tr> --%>
				</tbody>
			</table>
            <!-- //연구정보 -->
            </form:form>
            <!-- 버튼 -->
			<div class="btn_area">
				<a href="#" onclick="fn_list(); return false;" class="type02">목록</a>
			</div>
			<!-- //버튼 -->
            <!-- 탭버튼 -->
            <div class="tab_area tab06">
                <ul>
                    <li><a href="#" onclick="fn_view(); return false;" >동의서</a></li>
                	<li><a href="#" onclick="fn_view2(); return false;">CRF(설문)</a></li>
                	<li><a href="#" onclick="fn_view3(); return false;">연구대상자특성</a></li>
                	<li><a href="#" onclick="fn_view4(); return false;">피부자극</a></li>
                	<li><a href="#" onclick="fn_view5(); return false;">제품사용</a></li>
                	<li><a href="#" onclick="fn_view6(); return false;" class="on">결과보고서</a></li>
                </ul>
            </div>
            <!-- //탭버튼 -->
			<div class="tbl_top_info">
				<h4>결과보고서</h4>
				<!-- 버튼 -->
				<div>
					<a href="#" onclick="fn_ubi_pop('detailForm', 'report', 'corpCd#<c:out value='${rs1000mVO.corpCd }'/>#rsNo#<c:out value='${rs1000mVO.rsNo }'/>','<c:out value='${rs1000mVO.rsCd }'/>_결과보고서_<c:out value='${rs1000mVO.vendName }'/>'); return false;" class="btn_sub">결과보고서 추출</a>
				</div>
			</div>
			<!-- //테이블 상단 정보 -->
            <!-- 결과보고서 -->
             <!-- 목록 -->
			<table class="tbl_list">
				<colgroup>
					<col style="width:5%" />
					<col style="width:auto" />
					<col style="width:15%" />
					<col style="width:10%" />
				</colgroup>
				<thead>
					<tr>
						<th scope="col">번호</th>
						<th scope="col">보고서종류</th>
						<th scope="col">등록일자</th>
						<th scope="col">보고서</th>
					</tr>
				</thead>
				<tbody>
				<c:forEach var="result" items="${resultList}" varStatus="status">
					<tr>
						<td><c:out value="${result.rownum }"/></td>
						<td><c:out value="${result.rptClsNm }"/></td>
						<td><c:out value="${result.rptDt }"/></td>
						<td><a href="#" onclick="fn_filedownload('<c:out value="${result.attachNo }"/>','<c:out value="${result.boardType }"/>'); return false;" class="btn_sub">다운로드</a></td>
					</tr>
				</c:forEach>
				<c:if test="${resultList.size() == 0 }">
					<tr>
						<td class="nodata" colspan="4">등록된 보고서 정보가 없습니다.</td>
					</tr>
				</c:if>
				</tbody>
			</table>
			<!-- <div class="rst_report">
			</div> -->
			<!-- //결과보고서 -->
		</div>
		<!-- //contents -->
	</div>
	<!-- //container -->
</div>	
<!-- //wrap -->
</body>
</html>