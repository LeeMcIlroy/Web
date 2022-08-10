<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c"      uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="form"   uri="http://www.springframework.org/tags/form" %>
<%@ taglib prefix="ui"     uri="http://egovframework.gov/ctl/ui"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<!doctype html>
<html lang="kr">
<c:import url="/EgovPageLink.do?link=usr/inc/incHead" />
<script type="text/javascript">
	// 목록
	function fn_list(pageNo){
		$("#pageIndex").val(pageNo);
		$("#frm").attr("method", "post").attr("action", "<c:out value='${pageContext.request.contextPath }/usr/community/notice/noticeList.do'/>").submit();
	}
	
	// 조회
	function fn_select(cbSeq){
		$("#frm").attr("action", "<c:out value='${pageContext.request.contextPath }/usr/community/notice/noticeView.do'/>?cbSeq="+cbSeq).submit();
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
						<c:param name="dept1" value="학사안내"/>
						<c:param name="dept2" value="공지사항"/>
					</c:import>
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
					<div class="transform_table notice_type">
						<ul class="tbl_th">
							<li>번호</li>
							<li>제목</li>
							<li>작성자</li>
							<li>작성일</li>
							<li>조회</li>
						</ul>
						<div class="tbl_td">
							<c:forEach items="${ntResultList }" var="ntResult" varStatus="status">
								<ul>
									<li class="tbl_ntc"><span>공지</span></li>
									<li class="txt_left">
										<a href="#"
											<c:if test="${ntResult.cbSecretYn eq 'Y' }">onclick="fn_pwd(<c:out value='${ntResult.cbSeq }'/>,<c:out value='${ntResult.cbPassword }'/>); return false;"</c:if>	
											<c:if test="${ntResult.cbSecretYn ne 'Y' }">onclick="fn_select(<c:out value='${ntResult.cbSeq }'/>); return false;"</c:if>	>
											<c:out value="${ntResult.cbTitle }" escapeXml="false"/>
											<c:if test="${ntResult.cmmtCount gt 0 }">(<c:out value="${ntResult.cmmtCount }"/>)</c:if>
											<c:if test="${ntResult.cbSecretYn eq 'Y' }">
												<img src="<c:out value='${pageContext.request.contextPath }/assets/usr/img/icon_lock.png'/>" alt="비밀글" />
											</c:if>
										</a>
									</li>
									<li><c:out value="${ntResult.regName }"/></li>
									<li><c:out value="${ntResult.cbRegDate }"/></li>
									<li><c:out value="${ntResult.cbCount }"/></li>
								</ul>
							</c:forEach>
							<c:forEach items="${resultList }" var="result" varStatus="status">
								<ul>
									<li class="tbl_ntc"><c:out value="${paginationInfo.totalRecordCount+1 - ((searchVO.pageIndex-1) * 10 + status.count)}"/></li>
									<li class="txt_left">
										<a href="#"
											<c:if test="${result.cbSecretYn eq 'Y' }">onclick="fn_pwd(<c:out value='${result.cbSeq }'/>,<c:out value='${result.cbPassword }'/>); return false;"</c:if>	
											<c:if test="${result.cbSecretYn ne 'Y' }">onclick="fn_select(<c:out value='${result.cbSeq }'/>); return false;"</c:if>	>
											<c:out value="${result.cbTitle }" escapeXml="false"/>
											<c:if test="${result.cmmtCount gt 0 }">(<c:out value="${result.cmmtCount }"/>)</c:if>
											<c:if test="${result.cbSecretYn eq 'Y' }">
												<img src="<c:out value='${pageContext.request.contextPath }/assets/usr/img/icon_lock.png'/>" alt="비밀글" />
											</c:if>
										</a>
									</li>
									<li><c:out value="${result.regName }"/></li>
									<li><c:out value="${result.cbRegDate }"/></li>
									<li><c:out value="${result.cbCount }"/></li>
								</ul>
							</c:forEach>
							<%--
							<ul>
								<li class="tbl_ntc"><span>공지</span></li>
								<li class="txt_left"><a href="#">[자격증 취득과정] 컬러리스트산업기사 자격과정(1) <img src="../../img/icon_lock.png" alt="비밀글" /></a></li>
								<li>홍길동</li>
								<li>2017.06.21</li>
								<li>20,000</li>
							</ul>
							--%>
						</div>
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