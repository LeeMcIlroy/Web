<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c"      uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="form"   uri="http://www.springframework.org/tags/form" %>
<%@ taglib prefix="ui"     uri="http://egovframework.gov/ctl/ui"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ taglib prefix="common" 	uri="/WEB-INF/tld/common.tld"%>
<!doctype html>
<html lang="kr">
	<c:import url="/EgovPageLink.do?link=inc/incHead" />
	<script type="text/javascript">
		// 목록
		function fn_list(pageIndex){
			$("#pageIndex").val(pageIndex);
			$("#frm").attr("method", "post").attr("action", "<c:out value='${pageContext.request.contextPath}/usr/floodCenter/noticeList.do'/>").submit();
		}
	
		// 등록
		function fn_modify(){
			$("#frm").attr("method", "post").attr("action", "<c:out value='${pageContext.request.contextPath}/usr/floodCenter/noticeModify.do'/>").submit();
		}
		
		// 조회
		function fn_select(noticeId){
			$("#noticeId").val(noticeId);
			$("#frm").attr("method", "post").attr("action", "<c:out value='${pageContext.request.contextPath}/usr/floodCenter/noticeView.do'/>").submit();
		}
		
	</script>
	<body class="sub_page">
	<form:form commandName="searchVO" id="frm" name="frm">
	<input type="hidden" id="noticeId" name="noticeId">
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
						<div class="title">공지사항</div>
						<div class="navi">
							<ul>
								<li>HOME</li>
								<li>수방매뉴얼</li>
								<li>공지사항</li>
							</ul>
						</div>
					</div>
					<fieldset>
						<legend>검색하기</legend>
						<div class="top_sh_box">
							<div class="sh_box">
								<dl>
									<dt></dt>
									<dd>
										<form:select path="searchCondition1" class="select_box">
											<form:option value="1">제목</form:option>
											<form:option value="2">작성자</form:option>
										</form:select>
									</dd>
								</dl>
								<dl>
									<dt></dt>
									<dd>
										<form:input path="searchWord" class="input_p" placeholder="검색어를 입력해 주세요"/>
									</dd>
								</dl>
							</div>
							<div class="btn_sh"><button onclick="fn_list(1); return false;">검색</button></div>
						</div>
					</fieldset>
					<div class="cont_box ptb_50">
						<div class="transform_table notice_type">
							<ul class="tbl_th">
								<li>No.</li>
								<li>제목</li>
								<li>작성자</li>
								<li>작성일</li>
								<li>조회</li>
							</ul>
							<div class="tbl_td">
								<c:forEach items="${noticeList }" var="result" varStatus="status">
									<ul>
										<li class="tbl_ntc"><span>[공지]</span></li>
										<li class="txt_left">
											<a href="#" onclick="fn_select(<c:out value='${result.noticeId }'/>); return false;">
												<c:out value="${result.title }"/>
												<c:if test="${!empty result.attachFileId }">
													&nbsp;&nbsp;<img src="<c:out value='${pageContext.request.contextPath}/assets/img/file_01.png'/>" alt="첨부파일" />
												</c:if>
											</a>
										</li>
										<li><c:out value="${result.regNm }"/></li>
										<li><c:out value="${result.regDttm }"/></li>
										<li><c:out value="${result.hitCnt }"/></li>
									</ul>
								</c:forEach>
								<c:forEach items="${resultList }" var="result" varStatus="status">
									<ul>
										<li class="tbl_ntc"><span><c:out value="${paginationInfo.totalRecordCount+1 - ((searchVO.pageIndex-1) * 10 + status.count)}"/></span></li>
										<li class="txt_left">
											<a href="#" onclick="fn_select(<c:out value='${result.noticeId }'/>); return false;">
												<c:out value="${result.title }"/>
												<c:if test="${!empty result.attachFileId }">
													&nbsp;&nbsp;<img src="<c:out value='${pageContext.request.contextPath}/assets/img/file_01.png'/>" alt="첨부파일" />
												</c:if>
											</a>
										</li>
										<li><c:out value="${result.regNm }"/></li>
										<li><c:out value="${result.regDttm }"/></li>
										<li><c:out value="${result.hitCnt }"/></li>
									</ul>
								</c:forEach>
							</div>
						</div>
						<div class="pager w_btn">
							<!-- 웹페이징 -->
								<ui:pagination paginationInfo="${paginationInfo }" type="image" jsFunction="fn_list"/>
								<form:hidden path="pageIndex"/>
							<!-- // 웹페이징 -->
							<div class="btn_box"><botton class="btn_go_write" onclick="fn_modify(); return false;">글쓰기</button></div>
						</div>
					</div>
				</div>
			</div>
		</div>
		</form:form>
		<!-- footer -->
		<c:import url="${pageContext.request.contextPath }/EgovPageLink.do?link=usr/inc/incFooter"/>
		<!-- footer -->
		<input type="hidden" id="message" name="message" value="${message }">
	</body>
</html>
