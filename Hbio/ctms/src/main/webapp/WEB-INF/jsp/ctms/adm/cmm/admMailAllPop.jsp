<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c"      uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="form"   uri="http://www.springframework.org/tags/form" %>
<%@ taglib prefix="ui"     uri="http://egovframework.gov/ctl/ui"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ taglib prefix="common" 	uri="/WEB-INF/tld/common.tld"%>
<!doctype html>
<html>
<c:import url="/EgovPageLink.do?link=adm/inc/incHead"/>
<script type="text/javascript">
	$(function(){
		//이메일 설정을 위해 연구대상자 목록 선택
		$("#all-chk").change(function(){
			$("input[name=rsjSeq]").prop("checked", $(this).prop('checked'));
		});
		
		$("input[name=rsjSeq]").prop("checked", "checked");
		
		var ynsendmCls = '<c:out value="${rm1000mVO.sendmCls}"/>';
		
		switch(ynsendmCls) {
		case "1" :  
			$("#sendmCls1").attr('checked', 'checked');
			break;
		case "2" :  
			$("#sendmCls2").attr('checked', 'checked');
			break;
		default :
			$("#sendmCls1").attr('checked', 'checked');	
		}
	});

	
	//multipart request 형태로 변경해야 함
	
	function fn_step(){
		if(confirm('대상자에게 이메일을 발송합니다.\r\n저장하시겠습니까?')){
			var corpCd = $("#corpCd").val();
			var recmDt = $("#datepicker01").val();
			var title = $("#title").val();
			var cont = $("#cont").val();			
			var sendmCls = $("input:radio[name='sendmCls']:checked").val();
			var resrDt = $("#datepicker02").val();
			var resrHr = $("#resrHr").val();
			var resrMm = $("#resrMm").val();
			var rsjNo = $("input[name=rsjSeq]:checked").serialize();
			
			//multipart request
			var form = $('#detailForm')[0];
			var data = new FormData(form);
			//, data: "corpCd="+corpCd+"&"+"recmDt="+recmDt+"&"+"sendmCls="+sendmCls+"&"+"resrDt="+resrDt+"&"+"resrHr="+resrHr+"&"+"resrMm="+resrMm+"&"+"title="+title+"&"+"cont="+cont+"&"+$("input[name=rsjSeq]:checked").serialize()
			//, dataType:"json"
			$.ajax({
				url: "<c:url value='${pageContext.request.contextPath }/qxsepmny/cmm/cmmAjaxSaveAllMail.do'/>"
				, type: "post"
				, enctype: 'multipart/form-data'
				, data: data
				, processData: false
	            , contentType: false
	            , cache: false
	            , timeout: 600000
				, success: function(data){
					//alert(data.message);
					alert("메일이 발송되었습니다");
					window.opener.fn_list(1);
					window.close();
				}, error: function(){
					alert("오류가 발생하였습니다.");
				}
			});
		}
	}
	
	function fn_emailspl() {		
		var jbString = $("select[name=emailspl]").val();
	    var jbSplit = jbString.split(';');
		$("#title").val(jbSplit[0]);
		$("#cont").val(jbSplit[1]);
	}
		
	
	//첨부파일 삭제
	function fn_delfile(fileKey, seq){
	
		var html = '';
		if(seq != ''){
			html += '<input type="hidden" id="delFile" name="delFile" value="'+seq+'"/>';
		}
			html += '<input type="file" id="'+fileKey+'" name="'+fileKey+'" onchange="fn_file_add(\''+fileKey+'\'); return false;"/>';
			html += '<label for="'+fileKey+'" id="'+fileKey+'_label" class="btn_sub">파일업로드</label>';
		
		
		$("#"+fileKey+"_div").html(html);
	}
	//첨부파일 추가
	function fn_file_add(fileKey){
		
		if(fileCheck_adm(fileKey)){
			var fileValue = $('#'+fileKey).val().split("\\");
			var fileName = fileValue[fileValue.length-1];
			var extension = fileName.split(".")[1].toUpperCase();
			var html = ''
		
			html+= '<div>';
			html+= '<span>'+fileName+'</span>';
			html+= '<a href="#" onclick="fn_delfile(\''+fileKey+'\',\'\');">삭제</a>';
			html+= '</div>'; 
			
			$("#"+fileKey+"_label").addClass('dpn');
			$("#"+fileKey+"_div").append(html); 
        } 
	}
	
</script>
<body>
<!-- pop_wrap -->
<div class="pop_wrap">
	<!-- pop_header -->
	<div class="pop_header">
		<h1 class="hidden"><a href="#">H&amp;Bio</a></h1>
		<h2>이메일 발송</h2>
		<a href="javascript:window.close();" title="닫기">닫기</a>
	</div>
	<!-- //pop_header -->
	<!-- pop_con -->
	<div class="pop_con type02">
	<form:form commandName="rm1000mVO" id="detailForm" name="detailForm" method="post" enctype="multipart/form-data">
			<input type="hidden" id="corpCd" name="corpCd" value="${rm1000mVO.corpCd}">
			<!-- <input type="hidden" id="rsjSeq" name="rsjSeq"> -->			
			<input type="hidden" id="pageIndex" name="pageIndex" value="${pageIndex}">
		<!-- 서브타이틀 -->
		<div class="sub_title_area type02">
			<h3>발송 대상자</h3>
		</div>
		<!-- //서브타이틀 -->
		<!-- 대상자 -->
		<div>
		<div class="hd_fix">
				<table class="tbl_list">
					<colgroup>
						<col style="width:10%" />
						<col style="width:10%" />
						<col style="width:auto" />
						<col style="width:20%" />
						<col style="width:15%" />
						<col style="width:20%" />
						<col style="width:10%" />
					</colgroup>
					<thead>
						<tr>
							<th scope="col" ><input type="checkbox" id="all-chk"/></th>
							<th scope="col" >번호</th>
							<th scope="col" >이름</th>
							<th scope="col" >이메일</th>
							<th scope="col" >핸드폰</th>
							<th scope="col" >연구코드</th>
							<th scope="col" >참여상태</th>
						</tr>
					</thead>
					<tbody>
						<c:forEach var="result" items="${resultList}" varStatus="status">			
					<tr>
						<td><input type="checkbox" name="rsjSeq" value="<c:out value='${result.rsNo }'/><c:out value='${result.rsjNo }'/><c:out value='${result.hpNo }'/><c:out value='${result.email }'/>"/></td>
						<td><c:out value="${result.rownum}"/></td>
						<td><c:out value="${result.rsjName}"/></td>
						<td>
							<c:choose>
                        		<c:when test="${result.email eq '' }"><span style="color:red;">(이메일주소확인)</span></c:when>
                        		<c:when test="${result.email ne '' }"><c:out value="${result.email }"/></c:when>
                       		</c:choose>
						</td>
						<td>
							<c:choose>
                        		<c:when test="${result.hpNo eq '' }"><span style="color:red;">(핸드폰번호확인)</span></c:when>
                        		<c:when test="${result.hpNo ne '' }"><c:out value="${result.hpNo }"/></c:when>
                       		</c:choose>
						</td>
						<td><c:out value="${result.rsCd}"/></td>
						<td><c:out value="${result.appstaClsNm}"/></td>
					</tr>
					</c:forEach>
					<c:if test="${resultList.size() == 0 }">
						<tr>
							<td class="nodata" colspan="6">선택한 대상자 정보가 없습니다.</td>
						</tr>
					</c:if>
					</tbody>
				</table>
		</div>
		</div>
		<!-- //대상자 -->
		<!-- 이메일발송 -->
		<table class="tbl_view">
			<colgroup>
				<col style="width:200px" />
				<col style="width:auto" />
			</colgroup>
			<tbody>
				<tr>
					<th scope="row">접수일자</th>
					<td>	    
						<div class="date_sec type02">
							<span>
								<input name="recmDt" id="datepicker01" placeholder="0000-00-00" value="<c:out value="${rm1000mVO.recmDt }" />" class="date required" title="예약일자" />
								<label for="datepicker01" class="btn_cld">날짜검색</label>
							</span>
						</div>
					</td>	
				</tr>	
				<tr>
					<th scope="row">발송구분</th>
					<td>
						<input type="radio" name="sendmCls" id="sendmCls1" value="1"/>
					    <label for="sendmCls1">즉시발송</label>
					    <input type="radio" name="sendmCls" id="sendmCls2" value="2"/>
					    <label for="sendmCls2">예약발송</label>
					</td>
				<tr>
					<th scope="row">예약일자</th>
					<td>	    
						<div class="date_sec type02">
							<span>
								<input name="resrDt" id="datepicker02" placeholder="0000-00-00" value="<c:out value="${rm1000mVO.resrDt }" />" class="date required" title="예약일자" />
								<label for="datepicker02" class="btn_cld">날짜검색</label>
							</span>
						</div>
						<select id="resrHr" name="resrHr" class="p30">
							<option value="" <c:if test="${rm1000mVO.resrHr eq '' }">selected="selected"</c:if> >선택</option>
							<option value="1" <c:if test="${rm1000mVO.resrHr eq '1' }">selected="selected"</c:if> >1</option>
							<option value="2" <c:if test="${rm1000mVO.resrHr eq '2' }">selected="selected"</c:if> >2</option>
							<option value="3" <c:if test="${rm1000mVO.resrHr eq '3' }">selected="selected"</c:if> >3</option>
							<option value="4" <c:if test="${rm1000mVO.resrHr eq '4' }">selected="selected"</c:if> >4</option>
							<option value="5" <c:if test="${rm1000mVO.resrHr eq '5' }">selected="selected"</c:if> >5</option>
							<option value="6" <c:if test="${rm1000mVO.resrHr eq '6' }">selected="selected"</c:if> >6</option>
							<option value="7" <c:if test="${rm1000mVO.resrHr eq '7' }">selected="selected"</c:if> >7</option>
							<option value="8" <c:if test="${rm1000mVO.resrHr eq '8' }">selected="selected"</c:if> >8</option>
							<option value="9" <c:if test="${rm1000mVO.resrHr eq '9' }">selected="selected"</c:if> >9</option>
							<option value="10" <c:if test="${rm1000mVO.resrHr eq '10' }">selected="selected"</c:if> >10</option>
							<option value="11" <c:if test="${rm1000mVO.resrHr eq '11' }">selected="selected"</c:if> >11</option>
							<option value="12" <c:if test="${rm1000mVO.resrHr eq '12' }">selected="selected"</c:if> >12</option>
							<option value="13" <c:if test="${rm1000mVO.resrHr eq '13' }">selected="selected"</c:if> >13</option>
							<option value="14" <c:if test="${rm1000mVO.resrHr eq '14' }">selected="selected"</c:if> >14</option>
							<option value="15" <c:if test="${rm1000mVO.resrHr eq '15' }">selected="selected"</c:if> >15</option>
							<option value="16" <c:if test="${rm1000mVO.resrHr eq '16' }">selected="selected"</c:if> >16</option>
							<option value="17" <c:if test="${rm1000mVO.resrHr eq '17' }">selected="selected"</c:if> >17</option>
							<option value="18" <c:if test="${rm1000mVO.resrHr eq '18' }">selected="selected"</c:if> >18</option>
							<option value="19" <c:if test="${rm1000mVO.resrHr eq '19' }">selected="selected"</c:if> >19</option>
							<option value="20" <c:if test="${rm1000mVO.resrHr eq '20' }">selected="selected"</c:if> >20</option>
							<option value="21" <c:if test="${rm1000mVO.resrHr eq '21' }">selected="selected"</c:if> >21</option>
							<option value="22" <c:if test="${rm1000mVO.resrHr eq '22' }">selected="selected"</c:if> >22</option>
							<option value="23" <c:if test="${rm1000mVO.resrHr eq '23' }">selected="selected"</c:if> >23</option>
						</select>시&nbsp;&nbsp;
						<select id="resrMm" name="resrMm" class="p30">
							<option value="" <c:if test="${rm1000mVO.resrMm eq '' }">selected="selected"</c:if> >선택</option>
							<option value="0" <c:if test="${rm1000mVO.resrMm eq '0' }">selected="selected"</c:if> >00</option>
							<option value="10" <c:if test="${rm1000mVO.resrMm eq '10' }">selected="selected"</c:if> >10</option>
							<option value="20" <c:if test="${rm1000mVO.resrMm eq '20' }">selected="selected"</c:if> >20</option>
							<option value="30" <c:if test="${rm1000mVO.resrMm eq '30' }">selected="selected"</c:if> >30</option>
							<option value="40" <c:if test="${rm1000mVO.resrMm eq '40' }">selected="selected"</c:if> >40</option>
							<option value="50" <c:if test="${rm1000mVO.resrMm eq '50' }">selected="selected"</c:if> >50</option>
						</select>분
					</td>
				</tr>
				<tr>
					<th scope="row">발송 제목</th>
					<td>
					<div class="msg_select">
						<select id="emailspl" name="emailspl" onchange="fn_emailspl()">
							<option value="">자동입력</option>
							<c:forEach var="emailresult" items="${emailList}">									
								<option value="${emailresult.title};${emailresult.cont}">${emailresult.title}</option>
							</c:forEach>
						</select>
						</div>
						<input name="title" id="title" value="<c:out value="${rm1000mVO.title }" />" class="p90 required" title="발송제목" />
					</td>
				</tr>
				<tr>
					<th scope="row">내 용</th>
					<td>
					<textarea id="cont" name="cont"><c:out value="${rm1000mVO.cont }" /></textarea>
					</td>
				</tr>
				<tr>
					<th scope="row">첨부파일</th>
                    <td id="file_td">
                    	<div class="attach_sec type02 mb02" id="attachRpt01_div">
                         	<c:choose>
                          		<c:when test="${attachMap.attachRpt01 != null }">
                            	<div>
                            		<span><c:out value="${attachMap.attachRpt01.orgFileName }"/></span>
                            		<a href="#" onclick="fn_delfile('attachRpt01','<c:out value="${attachMap.attachRpt01.attachNo }"/>');">삭제</a>
                            	</div>
                          		</c:when>
                          		<c:otherwise>
                            	 <input type="file" id="attachRpt01" name="attachRpt01" onchange="fn_file_add('attachRpt01'); return false;"/>
                            	<label for="attachRpt01" id="attachRpt01_label" class="btn_sub">파일업로드</label>  
                          		</c:otherwise>
                         	</c:choose>
                        </div>
					</td>
				</tr>
			</tbody>
		</table>
		<!-- //이메일발송 -->
		</form:form>
		<!-- 버튼 -->
		<div class="btn_area">
			<a href="javascript:window.close();" class="type02">취소</a>
			<a href="#" onclick="fn_step(); return false;" >저장</a>
		</div>
		<!-- //버튼 -->
	</div>
	<input type="hidden" name="message" id="message" value="<c:out value='${message }'/>"/>
	<!-- //pop_con -->
</div>	
<!-- //pop_wrap -->
</body>
</html>