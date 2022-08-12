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
		location.href = "<c:out value='${pageContext.request.contextPath }/qxsepmny/tmp/ech020302.do'/>";
	}
</script>
<body>
<!-- wrap -->
<div class="wrap">
	<c:import url="/EgovPageLink.do?link=adm/inc/incTopnav"/>
	<!-- container -->
	<div class="container">
		<h2>eCRF관리</h2>
		<!-- contents -->
		<div class="contents">
			<!-- 타이틀 -->
			<jsp:include page="/WEB-INF/jsp/ctms/adm/inc/incPageTitle.jsp">
				<jsp:param name="dept1" value="eCRF관리"/>
	            <jsp:param name="dept2" value="질문답변관리"/>
           	</jsp:include>
			<!-- //타이틀 -->
			<!-- 검색영역 -->
			<div class="srch_area">
				<ul>
					<li>
						<p>유형</p>
						<span>
							<select>
								<option>전체</option>
							</select>
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
					<col style="width:5%" />
					<col style="width:10%" />
					<col style="width:auto" />
					<col style="width:20%" />
					<col style="width:10%" />
					<col style="width:10%" />
					<col style="width:10%" />
				</colgroup>
				<thead>
					<tr>
						<th scope="col">번호</th>
						<th scope="col">유형</th>
						<th scope="col">질문/답변명</th>
						<th scope="col">질문</th>
						<th scope="col">답변개수</th>
						<th scope="col">등록일</th>
                        <th scope="col">사용여부</th>
					</tr>
				</thead>
				<tbody>
					<tr>
						<td class="nodata" colspan="7">질문답변 정보가 없습니다.</td>
					</tr>
					<tr onclick="fn_view(); return false;">
						<td>3</td>
						<td>단일응답</td>						
						<td>증상완화 5개 답변 – 매우 그렇다</td>	
						<td>질문이 들어갑니다</td>
						<td>5</td>
						<td>0000-00-00</td>
						<td>사용</td>
					</tr>
					<tr onclick="fn_view(); return false;">
						<td>2</td>
						<td>단일응답</td>						
						<td>증상완화 5개 답변 – 매우 그렇다</td>	
						<td>질문이 들어갑니다</td>
						<td>5</td>
						<td>0000-00-00</td>
						<td>사용</td>
					</tr>
					<tr onclick="fn_view(); return false;">
						<td>1</td>
						<td>단일응답</td>						
						<td>증상완화 5개 답변 – 매우 그렇다</td>	
						<td>질문이 들어갑니다</td>
						<td>5</td>
						<td>0000-00-00</td>
						<td>사용</td>
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
			<!-- 하단버튼 -->
			<div class="list_btm_btn">
				<div>
					<a href="#">등록</a>
				</div>
			</div>
			<!-- //하단버튼 -->
		</div>
		<!-- //contents -->
	</div>
	<!-- //container -->
</div>	
<!-- //wrap -->
</body>
</html>