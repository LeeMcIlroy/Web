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
		window.open("<c:out value='${pageContext.request.contextPath }/qxsepmny/tmp/ech030202.do'/>"
					, '연구일정팝업', 'width=1000, height=500, menubar=no, status=no, toolbar=no, scrollbars=1');
	}
</script>
<body>
<!-- wrap -->
<div class="wrap">
	<c:import url="/EgovPageLink.do?link=adm/inc/incTopnav"/>
	<!-- container -->
	<div class="container">
		<h2>피험자관리</h2>
		<!-- contents -->
		<div class="contents">
			<!-- 타이틀 -->
			<jsp:include page="/WEB-INF/jsp/ctms/adm/inc/incPageTitle.jsp">
				<jsp:param name="dept1" value="피험자관리"/>
	            <jsp:param name="dept2" value="연구일정"/>
           	</jsp:include>
			<!-- //타이틀 -->
			<!-- 달력 -->
			<div class="calendar_top">
				<a href="#">이전달</a>
				2020년 10월
				<a href="#">다음달</a>
				<div>
					<span>
						<select>
							<option>연구코드 선택</option>
						</select>
					</span>
				</div>
			</div>			
			<div class="calendar sec_ver01">						
				<table>
					<colgroup>
						<col style="width:14%" />
						<col style="width:14%" />
						<col style="width:14%" />
						<col style="width:14%" />
						<col style="width:14%" />
						<col style="width:14%" />
						<col style="width:14%" />
					</colgroup>
					<thead>
						<tr>
							<th scope="col">일</th>
							<th scope="col">월</th>
							<th scope="col">화</th>
							<th scope="col">수</th>
							<th scope="col">목</th>
							<th scope="col">금</th>
							<th scope="col">토</th>
						</tr>
					</thead>
					<tbody>
						<tr>
							<td>
								<div>1</div>
							</td>
							<td>
								<div>2</div>
							</td>
							<td class="today">
								<div>3</div>
								<a href="#" onclick="fn_pop(); return false;" class="event_color01">HBSE-MLG-20057-1 시작</a>
								<a href="#" class="event_color02">HBSE-MLG-20057-1 시작</a>
								<a href="#" class="event_color03">HBSE-MLG-20057-1 시작</a>
								<a href="#" class="event_color04">HBSE-MLG-20057-1 시작</a>
								<a href="#" class="event_color05">HBSE-MLG-20057-1 시작</a>
							</td>
							<td>
								<div>4</div>
							</td>
							<td>
								<div>5</div>
								<a href="#" class="event_color06">HBSE-MLG-20057-1 시작</a>
								<a href="#" class="event_color07">HBSE-MLG-20057-1 시작</a>
								<a href="#" class="event_color08">HBSE-MLG-20057-1 시작</a>
								<a href="#" class="event_color09">HBSE-MLG-20057-1 시작</a>
								<a href="#" class="event_color10">HBSE-MLG-20057-1 시작</a>
							</td>
							<td>
								<div>6</div>
							</td>
							<td>
								<div>7</div>
							</td>
						</tr>
						<tr>
							<td>
								<div>8</div>
							</td>
							<td>
								<div>9</div>
								<a href="#" class="event_color11">HBSE-MLG-20057-1 시작</a>
								<a href="#" class="event_color12">HBSE-MLG-20057-1 시작</a>
								<a href="#" class="event_color13">HBSE-MLG-20057-1 시작</a>
								<a href="#" class="event_color14">HBSE-MLG-20057-1 시작</a>
								<a href="#" class="event_color15">HBSE-MLG-20057-1 시작</a>							
							</td>
							<td>
								<div>10</div>
							</td>
							<td>
								<div>11</div>
							</td>
							<td>
								<div>12</div>
							</td>
							<td>
								<div>13</div>
								<a href="#" class="event_color16">HBSE-MLG-20057-1 시작</a>
								<a href="#" class="event_color17">HBSE-MLG-20057-1 시작</a>
								<a href="#" class="event_color18">HBSE-MLG-20057-1 시작</a>
								<a href="#" class="event_color19">HBSE-MLG-20057-1 시작</a>
								<a href="#" class="event_color20">HBSE-MLG-20057-1 시작</a>
							</td>
							<td>
								<div>14</div>
							</td>
						</tr>
						<tr>
							<td>
								<div>15</div>
							</td>
							<td>
								<div>16</div>
							</td>
							<td>
								<div>17</div>
							</td>
							<td>
								<div>18</div>
							</td>
							<td>
								<div>19</div>
							</td>
							<td>
								<div>20</div>
							</td>
							<td>
								<div>21</div>
							</td>
						</tr>
						<tr>
							<td>
								<div>22</div>
							</td>
							<td>
								<div>23</div>
								<a href="#" class="event_color21">HBSE-MLG-20057-1 시작</a>
								<a href="#" class="event_color22">HBSE-MLG-20057-1 시작</a>
								<a href="#" class="event_color23">HBSE-MLG-20057-1 시작</a>
								<a href="#" class="event_color24">HBSE-MLG-20057-1 시작</a>
								<a href="#" class="event_color25">HBSE-MLG-20057-1 시작</a>		
							</td>
							<td>
								<div>24</div>
							</td>
							<td>
								<div>25</div>
							</td>
							<td>
								<div>26</div>
							</td>
							<td>
								<div>27</div>
								<a href="#" class="event_color26">HBSE-MLG-20057-1 시작</a>
								<a href="#" class="event_color27">HBSE-MLG-20057-1 시작</a>
								<a href="#" class="event_color28">HBSE-MLG-20057-1 시작</a>
								<a href="#" class="event_color29">HBSE-MLG-20057-1 시작</a>
								<a href="#" class="event_color30">HBSE-MLG-20057-1 시작</a>
							</td>
							<td>
								<div>28</div>
							</td>
						</tr>
						<tr>
							<td>
								<div>29</div>
							</td>
							<td>
								<div>30</div>
							</td>
							<td>
								<div>31</div>
							</td>
							<td></td>
							<td></td>
							<td></td>
							<td></td>
						</tr>
					</tbody>
				</table>
			</div>
			<!-- //달력 -->
		</div>
		<!-- //contents -->
	</div>
	<!-- //container -->
</div>	
<!-- //wrap -->
</body>
</html>