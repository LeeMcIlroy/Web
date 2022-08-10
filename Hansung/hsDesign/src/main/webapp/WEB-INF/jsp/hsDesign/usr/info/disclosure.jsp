<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c"      uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="form"   uri="http://www.springframework.org/tags/form" %>
<%@ taglib prefix="ui"     uri="http://egovframework.gov/ctl/ui"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<!DOCTYPE html>
<html lang="ko" >
<c:import url="/EgovPageLink.do?link=usr/inc/incHead" />
<script type="text/javascript">
	//PDF 열기
	function fn_pdfOpen(fileId){
		window.open("<c:out value='${pageContext.request.contextPath}/cmmn/file/pdfOpen.do?fileId='/>"+fileId, "_blank" );
	}
</script>
<body>
<form id="frm" name="frm">
	<!-- skip_navigation -->
	<dl id="skip_nav">
		<dt>바로가기 메뉴</dt>
		<dd><a href="#content">본문 바로가기</a></dd>
		<dd><a href="#top_menu">메뉴 바로가기</a></dd>
		<dd><a href="#footer">페이지 하단 바로가기</a></dd>
	</dl>
	<!-- //skip_navigation -->
	<div class="content">
	<!-- header -->
	<c:import url="/EgovPageLink.do?link=usr/inc/incTopnav" />
	<!--// header -->
	<!-- container -->
	<div class="main_content" id="content">
		<div class="width_box">
			<!-- lnb -->
			<c:import url="/EgovPageLink.do?link=usr/inc/incLeftmenu"/>
			<!--// lnb -->
			<!-- content -->
			<div class="sub_content">
				<!-- 타이틀 영역 -->
				<jsp:include page="/WEB-INF/jsp/hsDesign/usr/inc/incPageTitle.jsp">
					<jsp:param name="dept1" value="한디원소개"/>
		            <jsp:param name="dept2" value="기관정보공시"/>
	           	</jsp:include>
				<div class="disc_box">
					<img src="<c:out value='${pageContext.request.contextPath }/assets/usr/img/disclosure.jpg'/>" style="width:100%;"/>
					<!-- <ol>
						<li>1. 기관 운영규칙 / 시설 등 기본현황
							<ul>
								<li>가. 기관운영규칙 및 평가인정 학습과정 운영에 관한 각종 규정 :</li>
								<li>
									○ 디자인아트교육원 규정 <a href="#"  onclick="fn_pdfOpen('1'); return false;"><span style="color: #000000;">: [다운로드]</span></a><br>
									○ 학사내규 <a href="#"  onclick="fn_pdfOpen('2'); return false;"><span style="color: #000000;">: [다운로드]</span></a>
								</li>
							</ul>
							<ul>
								<li>나. 교사 등 시설 현황 : <a href="#"  onclick="fn_pdfOpen('3'); return false;"><span style="color: #000000;">[다운로드]</span></a></li>
							</ul>
							<ul>
								<li>다. 원격교육 실시 관련 시설/설비현황 : 해당없음</li>
							</ul>
						</li>
						<li>2. 평가인정을 받은 학습과정 현황 및 그 운영에 관한 사항
							<ul>
								<li>가. 평가인정 학습과정 현황 : <a href="#"  onclick="fn_pdfOpen('4'); return false;"><span style="color: #000000;">[다운로드]</span></a></li>
								<li>나. 연간 학습과정 운영일정 : <a href="#"  onclick="fn_pdfOpen('5'); return false;"><span style="color: #000000;">[다운로드]</span></a></li>
							</ul>
						</li>
						<li>3. 학습자 수 등 학습자 현황에 관한 사항 : 학습과정별 학급 수 및 학습자 수 <a href="#"  onclick="fn_pdfOpen('6'); return false;"><span style="color: #000000;">[다운로드]</span></a></li>
						<li>4. 교수 또는 강사 현황에 관한 사항
							<ul>
								<li>가. 교수 또는 강사의 수 :  <a href="#"  onclick="fn_pdfOpen('7'); return false;">[다운로드]</a></li>
								<li>나. 교육훈련기관 전체 교수 또는 강사 대비 해당 교육훈련기관 소속 교수 또는 강사 현황 :  <a href="#"  onclick="fn_pdfOpen('8'); return false;">[다운로드]</a></li>
								<li>다. 교수 또는 강사의 강의 담당 현황 :  <a href="#"  onclick="fn_pdfOpen('9'); return false;">[다운로드]</a></li>
								<li>라. 교수 또는 강사 강의료 :  <a href="#"  onclick="fn_pdfOpen('10'); return false;">[다운로드]</a></li>
							</ul>
						</li>
						<li>5. 학습비 및 회계에 관한 사항
							<ul>
								<li>가. 학습과정별 학습비 : <a href="<c:out value='${pageContext.request.contextPath }/usr/hdaCampus/liberal.do'/>" >[이동하기]</a></li>
								<li>나. 예산 및 결산 :<span style="color: #0000ff;">하단 2016년도 09월 공시자료 확인</span></li>
								<li>다. 장학금 지급 현황 : <span style="color: #0000ff;">하단 2016년도 09월 공시자료 확인</span></li>
							</ul>
						</li>
						<li>6. 법 제5조에 따른 평가인정 취소 등에 관한 사항 :  <a href="#"  onclick="fn_pdfOpen('11'); return false;">[다운로드]</a></li>
						<li>7. 기관 발전계획 및 특성화 계획 : <a href="#"  onclick="fn_pdfOpen('12'); return false;">[다운로드]</a></li>
						<li>8. 그 밖의 교육여건 및 기관 운영현황
							<ul>
								<li>가. 직원 수 : <span style="color: #0000ff;">하단 2016년도 09월 공시자료 확인</span></li>
								<li>나. 학습비 반환 현황 : <span style="color: #0000ff;">하단 2016년도 09월 공시자료 확인</span></li>
							</ul>
						</li>
						<li>※ 기관정보공시전체
							<ul>
								<li>○ 2016.09기준 : <a href="#"  onclick="fn_pdfOpen('13'); return false;">[다운로드]</a></li>
							</ul>
						</li>
					</ol> -->
				</div>
			</div>
		</div>
		<!--// content -->
	</div>
	<!--// container -->
	<hr />
	<!-- footer -->
	<c:import url="/EgovPageLink.do?link=usr/inc/incFooter" />
	<!--// footer -->
</div>
<input type="hidden" id="message" value="${message}" />
</form>
</body>
</html>