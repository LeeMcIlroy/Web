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
	
	// 목록
	function fn_list(){
		$("#frm").attr("method", "post").attr("action", "<c:out value='${pageContext.request.contextPath }/usr/news/ucc/uccList.do'/>").submit();
	}

	// 조회
	function fn_select(cbSeq){
		$("#cbSeq").val(cbSeq);
		
		$("#frm").attr("method", "get").attr("action", "<c:out value='${pageContext.request.contextPath }/usr/news/ucc/uccView.do'/>").submit();
	}
	
	$("iframe").click(function(e){
		e.stopPropagation();
	});
	/* 
	var flag = true;
	// 목록조회
	$(function(){
		$(window).scroll(function(){
 			if  ($(window).scrollTop() + $(window).height() >= $("#footer").offset().top){
 				if(flag){
					fn_select_add();
 				}
			}
		});
	});
	 */
	// 이전글 보기
	function fn_select_add(){
		flag = false;
		$.ajax({
			url: "<c:out value='${pageContext.request.contextPath }/usr/news/festival/festivalPreView.do'/>"
			, type: "get"
			, data: "cbSeq="+$("#cbSeq").val()+"&cbType="+$("#cbType").val()
			, dataType:"json"
			, success: function(data){
				cmmBoardVO = data.cmmBoardVO;
				if(cmmBoardVO == null){
					alert("마지막 글입니다.");
					return false;
				}else{
					
				recentList = data.recentList;
							
				
				tags = "<div class='transform_table notice_type'><div class='tbl_view'>";
				tags += "<ul class='tbl_view_m'>";
				tags += "<li class='txt_left'>"+cmmBoardVO.cbTitle+"</li>";
				tags += "<li>작성자 : "+cmmBoardVO.regName+"</li>";
				tags += "<li>"+cmmBoardVO.cbRegDate+"</li>";
				tags += "<li>"+cmmBoardVO.cbCount+"</li>";
				tags += "</ul>";
				tags += "<div class='tbl_cont'><div class='video_box'>";
				if(cmmBoardVO.cbThUrl.indexOf("youtu") != -1){
					if(cmmBoardVO.cbThUrl.indexOf("https:") != -1){
						var cbThUrl = cmmBoardVO.cbThUrl.replace('https://youtu.be/','');
						tags += "<iframe width='560' height='315' src='https://www.youtube.com/embed/"+cbThUrl+"' frameborder='0' allowfullscreen></iframe>"
					}else if(cmmBoardVO.cbThUrl.indexOf("https:") != -1){
						var cbThUrl = cmmBoardVO.cbThUrl.replace('http://youtu.be/','');
						tags += "<iframe width='560' height='315 src='https://www.youtube.com/embed/"+cbThUrl+"' frameborder='0' allowfullscreen></iframe>";
					}							
				}else if(cmmBoardVO.cbThUrl.indexOf("/vimeo") != -1){
					if(cmmBoardVO.cbThUrl.indexOf("https:") != -1){
						var cbThUrl = cmmBoardVO.cbThUrl.replace('https://vimeo.com/','');
						tags += "<iframe src='https://player.vimeo.com/video/"+cbThUrl+"' width='560' height='315 frameborder='0' webkitallowfullscreen mozallowfullscreen allowfullscreen></iframe>"
					}else if(cmmBoardVO.cbThUrl.indexOf("https:") != -1){
						var cbThUrl = cmmBoardVO.cbThUrl.replace('http://vimeo.com/','');
						tags += "<iframe src='https://player.vimeo.com/video/"+cbThUrl+"' width='560' height='315 frameborder='0' webkitallowfullscreen mozallowfullscreen allowfullscreen></iframe>";
					
					}
				}	
				
				tags += "</div>"+cmmBoardVO.cbContent +"</div></div></div>";
				tags += "<div class='btn_box'><a href='#' class='btn_go_list' onclick='fn_list(); return false;'>목록</a></div>";
				if(!(recentList == null || recentList.length == 0)){
					tags += "<div class='sub_page_area'>";
					tags += "<div class='sub_title'>최신글</div></div>";
					tags += "<ul class='view_page_link'>";
					for(i =0; i<recentList.length; i++){
						tags += "<li><a href='#' onclick='fn_select('"+cmmBoardVO.cbSeq+"'); return false;'>";
						tags += "<dl><dt>"
						if(recentList[i].cbThUrl.indexOf("youtu") != -1){
							if(recentList[i].cbThUrl.indexOf("https:") != -1){
								var cbThUrl = recentList[i].cbThUrl.replace('https://youtu.be/','');
								tags += "<iframe width='209' height='129' src='https://www.youtube.com/embed/"+cbThUrl+"' frameborder='0' allowfullscreen></iframe>"
							}else if(recentList[i].cbThUrl.indexOf("https:") != -1){
								var cbThUrl = recentList[i].cbThUrl.replace('http://youtu.be/','');
								tags += "<iframe width='209' height='129' src='https://www.youtube.com/embed/"+cbThUrl+"' frameborder='0' allowfullscreen></iframe>";
							}							
						}else if(recentList[i].cbThUrl.indexOf("/vimeo") != -1){
							if(recentList[i].cbThUrl.indexOf("https:") != -1){
								var cbThUrl = recentList[i].cbThUrl.replace('https://vimeo.com/','');
								tags += "<iframe src='https://player.vimeo.com/video/"+cbThUrl+"' width='209' height='129' frameborder='0' webkitallowfullscreen mozallowfullscreen allowfullscreen></iframe>"
							}else if(recentList[i].cbThUrl.indexOf("https:") != -1){
								var cbThUrl = recentList[i].cbThUrl.replace('http://vimeo.com/','');
								tags += "<iframe src='https://player.vimeo.com/video/"+cbThUrl+"' width='209' height='129' frameborder='0' webkitallowfullscreen mozallowfullscreen allowfullscreen></iframe>";
							
							}
						}											
						tags += "</dt><dd>"+cmmBoardVO.cbTitle+"</dd></dl></a></li>";
						
					}
					
					tags += "</ul><br/><br/>";
				}
				
				
				$("#cbSeq").val(cmmBoardVO.cbSeq);
				$("#viewPage").append(tags);
				
				// .scroll() 이벤트 지속성 방지를 위해 setTimeout()
				setTimeout(function(){flag = true;}, 500);
				
				}
			}
			, error: function(){
				alert("오류가 발생하였습니다.");
			}
		});
	}
</script>
<body>
<form:form commandName="searchVO" id="frm" name="frm">
<form:hidden path="pageIndex"/>
<form:hidden path="searchType"/>
<form:hidden path="menuType"/>
<form:hidden path="searchCondition2"/>
<form:hidden path="searchWord"/>
<input type="hidden" id="cbSeq" name="cbSeq" value="${cmmBoardVO.cbSeq }"/>
<input type="hidden" id="cbType" name="cbType" value="${cmmBoardVO.cbType }"/>
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
					<jsp:param name="dept1" value="한디원뉴스"/>
		            <jsp:param name="dept2" value="작품동영상 & UCC"/>
	           	</jsp:include>
	           	<div id="viewPage">
					<div class="transform_table notice_type">
						<div class="tbl_view">
							<ul class="tbl_view_m">
								<li class="txt_left"><c:out value="${cmmBoardVO.cbTitle }" escapeXml="false"/></li>
								<li>작성자 : <c:out value="${cmmBoardVO.regName }"/></li>
								<li><c:out value="${cmmBoardVO.cbRegDate }"/></li>
								<li><c:out value="${cmmBoardVO.cbCount }"/></li>
							</ul>
							<div class="tbl_cont">
								<%-- 
								<div class="video_box">
									<c:if test="${fn:containsIgnoreCase(cmmBoardVO.cbThUrl,'youtu')}">
										<c:if test="${fn:containsIgnoreCase(cmmBoardVO.cbThUrl,'https:')}">
											<iframe width="560" height="315" src="https://www.youtube.com/embed/<c:out value='${fn:trim(fn:replace(cmmBoardVO.cbThUrl,"https://youtu.be/","")) }'/>?rel=0&vq=hd720" frameborder="0" allowfullscreen></iframe>
										</c:if>
										<c:if test="${fn:containsIgnoreCase(cmmBoardVO.cbThUrl,'http:')}">
											<iframe width="560" height="315" src="https://www.youtube.com/embed/<c:out value='${fn:trim(fn:replace(cmmBoardVO.cbThUrl,"http://youtu.be/","")) }'/>?rel=0&vq=hd720" frameborder="0" allowfullscreen></iframe>
										</c:if>
									</c:if>
									<c:if test="${fn:containsIgnoreCase(cmmBoardVO.cbThUrl,'/vimeo')}">
										<c:if test="${fn:containsIgnoreCase(cmmBoardVO.cbThUrl,'https:')}">
											<iframe width="560" height="315" src="https://player.vimeo.com/video/<c:out value='${fn:trim(fn:replace(cmmBoardVO.cbThUrl,"https://vimeo.com/","")) }'/>" frameborder="0" webkitallowfullscreen mozallowfullscreen allowfullscreen></iframe>
										</c:if>
										<c:if test="${fn:containsIgnoreCase(cmmBoardVO.cbThUrl,'http:')}">
											<iframe width="560" height="315" src="https://player.vimeo.com/video/<c:out value='${fn:trim(fn:replace(cmmBoardVO.cbThUrl,"http://vimeo.com/","")) }'/>" frameborder="0" webkitallowfullscreen mozallowfullscreen allowfullscreen></iframe>
										</c:if>
									</c:if>
								</div>
								 --%>
								<c:out value="${cmmBoardVO.cbContent }" escapeXml="false" />
							</div>
						</div>
					</div>
					<div class="btn_box">
						<a href="#" class="btn_go_list" onclick="fn_list(); return false;">목록</a>
					</div>
					<c:if test="${!empty recentList }">
					<div class="sub_page_area">
						<div class="sub_title">최신글</div>
					</div>
					<ul class="view_page_link">
						<c:forEach var="list" items="${recentList }">
						<li>
							<a href="#" onclick="fn_select(<c:out value='${list.cbSeq }'/>); return false;">
								<dl>
									<dt>
										<c:if test="${list.cbThType eq 'IMG' }">
											<img src="<c:out value='/showImage.do?filePath=${list.cbThImgPath}'/>" alt="<c:out value='${list.cbThImgName }'/>" />
										</c:if>
										<c:if test="${list.cbThType eq 'AVI' }">
											<c:if test="${fn:containsIgnoreCase(list.cbThUrl,'youtu')}">
												<c:if test="${fn:containsIgnoreCase(list.cbThUrl,'https:')}">
													<iframe  src="https://www.youtube.com/embed/<c:out value='${fn:trim(fn:replace(list.cbThUrl,"https://youtu.be/","")) }'/>?rel=0&vq=hd720" frameborder="0" allowfullscreen></iframe>
												</c:if>
												<c:if test="${fn:containsIgnoreCase(list.cbThUrl,'http:')}">
													<iframe  src="https://www.youtube.com/embed/<c:out value='${fn:trim(fn:replace(list.cbThUrl,"http://youtu.be/","")) }'/>?rel=0&vq=hd720" frameborder="0" allowfullscreen></iframe>
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
									<dd><c:out value="${list.cbTitle }" escapeXml="false"/></dd>
								</dl>
							</a>
						</li>
						</c:forEach>
					</ul>
					</c:if>
				</div>
			</div>
			<div class="go_top"><a href="javascript:window.scrollTo(0,0)"><strong>▲</strong><br>TOP</a></div>
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