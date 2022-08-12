package ctms.batch;

import java.io.File;
import java.text.DateFormat;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.scheduling.annotation.Scheduled;
import org.springframework.stereotype.Component;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.multipart.MultipartHttpServletRequest;
import org.springframework.web.servlet.View;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import org.apache.commons.mail.EmailException;
import org.apache.commons.mail.SimpleEmail;
import component.excel.ExcelUtil;
import component.file.CmmnFileMngUtil;
import component.file.FileInfoVO;
import component.mail.MailSendUtil;
import component.sms.SmsSendUtil;
import component.util.ComStringUtil;
import component.web.PaginationController;
import egovframework.com.cmm.util.EgovUserDetailsHelper;
import egovframework.com.utl.sim.service.EgovFileScrty;
import egovframework.let.utl.fcc.service.EgovStringUtil;
import egovframework.rte.fdl.property.EgovPropertyService;
import egovframework.rte.psl.dataaccess.util.EgovMap;
import egovframework.rte.ptl.mvc.tags.ui.pagination.PaginationInfo;
import ctms.adm.cmm.AdmCmmController;
import ctms.cmm.CmmDAO;
import ctms.valueObject.AdminVO;
import ctms.valueObject.Ct7000mVO;
import ctms.valueObject.Rm1000mVO;
import ctms.valueObject.cmm.CmmnListVO;
import ctms.valueObject.cmm.CmmnSearchVO;

@Component
public class ScheduleTask {
	
	private static final Logger LOGGER = LoggerFactory.getLogger(ScheduleTask.class);
	@Autowired private ScheduleDAO scheduleDAO;
	@Autowired private CmmDAO cmmDAO;
	@Resource private CmmnFileMngUtil fileUtil;
	@Resource private MailSendUtil mailUtil;
	//@Resource private View jsonView;
	@Resource(name = "propertiesService") protected EgovPropertyService propertyService;
	
	//이메일 예약 발송  
	@Scheduled(cron="0 0/55 * * * *")
	public void taskSendEmail() throws Exception{

		LOGGER.debug("Batch Start====================");
		//세션 호출
		//AdminVO adminVO = (AdminVO) request.getSession().getAttribute("adminSessionCtms");

		CmmnSearchVO searchVO = new CmmnSearchVO();
	
		//회사코드 설정
		searchVO.setCorpCd("HNBSRC");

		String thost = "";
		String tpassword = "";
		String tusername = "";

		//현재시간 설정
		DateFormat dateFormat = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
		Date date = new Date();        
		String dateToStr = dateFormat.format(date);
		
		//발송대상 예약이메일 조회
		CmmnListVO listVO = scheduleDAO.selectBatchMailList(searchVO);
		
		if(listVO.getTotalRecordCount() > 0) {
			//메일서버 정보 획득
			EgovMap map1 = new EgovMap();
			map1.put("corpCd", "HNBSRC");
			String mailHost = cmmDAO.selectMailHost(map1);
			String[] spmailhost = mailHost.split(",");
			thost	 = spmailhost[0].toString(); //host
			tpassword = EgovFileScrty.decode(spmailhost[1].toString()); //password
			tusername = spmailhost[2].toString(); //username
		}
	
        for(EgovMap map : listVO.getEgovList()){
        	String mapKey = (String) map.get("recmNo")+map.get("resrDt");
        	
        	//예약일시가 현재일시보다 작으면 이메일을 발송
        	String resrDate = (String) map.get("resrDate");
        	if(resrDate.compareTo(dateToStr) < 0 ) {
        		String usrEmail = (String) map.get("receEmail");
        		LOGGER.debug("usrEmail="+usrEmail);
        		String usrName = "고객님";
        		String title = (String) map.get("title");
        		LOGGER.debug("title="+title);
        		String cont = (String) map.get("cont");
        		LOGGER.debug("cont="+cont);
        		String afterPwd = ComStringUtil.createPassword(6);
        		
        		// 첨부파일 서버 저장
        	    //List<FileInfoVO> fileList = fileUtil.totUploadFiles("dddd", "MAIL");
        		
        		//List<FileInfoVO> fileList = new ArrayList();
        		//fileList.clear();
        		
        		//첨부파일을 획득한다. 폴더 EATF
        		final String UPLOAD_HOME = propertyService.getString("Globals.fileStorePath.attachedFile");
        		List<FileInfoVO> fileInfoList = new ArrayList<>();
        		
        		EgovMap mapAttach = new EgovMap();
        		mapAttach.put("boardSeq", "HNBSRC"+map.get("recmNo"));
        		mapAttach.put("boardType", "EATF");
    			List<Ct7000mVO> attachList = cmmDAO.selectAttachList(mapAttach);
          		LOGGER.debug("attachList="+attachList.toString());
    			
    			EgovMap attachMap = new EgovMap();
    			for(Ct7000mVO attach : attachList){
    				String fileName = attach.getOrgFileName(); //파일명
    				//String fileExt = fileName.substring(fileName.lastIndexOf(".")+1); // 확장자(ex> jpg | fileName.substring(fileName.lastIndexOf(".")) = .jpg);
    				//String fileNm = EgovStringUtil.getTimeStamp() + "." + fileExt;
    				String filePath = attach.getRegFileName();
    				//String filePath = File.separator + "EATF" + File.separator + fileNm;
    				
    				FileInfoVO fileInfoVO = new FileInfoVO();
    				fileInfoVO.setFileName(fileName);
    				fileInfoVO.setFilePath(filePath);
              		LOGGER.debug("fileInfoVO="+fileInfoVO.toString());
    				
    				fileInfoList.add(fileInfoVO);
    			}
        		
    			//선택한 보고서가 있으면 첨부파일에 추가한다  1 초안보고서 2 최종보고서 
    			mapAttach.put("boardSeq", map.get("rsNo")); //연구과제번호
        		mapAttach.put("boardType", "REPORT");
    			List<Ct7000mVO> attachList2 = cmmDAO.selectAttachList(mapAttach);
    			
    			EgovMap attachMap2 = new EgovMap();
    			for(Ct7000mVO attach : attachList2){
    				String fileName = attach.getOrgFileName(); //파일명
    				//String fileExt = fileName.substring(fileName.lastIndexOf(".")+1); // 확장자(ex> jpg | fileName.substring(fileName.lastIndexOf(".")) = .jpg);
    				//String fileNm = EgovStringUtil.getTimeStamp() + "." + fileExt;
    				String filePath = attach.getRegFileName();
    				//String filePath = File.separator + "EATF" + File.separator + fileNm;
    				
    				//보고서를 첨부했는지 확인한다 1 초안보고서 2 최종보고서 2개 모두 선택 가능함 
    				String mapfileNames = (String) map.get("fileNames");
    				String sp1 = "0";
    				String sp2 = "0";
    				String[] spmapfileNames = mapfileNames.split(",");
    				int spLength = spmapfileNames.length;
    				if(spLength == 1) {
    					sp1 = spmapfileNames[0].toString();
    					sp2 = "0";
    				} else {
    					if(spLength == 2) {
        					sp1 = spmapfileNames[0].toString();
        					sp2 = spmapfileNames[1].toString();
        				}
    				}
    				
    				if(sp1.equals("1")) {
    					if(attach.getFileKey().equals("draftRpt")) { //초안보고서
        					FileInfoVO fileInfoVO = new FileInfoVO();
            				fileInfoVO.setFileName(fileName);
            				fileInfoVO.setFilePath(filePath);
                      		LOGGER.debug("fileInfoVO draftRpt="+fileInfoVO.toString());
            				
            				fileInfoList.add(fileInfoVO);	
        				}	
    				}else {
    					if(sp1.equals("2")) {
    						if(attach.getFileKey().equals("finalRpt")) { //최종보고서
    	    					FileInfoVO fileInfoVO = new FileInfoVO();
    	        				fileInfoVO.setFileName(fileName);
    	        				fileInfoVO.setFilePath(filePath);
    	                  		LOGGER.debug("fileInfoVO finalRpt="+fileInfoVO.toString());
    	        				
    	        				fileInfoList.add(fileInfoVO);
    	    				}
    					}
    				}
    				
    				if(sp2.equals("1")) {
    					if(attach.getFileKey().equals("draftRpt")) { //초안보고서
        					FileInfoVO fileInfoVO = new FileInfoVO();
            				fileInfoVO.setFileName(fileName);
            				fileInfoVO.setFilePath(filePath);
                      		LOGGER.debug("fileInfoVO draftRpt="+fileInfoVO.toString());
            				
            				fileInfoList.add(fileInfoVO);	
        				}	
    				}else {
    					if(sp2.equals("2")) {
    						if(attach.getFileKey().equals("finalRpt")) { //최종보고서
    	    					FileInfoVO fileInfoVO = new FileInfoVO();
    	        				fileInfoVO.setFileName(fileName);
    	        				fileInfoVO.setFilePath(filePath);
    	                  		LOGGER.debug("fileInfoVO finalRpt="+fileInfoVO.toString());
    	        				
    	        				fileInfoList.add(fileInfoVO);
    	    				}
    					}
    				}
    			}
    			
        		mailUtil.sendEmail(usrEmail, usrName, afterPwd, title, cont, thost, tusername, tpassword, fileInfoList);
        		LOGGER.debug("Batch Mail Send O.K!====================");
 
        		String sendsCls = (String) map.get("sendsCls");
        		if(sendsCls.equals("2")) { //이메일+SMS 선택시
        			//SMS를 같이 보낸다
        			String to = (String) map.get("receNo");
        			String from = "01033550107";
        			String text = (String) map.get("smscont");
        			SmsSendUtil.sendSms(to, from, text);
          			LOGGER.debug("Batch SMS Send O.K!====================");
          		        			
        			//SMS 발송내역 등록
        			EgovMap mapSms = new EgovMap();
        			mapSms.put("corpCd", "HNBSRC");
        			mapSms.put("recsDt", map.get("recmDt")); //접수일자
        			mapSms.put("branchCd", map.get("branchCd")); //지사코드
        			mapSms.put("rsNo", map.get("rsNo"));
        			mapSms.put("tstaCls", "30");  //전송상태 30 처리완료
        			mapSms.put("tsenCls", "100");  //전송결과 100 전송완료
        			mapSms.put("sendNo", "01033550107"); //발신번호
        			mapSms.put("sendName", "에이치앤바이오"); //발신자명
        			mapSms.put("receNo", map.get("receNo")); //수신번호
        			mapSms.put("receName", "고객님"); //수신자명
        			mapSms.put("smsCls", "1"); //SMS구분 1 단문  2 장문 - 본문내용크기
        			mapSms.put("title", ""); 
        			mapSms.put("cont", map.get("smscont")); //SMS 내용
        			mapSms.put("remk", map.get("recmNo")); //메일발송번호
        			mapSms.put("sendmCls", map.get("sendmCls")); //발송구분 2 이메일+SMS
        			mapSms.put("accpDt", dateToStr); 
        			mapSms.put("sendDt", dateToStr);
        			mapSms.put("retnDt", dateToStr);        			
        			mapSms.put("rsjNo", "");
        			mapSms.put("dataRegnt", "aid");
        			
        			LOGGER.debug("mapSms.toString()="+mapSms.toString());
        		    cmmDAO.insertAjaxSaveSms(mapSms);        			
               		LOGGER.debug("Batch SMSlog insert O.K!====================");
        		}
        		
        		//발송상태를 변경한다. TSEN_CLS 900 전송대기 -> 100 전송완료
        		EgovMap map2 = new EgovMap();
        		map2.put("corpCd", "HNBSRC");
        		map2.put("recmNo", map.get("recmNo"));
        		map2.put("dataRegnt", "aid");
        		scheduleDAO.updateBatchMailTsenCls(map2);
        	}
        }
	}	
	
}
