<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c"      uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="form"   uri="http://www.springframework.org/tags/form" %>
<%@ taglib prefix="ui"     uri="http://egovframework.gov/ctl/ui"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ taglib prefix="common" 	uri="/WEB-INF/tld/common.tld"%>
<!DOCTYPE html>
<html lang="ko">
<c:import url="/EgovPageLink.do?link=adm/inc/incHead"/>
<body>
	<c:import url="/EgovPageLink.do?link=adm/inc/incTopnav"/>
	<!-- contents -->
	<div class="content-box">
		<div class="contents">
			<!-- left menu -->
			<c:import url="/EgovPageLink.do?link=adm/inc/incLeftmenu"/>
			<!--// left menu -->
			<div class="main-content">
				<jsp:include page="/WEB-INF/jsp/lcms/adm/inc/incPageTitle.jsp">
					<jsp:param name="dept1" value="수업"/>
		            <jsp:param name="dept2" value="성적"/>
	           	</jsp:include>
				<!-- search -->
				<div class="search-box none-option">
					<input type="checkbox" id="search-option-open" />
					<div class="search web"><!-- 모바일 수정 -->
						<div class="search-input">
							<table class="shearch-option">
								<colgroup>
									<col style="width:8%;" />
									<col />
								</colgroup>
								<tbody>
									<tr>
										<td>대상학기</td>
										<td>
											<select>
												<option><c:out value="${resultMap.lectYear }"/></option>
											</select>
											<select>
												<option><c:out value="${resultMap.lectSem }"/></option>
											</select>
										</td>
									</tr>
								</tbody>
							</table>
						</div>
					</div>
				</div>
				<!--// search -->
				<p class="sub-title">기본 정보</p>
				<!-- table -->
				<div class="list-table-box">
					<table class="normal-wmv-table">
						<colgroup>
							<col style="width:10%;" />
							<col style="width:40%;" />
							<col style="width:10%;" />
							<col style="width:40%;" />
						</colgroup>
						<tbody>
							<tr>
								<th>과목명</th>
								<td>
									<c:out value="${resultMap.lectName }" />
								</td>
								<th>분반</th>
								<td>
									<c:out value="${resultMap.lectDivi }" />
								</td>
							</tr>
							<tr>
								<th>학번</th>
								<td>
									<c:out value="${resultMap.memberCode }" />
								</td>
								<th>이름</th>
								<td>
									<c:out value="${resultMap.name }" />
								</td>
							</tr>
						</tbody>
					</table>
				</div>
				<p class="sub-title">성적현황</p>
				<!-- table -->
				<div class="list-table-box">
					<table class="normal-list-table">
						<colgroup>
							<col />
							<col />
							<col />
							<col />
							<col />
							<col />
							<col />
							<col />
							<col />
							<col />
							<col />
							<col />
							<col style="width:8%;" />
						</colgroup>
						<thead>
							<tr>
								<th colspan="4">중간시험</th>
								<th colspan="4">기말시험</th>
								<th colspan="4">영역별평균</th>
								<th rowspan="3">평균</th>
							</tr>
							<tr>
								<th colspan="2">표현능력</th>
								<th colspan="2">이해능력</th>
								<th colspan="2">표현능력</th>
								<th colspan="2">이해능력</th>
								<th colspan="2">표현능력</th>
								<th colspan="2">이해능력</th>
							</tr>
							<tr>
								<th>말하기</th>
								<th>쓰기</th>
								<th>듣기</th>
								<th>읽기</th>
								<th>말하기</th>
								<th>쓰기</th>
								<th>듣기</th>
								<th>읽기</th>
								<th>말하기</th>
								<th>쓰기</th>
								<th>듣기</th>
								<th>읽기</th>
							</tr>
						</thead>
						<tbody>
							<tr>
								<td style="<c:out value='${resultMap.midSpeak < 60?"color:#fc6039":"" }'/>"><c:out value="${resultMap.midSpeak }"/></td>
								<td style="<c:out value='${resultMap.midWrite < 60?"color:#fc6039":"" }'/>"><c:out value="${resultMap.midWrite }"/></td>
								<td style="<c:out value='${resultMap.midListen < 60?"color:#fc6039":"" }'/>"><c:out value="${resultMap.midListen }"/></td>
								<td style="<c:out value='${resultMap.midRead < 60?"color:#fc6039":"" }'/>"><c:out value="${resultMap.midRead }"/></td>
								<td style="<c:out value='${resultMap.finSpeak < 60?"color:#fc6039":"" }'/>"><c:out value="${resultMap.finSpeak }"/></td>
								<td style="<c:out value='${resultMap.finWrite < 60?"color:#fc6039":"" }'/>"><c:out value="${resultMap.finWrite }"/></td>
								<td style="<c:out value='${resultMap.finListen < 60?"color:#fc6039":"" }'/>"><c:out value="${resultMap.finListen }"/></td>
								<td style="<c:out value='${resultMap.finRead < 60?"color:#fc6039":"" }'/>"><c:out value="${resultMap.finRead }"/></td>
								<td><c:out value="${resultMap.avgSpeak }"/></td>
								<td><c:out value="${resultMap.avgWrite }"/></td>
								<td><c:out value="${resultMap.avgListen }"/></td>
								<td><c:out value="${resultMap.avgRead }"/></td>
								<td style="<c:out value='${resultMap.avgTotal < 70?"color:#fc6039":"" }'/>"><c:out value="${resultMap.avgTotal }"/></td>
							</tr>
						</tbody>
					</table>
				</div>
				<!--// table -->
				<!--// table -->
			</div>
		</div>
	</div>
	<!--// contents -->
	<!-- footer -->
	<c:import url="/EgovPageLink.do?link=adm/inc/incFooter"/>
	<!--// footer -->
</body>
</html>