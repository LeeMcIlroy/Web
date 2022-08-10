<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c"      uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="form"   uri="http://www.springframework.org/tags/form" %>
<%@ taglib prefix="ui"     uri="http://egovframework.gov/ctl/ui"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="fn"  uri="http://java.sun.com/jsp/jstl/functions" %>
<!doctype html>
<html lang="kr">
<c:import url="/EgovPageLink.do?link=usr/inc/incHead" />
<script>
	//PDF 열기
	function fn_pdfOpen(fileId){
		window.open("<c:out value='${pageContext.request.contextPath}/cmmn/file/pdfOpen.do?fileId='/>"+fileId, "_blank" );
	}
</script>
<body>
<form:form commandName="searchVO" id="frm" name="frm">
	<!-- skip_navigation -->
	<dl id="skip_nav">
		<dt>바로가기 메뉴</dt>
		<dd><a href="#content">본문 바로가기</a></dd>
		<dd><a href="#top_menu">메뉴 바로가기</a></dd>
		<dd><a href="#footer">페이지 하단 바로가기</a></dd>
	</dl>
	<!-- //skip_navigation -->
	<div class="content">
		<!-- header area -->
		<c:import url="/EgovPageLink.do?link=usr/inc/incTopnav" />
		<!-- //header area -->
		<div class="main_content" id="content">
			<div class="width_box">
				<!-- left menu area-->
				<c:import url="/EgovPageLink.do?link=usr/inc/incLeftmenu"/>
				<!-- //left menu area--> 
				<div class="sub_content">
					<c:import url="/EgovPageLink.do?link=usr/inc/incPageTitle">
						<c:param name="dept1" value="한디원소개"/>
						<c:param name="dept2" value="보유과목안내"/>
					</c:import>
					
					<div class="pros_box">
						<div class="pros_title">"2020년 03월 기준" 한디원이 보유하고 있는 학점은행제 표준교육과정 학습과목안내입니다.<br><span class="r_txt">[다운로드]</span>를 클릭하면 해당과목의 강의계획서를 열람할 수 있습니다. (PDF파일)</div>
						<div class="ta_overbox">
							<table class="ta874_ty02" summary="다운로드를 연번, 과목명, 수강료(원), 강의계획서 순서로 보여줍니다.">
								<caption>모집일정</caption>
								<colgroup>
									<col style="width:" />
									<col style="width:" />
									<col style="width:" />
									<col style="width:" />
									<col style="width:" />
								</colgroup>
								<thead>
									<tr style="height:50px;">
										<th scope="col" >연번</th>
										<th scope="col" >과목명</th>
										<th scope="col" >관련전공</th>
										<th scope="col" >수강료(원)</th>
										<th scope="col" >강의계획서</th>
									</tr>
								</thead>
								<tbody>
									<c:forEach var="list" items="${pdfList }" varStatus="status">
										<tr>
											<td><c:out value="${status.count }"/></td>
											<td> 
												<c:out value="${fn:substring(list.pdfName,0,fn:indexOf(list.pdfName, '.pdf')) }"/> 	
											</td>
											<td><c:out value="${list.pdfName2 }"/></td>
<%-- 											<td><fmt:formatNumber value="${list.subjectPrice }" type="currency"/></td>--%>																
										    <td><c:out value="${fn:substring(list.subjectPrice,0,3)}"/>,<c:out value="${fn:substring(list.subjectPrice,3,6)}"/></td>
 
 											<td><a href="#" target="_blank" onclick="fn_pdfOpen(<c:out value='${list.pdfSeq }'/>); return false;">[다운로드]</a></td>
										</tr>
									</c:forEach>
								</tbody>
							</table>
						</div>
					</div>
				</div>
			</div>
			<div class="go_top"><a href="javascript:window.scrollTo(0,0)"><strong>▲</strong><br>TOP</a></div>
		</div>
		<!-- footer -->
		<c:import url="/EgovPageLink.do?link=usr/inc/incFooter" />
		<!-- //footer -->
	</div>
	<input type="hidden" id="message" value="${message}" />
</form:form>
</body>
</html>