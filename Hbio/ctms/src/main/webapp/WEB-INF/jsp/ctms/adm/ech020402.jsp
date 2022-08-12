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
	            <jsp:param name="dept2" value="피부특성관리"/>
           	</jsp:include>
			<!-- //타이틀 -->
			<!-- 서브타이틀 -->
			<div class="sub_title_area type02">
				<h4>기본정보</h4>
			</div>
			<!-- //서브타이틀 -->
            <!-- 기본정보 -->
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
					<tr>
						<th scope="row">eCRF상태</th>
						<td colspan="3">
							<input type="radio" name="eCRFState" id="eCRFState_01" />
						    <label for="eCRFState_01">대기</label>
						    <input type="radio" name="eCRFState" id="eCRFState_02" />
						    <label for="eCRFState_02">작성중</label>
						    <input type="radio" name="eCRFState" id="eCRFState_03" />
						    <label for="eCRFState_03">확정</label>
						</td>
					</tr>
				</tbody>
			</table>
			<!-- //기본정보 -->
            <!-- 버튼 -->
			<div class="btn_area">
				<a href="#" class="type02">취소</a>
				<a href="#">저장</a>
			</div>
			<!-- //버튼 -->
			<!-- 피부특성관리 정보 -->
			<div class="survey_info">
				<table class="tbl_view">
					<colgroup>
						<col style="width:15%" />
						<col style="width:85%" />
					</colgroup>
					<tbody>
						<tr>
							<th scope="row">설문차수</th>
							<td>피부특성관리</td>
						</tr>					
						<tr>
							<th scope="row">템플릿 선택</th>
							<td>
								<select class="p20">
									<option>템플릿구분</option>
								</select>
								<select class="p40">
									<option>템플릿명</option>
								</select>
							</td>
						</tr>
						<tr>
							<th scope="row">설문명</th>
							<td>
								<input type="text" class="type02 ta_l" />
							</td>
						</tr>
						<tr>
							<th scope="row">조사내용</th>
							<td>
								<textarea class="type02"></textarea>
							</td>
						</tr>
						<tr>
							<th scope="row">참여기간</th>
							<td>
								<div class="date_sec">
									<span>
										<input type="text" class="date" />
										<a href="#" class="btn_cld">날짜검색</a>
									</span>
									<em>~</em>
									<span>
										<input type="text" class="date" />
										<a href="#" class="btn_cld">날짜검색</a>
									</span>
								</div>
								<input type="checkbox" name="survey_01" id="survey_01" />
							    <label for="survey_01">방문 설문</label>
							</td>
						</tr>
					</tbody>
				</table>
				<!-- 삭제버튼 -->
				<div class="sub_btn_area">
					<a href="#">삭제</a>
				</div>
				<!-- //삭제버튼 -->
			</div>
			<!-- //피부특성관리 정보 -->
		</div>
		<!-- //contents -->
	</div>
	<!-- //container -->
</div>	
<!-- //wrap -->
</body>
</html>