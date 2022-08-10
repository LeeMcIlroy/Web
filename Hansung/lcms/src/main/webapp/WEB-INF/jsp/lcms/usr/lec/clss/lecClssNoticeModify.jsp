<%@page import="egovframework.rte.psl.dataaccess.util.EgovMap"%>
<%@page import="lcms.valueObject.UsrVO"%>
<%@page import="java.text.SimpleDateFormat"%>
<%@page import="java.util.*, java.text.*"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c"      uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="form"   uri="http://www.springframework.org/tags/form" %>
<%@ taglib prefix="ui"     uri="http://egovframework.gov/ctl/ui"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ taglib prefix="common" 	uri="/WEB-INF/tld/common.tld"%>
<%
	String stdMenuNo = ((String)session.getAttribute("stdMenuNo")!=null)?(String)session.getAttribute("stdMenuNo"):"";
	UsrVO usrVO = ((UsrVO)session.getAttribute("usrSession")!=null)?(UsrVO)session.getAttribute("usrSession"):null;
	String selLectName = (String)session.getAttribute("selLectName")!=null?(String)session.getAttribute("selLectName"):"";
	String selLectCode = (String)session.getAttribute("selLectCode")!=null?(String)session.getAttribute("selLectCode"):"";
	EgovMap lecSession = (EgovMap)session.getAttribute("lecSession");
%>
<!DOCTYPE html>
<html lang="ko">
<c:import url="/EgovPageLink.do?link=usr/inc/incHead"/>

<script>
		function closeLayer( obj ) {
			$(obj).parent().parent().hide();
		}


		$(function(){
			
			$("input[type='file']").change(function(){
				var eleId = this.id;
				var cnt = eleId.split('_')[2];
				if(fileCheck_adm(eleId)){
					var fileValue = $(this).val().split("\\");
					var fileName = fileValue[fileValue.length-1];
					var extension = fileName.split(".")[1].toUpperCase();
				
			 		/* if(extension != 'JPG'){
						alert('JPG만이 첨부 가능합니다');
						$('#upload_file').val('');
						return;
					} */
			 		
					$("#fileName_"+cnt).val(fileName);
				}else{
					$(this).val('');
					$("#fileName_"+cnt).val('파일선택');
				}
			});

			/* 클릭 클릭시 클릭을 클릭한 위치 근처에 레이어가 나타난다. */
			$('.imgSelect').click(function(e)
			{
				var sWidth = window.innerWidth;
				var sHeight = window.innerHeight;

				var oWidth = $('.popupLayer').width();
				var oHeight = $('.popupLayer').height();

				// 레이어가 나타날 위치를 셋팅한다.
				var divLeft = e.clientX + 10;
				var divTop = e.clientY + 5;

				// 레이어가 화면 크기를 벗어나면 위치를 바꾸어 배치한다.
				if( divLeft + oWidth > sWidth ) divLeft -= oWidth;
				if( divTop + oHeight > sHeight ) divTop -= oHeight;

				// 레이어 위치를 바꾸었더니 상단기준점(0,0) 밖으로 벗어난다면 상단기준점(0,0)에 배치하자.
				if( divLeft < 0 ) divLeft = 0;
				if( divTop < 0 ) divTop = 0;

				$('.popupLayer').css({
					"top": divTop,
					"left": divLeft,
					"position": "absolute"
				}).show();
			});

		});
			
// 		$(function(){
// 			$("#upload_file").change(function(){
// 				var fileValue = $('#upload_file').val().split("\\");
// 				var fileName = fileValue[fileValue.length-1];
// 				var extension = fileName.split(".")[1].toUpperCase();
			
// 		 		/* if(extension != 'JPG'){
// 					alert('JPG만이 첨부 가능합니다');
// 					$('#upload_file').val('');
// 					return;
// 				} */
		 		
// 				$("#fileName").val(fileName);
// 				$("#deleteYn").val('Y');
// 			});
// 		});
		function save(){
			
			var lcnotiSeq = $('#lcnotiSeq').val();
			var lcnotiTitle = $('#lcnotiTitle').val();
			var lcnotiContent = CKEDITOR.instances['lcnotiContent']; 
			var lcnotiTop = $("#notice-top").is(":checked");
			
			if( lcnotiTop == true ){
				$("#lcnotiTop").val("Y");
			}else{
				$("#lcnotiTop").val("N");
			}
			
			if(lcnotiTitle==''){
				alert('제목을 입력해주세요.');
				$('#lcnotiTitle').focus();
				return;
			}
			
			if(lcnotiContent.getData()==''){
				alert('내용을 입력해주세요.')
				$('#lcnotiContent').focus();
				return;
			}
			
			$("#detailForm").attr("action", "<c:out value='${pageContext.request.contextPath}/usr/lec/clss/lecClssAddNotice.do'/>").submit();
			
		}
		
		function fn_add(web){
			var cnt = $("."+web+" .file-upload").length;
			
			var html = '';
			
			html += '<p class="file-upload" id="'+web+'_'+cnt+'">';
			html += '	<input type="text" value="파일선택" class="input-data" disabled="disabled" id="fileName_'+cnt+'">';
			html += '	<label for="upload_file_'+cnt+'" class="btn-upload-file">파일업로드</label>';
			html += '	<input type="file" class="hidden" id="upload_file_'+cnt+'" name="upload_file_'+cnt+'"/>';
			html += '	<button class="white" onclick="fn_remove(\''+web+'\','+cnt+'); return false;">x</button>';
			html += '</p>';
			
			$("#file_"+web).append(html);
			
	        $("#upload_file_"+(cnt)).change(function(){ 
	        	if(fileCheck_adm('upload_file_'+(cnt))){
	    			var fileValue = $('#upload_file_'+(cnt)).val().split("\\");
	    			var fileName = fileValue[fileValue.length-1];
	    			var extension = fileName.split(".")[1].toUpperCase();
	    		
	     		/* if(extension != 'JPG'){
	    			alert('JPG만이 첨부 가능합니다');
	    			$('#upload_file').val('');
	    			return;
	    		} */
	    		$("#fileName_"+(cnt)).val(fileName);
	    		}
	         
	        });
		}
		
		function fn_del(seq){
			
			var html = '<input type="hidden" name="delSeqList" value="'+seq+'"/>';
			
			$("#delAtt").append(html);
			$("#fileDiv"+seq).remove();
		}
		
		function fn_remove(web, cnt){
			$("#"+web+"_"+cnt).remove();
		}
	</script>
<body>
<form:form commandName="lecClssNoticeVO" id="detailForm" name="detailForm" method="post" enctype="multipart/form-data">
<%-- 	<input type="hidden" name="lcnotiSeq" id="lcnotiSeq" value="${lecClssNoticeVO.lcnotiSeq } "/> --%>
	<form:hidden path="lcnotiSeq"/>
<%-- 	<input type="hidden" name="lectCode" id="lectCode" value="${lecClssNoticeVO.lectCode }"/> --%>
	<form:hidden path="lectCode" value="<%=selLectCode %>"/>
	<c:import url="/EgovPageLink.do?link=usr/inc/incTopnavLec"/>
	<!-- contents -->
	<div class="content-box">
		<div class="contents">
			<!-- left menu -->
			<c:import url="/EgovPageLink.do?link=usr/inc/incLeftmenuLec"/>
			<!--// left menu -->
			<div class="main-content">
				<div class="title-area">
					<p class="page-lv01">강의공지</p>
					<div class="navi web"> <!-- 모바일 수정 -->
						<span class="icon-home">Home</span>
						<span>강의실</span>
						<span>수업</span>
						<span>강의공지</span>
					</div>
				</div>

				<p class="sub-title">공지내용</p>
				<!-- table -->
				<div class="list-table-box web">
					<table class="normal-wmv-table">
						<colgroup>
							<col style="width:10%;" />
							<col style="width:23%;" />
							<col style="width:10%;" />
							<col style="width:23%;" />
							<col style="width:10%;" />
							<col />
						</colgroup>
						<tbody>
							<tr>
								<th><sup>*</sup>공지구분</th>
								<td>
									<select id="lcnotiGubun" name="lcnotiGubun">
										<option value="전체" <c:if test="${lecClssNoticeVO.lcnotiGubun eq '전체'}"></c:if> >전체</option>
										<%-- <option value="수업" <c:if test="${lecClssNoticeVO.lcnotiGubun eq '수업'}"></c:if> >수업</option>
										<option value="성적" <c:if test="${lecClssNoticeVO.lcnotiGubun eq '성적'}"></c:if> >성적</option>
										<option value="출석" <c:if test="${lecClssNoticeVO.lcnotiGubun eq '출석'}"></c:if> >출석</option>
										<option value="기타" <c:if test="${lecClssNoticeVO.lcnotiGubun eq '기타'}"></c:if> >기타</option> --%>
									</select>
								</td>
								<th>작성일자</th>
								<%
								
								Date date = new Date();
								SimpleDateFormat simpleDate = new SimpleDateFormat("yyy-MM-dd");
								String strdate = simpleDate.format(date);
								
								%>
								<td>
									 <c:if test="${empty  lecClssNoticeVO.lcnotiDate}">
										<input type="hidden" name="lcnotiDate" id="lcnotiDate" value="<%=strdate %>"/>
										<c:out value="<%=strdate %>" />
									 </c:if>
									 <c:if test="${!empty  lecClssNoticeVO.lcnotiDate}">
										 <c:out value="${lecClssNoticeVO.lcnotiDate}"></c:out>
									 </c:if>
								</td>
								<th>작성자</th>
								<td>
									 <c:if test="${empty  lecClssNoticeVO.lcnotiWriter}">
										<input type="hidden" name="lcnotiWriter" id="lcnotiWriter" value=" <%= usrVO.getName() %>"/>
										<c:out value="<%= usrVO.getName() %>" />
									 </c:if>
									 <c:if test="${!empty  lecClssNoticeVO.lcnotiWriter}">
										 <c:out value="${lecClssNoticeVO.lcnotiWriter}"></c:out>
									 </c:if>
								</td>
							</tr>
							<tr>
								<th><sup>*</sup>제목</th>
								<td colspan="5">
									<input type="text" class="input-data" name="lcnotiTitle" id="lcnotiTitle" value="${ lecClssNoticeVO.lcnotiTitle }" />&nbsp;&nbsp;&nbsp;
									<label for="notice-top">상단고정</label>
									<input type="checkbox" id="notice-top" <c:if test="${ lecClssNoticeVO.lcnotiTop eq 'Y' }">checked="checked"</c:if> />
									<input type="hidden" name="lcnotiTop" id="lcnotiTop" value="N"/>
								</td>
							</tr>
							<tr>
								<th><sup>*</sup>내용</th>
								<td colspan="5" class="bln editor" height="200">
									<textarea id="lcnotiContent" name="lcnotiContent"><c:out value="${lecClssNoticeVO.lcnotiContent }"/></textarea>
									<script type="text/javascript">
										CKEDITOR.replace( 'lcnotiContent', {
											height: 300,
											filebrowserImageUploadUrl: "<c:url value='/cmmn/ckeditor/uploadCkeditorFile.do'/>"
										});
									</script>
								</td>
							</tr>
						</tbody>
					</table>
				</div>
				<!--// table -->
				<div class="mob mb20">
					<div class="mob-write">
						<dl>
							<dt><sup>*</sup>공지구분</dt>
							<dd>
								<ul>
									<li>
										<select id="lcnotiGubun" name="lcnotiGubun">
											<option value="전체" <c:if test="${lecClssNoticeVO.lcnotiGubun eq '전체'}"></c:if> >전체</option>
										</select>
									</li>
								</ul>
							</dd>
						</dl>
						<dl>
							<dt>작성일자</dt>
							<dd>
								<c:if test="${empty  lecClssNoticeVO.lcnotiDate}">
									<input type="hidden" name="lcnotiDate" id="lcnotiDate" value="<%=strdate %>"/>
									<c:out value="<%=strdate %>" />
								 </c:if>
								 <c:if test="${!empty  lecClssNoticeVO.lcnotiDate}">
									 <c:out value="${lecClssNoticeVO.lcnotiDate}"></c:out>
								 </c:if>
							</dd>
						</dl>
						<dl>
							<dt>작성자</dt>
							<dd>
								 <c:if test="${empty  lecClssNoticeVO.lcnotiWriter}">
									<input type="hidden" name="lcnotiWriter" id="lcnotiWriter" value=" <%= usrVO.getName() %>"/>
									<c:out value="<%= usrVO.getName() %>" />
								 </c:if>
								 <c:if test="${!empty  lecClssNoticeVO.lcnotiWriter}">
									 <c:out value="${lecClssNoticeVO.lcnotiWriter}"></c:out>
								 </c:if>
							</dd>
						</dl>
						<dl>
							<dt><sup>*</sup>제목</dt>
							<dd>
								<input type="text" class="input-data" name="lcnotiTitle" id="lcnotiTitle" value="${ lecClssNoticeVO.lcnotiTitle }" />&nbsp;&nbsp;&nbsp;
									<label for="notice-top">상단고정</label>
									<input type="checkbox" id="notice-top" <c:if test="${ lecClssNoticeVO.lcnotiTop eq 'Y' }">checked="checked"</c:if> />
									<input type="hidden" name="lcnotiTop" id="lcnotiTop" value="N"/>
							</dd>
						</dl>
						<dl>
							<!-- <dt><sup>*</sup>내용</dt>
							<dd> -->
								<textarea id="lcnotiContent2" name="lcnotiContent"><c:out value="${lecClssNoticeVO.lcnotiContent }"/></textarea>
								<script type="text/javascript">
									CKEDITOR.replace( 'lcnotiContent2', {
										height: 300,
										filebrowserImageUploadUrl: "<c:url value='/cmmn/ckeditor/uploadCkeditorFile.do'/>"
									});
								</script>
							<!-- </dd> -->
						</dl>
					</div>
				</div>

				<p class="sub-title">첨부파일</p>
					<!-- table -->
					<div class="list-table-box web">
						<table class="normal-wmv-table">
							<colgroup>
								<col style="width:10%;" />
								<col />
							</colgroup>
							<tbody>
								<tr>
									<th>첨부파일</th>
									<td id="file_web">
										<c:forEach items="${attachList }" var="attach" varStatus="status">
											<p class="file-upload" id="fileDiv<c:out value='${attach.attachSeq }'/>">
												<a href="<c:url value='/cmmn/file/downloadFile.do?fileId=${attach.attachSeq }&type=${attach.boardType }'/>"><c:out value="${attach.orgFileName }"/></a>
												<button class="white" onclick="fn_del('<c:out value="${attach.attachSeq }"/>'); return false;">x</button>
												<input type="hidden" id="deleteFile" name="deleteFile" value='<c:out value="${attach.attachSeq }"></c:out>'/>
											</p>
										</c:forEach>
										<p class="file-upload">
											<input type="text" value="파일선택" class="input-data" disabled="disabled" id="fileName_0">
											<label for="upload_file_0" class="btn-upload-file">파일업로드</label>
											<input type="file" class="hidden" id="upload_file_0" name="upload_file_0"/>
											<button class="white" onclick="fn_add('web'); return false;">+</button>
										</p>
									</td>
								</tr>
							</tbody>
						</table>
					</div>
				<!--// table -->
				<div class="mob mb20">
						<div class="mob-write">
							<dl>
								<dt>첨부파일</dt>
								<dd>
									<ul>
										<li id="file_mob">
											<c:forEach items="${attachList }" var="attach" varStatus="status">
												<p class="file-upload" id="fileDiv<c:out value='${attach.attachSeq }'/>">
													<a href="<c:url value='/cmmn/file/downloadFile.do?fileId=${attach.attachSeq }&type=${attach.boardType }'/>"><c:out value="${attach.orgFileName }"/></a>
													<button class="white" onclick="fn_del('<c:out value="${attach.attachSeq }"/>'); return false;">x</button>
												</p>
											</c:forEach>
											<p class="file-upload">
												<input type="text" value="파일선택" class="input-data" disabled="disabled" id="fileName_0">
												<label for="upload_file_0" class="btn-upload-file">파일업로드</label>
												<input type="file" class="hidden" id="upload_file_0" name="upload_file_0"/>
												<button class="white" onclick="fn_add('mob'); return false;">+</button>
											</p>
										</li>
									</ul>
								</dd>
							</dl>
						</div>
					</div>

				<div class="table-button">
					<div class="btn-box">
						<a href="<c:out value='${pageContext.request.contextPath }/usr/lec/clss/lecClssNoticeList.do'/>" class="white btn-list">목록</a>
						<button type="button" class="white btn-save" onclick="save(); return false;">저장</button>
					</div>
				</div>
			</div>
		</div>
		<div id="delAtt"></div>
	</div>
	<!--// contents -->
	<!-- footer -->
	<c:import url="/EgovPageLink.do?link=usr/inc/incFooter"/>
	<!--// footer -->

	<!-- 모바일 수정 -->
	<div class="black"></div>
	<!--// 모바일 수정 -->
</form:form>
</body>
</html>