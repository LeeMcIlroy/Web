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
	            <jsp:param name="dept2" value="종합통계"/>
           	</jsp:include>
			<!-- //타이틀 -->
			<!-- 테이블 상단 정보 -->
			<div class="tbl_top_info">
				<span>
					<select class="sub">
						<option>2020년</option>
					</select>
					<select class="sub">
						<option>1월</option>
					</select>
				</span>
				<!-- 버튼 -->
				<div>
					<a href="#" class="btn_excel">엑셀</a>
				</div>
			</div>
			<!-- //테이블 상단 정보 -->
			<!-- 목록 -->
			<table class="tbl_list tr_link">
				<colgroup>
					<col style="width:8%" />
					<col style="width:8%" />
					<col style="width:3%" />
					<col style="width:7%" />
					<col style="width:5%" />
					<col style="width:5%" />
					<col style="width:3%" />
					<col style="width:3%" />
					<col style="width:2%" />
					<col style="width:6%" />
					<col style="width:6%" />
					<col style="width:5%" />
					<col style="width:5%" />
					<col style="width:5%" />
					<col style="width:5%" />
					<col style="width:4%" />
					<col style="width:4%" />
					<col style="width:4%" />
				</colgroup>
				<thead>
					<tr>
						<th scope="col">연구코드</th>
						<th scope="col">연구명</th>
						<th scope="col">연구<br />상태</th>
						<th scope="col">고객사명</th>
						<th scope="col">계약일</th>
						<th scope="col">연구기간</th>
						<th scope="col">연구<br />책임자</th>
						<th scope="col">연구<br />담당자</th>
						<th scope="col">피험자수</th>
						<th scope="col">연구<br />(VAT미포함)</th>
						<th scope="col">누적연구비</th>
						<th scope="col">보고서<br />승인일</th>
						<th scope="col">IRB계획<br />승인일</th>
						<th scope="col">IRB결과<br />승인일</th>
						<th scope="col">결과보고일</th>
						<th scope="col">연구<br />계획서</th>
						<th scope="col">결과<br />보고서</th>
						<th scope="col">심의결과<br />통지서</th>
					</tr>
				</thead>
				<tbody>
					<tr>
						<td class="nodata" colspan="18">종합통계 정보가 없습니다.</td>
					</tr>
					<tr onclick="location.href='#'">
						<td>HBSE-MLG-20057-1</td>						
						<td>Ecrf 관찰연구 1회</td>	
						<td>진행중</td>
						<td>고객사명</td>
						<td>0000-00-00</td>
						<td>0000-00-00<br />0000-00-00</td>
						<td>홍길동</td>
						<td>아무개</td>
						<td>10</td>
						<td>22,000,000</td>
						<td>22,000,000</td>
						<td>0000-00-00</td>
						<td>0000-00-00</td>
						<td>0000-00-00</td>
						<td>0000-00-00</td>
						<td><a href="#" class="btn_sub">다운</a></td>
						<td><a href="#" class="btn_sub">다운</a></td>
						<td><a href="#" class="btn_sub">다운</a></td>
					</tr>
					<tr onclick="location.href='#'">
						<td>HBSE-MLG-20057-1</td>						
						<td>Ecrf 관찰연구 1회</td>	
						<td>진행중</td>
						<td>고객사명</td>
						<td>0000-00-00</td>
						<td>0000-00-00<br />0000-00-00</td>
						<td>홍길동</td>
						<td>아무개</td>
						<td>10</td>
						<td>22,000,000</td>
						<td>22,000,000</td>
						<td>0000-00-00</td>
						<td>0000-00-00</td>
						<td>0000-00-00</td>
						<td>0000-00-00</td>
						<td><a href="#" class="btn_sub">다운</a></td>
						<td><a href="#" class="btn_sub">다운</a></td>
						<td><a href="#" class="btn_sub">다운</a></td>
					</tr>
					<tr onclick="location.href='#'">
						<td>HBSE-MLG-20057-1</td>						
						<td>Ecrf 관찰연구 1회</td>	
						<td>진행중</td>
						<td>고객사명</td>
						<td>0000-00-00</td>
						<td>0000-00-00<br />0000-00-00</td>
						<td>홍길동</td>
						<td>아무개</td>
						<td>10</td>
						<td>22,000,000</td>
						<td>22,000,000</td>
						<td>0000-00-00</td>
						<td>0000-00-00</td>
						<td>0000-00-00</td>
						<td>0000-00-00</td>
						<td><a href="#" class="btn_sub">다운</a></td>
						<td><a href="#" class="btn_sub">다운</a></td>
						<td><a href="#" class="btn_sub">다운</a></td>
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