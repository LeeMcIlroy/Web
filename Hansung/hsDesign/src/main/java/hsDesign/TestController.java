package hsDesign;

import hsDesign.adm.cmm.AdmCmmController;
import hsDesign.adm.cmmBoard.AdmCmmBoardDAO;
import hsDesign.adm.majorBoard.AdmMajorBoardDAO;
import hsDesign.valueObject.CmmBoardVO;
import hsDesign.valueObject.MajorBoardVO;
import hsDesign.valueObject.cmm.CmmnSearchVO;

import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;

import component.file.CmmnFileMngUtil;
import component.file.FileInfoVO;
import egovframework.rte.psl.dataaccess.util.EgovMap;

@Controller
public class TestController extends AdmCmmController{
	
	private static final Logger LOGGER = LoggerFactory.getLogger(TestController.class);
	@Autowired private AdmMajorBoardDAO admMajorBoardDAO;
	@Autowired private AdmCmmBoardDAO admCmmBoardDAO;
	@Autowired private CmmnFileMngUtil cmmnFileMngUtil;
		
	// 목록
	@RequestMapping("/test/test.do")
	public String admMajorDigitalArtList(ModelMap model, @ModelAttribute("searchVO") CmmnSearchVO searchVO, HttpSession session, HttpServletRequest request) {
		LOGGER.info("/test/test.do - 마이그레이션용 호출 URL");
		LOGGER.debug("searchVO = "+searchVO.toString());
		
		List<EgovMap> tempList = admMajorBoardDAO.selectTest();
		System.out.println("tempList load!");
		for (EgovMap egovMap : tempList) {
			System.out.println("start!");
			String title = egovMap.get("postTitle").toString();
			String content = egovMap.get("postContent").toString();
			String date = egovMap.get("postDate").toString();
			content = test.replaceHr(content);
			content = test.replaceClose(content);
			content = test.replaceVideo(content);
			content = test.replaceImg(content);
			content = test.replaceHr2(content);
			content = content.replaceAll("src=\"http://edubank.hansung.ac.kr/wp-content/uploads/", "src=\"/showOldImage.do?filePath=");
			content = content.replaceAll("src=\"https://edubank.hansung.ac.kr/wp-content/uploads/", "src=\"/showOldImage.do?filePath=");
			content = content.replaceAll("href=\"http://edubank.hansung.ac.kr/wp-content/uploads/", "href=\"#\" alt=\"");
			content = content.replaceAll("href=\"https://edubank.hansung.ac.kr/wp-content/uploads/", "href=\"#\" alt=\"");
			content = content.replaceAll(System.getProperty("line.separator"), "<br/>");
			System.out.println("@@@@@@@@@@@@@@@@@@@@");
			System.out.println(content);
			
			MajorBoardVO majorBoardVO = new MajorBoardVO();
			majorBoardVO.setMbTitle(title);
			majorBoardVO.setMbContent(content);
			majorBoardVO.setMbRegDate(date);
			
			String termId = egovMap.get("termId").toString();
			boolean termFlag = true;
			switch (termId) {
			case "181":
				majorBoardVO.setmCode("01");
				majorBoardVO.setMbGubun1("32");
				majorBoardVO.setMbGubun2("50");
				break;
			case "177":
				majorBoardVO.setmCode("01");
				majorBoardVO.setMbGubun1("32");
				majorBoardVO.setMbGubun2("50");
				break;
			case "180":
				majorBoardVO.setmCode("01");
				majorBoardVO.setMbGubun1("32");
				majorBoardVO.setMbGubun2("49");
				break;
			case "179":
				majorBoardVO.setmCode("01");
				majorBoardVO.setMbGubun1("32");
				majorBoardVO.setMbGubun2("53");
				break;
			case "178":
				majorBoardVO.setmCode("01");
				majorBoardVO.setMbGubun1("32");
				majorBoardVO.setMbGubun2("47");
				break;
			case "176":
				majorBoardVO.setmCode("01");
				majorBoardVO.setMbGubun1("32");
				majorBoardVO.setMbGubun2("48");
				break;
			case "75":
				majorBoardVO.setmCode("01");
				majorBoardVO.setMbGubun1("32");
				majorBoardVO.setMbGubun2("46");
				break;
			case "74":
				majorBoardVO.setmCode("01");
				majorBoardVO.setMbGubun1("32");
				majorBoardVO.setMbGubun2("45");
				break;
			case "73":
				majorBoardVO.setmCode("01");
				majorBoardVO.setMbGubun1("32");
				majorBoardVO.setMbGubun2("44");
				break;
			case "72":
				majorBoardVO.setmCode("01");
				majorBoardVO.setMbGubun1("32");
				majorBoardVO.setMbGubun2("22");
				break;
			case "71":
				majorBoardVO.setmCode("01");
				majorBoardVO.setMbGubun1("33");
				majorBoardVO.setMbGubun2("19");
				break;
			case "63":
				majorBoardVO.setmCode("01");
				majorBoardVO.setMbGubun1("33");
				majorBoardVO.setMbGubun2("19");
				break;
			case "76":
				majorBoardVO.setmCode("01");
				majorBoardVO.setMbGubun1("33");
				majorBoardVO.setMbGubun2("19");
				break;
			case "99":
				majorBoardVO.setmCode("02");
				majorBoardVO.setMbGubun1("34");
				majorBoardVO.setMbGubun2("4");
				break;
			case "97":
				majorBoardVO.setmCode("02");
				majorBoardVO.setMbGubun1("34");
				majorBoardVO.setMbGubun2("6");
				break;
			case "80":
				majorBoardVO.setmCode("02");
				majorBoardVO.setMbGubun1("34");
				majorBoardVO.setMbGubun2("22");
				break;
			case "79":
				majorBoardVO.setmCode("02");
				majorBoardVO.setMbGubun1("34");
				majorBoardVO.setMbGubun2("21");
				break;
			case "78":
				majorBoardVO.setmCode("02");
				majorBoardVO.setMbGubun1("34");
				majorBoardVO.setMbGubun2("25");
				break;
			case "190":
				majorBoardVO.setmCode("02");
				majorBoardVO.setMbGubun1("34");
				majorBoardVO.setMbGubun2("23");
				break;
			case "182":
				majorBoardVO.setmCode("02");
				majorBoardVO.setMbGubun1("34");
				majorBoardVO.setMbGubun2("18");
				break;
			case "77":
				majorBoardVO.setmCode("02");
				majorBoardVO.setMbGubun1("35");
				majorBoardVO.setMbGubun2("24");
				break;
			case "65":
				majorBoardVO.setmCode("02");
				majorBoardVO.setMbGubun1("35");
				majorBoardVO.setMbGubun2("24");
				break;
			case "200":
				majorBoardVO.setmCode("03");
				majorBoardVO.setMbGubun1("36");
				majorBoardVO.setMbGubun2("6");
				break;
			case "153":
				majorBoardVO.setmCode("03");
				majorBoardVO.setMbGubun1("36");
				majorBoardVO.setMbGubun2("6");
				break;
			case "198":
				majorBoardVO.setmCode("03");
				majorBoardVO.setMbGubun1("36");
				majorBoardVO.setMbGubun2("26");
				break;
			case "199":
				majorBoardVO.setmCode("03");
				majorBoardVO.setMbGubun1("36");
				majorBoardVO.setMbGubun2("30");
				break;
			case "197":
				majorBoardVO.setmCode("03");
				majorBoardVO.setMbGubun1("36");
				majorBoardVO.setMbGubun2("29");
				break;
			case "154":
				majorBoardVO.setmCode("03");
				majorBoardVO.setMbGubun1("37");
				majorBoardVO.setMbGubun2("27");
				break;
			case "155":
				majorBoardVO.setmCode("03");
				majorBoardVO.setMbGubun1("37");
				majorBoardVO.setMbGubun2("28");
				break;
			case "143":
				majorBoardVO.setmCode("04");
				majorBoardVO.setMbGubun1("38");
				majorBoardVO.setMbGubun2("4");
				break;
			case "173":
				majorBoardVO.setmCode("04");
				majorBoardVO.setMbGubun1("38");
				majorBoardVO.setMbGubun2("32");
				break;
			case "146":
				majorBoardVO.setmCode("04");
				majorBoardVO.setMbGubun1("38");
				majorBoardVO.setMbGubun2("22");
				break;
			case "166":
				majorBoardVO.setmCode("04");
				majorBoardVO.setMbGubun1("38");
				majorBoardVO.setMbGubun2("18");
				break;
			case "147":
				majorBoardVO.setmCode("04");
				majorBoardVO.setMbGubun1("38");
				majorBoardVO.setMbGubun2("6");
				break;
			case "145":
				majorBoardVO.setmCode("04");
				majorBoardVO.setMbGubun1("38");
				majorBoardVO.setMbGubun2("25");
				break;
			case "141":
				majorBoardVO.setmCode("04");
				majorBoardVO.setMbGubun1("39");
				majorBoardVO.setMbGubun2("24");
				break;
			case "144":
				majorBoardVO.setmCode("04");
				majorBoardVO.setMbGubun1("39");
				majorBoardVO.setMbGubun2("24");
				break;
			case "193":
				majorBoardVO.setmCode("04");
				majorBoardVO.setMbGubun1("39");
				majorBoardVO.setMbGubun2("24");
				break;
			case "148":
				majorBoardVO.setmCode("04");
				majorBoardVO.setMbGubun1("39");
				majorBoardVO.setMbGubun2("35");
				break;
			case "151":
				majorBoardVO.setmCode("04");
				majorBoardVO.setMbGubun1("39");
				majorBoardVO.setMbGubun2("35");
				break;
			case "84":
				majorBoardVO.setmCode("05");
				majorBoardVO.setMbGubun1("40");
				majorBoardVO.setMbGubun2("11");
				break;
			case "183":
				majorBoardVO.setmCode("05");
				majorBoardVO.setMbGubun1("40");
				majorBoardVO.setMbGubun2("11");
				break;
			case "82":
				majorBoardVO.setmCode("05");
				majorBoardVO.setMbGubun1("40");
				majorBoardVO.setMbGubun2("10");
				break;
			case "85":
				majorBoardVO.setmCode("05");
				majorBoardVO.setMbGubun1("41");
				majorBoardVO.setMbGubun2("51");
				break;
			case "66":
				majorBoardVO.setmCode("05");
				majorBoardVO.setMbGubun1("41");
				majorBoardVO.setMbGubun2("7");
				break;
			case "83":
				majorBoardVO.setmCode("05");
				majorBoardVO.setMbGubun1("41");
				majorBoardVO.setMbGubun2("7");
				break;
			case "88":
				majorBoardVO.setmCode("06");
				majorBoardVO.setMbGubun1("42");
				majorBoardVO.setMbGubun2("29");
				break;
			case "187":
				majorBoardVO.setmCode("06");
				majorBoardVO.setMbGubun1("42");
				majorBoardVO.setMbGubun2("29");
				break;
			case "185":
				majorBoardVO.setmCode("06");
				majorBoardVO.setMbGubun1("42");
				majorBoardVO.setMbGubun2("18");
				break;
			case "184":
				majorBoardVO.setmCode("06");
				majorBoardVO.setMbGubun1("42");
				majorBoardVO.setMbGubun2("18");
				break;
			case "87":
				majorBoardVO.setmCode("06");
				majorBoardVO.setMbGubun1("43");
				majorBoardVO.setMbGubun2("16");
				break;
			case "86":
				majorBoardVO.setmCode("06");
				majorBoardVO.setMbGubun1("43");
				majorBoardVO.setMbGubun2("16");
				break;
			case "89":
				majorBoardVO.setmCode("06");
				majorBoardVO.setMbGubun1("43");
				majorBoardVO.setMbGubun2("16");
				break;
			case "186":
				majorBoardVO.setmCode("06");
				majorBoardVO.setMbGubun1("43");
				majorBoardVO.setMbGubun2("16");
				break;
			case "92":
				majorBoardVO.setmCode("07");
				majorBoardVO.setMbGubun1("44");
				majorBoardVO.setMbGubun2("15");
				break;
			case "90":
				majorBoardVO.setmCode("07");
				majorBoardVO.setMbGubun1("44");
				majorBoardVO.setMbGubun2("43");
				break;
			case "188":
				majorBoardVO.setmCode("07");
				majorBoardVO.setMbGubun1("44");
				majorBoardVO.setMbGubun2("43");
				break;
			case "174":
				majorBoardVO.setmCode("07");
				majorBoardVO.setMbGubun1("45");
				majorBoardVO.setMbGubun2("42");
				break;
			case "91":
				majorBoardVO.setmCode("07");
				majorBoardVO.setMbGubun1("45");
				majorBoardVO.setMbGubun2("42");
				break;
			case "126":
				majorBoardVO.setmCode("08");
				majorBoardVO.setMbGubun1("47");
				majorBoardVO.setMbGubun2("20");
				break;
			case "125":
				majorBoardVO.setmCode("08");
				majorBoardVO.setMbGubun1("47");
				majorBoardVO.setMbGubun2("20");
				break;
			case "123":
				majorBoardVO.setmCode("08");
				majorBoardVO.setMbGubun1("47");
				majorBoardVO.setMbGubun2("20");
				break;
			case "120":
				majorBoardVO.setmCode("08");
				majorBoardVO.setMbGubun1("47");
				majorBoardVO.setMbGubun2("20");
				break;
			case "118":
				majorBoardVO.setmCode("08");
				majorBoardVO.setMbGubun1("47");
				majorBoardVO.setMbGubun2("20");
				break;
			case "117":
				majorBoardVO.setmCode("08");
				majorBoardVO.setMbGubun1("47");
				majorBoardVO.setMbGubun2("20");
				break;
			case "116":
				majorBoardVO.setmCode("08");
				majorBoardVO.setMbGubun1("47");
				majorBoardVO.setMbGubun2("20");
				break;
			case "115":
				majorBoardVO.setmCode("08");
				majorBoardVO.setMbGubun1("47");
				majorBoardVO.setMbGubun2("20");
				break;
			case "101":
				majorBoardVO.setmCode("08");
				majorBoardVO.setMbGubun1("47");
				majorBoardVO.setMbGubun2("20");
				break;
			case "100":
				majorBoardVO.setmCode("08");
				majorBoardVO.setMbGubun1("47");
				majorBoardVO.setMbGubun2("20");
				break;
			default:
				termFlag = false;
				break;
			}
			
			if(termFlag){
				majorBoardVO.setMbOldYn("Y");
				
				String id = egovMap.get("id").toString();
				
				
				majorBoardVO.setMbRegSeq("1");
				majorBoardVO.setMbRegName("관리자");
				
				String thumbType = egovMap.get("thumbType").toString();
				boolean thumbFlag = true;
				if("image".equals(thumbType)){
					EgovMap tempMap1 = admMajorBoardDAO.selectTest3(id);
					EgovMap tempMap2 = admMajorBoardDAO.selectTest5(id);
					if(tempMap1 != null){
						String tempPath = tempMap1.get("guid").toString();
						tempPath = tempPath.replace("https://edubank.hansung.ac.kr/wp-content/uploads", "");
						tempPath = tempPath.replace("http://edubank.hansung.ac.kr/wp-content/uploads", "");
						majorBoardVO.setMbthType("IMAGE");
						majorBoardVO.setMbthImgPath(tempPath.replace("/", "\\"));
						majorBoardVO.setMbthImgName(tempPath.substring(tempPath.lastIndexOf("/")+1));
						majorBoardVO.setMbOldSeq(tempMap1.get("id").toString());
					}else if(tempMap2 != null){
						String tempPath = tempMap2.get("guid").toString();
						tempPath = tempPath.replace("https://edubank.hansung.ac.kr/wp-content/uploads", "");
						tempPath = tempPath.replace("http://edubank.hansung.ac.kr/wp-content/uploads", "");
						majorBoardVO.setMbthType("IMAGE");
						majorBoardVO.setMbthImgPath(tempPath.replace("/", "\\"));
						majorBoardVO.setMbthImgName(tempPath.substring(tempPath.lastIndexOf("/")+1));
						majorBoardVO.setMbOldSeq(tempMap2.get("id").toString());
					}else{
						thumbFlag = false;	
					}
				}else if("video".equals(thumbType)){
					EgovMap tempMap3 = admMajorBoardDAO.selectTest4(id);
					if(tempMap3 != null){
						String tempPath = tempMap3.get("guid").toString();
						tempPath = tempPath.replace("http://www.youtube.com", "https://youtu.be");
						tempPath = tempPath.replace("https://www.youtube.com", "https://youtu.be");
						tempPath = tempPath.replace("watch?", "");
						tempPath = tempPath.replace("feature=player_detailpage", "");
						tempPath = tempPath.replace("feature=player_embeded", "");
						tempPath = tempPath.replace("feature=player_embedded", "");
						tempPath = tempPath.replace("feature=youtu.be", "");
						tempPath = tempPath.replace("v=", "");
						tempPath = tempPath.replace("&", "");
						majorBoardVO.setMbthType("VIDEO");
						majorBoardVO.setMbthUrl(tempPath);
						majorBoardVO.setMbOldSeq(tempMap3.get("id").toString());
					}else{
						thumbFlag = false;
					}
				}else{
					thumbFlag = false;
				}
				
				LOGGER.debug(majorBoardVO.toString());
				
				/*List<EgovMap> attachList = admMajorBoardDAO.selectTest2(id);
				if(attachList != null){
					for (EgovMap attachMap : attachList) {
						if(attachMap.get("postMimeType").toString().contains("image")){
							String tempPath = attachMap.get("guid").toString();
							tempPath = tempPath.replace("https://edubank.hansung.ac.kr/wp-content/uploads", "");
							tempPath = tempPath.replace("http://edubank.hansung.ac.kr/wp-content/uploads", "");
							majorBoardVO.setMbSeq(null);
							majorBoardVO.setMbthType("IMAGE");
							majorBoardVO.setMbthImgPath(tempPath.replace("/", "\\"));
							majorBoardVO.setMbthImgName(tempPath.substring(tempPath.lastIndexOf("/")+1));
							majorBoardVO.setMbOldSeq(attachMap.get("id").toString());
							admMajorBoardDAO.insertMajorBoardThumbOne(majorBoardVO);
						}
					}
				}*/
				
				/*String mbSeq = admMajorBoardDAO.insertMajorBoardOne2(majorBoardVO);
				majorBoardVO.setMbSeq(mbSeq);
				if(thumbFlag){
					admMajorBoardDAO.insertMajorBoardThumbOne(majorBoardVO);
				}*/
			}
		}
		return "quickstart";
	}
	// 목록
	@RequestMapping("/test/test2.do")
	public String test2(ModelMap model, @ModelAttribute("searchVO") CmmnSearchVO searchVO, HttpSession session, HttpServletRequest request) {
		LOGGER.info("/test/tes2t.do - 마이그레이션용 호출 URL");
		LOGGER.debug("searchVO = "+searchVO.toString());
		
		List<EgovMap> tempList = admMajorBoardDAO.selectTest();
		System.out.println("tempList load!");
		for (EgovMap egovMap : tempList) {
			System.out.println("start!");
			String title = egovMap.get("postTitle").toString();
			String content = egovMap.get("postContent").toString();
			String date = egovMap.get("postDate").toString();
			content = test.replaceHr(content);
			content = test.replaceVideo2(content);
			content = test.replaceClose2(content);
			content = test.replaceClose(content);
			content = test.replaceVideo(content);
			content = test.replaceImg(content);
			content = test.replaceHr2(content);
			content = content.replaceAll("src=\"http://edubank.hansung.ac.kr/wp-content/uploads/", "src=\"/showOldImage.do?filePath=");
			content = content.replaceAll("src=\"https://edubank.hansung.ac.kr/wp-content/uploads/", "src=\"/showOldImage.do?filePath=");
			content = content.replaceAll("href=\"http://edubank.hansung.ac.kr/wp-content/uploads/", "href=\"#\" alt=\"");
			content = content.replaceAll("href=\"https://edubank.hansung.ac.kr/wp-content/uploads/", "href=\"#\" alt=\"");
			content = content.replaceAll(System.getProperty("line.separator"), "<br/>");
			System.out.println("@@@@@@@@@@@@@@@@@@@@");
			System.out.println(content);
			
			CmmBoardVO cmmBoardVO = new CmmBoardVO();
			cmmBoardVO.setCbTitle(title);
			cmmBoardVO.setCbContent(content);
			cmmBoardVO.setCbRegDate(date);
			
			String termId = egovMap.get("termId").toString();
			if(termId.contains(",")){
				termId = termId.split(",")[0];
			}
			boolean termFlag = true;
			switch (termId) {
			case "1":
				cmmBoardVO.setCbType("0601");
				break;
			case "58":
				cmmBoardVO.setCbType("0601");
				break;
			case "59":
				cmmBoardVO.setCbType("0801");
				break;
			case "15":
				cmmBoardVO.setCbType("0701");
				break;
			case "98":
				cmmBoardVO.setCbType("0701");
				break;
			default:
				termFlag = false;
				break;
			}
			System.out.println(termId+ " / "+ termFlag);
			if(termFlag){
				
				String id = egovMap.get("id").toString();
				
				
				cmmBoardVO.setRegSeq("1");
				cmmBoardVO.setRegName("관리자");
				
				String thumbType = egovMap.get("thumbType").toString();
				boolean thumbFlag = true;
				if("image".equals(thumbType)){
					EgovMap tempMap1 = admMajorBoardDAO.selectTest3(id);
					EgovMap tempMap2 = admMajorBoardDAO.selectTest5(id);
					if(tempMap1 != null){
						String tempPath = tempMap1.get("guid").toString();
						tempPath = tempPath.replace("https://edubank.hansung.ac.kr/wp-content/uploads", "/old");
						tempPath = tempPath.replace("http://edubank.hansung.ac.kr/wp-content/uploads", "/old");
						cmmBoardVO.setCbThType("IMG");
						cmmBoardVO.setCbThImgPath(tempPath.replace("/", "\\"));
						cmmBoardVO.setCbThImgName(tempPath.substring(tempPath.lastIndexOf("/")+1));
					}else if(tempMap2 != null){
						String tempPath = tempMap2.get("guid").toString();
						tempPath = tempPath.replace("https://edubank.hansung.ac.kr/wp-content/uploads", "/old");
						tempPath = tempPath.replace("http://edubank.hansung.ac.kr/wp-content/uploads", "/old");
						cmmBoardVO.setCbThType("IMG");
						cmmBoardVO.setCbThImgPath(tempPath.replace("/", "\\"));
						cmmBoardVO.setCbThImgName(tempPath.substring(tempPath.lastIndexOf("/")+1));
					}else{
						thumbFlag = false;	
					}
				}else if("video".equals(thumbType)){
					EgovMap tempMap3 = admMajorBoardDAO.selectTest4(id);
					if(tempMap3 != null){
						String tempPath = tempMap3.get("guid").toString();
						tempPath = tempPath.replace("http://www.youtube.com", "https://youtu.be");
						tempPath = tempPath.replace("https://www.youtube.com", "https://youtu.be");
						tempPath = tempPath.replace("watch?", "");
						tempPath = tempPath.replace("feature=player_detailpage", "");
						tempPath = tempPath.replace("feature=player_embeded", "");
						tempPath = tempPath.replace("feature=player_embedded", "");
						tempPath = tempPath.replace("feature=youtu.be", "");
						tempPath = tempPath.replace("v=", "");
						tempPath = tempPath.replace("&", "");
						cmmBoardVO.setCbThType("AVI");
						cmmBoardVO.setCbThUrl(tempPath);
					}else{
						thumbFlag = false;
					}
				}else{
					thumbFlag = false;
				}
				
				LOGGER.debug(cmmBoardVO.toString());
				
				/*String cbSeq = admCmmBoardDAO.cmmBoardInsert(cmmBoardVO);
				FileInfoVO fileInfoVO = new FileInfoVO();
				fileInfoVO.setFileName(cmmBoardVO.getCbThImgName());
				fileInfoVO.setFilePath(cmmBoardVO.getCbThImgPath());
				if(thumbFlag){
					if(cmmBoardVO.getCbThType().equals("IMG"));
					admCmmBoardDAO.cmmBoardThumbFileUpdate(fileInfoVO, cbSeq);
				}*/
			}
		}
		return "quickstart";
	}
	
	// 목록
	@RequestMapping("/test/test3.do")
	public String test3(ModelMap model, @ModelAttribute("searchVO") CmmnSearchVO searchVO, HttpSession session, HttpServletRequest request) {
		LOGGER.info("/test/test3.do - 마이그레이션용 호출 URL");
		LOGGER.debug("searchVO = "+searchVO.toString());
		
		List<EgovMap> tempList = admMajorBoardDAO.selectTest6();
		System.out.println("tempList load!");
		for (EgovMap egovMap : tempList) {
			System.out.println("start!");
			String seq = egovMap.get("mbSeq").toString();
			String content = egovMap.get("mbContent").toString();
			content = test.replaceAlign(content);
			content = test.replaceImgSize(content);
			System.out.println("@@@@@@@@@@@@@@@@@@@@");
			System.out.println(content);
			
			MajorBoardVO majorBoardVO = new MajorBoardVO();
			
			majorBoardVO.setMbSeq(seq);
			majorBoardVO.setMbContent(content);
			
			LOGGER.debug(majorBoardVO.toString());
			
			admMajorBoardDAO.updateImageSize(majorBoardVO);
		}
		
		List<EgovMap> tempList2 = admMajorBoardDAO.selectTest7();
		System.out.println("tempList load!");
		for (EgovMap egovMap : tempList2) {
			System.out.println("start!");
			String seq = egovMap.get("cbSeq").toString();
			String content = egovMap.get("cbContent").toString();
			content = test.replaceAlign(content);
			content = test.replaceImgSize(content);
			System.out.println("@@@@@@@@@@@@@@@@@@@@");
			System.out.println(content);
			
			CmmBoardVO paramVO = new CmmBoardVO();
			
			paramVO.setCbSeq(seq);
			paramVO.setCbContent(content);
			
			LOGGER.debug(paramVO.toString());
			
			admMajorBoardDAO.updateImageSize2(paramVO);
		}
		return "quickstart";
	}
	
	
}
