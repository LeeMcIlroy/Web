<!-- 200408추가 -->
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c"      uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="form"   uri="http://www.springframework.org/tags/form" %>
<%@ taglib prefix="ui"     uri="http://egovframework.gov/ctl/ui"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<!doctype html>
<html lang="kr">
<c:import url="/EgovPageLink.do?link=usr/inc/incHead" />
<script type="text/javascript">
	// 목록
	function fn_list(pageNo){
		$("#pageIndex").val(pageNo);
		$("#frm").attr("method", "post").attr("action", "<c:out value='${pageContext.request.contextPath }/usr/community/overseas/overseasList.do'/>").submit();
	}
	
	
	// 조회
	function fn_select(cbSeq){
		$("#cbSeq").val(cbSeq);
		
		$("#frm").attr("action", "<c:out value='${pageContext.request.contextPath }/usr/community/overseas/overseasView.do'/>?cbSeq="+cbSeq).submit();
	}
	
	$("iframe").click(function(e){
		e.stopPropagation();
	});
	
	// 파일 다운로드
	function fn_filedownload(cbupSeq, type){
		location.href = "<c:out value='${pageContext.request.contextPath}/cmmn/file/downloadFile.do'/>?fileId="+cbupSeq+"&type="+type;
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
						<c:param name="dept2" value="해외프로그램"/>
						<c:param name="dept3" value="해외인턴십 안내"/>
					</c:import>
					
					
           	 	<!-- 200420추가 -->
	           	<div class="top_tab type_li2">
					<ul>
						<li><a href="<c:out value='${pageContext.request.contextPath }/usr/community/overseas/overseas.do'/>">해외인턴십 안내</a></li>
						<li class="active"><a href="<c:out value='${pageContext.request.contextPath }/usr/community/overseas/overseasList.do'/>">해외인턴십 보고서</a></li>
					</ul>
				</div>
				
					<%-- 
					<div class="list_sh">
						<ul>
							<li>
								<form:select path="searchCondition1">
									<form:option value="">전체</form:option>
									<form:option value="title">제목</form:option>
									<form:option value="writer">작성자</form:option>
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
					 --%>
					<%-- <div class="transform_table notice_type">
						<ul class="tbl_th">
							<li>번호</li>
							<li>제목</li>
							<li>보고서</li>
							<li>작성자</li>
							<li>작성일</li>
						</ul>
						<div class="tbl_td">
							<c:forEach items="${resultList }" var="list" varStatus="status">
								<ul>
									<li class="tbl_ntc"><c:out value="${paginationInfo.totalRecordCount+1 - ((searchVO.pageIndex-1) * 10 + status.count)}"/></li>
									<li class="txt_left"><a href=""  onclick="fn_select('<c:out value="${list.cbSeq }"/>'); return false;"><c:out value="${list.cbTitle }" escapeXml="false"/></a></li>
									<li>
										<c:set var="chk" value="N"/>
										<c:forEach items="${fileList }" var="cbUpfileList">
											<c:forEach items="${cbUpfileList }" var="cbUpfile">
												<c:if test="${cbUpfile.cbSeq eq list.cbSeq }">
													<a href="#" onclick="fn_filedownload(<c:out value='${cbUpfile.cbupSeq }'/>, 'CMMBOARD'); return false;">다운로드</a>
													<c:set var="chk" value="Y"/>
												</c:if>
											</c:forEach>
										</c:forEach>
										<c:if test="${chk eq 'N' }">
											&nbsp;
										</c:if>
									</li>
									<c:if test="${!empty list.regName }">
										<li>
											<c:out value="${list.regName }"/>
										</li>
									</c:if>
									<c:if test="${empty list.regName }">
										<li>&nbsp; </li>
									</c:if>
									<li><c:out value="${list.cbRegDate }"/></li>
								</ul>
							</c:forEach>
							
							<ul>
								<li class="tbl_ntc"><span>공지</span></li>
								<li class="txt_left"><a href="#">[자격증 취득과정] 컬러리스트산업기사 자격과정(1) <img src="../../img/icon_lock.png" alt="비밀글" /></a></li>
								<li>홍길동</li>
								<li>2017.06.21</li>
								<li>20,000</li>
							</ul>
							
						</div>
					</div> --%>
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
												<div class="title">
													<c:out value="${list.cbTitle }" escapeXml="false"/>
												</div>
												<div class="date"><c:out value="${list.cbRegDate }"/> | <c:out value="${list.cbCount }"/></div>
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
					<!-- rolling banner -->
					
					<!-- //rolling banner -->
				</div>
			</div>
		</div>
		<!-- footer -->
		<c:import url="/EgovPageLink.do?link=usr/inc/incFooter" />
		<!-- //footer -->
	</div>
	<input type="hidden" id="message" value="${message}" />
</form:form>
</body>
</html>