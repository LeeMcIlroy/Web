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
	function fn_update(chkNum){
			$("#chkNum").val(chkNum);
			//$("#frm").attr("action", "<c:url value='/usr/ecf0201/ecf0201Update.do'/>").submit();
			$("#frm").attr("action", "<c:url value='qxsepmny/ech0205/ech0205UseUpdate.do'/>").submit();
		}
	
	function fn_etc(num){
		$("#remk").val($("#remk_"+num).val());
		$("#frm").attr("action", "<c:url value='/usr/ecf0201/ecf0201RemkUpdate.do'/>").submit();
	}

</script>

<body>
<form:form commandName="searchVO" id="listForm" name="listForm">
<input type="hidden" id="corpCd" name="corpCd"/>
<input type="hidden" id="rsNo" name="rsNo"/>
<!-- pop_wrap -->
<div class="pop_wrap">
	<!-- pop_header -->
	<div class="pop_header">
		<h1 class="hidden"><a href="#">H&amp;Bio</a></h1>
		<h2>체크결과</h2>
		<a href="javascript:window.close();" title="닫기">닫기</a>
	</div>
	<!-- //pop_header -->
	<!-- pop_con -->
	<div class="pop_con type02">
		<!-- 서브타이틀 -->
		<div class="sub_title_area type02">
			<h3>피험자 정보</h3>
		</div>
		<!-- //서브타이틀 -->
		<!-- 피험자 정보 -->
		<table class="tbl_list type02">
			<colgroup>
				<col style="width:10%" />
				<col style="width:10%" />
				<col style="width:8%" />
				<col style="width:8%" />
				<col style="width:14%" />
				<col style="width:10%" />
				<col style="width:10%" />
				<col style="width:10%" />
				<col style="width:10%" />
			</colgroup>
			<thead>
				<tr>
					<th scope="col">이름</th>
					<th scope="col">생년월일</th>
					<th scope="col">나이</th>
					<th scope="col">성별</th>
					<th scope="col">핸드폰</th>
					<th scope="col">체크시작일</th>
					<th scope="col">체크종료일</th>
					<th scope="col">체크응답</th>
					<th scope="col">특이사항</th>
				</tr>
			</thead>
			<tbody>
				<tr>
					<td><c:out value="${cr3210mVO.rsjName }" /></td>
					<td><c:out value="${cr3210mVO.brDt }" /></td>
					<td><c:out value="${cr3210mVO.age }" /></td>
					<td><c:out value="${cr3210mVO.genYnNm }" /></td>
					<td><c:out value="${cr3210mVO.hpNo }" /></td>
					<td><c:out value="${cr3210mVO.chkStdt }" /></td>
					<td><c:out value="${cr3210mVO.chkEndt }" /></td>
					<td><c:out value="${cr3210mVO.chkCnt }" /></td>
					<td><c:out value="${cr3210mVO.remk }" /></td>
				</tr>
			</tbody>
		</table>
		<!-- //피험자 정보 -->
		<!-- 서브타이틀 -->
		<div class="sub_title_area">
			<h3>사용체크 결과</h3>
		</div>
		<!-- //서브타이틀 -->
		<!-- 사용체크 결과 -->
		<div class="check_result">
		<table class="tbl_list">
				<colgroup>
					<col style="width:auto" />
					<col style="width:10%" />
					<col style="width:10%" />
					<col style="width:10%" />
					<col style="width:10%" />
					<col style="width:10%" />
					<col style="width:10%" />
					<col style="width:15%" />
				</colgroup>
				<thead>
					<tr>
						<th scope="col">사용일자</th>
						<th scope="col">체크1</th>
						<th scope="col">체크2</th>
						<th scope="col">체크3</th>
						<th scope="col">체크4</th>
						<th scope="col">체크5</th>
						<th scope="col">사용횟수</th>
						<th scope="col">비고</th>
					</tr>
				</thead>
				<tbody>
				<c:forEach var="result" items="${resultList}" varStatus="status">
					<tr>
						<td><c:out value="${result.chkDt }"/></td>
						<td>
							<c:choose>
                         		<c:when test="${result.chk1 eq 'N' }"><span style="color:red;">미사용</span></c:when>
                         		<c:when test="${result.chk1 eq 'Y' }">사용</c:when>
                         	</c:choose>
                        </td>
                        <td>
							<c:choose>
                          		<c:when test="${result.chk2 eq 'N' }"><span style="color:red;">미사용</span></c:when>
                          		<c:when test="${result.chk2 eq 'Y' }">사용</c:when>
                          	</c:choose>
                       	</td>
                        <td>
							<c:choose>
                          		<c:when test="${result.chk3 eq 'N' }"><span style="color:red;">미사용</span></c:when>
                          		<c:when test="${result.chk3 eq 'Y' }">사용</c:when>
                          	</c:choose>
                       	</td>
                        <td>
							<c:choose>
                          		<c:when test="${result.chk4 eq 'N' }"><span style="color:red;">미사용</span></c:when>
                          		<c:when test="${result.chk4 eq 'Y' }">사용</c:when>
                          	</c:choose>
                       	</td>
                        <td>
							<c:choose>
                          		<c:when test="${result.chk5 eq 'N' }"><span style="color:red;">미사용</span></c:when>
                          		<c:when test="${result.chk5 eq 'Y' }">사용</c:when>
                          	</c:choose>
                       	</td>
						<td><c:out value="${result.chkCnt}"/></td>
						<td><c:out value="${result.remk}"/></td>
					</tr>
				</c:forEach>
				<c:if test="${resultList.size() == 0 }">
					<tr>
						<td class="nodata" colspan="8">연구대상자의 사용결과가 없습니다.</td>
					</tr>
				</c:if>
				</tbody>
		</table>
		</div>
		<!-- //사용체크 결과 -->
		<!-- 버튼 -->
		<div class="btn_area">
<!-- 			<a href="#" class="type02">닫기</a> -->
		</div>
		<!-- //버튼 -->
	</div>
	<!-- //pop_con -->
</div>	
<!-- //pop_wrap -->
</form:form>
</body>
</html>