<%@page import="writer.valueObject.PopupVO"%>
<%@page import="java.util.List"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c"      uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="form"   uri="http://www.springframework.org/tags/form" %>
<%@ taglib prefix="ui"     uri="http://egovframework.gov/ctl/ui"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ page import="egovframework.com.cmm.util.EgovUserDetailsHelper" %>
<%
	List<PopupVO> popupList = (List<PopupVO>) request.getAttribute("popupList");
	int recordCnt = popupList.size();
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml" lang="ko" xml:lang="ko">
<c:import url="/EgovPageLink.do?link=usr/inc/incHead" />
<script>

	$(function(){
		if(<%= recordCnt %> > 0){
<%
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
%>
		}
		
		memCode = "<c:out value='${sessionScope.userSession.memCode}'/>"

		if(memCode != ''){
			<c:if test="${qstnrPopup eq 'Y'}"> 
				<c:forEach var="qstnrSeq" items="${qstnrSeqs}">
					window.open("<c:out value='${pageContext.request.contextPath }/usr/main/questionaireModify.do?qstnrSeq='/><c:out value='${qstnrSeq}'/>", "", "width=900, height=800, scrollbars=yes");
				</c:forEach>
			</c:if>	
		}
	});

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

	function fn_alert(){
		alert("준비중 입니다.");
		return false;
	}
	
	function fn_select(type, seq){
		if(type=="NOTI"){
			$("#seq").attr("name", "brdSeq").val(seq);
			url = "<c:out value='${pageContext.request.contextPath }/usr/board/notice/boardNoticeView.do'/>";
		}else if(type=="QNA"){
			$("#seq").attr("name", "qnaSeq").val(seq);
			url = "<c:out value='${pageContext.request.contextPath }/usr/board/qna/boardQnaView.do'/>";
		}else if(type=="WRITE"){
			$("#seq").attr("name", "brdSeq").val(seq);
			url = "<c:out value='${pageContext.request.contextPath }/usr/cntst/cntstWriteComView.do'/>";
		}
		
		$("#frm").attr("method","post").attr("action",url).submit();
	}
	
	function fn_list(type){
		if(type=="NOTI"){
			location.href = "<c:out value='${pageContext.request.contextPath }/usr/board/notice/boardNoticeList.do'/>";
		}else if(type=="QNA"){
			location.href = "<c:out value='${pageContext.request.contextPath }/usr/board/qna/boardQnaList.do'/>";
		}
	}

	function fn_youtube(url){
		window.open(url, '_blank'); 
		return false;
	}
</script>
<body>
<form id="frm" name="frm">
<input type="hidden" id="seq" name="seq"/>
<input type="hidden" id="qstnrSeq" name="qstnrSeq"/>
<div class="wrap">
	<!-- 스킵 네비게이션 -->
	<div id="skip_navigation">
		<ul>
			<li><a href="#gnb">주 메뉴 바로가기</a></li>
			<li><a href="#content">본문 바로가기</a></li>
		</ul>
	</div>
	<div class="wrap_main">
		<!-- header -->
		<c:import url="/EgovPageLink.do?link=usr/inc/incTopnav">
			<c:param name="type" value="main"/>
		</c:import>
		<!--// header -->
		<hr />
		<!-- container -->
		<div class="main_container">
			<div class="m_cont_txt">
				<img src="<c:out value='${pageContext.request.contextPath }/assets/usr/img/n_cont_txt.png'/>" alt="사고하고 표현하는 한성인 한성대학교 글쓰기센터 한성대학교" />
			</div>
			<!-- <div class="m_cont_img">
				<a href="<c:out value='${pageContext.request.contextPath }/usr/cntst/cntstWriteComList.do'/>"><img src="<c:out value='${pageContext.request.contextPath }/assets/usr/img/writing_resultcheck_img.jpg'/>" width="100%" alt="제 15회 한성인 글쓰기대회 결과확인" /></a>
			</div> -->
			<div class="m_cont">
			<% if(EgovUserDetailsHelper.isAuthenticatedUser()){ %>
				<div class="m_cont_l">
					<div class="m_log_pop">
						<ul>
							<li><a href="https://www.hansung.ac.kr/hnuLogin/hansung/loginView.do?returnUrl=https://www.hansung.ac.kr/copykiller/login.jsp" target="_blank"><img src="<c:out value='${pageContext.request.contextPath }/assets/usr/img/mc_img06.jpg'/>" alt="표절 검사기" /></a></li>
							<li><a href="<c:out value='${pageContext.request.contextPath }/usr/board/boardCompareNpointView.do'/>"><img src="<c:out value='${pageContext.request.contextPath }/assets/usr/img/mc_img04.jpg'/>" alt="비교과 포인트" /></a></li>
							<li><a href="<c:out value='${pageContext.request.contextPath }/usr/wcGuide/tips/wcGuideTipsList.do'/>"><img src="<c:out value='${pageContext.request.contextPath }/assets/usr/img/mc_img05.jpg'/>" alt="라이팅 팁스" /></a></li>
							<li><a href="<c:out value='${pageContext.request.contextPath }/usr/wcGuide/exclnt/wcGuideExclntList.do'/>"><img src="<c:out value='${pageContext.request.contextPath }/assets/usr/img/mc_img02.jpg'/>" alt="우수과제" /></a></li>
						</ul>
					</div>
				</div>
				<div class="m_cont_c">
					<ul>
						<li><a href="<c:out value='${pageContext.request.contextPath }/usr/cnsltRequestInfoView.do'/>" ><img src="<c:out value='${pageContext.request.contextPath }/assets/usr/img/mc_img01.jpg'/>" alt="상담신청" /></a></li>
						<li><a href="https://www.youtube.com/watch?v=6V2_8woUbRg" target="_blank"><img src="<c:out value='${pageContext.request.contextPath }/assets/usr/img/mc_img07.jpg'/>" alt="상담안내 동영상" /></a></li>
						<li><a href="<c:out value='${pageContext.request.contextPath }/usr/cntst/cntstWriteView.do'/>"><img src="<c:out value='${pageContext.request.contextPath }/assets/usr/img/mc_img03.jpg'/>" alt="대회안내" /></a></li>
					</ul>
				</div>
			<% }else{ %>
				<div class="m_cont_l">
					<div class="m_log_pop">
						<ul>
						<c:if test="${empty sessionScope.userSession }">
							<!-- <a href="<c:out value='${pageContext.request.contextPath }/usr/lec/lecClassList.do'/>"><img src="<c:out value='${pageContext.request.contextPath }/assets/usr/img/ml_img01_txt05.jpg'/>" alt="로그인후 강의실에 입장하세요. 입장하기" /></a> -->
							<!-- <li><a href="<c:out value='${pageContext.request.contextPath }/usr/lec/lecClassList.do'/>"><img src="<c:out value='${pageContext.request.contextPath }/assets/usr/img/ml_img01_ver01.jpg'/>"  height="161px" width="322px" alt="로그인후 강의실에 입장하세요. 입장하기" /></a></li>
 -->						
							<li><a href="#" onclick="fn_sso_login('http://writingcenter.hansung.ac.kr/usr/lgn/login.do'); return false;"><img src="<c:out value='${pageContext.request.contextPath }/assets/usr/img/ml_img01_ver01.jpg'/>"  height="161px" width="322px" alt="로그인후 강의실에 입장하세요. 입장하기" /></a></li>

						</c:if>
							<li><a href="https://hansung.copykiller.com/?l=ko" target="_blank"><img src="<c:out value='${pageContext.request.contextPath }/assets/usr/img/mc_img06.jpg'/>" alt="표절 검사기" /></a></li>
							<li><a href="<c:out value='${pageContext.request.contextPath }/usr/board/boardCompareNpointView.do'/>"><img src="<c:out value='${pageContext.request.contextPath }/assets/usr/img/mc_img04.jpg'/>" alt="비교과 포인트" /></a></li>
						</ul>
					</div>
				</div>
				<div class="m_cont_c">
					<ul>
						<li><a href="<c:out value='${pageContext.request.contextPath }/usr/cnsltRequestInfoView.do'/>" ><img src="<c:out value='${pageContext.request.contextPath }/assets/usr/img/mc_img01.jpg'/>" alt="상담신청" /></a></li>
						<li><a href="<c:out value='${pageContext.request.contextPath }/usr/wcGuide/tips/wcGuideTipsList.do'/>"><img src="<c:out value='${pageContext.request.contextPath }/assets/usr/img/mc_img05.jpg'/>" alt="라이팅 팁스" /></a></li>
						<li><a href="<c:out value='${pageContext.request.contextPath }/usr/cntst/cntstWriteView.do'/>"><img src="<c:out value='${pageContext.request.contextPath }/assets/usr/img/mc_img03.jpg'/>" alt="대회안내" /></a></li>
						<li><a href="<c:out value='${pageContext.request.contextPath }/usr/wcGuide/exclnt/wcGuideExclntList.do'/>"><img src="<c:out value='${pageContext.request.contextPath }/assets/usr/img/mc_img02.jpg'/>" alt="우수과제" /></a></li>
					</ul>
				</div>
			<% } %>



				<div class="m_cont_r">
					<div class="list_box">
						<ul>
							<li class="active"><a href="#">공지사항</a>
								<div class="list_notice">
									<c:forEach var="notice" items="${noticeList }">
										<ul>
											<li>
												<a href="#" onclick="fn_select('<c:out value='${notice.brdType }'/>',<c:out value='${notice.brdSeq }'/>); return false;">
													<c:if test="${notice.brdType eq 'WRITE' }">
														<c:if test="${notice.topicYn eq 'Y' }">
															<label class="topic_tit">[글쓰기대회]</label>
														</c:if>
														<c:if test="${notice.topicYn ne 'Y' }">
															<label class="alt_tit">[글쓰기대회]</label>
														</c:if>
													</c:if>
													<c:if test="${notice.brdType eq 'WRITE' and notice.topicYn eq 'Y' }">
														<label class="topic_tit"><c:out value="${notice.brdTitle }"/></label>
													</c:if>
													<c:if test="${notice.topicYn ne 'Y' }">
														<c:out value="${notice.brdTitle }"/>
													</c:if>
												</a>
											</li>
											<li><c:out value="[${notice.regDate }]"/></li>
										</ul>
									</c:forEach>
									<div class="more_btn"><a href="#" onclick="fn_list('NOTI'); return false;"><img src="<c:out value='${pageContext.request.contextPath }/assets/usr/img/btn_more.jpg'/>" alt="공지사항 더보기" /></a></div>
								</div>
							</li>
							<li><a href="#">Q&amp;A</a>
								<div class="list_notice">
									<c:forEach var="qna" items="${qnaList }">
										<ul>
											<li><a href="#" onclick="fn_select('QNA',<c:out value='${qna.qnaSeq }'/>); return false;"><c:out value="${qna.qstTitle }"/></a></li>
											<li><c:out value="[${qna.qstRegDate }]"/></li>
										</ul>
									</c:forEach>
									<div class="more_btn"><a href="#" onclick="fn_list('QNA'); return false;"><img src="<c:out value='${pageContext.request.contextPath }/assets/usr/img/btn_more.jpg'/>" alt="Q&amp;A 더보기" /></a></div>
								</div>
							</li>
  							<!-- <li onclick="fn_youtube('https://www.youtube.com/watch?v=6V2_8woUbRg'); return false;"> -->
							<!-- <a href="https://www.youtube.com/watch?v=6V2_8woUbRg" target="_blank">상담 안내</a> -->
							<!-- </li> -->
						</ul>
					</div>
				</div>
			</div>
		</div>
		<!--// container -->
	</div>
	<hr />
	<div class="m_foot">
	<!-- footer -->
	<c:import url="/EgovPageLink.do?link=usr/inc/incFooter" />
	<!--// footer -->
	</div>
</div>
<input type="hidden" id="message" name="message" value="${message }"/>
</form>
</body>
</html>