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
		location.href = "<c:out value='${pageContext.request.contextPath }/qxsepmny/tmp/ech070401.do'/>";
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
	            <jsp:param name="dept2" value="고객사관리"/>
           	</jsp:include>
			<!-- //타이틀 -->
			<!-- 서브타이틀 -->
			<div class="sub_title_area type02">
				<h4>회사정보</h4>
			</div>
			<!-- //서브타이틀 -->
            <!-- 회사정보 -->
			<table class="tbl_view">
				<colgroup>
					<col style="width:15%" />
					<col style="width:35%" />
					<col style="width:15%" />
					<col style="width:35%" />
				</colgroup>
				<tbody>
					<tr>
						<th scope="row">회사명</th>
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
					<tr>
						<th scope="row">대표자명</th>
						<td>
							<input type="text" />
						</td>
						<th scope="row" class="bl">사업자등록번호</th>
						<td>
							<input type="text" class="p30" />
                            -
                            <input type="text" class="p20" />
                             -
                            <input type="text" class="p40" />
						</td>
					</tr>
					<tr>
						<th scope="row">전화번호</th>
						<td>
							<select class="p25">
                                <option>선택</option>
                            </select>
                            -
                            <input type="text" class="p30" />
                             -
                            <input type="text" class="p30" />
						</td>
						<th scope="row" class="bl">팩스번호</th>
						<td>
							<select class="p25">
                                <option>선택</option>
                            </select>
                            -
                            <input type="text" class="p30" />
                             -
                            <input type="text" class="p30" />
						</td>
					</tr>
					<tr>
						<th scope="row">주소</th>
						<td colspan="3">
							<a href="#" class="btn_sub2">주소검색</a>
							<input type="text" class="p15" />
							<input type="text" class="ta_l p40" />
							<input type="text" class="ta_l p35" placeholder="상세주소" />
						</td>
					</tr>
				</tbody>
			</table>
            <!-- //회사정보 -->
            <!-- 서브타이틀 -->
			<div class="sub_title_area">
				<h4>담당자정보</h4>
			</div>
			<!-- //서브타이틀 -->
            <!-- 담당자정보 -->
			<table class="tbl_view">
				<colgroup>
					<col style="width:15%" />
					<col style="width:35%" />
					<col style="width:15%" />
					<col style="width:35%" />
				</colgroup>
				<tbody>
					<tr>
						<th scope="row">담당자명</th>
						<td>
							<input type="text" />
						</td>
						<th scope="row" class="bl">부서/직위</th>
						<td>
							<input type="text" />
						</td>
					</tr>
					<tr>
						<th scope="row">담당자핸드폰</th>
						<td>
							<select class="p25">
                                <option>선택</option>
                            </select>
                            -
                            <input type="text" class="p30" />
                             -
                            <input type="text" class="p30" />
						</td>
						<th scope="row" class="bl">담당자이메일</th>
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
            <!-- //담당자정보 -->
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