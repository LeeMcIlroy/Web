===============================================환경파일 세팅=======================================================

1. 웹루트에   webfilter  디렉토리 복사

	webfilter 디렉토리 파일:	/js/webfilter.js
					
						/html/webfilterBypass.html
						/html/webfilterResult.html

						/inc/initCheckWebfilter.jsp


2. 웹필터 IP 또는 도메인 설정

	2.1. webfilter.js 파일 수정
		webFilterServerAddress='http://xxx.xxx.xxx.xxx';     ==> 해당 웹필터 서버 아이피로 수정
		wfcontextRoot = "";   ==> 해당 ContextROOT 가 있으면 등록 ex)  '/english'



	2.2. initCheckWebfilter.php 파일 수정
		String wfcontextRoot = "";  ==> 해당 ContextROOT 가 있으면 등록 ex)  '/english'
		String wfServerAddress="xxx.xxx.xxx.xxx";  ==> 해당 웹필터 서버 아이피로 수정




3. 쓰기페이지 소스수정

	- 쓰기페이지를 FTP로 열어서 
	
	<!--  웹필터 수정 -->
	<%@ include file="/webfilter/inc/initCheckWebfilter.jsp"%>
	<!--  웹필터 수정 -->

	</body>
	</html> 

	위와같이 </body>태그 위에 웹필터 모듈을 include한다.

	
=====================================================
#######		이것으로 소스수정 완료            #######
=====================================================