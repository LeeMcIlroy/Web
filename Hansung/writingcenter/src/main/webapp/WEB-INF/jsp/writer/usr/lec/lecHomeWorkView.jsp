<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c"      uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="form"   uri="http://www.springframework.org/tags/form" %>
<%@ taglib prefix="ui"     uri="http://egovframework.gov/ctl/ui"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ taglib prefix="common" uri="/WEB-INF/tld/common.tld"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml" lang="ko" xml:lang="ko">
<c:import url="/EgovPageLink.do?link=usr/inc/incHead" />
<script type="text/javascript">
	
	// 수정화면
	function fn_modify(){
		$("#frm").attr("method", "post").attr("action", "<c:out value='${pageContext.request.contextPath }/usr/lec/lecHomeWorkModify.do'/>").submit();
	}
	
	// 삭제
	function fn_delete(){
		if(confirm("한번 삭제한 데이터는 되돌릴 수 없습니다.\n정말로 삭제하시겠습니까?")){
			$("#frm").attr("method", "post").attr("action", "<c:out value='${pageContext.request.contextPath }/usr/lec/lecHomeWorkDelete.do'/>").submit();
		}
	}
	
	// 목록
	function fn_list(){
		$("#frm").attr("method", "post").attr("action", "<c:out value='${pageContext.request.contextPath }/usr/lec/lecHomeWorkList.do'/>").submit();
	}
	
	// 댓글 등록
	function fn_cmmt_insert(){
		if($("#cmtContent").val() == ''){
			alert("댓글 내용을 입력해주세요.");
			return false;
		}
		$("#frm").attr("method", "post").attr("action", "<c:out value='${pageContext.request.contextPath }/usr/lec/lecHmwkCommentInsert.do'/>").submit();
	}
	
	// 댓글 삭제
	function fn_cmmt_delete(cmtSeq){
		if(confirm("댓글을 삭제하시겠습니까?")){
			$("#cmtSeq").val(cmtSeq);
			$("#frm").attr("method", "post").attr("action", "<c:out value='${pageContext.request.contextPath }/usr/lec/lecHmwkCommentDelete.do'/>").submit();
		}
	}
	
	// 댓글 더보기
	function fn_cmmt_add_list(){
		$("#pageCmmtIndex").val(parseInt($("#pageCmmtIndex").val())+1);
		$.ajax({
			url: "<c:out value='${pageContext.request.contextPath }/usr/lec/lecHmwkCommentAddList.do'/>"
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
					tags += '<span>'+result.regName+'</span>&nbsp;'+result.regDate;
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
	
	// 파일 다운로드
	function fn_download(type, upSeq){
		location.href = "<c:out value='${pageContext.request.contextPath }/cmmn/file/downloadFile.do'/>?type="+type+"&fileId="+upSeq;
	}
</script>
<body>
<form:form commandName="homeworkVO" id="frm" name="frm">
<form:hidden path="hmwkSeq" />
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
				<table class="view_type01 mb20" summary="우리게시판 상세보기">
					<caption>우리게시판</caption>
					<colgroup>
						<col width="14%" />
						<col width="20%" />
						<col width="13%" />
						<col width="20%" />
						<col width="13%" />
						<col width="20%" />
					</colgroup>
					<tbody>
						<tr>
							<c:choose>
								<c:when test="${!empty homeworkVO.hmwkNames && !empty homeworkVO.hmwkHakbuns && !empty homeworkVO.hmwkDepts }">
									<th scope="col">이름</th>
									<td><c:out value="${homeworkVO.hmwkNames }"/></td>
									<th scope="col">학과</th>
									<td><c:out value="${homeworkVO.hmwkDepts }"/></td>
									<th scope="col">학번</th>
									<td><c:out value="${homeworkVO.hmwkHakbuns }"/></td>
								</c:when>
								<c:otherwise>
									<th scope="col">이름</th>
									<td><c:out value="${homeworkVO.hmwkRegName }"/></td>
									<th scope="col">학과</th>
									<td><c:out value="${homeworkVO.hmwkRegDept }"/></td>
									<th scope="col">학번</th>
									<td><c:out value="${homeworkVO.hmwkRegId }"/></td>
								</c:otherwise>
							</c:choose>
						</tr>
						<tr>
							<th scope="row">내용</th>
							<td colspan="5"><c:out value="${homeworkVO.hmwkContent }" escapeXml="false"/></td>
						</tr>
						<tr>
							<th scope="col">과제 파일</th>
							<td colspan="3">
								<c:forEach items="${hmwkFileList }" var="hmwkFile">
									<c:if test="${hmwkFile.upType eq 'BEFORE' }">
										<a href="#" onclick="fn_download('HOMEWORK', <c:out value='${hmwkFile.upSeq }'/>); return false;">
											<c:out value="${hmwkFile.upOriginFileName }"/>
										</a><br />
									</c:if>
								</c:forEach>
							</td>
							<th scope="col">제출일</th>
							<td><c:out value="${homeworkVO.hmwkRegDate }"/></td>
						</tr>
						<tr>
							<th scope="row">첨삭 지도 파일</th>
							<td colspan="3">
								<c:forEach items="${hmwkFileList }" var="hmwkFile">
									<c:if test="${hmwkFile.upType eq 'AFTER' }">
										<a href="#" onclick="fn_download('HOMEWORK', <c:out value='${hmwkFile.upSeq }'/>); return false;">
											<c:out value="${hmwkFile.upOriginFileName }"/>
										</a><br />
									</c:if>
								</c:forEach>
							</td>
							<th scope="col">첨삭일</th>
							<td><c:out value="${homeworkVO.hmwkUpdtDate }"/></td>
						</tr>
						<tr>
							<th scope="row">총평</th>
							<td colspan="5"><c:out value="${homeworkVO.hmwkContent2 }" escapeXml="false"/></td>
						</tr>
						<tr>
							<th scope="row">상태</th>
							<td colspan="5">
								<c:if test="${homeworkVO.hmwkStatus eq 1 }">
									<a href="#" class="ta_s_btn03">제출</a>
								</c:if>
								<c:if test="${homeworkVO.hmwkStatus eq 2 }">
									<a href="#" class="ta_s_btn01">첨삭완료</a>
								</c:if>
								<c:if test="${homeworkVO.hmwkStatus eq 3 }">
									<a href="#" class="ta_s_btn01">첨삭완료</a>
									<a href="#" class="ta_s_btn02">첨삭확인완료</a>
								</c:if>
								<c:if test="${homeworkVO.hmwkStatus eq 4 }">
									<a href="#" class="ta_s_btn01">첨삭진행중</a>
								</c:if>
							</td>
						</tr>
					</tbody>
				</table>
				<!-- 하단 영역 -->
				<div class="btm_area mb50">
					<div class="btn_box">
						<div class="btn_r">
							<common:eqSession pin="${homeworkVO.hmwkRegId }">
								<c:if test="${homeworkVO.hmwkStatus eq 1 }">
									<a href="#" class="btn_modi" onclick="fn_modify(); return false;">수정</a>
									<a href="#" class="btn_del" onclick="fn_delete(); return false;">삭제</a>
								</c:if>
							</common:eqSession>
							<a href="#" class="btn_list" onclick="fn_list(); return false;">목록</a>
						</div>
					</div>
				</div>
				<!-- 하단 영역 -->
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
									<span><c:out value="${cmmt.regName }"/></span>&nbsp;<c:out value="${cmmt.regDate }"/>
									<common:eqSession pin="${cmmt.regId }">
										<div class="cmt_fuction">
											<a href="#" class="btn_s_del"onclick="fn_cmmt_delete(<c:out value='${cmmt.cmtSeq }'/>); return false;">삭제</a>
										</div>
									</common:eqSession>
									<p><c:out value="${cmmt.cmtContent }"/></p>
								</div>
							</c:forEach>
						<%--
							<div class="cmt_cont">
								<span>홍길동</span> 2017-03-28
								<div class="cmt_fuction"><a href="#" class="btn_s_modi">수정</a><a href="#" class="btn_s_del">삭제</a></div>
								<p>기대 하고 있습니다.</p>
							</div>
							<div class="cmt_int">
								<textarea cols="5" rows="5"></textarea>
								<a  href="#">등록하기</a>
							</div>
					 	--%>
						</div>
					</div>
				</div>
				<!-- 하단 영역 -->
				<div class="btm_area">
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
<input type="hidden" id="message" name="message" value="${message }"/>
<!-- 목록페이지 조건 -->
<input type="hidden" id="searchClass" name="searchClass" value="${searchVO.searchClass }"/>
<input type="hidden" id="searchSubject" name="searchSubject" value="${searchVO.searchSubject }"/>
<input type="hidden" id="searchType" name="searchType" value="${searchVO.searchType }"/>
<input type="hidden" id="pageIndex" name="pageIndex" value="${searchVO.pageIndex }"/>
<input type="hidden" id="pageIndex2" name="pageIndex2" value="${searchVO.pageIndex2 }"/>
<input type="hidden" id="searchCondition" name="searchCondition" value="${searchVO.searchCondition }"/>
<input type="hidden" id="searchCondition2" name="searchCondition2" value="${searchVO.searchCondition2 }"/>
<input type="hidden" id="searchWord" name="searchWord" value="${searchVO.searchWord }"/>
<input type="hidden" id="searchWord2" name="searchWord2" value="${searchVO.searchWord2 }"/>
<!--// 목록페이지 조건 -->
</form:form>
</body>
</html>