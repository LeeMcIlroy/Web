<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c"      uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="form"   uri="http://www.springframework.org/tags/form" %>
<%@ taglib prefix="ui"     uri="http://egovframework.gov/ctl/ui"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml" lang="ko" xml:lang="ko">
<c:import url="/EgovPageLink.do?link=usr/inc/incHead" />
<body>
<div class="wrap">
	<!-- 스킵 네비게이션 -->
	<div id="skip_navigation">
		<ul>
			<li><a href="#gnb">주 메뉴 바로가기</a></li>
			<li><a href="#content">본문 바로가기</a></li>
		</ul>
	</div>
	<!-- header -->
	<c:import url="/EgovPageLink.do?link=usr/inc/incTopnav" />
	<!--// header -->
	<hr />
	<!-- container -->
	<div class="container">
		<!-- lnb -->
		<c:import url="/EgovPageLink.do?link=usr/inc/incLeftmenu" />
		<!--// lnb -->
		<!-- content -->
		<div class="content" id="content">
			<jsp:include page="/WEB-INF/jsp/writer/usr/inc/incPageTitle.jsp">
            	<jsp:param name="dept1" value="대회"/>
            	<jsp:param name="dept2" value="한성인 글쓰기 대회"/>
            </jsp:include>
            <div class="cont_box">
				<div class="book_line02">
					<ul>
						<!-- <li><a href="#p09_txt01"><span>대회 소개</span></a></li> -->
						<li><a href="<c:out value='${pageContext.request.contextPath }/usr/cntst/cntstWriteComList.do'/>"><span>공지사항</span></a></li>
						<li><a href="<c:out value='${pageContext.request.contextPath }/usr/cntst/cntstContestApply.do'/>"><span>대회 신청</span></a></li>
					</ul>
				</div>
				<div class="p09mid_title"><a name="p09_txt01">대회 소개</a></div>
				<dl class="p09_txt02">
					<dt>대회 목적</dt>
					<dd>						
						<dl class="p09_txt_dl">
							<dt><img src="<c:out value='${pageContext.request.contextPath }/assets/usr/img/cw_icon01.jpg'/>" alt="" /></dt>
							<dd>논리적이고<br/>비판적인 사고력 확장 </dd>
						</dl>
						<dl class="p09_txt_dl">
							<dt><img src="<c:out value='${pageContext.request.contextPath }/assets/usr/img/cw_icon02.jpg'/>" alt="" /></dt>
							<dd>주제에 대한<br/>문제해결능력 향상</dd>
						</dl>
						<dl class="p09_txt_dl">
							<dt><img src="<c:out value='${pageContext.request.contextPath }/assets/usr/img/cw_icon03.jpg'/>" alt="" /></dt>
							<dd>사고력과 문제 해결 능력을<br/>글쓰기로 구현하는<br>능력 개발</dd>
						</dl>						
					</dd>
				</dl>
				<dl class	="p09_txt02">
					<dt>신청 자격</dt>
					<dd>
						<ul class="p09_icon02">
							<li>한성대학교 재학생이라면 누구든 신청 가능</li>
						</ul>
					</dd>
				</dl>
				<dl class="p09_txt02">
					<dt>대회 일정</dt>
					<dd>
						<ul class="p09_icon02">
							<li>매년 1학기 (5월 중에 시행)</li>
							<li>상세 일정은 홈페이지 공지사항 참조</li>
						</ul>
					</dd>
				</dl>
				<dl class="p09_txt02">
					<dt>주제</dt>
					<dd>
						<ul class="p09_icon02">
							<li>대회 당일 현장 공지</li>
						</ul>
					</dd>
				</dl>
				<dl class="p09_txt02">
					<dt>심사 기준</dt>
					<dd>
						<div class="cpt_ta">
							<div>글쓰기</div>
							<ul>
								<li>논리 능력</li>
								<li>문제 해결 능력</li>
								<li>표현 능력</li>
							</ul>
						</div>
					</dd>
				</dl>
				
				<div class="p09mid_title"><a name="p09_txt02">대회 신청</a></div>
				<dl class="p09_txt02">
					<dt>대회 신청</dt>
					<dd>
						<!-- <ul class="p09_box_arrow02">
							<li>학생이력관리시스템<br/><a href="http://career.hansung.ac.kr" title="[새창]" target="_blank">http://career.hansung.ac.kr</a></li>
							<li>공모전/경진대회</li>
							<li>한성인 글쓰기 대회</li>
						</ul> -->
						<ul class="p09_icon02">
							<li>글쓰기센터 홈페이지(<a href="https://writer.hansung.ac.kr" target="_blank">https://writer.hansung.ac.kr</a>)에서 신청서 양식 다운로드 후 작성</li>
							<li>작성한 신청서를 이메일(<a href="mailto:contest4354@hansung.ac.kr" target="_blank">contest4354@hansung.ac.kr</a>)로 발송 또는 직접 제출</li>
						</ul>
					</dd>
				</dl>
				<dl class="p09_txt02">
					<dt>대회 당일 준비사항</dt>
					<dd>
						<ul class="p09_icon02">
							<li>신분증(학생증 혹은 주민등록증), 필기도구(볼펜 사용)</li>
						</ul>
					</dd>
				</dl>
				<dl class="p09_txt02">
					<dt style="background:url(none); padding-left:0;">※ 참고사항</dt>
					<dd>
						<ul class="p09_icon02">
							<li>대회 참가 시간과 수업 시간이 겹칠 경우 출석 협조문 발급 가능 </li>
							<!-- 비교과포인트사이트 링크 삭제 - 2021.04.20 -->
							<!-- <li>비교과 포인트 지급 (<a href="http://career.hansung.ac.kr/main.do" target="_blank">http://career.hansung.ac.kr/main.do</a>)</li> -->
							<li>비교과 포인트 지급 </li>
							<li>제출한 글은 교육 및 연구자료로 활용될 수 있습니다.</li>
						</ul>
					</dd>
				</dl>
			</div>
		</div>
		<!--// content -->
	</div>
	<!--// container -->
	<hr />
	<!-- footer -->
	<c:import url="/EgovPageLink.do?link=usr/inc/incFooter" />
	<!--// footer -->
	<input type="hidden" id="message" name="message" value="<c:out value='${message }'/>"/>
</div>
</body>
</html>