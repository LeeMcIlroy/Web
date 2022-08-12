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
		
		var ynLock = '<c:out value="${rs1010mVO.dataLockYn}"/>';		
		if(ynLock=='Y') {
						
			//$("#btnDel").hide();
			//$("#btnModi").hide();
			//$("#data_lock").attr('checked', 'checked');
			//$("#data_lock").attr('disabled', 'true');
			
			//참여지사 목록
			//$("#btnRegBr").hide();
			//$("#btnDelBr").hide();
			//$(".btnModiBr").attr('onclick', '').unbind('click');			
			
			//참여연구담당자 목록
			//$("#btnRegSt").hide();
			//$("#btnDelSt").hide();
			//$(".btnModiSt").attr('onclick', '').unbind('click');
			
		
		//}
			
		}
	});



	function fn_view(){
		$("#detailForm").attr("action", "<c:url value='/qxsepmny/ech0102/ech0102View.do'/>").submit();
	}
	function fn_view2(setVal){
		$("#setVal").val(setVal);
		$("#detailForm").attr("action", "<c:url value='/qxsepmny/ech0102/ech0102View2.do'/>").submit();
	}


	function fn_pop_sms(){
		window.open("<c:out value='${pageContext.request.contextPath }/qxsepmny/tmp/ech100201.do'/>"
					, 'SMS발송', 'width=1000, height=500, menubar=no, status=no, toolbar=no, scrollbars=1');
	}
	
	function fn_pop_email(){
		window.open("<c:out value='${pageContext.request.contextPath }/qxsepmny/tmp/ech100202.do'/>"
					, '이메일발송', 'width=1000, height=500, menubar=no, status=no, toolbar=no, scrollbars=1');
	}

	function fn_pop_resv(){
		window.open("<c:out value='${pageContext.request.contextPath }/qxsepmny/tmp/ech100301.do'/>"
					, '예약관리', 'width=1000, height=500, menubar=no, status=no, toolbar=no, scrollbars=1');
	}
	
	function fn_pop(){
		window.open("<c:out value='${pageContext.request.contextPath }/qxsepmny/ech1001/ech1001List.do'/>"
					, '피험자조회', 'width=1000, height=500, menubar=no, status=no, toolbar=no, scrollbars=1');
	}
	
	
	//목록으로
	function fn_list(){
		$("#detailForm").attr("action", "<c:url value='/qxsepmny/ech0102/ech0102List.do'/>").submit();
	}
	
	
</script>
<body>
<!-- wrap -->
<div class="wrap">
	<c:import url="/EgovPageLink.do?link=adm/inc/incTopnav"/>
	<!-- container -->
	<div class="container">
		<h2>연구관리</h2>
		<!-- contents -->
		<div class="contents">
			<!-- 타이틀 -->
			<jsp:include page="/WEB-INF/jsp/ctms/adm/inc/incPageTitle.jsp">
				<jsp:param name="dept1" value="연구관리"/>
	            <jsp:param name="dept2" value="피험자선정"/>
           	</jsp:include>
			<!-- //타이틀 -->
			<!-- 서브타이틀 -->
			<div class="sub_title_area type02">
				<h4>연구관리</h4>
			</div>
			<!-- //서브타이틀 -->
            <!-- //검색조건유지 설정 -->
            <form:form commandName="searchVO" id="detailForm" name="detailForm" method="post" enctype="multipart/form-data">
			<input type="hidden" id="corpCd" name="corpCd" value="${rs1010mVO.corpCd }"/>
			<input type="hidden" id="rsCd" name="rsCd" value="${rs1010mVO.rsCd }"/>
			<input type="hidden" id="rsNo" name="rsNo" value="${rs1010mVO.rsNo }"/>
			<input type="hidden" id="setVal" name="setVal"/>
			<input type="hidden" id="pageIndex" name="pageIndex" value="${pageIndex }"/>
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
                          		<c:when test="${rs1010mVO.dataLockYn eq 'Y' }"><c:out value="${rs1010mVO.rsCd }" /><span style="color:red;">(Data Locked)</span></c:when>
                          		<c:when test="${rs1010mVO.dataLockYn eq 'N' }"><c:out value="${rs1010mVO.rsCd }" /></c:when>
                          	</c:choose>
						</td>					
						<th scope="row" class="bl">연구명</th>
						<td><c:out value="${rs1010mVO.rsName }" /></td>
					</tr>
					<%-- <tr>
						<th scope="row">연구상태</th>
						<td><c:out value="${rs1010mVO.rsstClsNm }" /></td>
						<th scope="row" class="bl">연구기간</th>
						<td><c:out value="${rs1010mVO.rsStdt }" />~<c:out value="${rs1010mVO.rsEndt }" /></td>
					</tr>
					<tr>
						<th scope="row">고객사명</th>
						<td><c:out value="${rs1010mVO.vendName }" /></td>
						<th scope="row" class="bl">담당자</th>
						<td><c:out value="${rs1010mVO.vmngName }" />,<c:out value="${rs1010mVO.vmnghpNo }" />,<c:out value="${rs1010mVO.vmngEmail }" /></td>
					</tr> --%>
				</tbody>
			</table>
			<!-- //연구정보 -->
			</form:form>	
            <!-- 버튼 -->
            <div class="btn_area">
				<a href="#" onclick="fn_list(); return false;" class="type02">목록</a>
			</div>
            <!-- 탭버튼 -->
            <div class="tab_area tab06">
                <ul>
                	<li><a href="#" onclick="fn_view(1); return false;" class="on">전체</a></li>
                	<li><a href="#" onclick="fn_view2(2); return false;">지원자</a></li>
                	<li><a href="#" onclick="fn_view2(3); return false;">풀선별</a></li>
                	<li><a href="#" onclick="fn_view2(4); return false;">스크리닝</a></li>
                	<li><a href="#" onclick="fn_view2(5); return false;">스크리닝방문</a></li>
                	<li><a href="#" onclick="fn_view2(6); return false;">피험자확정</a></li>
                </ul>
            </div>
            <!-- //탭버튼 -->
			<!-- 테이블 상단 정보 -->
			<div class="tbl_top_info">
				<!-- <a href="#" onclick="fn_pop(); return false;" class="btn_sub type02">피험자 풀선별</a>  -->
				<!-- 버튼 -->
				<div>
					<!-- <a href="#" class="btn_sub">예약SMS 발송</a>
					<a href="#" onclick="fn_pop_sms(); return false;" class="btn_sub">SMS 발송</a>
					<a href="#" onclick="fn_pop_email(); return false;" class="btn_sub">이메일 발송</a>
					<a href="#" class="btn_sub">1차선정</a>
					<a href="#" onclick="fn_pop_resv(); return false;" class="btn_sub">스크리닝예약</a>
					<a href="#" class="btn_sub">피험자확정</a>  -->
					<!-- <a href="#" class="btn_excel">엑셀</a> -->
				</div>
			</div>
			<!-- //테이블 상단 정보 -->
            <!-- 목록 -->
			<table class="tbl_list">
				<colgroup>
					<!--<col style="width:4%" /> -->
					<col style="width:5%" />
					<col style="width:6%" />
					<col style="width:10%" />
					<col style="width:4%" />
					<col style="width:8%" />
					<col style="width:5%" />
					<col style="width:8%" />
					<col style="width:6%" />
					<col style="width:6%" />
					<col style="width:6%" />
					<col style="width:8%" />
					<col style="width:auto" />
					<col style="width:6%" />
					<col style="width:6%" />
				</colgroup>
				<thead>
					<tr>
						<!-- <th scope="col"><input type="checkbox" /></th>  -->
						<th scope="col">번호</th>
						<th scope="col">이름</th>
						<th scope="col">거주지</th>
						<th scope="col">성별</th>
						<th scope="col">생년월일</th>
						<th scope="col">나이</th>
						<th scope="col">핸드폰</th>
						<th scope="col">지원</th>
						<th scope="col">풀선별</th>
						<th scope="col">스크리닝</th>
						<th scope="col">스크리닝번호</th>
						<th scope="col">스크리닝방문</th>
						<th scope="col">피험자확정</th>
						<th scope="col">식별번호</th>
					</tr>
				</thead>
				<tbody>
					<c:forEach items="${resultList }" var="result">
						<tr>
							<!-- <td><input type="checkbox" name="rsjSeq" value="<c:out value='${result.rsjNo }'/>"/></td>  -->
							<td><c:out value="${result.rownum }"/></td>
							<td  onclick="fn_view('<c:out value='${result.corpCd}'/>','<c:out value='${result.rsNo}'/>'); return false;"><c:out value="${result.rsjName }"/></td>
	                        <td><c:out value="${result.addrMain }"/></td>
							<td><c:out value="${result.genYnNm }"/></td>
							<td><c:out value="${result.brDt }"/></td>
							<td><c:out value="${result.age }"/></td>
							<td><c:out value="${result.hpNo }"/></td>
							<td><c:out value="${result.appYn }"/></td>
							<td><c:out value="${result.poolYn }"/></td>
							<td><c:out value="${result.firstSt }"/></td>
							<td><c:out value="${result.firstStNo }"/></td>
							<td id="answTd_0">
								<c:set var="chkNo" value="${result.mapKey }"/>
								<c:forEach items="${mtList[chkNo] }" var="resutlMt" varStatus="status">
									<div class="que_item ques_div_0">
										<c:out value="${resutlMt.resrDt }"/>-<c:out value="${resutlMt.resrHr }"/>:<c:out value="${resutlMt.resrMm }"/>(<c:out value="${resutlMt.mtStNm }"/>)						
									</div>
								</c:forEach>
							</td>
							<td><c:out value="${result.cfmYn }"/></td>
							<td><c:out value="${result.rsiNo }"/></td>
						</tr>
					</c:forEach>
					<c:if test="${resultList.size() == 0 }">
						<tr>
							<td class="nodata" colspan="14">선정된 연구대상자 정보가 없습니다.</td>
						</tr>
					</c:if>
				</tbody>
			</table>
			<!-- //목록 -->
		</div>
		<!-- //contents -->
	</div>
	<!-- //container -->
</div>	
<!-- //wrap -->
</body>
</html>
