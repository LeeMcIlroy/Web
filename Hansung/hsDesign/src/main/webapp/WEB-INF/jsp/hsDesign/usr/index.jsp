<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c"		uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="form"   	uri="http://www.springframework.org/tags/form" %>
<%@ taglib prefix="ui"     	uri="http://egovframework.gov/ctl/ui"%>
<%@ taglib prefix="spring" 	uri="http://www.springframework.org/tags"%>
<%@ taglib prefix="fn" 		uri="http://java.sun.com/jsp/jstl/functions" %>
<%@page import="hsDesign.valueObject.PopupVO"%>
<%@page import="java.util.List"%>
<%@ page import="egovframework.com.cmm.util.EgovUserDetailsHelper" %>
<!DOCTYPE html>
<html lang="ko" >
<c:import url="/EgovPageLink.do?link=usr/inc/incHead" />
<script type="text/javascript">
$(function(){
	cookiedata = document.cookie;
	
	if ( cookiedata.indexOf("popuphtml=done") < 0 ){ //쿠키 변경 여부 불러오기
		  		
		  
		window.open("${pageContext.request.contextPath }/assets/html/popup.html", "new", "toolbar=no, menubar=no, scrollbars=no, resizable=no, width=700, height=450, left=0, top=0" );
		  
	}else{
		
	}
	<%
		List<PopupVO> popupList = (List<PopupVO>) request.getAttribute("popupList");
		int recordCnt = popupList.size();
		if(recordCnt > 0){
			for(PopupVO vo : popupList){
				String scrollYn = "Y".equals(vo.getPopScrollYn())? "yes":"no";
				String resizeYn = "Y".equals(vo.getPopResizeYn())? "yes":"no";
	%>
				
				if(getCookie("wcPopup<%=vo.getPopSeq()%>") != "no"){
					var option = "width=<%=vo.getPopWidth()%>, height=<%=vo.getPopHeight()%>, top=<%=vo.getPopTop()%>, left=<%=vo.getPopLeft()%>";
					option += ", scrollbars=<%=scrollYn%>, resizable=<%=resizeYn%>";
					window.open("<c:out value='${pageContext.request.contextPath }/usr/main/popupView.do?popSeq='/><%=vo.getPopSeq()%>", "", option);
				}
	<%
			}
		}
	%>
	
	function getCookie(name) {
		var nameOfCookie = name + "=";
		var x = 0
		while ( x <= document.cookie.length ) {
			var y = (x+nameOfCookie.length);
			if ( document.cookie.substring( x, y ) == nameOfCookie ) {
				if ( (endOfCookie=document.cookie.indexOf( ";",y )) == -1 ){
					endOfCookie = document.cookie.length;
				}
				return unescape( document.cookie.substring(y, endOfCookie ) );
			}
			x = document.cookie.indexOf( " ", x ) + 1;
			if ( x == 0 ) break;
		}
		return "";
	}
	
	//팝업 추가
	if(getCookie("wcPopup") != "no"){
		var tags = "";
		tags += 	'<div class="pop_wrap" style="display:none;"  >';
		tags += 	'		<img src="/assets/usr/img/layerPopup5.jpg" alt="" style="width: 100%; height: 95.4%;" usemap="#layerMap"/>';
		tags += 	'		<map name="layerMap">';
		tags += 	'			<area shape="rect" coords="0, 0, 494, 273" href="https://edubank.hansung.ac.kr/usr/community/notice/noticeView.do?cbSeq=13438"/>';
		tags += 	'			<area shape="rect" coords="501, 0, 1000, 273" href="https://edubank.hansung.ac.kr/usr/community/notice/noticeView.do?cbSeq=13422"/>';
		tags += 	'			<area shape="rect" coords="5, 285, 325, 380" href="https://edubank.hansung.ac.kr/usr/community/employment.do"/>';
		tags += 	'			<area shape="rect" coords="335, 285, 655, 380" href="https://edubank.hansung.ac.kr/usr/community/exhibit.do"/>';
		tags += 	'			<area shape="rect" coords="670, 285, 985, 380" href="https://edubank.hansung.ac.kr/usr/community/association.do"/>';
		tags += 	'		</map>';
		tags += 	'		<div class="pop_foot">';
		tags += 	'			<ul>';
		tags += 	'				<li><input type="checkbox" name="dayClose" id="dayClose" /> <label for="dayClose">하루 창 열지 않기</label></li>';
		tags += 	'				<li><a href="#" onclick="closePop(); return false;">닫기</a></li>';
		tags += 	'			</ul>';
		tags += 	'		</div>';
		tags += 	'</div>';
		
		$("#content").append(tags);
	}
	
});
	function fn_aviChange(url, seq){
		var tags = "";
		var playUrl = $("#playUrl").val();
		
		$("#playUrl").val(url);
		var playUrlCode;
		
		var tags_a = "";
		if(url.indexOf("youtu") != -1){
			if(url.indexOf("https:") != -1){
				var url = url.replace('https://youtu.be/','');
				var playUrlCode = playUrl.replace('https://youtu.be/','');
				tags += "<iframe src='https://www.youtube.com/embed/"+url+"?autoplay=1&rel=0&vq=hd720' frameborder='0' allowfullscreen class='m_frame'></iframe>";
				
			}else if(url.indexOf("https:") != -1){
				var url = url.replace('http://youtu.be/','');
				var playUrlCode = playUrl.replace('http://youtu.be/','');
				tags += "<iframe src='https://www.youtube.com/embed/"+url+"?autoplay=1&rel=0&vq=hd720' frameborder='0' allowfullscreen class='m_frame'></iframe>";
			}	
			tags_a += '<a href="#"  onclick="fn_aviChange(\''+playUrl+'\',\''+seq+'\'); return false;" style="cursor: pointer;" ><img src="https://img.youtube.com/vi/'+playUrlCode+'/0.jpg" alt="'+seq+'"></img></a>';
		}else if(url.indexOf("/vimeo") != -1){
			if(url.indexOf("https:") != -1){
				var url = url.replace('https://vimeo.com/','');
				var playUrlCode = playUrl.replace('https://vimeo.com/','');
				tags += "<iframe src='https://player.vimeo.com/video/"+url+"?autoplay=1&rel=0&vq=hd720' frameborder='0' webkitallowfullscreen mozallowfullscreen allowfullscreen class='m_frame'></iframe>";
						
			}else if(url.indexOf("https:") != -1){
				var url = url.replace('http://vimeo.com/','');
				var playUrlCode = playUrl.replace('http://vimeo.com/','');
				tags += "<iframe src='https://player.vimeo.com/video/"+url+"?autoplay=1&rel=0&vq=hd720' frameborder='0' webkitallowfullscreen mozallowfullscreen allowfullscreen class='m_frame'></iframe>";
				
			}
			tags_a += '<a href="#"  onclick="fn_aviChange('+playUrl+','+seq+'); return false;" style="cursor: pointer;" ><iframe src="https://player.vimeo.com/video/'+playUrlCode+'" frameborder="0" allowfullscreen class="m_frame"></iframe></a>';
		}	
		
		$(".video_box").empty();
		$(".video_box").append(tags);

		$("#aviBan"+seq).empty();
		$("#aviBan"+seq).append(tags_a);
		
		
		
	}
	// 팝업 쿠키 생성
	function setCookie(name, value, expiredays){ 
		var todayDate = new Date(); 
		todayDate.setDate( todayDate.getDate() + expiredays ); 
		document.cookie = name + "=" + escape( value ) + "; path=/; expires=" + todayDate.toGMTString() + ";" 
	} 

	// 팝업창 닫기
	function closePop(){
		if ($("input:checkbox[name=dayClose]").is(":checked")){
			setCookie("wcPopup", "no" , 1);
		} 
		$(".pop_wrap").remove();
	}
	
	function fnPopupView(){
		
		 $('.popup').show();
		  cookiedata = document.cookie;
		  if ( cookiedata.indexOf("custompopup=done") < 0 ){ //쿠키 변경 여부 불러오기
		  	document.all['popup'].style.visibility = "visible";
		  }
		  else {
		  	document.all['popup'].style.display = "none";
		  }
		
	}

	function PopupNoDisplay() {
	  setCookie("custompopup", "done", 1); //쿠키값 변경
	  PopupHide();
	}

	function PopupHide() { //팝업창 지우기
	  $('#popup').hide();
	 
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
	<!-- header -->
		<c:import url="/EgovPageLink.do?link=usr/inc/incTopnav2" />
		<!-- <div id="popup" class="popup" style="display:none; position: absolute; left:300px; top:300px; z-index: 100; visibility: visible;box-shadow:3px 3px 10px 3px #8d8b8b;background:#fff;">
            <div style="width:700px; height:500px; overflow:hidden; position: relative;">		
            
			 	<img src="/assets/html/img/banner_aprilNew.png" alt="팝업이미지" usemap="#map" style="border: 0; width:700px; height:400px;"/>
			</div>		
					
			 <div style="background:#1f2430; width:100%; height:40px; position:absolute; bottom:0; left:0;">
	                <div style=" overflow:hidden; margin-top:6px;">
	                    <button type="button" onclick="PopupNoDisplay();" style="background:#1f2430; margin-top: 5px; color: #fff; border:1px solid #1f2430; margin-left: 10px; cursor:pointer"><span>하루동안 보지않기</span></button>
	                    <button type="button" onclick="PopupHide();" style="background:#2f3545;float: right; margin-top: 1px; color: #fff; margin-right: 15px;border:1px solid #1f2430; padding: 4px 7px 4px 7px; ">닫기</button>
	                </div>
	          </div>
		</div>
            
            
		<map name="map" id="map">
		      	<area shape="rect" coords="35,81,335,374" href="https://edubank.hansung.ac.kr/usr/info/hdIntro.do" target="_blank" alt="" />
		    	<area shape="rect" coords="362,82,662,373" href="https://edubank.hansung.ac.kr/usr/community/proud/proudView.do?cbSeq=17903" target="_blank" alt="" />
		
		
		</map> -->
		<!--// header -->
		<!-- container - start -->
	<!-- 	<div class="n_main_content" id="content" style="visibility: hidden;">
			<div class="width_box">
				sns
				<div class="top_sns">
					<ul>
						<li><a href="<c:url value='https://www.instagram.com/handione_official/'/>" title="[새창] 인스타그램 바로가기" target="_blank"><img src="<c:out value='${pageContext.request.contextPath }/assets/usr/img/sns_i.jpg'/>" alt="인스타그램" /></a></li>
						<li><a href="<c:url value='https://www.facebook.com/hansungart'/>" title="[새창] 페이스북 바로가기" target="_blank"><img src="<c:out value='${pageContext.request.contextPath }/assets/usr/img/sns_f.jpg'/>" alt="페이스북" /></a></li>
						<li><a href="<c:url value='https://www.youtube.com/channel/UCCCqSlEk1kmlnbc669O-xwQ'/>" title="[새창] 유튜브 바로가기" target="_blank"><img src="<c:out value='${pageContext.request.contextPath }/assets/usr/img/sns_y.jpg'/>" alt="유투브" /></a></li>
						<li> &nbsp; <span style="color:#1b347d;font-weight:bold;font-size:10pt;">한디원 공식채널</span></li>
					</ul>
				</div>
				//sns
			</div>
			<div class="width_box">
				<div class="m_box_banner">
					<ul>
						<c:forEach var="list" items="${slideBannerList }">
							<li>
								<c:if test="${list.banNewWindow ne 'Y' && list.banNewWindow ne 'N'}">
									<c:if test="${list.banNewWindow eq '01' }">
										<a href="https://edulms.hansung.ac.kr/application/application_check1.php">																			</c:if>
									<c:if test="${list.banNewWindow ne '01' }">
										<a href="#" onclick="fn_appliForm_open('<c:out value="${list.banNewWindow }"/>'); return false;">
									</c:if>
								</c:if>
								<c:if test="${list.banNewWindow eq 'Y' || list.banNewWindow eq 'N'}">
									<c:if test="${fn:containsIgnoreCase(list.banUrl,'http')}">
										<a href="<c:out value='${list.banUrl}'/>"  <c:if test="${list.banAddWindow eq 'Y' }"> target="_blank"</c:if>>
									</c:if>
									<c:if test="${!fn:containsIgnoreCase(list.banUrl,'http')}">
										<a href="<c:out value='http://${list.banUrl}'/>"  <c:if test="${list.banAddWindow eq 'Y' }"> target="_blank"</c:if>>
									</c:if>
								</c:if>
								<dl>
									<dt><c:out value="${list.banName }"/></dt>
									<dd><c:out value="${list.banAddName1 }" escapeXml="false"/></dd>
								</dl>
								</a>
								<a href="<c:out value='${list.banUrl }'/>" <c:if test="${list.banNewWindow eq 'Y' }">target = "_blank"</c:if> class="m_more"><img src="/assets/usr/img/m_more_img.png" alt="더보기" /></a>
							</li>	
						</c:forEach>
						<%--
						<li>
							<a href="<c:url value='https://drive.google.com/file/d/0B4o3r-7T90Wlc0JrVUtpM0prcWs/view'/>" target="_blank">
							<dl>
								<dt>브로셔보기</dt>
								<dd>한디원의 장점을<br>브로셔로 만나보세요</dd>
							</dl>
							</a>
							<a href="<c:url value='https://drive.google.com/file/d/0B4o3r-7T90Wlc0JrVUtpM0prcWs/view'/>" target="_blank" class="m_more"><img src="/assets/usr/img/m_more_img.png" alt="더보기" /></a>
						</li>
						--%>
						<li>
							<a href="<c:out value='${pageContext.request.contextPath }/usr/info/brodata/broDataList.do'/>">
							<dl>
								<dt>작품자료실</dt>
								<dd>전공별 작품 보러가기</dd>
							</dl>
							</a>
							<a href="<c:out value='${pageContext.request.contextPath }/usr/info/brodata/broDataList.do'/>" class="m_more"><img src="/assets/usr/img/m_more_img.png" alt="더보기" /></a>
						</li>
						<%--
						<li>
							<a href="<c:out value='${pageContext.request.contextPath }/usr/community/enterprise.do'/>" target="_blank" >
							<dl>
								<dt>산학협력 현황</dt>
								<dd>기업과 함께하는<br> 한디원</dd>
							</dl>
							</a>
							<a href="<c:out value='${pageContext.request.contextPath }/usr/community/enterprise.do'/>" target="_blank" class="m_more"><img src="/assets/usr/img/m_more_img.png" alt="더보기" /></a>
						</li>
						--%>
						<%--<li>
							<a href="<c:out value='${pageContext.request.contextPath }/usr/community/notice/noticeView.do?cbSeq=14179'/>">
							<dl>
								<dt>진로체험스쿨</dt>
								<dd>
									디자인분야 현직 전문가들에 의한<br/>
									진로 및 취업상담
								</dd>
							</dl>
							</a>
							<a href="<c:out value='${pageContext.request.contextPath }/usr/community/notice/noticeView.do?cbSeq=14179'/>" target="_blank"  class="m_more"><img src="/assets/usr/img/m_more_img.png" alt="더보기" /></a>
						</li>--%>
						 <li>
							<a href="<c:out value='${pageContext.request.contextPath }/usr/general/exper/experInfo.do'/>">
							<dl>
								<dt>진로체험스쿨</dt>
								<dd>디자인분야 현직 전문가들에 의한<br/>
								 진로 및 취업상담</dd>
							</dl>
							</a>
							<a href="<c:out value='${pageContext.request.contextPath }/usr/general/exper/experInfo.do'/>" target="_blank"  class="m_more"><img src="/assets/usr/img/m_more_img.png" alt="더보기" /></a>
						</li> 
						<li>
							<a href="<c:out value='${pageContext.request.contextPath }/usr/community/exhibit.do'/>" target="_blank">
							<dl>
								<dt>국제공모전 수상</dt>
								<dd>국제공모전<br>4개대회 연속 수상</dd>
							</dl>
							</a>
							<a href="<c:out value='${pageContext.request.contextPath }/usr/community/exhibit.do'/>" target="_blank" class="m_more"><img src="/assets/usr/img/m_more_img.png" alt="더보기" /></a>
						</li>
						<li>
							<a href="<c:out value='${pageContext.request.contextPath }/usr/majorBoard/beauty/majorBeautyInfo.do?menuType=01'/>" target="_blank">
							<dl>
								<dt>2+2본교연계과정</dt>
								<dd>한성대학교 <br>뷰티매니지먼트학과<br>졸업장 취득</dd>
							</dl>
							</a>
							<a href="<c:out value='${pageContext.request.contextPath }/usr/majorBoard/beauty/majorBeautyInfo.do?menuType=01'/>" target="_blank" class="m_more"><img src="/assets/usr/img/m_more_img.png" alt="더보기" /></a>
						</li>
						<li>
							<a href="<c:out value='${pageContext.request.contextPath }/usr/majorBoard/digitalArt/majorDigitalArtJobList.do?menuType=05'/>">
							<dl>
								<dt>성우콘텐츠 크리에이터과정</dt>
								<dd>한디원과<br>(사)한국성우협회가 함께 합니다.</dd>
							</dl>
							</a>
							<a href="<c:out value='${pageContext.request.contextPath }/usr/majorBoard/digitalArt/majorDigitalArtJobList.do?menuType=05'/>" class="m_more"><img src="/assets/usr/img/m_more_img.png" alt="더보기" /></a>
						</li>
						<li>
							<a href="<c:out value='${pageContext.request.contextPath }/usr/majorBoard/digitalEnt/majorDigitalEntInfo.do?menuType=01'/>">
							<dl>
								<dt>디지털아트(게임) <br> 전공 개설</dt>
								<dd>게임일러스트레이션, 게임개발, e스포츠</dd>
							</dl>
							</a>
							<a href="<c:out value='${pageContext.request.contextPath }/usr/majorBoard/digitalEnt/majorDigitalEntInfo.do?menuType=01'/>" class="m_more"><img src="/assets/usr/img/m_more_img.png" alt="더보기" /></a>
						</li>
					</ul>
				</div>
			</div>
		</div> -->
		<!-- container - end -->
		<!-- 영상배너 - start -->

		<div class="n_main_content" id="aviBanner"  style="background-color:#272727;">
			<div class="width_box">
				<div class="video_list01">
					<div class="video_box">
						<c:if test="${fn:containsIgnoreCase(aviBannerOne.banUrl,'youtu')}">
							<c:if test="${fn:containsIgnoreCase(aviBannerOne.banUrl,'https:')}"> 
								<iframe src="https://www.youtube.com/embed/<c:out value='${fn:trim(fn:replace(aviBannerOne.banUrl,"https://youtu.be/","")) }'/>?rel=0&vq=hd720" frameborder="0" allowfullscreen class="m_frame"></iframe>
							</c:if>
							<c:if test="${fn:containsIgnoreCase(aviBannerOne.banUrl,'http:')}"> 
								<iframe src="https://www.youtube.com/embed/<c:out value='${fn:trim(fn:replace(aviBannerOne.banUrl,"http://youtu.be/","")) }'/>?rel=0&vq=hd720" frameborder="0" allowfullscreen class="m_frame"></iframe>
							</c:if>
						</c:if>
						<c:if test="${fn:containsIgnoreCase(aviBannerOne.banUrl,'vimeo') }">
							<c:if test="${fn:containsIgnoreCase(aviBannerOne.banUrl,'https:')}">
								<iframe src="https://player.vimeo.com/video/<c:out value='${fn:trim(fn:replace(aviBannerOne.banUrl,"https://vimeo.com/","")) }'/>" frameborder="0" allowfullscreen class="m_frame"></iframe>
							</c:if>
							<c:if test="${fn:containsIgnoreCase(aviBannerOne.banUrl,'http:')}">
								<iframe src="https://player.vimeo.com/video/<c:out value='${fn:trim(fn:replace(aviBannerOne.banUrl,"http://vimeo.com/","")) }'/>" frameborder="0" allowfullscreen class="m_frame"></iframe>
							</c:if>
						</c:if>
					</div>
					<input type="hidden" id="playUrl" value="<c:out value='${aviBannerOne.banUrl}'/>"/>
					<div class="video_sum_box">
						<ul>
							<c:if test="${!empty aviBannerList }">
								<c:forEach var="list" items="${aviBannerList }" varStatus="status">
									<c:if test="${status.index ne 0 }">
										<c:if test="${fn:containsIgnoreCase(list.banUrl,'youtu')}">
											<c:if test="${fn:containsIgnoreCase(list.banUrl,'https:')}"> 
			 									<li id="aviBan<c:out value='${list.banSeq }'/>"><a href="#"  onclick="fn_aviChange('<c:out value='${list.banUrl }'/>','<c:out value='${list.banSeq }'/>'); return false;" style="cursor: pointer;" ><img src="https://img.youtube.com/vi/<c:out value='${fn:trim(fn:replace(list.banUrl,"https://youtu.be/","")) }'/>/0.jpg" alt="<c:out value='${list.banName }'/>"></img></a></li>
											</c:if>
											<c:if test="${fn:containsIgnoreCase(list.banUrl,'http:')}">
												<li id="aviBan<c:out value='${list.banSeq }'/>"><a href="#"  onclick="fn_aviChange('<c:out value='${list.banUrl }'/>','<c:out value='${list.banSeq }'/>'); return false;" style="cursor: pointer;" ><img src="https://img.youtube.com/vi/<c:out value='${fn:trim(fn:replace(list.banUrl,"http://youtu.be/","")) }'/>/0.jpg" alt="<c:out value='${list.banName }'/>"></img></a></li>
											</c:if>
										</c:if>
										<c:if test="${fn:containsIgnoreCase(list.banUrl,'/vimeo')}">
											<c:if test="${fn:containsIgnoreCase(list.banUrl,'https:')}">
												<li id="aviBan<c:out value='${list.banSeq }'/>"><a href="#"  onclick="fn_aviChange('<c:out value='${list.banUrl }'/>','<c:out value='${list.banSeq }'/>'); return false;" style="cursor: pointer;" ><iframe src="https://player.vimeo.com/video/<c:out value='${fn:trim(fn:replace(list.banUrl,"https://vimeo.com/","")) }'/>" frameborder="0" allowfullscreen class="m_frame"></iframe></a></li>
											</c:if>
											<c:if test="${fn:containsIgnoreCase(list.banUrl,'http:')}">
												<li id="aviBan<c:out value='${list.banSeq }'/>"><a href="#"  onclick="fn_aviChange('<c:out value='${list.banUrl }'/>','<c:out value='${list.banSeq }'/>'); return false;" style="cursor: pointer;" ><iframe src="https://player.vimeo.com/video/<c:out value='${fn:trim(fn:replace(list.banUrl,"http://vimeo.com/","")) }'/>" frameborder="0" allowfullscreen class="m_frame"></iframe></a></li>
											</c:if>
										</c:if>
									</c:if> 
								</c:forEach>
							</c:if>
						</ul>
					</div>					
				</div>
				<div class="video_list02">
					<ul class="video_box">
						<c:forEach var="list" items="${aviBannerList }">
							<c:if test="${fn:containsIgnoreCase(list.banUrl,'youtu')}">
								<c:if test="${fn:containsIgnoreCase(list.banUrl,'https:')}"> 
 									<li style="background-color:#000;"><iframe src="https://www.youtube.com/embed/<c:out value='${fn:trim(fn:replace(list.banUrl,"https://youtu.be/","")) }'/>?rel=0&vq=hd720" frameborder="0" allowfullscreen class="m_frame"></iframe></li>
								</c:if>
								<c:if test="${fn:containsIgnoreCase(list.banUrl,'http:')}">
									<li style="background-color:#000;"><iframe src="https://www.youtube.com/embed/<c:out value='${fn:trim(fn:replace(list.banUrl,"http://youtu.be/","")) }'/>?rel=0&vq=hd720" frameborder="0" allowfullscreen class="m_frame"></iframe></li>
								</c:if>
							</c:if>
							<c:if test="${fn:containsIgnoreCase(list.banUrl,'/vimeo')}">
								<c:if test="${fn:containsIgnoreCase(list.banUrl,'https:')}">
									<li style="background-color:#000;"><iframe src="https://player.vimeo.com/video/<c:out value='${fn:trim(fn:replace(list.banUrl,"https://vimeo.com/","")) }'/>" frameborder="0" allowfullscreen class="m_frame"></iframe></li>
								</c:if>
								<c:if test="${fn:containsIgnoreCase(list.banUrl,'http:')}">
									<li style="background-color:#000;"><iframe src="https://player.vimeo.com/video/<c:out value='${fn:trim(fn:replace(list.banUrl,"http://vimeo.com/","")) }'/>" frameborder="0" allowfullscreen class="m_frame"></iframe></li>
								</c:if>
							</c:if> 
						</c:forEach>
					</ul>
				</div>		
			</div>
		</div>

		<!-- 영상배너 - end -->
		<!-- 한디원 이슈 & 한디원 행사 - start -->
		<div class="n_main_content" id="proudContent" style="visibility: hidden;">
			<div class="width_box">
				<!-- <div class="tit_line"><div>한디원 이슈</div> <a href="<c:out value='${pageContext.request.contextPath }/usr/community/proud/proudList.do'/>">더보기 +</a></div>
				<ul>
					<c:forEach var="list" items="${proudList }">
						<li>
							<a href="<c:out value='${pageContext.request.contextPath }/usr/community/proud/proudView.do?cbSeq=${list.cbSeq }'/>">
								<dl>
									<dt>
										<c:if test="${list.cbThType eq 'IMG' }">
											<c:if test="${fn:contains(list.cbThImgPath,'/old/') }">
												<img onerror='this.src="<c:out value='/assets/usr/img/no_img.jpg'/>"' src="<c:out value='/showImage.do?filePath=${list.cbThImgPath}'/>" alt="<c:out value='${list.cbThImgName }'/>" />	
											</c:if>
											<c:if test="${!fn:contains(list.cbThImgPath,'/old/') }">
												<img onerror='this.src="<c:out value='/assets/usr/img/no_img.jpg'/>"' src="<c:out value='/showImage.do?filePath=${fn:split(list.cbThImgPath,".")[0]}_thumbnail.${fn:split(list.cbThImgPath,".")[1]}'/>" alt="<c:out value='${list.cbThImgName }'/>" />
											</c:if>
										</c:if>
										<c:if test="${list.cbThType eq 'AVI' }">
											<c:if test="${fn:containsIgnoreCase(list.cbThUrl,'youtu')}">
												<c:if test="${fn:containsIgnoreCase(list.cbThUrl,'https:')}">
													<iframe  src="https://www.youtube.com/embed/<c:out value='${fn:trim(fn:replace(list.cbThUrl,"https://youtu.be/","")) }'/>" frameborder="0" allowfullscreen></iframe>
												</c:if>
												<c:if test="${fn:containsIgnoreCase(list.cbThUrl,'http:')}">
													<iframe  src="https://www.youtube.com/embed/<c:out value='${fn:trim(fn:replace(list.cbThUrl,"http://youtu.be/","")) }'/>" frameborder="0" allowfullscreen></iframe>
												</c:if>
											</c:if>
											<c:if test="${fn:containsIgnoreCase(list.cbThUrl,'/vimeo')}">
												<c:if test="${fn:containsIgnoreCase(list.cbThUrl,'https:')}">
													<iframe src="https://player.vimeo.com/video/<c:out value='${fn:trim(fn:replace(list.cbThUrl,"https://vimeo.com/","")) }'/>"  frameborder="0" webkitallowfullscreen mozallowfullscreen allowfullscreen></iframe>
												</c:if>
												<c:if test="${fn:containsIgnoreCase(list.cbThUrl,'http:')}">
													<iframe src="https://player.vimeo.com/video/<c:out value='${fn:trim(fn:replace(list.cbThUrl,"http://vimeo.com/","")) }'/>"  frameborder="0" webkitallowfullscreen mozallowfullscreen allowfullscreen></iframe>
												</c:if>
											</c:if>
										</c:if>
									</dt>
									<dd><c:out value='${list.cbTitle }' escapeXml="false"/></dd>
								</dl>
							</a>
						</li>	 
					</c:forEach>
				</ul> -->
				<!-- <div class="tit_line"><div>한디원 행사</div> <a href="<c:out value='${pageContext.request.contextPath }/usr/community/festival/festivalList.do'/>">더보기 +</a></div>
				<ul>
					<c:forEach var="list" items="${festivalList }">
						<li>
							<a href="<c:out value='${pageContext.request.contextPath }/usr/community/festival/festivalView.do?cbSeq=${list.cbSeq }'/>">
								<dl>
									<dt>
										<c:if test="${list.cbThType eq 'IMG' }">
											<c:if test="${fn:contains(list.cbThImgPath,'/old/') }">
												<img onerror='this.src="<c:out value='/assets/usr/img/no_img.jpg'/>"' src="<c:out value='/showImage.do?filePath=${list.cbThImgPath}'/>" alt="<c:out value='${list.cbThImgName }'/>" />	
											</c:if>
											<c:if test="${!fn:contains(list.cbThImgPath,'/old/') }">
												<img onerror='this.src="<c:out value='/assets/usr/img/no_img.jpg'/>"' src="<c:out value='/showImage.do?filePath=${fn:split(list.cbThImgPath,".")[0]}_thumbnail.${fn:split(list.cbThImgPath,".")[1]}'/>" alt="<c:out value='${list.cbThImgName }'/>" />
											</c:if>
										</c:if>
										<c:if test="${list.cbThType eq 'AVI' }">
											<c:if test="${fn:containsIgnoreCase(list.cbThUrl,'youtu')}">
												<c:if test="${fn:containsIgnoreCase(list.cbThUrl,'https:')}">
													<iframe  src="https://www.youtube.com/embed/<c:out value='${fn:trim(fn:replace(list.cbThUrl,"https://youtu.be/","")) }'/>" frameborder="0" allowfullscreen></iframe>
												</c:if>
												<c:if test="${fn:containsIgnoreCase(list.cbThUrl,'http:')}">
													<iframe  src="https://www.youtube.com/embed/<c:out value='${fn:trim(fn:replace(list.cbThUrl,"http://youtu.be/","")) }'/>" frameborder="0" allowfullscreen></iframe>
												</c:if>
											</c:if>
											<c:if test="${fn:containsIgnoreCase(list.cbThUrl,'/vimeo')}">
												<c:if test="${fn:containsIgnoreCase(list.cbThUrl,'https:')}">
													<iframe src="https://player.vimeo.com/video/<c:out value='${fn:trim(fn:replace(list.cbThUrl,"https://vimeo.com/","")) }'/>"  frameborder="0" webkitallowfullscreen mozallowfullscreen allowfullscreen></iframe>
												</c:if>
												<c:if test="${fn:containsIgnoreCase(list.cbThUrl,'http:')}">
													<iframe src="https://player.vimeo.com/video/<c:out value='${fn:trim(fn:replace(list.cbThUrl,"http://vimeo.com/","")) }'/>"  frameborder="0" webkitallowfullscreen mozallowfullscreen allowfullscreen></iframe>
												</c:if>
											</c:if>
										</c:if>
									</dt>
									<dd><c:out value='${list.cbTitle }' escapeXml="false"/></dd>
								</dl>
							</a>
						</li>	 
					</c:forEach>
					
				</ul> -->
				<div class="tit_line"><div>한디원 전공 소식</div> <!-- <a href="<c:out value='${pageContext.request.contextPath }/usr/community/festival/festivalList.do'/>">더보기 +</a> --></div>
				<ul>
					<c:forEach var="list" items="${majorMainList }" varStatus="status">
						<li>
							
<%-- 							<a href="<c:out value='${pageContext.request.contextPath }/usr/${list.mCode > 10? (list.mCode == 11? "majorBoard":list.dept2): list.dept2.concat("Board")}/${list.dept}/${list.mCode == 11? "major":list.dept2}${list.dept.substring(0,1).toUpperCase().concat(list.dept.substring(1)) }View.do?pageIndex=1&searchType=${list.mbGubun1 }&mbSeq=${list.mbSeq }'/><c:if test="${list.mCode eq '01'}">&menuNo=10106</c:if>">
 --%>								
 
							<a href="<c:out value='${pageContext.request.contextPath }/usr/${list.mCode > 10? (list.mCode == 11? "majorBoard":list.dept2): list.dept2.concat("Board")}/${list.dept}/${list.mCode == 11? "major":list.dept2}${list.dept.substring(0,1).toUpperCase().concat(list.dept.substring(1)) }View.do?pageIndex=1&searchType=${list.mbGubun1 }&mbSeq=${list.mbSeq }'/><c:if test="${list.mCode eq '01'}">&menuNo=10106</c:if>">
 
 								<dl>
									<dt>
										<c:if test="${list.mbthType eq 'IMAGE' }">
											<c:if test="${list.mbOldYn eq 'Y' }">
												<img onerror='this.src="<c:out value='/assets/usr/img/no_img.jpg'/>"' src="<c:out value='/showImage.do?filePath=${list.mbthImgPath}'/>" alt="<c:out value='${list.mbthImgPath }'/>" />	
											</c:if>
											<c:if test="${list.mbOldYn eq 'N' }">
												<img onerror='this.src="<c:out value='/assets/usr/img/no_img.jpg'/>"' src="<c:out value='/showImage.do?filePath=${fn:split(list.mbthImgPath,".")[0]}_thumbnail.${fn:split(list.mbthImgPath,".")[1]}'/>" alt="<c:out value='${list.mbthImgPath }'/>" />
											</c:if>
										</c:if>
										<c:if test="${list.mbthType eq 'VIDEO' }">
											<c:if test="${fn:containsIgnoreCase(list.mbthUrl,'youtu')}">
												<c:if test="${fn:containsIgnoreCase(list.mbthUrl,'https:')}">
													<iframe  src="https://www.youtube.com/embed/<c:out value='${fn:trim(fn:replace(list.mbthUrl,"https://youtu.be/","")) }'/>?rel=0&vq=hd720&hd=1&fs=1" frameborder="0" allowfullscreen></iframe>
												</c:if>
												<c:if test="${fn:containsIgnoreCase(list.mbthUrl,'http:')}">
													<iframe  src="https://www.youtube.com/embed/<c:out value='${fn:trim(fn:replace(list.mbthUrl,"http://youtu.be/","")) }'/>?rel=0&vq=hd720&hd=1&fs=1" frameborder="0" allowfullscreen></iframe>
												</c:if>
											</c:if>
											<c:if test="${fn:containsIgnoreCase(list.mbthUrl,'/vimeo')}">
												<c:if test="${fn:containsIgnoreCase(list.cbThUrl,'https:')}">
													<iframe src="https://player.vimeo.com/video/<c:out value='${fn:trim(fn:replace(list.mbthUrl,"https://vimeo.com/","")) }'/>"  frameborder="0" webkitallowfullscreen mozallowfullscreen allowfullscreen></iframe>
												</c:if>
												<c:if test="${fn:containsIgnoreCase(list.mbthUrl,'http:')}">
													<iframe src="https://player.vimeo.com/video/<c:out value='${fn:trim(fn:replace(list.mbthUrl,"http://vimeo.com/","")) }'/>"  frameborder="0" webkitallowfullscreen mozallowfullscreen allowfullscreen></iframe>
												</c:if>
											</c:if>
										</c:if>
									</dt>
									<dd><c:out value='${list.mbTitle }' escapeXml="false"/></dd>
								</dl>
							</a>
						</li>	 
					</c:forEach>
					
				</ul>
				
				<!-- <div class="tit_line"><div>공지사항</div> <a href="<c:out value='${pageContext.request.contextPath }/usr/community/notice/noticeList.do'/>">더보기 +</a></div>
				<div class="main_notice_list">
					<c:forEach items="${ntResultList }" var="ntResult">
						<ul>
							<li><a href="<c:out value='${pageContext.request.contextPath }/usr/community/notice/noticeView.do?cbSeq=${ntResult.cbSeq }'/>"><c:out value="${ntResult.cbTitle }" escapeXml="false"/></a></li>
							<li><c:out value="${ntResult.cbRegDate }"/></li>
						</ul>
					</c:forEach>
				</div> -->
			</div>
		</div>
		<!-- 자랑스런 한디원 & 한디원 행사 - end -->
		<!-- 하단 롤링 배너 - start -->
		<c:import url="/usr/incBtmRollingBanner.do"/>
		<!-- 하단 롤링 배너 - end -->
		<hr />
		<!-- footer -->		
		<div id="divFooter" style="visibility: hidden;">
			<c:import url="/EgovPageLink.do?link=usr/inc/incFooter" />
		</div>
		
		<!--// footer -->
	</div>
<input type="hidden" id="message" value="${message}" />
</form:form>
<script type="text/javascript" src="<c:out value='${pageContext.request.contextPath }/assets/usr/js/imagesloaded.pkgd.min.js'/>"></script>
<script type="text/javascript">
	$(function(){
		/*
		$(".m_visual").imagesLoaded({ background: ".m_vh" },function(){
			console.log("m_visual loading complete!");
		*/
		<c:if test="${fn:length(mainBannerList) > 1 }">
			slider = $('.m_visual > ul').bxSlider({
				auto : true
				, autoHover: true
				, preloadImages : "visible"
				, onSliderLoad : function(){
					$(".m_visual ul").css("visibility", "visible");
					$(".black_bar").css("visibility", "visible");
					$("#content").css("visibility", "visible");
					if($("#aviBanner").length > 0) $("#aviBanner").css("visibility", "visible");
					$("#proudContent").css("visibility", "visible");
					$("#btmRollingBanner").css("visibility", "visible");
					$("#divFooter").css("visibility", "visible");
				}
			});
		</c:if>
		<c:if test="${fn:length(mainBannerList) <= 1 }">
			$(".m_visual ul").css("visibility", "visible");
			$(".black_bar").css("visibility", "visible");
			$("#content").css("visibility", "visible");
			if($("#aviBanner").length > 0) $("#aviBanner").css("visibility", "visible");
			$("#proudContent").css("visibility", "visible");
			$("#btmRollingBanner").css("visibility", "visible");
			$("#divFooter").css("visibility", "visible");
		</c:if>
		/*
		});
		*/
	});

</script>
</body>
</html>