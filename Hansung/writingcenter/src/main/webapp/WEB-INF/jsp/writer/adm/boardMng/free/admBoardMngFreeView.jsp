<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c"      uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="form"   uri="http://www.springframework.org/tags/form" %>
<%@ taglib prefix="ui"     uri="http://egovframework.gov/ctl/ui"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml" lang="ko" xml:lang="ko">
<c:import url="/EgovPageLink.do?link=adm/inc/incHead" />
<script>

	/* 목록으로 */
	function fn_goList(){
		$("#frm").attr("method", "post").attr("action", "<c:url value='/xabdmxgr/boardMng/free/admBoardMngFreeList.do'/>").submit();
	}
	
	/* 삭제 */
	function fn_delete(){
		if(confirm("게시글을 삭제하시겠습니까?")==true){
			$("#frm").attr("method","post").attr("action","<c:url value='/xabdmxgr/boardMng/free/admBoardMngFreeDelete.do'/>").submit();			
		}else{
			return false;
		}
	}
	
	/* 수정화면 */ 	
	function fn_modify(){
		$("#frm").attr("method","post").attr("action","<c:url value='/xabdmxgr/boardMng/free/admBoardMngFreeModifyView.do'/>").submit();
	} 
	
	// 댓글 등록
	function fn_cmmt_insert(){
		if($("#cmtContent").val() == ''){
			alert("댓글 내용을 입력해주세요.");
			return false;
		}
		$("#frm").attr("method", "post").attr("action", "<c:url value='/xabdmxgr/boardMng/free/boardMngFreeCommentInsert.do'/>").submit();
	}
	
	// 댓글 삭제
	function fn_cmmt_delete(cmtSeq){
		if(confirm("댓글을 삭제하시겠습니까?")){
			$("#cmtSeq").val(cmtSeq);
			$("#frm").attr("method", "post").attr("action", "<c:url value='/xabdmxgr/boardMng/free/boardMngFreeCommentDelete.do'/>").submit();
		}
	}
	
	// 댓글 더보기
	function fn_cmmt_add_list(){
		$("#pageCmmtIndex").val(parseInt($("#pageCmmtIndex").val())+1);
		$.ajax({
			url: "<c:url value='/xabdmxgr/boardMng/free/boardMngFreeCommentAddList.do'/>"
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
		location.href = "<c:url value='/cmmn/file/downloadFile.do?type="+type+"&fileId="+upSeq+"'/>";
	}
</script>
<body>
<form id="frm">
<input type="hidden" id="brdSeq" name="brdSeq" value="<c:out value='${boardVO.brdSeq }'/>" />
<input type="hidden" id="searchType" name="searchType" value="FREE" />
<input type="hidden" id="pageIndex" name="pageIndex" value="${searchVO.pageIndex }"/>
<input type="hidden" id="searchCondition" name="searchCondition" value="${searchVO.searchCondition }"/>
<input type="hidden" id="searchWord" name="searchWord" value="${searchVO.searchWord }"/>
<input type="hidden" id="cmtSeq" name="cmtSeq" /> 
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
			<div class="title_area">
				<jsp:include page="/WEB-INF/jsp/writer/adm/inc/incPageTitle.jsp">
					<jsp:param name="dept1" value="게시판관리"/>
		            <jsp:param name="dept2" value="자유게시판"/>
            	</jsp:include>
			</div>
			<div class="cont_box">
			<!-- content -->
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
							<th scope="row" colspan="6"><c:out value="${boardVO.brdTitle }"/></th>
						</tr>
						<tr>
							<th scope="row">글쓴이</th>
							<td><c:out value="${boardVO.regName }"/></td>
							<th scope="row">작성일</th>
							<td><c:out value="${boardVO.regDate }"/></td>
							<th scope="row">조회</th>
							<td><c:out value="${boardVO.brdHitcount }"/></td>
						</tr>
						<tr>
							<th scope="row">첨부파일</th>
							<td colspan="5">
								<c:forEach var="list" items="${listVO }">
									<a href="#" onclick="fn_download('FREE', <c:out value='${list.upSeq }'/>); return false;">
										<c:out value="${list.upOriginFileName }"/>
									</a><br/>
								</c:forEach>
							</td>
						</tr>
						<tr>
							<td colspan="6">
								<c:out value="${boardVO.brdContent }" escapeXml="false"/>
							</td>
						</tr>
					</tbody>
				</table>
				
				<div class="btm_area">
					<div class="btn_box">
						<div class="btn_r">
							<a href="#" class="b_type01" onclick="fn_modify(); return false;">수정</a>
							<a href="#" class="b_type02" onclick="fn_delete(); return false;">삭제</a>
							<a href="#" class="b_type03" onclick="fn_goList(); return false;">목록</a>
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
									<span><c:out value="${cmmt.regName }"/></span>&nbsp;<c:out value="${cmmt.regDate }"/>
									<div class="cmt_fuction">
										<a href="#" class="btn_s_del" onclick="fn_cmmt_delete(<c:out value='${cmmt.cmtSeq }'/>); return false;">삭제</a>
									</div>
									<p><c:out value="${cmmt.cmtContent }" escapeXml="false"/></p>
								</div>
							</c:forEach>
						</div>
					</div>
				</div>

				<div class="btn_box">
					<div class="btn_c">
						<a href="#" class="b_type03" onclick="fn_cmmt_add_list(); return false;">더보기</a>
						<input type="hidden" id="pageCmmtIndex" name="pageCmmtIndex" value="1"/>
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
<input type="hidden" id="message" value="${message}" />
</form>
</body>
</html>