<%@ page contentType="text/html; charset=utf-8" pageEncoding="utf-8" %>
<%@ page import="java.io.File, java.text.SimpleDateFormat, java.util.*" %>
<%@ page import="com.ubireport.eform.UbiEformData, com.ubireport.common.util.StrUtil" %>
<%@ page import="component.ubi.UbiReportTask, egovframework.rte.psl.dataaccess.util.EgovMap" %>
<%@ page import="org.springframework.web.context.*, org.springframework.web.context.support.*"%>
<%
	/* UbiReportTask ubiTask = new UbiReportTask(); */
	WebApplicationContext ac = WebApplicationContextUtils.getWebApplicationContext(application);
	UbiReportTask ubiTask = (UbiReportTask) ac.getBean("ubiTask");
	EgovMap paramMap = new EgovMap();
	List<EgovMap> answList = new ArrayList<EgovMap>();
	String type = "";

	// 보안을 위해 설치 후 임시로 false로 변경해서 결과 확인 후 소스 배포 시 무조건 true로 변경해야함
	boolean refererCheck = false;
	String referer = request.getHeader("referer");	// REFERER 가져오기
	if( refererCheck && 
		(com.ubireport.common.util.StrUtil.nvl(referer, "").equals("") || 
				com.ubireport.common.util.StrUtil.nvl(referer, "").indexOf(request.getServerName()) == -1) ) { 	// REFERER 체크(브라우저에서 직접 호출 방지)
		out.clear();
		out.print("비정상적인 접근입니다.");
		return;
	}

	boolean useLog = true;
	String NL = System.getProperty("line.separator");
	String TODAY = (new SimpleDateFormat("yyyyMMdd")).format(System.currentTimeMillis());

	//웹어플리케이션명
	String appName = StrUtil.nvl(request.getContextPath(), "");
	if( "/".equals(appName) )
		appName = "";
	//웹어플리케이션 Root URL, ex)http://localhost:8080/myapp
	String appUrl = request.getScheme() + "://" + request.getServerName() + ":" + request.getServerPort() + appName;	

	String serverUrl = appUrl + "/UbiServer";
	String appPath = request.getRealPath("/");
	appPath = appPath.replaceAll("\\\\", "/");
	if( appPath.lastIndexOf("/") == (appPath.length() - 1) ) {
		appPath = appPath.substring(0, appPath.lastIndexOf("/"));
	}
	//System.out.println("[appUrl] " + appUrl);
	//System.out.println("[appPath] " + appPath);
	
	// PDF 저장 경로
//	String savePath = appPath + "/ubi4/storage/" + TODAY;
	String savePath = "D:/WAS/2020/ctms/upload/attach/";

	// PDF 파일명 ( 고객코드_파일명_시간 로 생성 )
	String saveFileName = "";
	String saveFullPath = "";
	String typePath = "";

	/* 설정 정보 */
	StringBuffer sb = new StringBuffer();
	sb.append("---------------------------------------------").append(NL);
	sb.append("[ Setting Info]").append(NL);
	sb.append("---------------------------------------------").append(NL);
	sb.append("* App URL : " + appUrl).append(NL);
	sb.append("* UbiServer URL : " + serverUrl).append(NL);
	sb.append("* App Path : " + appPath).append(NL);
	sb.append("* Save Path : " + savePath).append(NL);
	sb.append("* Save File Name : " + saveFileName).append(NL);
	sb.append("* Save Full Path : " + saveFullPath).append(NL);
	sb.append(NL);
	
	
	out.clearBuffer();

	UbiEformData ubiEformData = null;
	try {

		ubiEformData = new UbiEformData(request, response);

		int i = 0;
		/* 아규먼트 정보 : ubiencrypt=true인 경우 아규먼트 정보처리가 안됨. 수정 필요*/
		sb.append("---------------------------------------------").append(NL);
		sb.append("[ Argument Info]").append(NL);
		sb.append("---------------------------------------------").append(NL);
		String[] argNames = ubiEformData.getArgumentNames();
		if (argNames != null) {
			for (i = 0; i < argNames.length; i++) {
				sb.append(argNames[i] + " = " + ubiEformData.getArgument(argNames[i])).append(NL);
				paramMap.put(argNames[i], ubiEformData.getArgument(argNames[i]));
				if("type".equals(argNames[i])){
					type = ubiEformData.getArgument(argNames[i]);
				}
			}
		}
		sb.append(NL);
		
		if(type.indexOf("agree") != -1){
			typePath = "ICF";
			if("agree_1".equals(type)){
				saveFileName = "개인정보동의서_" + paramMap.get("usrName") + "_" + System.currentTimeMillis() + ".pdf";
			}else if("agree_2".equals(type)){
				saveFileName = "연구참여동의서_" + paramMap.get("usrName") + "_" + System.currentTimeMillis() + ".pdf";
			}
		}else{
			typePath = "SVY";
			saveFileName = "설문_" + paramMap.get("usrName") +  "_" +  System.currentTimeMillis() + ".pdf";
		}
		// PDF 파일명 ( 고객코드_파일명_시간 로 생성 )
		// saveFileName = "ubireport_" + System.currentTimeMillis() + ".pdf";
		
		saveFullPath = savePath + typePath + "/" + saveFileName;
		
		File fSavePath = new File(savePath);
		if( !fSavePath.exists() )
			fSavePath.mkdir();
		
		HashMap<String, String> hMap = new HashMap<String, String>();
 
		/* 사용자 입력 정보 */
		sb.append("---------------------------------------------").append(NL);
		sb.append("[ Input Info ]").append(NL);
		sb.append("---------------------------------------------").append(NL);
		String[] columnNames = ubiEformData.getParameterNames();
		if (columnNames != null) {
			for (i = 0; i < columnNames.length; i++) {
				EgovMap map = new EgovMap();

				String inputName = columnNames[i];
				String[] nmSpl = inputName.split("_");
				String quesNo = nmSpl[0].substring(1);
				map.put("quesNo", quesNo);

				// 라디오버튼 값 : RB로 끝나면 Radio button 의 값임
				if( inputName.lastIndexOf("RB") == (inputName.length() - 2) ) {
					// RadioBox 값은 "[,,checked,,]" 형태로 받음
					String tmp = ubiEformData.getParameter(inputName);
					tmp = tmp.substring(1);						// [ 날림
					tmp = tmp.substring(0, tmp.length() - 1);	// ]날림

					String [] value = tmp.split(",");

					boolean checkFlag = false;
					for( int j = 0; j < value.length; j++ ) {
						if( "checked".equals(value[j]) ) {
							map.put("answNum", (j+1));
							
							checkFlag = true;
							sb.append(inputName + " = " + (j+1)).append(NL);
							hMap.put(inputName, "" + (j+1));
							break;
						}
					}

					// checked가 없는 경우
					if( !checkFlag )
						hMap.put(inputName, "-1");
				}
				// 라디오버튼 이외의 값
				else {
					if(!"SIGNPAD".equals(inputName) && !"NAMEPAD".equals(inputName) && !"DATEPAD".equals(inputName)){
						map.put("answCon", ubiEformData.getParameter(inputName));
					}
					
					sb.append(inputName + " = " + ubiEformData.getParameter(inputName)).append(NL);
					hMap.put(inputName, ubiEformData.getParameter(inputName));
				}
				answList.add(map);
			}
		}

		if( useLog )
			System.out.println(sb.toString());

		sb.delete(0, sb.length());


		Set set = hMap.entrySet();
		Iterator iterator = set.iterator();
		while(iterator.hasNext()) {

			Map.Entry mentry = (Map.Entry)iterator.next();
			System.out.println("key["+ mentry.getKey() + "], Value[" + mentry.getValue() + "]");
		}


		// 파일 생성
		boolean saveResult = ubiEformData.saveFile(UbiEformData.PDF, saveFullPath);

		/* 파일 저장 결과 정보 */
		sb.append("---------------------------------------------").append(NL);
		sb.append("[ File Save Result : " + (saveResult?"Success!":"Fail!") + " ]").append(NL);
		sb.append("---------------------------------------------").append(NL);
		
		// 파일 생성 결과로 로직 생성해야함
		if( saveResult ) {
			
			ubiEformData.sendSuccess(out, "FILENAME#" + saveFullPath);
			/*
			DB 작업
			*/
			paramMap.put("filePath", "\\" + typePath + "\\" + saveFileName);
			paramMap.put("fileName", saveFileName);
			
			if(type.indexOf("agree") != -1){
				ubiTask.agreement(paramMap);
			}else{
				ubiTask.survey(paramMap, answList);
			}
		}
		else {
			
			ubiEformData.sendError(out, "파일 저장 오류");
		}

		System.out.println(sb.toString());
		sb.delete(0, sb.length());
	}
	catch (Exception e) {
		e.printStackTrace();
		try {
			if (ubiEformData != null) {
				ubiEformData.sendError(out, e.getMessage());
			}
		} catch (Exception ex) {}
	}
%>
