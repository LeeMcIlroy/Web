===============================================ȯ������ ����=======================================================

1. ����Ʈ��   webfilter  ���丮 ����

	webfilter ���丮 ����:	/js/webfilter.js
					
						/html/webfilterBypass.html
						/html/webfilterResult.html

						/inc/initCheckWebfilter.asp


2. asp TCP Socket ������ ��ġ

	# CSSocket_Setup ����
	2.1  ��ġ�ϱ����� ���� �׽�Ʈ�� ���Ͽ����� �ȵɰ�쿡 ��ġ
	2.2  CSSocket_Setup.exe ��ġ�Ѵ�.

	# w3Socket ����
        2.1  ��ġ�ϱ����� ���� �׽�Ʈ�� ���Ͽ����� �ȵɰ�쿡 ��ġ
	2.2  Socket.dll �� �ش缭�� c:\windows\system32\ ������ ��������
              regsvr32 c:\windows\system32\Socket.dll ������ �����Ͽ� ������Ʈ�� ���


3. ������ IP �Ǵ� ������ ����

	3.1. webfilter.js ���� ����
		webFilterServerAddress='http://xxx.xxx.xxx.xxx';     ==> �ش� ������ ���� �����Ƿ� ����
		wfcontextRoot = "";   ==> �ش� ContextROOT �� ������ ��� ex)  '/english'

	3.2. initCheckWebfilter.asp ���� ����
		wfcontextRoot = ""	==> �ش� ContextROOT �� ������ ��� ex)  '/english'
		wfServerAddress="xxx.xxx.xxx.xxx"   ==> �ش� ������ ���� �����Ƿ� ����


4. ���������� �ҽ�����

	- ������������ FTP�� ��� 
	
	<!--  ������ ���� -->
	<%Server.Execute "/webfilter/inc/initCheckWebfilter.asp"%>
	<!--  ������ ���� -->

	</body>
	</html> 

	���Ͱ��� </body>�±� ���� ������ ����� include�Ѵ�.
	

=====================================================
#######		�̰����� �ҽ����� �Ϸ�            #######
=====================================================