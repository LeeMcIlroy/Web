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
		$("#frm").attr("method", "post").attr("action", "<c:out value='${pageContext.request.contextPath }/usr/majorBoard/interior/majorInteriorList.do'/>").submit();
	}
	
	// 조회
	function fn_select(mbSeq){
		$("#mbSeq").val(mbSeq);
		$("#frm").attr("method", "get").attr("action", "<c:out value='${pageContext.request.contextPath }/usr/majorBoard/interior/majorInteriorView.do'/>").submit();
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
			url: "<c:out value='${pageContext.request.contextPath }/usr/majorBoard/interior/majorInteriorPreView.do'/>"
			, type: "get"
			, data: "mbSeq="+$("#mbSeq").val()+"&mCode="+$("#mCode").val()+"&mbGubun1="+$("#mbGubun1").val()+"&mbGubun2="+$("#mbGubun2").val()
			, dataType:"json"
			, success: function(data){
				majorBoardVO = data.majorBoardVO;
				if(majorBoardVO == null){
					alert("마지막 글입니다.");
					return false;
				}else{
					
				recentList = data.recentList;
							
				
				tags = "<div class='transform_table notice_type'><div class='tbl_view'>";
				tags += "<ul class='tbl_view_m title'>";
				tags += "<li class='txt_left'><div class='ticon_type01'>"+majorBoardVO.mbGubun2Name+"</div>"+majorBoardVO.mbTitle+"</li>";
				tags += "<li>작성자 :"+majorBoardVO.mbRegName+"</li>";
				tags += "<li>"+majorBoardVO.mbRegDate+"</li>";
				tags += "<li>"+majorBoardVO.mbCount+"</li>";
				tags += "</ul>";
				tags += "<div class='tbl_cont'>"+majorBoardVO.mbContent +"</div></div></div>";
				tags += "<div class='btn_box'><a href='#' class='btn_go_list' onclick='fn_list(); return false;'>목록</a></div>";
				if(!(recentList == null || recentList.length == 0)){
					tags += "<div class='sub_page_area'>";
					tags += "<div class='sub_title'>관련글</div></div>";
					tags += "<ul class='view_page_link'>";
					for(i =0; i<recentList.length; i++){
						tags += "<li><a href='#' onclick='fn_select('"+majorBoardVO.mbSeq+"'); return false;'>";
						tags += "<dl><dt>"
						if(recentList[i].mbthType == 'IMAGE'){
							if(recentList[i].mbOldYn == 'Y'){
								tags += "<img onerror='this.src='<c:out value='${pageContext.request.contextPath }/assets/usr/img/all_menu_bg.png'/>'' style='width:209px; height:129px;' src='<c:out value='/showOldImage.do?filePath="+recentlist[i].mbthImgPath+"'/>' alt='"+recentList[i].mbthImgName +"'/>";
							}else{
								tags += "<img onerror='this.src='<c:out value='${pageContext.request.contextPath }/assets/usr/img/all_menu_bg.png'/>'' style='width:209px; height:129px;' src='<c:out value='/showImage.do?filePath="+recentList[i].mbthImgPath+"'/>' alt='"+recentList[i].mbthImgName+"' />";
								
							}
									
						}else if(recentList[i].mbthType == 'VIDEO'){
							if(recentList[i].mbthUrl.indexOf("youtu") != -1){
								if(recentList[i].mbthUrl.indexOf("https:") != -1){
									var mbthUrl = recentList[i].mbthUrl.replace('https://youtu.be/','');
									tags += "<iframe width='209' height='129' src='https://www.youtube.com/embed/"+mbthUrl+"' frameborder='0' allowfullscreen></iframe>"
								}else if(recentList[i].mbthUrl.indexOf("https:") != -1){
									var mbthUrl = recentList[i].mbthUrl.replace('http://youtu.be/','');
									tags += "<iframe width='209' height='129' src='https://www.youtube.com/embed/"+mbthUrl+"' frameborder='0' allowfullscreen></iframe>";
								}							
							}else if(recentList[i].mbthUrl.indexOf("/vimeo") != -1){
								if(recentList[i].mbthUrl.indexOf("https:") != -1){
									var mbthUrl = recentList[i].mbthUrl.replace('https://vimeo.com/','');
									tags += "<iframe src='https://player.vimeo.com/video/"+mbthUrl+"' width='209' height='129' frameborder='0' webkitallowfullscreen mozallowfullscreen allowfullscreen></iframe>"
								}else if(recentList[i].mbthUrl.indexOf("https:") != -1){
									var mbthUrl = recentList[i].mbthUrl.replace('http://vimeo.com/','');
									tags += "<iframe src='https://player.vimeo.com/video/"+mbthUrl+"' width='209' height='129' frameborder='0' webkitallowfullscreen mozallowfullscreen allowfullscreen></iframe>";
									
								}
							}											
						}else{
							tags += "<img style='width:209px; height:129px;' src='<c:out value='/assets/usr/img/all_menu_bg.png'/>' alt='한디원' />";
						}
					tags += "</dt><dd>"+majorBoardVO.mbTitle+"</dd></dl></a></li>";
						
					}
					
					tags += "</ul><br/><br/><br/><br/>";
				}
				
				
				$("#mbSeq").val(majorBoardVO.mbSeq);
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
	/* 
	 */

</script>
<body>
<form:form commandName="searchVO" id="frm" name="frm">
<form:hidden path="pageIndex"/>
<form:hidden path="searchType"/>
<form:hidden path="menuType"/>
<form:hidden path="searchCondition2"/>
<form:hidden path="searchWord"/>
<input type="hidden" id="menuNum" name="menuNo" value="<c:out value="${sessionScope.menuNo}"/>">
<input type="hidden" id="mbSeq" name="mbSeq" value="${resultVO.mbSeq }">
<input type="hidden" id="mCode" name="mCode" value="${resultVO.mCode }">
<input type="hidden" id="mbGubun1" name="mbGubun1" value="${resultVO.mbGubun1}">
<input type="hidden" id="mbGubun2" name="mbGubun2" value="${resultVO.mbGubun2}">
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
		            <jsp:param name="dept2" value="실내디자인"/>
		            <jsp:param name="dept3" value="${resultVO.mbGubun1Name }"/>
	           	</jsp:include>
	           	<div id="viewPage">
					<div class="transform_table notice_type">
						<div class="tbl_view">
							<ul class="tbl_view_m title">
								<li class="txt_left"><div class="ticon_type01"><c:out value="${resultVO.mbGubun2Name }"/></div><c:out value="${resultVO.mbTitle }" escapeXml="false"/></li>
								<li>작성자 : <c:out value="${resultVO.mbRegName }"/></li>
								<li><c:out value="${resultVO.mbRegDate }"/></li>
								<li><c:out value="${resultVO.mbCount }"/></li>
							</ul>
							<div class="tbl_cont">
								<c:out value="${resultVO.mbContent }" escapeXml="false" />
							</div>
								<c:choose>
								<c:when test="${resultVO.mbthFileName != null }">
									<div class="tbl_cont"> 
			
										<ul class="tbl_view_m title">
											<li> 첨부파일 :	<a href="" onclick="fn_filedownload(${resultVO.mbthFileSeq}, 'majorFile'); return false;"><c:out value='${resultVO.mbthFileName}'/></a></li>
										</ul>
									</div>
								</c:when>						
						</c:choose>
						</div>
					</div>
					<div class="btn_box">
						<a href="#" class="btn_go_list" onclick="fn_list(); return false;">전체글보기</a>
					</div>
					<c:if test="${!empty recentList }">
					<div class="sub_page_area">
						<div class="sub_title">이전글</div>
					</div>
					<ul class="view_page_link">
						<c:forEach var="list" items="${recentList }">
						<li>
							<a href="#" onclick="fn_select(<c:out value='${list.mbSeq }'/>); return false;">
								<dl>
									<dt>
										<c:if test="${list.mbthType eq 'IMAGE' }">
											<c:if test="${list.mbOldYn eq 'Y' }">
												<img onerror='this.src="<c:out value='/assets/usr/img/no_img.jpg'/>"'  src="<c:out value='/showOldImage.do?filePath=${list.mbthImgPath}'/>" alt="<c:out value='${list.mbthImgName }'/>" />
											</c:if>
											<c:if test="${list.mbOldYn eq 'N' }">
												<img onerror='this.src="<c:out value='/assets/usr/img/no_img.jpg'/>"'  src="<c:out value='/showImage.do?filePath=${fn:split(list.mbthImgPath,".")[0]}_thumbnail.${fn:split(list.mbthImgPath,".")[1]}'/>" alt="<c:out value='${list.mbthImgName }'/>" />
											</c:if>
										</c:if>
										<c:if test="${list.mbthType eq 'VIDEO' }">
											<c:if test="${fn:containsIgnoreCase(list.mbthUrl,'youtu')}">
												<c:if test="${fn:containsIgnoreCase(list.mbthUrl,'https:')}">
													<iframe src="https://www.youtube.com/embed/<c:out value='${fn:trim(fn:replace(list.mbthUrl,"https://youtu.be/","")) }'/>?rel=0&vq=hd720" frameborder="0" allowfullscreen></iframe>
												</c:if>
												<c:if test="${fn:containsIgnoreCase(list.mbthUrl,'http:')}">
													<iframe src="https://www.youtube.com/embed/<c:out value='${fn:trim(fn:replace(list.mbthUrl,"http://youtu.be/","")) }'/>?rel=0&vq=hd720" frameborder="0" allowfullscreen></iframe>
												</c:if>
											</c:if>
											<c:if test="${fn:containsIgnoreCase(list.mbthUrl,'/vimeo')}">
												<c:if test="${fn:containsIgnoreCase(list.mbthUrl,'https:')}">
													<iframe src="https://player.vimeo.com/video/<c:out value='${fn:trim(fn:replace(list.mbthUrl,"https://vimeo.com/","")) }'/>" frameborder="0" webkitallowfullscreen mozallowfullscreen allowfullscreen></iframe>
												</c:if>
												<c:if test="${fn:containsIgnoreCase(list.mbthUrl,'http:')}">
													<iframe src="https://player.vimeo.com/video/<c:out value='${fn:trim(fn:replace(list.mbthUrl,"http://vimeo.com/","")) }'/>" frameborder="0" webkitallowfullscreen mozallowfullscreen allowfullscreen></iframe>
												</c:if>
											</c:if>
										</c:if>
										<c:if test="${list.mbthType eq '' || list.mbthType eq null}">
											<img  src="<c:out value='/assets/usr/img/all_menu_bg.png'/>" alt="한디원" />
										</c:if>
									</dt>
									<dd><c:out value="${list.mbTitle }" escapeXml="false"/></dd>
								</dl>
							</a>
						</li>
						</c:forEach>
					</ul>
					</c:if>
					<br/><br/>
				</div>
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
<input type="hidden" id="message" value="${message}" />
</form:form>
</body>
</html>