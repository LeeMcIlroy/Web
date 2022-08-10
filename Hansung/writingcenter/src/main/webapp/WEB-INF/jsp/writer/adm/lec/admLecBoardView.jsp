<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ taglib prefix="c"      uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="form"   uri="http://www.springframework.org/tags/form" %>
<%@ taglib prefix="ui"     uri="http://egovframework.gov/ctl/ui"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml" lang="ko" xml:lang="ko">
<c:import url="/EgovPageLink.do?link=adm/inc/incHead" />
<script type="text/javaScript">

	//목록
	function fn_list(){
		$("#frm").attr("method", "post").attr("action", "<c:url value='/xabdmxgr/lec/admLecBoardList.do'/>").submit();
	}

	// 수정
	function fn_modify(){
		$("#frm").attr("method", "post").attr("action", "<c:url value='/xabdmxgr/lec/admLecBoardModify.do'/>").submit();
	}

	// 삭제
	function fn_delete(){
		$("#frm").attr("method", "post").attr("action", "<c:url value='/xabdmxgr/lec/admLecBoardDelete.do'/>").submit();
	}
	
	// 댓글 더보기
	function fn_cmmt_add_list(){
		$("#pageCmmtIndex").val(parseInt($("#pageCmmtIndex").val())+1);
		$.ajax({
			url: "<c:url value='/xabdmxgr/lec/admLecBoardCommentAddList.do'/>"
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
		
		$("#frm").attr("method", "post").attr("action", "<c:url value='/xabdmxgr/lec/admLecBoardCommentInsert.do'/>").submit();
	}
	
	// 댓글 삭제
	function fn_cmmt_delete(cmtSeq){
		$("#cmtSeq").val(cmtSeq);
		$("#frm").attr("method", "post").attr("action", "<c:url value='/xabdmxgr/lec/admLecBoardCommentDelete.do'/>").submit();
	}
	
	// 파일 다운로드
	function fn_download(type, upSeq){
		location.href = "<c:url value='/cmmn/file/downloadFile.do?type="+type+"&fileId="+upSeq+"'/>";
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
	<c:import url="/EgovPageLink.do?link=adm/inc/incTopnav" />
	<!--// header -->
	<hr />
	<p class="container_top_bg"></p>
	<!-- container -->
	<div class="container">
		<!-- lnb -->
		<c:import url="/EgovPageLink.do?link=adm/inc/incLeftmenu" />
		<!--// lnb -->
		<!-- content -->
		<div class="content" id="content">
			<!-- 타이틀 영역 -->
			<jsp:include page="/WEB-INF/jsp/writer/adm/inc/incPageTitle.jsp">
            	<jsp:param name="dept1" value="강의실"/>
            	<jsp:param name="dept2" value="${smtrClsInfo.smtrTitle }"/>
            </jsp:include>
			<div class="cont_box">
			<!-- content -->
				<!-- table -->
				<table class="view_tbl_03 mb30 mt30" summary="C/L 분류 관리">
					<caption>C/L 분류</caption>
					<colgroup>
						<col width="14%" />
						<col width="20%" />
						<col width="13%" />
						<col width="20%" />
						<col width="13%" />
						<col width="20%" />
					</colgroup>
					<tbody>
						<tr class="first">
							<th scope="row" colspan="6"><c:out value="${clsNoticeVO.ntTitle}"/></th>
						</tr>
						<tr>
							<th scope="row">글쓴이</th>
							<td><c:out value="${clsNoticeVO.regName}"/></td>
							<th scope="row">작성일</th>
							<td><c:out value="${clsNoticeVO.regDate}"/></td>
							<th scope="row">조회</th>
							<td><c:out value="${clsNoticeVO.ntHitcount}"/></td>
						</tr>
						<tr>
							<th scope="row">첨부파일</th>
							<td colspan="5">
								<c:forEach items="${notiUpfileList }" var="notiUpfile">
									<a href="#" onclick="fn_download('CLSNOTICE', <c:out value='${notiUpfile.upSeq }'/>); return false;">
										<c:out value="${notiUpfile.upOriginFileName }"/>
									</a><br />
								</c:forEach>
							</td>
						</tr>
						<tr>
							<td colspan="6"><c:out value="${clsNoticeVO.ntContent }" escapeXml="false"/></td>
						</tr>
					</tbody>
				</table>
				<div class="btn_box">
					<div class="btn_r">
						<c:if test="${clsNoticeVO.regId eq sessionScope.adminSession.memCode }">
							<a href="#" class="b_type01" onclick="fn_modify(); return false;">수정</a>
							<a href="#" class="b_type02" onclick="fn_delete(); return false;">삭제</a>
						</c:if>
						<a href="#" class="b_type03" onclick="fn_list(); return false;">목록</a>
					</div>
				</div>
				<div class="coment_write">
					<div class="cmt_up">
						<div class="cmt_total">ㆍ총 댓글수 : <span><c:out value="${cmmtListCnt }"/></span>건</div>
						<div class="cmt_box">
							<c:forEach items="${cmmtList }" var="cmmt">
								<div class="cmt_cont">
									<span><c:out value="${cmmt.regName }"/></span> <c:out value="${cmmt.regDate }"/>
									<div class="cmt_fuction">
									<%--
										<a href="#" class="btn_s_modi">수정</a>
									 --%>
										<a href="#" class="btn_s_del" onclick="fn_cmmt_delete(<c:out value='${cmmt.cmtSeq }'/>); return false;">삭제</a>
									</div>
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
					<div class="btn_box">
						<div class="btn_c">
							<a href="#" class="b_type03" onclick="fn_cmmt_add_list(); return false;">더보기</a>
							<input type="hidden" id="pageCmmtIndex" name="pageCmmtIndex" value="1"/>
						</div>
					</div>
					<div class="cmt_int">
						<textarea cols="5" rows="5" id="cmtContent" name="cmtContent"></textarea>
						<a href="#" onclick="fn_cmmt_insert(); return false;">등록하기</a>
					</div>
				</div>
			<!-- //content -->
			</div>
		</div>
		<!--// content -->
	</div>
	<!--// container -->
	<hr />
	<!-- footer -->
	<c:import url="/EgovPageLink.do?link=adm/inc/incFooter" />
	<!--// footer -->
</div>

<input type="hidden" id="message" value="${searchVO.message}" />
<!-- 목록페이지 조건 -->
<input type="hidden" id="pageIndex" name="pageIndex" value="${searchVO.pageIndex }"/>
<input type="hidden" id="searchType" name="searchType" value="${searchVO.searchType }"/>
<input type="hidden" id="searchCondition" name="searchCondition" value="${searchVO.searchCondition }"/>
<input type="hidden" id="searchWord" name="searchWord" value="${searchVO.searchWord }"/>
<!-- //목록페이지 조건 -->
</form:form>
</body>
</html>