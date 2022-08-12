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
		location.href = "<c:out value='${pageContext.request.contextPath }/qxsepmny/tmp/ech040102.do'/>";
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
	            <jsp:param name="dept2" value="시험결과추출"/>
           	</jsp:include>
			<!-- //타이틀 -->
			<!-- 검색영역 -->
			<div class="srch_area">
				<ul>
					<li>
						<p>연구코드</p>
						<span class="type01">
							<input type="text" placeholder="연구코드" />
						</span>
						<span>
							<select>
								<option>년도</option>
							</select>
						</span>
						<span class="type01">
							<select>
								<option>연구코드/연구명</option>
							</select>
						</span>
					</li>
					<li>
						<p>연구상태</p>
						<span>
							<select>
								<option>전체</option>
							</select>
						</span>
					</li>
					<li>
						<p>기간</p>
                        <span>
                            <select>
								<option>검색조건</option>
							</select>
                        </span>
						<span>
							<input type="text" class="date" />
							<a href="#" class="btn_cld">날짜검색</a>
						</span>
						<em>~</em>
						<span>
							<input type="text" class="date" />
							<a href="#" class="btn_cld">날짜검색</a>
						</span>
						<span class="type00">
							<input type="radio" name="period" id="period01" /> <label for="period01">1년</label>
							<input type="radio" name="period" id="period02" /> <label for="period02">3개월</label>
							<input type="radio" name="period" id="period03" /> <label for="period03">1개월</label>
						</span>
					</li>                    
                    <li>
						<p>검색어</p>
						<span>
							<select>
								<option>검색조건</option>
							</select>
						</span>
                        <span class="type02">
                            <input type="text" placeholder="검색어 입력" />
                        </span>
					</li>
				</ul>
				<!-- 조회버튼 -->
				<a href="#">조회</a>
			</div>
			<!-- //검색영역 -->
			<!-- 테이블 상단 정보 -->
			<div class="tbl_top_info">
				<span>총 10건</span>
				<!-- 버튼 -->
				<div>
					<a href="#" class="btn_excel">엑셀</a>
				</div>
			</div>
			<!-- //테이블 상단 정보 -->
			<!-- 목록 -->
			<table class="tbl_list tr_link">
				<colgroup>
					<col style="width:20%" />
					<col style="width:auto" />
					<col style="width:8%" />
					<col style="width:8%" />
					<col style="width:8%" />
					<col style="width:8%" />
					<col style="width:8%" />
					<col style="width:8%" />
					<col style="width:8%" />
				</colgroup>
				<thead>
					<tr>
						<th scope="col">연구코드</th>
						<th scope="col">연구명</th>
						<th scope="col">연구상태</th>
						<th scope="col">피험자수</th>
						<th scope="col">동의서</th>
						<th scope="col">eCRF통계</th>
						<th scope="col">피부특성</th>
						<th scope="col">피부자극</th>
						<th scope="col">제품사용</th>
					</tr>
				</thead>
				<tbody>
					<tr>
						<td class="nodata" colspan="9">시험결과추출 정보가 없습니다.</td>
					</tr>
					<tr onclick="fn_view(); return false;">
						<td>HBSE-MLG-20057-1</td>						
						<td>Ecrf 관찰연구 1회</td>	
						<td>진행중</td>
						<td>10</td>
						<td>10/10</td>
						<td>10/10</td>
						<td>10/10</td>
						<td>10/10</td>
						<td>10/10</td>
					</tr>
					<tr onclick="location.href='#'">
						<td>HBSE-MLG-20057-1</td>						
						<td>Ecrf 관찰연구 1회</td>	
						<td>진행중</td>
						<td>10</td>
						<td>10/10</td>
						<td>10/10</td>
						<td>10/10</td>
						<td>10/10</td>
						<td>10/10</td>
					</tr>
					<tr onclick="location.href='#'">
						<td>HBSE-MLG-20057-1</td>						
						<td>Ecrf 관찰연구 1회</td>	
						<td>진행중</td>
						<td>10</td>
						<td>10/10</td>
						<td>10/10</td>
						<td>10/10</td>
						<td>10/10</td>
						<td>10/10</td>
					</tr>
				</tbody>
			</table>
			<!-- //목록 -->
			<!-- 페이징 -->
			<div class="pagenate">
				<a href="#" class="pg_first">처음</a>
				<a href="#" class="pg_prev">이전</a>
				<a href="#" class="active">1</a>
				<a href="#">2</a>
				<a href="#">3</a>
				<a href="#">4</a>
				<a href="#">5</a>
				<a href="#">6</a>
				<a href="#">7</a>
				<a href="#">8</a>
				<a href="#">9</a>
				<a href="#">10</a>
				<a href="#" class="pg_next">다음</a>
				<a href="#" class="pg_last">마지막</a>
			</div>
			<!-- //페이징 -->
		</div>
		<!-- //contents -->
	</div>
	<!-- //container -->
</div>	
<!-- //wrap -->
</body>
</html>