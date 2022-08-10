===============================================환경파일 세팅=======================================================

1. 웹루트에   webfilter  디렉토리 복사

	webfilter 디렉토리 파일:	/js/webfilter.js
					
						/html/webfilterBypass.html
						/html/webfilterResult.html

						/inc/initCheckWebfilter.asp


2. asp TCP Socket 서버에 설치

	# CSSocket_Setup 사용시
	2.1  설치하기전에 먼제 테스트후 소켓연결이 안될경우에 설치
	2.2  CSSocket_Setup.exe 설치한다.

	# w3Socket 사용시
        2.1  설치하기전에 먼제 테스트후 소켓연결이 안될경우에 설치
	2.2  Socket.dll 을 해당서버 c:\windows\system32\ 폴더에 복사한후
              regsvr32 c:\windows\system32\Socket.dll 윈도우 실행하여 레지스트에 등록


3. 웹필터 IP 또는 도메인 설정

	3.1. webfilter.js 파일 수정
		webFilterServerAddress='http://xxx.xxx.xxx.xxx';     ==> 해당 웹필터 서버 아이피로 수정
		wfcontextRoot = "";   ==> 해당 ContextROOT 가 있으면 등록 ex)  '/english'

	3.2. initCheckWebfilter.asp 파일 수정
		wfcontextRoot = ""	==> 해당 ContextROOT 가 있으면 등록 ex)  '/english'
		wfServerAddress="xxx.xxx.xxx.xxx"   ==> 해당 웹필터 서버 아이피로 수정


4. 쓰기페이지 소스수정

	- 쓰기페이지를 FTP로 열어서 
	
	<!--  웹필터 수정 -->
	<%Server.Execute "/webfilter/inc/initCheckWebfilter.asp"%>
	<!--  웹필터 수정 -->

	</body>
	</html> 

	위와같이 </body>태그 위에 웹필터 모듈을 include한다.
	

=====================================================
#######		이것으로 소스수정 완료            #######
=====================================================