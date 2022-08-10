<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c"      uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="form"   uri="http://www.springframework.org/tags/form" %>
<%@ taglib prefix="ui"     uri="http://egovframework.gov/ctl/ui"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<!DOCTYPE html>
<html lang="ko" >
<c:import url="/EgovPageLink.do?link=usr/inc/incHead" />
<body>
<input type="hidden" id="cbcoRegName" name="cbcoRegName" value="${cmmBoardVO.regName }"/>
<input type="hidden" id="cbcoSeq" name="cbcoSeq" />
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
					<jsp:param name="dept1" value="비학위과정"/>
		            <jsp:param name="dept2" value="수강문의"/>
	           	</jsp:include>
		
				<div class="transform_table notice_type">
					<div class="tbl_view">
						<ul class="tbl_view_m">
							<li class="txt_left"><strong><span style="color:#ff0000">비학위과정 FAQ</span></strong></li>
							<li>작성자 : 관리자</li>
							<li>2021-01-25</li>
							<li>-</li>
						</ul>
						<div class="tbl_cont">
							<p><strong><strong>1. </strong><strong>입금 수단 변경 </strong></strong></p>
							<p>Q. 수강신청 후 무통장입금 신청했는데, 카드 결제 가능한가요?</p>
							<p>A. 네. 가능합니다. 마찬가지로 카드결제 신청 후 무통장입금도 가능합니다.</p>
							<p>&nbsp;</p>
							<p><strong><strong>2. </strong><strong>무통장 입금 </strong></strong></p>
							<p>Q. 무통장입금을 위한 계좌번호는 어디에 있나요?</p>
							<p>A. 수강신청 작성 화면 하단에서 확인 가능합니다.</p>
							<p><br/><img src="${pageContext.request.contextPath }/assets/adm/img/faq_img01.jpg" width="100%"/></p>
							<p>&nbsp;</p>
							<p><strong><strong>3. </strong><strong>수강신청과 수강료 납부 </strong></strong></p>
							<p>Q. 수강신청 후 수강료 납부를 하지 않아도 수업을 들을 수 있나요?</p>
							<p>A. 아니오. 수강료를 납부하여야 수강 가능합니다.</p>
							<p><span style="color:#ff0000">또한 과정이 선착순 마감인 경우, 수강신청 순이 아닌 수강료 납부 순으로 마감됩니다.</span></p>							
							<p>&nbsp;</p>
							<p><strong><strong>4. </strong><strong>개강 전 안내 </strong></strong></p>
							<p>Q. 개강 전에 별도 안내를 받을 수 있나요?</p>
							<p>A. 네. 개강 전 수강료 납부 완료자 대상으로 안내 문자를 발송합니다.</p>
							<p>&nbsp;</p>
							<p><strong><strong>5. </strong><strong>개강 후 수강 신청 </strong></strong></p>
							<p>Q. 개강 후에도 수강신청하고 수강료 납부하여 수강 가능한가요?</p>
							<p>A. 가능합니다. 교학팀으로 문의해주시기 바랍니다.</p>
							<p><strong>&nbsp;</strong></p>
							<p><strong><strong>6. </strong><strong>환불 관련</strong></strong></p>
							<p>Q. 환불 기준이 궁금합니다.</p>
							<p>A. 환불 기준은 평생교육법 시행령에 의거합니다.</p>
							<p>디자인아트교육원 홈페이지 <span style="color:#0000ff">https://edubank.hansung.ac.kr/</span> - 학사안내 &ndash; 양식자료실 &ndash; 일반교양과정(비학위과정) 환불 신청서 하단에서 확인 가능합니다.</p>
							<p><br/><img src="${pageContext.request.contextPath }/assets/adm/img/faq_img02.jpg" width="100%"/></p>
							<p><strong>&nbsp;</strong></p>
							<p><strong><strong>7. </strong><strong>환불 신청</strong></strong></p>
							<p>①환불 신청서(디자인아트교육원 홈페이지 <span style="color:#0000ff">https://edubank.hansung.ac.kr/</span> - 학사안내 &ndash; 양식자료실 &ndash; 일반교양과정(비학위과정) 환불 신청서)</p>
							<p>②본인명의 통장사본</p>
							<p>③신분증사본</p>
							<p>상기의 서류를 준비하시어 <span style="color:#800080">edulife@hansung.ac.kr</span> 로 발송해주세요.</p>
							<p>*최소 1주-최대 2주 소요</p>
							<p><strong>&nbsp;</strong></p>
							<p><strong><span style="color:#ff0000"><strong>8. </strong><strong>교육장학금 신청 </strong></span></strong></p>
							<p>Q. 교육장학금이 뭔가요? 교육장학금은 어떻게 신청하나요?</p>
							<p>A. 교육장학금은 본교재학생들을 위해 취업지원팀에서 지원하는 장학금입니다..</p>
							<p>따라서 <span style="color:#ff0000">장학금 지원 한도와 같은 사항은 취업지원팀에 문의</span>하시면 됩니다.</p>
							<p>교육장학금은 출석률 80% 수강생을 대상으로 하는 <span style="color:#ff0000">사후 장학금</span>으로 <span style="color:#ff0000">증명서류 요청(수강확인서, 납입내역서)은 한디원으로, 서류 제출 및 장학금 수령은 취업지원팀</span>에 요청하세요.</p>
							<p>취업지원팀 02-760-4295</p>
							<p><strong>&nbsp;</strong></p>
							<p><strong><span style="color:#ff0000"><strong>9. </strong><strong>한디원 재학생들 위한 장학금은 없나요? </strong></span></strong></p>
							<p>한디원 재학생들은 <span style="color:#ff0000">별도의 절차 없이 수강료 납부 시,</span> 감면 적용된 금액을 납부하면 됩니다.</p>
						</div>
					</div>
				</div>
				<div class="btn_box" >
				    <a href="#" class="btn_go_list" onclick="history.back(-1);">목록</a>
				</div>
				<!-- rolling banner -->
				<c:import url="/EgovPageLink.do?link=usr/inc/incRollingBanner"/>
				<!-- //rolling banner -->
				<div class="go_top"><a href="javascript:window.scrollTo(0,0)"><strong>▲</strong><br>TOP</a></div>
			</div>
			<!--// content -->
		</div>
	</div>
	<!--// container -->
	<hr />
	<!-- footer -->
	<c:import url="/EgovPageLink.do?link=usr/inc/incFooter" />
	<!--// footer -->
</div>
</body>
</html>