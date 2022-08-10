<!-- 200408 추가 -->
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c"      uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="form"   uri="http://www.springframework.org/tags/form" %>
<%@ taglib prefix="ui"     uri="http://egovframework.gov/ctl/ui"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html xmlns="http://www.w3.org/1999/xhtml" lang="ko" xml:lang="ko">
<c:import url="/EgovPageLink.do?link=adm/inc/incHead" />
<script type="text/javascript">

	// 목록
	function fn_list(){
		$("#frm").attr("method", "post").attr("action", "<c:out value='${pageContext.request.contextPath}/qxerpynm/cmmBoard/admCmmBoardList.do'/>").submit();
	}

	// 수정화면
	function fn_modify(cbSeq){
		$("#cbSeq").val(cbSeq);
		$("#frm").attr("method", "post").attr("action", "<c:out value='${pageContext.request.contextPath}/qxerpynm/cmmBoard/admCmmBoardModify.do'/>").submit();
	}
<c:if test="${paginationInfo.totalRecordCount eq 0 }">	
	// 삭제
	function fn_delete(cbSeq){
		if(confirm("정말 삭제하시겠습니까?\n삭제한 데이터는 복구할 수 없습니다.")){
			$("#cbSeq").val(cbSeq);
			$("#frm").attr("method", "post").attr("action", "<c:out value='${pageContext.request.contextPath}/qxerpynm/cmmBoard/admCmmBoardDelete.do'/>").submit();
		}
	}
</c:if>
	
	// 댓글 더보기
	function fn_cmmt_list(cbSeq){
		$("#cbSeq").val(cbSeq);
		$("#cmmtPageIndex").val(parseInt($("#cmmtPageIndex").val())+1);
		$.ajax({
			url: "<c:out value='${pageContext.request.contextPath}/qxerpynm/cmmBoard/admCmmBoardCmmtAddList.do'/>"
			, type: "post"
			, data: $("#frm").serialize()
			, dataType:"json"
			, success: function(data){
				cmmtResultList = data.cmmtResultList;
				
				if(cmmtResultList.length == 0){
					alert("마지막 댓글입니다.");
					$(".btn_box").css("display", "none");
					return false;
				}
				
				$.each(cmmtResultList, function(i, result){
					var tags = '';
					tags += '<div class="cmt_cont">';
					tags += '	<span>'+result.cbcoRegName+'</span> '+result.cbcoRegDate;
					tags += '	<div class="cmt_fuction">';
					tags += '		<a href="#" onclick="fn_cmmt_delete('+result.cbSeq+', '+result.cbcoSeq+'); return false;" class="btn_s_del">삭제</a>';
					tags += '	</div>';
					tags += '	<p>'+result.cbcoContent+'</p>';
					tags += '</div>';
					
					$(".cmt_box").append(tags);
				});
				
			}, error: function(){
				alert("오류가 발생하였습니다.");
			}
		});
	}
	
	// 댓글 입력
	function fn_cmmt_insert(cbSeq){
		if($.trim($("#cbcoContent").val()) == ''){
			alert("댓글 내용을 입력해주세요.");
			return false;
		}
		$("#cbSeq").val(cbSeq);
		$("#frm").attr("method", "post").attr("action", "<c:out value='${pageContext.request.contextPath}/qxerpynm/cmmBoard/admCmmBoardCmmtInsert.do'/>").submit();		
	}
	
	// 댓글 삭제
	function fn_cmmt_delete(cbSeq, cbcoSeq){
		if(confirm("정말로 삭제하시겠습니까?\n삭제한 데이터는 복구할 수 없습니다.")){
			$("#cbSeq").val(cbSeq);
			$("#cbcoSeq").val(cbcoSeq);
			$("#frm").attr("method", "post").attr("action", "<c:out value='${pageContext.request.contextPath}/qxerpynm/cmmBoard/admCmmBoardCmmtDelete.do'/>").submit();
		}
	}

	// 파일 다운로드
	function fn_filedownload(cbupSeq, type){
		location.href = "<c:out value='${pageContext.request.contextPath}/cmmn/file/downloadFile.do'/>?fileId="+cbupSeq+"&type="+type;
	}

</script>
<body>
<form id="frm" name="frm">
<input type="hidden" id="cbSeq" name="cbSeq"/>
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
			<c:import url="/EgovPageLink.do?link=adm/inc/incLeftmenu"/>
			<!--// lnb -->
			<!-- content -->
			<div class="content" id="content">
				<!-- 타이틀 영역 -->
				<c:import url="/EgovPageLink.do?link=adm/inc/incPageTitle">
					<c:param name="dept1" value="한디원뉴스"/>
					<c:param name="dept2" value="해외프로그램"/>
				</c:import>
				<div class="cont_box">
				<!-- content -->
					<!-- table -->
					<table class="view_tbl_03 mb30 mt30" summary="해외프로그램">
						<caption>해외프로그램</caption>
						<colgroup>
							<col width="13%" />
							<col width="20%" />
							<col width="13%" />
							<col width="20%" />
							<col width="14%" />
							<col width="20%" />
						</colgroup>
						<tbody>
							<tr class="first">
								<th scope="row" colspan="6"><c:out value="${cmmBoardVO.cbTitle }" escapeXml="false"/></th>
							</tr>
							<tr>
								<th scope="row">공지여부</th>
								<td >
									<c:if test="${cmmBoardVO.cbNoticeYn eq 'Y' }">공지</c:if>
									<c:if test="${cmmBoardVO.cbNoticeYn eq 'N' }">일반</c:if>
								</td>
								<th scope="row">공지일</th>
								<td colspan="3">
									<c:if test="${cmmBoardVO.cbNoticeYn eq 'Y' }">
										<c:out value="${cmmBoardVO.cbNoticeDate }"/>
									</c:if>
									<c:if test="${cmmBoardVO.cbNoticeYn eq 'N' }">
										-
									</c:if>
								</td>
							</tr>
							<tr>
								<th scope="row">작성자</th>
								<td><c:out value="${cmmBoardVO.regName }"/></td>
								<th scope="row">작성일</th>
								<td><c:out value="${cmmBoardVO.cbRegDate }"/></td>
								<th scope="row">조회수</th>
								<td><c:out value="${cmmBoardVO.cbCount }"/></td>
							</tr>
							<tr>
								<th scope="row">첨부파일</th>
								<td colspan="5">
									<c:forEach items="${cbUpfileList }" var="cbUpfile">
										<a href="#" onclick="fn_filedownload(<c:out value='${cbUpfile.cbupSeq }'/>, 'CMMBOARD'); return false;">
											<c:out value="${cbUpfile.cbupOriginFilename }"/>
										</a>
										<br />
									</c:forEach>
								</td>
							</tr>
							<tr>
								<td colspan="6"><c:out value="${cmmBoardVO.cbContent }" escapeXml="false"/></td>
							</tr>
							<%-- 
							<tr>
								<td colspan="6">
									<c:if test="${!empty cmmBoardVO.cbThImgPath }">
										<img src="<c:out value='/showImage.do?filePath=${cmmBoardVO.cbThImgPath }'/>" alt="" style="width: 100%;"/>
									</c:if>
									<c:if test="${!empty cmmBoardVO.cbThUrl }">
										<iframe 
											width="750" 
											height="563" 
											src="<c:out value='${
																	fn:trim(
																		fn:replace(
																			fn:replace(
																				fn:replace(
																					fn:replace(
																						cmmBoardVO.cbThUrl, "http://", ""
																					), "https://", ""
																				), "youtu.be/", "https://www.youtube.com/embed/"
																			), "vimeo.com/", "https://player.vimeo.com/video/"
																		)
																	)
																}'/>"
											frameborder="0" webkitallowfullscreen mozallowfullscreen allowfullscreen></iframe>
									</c:if>
								</td>
							</tr>
							 --%>
						</tbody>
					</table>
					<div class="btn_box">
						<div class="btn_r">
							<a href="#" onclick="fn_modify(<c:out value='${cmmBoardVO.cbSeq }'/>); return false;" class="b_type01">수정</a>
							<c:if test="${paginationInfo.totalRecordCount eq 0 }">
								<a href="#" onclick="fn_delete(<c:out value='${cmmBoardVO.cbSeq }'/>); return false;" class="b_type02">삭제</a>
							</c:if>
							<a href="#" onclick="fn_list(); return false;" class="b_type03">목록</a>
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
<!-- 목록 검색 조건 -->
<input type="hidden" id="menuType" name="menuType" value="${searchVO.menuType }"/>
<input type="hidden" id="searchCondition1" name="searchCondition1" value="${searchVO.searchCondition1 }"/>
<input type="hidden" id="searchWord" name="searchWord" value="${searchVO.searchWord }"/>
<input type="hidden" id="pageIndex" name="pageIndex" value="${searchVO.pageIndex }"/>
<!--// 목록 검색 조건 -->
<input type="hidden" id="message" name="message" value="${message }"/>
</form>
</body>
</html>