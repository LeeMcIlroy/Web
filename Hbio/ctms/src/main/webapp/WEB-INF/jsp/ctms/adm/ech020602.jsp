<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c"      uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="form"   uri="http://www.springframework.org/tags/form" %>
<%@ taglib prefix="ui"     uri="http://egovframework.gov/ctl/ui"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ taglib prefix="common" 	uri="/WEB-INF/tld/common.tld"%>
<!doctype html>
<html>
<c:import url="/EgovPageLink.do?link=adm/inc/incHead"/>
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
	            <jsp:param name="dept2" value="연구동의서관리"/>
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
						<td>연구명</td>
					</tr>
				</tbody>
			</table>
			<!-- //연구정보 -->
			<!-- 서브타이틀 -->
			<div class="sub_title_area">
				<h4>피험자정보</h4>
			</div>
			<!-- //서브타이틀 -->
            <!-- 피험자정보 -->
			<table class="tbl_list">
				<colgroup>
					<col style="width:5%" />
					<col style="width:15%" />
					<col style="width:15%" />
					<col style="width:10%" />
					<col style="width:10%" />
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
						<th scope="col">핸드폰</th>
						<th scope="col">개인정보수집동의</th>
						<th scope="col">연구참여동의</th>
					</tr>
				</thead>
				<tbody>
					<tr>
						<td>3</td>					
						<td>홍길동</td>
						<td>000000</td>
						<td>00</td>
						<td>남</td>
						<td>010-0000-0000</td>
						<td><span>완료</span></td>
						<td><span class="unregi">미등록</span></td>
					</tr>
					<tr>
						<td>2</td>					
						<td>홍길동</td>
						<td>000000</td>
						<td>00</td>
						<td>남</td>
						<td>010-0000-0000</td>
						<td><span>완료</span></td>
						<td><span class="unregi">미등록</span></td>
					</tr>
					<tr>
						<td>1</td>					
						<td>홍길동</td>
						<td>000000</td>
						<td>00</td>
						<td>남</td>
						<td>010-0000-0000</td>
						<td><span>완료</span></td>
						<td><span class="unregi">미등록</span></td>
					</tr>
				</tbody>
			</table>
			<!-- //피험자정보 -->
		</div>
		<!-- //contents -->
	</div>
	<!-- //container -->
</div>	
<!-- //wrap -->
</body>
</html>