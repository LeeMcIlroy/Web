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
		window.open("<c:out value='${pageContext.request.contextPath }/qxsepmny/tmp/ech020703.do'/>"
					, '피부자극등록', 'width=1000, height=500, menubar=no, status=no, toolbar=no, scrollbars=1');
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
				<jsp:param name="dept1" value="자료추출"/>
	            <jsp:param name="dept2" value="피부자극결과"/>
           	</jsp:include>
           	<!-- //타이틀 -->
            <!-- 목록 -->
			<table class="tbl_list multi_hd">
				<colgroup>
					<col style="width:auto" />
					<col style="width:12%" />
					<col style="width:12%" />
					<col style="width:12%" />
					<col style="width:12%" />
					<col style="width:12%" />
					<col style="width:12%" />
					<col style="width:10%" />
				</colgroup>
				<thead>
					<tr>
						<th scope="col" rowspan="3">식별코드</th>
						<th scope="col" colspan="6">시험불질</th>
						<th scope="col" rowspan="3">등록</th>
					</tr>
					<tr>
						<th scope="col" colspan="3" class="bl">첩포 제거 30분 후</th>
						<th scope="col" colspan="3">첩포 제거 24시간 후</th>
					</tr>
					<tr>
						<th scope="col" class="bl">#12<br />(N.C)</th>
						<th scope="col">#13<br />(N.C)</th>
						<th scope="col">#3</th>
						<th scope="col">#12<br />(N.C)</th>
						<th scope="col">#13<br />(N.C)</th>
						<th scope="col">#3</th>
					</tr>
				</thead>
				<tbody>
					<tr>
						<td>20013-5-01</td>
						<td>0</td>						
						<td>0</td>
						<td>0</td>
						<td>0</td>
						<td>0</td>
						<td>0</td>
						<td><a onclick="fn_pop(); return false;" class="btn_sub">등록</a></td>
					</tr>
					<tr>
						<td>20013-5-02</td>
						<td>0</td>						
						<td>0</td>
						<td>0</td>
						<td>0</td>
						<td>0</td>
						<td>0</td>
						<td><a onclick="fn_pop(); return false;" class="btn_sub">등록</a></td>
					</tr>
					<tr>
						<td>20013-5-03</td>
						<td>0</td>						
						<td>0</td>
						<td>0</td>
						<td>0</td>
						<td>0</td>
						<td>0</td>
						<td><a onclick="fn_pop(); return false;" class="btn_sub">등록</a></td>
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