package ctms.usr.ecf0201;

import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Calendar;
import java.util.Date;
import java.util.List;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.View;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import component.file.CmmnFileMngUtil;
import ctms.adm.cmm.AdmCmmController;
import ctms.valueObject.Sb1000mVO;
import ctms.valueObject.cmm.CmmnSearchVO;
import egovframework.com.cmm.util.EgovUserDetailsHelper;
import egovframework.let.utl.fcc.service.EgovStringUtil;
import egovframework.rte.fdl.property.EgovPropertyService;
import egovframework.rte.psl.dataaccess.util.EgovMap;

@Controller
public class Ecf0201Controller extends AdmCmmController{

	private static final Logger LOGGER = LoggerFactory.getLogger(Ecf0201Controller.class);
	@Autowired private Ecf0201DAO ecf0201DAO;
	@Resource private CmmnFileMngUtil fileUtil;
	@Resource private View jsonView;
	
	@Resource(name = "propertiesService") protected EgovPropertyService propertyService;
 
    //질문답변관리 목록화면으로 리다이렉트합니다.
    private String redirectEcf0201List(RedirectAttributes reda, String message, CmmnSearchVO searchVO){
        reda.addFlashAttribute("message", message);
        reda.addFlashAttribute("searchVO", searchVO);
        return "redirect:/usr/ecf0201/ecf0201List.do";
    }
		
	/**
	 * 제품사용관리 목록
	 * 
	 * @param model
	 * @return 제품사용관리 목록화면
	 * @throws Exception
	 */	
	@RequestMapping("/usr/ecf0201/ecf0201List.do")
	public String ech0201List(@ModelAttribute("searchVO") CmmnSearchVO searchVO, HttpServletRequest request, ModelMap model ) throws Exception {
		LOGGER.debug("/usr/ecf0201/ecf0201List.do -  제품사용관리 목록");
		LOGGER.debug("searchVO = " + searchVO.toString());
		
		//회사코드 설정
		searchVO.setCorpCd(EgovUserDetailsHelper.getAuthenticatedCorpCd());
		
		Sb1000mVO sessionVO = (Sb1000mVO) EgovUserDetailsHelper.getAuthenticatedUser();
		searchVO.setSearchCondition1(sessionVO.getRsjNo());
		
		List<EgovMap> rsList = ecf0201DAO.selectEcf0201RsList(sessionVO);
		model.addAttribute("rsList", rsList);
		
		if(!EgovStringUtil.isEmpty(searchVO.getRsNo())){
			EgovMap timeMap = ecf0201DAO.selectEcf0201Map(searchVO);
			
			if(timeMap != null){
				Calendar cal = Calendar.getInstance();
	
				Date chkStdt = getStringByDate((String) timeMap.get("chkStdt"));
				Date chkEndt = getStringByDate((String) timeMap.get("chkEndt"));
				List<EgovMap> timeList = new ArrayList<EgovMap>();
				
				cal.setTime(chkEndt);
				while(true) {
					EgovMap map = new EgovMap();
					map.put("chkDt", getDateByString(cal.getTime(), "1"));
					map.put("chkDt2", getDateByString(cal.getTime(), "2"));
					map.put("chkDtInt", getDateByInteger(cal.getTime()));

					timeList.add(map);
		             
		            // 현재 날짜가 시작일자보다 작으면 종료 
					cal.add(Calendar.DATE, -((int) timeMap.get("chkTrm")));
		            if(getDateByInteger(cal.getTime()) < getDateByInteger(chkStdt)){
		            	break;
		            }
		        }
				model.addAttribute("timeList", timeList);
				model.addAttribute("timeMap", timeMap);
				model.addAttribute("nowDate", EgovStringUtil.getDateMinus());
				model.addAttribute("nowDateInt", getDateByInteger(getStringByDate(EgovStringUtil.getDateMinus())));
				
				List<EgovMap> resultList = ecf0201DAO.selectEcf0201List(searchVO); 
				EgovMap resultMap = new EgovMap();
				for(EgovMap map : resultList){
					resultMap.put((String) map.get("chkDt"), map);
					
				}
				model.addAttribute("resultMap", resultMap);
				model.addAttribute("resultList", resultList);
			}
		}
		
		return "/usr/ecf0201/ecf0201List";
		
	}
    
	public static int getDateByInteger(Date date) {
		SimpleDateFormat sdf = new SimpleDateFormat("yyyyMMdd");
		return Integer.parseInt(sdf.format(date));
	}
    
	public static String getDateByString(Date date, String type) {
		SimpleDateFormat sdf;
		if("1".equals(type)){
			sdf = new SimpleDateFormat("yyyy-MM-dd (E)");
		}else{
			sdf = new SimpleDateFormat("yyyy-MM-dd");
		}
		return sdf.format(date);
	}
	

    
	public static Date getStringByDate(String date) throws Exception {
		SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
		return sdf.parse(date);
	}
	
	/**
	 * 제품사용체크 저장
	 * 
	 * @param model
	 * @return 제품사용체크 저장
	 * @throws Exception
	 */	
	@RequestMapping("/usr/ecf0201/ecf0201Update.do")
	public String ecf0201Update(@ModelAttribute("searchVO") CmmnSearchVO searchVO, String chkDt, String chkNum, RedirectAttributes reda, HttpServletRequest request, ModelMap model) throws Exception {
		LOGGER.debug("/usr/ecf0201/ecf0201Update.do -  제품사용체크 저장");
		LOGGER.debug("searchVO = " + searchVO.toString());
		EgovMap paramMap = new EgovMap();
		String message = "";
		
		Sb1000mVO sessionVO = (Sb1000mVO) EgovUserDetailsHelper.getAuthenticatedUser();
		
		//회사코드 설정
		paramMap.put("corpCd", EgovUserDetailsHelper.getAuthenticatedCorpCd());
		paramMap.put("dataRegnt", sessionVO.getRsjName());
		paramMap.put("rsjNo", sessionVO.getRsjNo());
		paramMap.put("rsNo", searchVO.getRsNo());
		paramMap.put("chkNum", chkNum);
		paramMap.put("chkDt", chkDt);
		
		String duplChk = ecf0201DAO.selectEcf0201DuplChk(paramMap);
		
		if("TRUE".equals(duplChk)){
			ecf0201DAO.insertEcf0201(paramMap);
			message = "체크되었습니다.";
		}else{
			ecf0201DAO.updateEcf0201(paramMap);
			message = "체크되었습니다.";
		}
		
		ecf0201DAO.updateEcf0201ChkCnt(paramMap);
		
		return redirectEcf0201List(reda, message, searchVO);
	}

	/**
	 * 제품사용체크 특이사항 저장
	 * 
	 * @param model
	 * @return 제품사용체크 특이사항 저장
	 * @throws Exception
	 */	
	@RequestMapping("/usr/ecf0201/ecf0201RemkUpdate.do")
	public String ecf0201RemkUpdate(@ModelAttribute("searchVO") CmmnSearchVO searchVO, String chkDt, String remk, RedirectAttributes reda, HttpServletRequest request, ModelMap model) throws Exception {
		LOGGER.debug("/usr/ecf0201/ecf0201RemkUpdate.do -  제품사용체크 특이사항 저장");
		LOGGER.debug("searchVO = " + searchVO.toString());
		EgovMap paramMap = new EgovMap();
		String message = "";
		
		Sb1000mVO sessionVO = (Sb1000mVO) EgovUserDetailsHelper.getAuthenticatedUser();
		
		//회사코드 설정
		paramMap.put("corpCd", EgovUserDetailsHelper.getAuthenticatedCorpCd());
		paramMap.put("dataRegnt", sessionVO.getRsjName());
		paramMap.put("rsjNo", sessionVO.getRsjNo());
		paramMap.put("rsNo", searchVO.getRsNo());
		paramMap.put("remk", remk);
		paramMap.put("chkDt", chkDt);
		
		String duplChk = ecf0201DAO.selectEcf0201DuplChk(paramMap);
		
		if("TRUE".equals(duplChk)){
			ecf0201DAO.insertEcf0201Remk(paramMap);
			message = "저장되었습니다.";
		}else{
			ecf0201DAO.updateEcf0201Remk(paramMap);
			message = "저장되었습니다.";
		}
		
		return redirectEcf0201List(reda, message, searchVO);
	}

}
