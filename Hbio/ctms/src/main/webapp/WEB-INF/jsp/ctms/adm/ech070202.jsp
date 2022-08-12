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
		location.href = "<c:out value='${pageContext.request.contextPath }/qxsepmny/tmp/ech070201.do'/>";
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
	            <jsp:param name="dept2" value="사용자관리"/>
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
						<th scope="row">사용자ID</th>
						<td>
							<input type="text" />
						</td>
						<th scope="row" class="bl">비밀번호</th>
						<td>
							<input type="password" class="p50" />
							<a href="#" class="btn_sub2">임시비밀번호 SMS발송</a>
						</td>
					</tr>
					<tr>
						<th scope="row">구분</th>
						<td>
							<select>
								<option>선택</option>
							</select>
						</td>
						<th scope="row" class="bl">권한</th>
						<td>
							<select>
								<option>선택</option>
							</select>
						</td>
					</tr>
					<tr>
						<th scope="row">최근로그인</th>
						<td> 2020-01-01 15:30</td>
						<th scope="row" class="bl">가입일시</th>
						<td>2020-01-01 15:30</td>
					</tr>
					<tr>
						<th scope="row">상태</th>
						<td colspan="3">
							<input type="radio" name="useYN" id="useY" />
						    <label for="useY">정상</label>
						    <input type="radio" name="useYN" id="useN" />
						    <label for="useN">정지(로그인차단)</label>
						</td>
					</tr>
				</tbody>
			</table>
            <!-- //기본정보 -->
            <!-- 서브타이틀 -->
			<div class="sub_title_area">
				<h4>사용자정보</h4>
			</div>
			<!-- //서브타이틀 -->
            <!-- 사용자정보 -->
			<table class="tbl_view">
				<colgroup>
					<col style="width:15%" />
					<col style="width:35%" />
					<col style="width:15%" />
					<col style="width:35%" />
				</colgroup>
				<tbody>
					<tr>
						<th scope="row">사용자명</th>
						<td>
							<input type="text" />
						</td>
						<th scope="row" class="bl">지사정보</th>
						<td>
							<select>
								<option>선택</option>
							</select>
						</td>
					</tr>
					<tr>
						<th scope="row">부서</th>
						<td>
							<select>
								<option>선택</option>
							</select>
						</td>
						<th scope="row" class="bl">직위</th>
						<td>
							<input type="text" />
						</td>
					</tr>
					<tr>
						<th scope="row">핸드폰</th>
						<td>
							<select class="p25">
                                <option>선택</option>
                            </select>
                            -
                            <input type="text" class="p30" />
                             -
                            <input type="text" class="p30" />
						</td>
						<th scope="row" class="bl">이메일</th>
						<td>
							<input type="text" class="p30" />
                             @
                            <input type="text" class="p30" />
                            <select class="p30">
                                <option>직접입력</option>
                            </select>
						</td>
					</tr>
				</tbody>
			</table>
            <!-- //사용자정보 -->
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