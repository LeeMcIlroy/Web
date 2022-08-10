package hsDesign.usr.cmm;


import java.util.List;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;

import egovframework.rte.psl.dataaccess.util.EgovMap;

//@Controller
public class CmmController {
	
	private static final Logger LOGGER = LoggerFactory.getLogger(CmmController.class);
	@Autowired private CmmDAO cmmDAO;

	// 배너 목록 
	public EgovMap selectLeftBannerList(){
		LOGGER.info("/usr/banner- 사용자 > 배너");
		return cmmDAO.selectLeftBannerList();
		
	}
	
	// incleftmenu 목록 
	public List<EgovMap> selectBoardCodeList(){
		LOGGER.info("/usr/incleftMenu- 사용자 > 전공 incleftmenu");
		return cmmDAO.selectBoardCodeList();
		
	}

	//목록 태그 제거
	public List<EgovMap> replaceTag(List<EgovMap> resultList, String flag){
		LOGGER.info("게시판 목록 태그 제거");
		for (EgovMap egovMap : resultList) {
			String pattern = "<(\\/?)(?!\\/####)([^<|>]+)?>";
			String[] allowTags = "".split(",");
			
			StringBuffer buffer = new StringBuffer();
			for(int i=0; i<allowTags.length; i++){
				buffer.append("|" + allowTags[i].trim() + "(?!\\w)");
			}
			
			pattern = pattern.replace("####", buffer.toString());
			String tempContent = "";
			if(flag.equals("mb")) {
				tempContent = egovMap.get("mbContent").toString().replaceAll(pattern, "");
				egovMap.put("mbContent", tempContent);
				
			}else if(flag.equals("cb")) {
				tempContent = egovMap.get("cbContent").toString().replaceAll(pattern, "");
				egovMap.put("cbContent", tempContent);
			}else if(flag.equals("total")) {
				tempContent = egovMap.get("content").toString().replaceAll(pattern, "");
				egovMap.put("content", tempContent);
			}
				
		}
		return resultList;
	}
	
	// pdf 목록
	public List<EgovMap> selectPdfList(String pdfType){
		LOGGER.info("/usr/incleftMenu- 사용자 > pdf 목록");
		return cmmDAO.selectPdfList(pdfType);
		
	}
	
	
}
