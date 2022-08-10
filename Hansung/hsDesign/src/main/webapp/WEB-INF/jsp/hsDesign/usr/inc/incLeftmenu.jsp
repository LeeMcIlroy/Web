<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page import="hsDesign.valueObject.cmm.CmmnSearchVO"%> 
<%
	String menuNo = ((String)session.getAttribute("menuNo")!=null)?(String)session.getAttribute("menuNo"):"";
	
	// 190304  김현영 자랑스러운 한디원  - festival 메뉴번호 지정.
	// 191111 김현영 재수정
	CmmnSearchVO searchVO = (CmmnSearchVO)request.getAttribute("searchVO");
	if(searchVO!=null) {
		String menuType = (String)searchVO.getMenuType();
		if("0701".equals(menuType)) {
			menuNo = "4013";
		}
	}
%>
<!-- 200402수정 -->
<div class="left_area">
	<% if( menuNo.indexOf("40")==0 ){%>
		<div class="left_title">한디원소개</div>
		<ul class="left_menu_link">
			<li <% if( menuNo.indexOf("403")==0 ){ %> class="active" <%}%>>
				<a href="<c:out value='${pageContext.request.contextPath }/usr/info/ledgerGreeting.do'/>">원장인사말</a>
			</li>
			<li <% if( menuNo.equals("401") ){ %> class="active" <%}%>>
				<a href="<c:out value='${pageContext.request.contextPath }/usr/info/hdIntro.do'/>">한디원소개</a>
			</li>
			<li <% if( menuNo.equals("4011")|| menuNo.equals("40504") ){ %> class="active" <%}%>>
					<a href="<c:out value='${pageContext.request.contextPath }/usr/community/proud/proudList.do'/>">한디원 이슈</a>
			</li>
			<%-- <li <% if( menuNo.indexOf("23001")==0 ){ %> class="active" <%}%>>

					<a href="<c:out value='${pageContext.request.contextPath }/usr/community/overseas/overseas.do'/>">해외프로그램</a>
 					<a href="<c:out value='${pageContext.request.contextPath }/usr/info/promotionVideo.do'/>">해외프로그램</a> 
			</li>--%>
			<li <% if( menuNo.indexOf("40231")==0 ){ %> class="active" <%}%>>
				<a href="<c:out value='${pageContext.request.contextPath }/usr/community/overseas/overseas.do'/>">해외프로그램</a>
				<ul style="display:inline-block; height:80px;" >
					<li<% if( menuNo.indexOf("40231")==0 ){%> <%}%>><a href="<c:out value='${pageContext.request.contextPath }/usr/community/overseas/overseas.do'/>">해외인턴십</a></li>
					<li<% if( menuNo.indexOf("40233")==0 ){%> <%}%>><a href="<c:out value='${pageContext.request.contextPath }/usr/community/oveServ/oveServ.do'/>">해외봉사</a></li>
									
				</ul>
			</li>
			<%--<li <% if( menuNo.indexOf("402")==0 ){ %> class="active" <%}%>>
				<a href="<c:out value='${pageContext.request.contextPath }/usr/info/presidentGreeting.do'/>">총장인사말</a>
			</li>--%>
		
			<!-- <li <% if( menuNo.indexOf("407")==0 ){ %> class="active" <%}%>>
				<a href="<c:out value='${pageContext.request.contextPath }/usr/info/disclosure.do'/>">기관정보공시</a>
			</li> -->
			<!-- 200402 메뉴개편 추가 -->
			<li <% if( menuNo.indexOf("409")==0 ){ %> class="active" <%}%>>
				<a href="<c:out value='${pageContext.request.contextPath }/usr/hdaCampus/liberal.do'/>">보유과목안내</a>
			</li>
			<!-- //200402 메뉴개편 추가 -->
			<li <% if( menuNo.indexOf("405")==0 ){ %> class="active" <%}%>>
				<a href="<c:out value='${pageContext.request.contextPath }/usr/info/hotline.do'/>">조직및연락처</a>
			</li>
			<li <% if( menuNo.indexOf("404")==0 ){ %> class="active" <%}%>>
				<a href="<c:out value='${pageContext.request.contextPath }/usr/info/location.do'/>">오시는길</a>
			</li>
 			<%--<li <% if( menuNo.indexOf("506")==0 ){ %> class="active" <%}%>> 
				<a href="<c:out value='${pageContext.request.contextPath }/usr/info/promotionVideo.do'/>">홍보영상</a>
			</li>
			<li <% if( menuNo.indexOf("16003")==0 ){ %> class="active" <%}%>>
				<a href="<c:out value='${pageContext.request.contextPath }/usr/info/brodata/broDataList.do'/>">브로셔 자료</a>
			</li>--%>
		</ul>

	<% } else if( menuNo.indexOf("101")==0 ){ %>
	<div class="left_title">실내디자인</div>
	<ul class="left_menu_link">
		<li <% if( menuNo.indexOf("10101")==0 ){ %> class="active" <%}%>>
			<a href="<c:out value='${pageContext.request.contextPath }/usr/majorBoard/interior/majorInteriorInfo.do?menuType=01'/>">전공안내</a>
		</li>
		<li <% if( menuNo.indexOf("10102")==0 ){ %> class="active" <%}%> >
			<a href="<c:out value='${pageContext.request.contextPath }/usr/majorBoard/interior/majorInteriorTeacherList.do'/>">교수소개</a>
		</li>
		<li <% if( menuNo.indexOf("10103")==0 ){ %> class="active" <%}%> >
			<a href="<c:out value='${pageContext.request.contextPath }/usr/majorBoard/interior/majorInteriorJobList.do?menuType=01'/>">진출분야</a>
		</li>
		<li <% if( menuNo.indexOf("10104")==0 ){ %> class="active" <%}%> >
			<a href="<c:out value='${pageContext.request.contextPath }/usr/majorBoard/interior/majorInteriorCourse.do?menuType=01'/>">교과과정</a>
		</li>
		<c:set var="num" value="5"/>
		<c:forEach var="list" items="${bcList }">
			<c:if test="${list.mCode eq '01'}">
				<c:set var="num" value="${num +1 }"/>
				<c:set var="menuNum" value="1010${num }"/>
				<li <c:if test="${sessionScope.menuNo eq menuNum }">class="active"</c:if> >
					<a  href="<c:out value='${pageContext.request.contextPath }/usr/majorBoard/interior/majorInteriorList.do?searchType=${list.mmSeq }&menuNo=${menuNum}'/>"><c:out value="${list.bcName }"/></a>
				</li>
			</c:if>
		</c:forEach>
		<li <% if( menuNo.indexOf("10105")==0 ){ %> class="active" <%}%> >
			<a href="<c:out value='${pageContext.request.contextPath }/usr/transfer/transferReview/transferReviewList.do?menuType=01'/>">대학원&편입사례</a>
		</li>
	</ul>
	<% } else if( menuNo.indexOf("102")==0 ){%>
	<div class="left_title">시각디자인학</div>
	<ul class="left_menu_link">
		<li <% if( menuNo.indexOf("10201")==0 ){ %> class="active" <%}%> ><a href="<c:out value='${pageContext.request.contextPath }/usr/majorBoard/visual/majorVisualInfo.do?menuType=01'/>">전공안내</a></li>
		<li <% if( menuNo.indexOf("10202")==0 ){ %> class="active" <%}%> ><a href="<c:out value='${pageContext.request.contextPath }/usr/majorBoard/visual/majorVisualTeacherList.do'/>">교수소개</a></li>
		<li <% if( menuNo.indexOf("10203")==0 ){ %> class="active" <%}%> ><a href="<c:out value='${pageContext.request.contextPath }/usr/majorBoard/visual/majorVisualJobList.do?menuType=01'/>">진출분야</a></li>
		<li <% if( menuNo.indexOf("10204")==0 ){ %> class="active" <%}%> ><a href="<c:out value='${pageContext.request.contextPath }/usr/majorBoard/visual/majorVisualCourse.do?menuType=01'/>">교과과정</a></li>
		<c:set var="num" value="4"/>
		<c:forEach var="list" items="${bcList }">
			<c:if test="${list.mCode eq '02'}">
				<c:set var="num" value="${num +1 }"/>
				<c:set var="menuNum" value="1020${num }"/>
				<li <c:if test="${sessionScope.menuNo eq menuNum }">class="active"</c:if> >
					<a  href="<c:out value='${pageContext.request.contextPath }/usr/majorBoard/visual/majorVisualList.do?searchType=${list.mmSeq }&menuNo=${menuNum}'/>"><c:out value="${list.bcName }"/></a>
				</li>
			</c:if>
		</c:forEach>
	</ul>
	<% } else if( menuNo.indexOf("103")==0 ){%>
	<div class="left_title">산업디자인</div>
	<ul class="left_menu_link">		
		<li <% if( menuNo.indexOf("10301")==0 ){ %> class="active" <%}%> ><a href="<c:out value='${pageContext.request.contextPath }/usr/majorBoard/industrial/majorIndustrialInfo.do?menuType=01'/>">전공안내</a></li>
		<li <% if( menuNo.indexOf("10302")==0 ){ %> class="active" <%}%> ><a href="<c:out value='${pageContext.request.contextPath }/usr/majorBoard/industrial/majorIndustrialTeacherList.do'/>">교수소개</a></li>
		<li <% if( menuNo.indexOf("10303")==0 ){ %> class="active" <%}%> ><a href="<c:out value='${pageContext.request.contextPath }/usr/majorBoard/industrial/majorIndustrialJobList.do?menuType=01'/>">진출분야</a></li>
		<li <% if( menuNo.indexOf("10304")==0 ){ %> class="active" <%}%> ><a href="<c:out value='${pageContext.request.contextPath }/usr/majorBoard/industrial/majorIndustrialCourse.do?menuType=01'/>">교과과정</a></li>
		<c:set var="num" value="4"/>
		<c:forEach var="list" items="${bcList }">
			<c:if test="${list.mCode eq '03'}">
				<c:set var="num" value="${num +1 }"/>
				<c:set var="menuNum" value="1030${num }"/>
				<li <c:if test="${sessionScope.menuNo eq menuNum }">class="active"</c:if> >
					<a  href="<c:out value='${pageContext.request.contextPath }/usr/majorBoard/industrial/majorIndustrialList.do?searchType=${list.mmSeq }&menuNo=${menuNum}'/>"><c:out value="${list.bcName }"/></a>
				</li>
			</c:if>
		</c:forEach>
	</ul>
	<% } else if( menuNo.indexOf("104")==0 ){%>
	<div class="left_title" style="font-size: 25px;">디지털아트학<span style="font-size: 15px;">(디자인)</span></div>
	<ul class="left_menu_link">		
		<li <% if( menuNo.indexOf("10401")==0 ){ %> class="active" <%}%> ><a href="<c:out value='${pageContext.request.contextPath }/usr/majorBoard/digitalArt/majorDigitalArtInfo.do?menuType=01'/>">전공안내</a></li>
		<li <% if( menuNo.indexOf("10402")==0 ){ %> class="active" <%}%> ><a href="<c:out value='${pageContext.request.contextPath }/usr/majorBoard/digitalArt/majorDigitalArtTeacherList.do'/>">교수소개</a></li>
		<li <% if( menuNo.indexOf("10403")==0 ){ %> class="active" <%}%> ><a href="<c:out value='${pageContext.request.contextPath }/usr/majorBoard/digitalArt/majorDigitalArtJobList.do?menuType=01'/>">진출분야</a></li>
		<li <% if( menuNo.indexOf("10404")==0 ){ %> class="active" <%}%> ><a href="<c:out value='${pageContext.request.contextPath }/usr/majorBoard/digitalArt/majorDigitalArtCourse.do?menuType=01'/>">교과과정</a></li>
		<c:set var="num" value="4"/>
		<c:forEach var="list" items="${bcList }">
			<c:if test="${list.mCode eq '04'}">
				<c:set var="num" value="${num +1 }"/>
				<c:set var="menuNum" value="1040${num }"/>
				<li <c:if test="${sessionScope.menuNo eq menuNum }">class="active"</c:if> >
					<a  href="<c:out value='${pageContext.request.contextPath }/usr/majorBoard/digitalArt/majorDigitalArtList.do?searchType=${list.mmSeq }&menuNo=${menuNum}'/>"><c:out value="${list.bcName }"/></a>
				</li>
			</c:if>
		</c:forEach>
	</ul>
	<% } else if( menuNo.indexOf("109")==0 ){%>
	<div class="left_title" style="font-size: 25px;">디지털아트학<span style="font-size: 15px;">(게임)</span></div>
	<ul class="left_menu_link">		
		<li <% if( menuNo.indexOf("10901")==0 ){ %> class="active" <%}%> ><a href="<c:out value='${pageContext.request.contextPath }/usr/majorBoard/digitalEnt/majorDigitalEntInfo.do?menuType=01'/>">전공안내</a></li>
		<li <% if( menuNo.indexOf("10902")==0 ){ %> class="active" <%}%> ><a href="<c:out value='${pageContext.request.contextPath }/usr/majorBoard/digitalEnt/majorDigitalEntTeacherList.do?searchType=게임일러스트레이션'/>">교수소개</a></li>
		<li <% if( menuNo.indexOf("10903")==0 ){ %> class="active" <%}%> ><a href="<c:out value='${pageContext.request.contextPath }/usr/majorBoard/digitalEnt/majorDigitalEntJobList.do?menuType=01'/>">진출분야</a></li>
		<li <% if( menuNo.indexOf("10904")==0 ){ %> class="active" <%}%> ><a href="<c:out value='${pageContext.request.contextPath }/usr/majorBoard/digitalEnt/majorDigitalEntCourse.do?menuType=01'/>">교과과정</a></li>
		<c:set var="num" value="4"/>
		<c:forEach var="list" items="${bcList }">
			<c:if test="${list.mCode eq '11'}">
				<c:set var="num" value="${num +1 }"/>
				<c:set var="menuNum" value="1090${num }"/>
				<li <c:if test="${sessionScope.menuNo eq menuNum }">class="active"</c:if> >
					<a  href="<c:out value='${pageContext.request.contextPath }/usr/majorBoard/digitalEnt/majorDigitalEntList.do?searchType=${list.mmSeq }&menuNo=${menuNum}'/>"><c:out value="${list.bcName }"/></a>
				</li>
			</c:if>
		</c:forEach>
	</ul>
	<% } else if( menuNo.indexOf("105")==0 ){%>
	<div class="left_title">패션디자인학</div>
	<ul class="left_menu_link">		
		<li <% if( menuNo.indexOf("10501")==0 ){ %> class="active" <%}%> ><a href="<c:out value='${pageContext.request.contextPath }/usr/majorBoard/fassion/majorFassionInfo.do?menuType=01'/>">전공안내</a></li>
		<li <% if( menuNo.indexOf("10502")==0 ){ %> class="active" <%}%> ><a href="<c:out value='${pageContext.request.contextPath }/usr/majorBoard/fassion/majorFassionTeacherList.do'/>">교수소개</a></li>
		<li <% if( menuNo.indexOf("10503")==0 ){ %> class="active" <%}%> ><a href="<c:out value='${pageContext.request.contextPath }/usr/majorBoard/fassion/majorFassionJobList.do?menuType=01'/>">진출분야</a></li>
		<li <% if( menuNo.indexOf("10504")==0 ){ %> class="active" <%}%> ><a href="<c:out value='${pageContext.request.contextPath }/usr/majorBoard/fassion/majorFassionCourse.do?menuType=01'/>">교과과정</a></li>
		<c:set var="num" value="4"/>
		<c:forEach var="list" items="${bcList }">
			<c:if test="${list.mCode eq '05'}">
				<c:set var="num" value="${num +1 }"/>
				<c:set var="menuNum" value="1050${num }"/>
				<li <c:if test="${sessionScope.menuNo eq menuNum }">class="active"</c:if> >
					<a  href="<c:out value='${pageContext.request.contextPath }/usr/majorBoard/fassion/majorFassionList.do?searchType=${list.mmSeq }&menuNo=${menuNum}'/>"><c:out value="${list.bcName }"/></a>
				</li>
			</c:if>
		</c:forEach>
	</ul>
	<% } else if( menuNo.indexOf("106")==0 ){%>
<!-- 	200417수정 -->
	<div class="left_title">패션디자인</div>
	<ul class="left_menu_link">		
		<li <% if( menuNo.indexOf("10601")==0 ){ %> class="active" <%}%> ><a href="<c:out value='${pageContext.request.contextPath }/usr/majorBoard/fassion/majorFassionInfo.do?menuType=01'/>">전공안내</a></li>
		<li <% if( menuNo.indexOf("10602")==0 ){ %> class="active" <%}%> ><a href="<c:out value='${pageContext.request.contextPath }/usr/majorBoard/fassion/majorFassionTeacherList.do'/>">교수소개</a></li>
		<li <% if( menuNo.indexOf("10603")==0 ){ %> class="active" <%}%> ><a href="<c:out value='${pageContext.request.contextPath }/usr/majorBoard/fassion/majorFassionJobList.do?menuType=01'/>">진출분야</a></li>
		<li <% if( menuNo.indexOf("10604")==0 ){ %> class="active" <%}%> ><a href="<c:out value='${pageContext.request.contextPath }/usr/majorBoard/fassion/majorFassionCourse.do?menuType=01'/>">교과과정</a></li>
		<li <% if( menuNo.indexOf("10605")==0 ){ %> class="active" <%}%> ><a href="<c:out value='${pageContext.request.contextPath }/usr/majorBoard/fassion/majorFassionList.do?searchType=40&menuNo=10505'/>">전공소식</a></li>
		<li <% if( menuNo.indexOf("10606")==0 ){ %> class="active" <%}%> ><a href="<c:out value='${pageContext.request.contextPath }/usr/majorBoard/fassion/majorFassionList.do?searchType=41&menuNo=10506'/>">전공작품</a></li>
		<%-- <c:set var="num" value="4"/>
		<c:forEach var="list" items="${bcList }">
			<c:if test="${list.mCode eq '06'}">
				<c:set var="num" value="${num +1 }"/>
				<c:set var="menuNum" value="1060${num }"/>
				<li <c:if test="${sessionScope.menuNo eq menuNum }">class="active"</c:if> >
					<a  href="<c:out value='${pageContext.request.contextPath }/usr/majorBoard/fbusiness/majorFbusinessList.do?searchType=${list.mmSeq }&menuNo=${menuNum}'/>"><c:out value="${list.bcName }"/></a>
				</li>
			</c:if>
		</c:forEach> --%>
	</ul>
<!-- 	<div class="left_title">패션비즈니스</div> 
	<ul class="left_menu_link">		
		<li <% if( menuNo.indexOf("10601")==0 ){ %> class="active" <%}%> ><a href="<c:out value='${pageContext.request.contextPath }/usr/majorBoard/fbusiness/majorFbusinessInfo.do?menuType=01'/>">전공안내</a></li>
		<li <% if( menuNo.indexOf("10602")==0 ){ %> class="active" <%}%> ><a href="<c:out value='${pageContext.request.contextPath }/usr/majorBoard/fbusiness/majorFbusinessTeacherList.do'/>">교수소개</a></li>
		<li <% if( menuNo.indexOf("10603")==0 ){ %> class="active" <%}%> ><a href="<c:out value='${pageContext.request.contextPath }/usr/majorBoard/fbusiness/majorFbusinessJobList.do?menuType=04'/>">진출분야</a></li>
		<li <% if( menuNo.indexOf("10604")==0 ){ %> class="active" <%}%> ><a href="<c:out value='${pageContext.request.contextPath }/usr/majorBoard/fbusiness/majorFbusinessCourse.do?menuType=01'/>">교과과정</a></li>
		<c:set var="num" value="4"/>
		<c:forEach var="list" items="${bcList }">
			<c:if test="${list.mCode eq '06'}">
				<c:set var="num" value="${num +1 }"/>
				<c:set var="menuNum" value="1060${num }"/>
				<li <c:if test="${sessionScope.menuNo eq menuNum }">class="active"</c:if> >
					<a  href="<c:out value='${pageContext.request.contextPath }/usr/majorBoard/fbusiness/majorFbusinessList.do?searchType=${list.mmSeq }&menuNo=${menuNum}'/>"><c:out value="${list.bcName }"/></a>
				</li>
			</c:if>
		</c:forEach>
	</ul>-->
	<% } else if( menuNo.indexOf("107")==0 ){%>
	<div class="left_title">미용학</div>
	<ul class="left_menu_link">		
		<li <% if( menuNo.indexOf("10701")==0 ){ %> class="active" <%}%> ><a href="<c:out value='${pageContext.request.contextPath }/usr/majorBoard/beauty/majorBeautyInfo.do?menuType=01'/>">전공안내</a></li>
		<li <% if( menuNo.indexOf("10702")==0 ){ %> class="active" <%}%> ><a href="<c:out value='${pageContext.request.contextPath }/usr/majorBoard/beauty/majorBeautyTeacherList.do'/>">교수소개</a></li>
		<li <% if( menuNo.indexOf("10703")==0 ){ %> class="active" <%}%> ><a href="<c:out value='${pageContext.request.contextPath }/usr/majorBoard/beauty/majorBeautyJobList.do?menuType=01'/>">진출분야</a></li>
		<li <% if( menuNo.indexOf("10704")==0 ){ %> class="active" <%}%> ><a href="<c:out value='${pageContext.request.contextPath }/usr/majorBoard/beauty/majorBeautyCourse.do?menuType=01'/>">교과과정</a></li>
		<c:set var="num" value="4"/>
		<c:forEach var="list" items="${bcList }">
			<c:if test="${list.mCode eq '07'}">
				<c:set var="num" value="${num +1 }"/>
				<c:set var="menuNum" value="1070${num }"/>
				<li <c:if test="${sessionScope.menuNo eq menuNum }">class="active"</c:if> >
					<a  href="<c:out value='${pageContext.request.contextPath }/usr/majorBoard/beauty/majorBeautyList.do?searchType=${list.mmSeq }&menuNo=${menuNum}'/>"><c:out value="${list.bcName }"/></a>
				</li>
			</c:if>
		</c:forEach>
	</ul>
	<% } else if( menuNo.indexOf("108")==0 ){%>
	<div class="left_title">미용학(one-day)</div>
	<ul class="left_menu_link">		
		<li <% if( menuNo.indexOf("10801")==0 ){ %> class="active" <%}%> ><a href="<c:out value='${pageContext.request.contextPath }/usr/majorBoard/beautyOne/majorBeautyOneInfo.do?menuType=01'/>">전공안내</a></li>
		<li <% if( menuNo.indexOf("10802")==0 ){ %> class="active" <%}%> ><a href="<c:out value='${pageContext.request.contextPath }/usr/majorBoard/beautyOne/majorBeautyOneTeacherList.do'/>">교수소개</a></li>
		<li <% if( menuNo.indexOf("10803")==0 ){ %> class="active" <%}%> ><a href="<c:out value='${pageContext.request.contextPath }/usr/majorBoard/beautyOne/majorBeautyOneJobList.do?menuType=01'/>">진출분야</a></li>
		<li <% if( menuNo.indexOf("10804")==0 ){ %> class="active" <%}%> ><a href="<c:out value='${pageContext.request.contextPath }/usr/majorBoard/beautyOne/majorBeautyOneCourse.do?menuType=01'/>">교과과정</a></li>
		<c:set var="num" value="4"/>
		<c:forEach var="list" items="${bcList }">
			<c:if test="${list.mCode eq '08'}">
				<c:set var="num" value="${num +1 }"/>
				<c:set var="menuNum" value="1080${num }"/>
				<li <c:if test="${sessionScope.menuNo eq menuNum }">class="active"</c:if> >
					<a  href="<c:out value='${pageContext.request.contextPath }/usr/majorBoard/beautyOne/majorBeautyOneList.do?searchType=${list.mmSeq }&menuNo=${menuNum}'/>"><c:out value="${list.bcName }"/></a>
				</li>
			</c:if>
		</c:forEach>
	</ul>
	<% } else if( menuNo.indexOf("21")==0 ){%>
		<div class="left_title" style="font-size: 25px;">일학습엘리트과정</div>
		<ul class="left_menu_link">		

			<li <% if( menuNo.indexOf("2101")==0 ){ %> class="active" <%}%> ><a href="<c:out value='${pageContext.request.contextPath }/usr/elite/elite.do'/>">일학습엘리트과정이란?</a></li>
			<!--20210402 관리자요청. <li><a href="<c:out value='${pageContext.request.contextPath }/usr/elite/fbusiness/eliteFbusinessInfo.do'/>">글로벌패션창업</a></li> -->
		   <li><a href="<c:out value='${pageContext.request.contextPath }/usr/elite/beauty/eliteHairInfo.do'/>">하야시두피모발</a></li>
			<li><a href="<c:out value='${pageContext.request.contextPath }/usr/elite/beauty/eliteBeautyInfo.do'/>">뷰티교육자</a></li>
			<li><a href="<c:out value='${pageContext.request.contextPath }/usr/elite/beauty/eliteNatoInfo.do'/>">나투리아</a></li>
		</ul>


	<% } else if( menuNo.indexOf("20")==0){%>
		<div class="left_title">입학안내</div>
		<ul class="left_menu_link">
			<li <% if( menuNo.indexOf("201")==0 ){ %> class="active" <%}%>>
				<a href="<c:out value='${pageContext.request.contextPath }/usr/enter/prospectus.do'/>">모집요강</a>
			</li>
			<!-- 200402 메뉴개편 추가 -->
<%-- 			<li <% if( menuNo.indexOf("208")==0 ){ %> class="active" <%}%> > 
				<a href="<c:out value='${pageContext.request.contextPath }/usr/elite/eliteProspect.do'/>">모집요강(일학습엘리트)</a>
			</li>--%>
			<!-- //200402 메뉴개편 추가 -->
			<li <% if( menuNo.indexOf("202")==0 ){ %> class="active" <%}%>>
				<a href="#" onclick="fn_appliForm_open_sub('01'); return false;">원서접수</a>
			</li>
			<li <% if( menuNo.indexOf("203")==0 ){ %> class="active" <%}%>>
				<a href="#" onclick="fn_appliForm_open_sub('02'); return false;">원서접수확인</a>
			</li>
			<li <% if( menuNo.indexOf("204")==0 ){ %> class="active" <%}%>>
				<a href="#" onclick="fn_appliForm_open_sub('03'); return false;">합격자, 등록금 조회</a>
			</li>
			<li <% if( menuNo.indexOf("205")==0 ){ %> class="active" <%}%>>
				<a href="<c:out value='${pageContext.request.contextPath }/usr/enter/consult/consultList.do'/>">입학상담</a>
			</li>
		 	<li <% if( menuNo.indexOf("206")==0 ){ %> class="active" <%}%>>
				<a href="<c:out value='${pageContext.request.contextPath }/usr/enter/faq/faqList.do?menuType=01'/>">자주하는 질문</a>
			</li>
			<li <% if( menuNo.indexOf("207")==0 ){ %> class="active" <%}%>>
				<a href="<c:out value='${pageContext.request.contextPath }/usr/enter/brochure/brochureModify.do'/>">브로셔신청</a>
			</li>
		</ul>

	<% } else if( menuNo.indexOf("30")==0 ){%>
		<div class="left_title">학사안내</div>
		<ul class="left_menu_link">
			<li <% if( menuNo.indexOf("301")==0 ){ %> class="active" <%}%>>
				<a href="<c:out value='${pageContext.request.contextPath }/usr/hdaCampus/adcal/academicCalendar.do'/>">학사일정</a>
			</li>
			<li <% if( menuNo.indexOf("305")==0 ){ %> class="active" <%}%>>
				<a href="<c:out value='${pageContext.request.contextPath }/usr/community/faq/faqList.do'/>">학사정보</a>
			</li>

			<!--<li <% if( menuNo.indexOf("309")==0 ){ %> class="active" <%}%>>
				<a href="<c:out value='${pageContext.request.contextPath }/usr/enter/faq/faqList.do?menuType=01'/>">학사정보</a>
			</li>-->
		<!--	<li <% if( menuNo.indexOf("302")==0 ){ %> class="active" <%}%>>
				<a href="<c:out value='${pageContext.request.contextPath }/usr/hdaCampus/guide/affairsGuide.do?menuType=01'/>">학사정보</a>
			</li>-->
			<li <% if( menuNo.indexOf("303")==0 ){ %> class="active" <%}%>>
				<a href="<c:out value='${pageContext.request.contextPath }/usr/hdaCampus/scholarship.do'/>">장학제도</a>
			</li>
			<li <% if( menuNo.indexOf("304")==0 ){ %> class="active" <%}%>>
				<a href="<c:out value='${pageContext.request.contextPath }/usr/hdaCampus/form/formList.do'/>">양식자료실</a>
			</li>
		<!-- 200402 메뉴개편 추가 -->
						<li <% if( menuNo.indexOf("306")==0 ){ %> class="active" <%}%>>
				<a href="<c:out value='${pageContext.request.contextPath }/usr/community/qna/qnaList.do'/>">학사 Q&A</a>
			</li>
			<li <% if( menuNo.indexOf("307")==0 ){ %> class="active" <%}%>>
				<a href="<c:out value='${pageContext.request.contextPath }/usr/community/smg/smgList.do'/>">한디원신문고</a>
			</li>
			<li <% if( menuNo.indexOf("308")==0 ){ %> class="active" <%}%>>
				<a href="<c:out value='${pageContext.request.contextPath }/usr/community/notice/noticeList.do'/>">공지사항</a>
			</li>
		<!--  //200402 메뉴개편 추가 -->
		</ul>
	
	
	<% } else if( menuNo.indexOf("50")==0 ){%>
	
		<% if( menuNo.indexOf("5090")==0 ){%>
			<div class="left_title">행사</div>
			<ul class="left_menu_link">
				<li <% if( menuNo.indexOf("50901")==0 ){ %> class="active" <%}%>>
					<a href="<c:out value='${pageContext.request.contextPath }/usr/event/eventModify.do'/>">행사참가신청</a>
				</li>
				<li <% if( menuNo.indexOf("50902")==0 ){ %> class="active" <%}%>>
					<a href="<c:out value='${pageContext.request.contextPath }/usr/event/eventExpo.do'/>">행사참가비확인</a>
				</li>
				<li <% if( menuNo.indexOf("50903")==0 ){ %> class="active" <%}%>>
					<a href="<c:out value='${pageContext.request.contextPath }/usr/event/eventCancel.do'/>">행사참가 취소신청</a>
				</li>
			</ul>
		<% } else {%>
			<div class="left_title">캠퍼스생활</div>
			<ul class="left_menu_link">
				<!-- <li <% if( menuNo.indexOf("501")==0 ){ %> class="active" <%}%>>
					<a href="<c:out value='${pageContext.request.contextPath }/usr/community/proud/proudList.do'/>">한디원 이슈</a>
				</li> -->
				<li <% if( menuNo.indexOf("504")==0 ){ %> class="active" <%}%>>
					<a href="<c:out value='${pageContext.request.contextPath }/usr/community/exhibit.do'/>">공모전 수상</a>
				</li>
				<!--<li <% if( menuNo.indexOf("702")==0 ){ %> class="active" <%}%>>
					<a href="<c:out value='${pageContext.request.contextPath }/usr/community/ass/assList.do'/>">기업 · 지역연계수업</a>
				</li>-->
				<li <% if( menuNo.indexOf("16003")==0 ){ %> class="active" <%}%>>
					<a href="<c:out value='${pageContext.request.contextPath }/usr/info/brodata/broDataList.do'/>">작품자료실</a>
				</li>
<%-- 				<li <% if( menuNo.indexOf("601")==0 ){ %> class="active" <%}%>> --%>
<%-- 					<a href="<c:out value='${pageContext.request.contextPath }/usr/community/employment.do'/>">졸업후 진로</a> --%>
<!-- 				</li> -->
				<!-- <li <% if( menuNo.indexOf("23001")==0 ){ %> class="active" <%}%>>
				
					<a href="<c:out value='${pageContext.request.contextPath }/usr/community/overseas/overseas.do'/>">해외프로그램</a>
				<%-- 					<a href="<c:out value='${pageContext.request.contextPath }/usr/info/promotionVideo.do'/>">해외프로그램</a> --%>
				</li> -->
			</ul>
		<% } %>
	<% } else if( menuNo.indexOf("70")==0 ){%>
	<div class="left_title">기업 · 지역연계수업</div>
		<ul class="left_menu_link">
			<li <% if( menuNo.indexOf("702")==0 ){ %> class="active" <%}%> >
				<a href="<c:out value='${pageContext.request.contextPath }/usr/community/association.do'/>">기업 · 지역연계수업이란?</a>
			</li>
			<li <% if( menuNo.indexOf("701")==0 ){ %> class="active" <%}%> >
				<a href="<c:out value='${pageContext.request.contextPath }/usr/community/ass/assList.do'/>">기업 · 지역연계수업현황</a>
			</li>
		</ul>	
				
<!-- 	200420추가	 -->
	<% } else if( menuNo.indexOf("230")==0 ){%>
	<div class="left_title">해외프로그램</div>
		<ul class="left_menu_link">
			<li <% if( menuNo.indexOf("23001")==0 ){ %> class="active" <%}%> ><a href="<c:out value='${pageContext.request.contextPath }/usr/community/overseas/overseas.do'/>">해외인턴십</a></li>
			<!--<li <% if( menuNo.indexOf("23002")==0 ){ %> class="active" <%}%> ><a href="<c:out value='${pageContext.request.contextPath }/usr/community/oveStud/oveStud.do'/>">해외연수</a></li>-->
			<li <% if( menuNo.indexOf("23003")==0 ){ %> class="active" <%}%> ><a href="<c:out value='${pageContext.request.contextPath }/usr/community/oveServ/oveServ.do'/>">해외봉사</a></li>
		</ul>	
<!-- 	//200420추가	 -->

	<% } else if( menuNo.indexOf("160")==0 ){%>
	<div class="left_title">작품자료실</div>
		<ul class="left_menu_link">
			<li <% if( menuNo.indexOf("16003")==0 ){ %> class="active" <%}%> ><a href="<c:out value='${pageContext.request.contextPath }/usr/info/brodata/broDataList.do'/>">작품자료실</a></li>
			<li <% if( menuNo.indexOf("16001")==0 ){ %> class="active" <%}%> ><a href="<c:out value='${pageContext.request.contextPath }/usr/community/ucc/uccList.do'/>">동영상</a></li>
			<li <% if( menuNo.indexOf("16002")==0 ){ %> class="active" <%}%> ><a href="<c:out value='${pageContext.request.contextPath }/usr/community/webtoon/webtoonList.do'/>">한디원웹툰</a></li>
		</ul>	

	<%-- <% } else if( menuNo.indexOf("260")==0 ){%>
		<div class="left_title">채용공고</div>
		<ul class="left_menu_link">
			<li <% if( menuNo.indexOf("26001")==0 ){ %> class="active" <%}%> ><a href="<c:out value='${pageContext.request.contextPath }/usr/jobs/worknet/recruitment/recruList.do'/>">채용정보</a></li>
			<!--<li <% if( menuNo.indexOf("26002")==0 ){ %> class="active" <%}%> ><a href="<c:out value='${pageContext.request.contextPath }/usr/jobs/worknet/breakingNews/brNewsList.do'/>">공채속보</a></li>-->
		</ul>	--%>	
	<% } else if( menuNo.indexOf("60")==0 || menuNo.indexOf("260")==0 ){%>
		<div class="left_title">취업센터</div>
		<ul class="left_menu_link">
			<li <% if( menuNo.indexOf("601")==0 || menuNo.indexOf("603")==0 ){ %> class="active" <%}%>>
				<a href="<c:out value='${pageContext.request.contextPath }/usr/community/employment.do'/>">취업현황</a>
			</li>
			<li <% if( menuNo.indexOf("602")==0 ){ %> class="active" <%}%>>
				<a href="<c:out value='${pageContext.request.contextPath }/usr/community/univercity.do'/>">진학현황</a>
			</li>
		<!--	<li <% if( menuNo.indexOf("603")==0 ){ %> class="active" <%}%>>
				<a href="<c:out value='${pageContext.request.contextPath }/usr/community/interview.do?menuType=01'/>">성공후기</a>
			</li>-->
			<li <% if( menuNo.indexOf("604")==0 ){ %> class="active" <%}%>>
				<a href="<c:out value='${pageContext.request.contextPath }/usr/community/enterprise.do'/>">산학협력(MOU)</a>
			</li>
			<li <% if( menuNo.indexOf("606")==0 ){ %> class="active" <%}%>>
				<a href="<c:out value='${pageContext.request.contextPath }/usr/community/employment/employList.do'/>">취업프로그램</a>
			</li>
			<li <% if( menuNo.indexOf("260")==0 ){ %> class="active" <%}%>>
				<a href="<c:out value='${pageContext.request.contextPath }/usr/jobs/worknet/recruitment/recruList.do'/>">채용공고</a>
			</li>
		</ul>
		
	<% } else if( menuNo.indexOf("80")==0 || menuNo.equals("22003")){%>
		<div class="left_title">D-School</div>
		<ul class="left_menu_link">
			<li <% if( menuNo.indexOf("806")==0 ){ %> class="active" <%}%>>
				<a href="<c:out value='${pageContext.request.contextPath }/usr/general/question/generalQuestionList.do'/>">공지사항</a>
			</li>

			<li <% if( menuNo.indexOf("801")==0 ){ %> class="active" <%}%>>
				<a href="<c:out value='${pageContext.request.contextPath }/usr/general/info/generalInfoList.do'/>">과정안내</a>
			</li>
			<li <% if( menuNo.indexOf("802")==0 ){ %> class="active" <%}%>>
				<a href="<c:out value='${pageContext.request.contextPath }/usr/general/request/generalRequestList.do'/>">D-School Q&A</a>
			</li>
			   <li <% if( menuNo.equals("22003")){ %> class="active" <%}%>>
				<a href="<c:out value='${pageContext.request.contextPath }/usr/general/exper/experNewsList.do'/>">진로체험소식</a>
			</li>

		</ul>	
		
		<% } else if( menuNo.indexOf("220")==0 ){%>
		<div class="left_title">진로체험</div>
		<ul class="left_menu_link">
			<li <% if( menuNo.indexOf("22001")==0 ){ %> class="active" <%}%>>
				<a href="<c:out value='${pageContext.request.contextPath }/usr/general/exper/experInfo.do'/>">진로체험안내</a>
			</li>
			<li <% if( menuNo.indexOf("22002")==0 ){ %> class="active" <%}%>>
				<a href="<c:out value='${pageContext.request.contextPath }/usr/general/exper/experModify.do'/>">진로체험신청</a>
			</li>
			<li <% if( menuNo.indexOf("22003")==0 ){ %> class="active" <%}%>>
				<a href="<c:out value='${pageContext.request.contextPath }/usr/general/exper/experNewsList.do'/>">진로체험소식</a>
			</li>
		</ul>
	
	<% } else if( menuNo.indexOf("110")==0 ){%>
	<div class="left_title">타일디자인시공</div>
	<ul class="left_menu_link">		
		<li <% if( menuNo.indexOf("11001")==0 ){ %> class="active" <%}%> ><a href="<c:out value='${pageContext.request.contextPath }/usr/elite/interior/eliteInteriorInfo.do'/>">전공안내</a></li>
		<li <% if( menuNo.indexOf("11002")==0 ){ %> class="active" <%}%> ><a href="<c:out value='${pageContext.request.contextPath }/usr/elite/interior/eliteInteriorTeacherList.do'/>">교수소개</a></li>
		<li <% if( menuNo.indexOf("11003")==0 ){ %> class="active" <%}%> ><a href="#" onclick="alert('준비중입니다.'); return false;">교과과정</a></li>
		<%-- <li <% if( menuNo.indexOf("11003")==0 ){ %> class="active" <%}%> ><a href="<c:out value='${pageContext.request.contextPath }/usr/elite/interior/eliteInteriorCourse.do?menuType=01'/>">교과과정</a></li> --%>
		<c:set var="num" value="3"/>
		<c:forEach var="list" items="${bcList }">
			<c:if test="${list.mCode eq '11'}">
				<c:set var="num" value="${num +1 }"/>
				<c:set var="menuNum" value="1100${num }"/>
				<li <c:if test="${sessionScope.menuNo eq menuNum }">class="active"</c:if> >
					<a  href="<c:out value='${pageContext.request.contextPath }/usr/elite/interior/eliteInteriorList.do?searchType=${list.mmSeq }&menuNo=${menuNum}'/>"><c:out value="${list.bcName }"/></a>
				</li>
			</c:if>
		</c:forEach>
	</ul>
	<!-- <% } else if( menuNo.indexOf("120")==0 ){%>
	<div class="left_title">성우콘텐츠<br>크리에이터</div>
	<ul class="left_menu_link">		
		<li <% if( menuNo.indexOf("12001")==0 ){ %> class="active" <%}%> ><a href="<c:out value='${pageContext.request.contextPath }/usr/elite/digitalArt/eliteDigitalArtInfo.do'/>">전공안내</a></li>
		<li <% if( menuNo.indexOf("12002")==0 ){ %> class="active" <%}%> ><a href="<c:out value='${pageContext.request.contextPath }/usr/elite/digitalArt/eliteDigitalArtTeacherList.do'/>">교수소개</a></li>
		<%--
		<li <% if( menuNo.indexOf("12003")==0 ){ %> class="active" <%}%> ><a href="#" onclick="alert('준비중입니다.'); return false;">교과과정</a></li>
		--%>
		<li <% if( menuNo.indexOf("12003")==0 ){ %> class="active" <%}%> ><a href="<c:out value='${pageContext.request.contextPath }/usr/elite/digitalArt/eliteDigitalArtCourse.do'/>">교과과정</a></li>
		<c:set var="num" value="3"/>
		<c:forEach var="list" items="${bcList }">
			<c:if test="${list.mCode eq '12'}">
				<c:set var="num" value="${num +1 }"/>
				<c:set var="menuNum" value="1200${num }"/>
				<li <c:if test="${sessionScope.menuNo eq menuNum }">class="active"</c:if> >
					<a  href="<c:out value='${pageContext.request.contextPath }/usr/elite/digitalArt/eliteDigitalArtList.do?searchType=${list.mmSeq }&menuNo=${menuNum}'/>"><c:out value="${list.bcName }"/></a>
				</li>
			</c:if>
		</c:forEach>
	</ul> -->
	<% } else if( menuNo.indexOf("130")==0 ){%>
	<div class="left_title">글로벌패션창업</div>
	<ul class="left_menu_link">		
		<li <% if( menuNo.indexOf("13001")==0 ){ %> class="active" <%}%> ><a href="<c:out value='${pageContext.request.contextPath }/usr/elite/fbusiness/eliteFbusinessInfo.do'/>">전공안내</a></li>
		<li <% if( menuNo.indexOf("13002")==0 ){ %> class="active" <%}%> ><a href="<c:out value='${pageContext.request.contextPath }/usr/elite/fbusiness/eliteFbusinessTeacherList.do'/>">교수소개</a></li>
		<li <% if( menuNo.indexOf("13003")==0 ){ %> class="active" <%}%> ><a href="<c:out value='${pageContext.request.contextPath }/usr/elite/fbusiness/eliteFbusinessCourse.do?menuType=01'/>">교과과정</a></li>
		<c:set var="num" value="3"/>
		<c:forEach var="list" items="${bcList }">
			<c:if test="${list.mCode eq '13'}">
				<c:set var="num" value="${num +1 }"/>
				<c:set var="menuNum" value="1300${num }"/>
				<li <c:if test="${sessionScope.menuNo eq menuNum }">class="active"</c:if> >
					<a  href="<c:out value='${pageContext.request.contextPath }/usr/elite/fbusiness/eliteFbusinessList.do?searchType=${list.mmSeq }&menuNo=${menuNum}'/>"><c:out value="${list.bcName }"/></a>
				</li>
			</c:if>
		</c:forEach>
	</ul>
	<% } else if( menuNo.indexOf("140")==0 ){%>
	
	<% if( menuNo.equals("14001")){%>
		<div class="left_title">뷰티교육자</div>
	<% }%>
	<% if( menuNo.equals("14010")){%>
		<div class="left_title">하야시두피모발</div>
	<% }%>	
	<% if( menuNo.equals("14011")){%>
		<div class="left_title">나투리아</div>
	<% }%>	
	<ul class="left_menu_link">		
		<% if( menuNo.equals("14010")){%>
		<li class="active" ><a href="<c:out value='${pageContext.request.contextPath }/usr/elite/beauty/eliteHairInfo.do'/>">전공안내</a>
			<ul style="display:inline-block; height:50px;" >
				<li<% if( menuNo.equals("14001")){%> class="active"<%}%>><a href="<c:out value='${pageContext.request.contextPath }/usr/elite/beauty/eliteHairInfo.do'/>">하야시두피모발</a></li>
				
										
			</ul>
		</li>
		<% }%>	
		<% if( menuNo.equals("14001")){%>
		<li class="active" ><a href="<c:out value='${pageContext.request.contextPath }/usr/elite/beauty/eliteBeautyInfo.do'/>">전공안내</a>
			<ul style="display:inline-block; height:50px;" >
	 			<li<% if( menuNo.equals("14001")){%> class="active"<%}%>><a href="<c:out value='${pageContext.request.contextPath }/usr/elite/beauty/eliteBeautyInfo.do'/>">뷰티교육자</a></li>
														
			</ul>
		</li>
		<% }%>	
		<% if( menuNo.equals("14011")){%>
		<li class="active" ><a href="<c:out value='${pageContext.request.contextPath }/usr/elite/beauty/eliteNatoInfo.do'/>">전공안내</a>
			<ul style="display:inline-block; height:50px;" >
				<li<% if( menuNo.equals("14011")){%> class="active"<%}%>><a href="<c:out value='${pageContext.request.contextPath }/usr/elite/beauty/eliteNatoInfo.do'/>">나투리아</a></li>
										
			</ul>
		</li>
		<% }%>	
		<li <% if( menuNo.indexOf("14002")==0 ){ %> class="active" <%}%> ><a href="<c:out value='${pageContext.request.contextPath }/usr/elite/beauty/eliteBeautyTeacherList.do'/>">교수소개</a></li>
		<li <% if( menuNo.indexOf("14003")==0 ){ %> class="active" <%}%> ><a href="<c:out value='${pageContext.request.contextPath }/usr/elite/beauty/eliteBeautyCourse.do?menuType=01'/>">교과과정</a></li>
		<c:set var="num" value="3"/>
		<c:forEach var="list" items="${bcList }">
			<c:if test="${list.mCode eq '14'}">
				<c:set var="num" value="${num +1 }"/>
				<c:set var="menuNum" value="1400${num }"/>
				<li <c:if test="${sessionScope.menuNo eq menuNum }">class="active"</c:if> >
					<a  href="<c:out value='${pageContext.request.contextPath }/usr/elite/beauty/eliteBeautyList.do?searchType=${list.mmSeq }&menuNo=${menuNum}'/>"><c:out value="${list.bcName }"/></a>
				</li>
			</c:if>
		</c:forEach>
	</ul>
	<% } %>		
	<!-- left banner -->
	<c:if test="${!empty bannerList }">
		<c:if test="${bannerlist.banNewWindow eq 'Y' || bannerList.banNewWindow eq 'N'}">
			<a href="<c:url value='${bannerList.banUrl }'/>" <c:if test="${bannerList.banNewWindow eq 'Y' }">target="_blank"</c:if> ><img src="<c:out value='/showImage.do?filePath=${bannerList.banImgPath }'/>" alt="<c:out value='${bannerList.banName }'/>" style="width:200px; height:137.66px;"/></a>
		</c:if>
		<c:if test="${bannerList.banNewWindow ne 'Y' && bannerList.banNewWindow ne 'N'}">
			<c:if test="${bannerList.banNewWindow eq '01' }">
				<a href="#" onclick="fn_appliForm_choose_sub(); return false;"><img src="<c:out value='/showImage.do?filePath=${bannerList.banImgPath }'/>" alt="<c:out value='${bannerList.banName }'/>" style="width:200px; height:137.66px;"/></a>
			</c:if>
			<c:if test="${bannerList.banNewWindow ne '01' }">
				<a href="#" onclick="fn_appliForm_open_sub('<c:out value="${bannerList.banNewWindow }"/>'); return false;"><img src="<c:out value='/showImage.do?filePath=${bannerList.banImgPath }'/>" alt="<c:out value='${bannerList.banName }'/>" style="width:200px; height:137.66px;"/></a>
			</c:if>
		</c:if>
	</c:if>
	
	<!-- //left banner -->
</div>