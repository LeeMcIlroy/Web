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

	function fn_pop_resv(){
		window.open("<c:out value='${pageContext.request.contextPath }/qxsepmny/tmp/ech100301.do'/>"
					, '예약관리', 'width=1000, height=500, menubar=no, status=no, toolbar=no, scrollbars=1');
	}
	
	function fn_pop(){
		window.open("<c:out value='${pageContext.request.contextPath }/qxsepmny/tmp/ech100101.do'/>"
					, '피험자조회', 'width=1000, height=500, menubar=no, status=no, toolbar=no, scrollbars=1');
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
            <!-- 연구관리 -->
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
						<th scope="row" class="bl">피험자중복</th>
						<td>중복참여 가능</td>
					</tr>
					<tr>
						<th scope="row">연구명</th>
						<td colspan="3">연구명이 들어갑니다.</td>
					</tr>
				</tbody>
			</table>
            <!-- //연구관리 -->
            <!-- 탭버튼 -->
            <div class="tab_area tab06">
                <ul>
                	<li><a href="#" class="on">전체</a></li>
                	<li><a href="#">지원자</a></li>
                	<li><a href="#">풀선별</a></li>
                	<li><a href="#">1차선정</a></li>
                	<li><a href="#">스크리닝</a></li>
                	<li><a href="#">피험자확정</a></li>
                </ul>
            </div>
            <!-- //탭버튼 -->
			<!-- 테이블 상단 정보 -->
			<div class="tbl_top_info">
				<a href="#" onclick="fn_pop(); return false;" class="btn_sub type02">피험자 풀선별</a>
				<!-- 버튼 -->
				<div>
					<a href="#" class="btn_sub">예약SMS 발송</a>
					<a onclick="fn_pop_sms(); return false;" class="btn_sub">SMS 발송</a>
					<a onclick="fn_pop_email(); return false;" class="btn_sub">이메일 발송</a>
					<a href="#" class="btn_sub">1차성정</a>
					<a onclick="fn_pop_resv(); return false;" class="btn_sub">스크리닝예약</a>
					<a href="#" class="btn_sub">피험자확정</a>
					<a href="#" class="btn_excel">엑셀</a>
				</div>
			</div>
			<!-- //테이블 상단 정보 -->
            <!-- 목록 -->
			<table class="tbl_list">
				<colgroup>
					<col style="width:4%" />
					<col style="width:5%" />
					<col style="width:6%" />
					<col style="width:5%" />
					<col style="width:4%" />
					<col style="width:8%" />
					<col style="width:5%" />
					<col style="width:10%" />
					<col style="width:8%" />
					<col style="width:8%" />
					<col style="width:8%" />
					<col style="width:auto" />
					<col style="width:6%" />
					<col style="width:6%" />
				</colgroup>
				<thead>
					<tr>
						<th scope="col"><input type="checkbox" /></th>
						<th scope="col">번호</th>
						<th scope="col">이름</th>
						<th scope="col">거주지</th>
						<th scope="col">성별</th>
						<th scope="col">생년월일</th>
						<th scope="col">나이</th>
						<th scope="col">핸드폰</th>
						<th scope="col">지원자</th>
						<th scope="col">풀선별</th>
						<th scope="col">1차선정</th>
						<th scope="col">스크리닝</th>
						<th scope="col">피험자확정</th>
						<th scope="col">피험자코드</th>
					</tr>
				</thead>
				<tbody>
					<tr>
						<td><input type="checkbox" /></td>
						<td>3</td>					
						<td>홍길동</td>
						<td>서울</td>
						<td>남</td>
						<td>000000</td>
						<td>00</td>
						<td>010-0000-0000</td>
						<td>지원자</td>
						<td>풀선별</td>
						<td>대상</td>
						<td>예약(0001) 2020-01-01 12:00</td>
						<td>확정</td>
						<td>00</td>
					</tr>
					<tr>
						<td><input type="checkbox" /></td>
						<td>2</td>			
						<td>홍길동</td>
						<td>서울</td>
						<td>남</td>
						<td>000000</td>
						<td>00</td>
						<td>010-0000-0000</td>
						<td>지원자</td>
						<td>풀선별</td>
						<td>대상</td>
						<td>예약(0001) 2020-01-01 12:00</td>
						<td>확정</td>
						<td>00</td>
					</tr>
					<tr>
						<td><input type="checkbox" /></td>
						<td>1</td>					
						<td>홍길동</td>
						<td>서울</td>
						<td>남</td>
						<td>000000</td>
						<td>00</td>
						<td>010-0000-0000</td>
						<td>지원자</td>
						<td>풀선별</td>
						<td>대상</td>
						<td>예약(0001) 2020-01-01 12:00</td>
						<td>확정</td>
						<td>00</td>
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
