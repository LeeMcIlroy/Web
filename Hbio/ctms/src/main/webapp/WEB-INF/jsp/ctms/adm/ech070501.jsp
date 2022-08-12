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
		location.href = "<c:out value='${pageContext.request.contextPath }/qxsepmny/tmp/ech070501.do'/>";
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
	            <jsp:param name="dept2" value="메뉴관리"/>
           	</jsp:include>			
			<!-- //타이틀 -->
			<!-- 테이블 상단 정보 -->
			<div class="tbl_top_info">
				<span>
					사용자구분
					<select class="sub">
						<option>연구책임자</option>
					</select>
				</span>
				<!-- 버튼 -->
				<div>
					<a href="#" class="btn_sub type02">저장</a>
				</div>
			</div>
			<!-- //테이블 상단 정보 -->
			<!-- 메뉴목록 -->
			<table class="tbl_list">
				<colgroup>
					<col style="width:40%" />
					<col style="width:50%" />
                    <col style="width:10%" />
				</colgroup>
				<thead>
					<tr>
						<th scope="col">대메뉴</th>
						<th scope="col">소메뉴</th>
						<th scope="col">메뉴노출 <input type="checkbox" /></th>
					</tr>
				</thead>
				<tbody>
					<tr>
						<td>1depth 메뉴명</td>						
						<td>2depth 메뉴명</td>						
						<td><input type="checkbox" /></td>
					</tr>
					<tr>
						<td>1depth 메뉴명</td>						
						<td>2depth 메뉴명</td>						
						<td><input type="checkbox" /></td>
					</tr>
					<tr>
						<td>1depth 메뉴명</td>						
						<td>2depth 메뉴명</td>						
						<td><input type="checkbox" /></td>
					</tr>
				</tbody>
			</table>
			<!-- //메뉴목록 -->
		</div>
		<!-- //contents -->
	</div>
	<!-- //container -->
</div>	
<!-- //wrap -->
</body>
</html>