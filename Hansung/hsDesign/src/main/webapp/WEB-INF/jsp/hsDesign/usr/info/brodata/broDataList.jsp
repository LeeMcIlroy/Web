<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c"      uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="form"   uri="http://www.springframework.org/tags/form" %>
<%@ taglib prefix="ui"     uri="http://egovframework.gov/ctl/ui"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<!doctype html>
<html lang="ko">
<c:import url="/EgovPageLink.do?link=usr/inc/incHead" />
<script type="text/javascript">
	// 목록
	function fn_list(pageNo){
		$("#pageIndex").val(pageNo);
		$("#frm").attr("method", "post").attr("action", "<c:out value='${pageContext.request.contextPath }/usr/info/brodata/broDataList.do'/>").submit();
	}

		// 조회
	function fn_select(cbSeq){
		$("#cbSeq").val(cbSeq);
		
		$("#frm").attr("action", "<c:out value='${pageContext.request.contextPath }/usr/info/brodata/broDataView.do'/>?cbSeq="+cbSeq).submit();
	}
	
	$("iframe").click(function(e){
		e.stopPropagation();
	});

	function fn_major(type){
		$("#searchCondition3").val(type);
		fn_list('1');
	}
</script><body>
<form:form commandName="searchVO" id="frm" name="frm">
	<form:hidden path="searchCondition3"/>
	<!-- skip_navigation -->
	<dl id="skip_nav">
		<dt>바로가기 메뉴</dt>
		<dd><a href="#content">본문 바로가기</a></dd>
		<dd><a href="#top_menu">메뉴 바로가기</a></dd>
		<dd><a href="#footer">페이지 하단 바로가기</a></dd>
	</dl>
	<!-- //skip_navigation -->
	<div class="content">
		<!-- header area -->
		<c:import url="/EgovPageLink.do?link=usr/inc/incTopnav" />
		<!-- //header area -->
		<div class="main_content" id="content">
			<div class="width_box">
				<!-- left menu area-->
				<c:import url="/EgovPageLink.do?link=usr/inc/incLeftmenu"/>
				<!-- //left menu area--> 
				<div class="sub_content">
					<c:import url="/EgovPageLink.do?link=usr/inc/incPageTitle">
						<c:param name="dept1" value="캠퍼스생활"/>
						<c:param name="dept2" value="작품자료실"/>
						<c:param name="dept3" value="작품자료실"/>
					</c:import>
					<div class="top_tab type_li8">
						<ul>
							<li <c:if test="${searchVO.searchCondition3 eq '' }">class="active"</c:if> ><a href="#" onclick="fn_major('');">전체</a></li>
							<li <c:if test="${searchVO.searchCondition3 eq '실내디자인' }">class="active"</c:if> ><a href="#" onclick="fn_major('실내디자인');">실내디자인</a></li>
							<li <c:if test="${searchVO.searchCondition3 eq '시각디자인' }">class="active"</c:if> ><a href="#" onclick="fn_major('시각디자인');">시각디자인</a></li>
							<li <c:if test="${searchVO.searchCondition3 eq '산업디자인' }">class="active"</c:if> ><a href="#" onclick="fn_major('산업디자인');">산업디자인</a></li>
							<li <c:if test="${searchVO.searchCondition3 eq '디지털아트(디자인)' }">class="active"</c:if> ><a href="#" onclick="fn_major('디지털아트(디자인)');">디지털아트(디자인)</a></li>
							<li <c:if test="${searchVO.searchCondition3 eq '디지털아트(게임)' }">class="active"</c:if> ><a href="#" onclick="fn_major('디지털아트(게임)');">디지털아트(게임)</a></li>
							<li <c:if test="${searchVO.searchCondition3 eq '패션디자인' }">class="active"</c:if> ><a href="#" onclick="fn_major('패션디자인');">패션디자인</a></li>
							<li <c:if test="${searchVO.searchCondition3 eq '미용학' }">class="active"</c:if> ><a href="#" onclick="fn_major('미용학');">미용학</a></li>
						</ul>
					</div>
					
	<!-- 		200408 주석		<div class="sub_cont_box">
						<div class="emp_icon_c">
							<ul>
								<c:forEach items="${resultList }" var="result">
									<li>
										<a href="<c:out value='${result.bdUrl }'/>" target="_blank">
											<img src="<c:out value='${pageContext.request.contextPath }/showImage.do?filePath=${result.bdSaveThumbPath }'/>" style="width: 100%;height: 100%;">
										</a>
									</li>
								</c:forEach>
							</ul>
						</div>
					</div>-->


<!-- 					200408추가 -->
		<!-- 검색  -->
					<div class="list_sh">
						<ul>
							<li>
								<form:select path="searchCondition1">
									<form:option value="title">제목</form:option>
									<%-- <form:option value="major">전공</form:option> --%>
								</form:select>
							</li>
							<li>
								<form:input path="searchWord"/>
							</li>
							<li>
								<a href="#" onclick="fn_list(1); return false">
									<img src="<c:out value='${pageContext.request.contextPath }/assets/usr/img/icon_sh.png'/>" alt="찾기" />
								</a>
							</li>
						</ul>
					</div>
 				<!--//검색 -->

					 <div class="img_list_type">
					 	<c:forEach var="list" items="${resultList }">
							<a href="#" onclick="fn_select(<c:out value='${list.cbSeq }'/>); return false;" >
								<ul>
									<li>
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
									</li>
									<li>
										<dl>
											<dt>
												<c:if test="${!empty list.cbGubun }">
													<div class="ticon_type01" style="float: left;">
<%-- 														<c:out value="${list.cbGubun eq '01'?'실내디자인':list.cbGubun eq '02'?'시각디자인':list.cbGubun eq '03'?'산업디자인':list.cbGubun eq '04'?'디지털아트':list.cbGubun eq '05'?'패션디자인':list.cbGubun eq '07'?'미용학':list.cbGubun eq '08'?'미용학(one-day)':'작품자료실'}" /> --%>
														<c:out value="${list.cbGubun }"/>	
													</div> 
												</c:if>
												<div class="title">
													<c:out value="${list.cbTitle }" escapeXml="false"/>
												</div>
												<div class="date">
													<c:out value="${list.cbRegDate }"/> | <c:out value="${list.cbCount }"/>
												</div>
											</dt>
											<dd>
												<c:if test="${fn:length(list.cbContent) > 200 }">
													<c:out value="${fn:substring(list.cbContent,0,200) }" escapeXml="false"/>...
												</c:if>
												<c:if test="${fn:length(list.cbContent) <= 200 }">
													<c:out value="${list.cbContent }" escapeXml="false"/>
												</c:if>
											</dd>
										</dl>
									</li>
								</ul>
							</a>
						</c:forEach>
					</div>

					<div class="pager">
						<ui:pagination paginationInfo="${paginationInfo }" type="image2" jsFunction="fn_list"/>
						<form:hidden path="pageIndex"/>
					</div>
				</div>
			</div>
			<div class="go_top"><a href="javascript:window.scrollTo(0,0)"><strong>▲</strong><br>TOP</a></div>
		</div>
		<!-- footer -->
		<c:import url="/EgovPageLink.do?link=usr/inc/incFooter" />
		<!-- //footer -->
	</div>
	<input type="hidden" id="message" value="${message}" />
</form:form>
</body>
</html>