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
	function fn_pop(){
		window.open("<c:out value='${pageContext.request.contextPath }/qxsepmny/tmp/ech020203.do'/>"
					, '템플릿관리미리보기', 'width=1000, height=500, menubar=no, status=no, toolbar=no, scrollbars=1');
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
	            <jsp:param name="dept2" value="템플릿관리"/>
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
						<th scope="row">템플릿코드</th>
						<td>
							<input type="text" disabled="disabled" />
						</td>
						<th scope="row" class="bl">템플릿구분</th>
						<td>
							<select>
								<option>선택</option>
							</select>
						</td>
					</tr>
					<tr>
						<th scope="row">템플릿명</th>
						<td>
							<input type="text" />
						</td>
						<th scope="row" class="bl">사용기간</th>
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
						</td>
					</tr>
					<tr>
						<th scope="row">사용여부</th>
						<td colspan="3">
							<input type="radio" name="useYN" id="useY" />
						    <label for="useY">사용</label>
						    <input type="radio" name="useYN" id="useN" />
						    <label for="useN">미사용</label>
						</td>
					</tr>
				</tbody>
			</table>
            <!-- //기본정보 -->
            <!-- 버튼 -->
			<div class="btn_area">
				<a href="#" class="type02">취소</a>
				<a href="#">저장</a>
				<!-- 미리보기 -->
				<div>
					<a onclick="fn_pop(); return false;" class="btn_sub type02">미리보기</a>
				</div>
				<!-- //미리보기 -->
			</div>
			<!-- //버튼 -->
			<!-- 질문 정보 -->
			<div class="question_info">
				<p>질문1</p>
				<table class="tbl_view">
					<colgroup>
						<col style="width:15%" />
						<col style="width:85%" />
					</colgroup>
					<tbody>
						<tr>
							<th scope="row"><i>*</i>유형</th>
							<td>
								<input type="radio" name="answerType01" id="answerType01_01" />
							    <label for="answerType01_01">단일응답</label>
							    <input type="radio" name="answerType01" id="answerType01_02" />
							    <label for="answerType01_02">복수응답</label>
							    <input type="radio" name="answerType01" id="answerType01_03" />
							    <label for="answerType01_03">자유기재형</label>
								&nbsp;&nbsp;&nbsp;
								<select class="p60">
									<option>질문/답변 불러오기</option>
								</select>
							</td>
						</tr>					
						<tr>
							<th scope="row"><i>*</i>질문</th>
							<td>
								<input type="text" class="ta_l" />
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
							</td>
						</tr>
					</tbody>
				</table>
				<!-- 삭제버튼 -->
				<div class="sub_btn_area type02">
					<a href="#">삭제</a>
				</div>
				<!-- //삭제버튼 -->
			</div>
			<!-- //질문 정보 -->
			<!-- 질문 정보 -->
			<div class="question_info">
				<p>질문2</p>
				<table class="tbl_view">
					<colgroup>
						<col style="width:15%" />
						<col style="width:85%" />
					</colgroup>
					<tbody>
						<tr>
							<th scope="row"><i>*</i>유형</th>
							<td>
								<input type="radio" name="answerType02" id="answerType02_01" />
							    <label for="answerType02_01">단일응답</label>
							    <input type="radio" name="answerType02" id="answerType02_02" />
							    <label for="answerType02_02">복수응답</label>
							    <input type="radio" name="answerType02" id="answerType02_03" />
							    <label for="answerType02_03">자유기재형</label>
								&nbsp;&nbsp;&nbsp;
								<select class="p60">
									<option>질문/답변 불러오기</option>
								</select>
							</td>
						</tr>					
						<tr>
							<th scope="row"><i>*</i>질문</th>
							<td>
								<input type="text" class="ta_l" />
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
							</td>
						</tr>
					</tbody>
				</table>
				<!-- 삭제버튼 -->
				<div class="sub_btn_area type02">
					<a href="#">삭제</a>
				</div>
				<!-- //삭제버튼 -->
			</div>
			<!-- //질문 정보 -->
			<!-- 설문지 추가 버튼 -->
			<a href="#" class="btm_btn">질문 추가 +</a>
			<!-- //설문지 추가 버튼 -->
		</div>
		<!-- //contents -->
	</div>
	<!-- //container -->
</div>	
<!-- //wrap -->
</body>
</html>