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
	function fn_view(){
		location.href = "<c:out value='${pageContext.request.contextPath }/qxsepmny/tmp/ech010102.do'/>";
	}
	
	function fn_pop() {
		window.open("<c:out value='${pageContext.request.contextPath }/qxsepmny/tmp/ech100401.do'/>"
				, '연구조회팝업', 'width=1000, height=500, menubar=no, status=no, toolbar=no, scrollbars=1');
	}
	
</script>
<body>
<!-- wrap -->
<div class="wrap">
	<c:import url="/EgovPageLink.do?link=adm/inc/incTopnav"/>
	<!-- container -->
	<div class="container">
		<h2>발송관리</h2>
		<!-- contents -->
		<div class="contents">
			<!-- 타이틀 -->
			<jsp:include page="/WEB-INF/jsp/ctms/adm/inc/incPageTitle.jsp">
				<jsp:param name="dept1" value="발송관리"/>
	            <jsp:param name="dept2" value="보고서발송"/>
           	</jsp:include>
			<!-- //타이틀 -->
            <!-- 발송내용 -->
            <table class="tbl_view mb03">
                <colgroup>
                    <col style="width:15%" />
                    <col style="width:85%" />
                </colgroup>
                <tbody>
                    <tr>
                        <th scope="row">연구선택</th>
                        <td>
                        	<a href="#" onclick="fn_pop(); return false;" class="btn_sub">연구조회</a>
                        	&nbsp;&nbsp;
                        	HBSE-MLG-20057-1  연구명이 들어갑니다.                        	
                        </td>
                    </tr>
                    <tr>
                        <th scope="row">첨부보고서</th>
                        <td>
                        	<input type="checkbox" name="attach" id="attach01" />
                        	<label for="attach01">연구이미지</label>
                        	<input type="checkbox" name="attach" id="attach02" />
                        	<label for="attach02">연구계획서</label>
                        </td>
                    </tr>
                </tbody>
            </table>
            <table class="tbl_view mb03">
                <colgroup>
                    <col style="width:15%" />
                    <col style="width:85%" />
                </colgroup>
                <tbody>
                    <tr>
                        <th scope="row">받는사람 이메일</th>
                        <td>
                        	<div class="email_address">
                        		<textarea class="type03"></textarea>
                        		<a href="#" class="btn_sub">고객사조회</a>           	
                        	</div>                        	
                        </td>
                    </tr>
                </tbody>
            </table>
            <table class="tbl_view mb03">
                <colgroup>
                    <col style="width:15%" />
                    <col style="width:85%" />
                </colgroup>
                <tbody>
                    <tr>
                        <th scope="row">발송일시</th>
                        <td>
                        	<input type="radio" name="sendType" id="sendType01" />
						    <label for="sendType01">즉시발송</label>
						    <input type="radio" name="sendType" id="sendType02" />
						    <label for="sendType02">예약발송</label>
						    &nbsp;&nbsp;
							<div class="date_sec type02">
								<span>
									<input type="text" class="date" />
									<a href="#" class="btn_cld">날짜검색</a>
								</span>
							</div>
							<select class="p10">
								<option>00</option>
							</select>
							시
							&nbsp;&nbsp;
							<select class="p10">
								<option>00</option>
							</select>
							분                     	
                        </td>
                    </tr>
                    <tr>
                        <th scope="row">발송제목</th>
                        <td>
                        	<input type="text" class="ta_l type02" />          	
                        </td>
                    </tr>
                    <tr>
                        <th scope="row">내용</th>
                        <td>
                        	<div class="editor_area">
                        		에디터
                       		</div>          	
                        </td>
                    </tr>
                    <tr>
                        <th scope="row">첨부파일</th>
                        <td>
                        	<div class="attach_sec type02">
                            	<input type="file" id="in_file01" />
                            	<label for="in_file01" class="btn_sub">파일업로드</label>
                            	<div>
                            		<span>파일명.jpg</span>
                            		<a href="#">삭제</a>
                            	</div>
                            </div>       	
                        </td>
                    </tr>
                </tbody>
            </table>
            <table class="tbl_view mb03">
                <colgroup>
                    <col style="width:15%" />
                    <col style="width:85%" />
                </colgroup>
                <tbody>
                    <tr>
                        <th scope="row">핸드폰 번호</th>
                        <td>
                       		<textarea class="type02 type03"></textarea>
                        </td>
                    </tr>
                    <tr>
                        <th scope="row">메시지</th>
                        <td>
                       		<textarea class="type02 type03"></textarea>
                        </td>
                    </tr>
                </tbody>
            </table>
            <p class="guide_txt">※ 수신자가 여러명일 경우 이메일, 핸드폰번호 사이에 콤마로 구분</p>
            <!-- //발송내용 -->
			<!-- 버튼 -->
			<div class="btn_area">
				<a href="#" class="type02">취소</a>
				<a href="#">발송</a>
			</div>
			<!-- //버튼 -->
		</div>
		<!-- //contents -->
	</div>
	<!-- //container -->
</div>	
<!-- //wrap -->

</body>
</html>