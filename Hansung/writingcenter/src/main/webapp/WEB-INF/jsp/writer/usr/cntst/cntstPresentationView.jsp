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
            	<jsp:param name="dept2" value="한성인 프레젠테이션 대회"/>
            </jsp:include>
			<div class="cont_box">
				<div class="book_line02">
					<ul>
						<!-- <li><a href="#p09_txt01"><span>공지사항</span></a></li> -->
						<li><a href="<c:out value='${pageContext.request.contextPath }/usr/cntst/cntstPptComList.do'/>"><span>공지사항</span></a></li>
						<li><a href="<c:out value='${pageContext.request.contextPath }/usr/cntst/cntstContestPptApply.do'/>"><span>대회 신청</span></a></li>
					</ul>
				</div>
				<div class="p09mid_title"><a name="p09_txt01">대회 소개</a></div>
				<dl class="p09_txt02">
					<dt>대회 목적</dt>
					<dd>						
						<dl class="p09_txt_dl">
							<dt><img src="<c:out value='${pageContext.request.contextPath }/assets/usr/img/cw02_icon01.jpg'/>" alt="" /></dt>
							<dd>다양한 주제 발표를 통해<br/>참신한 표현 전략 개발</dd>
						</dl>
						<dl class="p09_txt_dl">
							<dt><img src="<c:out value='${pageContext.request.contextPath }/assets/usr/img/cw02_icon02.jpg'/>" alt="" /></dt>
							<dd>논리적이고<br/>구조적인 사고력 확장</dd>
						</dl>
						<dl class="p09_txt_dl">
							<dt><img src="<c:out value='${pageContext.request.contextPath }/assets/usr/img/cw02_icon03.jpg'/>" alt="" /></dt>
							<dd>현대사회가 요구하는<br/>프레젠테이션문서 작성과<br/>발표 능력 향상</dd>
						</dl>						
					</dd>
				</dl>
				<dl class="p09_txt02">
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
							<li>매년 2학기 (11월 중에 시행)</li>
							<li>상세 일정은 홈페이지 공지사항 참조</li>
							<li class="no_icon_alt_txt">※ 한성인 프레젠테이션 대회는 예선과  본선, 두 차례로 이루어집니다.<br/>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;예선 후 홈페이지에 본선 진출자 명단이 공개되며, 예선 일주일 후에 본선이 있습니다.</li>
						</ul>
					</dd>
				</dl>
				<dl class="p09_txt02">
					<dt>주제</dt>
					<dd>
						<ul class="p09_icon02">
							<li>본선 한 달 전에 글쓰기센터 홈페이지에 주제 공지</li>
							<li>지정 주제 가운데 하나의 주제를 선택하여 발표</li>
						</ul>
					</dd>
				</dl>
				<dl class="p09_txt02">
					<dt>심사기준</dt>
					<dd>
						<div class="cpt_ta02">
							<ul>
								<li>논리적 구성 및 전달력</li>
								<li>내용의 창의성</li>
								<li>전달 및 설득 방법의 창의성 </li>
								<li>슬라이드 구성 능력</li>
							</ul>
						</div>
					</dd>
				</dl>
				<div class="p09mid_title"><a name="p09_txt02">대회 신청 안내</a></div>
				<dl class="p09_txt02">
					<dt>대회 신청</dt>
					<dd>
						<ul class="p09_box_arrow02">
							<li>학생이력관리시스템<br/><a href="http://career.hansung.ac.kr" target="_blank" title="[새창]">http://career.hansung.ac.kr</a></li>
							<li>공모전/경진대회</li>
							<li>한성인 프레젠테이션 대회</li>
						</ul>
						<ul class="p09_icon02">
							<li class="no_icon_alt_txt" style="padding-left:0;">※  팀으로 신청 가능</li>
						</ul>
					</dd>
				</dl>
				<dl class="p09_txt02">
					<dt>예선 준비사항</dt>
					<dd>
						<ul class="p09_icon02">
							<li>예선 전날 오후 6시까지 이메일로 PPT 파일 제출 (contest4354@hansung.ac.kr)</li>
						</ul>
					</dd>
				</dl>
				<dl class="p09_txt02">
					<dt>본선 준비사항</dt>
					<dd>
						<ul class="p09_icon02">
							<li>발표에 사용할 PPT 파일</li>
							<li>심사위원 제출용 PPT 인쇄물 9부 (한 페이지에 두 개의 슬라이드가 들어가도록 구성할 것)</li>
						</ul>
					</dd>
				</dl>
				<dl class="p09_txt02">
					<dt style="background:url(none); padding-left:0;">※ 참고사항</dt>
					<dd>
						<ul class="p09_icon02">
							<li>지정 주제에 대한 필독 사항을 글쓰기센터 홈페이지 공지사항에서 반드시 숙지할 것</li>
							<li>대회 참가 시간과 수업 시간이 겹칠 경우 출석 협조문 발급 가능 </li>
							<li>비교과 포인트 지급 (<a href="http://career.hansung.ac.kr/main.do" target="_blank">http://career.hansung.ac.kr/main.do</a>)</li>
							<li>대회 발표 영상은 교육 및 연구 자료로 활용될 수 있습니다.</li>
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
	<input type="hidden" name="message" id="message" value="<c:out value='${message }'/>"/>
</div>
</body>
</html>