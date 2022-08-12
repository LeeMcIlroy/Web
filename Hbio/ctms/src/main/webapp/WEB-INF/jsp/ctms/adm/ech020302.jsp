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
	            <jsp:param name="dept2" value="질문답변관리"/>
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
						<th scope="row">질문/답변명</th>
						<td colspan="3">
							<input type="text" class="ta_l type02" />
						</td>
					</tr>
					<tr>
						<th scope="row">유형</th>
						<td>
							<input type="radio" name="answerType" id="answerType_01" />
						    <label for="answerType_01">단일응답</label>
						    <input type="radio" name="answerType" id="answerType_02" />
						    <label for="answerType_02">복수응답</label>
						    <input type="radio" name="answerType" id="answerType_03" />
						    <label for="answerType_03">자유기재형</label>
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
            <!-- //기본정보 -->
            <!-- 서브타이틀 -->
			<div class="sub_title_area">
				<h4>질문/답변</h4>
			</div>
			<!-- //서브타이틀 -->
            <!-- 기본정보 -->
			<table class="tbl_view">
				<colgroup>
					<col style="width:15%" />
					<col style="width:85%" />
				</colgroup>
				<tbody>
					<tr>
						<th scope="row"><i>*</i>질문</th>
						<td>
							<input type="text" class="p65 ta_l" />
							<input type="text" class="p30 ta_l" placeholder="약어" />
						</td>
					</tr>
					<tr>
						<th scope="row"><i>*</i>답변</th>
						<td>
							<div class="que_item">
								<span>항목1</span>
								<input type="text" class="ta_l p70" />
								<a href="#" class="btn_add">추가</a>
							</div>
							<div class="que_item">
								<span>항목2</span>
								<input type="text" class="ta_l p70" />
								<a href="#" class="btn_subtract">삭제</a>
							</div>
							<div class="que_item">
								<span>항목3</span>
								<input type="text" class="ta_l p70" />
								<a href="#" class="btn_subtract">삭제</a>
							</div>
							<div class="que_item">
								<span>항목4</span>
								<input type="text" class="ta_l p70" />
								<a href="#" class="btn_subtract">삭제</a>
							</div>
							<div class="que_item">
								<span>항목5</span>
								<input type="text" class="ta_l p70" />
								<a href="#" class="btn_subtract">삭제</a>
							</div>
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
		</div>
		<!-- //contents -->
	</div>
	<!-- //container -->
</div>	
<!-- //wrap -->
</body>
</html>