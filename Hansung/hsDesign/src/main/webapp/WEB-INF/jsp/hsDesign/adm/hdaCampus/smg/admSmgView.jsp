<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c"      uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="form"   uri="http://www.springframework.org/tags/form" %>
<%@ taglib prefix="ui"     uri="http://egovframework.gov/ctl/ui"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
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
<input type="hidden" id="cbcoSeq" name="cbcoSeq"/>
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
					<c:param name="dept1" value="캠퍼스생활"/>
					<c:param name="dept2" value="한디원신문고"/>
				</c:import>
				<div class="cont_box">
				<!-- content -->
					<!-- table -->
					<table class="view_tbl_03 mb30 mt30" summary="학사Q&A">
						<caption>학사Q&amp;A</caption>
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
								<th scope="row">작성자</th>
								<td><c:out value="${cmmBoardVO.regName }"/></td>
								<th scope="row">작성일</th>
								<td><c:out value="${cmmBoardVO.cbRegDate }"/></td>
								<th scope="row">조회수</th>
								<td><c:out value="${cmmBoardVO.cbCount }"/></td>
							</tr>
							<tr>
								<th scope="row">공지여부</th>
								<td colspan="5">
									<c:if test="${cmmBoardVO.cbNoticeYn eq 'Y' }">공지</c:if>
									<c:if test="${cmmBoardVO.cbNoticeYn eq 'N' }">일반</c:if>
								</td>
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
					<div class="coment_write">
						<div class="cmt_int">
							<textarea id="cbcoContent" name="cbcoContent" cols="5" rows="5"></textarea>
							<a href="#" onclick="fn_cmmt_insert(<c:out value='${cmmBoardVO.cbSeq }'/>); return false;">입력</a>
						</div>
						<div class="cmt_up">
							<div class="cmt_total">ㆍ총 댓글수 : <span><c:out value="${paginationInfo.totalRecordCount }"/></span>건</div>
							<div class="cmt_box">
								<c:forEach items="${cmmtResultList }" var="cmmtResult">
									<div class="cmt_cont">
										<span><c:out value="${cmmtResult.cbcoRegName }"/></span> <c:out value="${cmmtResult.cbcoRegDate }"/>
										<div class="cmt_fuction">
											<a href="#" onclick="fn_cmmt_delete(<c:out value='${cmmBoardVO.cbSeq }'/>, <c:out value='${cmmtResult.cbcoSeq }'/>); return false;" class="btn_s_del">삭제</a>
										</div>
										<p><c:out value="${cmmtResult.cbcoContent }" escapeXml="false"/></p>
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
									<a  href="#">입력</a>
								</div>
						 	--%>
							</div>
						</div>
						<div class="btn_box" <c:if test="${paginationInfo.totalRecordCount lt 6 }">style="display:none;"</c:if>>
							<div class="btn_c">
								<a href="#" onclick="fn_cmmt_list(<c:out value='${cmmBoardVO.cbSeq }'/>); return false;" class="b_type03">더보기</a>
								<input type="hidden" id="cmmtPageIndex" name="cmmtPageIndex" value="${cmmtSearchVO.pageIndex }"/>
							</div>
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