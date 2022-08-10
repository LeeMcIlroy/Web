<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c"      uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="form"   uri="http://www.springframework.org/tags/form" %>
<%@ taglib prefix="ui"     uri="http://egovframework.gov/ctl/ui"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ taglib prefix="common" uri="/WEB-INF/tld/common.tld"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml" lang="ko" xml:lang="ko">
<c:import url="/EgovPageLink.do?link=usr/inc/incHead" />
<script type="text/javaScript">

	//목록
	function fn_list(){
		$("#frm").attr("method", "post").attr("action", "<c:out value='${pageContext.request.contextPath }/usr/lec/lecBoardList.do'/>").submit();
	}

	// 수정
	function fn_modify(){
		$("#frm").attr("method", "post").attr("action", "<c:out value='${pageContext.request.contextPath }/usr/lec/lecBoardModify.do'/>").submit();
	}

	// 삭제
	function fn_delete(){
		if(confirm("정말 삭제하시겠습니까?")){
			$("#frm").attr("method", "post").attr("action", "<c:out value='${pageContext.request.contextPath }/usr/lec/lecBoardDelete.do'/>").submit();
		}
	}
	
	// 댓글 더보기
	function fn_cmmt_add_list(){
		$("#pageCmmtIndex").val(parseInt($("#pageCmmtIndex").val())+1);
		$.ajax({
			url: "<c:out value='${pageContext.request.contextPath }/usr/lec/lecBoardCommentAddList.do'/>"
			, type: "post"
			, data: $("#frm").serialize()
			, dataType:"json"
			, success: function(data){
				cmmtList = data.cmmtList;
				console.log(cmmtList.length);
				
				if(cmmtList.length == 0){
					alert("마지막 댓글입니다."); 
					return false;
				}
				
				$.each(cmmtList, function(i, result){
					var tags = '';
					tags += '<div class="cmt_cont">';
					tags += '<span>'+result.regName+'</span> '+result.regDate;
					tags += '<div class="cmt_fuction">';
					tags += '<a href="#" class="btn_s_del" onclick="fn_cmmt_delete('+result.cmtSeq+'); return false;">삭제</a></div>';
					tags += '<p>'+fn_removeTag(result.cmtContent)+'</p>';
					tags += '</div>';
					
					$(".cmt_box").append(tags);
				});
				
			}, error: function(){
				alert("오류가 발생하였습니다.");
			}
		});
	}
	
	// 댓글 등록
	function fn_cmmt_insert(){
		if($("#cmtContent").val() == ''){
			alert("댓글 내용을 입력해주세요.");
			return false;
		}
		
		$("#frm").attr("method", "post").attr("action", "<c:out value='${pageContext.request.contextPath }/usr/lec/lecBoardCommentInsert.do'/>").submit();
	}
	
	// 댓글 삭제
	function fn_cmmt_delete(cmtSeq){
		$("#cmtSeq").val(cmtSeq);
		$("#frm").attr("method", "post").attr("action", "<c:out value='${pageContext.request.contextPath }/usr/lec/lecBoardCommentDelete.do'/>").submit();
	}
	
	// 파일 다운로드
	function fn_download(type, upSeq){
		location.href = "<c:out value='${pageContext.request.contextPath }/cmmn/file/downloadFile.do'/>?type="+type+"&fileId="+upSeq;
	}
</script>
<body>
<form:form commandName="searchVO" id="frm" name="frm">
<form:hidden path="searchClass" />
<input type="hidden" id="ntSeq" name="ntSeq" value="<c:out value='${clsNoticeVO.ntSeq }'/>"/>
<input type="hidden" id="cmtSeq" name="cmtSeq"/>
<div class="wrap">
	<!-- 스킵 네비게이션 -->
	<div id="skip_navigation">
		<ul>
			<li><a href="#gnb">주 메뉴 바로가기</a></li>
			<li><a href="#content">본문 바로가기</a></li>
		</ul>
	</div>
	<!-- header -->
	<c:import url="/EgovPageLink.do?link=usr/inc/incTopnav" />
	<!--// header -->
	<hr />
	<!-- container -->
	<div class="container">
		<!-- lnb -->
		<c:import url="/EgovPageLink.do?link=usr/inc/incLeftmenu" />
		<!--// lnb -->
		<!-- content -->
		<div class="content" id="content">
			<jsp:include page="/WEB-INF/jsp/writer/usr/inc/incPageTitle.jsp">
            	<jsp:param name="dept1" value="강의실"/>
            	<jsp:param name="dept2" value="${smtrClsInfo.smtrTitle }"/>
            </jsp:include>
			<div class="cont_box">
				<dl class="view_dl mb20">
					<dt><c:out value="${clsNoticeVO.ntTitle}"/></dt>
					<dd class="font12">
						글쓴이 : <c:out value="${clsNoticeVO.regName}"/>&nbsp;&nbsp;&nbsp;&nbsp;|&nbsp;&nbsp;&nbsp;&nbsp;
						작성일 : <c:out value="${clsNoticeVO.regDate}"/>&nbsp;&nbsp;&nbsp;&nbsp;|&nbsp;&nbsp;&nbsp;&nbsp;
						조회 : <c:out value="${clsNoticeVO.ntHitcount}"/>
					</dd>
					<dd class="view_dl_cont"><c:out value="${clsNoticeVO.ntContent }" escapeXml="false"/></dd>
					<dd class="font12">
						첨부파일<font class="ml5 mr5">:</font> 
						<c:forEach items="${notiUpfileList }" var="notiUpfile" varStatus="status">
							<a href="#" onclick="fn_download('CLSNOTICE', <c:out value='${notiUpfile.upSeq }'/>); return false;">
								<c:out value="${notiUpfile.upOriginFileName }"/>
							</a><c:if test="${!status.last }"><font class="ml10 mr10">|</font></c:if>
						</c:forEach>
					</dd>
				</dl>
				<!-- 하단 영역 -->
				<div class="btm_area mb50">
					<div class="btn_box">
						<div class="btn_r">
							<common:eqSession pin="${clsNoticeVO.regId }">
								<a href="#" class="btn_modi" onclick="fn_modify(); return false;">수정</a>
								<a href="#" class="btn_del" onclick="fn_delete(); return false;">삭제</a>
							</common:eqSession>
							<a href="#" class="btn_list" onclick="fn_list(); return false;">목록</a>
						</div>
					</div>
				</div>
				<div class="coment_write">
					<div class="cmt_int">
						<textarea cols="5" rows="5" id="cmtContent" name="cmtContent"></textarea>
						<a href="#" onclick="fn_cmmt_insert(); return false;">등록하기</a>
					</div>
					<div class="cmt_up">
						<div class="cmt_total">ㆍ총 댓글수 : <span><c:out value="${cmmtListCnt }"/></span>건</div>
						<div class="cmt_box">
							<c:forEach items="${cmmtList }" var="cmmt">
								<div class="cmt_cont">
									<span><c:out value="${cmmt.regName }"/></span> <c:out value="${cmmt.regDate }"/>
								 	<common:eqSession pin="${cmmt.regId }">
										<div class="cmt_fuction">
										<%--
											<a href="#" class="btn_s_modi">수정</a>
										 --%>
											<a href="#" class="btn_s_del" onclick="fn_cmmt_delete(<c:out value='${cmmt.cmtSeq }'/>); return false;">삭제</a>
										</div>
								 	</common:eqSession>
									<p><c:out value="${cmmt.cmtContent }"/></p>
								</div>	
							</c:forEach>
						</div>
					</div>
					<div class="btn_box">
						<div class="btn_c">
							<a href="#" class="btn_more" onclick="fn_cmmt_add_list(); return false;">더보기</a>
							<input type="hidden" id="pageCmmtIndex" name="pageCmmtIndex" value="1"/>
						</div>
					</div>
				</div>
				<!-- 하단 영역 -->
			</div>
		</div>
		<!--// content -->
	</div>
	<!--// container -->
	<hr />
	<!-- footer -->
	<c:import url="/EgovPageLink.do?link=usr/inc/incFooter" />
	<!--// footer -->
</div>
<input type="hidden" id="message" name="message" value="${message }" />
<!-- 목록페이지 조건 -->
<input type="hidden" id="pageIndex" name="pageIndex" value="${searchVO.pageIndex }"/>
<input type="hidden" id="searchCondition" name="searchCondition" value="${searchVO.searchCondition }"/>
<input type="hidden" id="searchWord" name="searchWord" value="${searchVO.searchWord }"/>
<!--// 목록페이지 조건 -->
</form:form>
</body>
</html>