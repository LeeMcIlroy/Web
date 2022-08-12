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
	function fn_pop_sms(){
		window.open("<c:out value='${pageContext.request.contextPath }/qxsepmny/tmp/ech100201.do'/>"
					, 'SMS발송', 'width=1000, height=500, menubar=no, status=no, toolbar=no, scrollbars=1');
	}

	function fn_pop_email(){
		window.open("<c:out value='${pageContext.request.contextPath }/qxsepmny/tmp/ech100202.do'/>"
					, '이메일발송', 'width=1000, height=500, menubar=no, status=no, toolbar=no, scrollbars=1');
	}

	function fn_pop(){
		window.open("<c:out value='${pageContext.request.contextPath }/qxsepmny/tmp/ech100301.do'/>"
					, '예약관리', 'width=1000, height=500, menubar=no, status=no, toolbar=no, scrollbars=1');
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
	            <jsp:param name="dept2" value="예약관리"/>
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
								<option>진행중</option>
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
					<a href="#" class="btn_sub">예약SMS 발송</a>
					<a href="#" onclick="fn_pop_sms(); return false;" class="btn_sub">SMS 발송</a>
					<a href="#" onclick="fn_pop_email(); return false;" class="btn_sub">이메일 발송</a>
					<a href="#" onclick="fn_pop(); return false;" class="btn_sub">예약관리</a>
					<a href="#" class="btn_excel">엑셀</a>
				</div>
			</div>
			<!-- //테이블 상단 정보 -->
			<!-- 목록 -->
			<table class="tbl_list">
				<colgroup>
					<col style="width:5%" />
					<col style="width:5%" />
					<col style="width:8%" />
					<col style="width:8%" />
					<col style="width:6%" />
					<col style="width:6%" />
					<col style="width:12%" />
					<col style="width:12%" />
					<col style="width:16%" />
					<col style="width:8%" />
					<col style="width:auto" />
				</colgroup>
				<thead>
					<tr>
						<th scope="col"><input type="checkbox" /></th>
						<th scope="col">번호</th>
						<th scope="col">이름</th>
						<th scope="col">생년월일</th>
						<th scope="col">나이</th>						
						<th scope="col">성별</th>
						<th scope="col">거주지</th>						
						<th scope="col">핸드폰</th>
						<th scope="col">참여연구</th>
						<th scope="col">예약차수</th>
						<th scope="col">예약상태</th>
					</tr>
				</thead>
				<tbody>
					<tr>
						<td><input type="checkbox" /></td>
						<td>3</td>					
						<td>홍길동</td>
						<td>000000</td>
						<td>00</td>						
						<td>남</td>
						<td>서울</td>						
						<td>010-0000-0000</td>
						<td>HBSE-MLG-20057-1</td>
						<td>1회차</td>
						<td>예약 2020-01-01 12:00</td>						
					</tr>
					<tr>
						<td><input type="checkbox" /></td>
						<td>2</td>			
						<td>홍길동</td>
						<td>000000</td>
						<td>00</td>						
						<td>남</td>
						<td>서울</td>						
						<td>010-0000-0000</td>
						<td>HBSE-MLG-20057-1</td>
						<td>1회차</td>
						<td>예약 2020-01-01 12:00</td>
					</tr>
					<tr>
						<td><input type="checkbox" /></td>
						<td>1</td>					
						<td>홍길동</td>
						<td>000000</td>
						<td>00</td>						
						<td>남</td>
						<td>서울</td>						
						<td>010-0000-0000</td>
						<td>HBSE-MLG-20057-1</td>
						<td>1회차</td>
						<td>예약 2020-01-01 12:00</td>
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