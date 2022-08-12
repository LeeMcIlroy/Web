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
		location.href = "<c:out value='${pageContext.request.contextPath }/qxsepmny/tmp/ech040104.do'/>";
	}
	
	function fn_pop(){
		window.open("<c:out value='${pageContext.request.contextPath }/qxsepmny/tmp/ech040403.do'/>"
					, 'eCRF통계출력팝업', 'width=1000, height=500, menubar=no, status=no, toolbar=no, scrollbars=1');
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
	            <jsp:param name="dept2" value="시험결과추출(eCRF통계)"/>
           	</jsp:include>
			<!-- //타이틀 -->
			<!-- 서브타이틀 -->
			<div class="sub_title_area type02">
				<h4>연구정보</h4>
			</div>
			<!-- //서브타이틀 -->
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
						<td>HBSE-MLG-20057-1</td>
						<th scope="row" class="bl">연구명</th>
						<td>Ecrf 관찰연구 1회</td>
					</tr>
				</tbody>
			</table>
            <!-- //연구정보 -->
            <!-- 버튼 -->
			<div class="btn_area">
				<a href="#" class="type02">목록</a>
			</div>
			<!-- //버튼 -->
            <!-- 탭버튼 -->
            <div class="tab_area tab06">
                <ul>
                	<li><a href="#">동의서</a></li>
                	<li><a href="#" class="on">eCRF통계</a></li>
                	<li><a href="#" onclick="fn_view(); return false;">피부특성</a></li>
                	<li><a href="#">피부자극</a></li>
                	<li><a href="#">제품사용</a></li>
                	<li><a href="#">결과보고서</a></li>
                </ul>
            </div>
            <!-- //탭버튼 -->
			<!-- 테이블 상단 정보 -->
			<div class="tbl_top_info">
				<h4>eCRF통계</h4>
				<!-- 버튼 -->
				<div>
					<select class="sub">
						<option>회차</option>
					</select>
					<a href="#" class="btn_sub">응답 종합통계 출력</a>
				</div>
			</div>
			<!-- //테이블 상단 정보 -->
            <!-- 목록 -->
			<table class="tbl_list">
				<colgroup>
					<col style="width:15%" />
					<col style="width:auto" />
					<col style="width:15%" />
					<col style="width:15%" />
					<col style="width:15%" />
				</colgroup>
				<thead>
					<tr>
						<th scope="col">설문차수</th>
						<th scope="col">설문명</th>
						<th scope="col">이름</th>
						<th scope="col">생년월일</th>
						<th scope="col">응답결과</th>
						
					</tr>
				</thead>
				<tbody>
					<tr>
						<td class="nodata" colspan="5">eCRF통계 정보가 없습니다.</td>
					</tr>
					<tr>
						<td>1차 1회</td>					
						<td>피부임상 1차설문</td>
						<td>홍길동</td>
						<td>000000</td>	
						<td><a href="#" onclick="fn_pop(); return false;" class="btn_sub">출력</a></td>
					</tr>
					<tr>
						<td>1차 1회</td>					
						<td>피부임상 1차설문</td>
						<td>홍길동</td>
						<td>000000</td>		
						<td><a href="#" class="btn_sub">출력</a></td>
					</tr>
					<tr>
						<td>1차 1회</td>					
						<td>피부임상 1차설문</td>
						<td>홍길동</td>
						<td>000000</td>
						<td><a href="#" class="btn_sub">출력</a></td>
					</tr>
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