===============================================ȯ������ ����=======================================================

1. ����Ʈ��   webfilter  ���丮 ����

	webfilter ���丮 ����:	/js/webfilter.js
					
						/html/webfilterBypass.html
						/html/webfilterResult.html

						/inc/initCheckWebfilter.php


2. ������ IP �Ǵ� ������ ����

	2.1. webfilter.js ���� ����
		webFilterServerAddress='http://xxx.xxx.xxx.xxx';     ==> �ش� ������ ���� �����Ƿ� ����
		wfcontextRoot = "";   ==> �ش� ContextROOT �� ������ ��� ex)  '/english'


	2.2. initCheckWebfilter.php ���� ����
		$wfcontextRoot = "";   ==> �ش� ContextROOT �� ������ ��� ex)  '/english'
		$wfServerAddress="xxx.xxx.xxx.xxx";   ==> �ش� ������ ���� �����Ƿ� ����


3. ���������� �ҽ�����

	- ������������ FTP�� ��� 
	
	<!--  ������ ���� -->
	<? include "/webfilter/inc/initCheckWebfilter.php"; ?>
	<!--  ������ ���� -->

	</body>
	</html> 

	���Ͱ��� </body>�±� ���� ������ ����� include�Ѵ�.


=====================================================
#######		�̰����� �ҽ����� �Ϸ�            #######
=====================================================