===============================================ȯ������ ����=======================================================

1. ����Ʈ��   webfilter  ���丮 ����

	webfilter ���丮 ����:	/js/webfilter.js
					
						/html/webfilterBypass.html
						/html/webfilterResult.html

						/inc/initCheckWebfilter.aspx


2. ������ IP �Ǵ� ������ ����

	2.1. webfilter.js ���� ����
		webFilterServerAddress='http://xxx.xxx.xxx.xxx';     ==> �ش� ������ ���� �����Ƿ� ����
		wfcontextRoot = "";   ==> �ش� ContextROOT �� ������ ��� ex)  '/english'


	2.2. initCheckWebfilter.aspx ���� ����
		
		2.2.1 �ڵ��� C# �Ǵ� VB ���� Ȯ��
			
			2.2.1.1  C#�ϰ�� �Ʒ��� �ּ��κ��� �����Ѵ�
			2.2.1.1  VB�ϰ�� �ּ�ó�� �ȵȺκ��� �����ϰ� �Ʒ��� �ּ��κ��� Ǯ���ش�.


		2.2.2  C#  �ϰ�� 	

			string wfcontextRoot = "";  ==> �ش� ContextROOT �� ������ ��� ex)  '/english'
			string wfServerAddress = "xxx.xxx.xxx.xxx";  ==> �ش� ������ ���� �����Ƿ� ����

		2.2.3  VB  �ϰ�� 	

			wfcontextRoot = ""    ==>    ==> �ش� ContextROOT �� ������ ��� ex)  '/english'
			wfServerAddress = "xxx.xxx.xxx.xxx"    ==> �ش� ������ ���� �����Ƿ� ����



3. ���������� �ҽ�����

	3.1  C#  �ϰ�� 	
	
		- ������������ FTP�� ��� 
	
		<!--  ������ ���� -->
		<% Server.Execute("/webfilter/inc/initCheckWebfilter.aspx"); %>
		<!--  ������ ���� -->

		</body>
		</html> 

		���Ͱ��� </body>�±� ���� ������ ����� include�Ѵ�.


	3.2  VB  �ϰ�� 	
	
		- ������������ FTP�� ��� 
	
		<!--  ������ ���� -->
		<% Server.Execute("/webfilter/inc/initCheckWebfilter.aspx") %>
		<!--  ������ ���� -->

		</body>
		</html> 

		���Ͱ��� </body>�±� ���� ������ ����� include�Ѵ�.


=====================================================
#######		�̰����� �ҽ����� �Ϸ�            #######
=====================================================