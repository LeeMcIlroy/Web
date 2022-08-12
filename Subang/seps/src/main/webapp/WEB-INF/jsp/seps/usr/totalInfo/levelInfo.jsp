<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c"      uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="form"   uri="http://www.springframework.org/tags/form" %>
<%@ taglib prefix="ui"     uri="http://egovframework.gov/ctl/ui"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ taglib prefix="common" 	uri="/WEB-INF/tld/common.tld"%>
<!doctype html>
<html lang="kr">
	<c:import url="/EgovPageLink.do?link=inc/incHead" />
	<body class="sub_page">
	<!-- top menu - start -->
	<c:import url="${pageContext.request.contextPath }/EgovPageLink.do?link=usr/inc/incTopnav"/>
	<!-- top menu - end -->
		<div class="m_body" >
			<!-- left menu - start -->
			<c:import url="${pageContext.request.contextPath }/EgovPageLink.do?link=usr/inc/incLeftnav"/>
			<!-- left menu - end -->
			<div class="main_content">
				<div class="content">
					<div class="m_title">
						<div class="title">수위정보</div>
						<div class="navi">
							<ul>
								<li>HOME</li>
								<li>상세관측정보</li>
								<li>수위정보</li>
							</ul>
						</div>
					</div>
					<fieldset>
						<legend>검색하기</legend>
						<div class="top_sh_box">
							<div class="sh_box">
								<dl>
									<dt>기간</dt>
									<dd>
										<input type="text" id="day_st" class="start_day input_date" /> ~ <input type="text" id="day_st02" class="finish_day input_date" />
									</dd>
								</dl>
							</div>
							<div class="btn_sh"><button>검색</button></div>
							<div class="dw_exl"><a href="#"><img src="<c:out value='${pageContext.request.contextPath}/assets/img/excel_icon.png'/>" alt="엑셀파일 다운로드" /></a></div>
						</div>
					</fieldset>
					<div class="cont_box none_bg pd_0 w100_p_div">
						<div class="multi_box">
							<div>
								<div class="dl_tit">한강대교</div>								
								<div class="dl_cont on_bg"><c:import url="${pageContext.request.contextPath }/EgovPageLink.do?link=usr/graph/hangangGraph"/></div>
							</div>
							<div class="on_bg ptb_10">
								<div class="grid_table_over grid_table_l">
									<table>
										<tbody>
											<tr>
												<td>시간</td>
												<td>12:10</td>
												<td>12:00</td>
												<td>11:50</td>
												<td>11:40</td>
												<td>11:30</td>
												<td>11:20</td>
												<td>11:10</td>
												<td>11:00</td>
												<td>10:50</td>
												<td>10:40</td>
												<td>10:30</td>
												<td>10:20</td>
												<td>10:10</td>
												<td>10:00</td>
											</tr>
											<tr>
												<td>수위</td>
												<td>-5.50</td>
												<td>-5.20</td>
												<td>-5.30</td>
												<td>-5.40</td>
												<td>-5.50</td>
												<td>-5.60</td>
												<td>-5.70</td>
												<td>-5.80</td>
												<td>-5.90</td>
												<td>-5.10</td>
												<td>-5.11</td>
												<td>-5.12</td>
												<td>-5.13</td>
												<td>-5.14</td>
											</tr>
											<tr>
												<td>단계</td>
												<td>평시</td>
												<td>평시</td>
												<td>평시</td>
												<td>평시</td>
												<td>평시</td>
												<td>평시</td>
												<td>평시</td>
												<td>평시</td>
												<td>관심</td>
												<td>평시</td>
												<td>평시</td>
												<td>평시</td>
												<td>평시</td>
												<td>평시</td>
											</tr>
										</tbody>
									</table>
								</div>
							</div>
						</div>
						<div class="multi_box">
							<div>
								<div class="dl_tit">청담대교</div>
								<div class="dl_cont on_bg"><c:import url="${pageContext.request.contextPath }/EgovPageLink.do?link=usr/graph/cheongdamGraph"/></div>
							</div>
							<div class="on_bg ptb_10">
								<div class="grid_table_over grid_table_l">
									<table>
										<tbody>
											<tr>
												<td>시간</td>
												<td>12:10</td>
												<td>12:00</td>
												<td>11:50</td>
												<td>11:40</td>
												<td>11:30</td>
												<td>11:20</td>
												<td>11:10</td>
												<td>11:00</td>
												<td>10:50</td>
												<td>10:40</td>
												<td>10:30</td>
												<td>10:20</td>
												<td>10:10</td>
												<td>10:00</td>
											</tr>
											<tr>
												<td>수위</td>
												<td>2.50</td>
												<td>2.20</td>
												<td>2.30</td>
												<td>2.40</td>
												<td>2.50</td>
												<td>2.60</td>
												<td>2.70</td>
												<td>2.80</td>
												<td>2.90</td>
												<td>2.10</td>
												<td>2.11</td>
												<td>2.12</td>
												<td>2.13</td>
												<td>2.14</td>
											</tr>
											<tr>
												<td>단계</td>
												<td>평시</td>
												<td>평시</td>
												<td>평시</td>
												<td>평시</td>
												<td>평시</td>
												<td>평시</td>
												<td>평시</td>
												<td>평시</td>
												<td>관심</td>
												<td>평시</td>
												<td>평시</td>
												<td>평시</td>
												<td>평시</td>
												<td>평시</td>
											</tr>
										</tbody>
									</table>
								</div>
							</div>
						</div>
						<div class="multi_box">
							<div>
								<div class="dl_tit">신곡교</div>								
								<div class="dl_cont on_bg"><c:import url="${pageContext.request.contextPath }/EgovPageLink.do?link=usr/graph/singokGraph"/></div>
							</div>
							<div class="on_bg ptb_10">
								<div class="grid_table_over grid_table_l">
									<table>
										<tbody>
											<tr>
												<td>시간</td>
												<td>12:10</td>
												<td>12:00</td>
												<td>11:50</td>
												<td>11:40</td>
												<td>11:30</td>
												<td>11:20</td>
												<td>11:10</td>
												<td>11:00</td>
												<td>10:50</td>
												<td>10:40</td>
												<td>10:30</td>
												<td>10:20</td>
												<td>10:10</td>
												<td>10:00</td>
											</tr>
											<tr>
												<td>수위</td>
												<td>2.50</td>
												<td>2.20</td>
												<td>2.30</td>
												<td>2.40</td>
												<td>2.50</td>
												<td>2.60</td>
												<td>2.70</td>
												<td>2.80</td>
												<td>2.90</td>
												<td>2.10</td>
												<td>2.11</td>
												<td>2.12</td>
												<td>2.13</td>
												<td>2.14</td>
											</tr>
											<tr>
												<td>단계</td>
												<td>평시</td>
												<td>평시</td>
												<td>평시</td>
												<td>평시</td>
												<td>평시</td>
												<td>평시</td>
												<td>평시</td>
												<td>평시</td>
												<td>관심</td>
												<td>평시</td>
												<td>평시</td>
												<td>평시</td>
												<td>평시</td>
												<td>평시</td>
											</tr>
										</tbody>
									</table>
								</div>
							</div>
						</div>
						<div class="multi_box">
							<div>
								<div class="dl_tit">팔당댐</div>
								<div class="dl_cont on_bg"><c:import url="${pageContext.request.contextPath }/EgovPageLink.do?link=usr/graph/paldangGraph"/></div>
							</div>
							<div class="on_bg ptb_10">
								<div class="grid_table_over grid_table_l">
									<table>
										<tbody>
											<tr>
												<td>시간</td>
												<td>12:10</td>
												<td>12:00</td>
												<td>11:50</td>
												<td>11:40</td>
												<td>11:30</td>
												<td>11:20</td>
												<td>11:10</td>
												<td>11:00</td>
												<td>10:50</td>
												<td>10:40</td>
												<td>10:30</td>
												<td>10:20</td>
												<td>10:10</td>
												<td>10:00</td>
											</tr>
											<tr>
												<td>방류량</td>
												<td>9,500</td>
												<td>9,200</td>
												<td>9,300</td>
												<td>9,400</td>
												<td>9,500</td>
												<td>9,600</td>
												<td>9,700</td>
												<td>9,800</td>
												<td>9,900</td>
												<td>9,100</td>
												<td>9,110</td>
												<td>9,120</td>
												<td>9,130</td>
												<td>9,140</td>
											</tr>
											<tr>
												<td>단계</td>
												<td>평시</td>
												<td>평시</td>
												<td>평시</td>
												<td>평시</td>
												<td>평시</td>
												<td>평시</td>
												<td>평시</td>
												<td>평시</td>
												<td>관심</td>
												<td>평시</td>
												<td>평시</td>
												<td>평시</td>
												<td>평시</td>
												<td>평시</td>
											</tr>
										</tbody>
									</table>
								</div>
							</div>
						</div>
					</div>
				</div>
			</div>
		</div>
		<!-- footer -->
		<c:import url="${pageContext.request.contextPath }/EgovPageLink.do?link=usr/inc/incFooter"/>
		<!-- footer -->
	</body>
</html>
