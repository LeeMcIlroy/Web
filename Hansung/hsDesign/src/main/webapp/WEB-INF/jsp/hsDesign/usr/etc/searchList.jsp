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
</script>
<body>
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
			<!-- content -->
			<div class="sub_content02">
				<c:import url="/EgovPageLink.do?link=usr/inc/incPageTitle">					
					<c:param name="dept2" value="통합검색"/>
				</c:import>
				<div class="all_sh">
					<strong>Search</strong> <input type="text" placeholder="검색어를 입력하세요" /> <a href="#">검색</a>
				</div>
				<div class="sh_info">
					<strong>[한디원]</strong> 에 관한 전체 <span>115</span>건의 검색 결과를 찾았습니다.
				</div>
				<div class="img_list_type">
					<a href="#">
						<ul>
							<li><img src="../../img/news_eximg.jpg" alt="[실내디자인] 2017년 1학기 개강파티" /></li>
							<li>
								<dl>
									<dt>
										<div class="title">[실내디자인] 2017년 1학기 개강파티[실내디자인] 2017년 1학기 개강파티[실내디자인] 2017년 1학기 개강파티[실내디자인] 2017년 1학기 개강파티[실내디자인] 2017년 1학기 개강파티[실내디자인] 2017년 1학기 개강파티</div>
										<div class="date">2017-05-31 | 4556</div>
									</dt>
									<dd>
										실내디자인 전공 2017년 1학기 개강파티를 3월 10일 진행하였습니다. 안녕하세요.  한성대학교 한디원 입학홍보팀입니다. 2018학년도 신ㆍ편입생 면접 일정을 안내해 드립니다.  홈페이지에서 원서접수를 하시면 입학팀에서 개별적으로 면접에
										2018학년도 신ㆍ편입생 면접 일정을 안내해 드립니다. 홈페이지에서 원서접수를 하시면 입학팀에서 개별적으로 면접에...
									</dd>									
									<dd class="navi_link">
										<ul>
											<li>한디원 뉴스</li>
											<li>공지사항</li>
										</ul>									
									</dd>
								</dl>								
							</li>
						</ul>						
					</a>
					<a href="#">
						<ul class="sum_img_none">							
							<li>
								<dl>
									<dt>
										<div class="title">[실내디자인] 2017년 1학기 개강파티[실내디자인] 2017년 1학기 개강파티[실내디자인] 2017년 1학기 개강파티[실내디자인] 2017년 1학기 개강파티[실내디자인] 2017년 1학기 개강파티[실내디자인] 2017년 1학기 개강파티</div>
										<div class="date">2017-05-31 | 4556</div>
									</dt>
									<dd>
										실내디자인 전공 2017년 1학기 개강파티를 3월 10일 진행하였습니다. 안녕하세요.  한성대학교 한디원 입학홍보팀입니다. 2018학년도 신ㆍ편입생 면접 일정을 안내해 드립니다.  홈페이지에서 원서접수를 하시면 입학팀에서 개별적으로 면접에
										2018학년도 신ㆍ편입생 면접 일정을 안내해 드립니다. 홈페이지에서 원서접수를 하시면 입학팀에서 개별적으로 면접에...
									</dd>
									<dd class="navi_link">
										<ul>
											<li>한디원 뉴스</li>
											<li>공지사항</li>
										</ul>									
									</dd>
								</dl>
							</li>
						</ul>
					</a>
				</div>
				<div class="pager">
					<a href="#" class="no_active"><img src="../img/pager_dl_icon.gif" alt="첫 페이지" /></a>
					<a href="#" class="no_active"><img src="../img/pager_dl02_icon.gif" alt="이전 페이지" /></a>
					<a href="#" class="active">1</a>
					<a href="#">2</a>
					<a href="#">3</a>
					<a href="#">4</a>
					<a href="#">5</a>
					<a href="#">6</a>
					<a href="#">7</a>
					<a href="#">8</a>
					<a href="#">9</a>
					<a href="#">10</a>
					<a href="#" class="no_active"><img src="../img/pager_dr02_icon.gif" alt="다음 페이지" /></a>
					<a href="#" class="no_active"><img src="../img/pager_dr_icon.gif" alt="마지막 페이지" /></a>
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
</body>
</html>