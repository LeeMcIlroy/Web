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
		location.href = "<c:out value='${pageContext.request.contextPath }/qxsepmny/tmp/ech070702.do'/>";
	}
</script>
<body>
<!-- wrap -->
<div class="wrap">
	<c:import url="/EgovPageLink.do?link=adm/inc/incTopnav"/>
	<!-- container -->
	<div class="container">
		<h2>기준정보</h2>
		<!-- contents -->
		<div class="contents">
			<!-- 타이틀 -->
			<jsp:include page="/WEB-INF/jsp/ctms/adm/inc/incPageTitle.jsp">
				<jsp:param name="dept1" value="기준정보"/>
	            <jsp:param name="dept2" value="공통코드관리"/>
           	</jsp:include>			
			<!-- //타이틀 -->
			<!-- 검색영역 -->
			<div class="srch_area">
				<ul>
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
					<li>
						<p>사용여부</p>
						<span>
							<select>
								<option>전체</option>
							</select>
						</span>
					</li>                    
				</ul>
				<!-- 조회버튼 -->
				<a href="#">조회</a>
			</div>
			<!-- //검색영역 -->
			<!-- 목록 -->
			<table class="tbl_list tr_link">
				<colgroup>
					<col style="width:5%" />
					<col style="width:15%" />
					<col style="width:20%" />
					<col style="width:auto" />
                    <col style="width:5%" />
				</colgroup>
				<thead>
					<tr>
						<th scope="col">번호</th>
						<th scope="col">대코드</th>
						<th scope="col">대코드명</th>
						<th scope="col">대코드설명</th>
						<th scope="col">사용여부</th>
					</tr>
				</thead>
				<tbody>
					<tr>
						<td class="nodata" colspan="5">대코드 정보가 없습니다.</td>
					</tr>
					<tr onclick="location.href='#'">
						<td>3</td>
						<td>000000</td>						
						<td>대코드명</td>						
						<td>대코드설명</td>
						<td>사용</td>
					</tr>
					<tr onclick="location.href='#'">
						<td>2</td>
						<td>000000</td>						
						<td>대코드명</td>						
						<td>대코드설명</td>
						<td>사용</td>
					</tr>
					<tr onclick="location.href='#'">
						<td>1</td>
						<td>000000</td>						
						<td>대코드명</td>						
						<td>대코드설명</td>
						<td>사용</td>
					</tr>
				</tbody>
			</table>
			<!-- //목록 -->
			<!--  목록 하단 -->
			<div class="list_btm">
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
				<!-- 하단버튼 -->
				<div class="list_btm_btn">
					<a href="#">등록</a>
				</div>
				<!-- //하단버튼 -->
			</div>
			<!-- //목록 하단 -->
			<!-- 탭버튼 -->
            <div class="tab_area tab06">
                <ul>
                	<li><a href="#" class="on">대코드</a></li>
                	<li><a href="#" onclick="fn_view(); return fasle;">소코드</a></li>
                </ul>
            </div>
            <!-- //탭버튼 -->
            <!-- 코드정보 -->
            <table class="tbl_view">
				<colgroup>
					<col style="width:15%" />
					<col style="width:35%" />
					<col style="width:15%" />
					<col style="width:35%" />
				</colgroup>
				<tbody>
					<tr>
						<th scope="row">대코드</th>
						<td>
							<input type="text" />
						</td>
						<th scope="row" class="bl">대코드명</th>
						<td>
							<input type="text" />
						</td>
					</tr>
					<tr>
						<th scope="row">대코드설명</th>
						<td>
							<input type="text" />
						</td>
						<th scope="row" class="bl">사용여부</th>
						<td>
							<input type="radio" name="useYN" id="useY" />
						    <label for="useY">사용</label>
						    <input type="radio" name="useYN" id="useN" />
						    <label for="useN">미사용</label>
						</td>
					</tr>
				</tbody>
			</table>
            <!-- //코드정보 -->
            <!-- 버튼 -->
			<div class="btn_area">
				<a href="#" class="type02">취소</a>
				<a href="#">저장</a>
			</div>
			<!-- //버튼 -->
		</div>
		<!-- //contents -->
	</div>
	<!-- //container -->
</div>	
<!-- //wrap -->
</body>
</html>