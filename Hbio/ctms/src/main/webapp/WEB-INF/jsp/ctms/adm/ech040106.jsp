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
		location.href = "<c:out value='${pageContext.request.contextPath }/qxsepmny/tmp/ech040107.do'/>";
	}
	
	function fn_pop(){
		window.open("<c:out value='${pageContext.request.contextPath }/qxsepmny/tmp/ech040406.do'/>"
					, '제품사용출력팝업', 'width=1000, height=500, menubar=no, status=no, toolbar=no, scrollbars=1');
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
	            <jsp:param name="dept2" value="시험결과추출(제품사용)"/>
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
                	<li><a href="#">eCRF통계</a></li>
                	<li><a href="#">피부특성</a></li>
                	<li><a href="#">피부자극</a></li>
                	<li><a href="#" class="on">제품사용</a></li>
                	<li><a href="#" onclick="fn_view(); return false;">결과보고서</a></li>
                </ul>
            </div>
            <!-- //탭버튼 -->
			<!-- 테이블 상단 정보 -->
			<div class="tbl_top_info">
				<h4>제품사용</h4>
			</div>
			<!-- //테이블 상단 정보 -->
            <!-- 목록 -->
			<table class="tbl_list">
				<colgroup>
					<col style="width:5%" />
					<col style="width:15%" />
					<col style="width:auto" />
					<col style="width:15%" />
					<col style="width:15%" />
					<col style="width:15%" />
				</colgroup>
				<thead>
					<tr>
						<th scope="col">번호</th>
						<th scope="col">이름</th>
						<th scope="col">생년월일</th>
						<th scope="col">나이</th>
						<th scope="col">성별</th>
						<th scope="col">제품사용</th>
					</tr>
				</thead>
				<tbody>
					<tr>
						<td class="nodata" colspan="6">제품사용 정보가 없습니다.</td>
					</tr>
					<tr>
						<td>3</td>	
						<td>홍길동</td>					
						<td>000000</td>
						<td>00</td>
						<td>남</td>	
						<td><a href="#" onclick="fn_pop(); return false;" class="btn_sub">출력</a></td>
					</tr>
					<tr>
						<td>2</td>	
						<td>홍길동</td>					
						<td>000000</td>
						<td>00</td>
						<td>남</td>	
						<td><a href="#" class="btn_sub">출력</a></td>
					</tr>
					<tr>
						<td>1</td>	
						<td>홍길동</td>					
						<td>000000</td>
						<td>00</td>
						<td>남</td>	
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