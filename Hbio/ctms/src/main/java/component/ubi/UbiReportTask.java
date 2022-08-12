package component.ubi;

import java.io.File;
import java.util.ArrayList;
import java.util.List;

import javax.annotation.Resource;

import org.apache.pdfbox.multipdf.PDFMergerUtility;
import org.apache.pdfbox.pdmodel.PDDocument;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;

import ctms.cmm.CmmDAO;
import ctms.ubi.UbiReportDAO;
import ctms.valueObject.Cr4000mVO;
import ctms.valueObject.Ct7000mVO;
import ctms.valueObject.Rs1010mVO;
import egovframework.com.cmm.util.EgovUserDetailsHelper;
import egovframework.rte.fdl.property.EgovPropertyService;
import egovframework.rte.psl.dataaccess.util.EgovMap;

@Component("ubiTask")
public class UbiReportTask {
	
	private static final Logger LOGGER = LoggerFactory.getLogger(UbiReportTask.class);
    
	@Autowired private UbiReportDAO ubiDAO;
	@Autowired private CmmDAO cmmDAO;
	@Resource(name = "propertiesService") protected EgovPropertyService propertyService;

	/**
	 * Ubi리포트의 동의서 데이터 관리
	 * @param paramMap
	 * @throws Exception
	 */
	public void agreement(EgovMap paramMap) throws Exception {
		LOGGER.info("UbiReportUtil.agreement - ubi리포트 동의서 데이터 관리");
		
		String type = (String) paramMap.get("type");
		
		Cr4000mVO cr4000mVO = new Cr4000mVO();
		Ct7000mVO attachVO = new Ct7000mVO();
		attachVO.setBoardNo((String) paramMap.get("corpCd")+(String) paramMap.get("rsNo")+(String) paramMap.get("subNo")); //회사코드+연구과제번호+피험자선정순번
		attachVO.setRegFileName((String) paramMap.get("filePath"));
		attachVO.setOrgFileName((String) paramMap.get("fileName"));
		attachVO.setBoardType("ICF");
		
		if("agree_1".equals(type)){
			attachVO.setFileKey("prIcf");
			cr4000mVO.setPricfYn("Y");
		}else if("agree_2".equals(type)){
			attachVO.setFileKey("rsIcf");
			cr4000mVO.setRsicfYn("Y");
		}
		
		cmmDAO.insertAttachFile(attachVO);
		
		cr4000mVO.setCorpCd((String) paramMap.get("corpCd"));
		cr4000mVO.setRsNo((String) paramMap.get("rsNo"));
		cr4000mVO.setSubNo((String) paramMap.get("subNo"));
		
		int chkcnt = ubiDAO.selectAgreementCnt(cr4000mVO);
		
		if(chkcnt == 0){
			ubiDAO.insertAgreement(cr4000mVO);
		}else{ 
			ubiDAO.updateAgreement(cr4000mVO);
		}
	}
	
	/**
	 * Ubi리포트의 설문 데이터 관리
	 * @param paramMap
	 * @throws Exception
	 */
	public void survey(EgovMap paramMap, List<EgovMap> answList) throws Exception {
		LOGGER.info("UbiReportUtil.survey - ubi리포트 설문 데이터 관리");
		
		Ct7000mVO attachVO = new Ct7000mVO();
		attachVO.setBoardNo((String) paramMap.get("corpCd")+(String) paramMap.get("rsNo")+(String) paramMap.get("rsiNo")); //회사코드+연구과제번호+식별번호 
		attachVO.setRegFileName((String) paramMap.get("filePath"));
		attachVO.setOrgFileName((String) paramMap.get("fileName"));
		attachVO.setBoardType("SVY");
		if(paramMap.get("type").equals("survey_1")) { //사용성, 효능 설문 		
			attachVO.setFileKey((String) paramMap.get("tempNo")); //템플릿 작성
		}else if(paramMap.get("type").equals("survey_2")){ //연구대상자특성(피부특성)
			attachVO.setFileKey((String) paramMap.get("tempNo")); //템플릿 작성
		}else if(paramMap.get("type").equals("survey_3")){ //피부자극
			attachVO.setFileKey((String) paramMap.get("tempNo")); //템플릿 작성
		}
		else {
			if(paramMap.get("type").equals("crf")) {
				attachVO.setFileKey((String) paramMap.get("tempNo")); //템플릿 작성	
			}else {
				attachVO.setFileKey("survey"); // 사용성, 효능 설문
			}
			 
		}
		
		cmmDAO.insertAttachFile(attachVO);
		
		//CRF작성 Update
		ubiDAO.updateMkHist(paramMap);
		
		//CRF작성여부를 감지해서 최초 작성인 경우 연구상태를 RSST_CLS '20' 진행 으로 설정한다.
		EgovMap cntMap= new EgovMap();
		cntMap = ubiDAO.selectMkCnt(paramMap);
		
		int totalMkcnt = (int) cntMap.get("totalMkCnt");
		if(totalMkcnt == 1) {
			paramMap.put("rsstCls", "20");
			ubiDAO.updateRsstCls(paramMap);
		}
		
		//연구종료확인서 저장시 연구과제내 모든 피험자의 연구종료확인서 작성을 확인하여 모든 작성이 완료된 경우 
		//1.RS1010M MK_YN = 'Y'를 설정하여 작성완료 탭 목록에 표시 한다. 
		//2.연구종료확인서를 포함하여 1명의 피험자의 CRF 합치기 작업을 시행한다.
		//2.항의 작업은 CRF작성 메뉴에서 처리한다.
		
		//corpCd, rsNo, rsiNo 알 수 있다.
		EgovMap map = new EgovMap();
		map.put("corpCd", (String) paramMap.get("corpCd"));
		map.put("tempNo", (String) paramMap.get("tempNo"));
		String chkTempType = cmmDAO.selectTempType(map); 
		if(chkTempType.equals("Y")) { //연구종료확인서 작성 시 CRF합치기 작업
			
			try{
				LOGGER.debug("CRF파일 합치기(+연구종료확인서)========== ");
				
		    	EgovMap mergeMap2 = new EgovMap();	
		    	mergeMap2.put("corpCd", (String) paramMap.get("corpCd"));
				mergeMap2.put("rsNo", (String) paramMap.get("rsNo"));    		
				
		    	
	    		EgovMap mergeMap = new EgovMap();
				
				List<File> fileList = new ArrayList<>();
				List<PDDocument> docList = new ArrayList<PDDocument>();
				
	    		mergeMap.put("boardType", "SVY");
	    		mergeMap.put("rsNo", (String) paramMap.get("rsNo"));
	    		mergeMap.put("rsiNo", (String) paramMap.get("rsiNo"));
	    		List<Ct7000mVO> mergeList = cmmDAO.selectMergeFile(mergeMap);
	    		LOGGER.debug("mergeList Empty= "+mergeList.isEmpty());
	    		
	    		for(Ct7000mVO file2 : mergeList){
	    			
	    			String fileNms = (String) file2.getOrgFileName();
	        		File file1 = new File("D:/WAS_JAVA/FactCTMS_HNB/Files/upload/attach/SVY/"+ fileNms.trim() );
	        		PDDocument doc1 = PDDocument.load(file1);
	        		fileList.add(file1);
	        		LOGGER.debug("fileList add= "+file1.pathSeparator);
	        		docList.add(doc1);
	    		}       		
	    		
	    		//식별번호 설정(연구종류+식별번호)
	    		Rs1010mVO rs1010mVO = new Rs1010mVO();
	    		rs1010mVO =  cmmDAO.selectRsInfoMst(mergeMap2);
	    		String setRsiNo = rs1010mVO.getRsNo1()+rs1010mVO.getRsNo2()+'-'+(String) paramMap.get("rsiNo");
	    		LOGGER.debug("setRsiNo= "+setRsiNo);
	    		LOGGER.debug("rsiNo= "+(String) paramMap.get("rsiNo"));
				PDFMergerUtility PDFMerger = new PDFMergerUtility();
				//파일이 저장될 경로
				PDFMerger.setDestinationFileName("D:/WAS_JAVA/FactCTMS_HNB/Files/upload/attach/SVYMerge/"+setRsiNo+".pdf");
				
				for(File fileObj : fileList){
					PDFMerger.addSource(fileObj);
				}
				// PDF 병합
				PDFMerger.mergeDocuments();
				
				// 병합하고나서 각 PDF파일 닫아주기.
				for(PDDocument doc : docList){
					doc.close();
				}
				
				
			}catch(Exception e){
				
			}
		}
		
		
		//연구과제의 연구종료확인서 전체 작성여부 확인 
		//int mkFinCnt = ubiDAO.selectMkFinCnt(paramMap);
		int mkFinCnt = (int) cntMap.get("totalMkFinCnt");
		if(mkFinCnt > 0) {
			int rsiCnt = ubiDAO.selectRsiCnt(paramMap); //피험자수
			if(mkFinCnt == rsiCnt) {
				//모든 피험자의 연구종료확인서가 완료된 경우 RS1010M MK_YN = 'Y' 설정
				//모든 피험자의 연구종료확인서가 완료된 경우 RS1010M RSST_CLS = '30' 완료 설정
				ubiDAO.updateAllMkFin(paramMap);
			}
		}
		
		String checkNum = "";
		for(EgovMap answMap : answList){
			LOGGER.info("corpCd = " + paramMap.get("corpCd"));
			LOGGER.info("rsNo = " + paramMap.get("rsNo"));
			LOGGER.info("rsiNo = " + paramMap.get("rsiNo"));
			LOGGER.info("rsjNo = " + paramMap.get("rsjNo"));
			LOGGER.info("tempNo = " + paramMap.get("tempNo"));
			
			//radio combo input를 구분하자 
			answMap.put("corpCd", paramMap.get("corpCd"));
			answMap.put("rsNo", paramMap.get("rsNo"));
			answMap.put("rsiNo", paramMap.get("rsiNo"));
			answMap.put("rsjNo", paramMap.get("rsjNo"));
			answMap.put("tempNo", paramMap.get("tempNo"));
			if(answMap.get("qtype").equals("C") || answMap.get("qtype").equals("R") ) {
				answMap.put("answCon", answMap.get("answNum") );
			}
			LOGGER.info("quesNo = " + answMap.get("quesNo"));
			if(answMap.get("quesNo").equals(checkNum)) { //질문번호가 같으면 update한다. 
				ubiDAO.updateSurveyAnsw(answMap);
				checkNum = answMap.get("quesNo").toString();
			}else {
				ubiDAO.insertSurveyAnsw(answMap);
				checkNum = answMap.get("quesNo").toString();  
				LOGGER.info("checkNum insert = " + checkNum);
			}
		}
	}
	
}
