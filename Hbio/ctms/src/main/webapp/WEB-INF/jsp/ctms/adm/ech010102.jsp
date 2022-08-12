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
	function fn_pop(){
		window.open("<c:out value='${pageContext.request.contextPath }/qxsepmny/tmp/ech100501.do'/>"
					, '관리자 조회', 'width=1000, height=500, menubar=no, status=no, toolbar=no, scrollbars=1');
	}
	function fn_list(){
		location.href = "<c:out value='${pageContext.request.contextPath }/qxsepmny/tmp/ech010101.do'/>";
	}	
</script>
<body>
<!-- wrap -->
<div class="wrap">
	<c:import url="/EgovPageLink.do?link=adm/inc/incTopnav"/>
	<!-- container -->
	<div class="container">
		<h2>연구관리</h2>
		<!-- contents -->
		<div class="contents">
			<!-- 타이틀 -->
			<jsp:include page="/WEB-INF/jsp/ctms/adm/inc/incPageTitle.jsp">
				<jsp:param name="dept1" value="연구관리"/>
	            <jsp:param name="dept2" value="연구관리"/>
           	</jsp:include>
			<!-- //타이틀 -->
			<!-- 서브타이틀 -->
            <div class="sub_title_area type02">
                <h4>연구정보</h4>
            </div>
            <!-- //서브타이틀 -->
            <!-- 연구정보 -->
            <table class="tbl_view">
                <colgroup>
                    <col style="width:15%" />
                    <col style="width:35%" />
                    <col style="width:15%" />
                    <col style="width:35%" />
                </colgroup>
                <tbody>
                    <tr>
                        <th scope="row">연구코드</th>
                        <td>
                            <select class="p25">
                                <option>선택</option>
                            </select>
                            -
                            <input type="text" class="p25" />
                            -
                            <input type="text" class="p25" />
                            -
                            <input type="text" class="p15" />
                        </td>
                        <th scope="row" class="bl">연구목적</th>
                        <td>
                            <select>
                                <option>선택</option>
                            </select>
                        </td>
                    </tr>
                    <tr>
                        <th scope="row">연구지사</th>
                        <td>
                            <select>
                                <option>선택</option>
                            </select>
                        </td>
                        <th scope="row" class="bl">연구분야</th>
                        <td>
                            <select>
                                <option>선택</option>
                            </select>
                        </td>
                    </tr>
                    <tr>
                        <th scope="row">연구책임자</th>
                        <td>
                            <div class="srch_sec">
                                홍길동
                                <a href="#" onclick="fn_pop(); return false;" class="btn_sub">조회</a>
                            </div>
                        </td>
                        <th scope="row" class="bl">연구담당자</th>
                        <td>
                            <div class="srch_sec">
                                홍길동
                                <a href="#" onclick="fn_pop(); return false;" class="btn_sub">조회</a>
                            </div>
                        </td>
                    </tr>
                    <tr>
                        <th scope="row">피험자수</th>
                        <td>
                            <input type="text" class="p25" /> 명&nbsp;&nbsp;&nbsp;
                            최대지원자수&nbsp;&nbsp;
                            <input type="text" class="p25" /> 명
                        </td>
                        <th scope="row" class="bl">연구기간</th>
                        <td>
                            <div class="date_sec">
                                <span>
                                    <input type="text" class="date" />
                                    <a href="#" class="btn_cld">날짜검색</a>
                                </span>
                                <em>~</em>
                                <span>
                                    <input type="text" class="date" />
                                    <a href="#" class="btn_cld">날짜검색</a>
                                </span>
                            </div>
                        </td>
                    </tr>
                    <tr>
                        <th scope="row">연구상태</th>
                        <td>
                            <input type="radio" name="H010101" id="H010101_01" />
                            <label for="H010101_01">예정</label>
                            <input type="radio" name="H010101" id="H010101_02" />
                            <label for="H010101_02">진행</label>
                            <input type="radio" name="H010101" id="H010101_03" />
                            <label for="H010101_03">완료</label>
                            <input type="radio" name="H010101" id="H010101_04" />
                            <label for="H010101_04">취소</label>
                        </td>
                        <th scope="row" class="bl">결과보고일</th>
                        <td>
                            <div class="date_sec">
                                <span>
                                    <input type="text" class="date" />
                                    <a href="#" class="btn_cld">날짜검색</a>
                                </span>
                            </div>
                        </td>
                    </tr>
                    <tr>
                        <th scope="row">방문횟수</th>
                        <td>
                            <select class="p90">
                                <option>선택</option>
                            </select>
                            회
                        </td>
                        <th scope="row" class="bl">중복참여여부</th>
                        <td>
                            <input type="radio" name="H010102" id="H010102_01" />
                            <label for="H010102_01">중복참여 가능</label>
                            <input type="radio" name="H010102" id="H010102_02" />
                            <label for="H010102_02">중복참여 불가</label>
                        </td>
                    </tr>
                    <tr>
                        <th scope="row">대상부위</th>
                        <td colspan="3">                            
                            <input type="checkbox" name="H010103" id="H010103_01" />
                            <label for="H010103_01">이마</label>
                            <input type="checkbox" name="H010103" id="H010103_02" />
                            <label for="H010103_02">눈</label>
                            <input type="checkbox" name="H010103" id="H010103_03" />
                            <label for="H010103_03">코</label>
                            <input type="checkbox" name="H010103" id="H010103_04" />
                            <label for="H010103_04">입</label>
                            <input type="checkbox" name="H010103" id="H010103_05" />
                            <label for="H010103_05">얼굴전체</label>
                            <input type="checkbox" name="H010103" id="H010103_06" />
                            <label for="H010103_06">등</label>
                            <input type="checkbox" name="H010103" id="H010103_07" />
                            <label for="H010103_07">피부전체</label>
                        </td>
                    </tr>
                    <tr>
                        <th scope="row">연구명</th>
                        <td colspan="3">                            
                            <input type="text" class="type02 ta_l" />
                        </td>
                    </tr>
                    <tr>
                        <th scope="row">대상부위</th>
                        <td colspan="3">                            
                            <textarea class="type02"></textarea>
                        </td>
                    </tr>
                </tbody>
            </table>
            <!-- //연구정보 -->
            <!-- 서브타이틀 -->
            <div class="sub_title_area">
                <h4>의뢰기관</h4>
            </div>
            <!-- //서브타이틀 -->
            <!-- 의뢰기관 -->
            <table class="tbl_view">
                <colgroup>
                    <col style="width:15%" />
                    <col style="width:35%" />
                    <col style="width:15%" />
                    <col style="width:35%" />
                </colgroup>
                <tbody>
                    <tr>
                        <th scope="row">고객사명</th>
                        <td>
                            <select>
                                <option>선택</option>
                            </select>
                        </td>
                        <th scope="row" class="bl">담당자</th>
                        <td>
                            <input type="text" class="ta_l" />
                        </td>
                    </tr>
                    <tr>
                        <th scope="row">연락처</th>
                        <td>
                            <select class="p25">
                                <option>선택</option>
                            </select>
                            -
                            <input type="text" class="p30" />
                             -
                            <input type="text" class="p30" />
                        </td>
                        <th scope="row" class="bl">이메일</th>
                        <td>
                            <input type="text" class="p30" />
                             @
                            <input type="text" class="p30" />
                            <select class="p30">
                                <option>직접입력</option>
                            </select>
                        </td>
                    </tr>
                    <tr>
                        <th scope="row">연구비</th>
                        <td>                            
                            <input type="text" class="p40" />
                            &nbsp;&nbsp;&nbsp;VAT&nbsp;
                            <input type="text" class="p40" />
                        </td>
                        <th scope="row" class="bl">IRB승인</th>
                        <td>
                            <input type="radio" name="H010104" id="H010104_01" />
                            <label for="H010104_01">필요</label>
                            <input type="radio" name="H010104" id="H010104_02" />
                            <label for="H010104_02">불필요</label>
                        </td>
                    </tr>
                    <tr>
                        <th scope="row">제품정보</th>
                        <td colspan="3">
                        	<select class="p40">
                        		<option>제품구분</option>
                        	</select>        
                        	&nbsp;&nbsp;&nbsp;제품명&nbsp;                   
                            <input type="text" class="p50 ta_l" />
                        </td>
                    </tr>
                </tbody>
            </table>
            <!-- //의뢰기관 -->
            <!-- 서브타이틀 -->
            <div class="sub_title_area">
                <h4>첨부파일</h4>
            </div>
            <!-- //서브타이틀 -->
            <!-- 첨부파일 -->
            <table class="tbl_view">
                <colgroup>
                    <col style="width:15%" />
                    <col style="width:35%" />
                    <col style="width:15%" />
                    <col style="width:35%" />
                </colgroup>
                <tbody>
                    <tr>
                        <th scope="row">연구공고</th>
                        <td>
                            <div class="attach_sec">
                            	<input type="file" id="in_file01" />
                            	<label for="in_file01" class="btn_sub">파일업로드</label>
                            	<div>
                            		<span>파일명.jpg</span>
                            		<a href="#">삭제</a>
                            	</div>
                            </div>
                        </td>
                        <th scope="row" class="bl">연구계획서</th>
                        <td>
                            <div class="attach_sec">
                            	<input type="file" id="in_file02" />
                            	<label for="in_file02" class="btn_sub">파일업로드</label>
                            	<div>
                            		<span>파일명.jpg</span>
                            		<a href="#">삭제</a>
                            	</div>
                            </div>
                        </td>
                    </tr>
                    <tr>
                        <th scope="row">IRB신규계획서</th>
                        <td>
                            <div class="attach_sec">
                            	<input type="file" id="in_file03" />
                            	<label for="in_file03" class="btn_sub">파일업로드</label>
                            	<div>
                            		<span>파일명.jpg</span>
                            		<a href="#">삭제</a>
                            	</div>
                            </div>
                        </td>
                        <th scope="row" class="bl">IRB결과보고서</th>
                        <td>
                            <div class="attach_sec">
                            	<input type="file" id="in_file04" />
                            	<label for="in_file04" class="btn_sub">파일업로드</label>
                            	<div>
                            		<span>파일명.jpg</span>
                            		<a href="#">삭제</a>
                            	</div>
                            </div>
                        </td>
                    </tr>
                </tbody>
            </table>
            <!-- //첨부파일 -->
			<!-- 버튼 -->
			<div class="btn_area">
				<a href="#" class="type02">취소</a>
				<a onclick="fn_list(); return false;">저장</a>
				<!-- 토글버튼 -->
				<div>
					데이터 잠금
		       		<div class="toggle_btn">
						<label class="switch">
							<input type="checkbox" id="data_lock" />
							<span class="slider round"></span>
						</label>
						<p>Lock</p>
					</div>
				</div>
				<!-- //토글버튼 -->
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
