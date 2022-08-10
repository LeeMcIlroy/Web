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
<form:form commandName="searchVO" id="frm" name="frm">
<form:hidden path="pageIndex"/>
<form:hidden path="searchType"/>
<form:hidden path="menuType"/>
<form:hidden path="searchCondition2"/>
<form:hidden path="searchWord"/>
<input type="hidden" id="mbSeq" name="mbSeq">
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
				<jsp:include page="/WEB-INF/jsp/hsDesign/usr/inc/incPageTitle2.jsp">
					<jsp:param name="dept1" value="전공"/>
		            <jsp:param name="dept2" value="디지털아트(게임)"/>
		            <jsp:param name="dept3" value="진출분야"/>
	           	</jsp:include>
				
				<div class="top_tab type_li3">
					<ul>
						<%-- <li <c:if test="${searchVO.menuType eq '01' }">class="active"</c:if> ><a href="<c:out value='${pageContext.request.contextPath }/usr/majorBoard/digitalEnt/majorDigitalEntJobList.do?menuType=01'/>">방송크리에이터</a></li> --%>
						<li <c:if test="${searchVO.menuType eq '01' }">class="active"</c:if> ><a href="<c:out value='${pageContext.request.contextPath }/usr/majorBoard/digitalEnt/majorDigitalEntJobList.do?menuType=01'/>">게임일러스트레이션</a></li>
						<%-- <li <c:if test="${searchVO.menuType eq '02' }">class="active"</c:if> ><a href="<c:out value='${pageContext.request.contextPath }/usr/majorBoard/digitalEnt/majorDigitalEntJobList.do?menuType=02'/>">성우</a></li> --%>
						<li <c:if test="${searchVO.menuType eq '02' }">class="active"</c:if> ><a href="<c:out value='${pageContext.request.contextPath }/usr/majorBoard/digitalEnt/majorDigitalEntJobList.do?menuType=02'/>">게임개발</a></li>
						<li <c:if test="${searchVO.menuType eq '03' }">class="active"</c:if> ><a href="<c:out value='${pageContext.request.contextPath }/usr/majorBoard/digitalEnt/majorDigitalEntJobList.do?menuType=03'/>">e스포츠</a></li>
					</ul>
				</div>		
				
				<%-- <c:if test="${searchVO.menuType eq '01' }">
					<p class="area_info">
						<span style="font-weight: bold;">크리에이터 이해</span><br/>
						크리에이터란 말 그대로 창작자를 말한다. 그러나 최근에는 유튜브의 성장으로 창작자라는 의미보다는 유튜브에서 동영상을 생산하고 업로드하는 이를 총체적으로 지칭하고 있다. 
						과거 지상파나 케이블 방송국에서 제작하는 방송만이 유일했다면 최근 인터넷 보급과 인터넷망의 확산으로 크리에이터들이 만들어 내는 UCC(User Created Contents)가 더욱 관심을 받고 있는 상황이다. 
						이런 개인채널의 발달로 인하여 일반인들이 직접 기획하고 제작, 송출할 수 있게 되면서 크리에이터 시장은 날로 성장해 가고 있다. 
					</p>
					<p class="area_info">
						<span style="font-weight: bold;">직업분야개요</span><br/>
						최근 청소년들이 가장 선호하는 직업군 중 하나가 크레이터인 것만큼 크리에이터 직업군은 매우 다양하다. 컨텐츠의 유형으로 분류가 가능하데 그 종류는 아래와 같다.<br/>
						&nbsp;• 게임: 주로 게임을 플레이하는 영상을 제작하는 것이 대표적이다. 게임 한 분야의 전문가의 경우도 있다. 대부분의 프로게이머들은 트위치와 유튜버를 병행하기도 한다. <br/>
						&nbsp;• 리뷰: 어떠한 제품이나 현상에 대해 개인의 시점에서 구독자들에게 리뷰하는 영상이다. 구독자수가 많은 유튜버들은 협찬을 받아 수익성 리뷰 영상을 제작하기도 한다.<br/>
						&nbsp;• 브이로그: 특히 요즘 대중화된 컨텐츠로, Video(동영상)+Blog(블로그)를 합친 말이다. 일상적인 생활, 이야기를 촬영한 영상을 말한다. 이미 인기가 많은 유명 유튜버나 연예인들도 브이로그 영상을 많이 찍곤 한다. 뿐만 아니라 일반인들도 유튜브에 브이로그 영상을 촬영하여 업로드하는 일이 많아지고 있다.<br/>
						&nbsp;• 음악: 자신이 만든 곡이나 어떠한 곡을 직접 연주하는 것을 말한다. 무명 음악가들이 인지도를 올리기 위해서, 또는 사람들에게 자신을 알리고자 유튜브를 이용하기도 한다.<br/>
						&nbsp;• 먹방: 한국에서 특히 유행하고 있는 유형으로, 음식을 먹는 모습을 보여주는 영상이다. 직접 요리를 해서 만든 음식을 먹기도 하고, 협찬을 받아 먹기도 한다. 또, 일반인이 먹기 어렵다고 판단되는 많은 양을 먹기도 하고, 그와 대비되어 적은 양을 먹기도 한다. 특이한 음식을 먹기도 하며 구하기 어려운 음식을 먹는 것도 있다.<br/>
						&nbsp;• ASMR: 조용히, 귀에 속삭이듯이 말하거나 또는 기분 좋은 소리를 계속하여 듣는 것으로 사람들에게 안정감을 느끼게 해준다. 그래서 잠들기 전에, 잠이 오지 않을 때 이러한 영상을 보는 시청자들이 많다.<br/>
						&nbsp;• 뷰티: 분장을 하는 과정이나 메이크업을 하는 모습을 보여주는 컨텐츠로 이러한 영상을 제작하는 유튜버를 “뷰티 유튜버”라고 칭한다. 주로 여성들에게 인기가 많으며, 재치있는 남성 유튜버들도 인기를 끌고 있다.<br/>
						&nbsp;• 댄스: 자신이 창작한 춤이나, 어떠한 춤을 커버한 영상을 촬영하여 보여주는 유형이다.<br/>
						&nbsp;• 운동: 운동방법에 대한 설명이 대표적이고 유명 스포츠 스타 또는 운동 고수들의 운동 영상을 보여주는 유형도 인기가 있다.<br/><br/>
						유튜브에 동영상을 올려서 일정 시청자와 조회수를 확보하게되면 광고를 통해 수익을 얻을 수 있다. 유튜브가 실시간 스트리밍 서비스를 하게 됨에 따라, 시청자는 자신이 좋아하는 유튜버에게 슈퍼챗을 통해 후원금을 낼 수도 있다.
						유튜브 광고는 여러 형태가 있으며, 시청자가 배너를 클릭하거나 영상 광고를 일정 시간 이상 시청하는 등의 행위를 함에 따라서 광고주가 비용을 지불하게 된다.
						또한 다양한 영상기술을 바탕으로 영상편집자나 영상콘텐츠제작자등으로 직업연계가 가능하다. 
					</p>
				
<!-- 					<div class="photo_slider"> -->
<!-- 						<ul class="b_photo"> -->
						<li>
							<img src="<c:out value='${pageContext.request.contextPath }/assets/usr/img/digitalEnt/dae_img_01.png'/>"  style="width:49%; height:250px;" />
							<img src="<c:out value='${pageContext.request.contextPath }/assets/usr/img/digitalEnt/dae_img_02.png'/>"  style="width:49%; height:250px;" />
						</li>
<!-- 						</ul> -->
<!-- 					</div> -->
				</c:if>		 --%>	
				<c:if test="${searchVO.menuType eq '01' }">
					<p class="area_info">오늘날 게임산업은 다양한 세부 그래픽 전문가들의 협업을 통해 대단히 정교하고 화려한 영상미를 가지고 있다. 배경원화, 캐릭터원화, 아이템원화, 몬스터원화, 3D모델링, UI제작, 캐릭터 리소스 등의 다양한 파트에 대한 교육을 통해 수준 높은 포트폴리오를 완성한다.</p>
						
				
					<div class="photo_slider">
						<ul class="b_photo">
						  <li><img src="<c:out value='${pageContext.request.contextPath }/assets/usr/img/digitalArt/da_advan_gi01.jpg'/>" /></li>
						  <li><img src="<c:out value='${pageContext.request.contextPath }/assets/usr/img/digitalArt/da_advan_gi02.jpg'/>" /></li>
						  <li><img src="<c:out value='${pageContext.request.contextPath }/assets/usr/img/digitalArt/da_advan_gi03.jpg'/>" /></li>
						  <li><img src="<c:out value='${pageContext.request.contextPath }/assets/usr/img/digitalArt/da_advan_gi04.jpg'/>" /></li>
						  <li><img src="<c:out value='${pageContext.request.contextPath }/assets/usr/img/digitalArt/da_advan_gi05.jpg'/>" /></li>
						  <li><img src="<c:out value='${pageContext.request.contextPath }/assets/usr/img/digitalArt/da_advan_gi06.jpg'/>" /></li>
						  <li><img src="<c:out value='${pageContext.request.contextPath }/assets/usr/img/digitalArt/da_advan_gi07.jpg'/>" /></li>
						  <li><img src="<c:out value='${pageContext.request.contextPath }/assets/usr/img/digitalArt/da_advan_gi08.jpg'/>" /></li>
						  <li><img src="<c:out value='${pageContext.request.contextPath }/assets/usr/img/digitalArt/da_advan_gi09.jpg'/>" /></li>
						  <li><img src="<c:out value='${pageContext.request.contextPath }/assets/usr/img/digitalArt/da_advan_gi10.jpg'/>" /></li>
						  <li><img src="<c:out value='${pageContext.request.contextPath }/assets/usr/img/digitalArt/da_advan_gi11.jpg'/>" /></li>
						  <li><img src="<c:out value='${pageContext.request.contextPath }/assets/usr/img/digitalArt/da_advan_gi12.jpg'/>" /></li>
						  <li><img src="<c:out value='${pageContext.request.contextPath }/assets/usr/img/digitalArt/da_advan_gi13.jpg'/>" /></li>
						  <li><img src="<c:out value='${pageContext.request.contextPath }/assets/usr/img/digitalArt/da_advan_gi14.jpg'/>" /></li>
						  <li><img src="<c:out value='${pageContext.request.contextPath }/assets/usr/img/digitalArt/da_advan_gi15.jpg'/>" /></li>
						  <li><img src="<c:out value='${pageContext.request.contextPath }/assets/usr/img/digitalArt/da_advan_gi16.jpg'/>" /></li>
						  <li><img src="<c:out value='${pageContext.request.contextPath }/assets/usr/img/digitalArt/da_advan_gi17.jpg'/>" /></li>
						</ul>
						<%-- 
						<div id="bx-pager">
							<a data-slide-index="0" href=""><img src="${pageContext.request.contextPath }/assets/usr/img/digitalArt/photo_s_eximg01.jpg" /></a>
							<a data-slide-index="1" href=""><img src="${pageContext.request.contextPath }/assets/usr/img/digitalArt/photo_s_eximg02.jpg" /></a>
							<a data-slide-index="2" href=""><img src="${pageContext.request.contextPath }/assets/usr/img/digitalArt/photo_s_eximg03.jpg" /></a>
							<a data-slide-index="3" href=""><img src="${pageContext.request.contextPath }/assets/usr/img/digitalArt/photo_s_eximg04.jpg" /></a>
							<a data-slide-index="4" href=""><img src="${pageContext.request.contextPath }/assets/usr/img/digitalArt/photo_s_eximg05.jpg" /></a>
							<a data-slide-index="5" href=""><img src="${pageContext.request.contextPath }/assets/usr/img/digitalArt/photo_s_eximg06.jpg" /></a>
							<a data-slide-index="6" href=""><img src="${pageContext.request.contextPath }/assets/usr/img/digitalArt/photo_s_eximg07.jpg" /></a>
							<a data-slide-index="7" href=""><img src="${pageContext.request.contextPath }/assets/usr/img/digitalArt/photo_s_eximg08.jpg" /></a>
						</div>
						 --%>
					</div>
				</c:if>
				<c:if test="${searchVO.menuType eq '02' }">
					<%-- <div class="sub_cont_page">
						<dl class="info_dl">
							<dd>
								<p><strong>직업분야개요</strong></p>
	                            <p>목소리(voice)는 개인의 개성을 나타내는 동시에 하나의 콘텐츠이다. 4차산업 물결 속에서 사람만이 가지고 있는 감정이 포함 된 Voice 콘텐츠는 그래서 더욱 중요하게 평가된다. 한성대학교 한디원은 4차산업시대에 맞는 직업군을 창출하고 자아실현을 위한 사회가 원하는 직업인으로 양성하기 위하여 본 직업분야교육 과정을 개설하였다.</p>
							</dd>
							<dd>
								<p><strong>커리큘럼 소개</strong></p>
	                            <p>본 커리큘럼은 Voice를 중심으로 다양한 미디어와 결합한 새로운 직업분야 교육을 목표로 하고 있다.</p>
	                            <p>성우뿐 아니라 Voice 더빙, 1인 미디어(MCN), 애니메이션 크리에이터, 게임 Voice, 영상편집, 영상촬영방법, 애니메이션제작 및 연기에 이르기까지 매체와 융합한 새로운 voice콘텐츠를 창출하기 위한 미래 지향적인 교육과정으로 구성되어 있다.</p>
	                            <p>본 과정을 이수하게 되면 다양한 매체를 통한 voice 콘텐츠를 전문가 수준까지 제작할 수 있도록 사)한국성우협회와 애니메이션전문가, CG전문가, 특수영상콘텐츠 전문가들로 교수진이 구성되어 있다. </p>
							</dd>
						</dl>
						<img src="<c:out value='${pageContext.request.contextPath }/assets/usr/img/digitalArt/da_voice_02_1_1.jpg'/>" />
						<img src="<c:out value='${pageContext.request.contextPath }/assets/usr/img/digitalArt/da_voice_02_2.jpg'/>" />
					</div> --%>						
				</c:if>					
				<c:if test="${searchVO.menuType eq '03' }">
					<p class="area_info">
						<span style="font-weight: bold;">e스포츠의 이해</span><br/>
						e스포츠는 일렉트로닉 스포츠(Electronic Sports)를 말하며 컴퓨터기반의 디바이스를 이용하여 인터넷 네트워크를 통해 승부를 겨루는 온라인 스포츠로 지적능력 및 신체적 능력을 요구하는 경기를 말합니다. 
						인터넷상의 네트워크 게임을 이용한 각종 대회나 리그를 말하며, 넓은 의미로는 게임 대회뿐 아니라 대회에서 활동하는 프로게이머, 게임해설자, e스포츠 방송국 등을 포함한 엔터네인먼트 산업을 뜻합니다. 
						최근에 90년대 말 게임 및 IT산업의 발전과 더불어 e스포츠산업이 성장했고, 2001년 ‘한국 e스포츠협회’가 창립이 되면서 e스포츠산업이 대중 스포츠로 성장하기 시작했고 e스포츠 종주국으로서의 기틀을 마련했습니다. 
					</p>
					<p class="area_info">
						<span style="font-weight: bold;">직업분야개요</span><br/>
						e스포츠는 단순히 게임뿐만 아니라 교육, 관광, 스포츠, 방송 등 광범위한 엔터네인먼트 산업으로 성장하고 있으며 몇 명의 스타플레이어가 이끈 초기와 달리 현재는 안정적인 기반 인프라를 바탕으로 지속적인 성장세를 유지하고 있다. 
						특히 2018년에 이어서 2022년 제 19회 항저우 아시안게임에도 경기 종목으로 선정되면서 그 위상은 더 커질 전망입니다. 
						e스포츠 과정은 4차산업혁명에 부응하는 신동력 직업군을 키워내는 과정으로 ‘e스포츠코치 및 감독’, ‘e스포츠해설자’, ‘e스포츠콘텐츠제작’, ‘e스포츠경기운영자’, ‘e스포츠크리에이터 및 중계운영자’, ‘e스포츠마케터’, ‘e스포츠심리치료사’ 등 다양한 신 직업 인재를 양성하기 위한 과정입니다. 
					</p>
					<p class="area_info">
						<span style="font-weight: bold;">e스포츠 산업규모</span><br/>
						<img src="<c:out value='${pageContext.request.contextPath }/assets/usr/img/digitalEnt/dae_es_01.png'/>" class="dd" />
						한국e스포츠는 인구 및 지역적 한계로 상대적으로 해외보다는 시장규모가 작은 편이나 최근 국내 e스포츠산업도 다양한 직업군과 함께 급성장 하고 있습니다.
						한국 e스포츠가 세계적으로 주목을 받을 수 있었던 것은 독보적인 맨파워(Man Power)와 90년대 말부터 쌓은 노하우로 'e스포츠의종주국' 타이트를 지니고 있기 때문입니다.
						산업적규모는 전세계의 약10.1%정도지만(한국콘텐츠진흥원'2016 e스포츠실태조사' 기준) 실력만큼은 단연 세계최고입니다. 한국에서 경험을 바탕으로 해외무대에서 활동하는 프로선수, e스포츠방송프로듀서, 국제심판 및 경기 운영자등이 속속 해외로 진출하고 있습니다. 
						<img src="<c:out value='${pageContext.request.contextPath }/assets/usr/img/digitalEnt/dae_es_02.png'/>" class="dd" />
					</p>
				</c:if>			
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
<input type="hidden" id="message" value="${message}" />
</form:form>
</body>
</html>