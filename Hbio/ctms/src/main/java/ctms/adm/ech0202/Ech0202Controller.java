package ctms.adm.ech0202;
 
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.List;
 
import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
 
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.View;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;
 
import ctms.valueObject.Cr2020mVO;
import ctms.valueObject.Cr2030mVO;
import ctms.valueObject.Cr2040mVO;
import ctms.valueObject.Cr2050mVO;
import ctms.valueObject.Cr2060mVO;
import ctms.valueObject.Cr2100mVO;
import component.excel.ExcelUtil;
import component.file.CmmnFileMngUtil;
import component.web.PaginationController;
import ctms.adm.cmm.AdmCmmController;
import ctms.valueObject.cmm.CmmnListVO;
import ctms.valueObject.cmm.CmmnSearchVO;
import egovframework.com.cmm.util.EgovUserDetailsHelper;
import egovframework.let.utl.fcc.service.EgovStringUtil;
import egovframework.rte.fdl.property.EgovPropertyService;
import egovframework.rte.psl.dataaccess.util.EgovMap;
import egovframework.rte.ptl.mvc.tags.ui.pagination.PaginationInfo;
 
@Controller
public class Ech0202Controller extends AdmCmmController{
 
    private static final Logger LOGGER = LoggerFactory.getLogger(Ech0202Controller.class);
    @Autowired private Ech0202DAO ech0202DAO;
    @Resource private CmmnFileMngUtil fileUtil;
    @Resource private View jsonView;
 
    @Resource(name = "propertiesService") protected EgovPropertyService propertyService;
 
    //템플릿관리 목록화면으로 리다이렉트합니다.
    private String redirectech0202List(RedirectAttributes reda, String message){
        reda.addFlashAttribute("message", message);
        return "redirect:/qxsepmny/ech0202/ech0202List.do";
    }
    
    /**
     * 템플릿관리 목록
     *
     * @param model
     * @return 템플릿관리 목록화면
     * @throws Exception
     */
    @RequestMapping("/qxsepmny/ech0202/ech0202List.do")
    public String ech0202List(@ModelAttribute("searchVO") CmmnSearchVO searchVO, HttpServletRequest request, ModelMap model ) throws Exception {
        LOGGER.debug("/qxsepmny/ech0202/ech0202List.do - 템플릿관리 목록");
        LOGGER.debug("searchVO = " + searchVO.toString());
        request.getSession().setAttribute("usrMenuNo", "101");
    	
    	List<EgovMap> typeList = cmmDAO.selectCmmCdList(EgovUserDetailsHelper.getAuthenticatedAdminCorpCd(), "CT3010");
    	model.addAttribute("typeList", typeList);
    
        PaginationInfo paginationInfo = PaginationController.getPaginationInfo(searchVO);
        CmmnListVO listVO = ech0202DAO.selectech0202List(searchVO);
        paginationInfo.setTotalRecordCount(listVO.getTotalRecordCount());
    
        model.addAttribute("resultList", listVO.getEgovList());
        model.addAttribute("paginationInfo", paginationInfo);
        model.addAttribute("totalCount", paginationInfo.getTotalRecordCount());
    
        return "/adm/ech0202/ech0202List";
    }
    
    /**
     * 템플릿관리 조회
     *
     * @param model
     * @return 템플릿관리 조회화면
     * @throws Exception
     */
    
    @RequestMapping("/qxsepmny/ech0202/ech0202View.do")
    public String ech0202View(@ModelAttribute("searchVO") CmmnSearchVO searchVO, String tempNo, HttpServletRequest request, ModelMap model, RedirectAttributes reda) throws Exception {
        LOGGER.debug("/qxsepmny/ech0202/ech0202View.do - 템플릿관리 조회");
        LOGGER.debug("tempNo1 = " + tempNo);
        LOGGER.debug("tempNo2 = " + tempNo);
       
       Cr2020mVO resultVO = new Cr2020mVO();
    
        if(!EgovStringUtil.isEmpty(tempNo)){
        	EgovMap paramMap = new EgovMap();
        	paramMap.put("corpCd", EgovUserDetailsHelper.getAuthenticatedAdminCorpCd());
        	paramMap.put("tempNo", tempNo);
            resultVO = ech0202DAO.selectech0202View(paramMap);
            
            List<EgovMap> cr2050List = ech0202DAO.selectEch0202QuesList(paramMap);
            model.addAttribute("cr2050List", cr2050List);
            
            EgovMap resultMap = new EgovMap();
            for(EgovMap map : cr2050List){
            	String quesNo = (String) map.get("quesNo");
            	paramMap.put("quesNo", quesNo);
	            List<EgovMap> cr2060List = ech0202DAO.selectEch0202AnswList(paramMap);
	            resultMap.put(quesNo, cr2060List);
            }
            model.addAttribute("cr2060Map", resultMap);
        }else{
            String message = "존재하지 않는 템플릿관리입니다.";
            return redirectech0202List(reda, message);
        }
 
        model.addAttribute("cr2020mVO", resultVO);
 
        return "/adm/ech0202/ech0202View";
    }

    /**
     * 템플릿관리 팝업
     *
     * @param model
     * @return 템플릿관리 팝업화면
     * @throws Exception
     */
    @RequestMapping("/qxsepmny/ech0202/ech0202Pop.do")
    public String ech0202Pop(@ModelAttribute("searchVO") CmmnSearchVO searchVO, String tempNo, HttpServletRequest request, ModelMap model, RedirectAttributes reda) throws Exception {
    	LOGGER.debug("/qxsepmny/ech0202/ech0202Pop.do - 템플릿관리 팝업");
    	LOGGER.debug("tempNo = " + tempNo);
    	
    	Cr2020mVO resultVO = new Cr2020mVO();
    	
    	if(!EgovStringUtil.isEmpty(tempNo)){
    		EgovMap paramMap = new EgovMap();
    		paramMap.put("corpCd", EgovUserDetailsHelper.getAuthenticatedAdminCorpCd());
    		paramMap.put("tempNo", tempNo);
    		resultVO = ech0202DAO.selectech0202View(paramMap);
    		
    		List<EgovMap> cr2050List = ech0202DAO.selectEch0202QuesList(paramMap);
    		model.addAttribute("cr2050List", cr2050List);
    		
    		EgovMap resultMap = new EgovMap();
    		for(EgovMap map : cr2050List){
    			String quesNo = (String) map.get("quesNo");
    			paramMap.put("quesNo", quesNo);
    			List<EgovMap> cr2060List = ech0202DAO.selectEch0202AnswList(paramMap);
    			resultMap.put(quesNo, cr2060List);
    		}
    		model.addAttribute("cr2060Map", resultMap);
    	}else{
    		String message = "존재하지 않는 템플릿관리입니다.";
    		return redirectech0202List(reda, message);
    	}
    	
    	model.addAttribute("cr2020mVO", resultVO);
    	
    	return "/adm/ech0202/ech0202Pop";
    }
 
    /**
     * 템플릿관리 수정&등록화면
     *
     * @param model
     * @return 템플릿관리 수정&등록화면
     * @throws Exception
     */
    @RequestMapping("/qxsepmny/ech0202/ech0202Modify.do")
    public String ech0202Modify(@ModelAttribute("searchVO") CmmnSearchVO searchVO, String tempNo, HttpServletRequest request, ModelMap model ) throws Exception {
        LOGGER.debug("/qxsepmny/ech0202/ech0202Modify.do - 템플릿관리 수정&등록화면");
        LOGGER.debug("tempNo = " + tempNo);
    	
    	List<EgovMap> typeList = cmmDAO.selectCmmCdList(EgovUserDetailsHelper.getAuthenticatedAdminCorpCd(), "CT3010");
    	model.addAttribute("typeList", typeList);
        
    	EgovMap paramMap = new EgovMap();
    	paramMap.put("corpCd", EgovUserDetailsHelper.getAuthenticatedAdminCorpCd());
        
        List<EgovMap> cr2030mList = ech0202DAO.selectCr2030mList(paramMap);
        model.addAttribute("cr2030mList", cr2030mList);
        
        Cr2020mVO resultVO = new Cr2020mVO();
        resultVO.setStDate(EgovStringUtil.getDateMinus());
        resultVO.setEdDate("9999-12-31");
        
        if(!EgovStringUtil.isEmpty(tempNo)){
        	paramMap.put("tempNo", tempNo);
            resultVO = ech0202DAO.selectech0202View(paramMap);
            
            List<EgovMap> cr2050List = ech0202DAO.selectEch0202QuesList(paramMap);
            model.addAttribute("cr2050List", cr2050List);
            
            EgovMap resultMap = new EgovMap();
            for(EgovMap map : cr2050List){
            	String quesNo = (String) map.get("quesNo");
            	paramMap.put("quesNo", quesNo);
	            List<EgovMap> cr2060List = ech0202DAO.selectEch0202AnswList(paramMap);
	            resultMap.put(quesNo, cr2060List);
            }
            model.addAttribute("cr2060Map", resultMap);
        }
        
        model.addAttribute("cr2020mVO", resultVO);
 
        return "/adm/ech0202/ech0202Modify";
    }
    
    /**
     * 템플릿관리 수정&등록
     *
     * @param model
     * @return 템플릿관리 수정&등록
     * @throws Exception
     */
    @RequestMapping("/qxsepmny/ech0202/ech0202Update.do")
    public String ech0202Update(@ModelAttribute("cr2020mVO") Cr2020mVO cr2020mVO, Cr2100mVO cr2100mVO, HttpServletRequest request, ModelMap model, RedirectAttributes reda) throws Exception {
        LOGGER.debug("/qxsepmny/ech0202/ech0202Update.do - 템플릿관리 수정&등록");
        LOGGER.debug("cr2020mVO = " + cr2020mVO.toString());
        String message = "";
        String tempNo = "";
        cr2020mVO.setCorpCd(EgovUserDetailsHelper.getAuthenticatedAdminCorpCd());
    
        if(EgovStringUtil.isEmpty(cr2020mVO.getTempNo())){
        	
        	cr2020mVO.setRegDt(EgovStringUtil.getDateMinus());
        	cr2020mVO.setStDate(cr2020mVO.getStDate());
        	cr2020mVO.setEdDate("9999-12-31");
        	tempNo = ech0202DAO.insertech0202(cr2020mVO);
        	LOGGER.debug("cr2020mVO2 = " + cr2020mVO.toString());
        	
        	//CR2100M 등록한다. tempNo
        	cr2100mVO.setCorpCd(EgovUserDetailsHelper.getAuthenticatedAdminCorpCd());
        	cr2100mVO.setTempNo1("CRF");
        	cr2100mVO.setTempNo(tempNo);
        	cr2100mVO.setRegDt(EgovStringUtil.getDateMinus());
        	cr2100mVO.setEmpNo(EgovUserDetailsHelper.getAuthenticatedAdminEmpNo());
        	//if(cr2020mVO.getTempType().equals("1010")) { //사용성 설문
        		//if(cr2020mVO.getTermType().equals("1")) { //사전
        			//cr2100mVO.setTempType("4010");
        		//}else if(cr2020mVO.getTermType().equals("2")) { //사후
        			//cr2100mVO.setTempType("4110");
        		//}        			
        	//}else if(cr2020mVO.getTempType().equals("1020")) { //효능 설문
        		//if(cr2020mVO.getTermType().equals("1")) { //사전
        			//cr2100mVO.setTempType("4020");
        		//}else if(cr2020mVO.getTermType().equals("2")) { //사후
        			//cr2100mVO.setTempType("4120");
        		//}
        	//}else if(cr2020mVO.getTempType().equals("1030")) { //연구자대상자특성 설문
        		//cr2100mVO.setTempType("4000");	
        	//}
        	
        	// 사용성, 효능 - 사전 사후 없이 각각 1개로 설정
        	if(cr2020mVO.getTempType().equals("1010")) { //사용성 설문
    			cr2100mVO.setTempType("4010");
    		}else if(cr2020mVO.getTempType().equals("1020")) { //효능 설문
    		    cr2100mVO.setTempType("4020");
    		}else if(cr2020mVO.getTempType().equals("1030")) { //연구자대상자특성 설문
    			cr2100mVO.setTempType("4000");	
    		}
        	
        	cr2100mVO.setUseYn("Y");
        	cr2100mVO.setStDate(cr2020mVO.getStDate());
        	cr2100mVO.setEdDate("9999-12-31");
        	cr2100mVO.setTempNm(cr2020mVO.getTempNm());
        	cr2100mVO.setRemk(cr2020mVO.getTempNm());
        	cr2100mVO.setUpageCnt("1");
        	cr2100mVO.setMkType("1");
        	cr2100mVO.setBranchCd(EgovUserDetailsHelper.getAuthenticatedAdminBranchCd());
        	cr2100mVO.setDataRegnt(EgovUserDetailsHelper.getAuthenticatedAdminId());
        	
        	ech0202DAO.insertEch0202CrfTemplete(cr2100mVO);
        	        	
            message = "등록이 완료되었습니다.";
        }else{
        	tempNo = cr2020mVO.getTempNo();
            ech0202DAO.updateech0202(cr2020mVO);

            //CRF 템플릿 업데이트
            cr2100mVO.setCorpCd(cr2020mVO.getCorpCd());
            cr2100mVO.setTempNo(cr2020mVO.getTempNo());
            cr2100mVO.setTempNm(cr2020mVO.getTempNm());
            cr2100mVO.setUseYn(cr2020mVO.getUseYn());
            ech0202DAO.updateEch0202CrfTemp(cr2100mVO);

        	EgovMap paramMap = new EgovMap();
        	paramMap.put("corpCd", EgovUserDetailsHelper.getAuthenticatedAdminCorpCd());
        	paramMap.put("tempNo", tempNo);
        	ech0202DAO.deleteech0202Answ(paramMap);
        	ech0202DAO.deleteech0202Ques(paramMap);
            
            message = "수정이 완료되었습니다.";
        }
        
        List<Cr2050mVO> cr2050VOList = cr2020mVO.getCr2050mVOList();
        
        if(cr2050VOList != null && cr2050VOList.size() != 0){
            for(Cr2050mVO cr2050mVO : cr2050VOList){
            	if(cr2050mVO != null){
            		if(!cr2050mVO.getQuesCon().equals("")) {
            			
		            	cr2050mVO.setTempNo(tempNo);
		            	cr2050mVO.setCorpCd(EgovUserDetailsHelper.getAuthenticatedAdminCorpCd());
		            	String quesNo = ech0202DAO.insertech0202Ques(cr2050mVO);
		            	List<Cr2060mVO> cr2060VOList = cr2050mVO.getCr2060mVOList();
		
		                int answSort = 0;
		                if(cr2060VOList != null && cr2060VOList.size() != 0){
		                	for(Cr2060mVO cr2060mVO : cr2060VOList){
		                		cr2060mVO.setCorpCd(EgovUserDetailsHelper.getAuthenticatedAdminCorpCd());
		                		cr2060mVO.setTempNo(tempNo);
		                		cr2060mVO.setQuesNo(quesNo);
		                		cr2060mVO.setAnswSort(String.valueOf(answSort));
		                		ech0202DAO.insertech0202Answ(cr2060mVO);
		                    	
		                    	answSort++;
		                	}
		                }
            		}   
            	}
            }
        }
        
        return redirectech0202List(reda, message);
    }
    
    
    /**
     * 템플릿관리 삭제
     *
     * @param model
     * @return 템플릿관리 삭제
     * @throws Exception
     */
    @RequestMapping("/qxsepmny/ech0202/ech0202Delete.do")
    public String ech0202Delete(@ModelAttribute("cr2020mVO") Cr2020mVO cr2020mVO, HttpServletRequest request, ModelMap model, RedirectAttributes reda) throws Exception {
        LOGGER.debug("/qxsepmny/ech0202/ech0202Delete.do - 템플릿관리 삭제");
        LOGGER.debug("cr2020mVO = " + cr2020mVO.toString());
        String message = "존재하지 않는 템플릿입니다.";
       
        if(!EgovStringUtil.isEmpty(cr2020mVO.getTempNo())){
            ech0202DAO.deleteech0202(cr2020mVO.getTempNo());
            
        	EgovMap paramMap = new EgovMap();
        	paramMap.put("corpCd", EgovUserDetailsHelper.getAuthenticatedAdminCorpCd());
        	paramMap.put("tempNo", cr2020mVO.getTempNo());
        	ech0202DAO.deleteech0202Ques(paramMap);
            ech0202DAO.deleteech0202Answ(paramMap);
    
            message = "해당 템플릿관리의 삭제가 완료되었습니다.";
        }
 
        return redirectech0202List(reda, message);
    }

    /**
     * 템플릿관리 복사
     *
     * @param model
     * @return 템플릿관리 복사
     * @throws Exception
     */
    @RequestMapping("/qxsepmny/ech0202/ech0202Copy.do")
    public String ech0202Copy(@ModelAttribute("searchVO") CmmnSearchVO searchVO, Cr2020mVO cr2020mVO, Cr2100mVO cr2100mVO, String tempNo, HttpServletRequest request, ModelMap model, RedirectAttributes reda) throws Exception {
    	LOGGER.debug("/qxsepmny/ech0202/ech0202Copy.do - 템플릿관리 삭제");
    	LOGGER.debug("tempNo = " + tempNo);
    	String message = "존재하지 않는 템플릿입니다.";
    	
    	if(!EgovStringUtil.isEmpty(tempNo)){
    		EgovMap paramMap = new EgovMap();
    		paramMap.put("corpCd", EgovUserDetailsHelper.getAuthenticatedAdminCorpCd());
    		paramMap.put("tempNo", tempNo);    		
    		
    		// 오늘일자 yyyy-MM-DD 형식
    		SimpleDateFormat dateFormat = new SimpleDateFormat ( "yyyy-MM-dd");    				
    		Date time = new Date();    				
    		String regDt = dateFormat.format(time);
    		
    		paramMap.put("regDt", regDt);
    		
    		// 새로운 템플릿번호 TEMP_NO는 CR2100M 기준으로 생성  
    		String newTempNo = ech0202DAO.insertEch0202Copy(paramMap);
    		LOGGER.debug("newTempNo = " + newTempNo);
   		
            cr2020mVO = ech0202DAO.selectech0202View(paramMap);    		

    		//CR2100M CRF템플릿 등록
    		//CR2100M 등록한다. tempNo
        	cr2100mVO.setCorpCd(EgovUserDetailsHelper.getAuthenticatedAdminCorpCd());
        	cr2100mVO.setTempNo1("CRF");
        	cr2100mVO.setTempNo(newTempNo);
        	cr2100mVO.setRegDt(EgovStringUtil.getDateMinus());
        	cr2100mVO.setEmpNo(EgovUserDetailsHelper.getAuthenticatedAdminEmpNo());
        	
        	// 사용성, 효능 - 사전 사후 없이 각각 1개로 설정
        	if(cr2020mVO.getTempType().equals("1010")) { //사용성 설문
    			cr2100mVO.setTempType("4010");
    		}else if(cr2020mVO.getTempType().equals("1020")) { //효능 설문
    		    cr2100mVO.setTempType("4020");
    		}else if(cr2020mVO.getTempType().equals("1030")) { //연구자대상자특성 설문
    			cr2100mVO.setTempType("4000");	
    		}
        	
        	cr2100mVO.setUseYn("Y");
        	cr2100mVO.setStDate(cr2020mVO.getStDate());
        	cr2100mVO.setEdDate("9999-12-31");
        	cr2100mVO.setTempNm(cr2020mVO.getTempNm());
        	cr2100mVO.setRemk(cr2020mVO.getTempNm());
        	cr2100mVO.setUpageCnt("1");
        	cr2100mVO.setMkType("1");
        	cr2100mVO.setBranchCd(EgovUserDetailsHelper.getAuthenticatedAdminBranchCd());
        	cr2100mVO.setDataRegnt(EgovUserDetailsHelper.getAuthenticatedAdminId());
        	
        	ech0202DAO.insertEch0202CrfTemplete(cr2100mVO);
    		
    		List<EgovMap> cr2050List = ech0202DAO.selectEch0202QuesList(paramMap);
            
            for(EgovMap map : cr2050List){
            	Cr2050mVO cr2050mVO = new Cr2050mVO(map);
            	cr2050mVO.setTempNo(newTempNo);
            	
            	String quesNo = ech0202DAO.insertech0202Ques(cr2050mVO);
            	LOGGER.debug("quesNo = " + quesNo);
            	
            	paramMap.put("quesNo", map.get("quesNo"));
	            List<EgovMap> cr2060List = ech0202DAO.selectEch0202AnswList(paramMap);
	            
	            
	            for(EgovMap cr2060Map : cr2060List){
	            	Cr2060mVO cr2060mVO = new Cr2060mVO(cr2060Map);
	            	cr2060mVO.setTempNo(newTempNo);
	            	cr2060mVO.setQuesNo(quesNo);
	            	
	            	ech0202DAO.insertech0202Answ(cr2060mVO);
	            }
            }
    		
    		
    		message = "템플릿이 복사되었습니다.";
    	}
    	
    	return redirectech0202List(reda, message);
    }
    
    /**
     * 템플릿관리 엑셀다운로드
     *
     * @param model
     * @return 템플릿관리 엑셀다운로드
     * @throws Exception
     */
    @SuppressWarnings("unchecked")
    @RequestMapping("/qxsepmny/ech0202/ech0202Excel.do")
    public void ech0202Excel(@ModelAttribute("searchVO") CmmnSearchVO searchVO, HttpServletRequest request, HttpServletResponse response, RedirectAttributes reda, ModelMap model) throws Exception {
        LOGGER.debug("/qxsepmny/entran/ech0202Excel.do - 템플릿관리 엑셀 다운로드");
        LOGGER.debug("searchVO = " + searchVO.toString());
       
        EgovMap dataMap = new EgovMap();
       
        List<EgovMap> resultList = ech0202DAO.selectech0202Excel(searchVO);
        dataMap.put("resultList", resultList);
       
        int num = 1;
        for (EgovMap egovMap : resultList) {
            egovMap.put("number", num);
            num++;
        }
       
        /*AdminVO sessionVO = (AdminVO) EgovUserDetailsHelper.getAuthenticatedAdmin();
        dataMap.put("printUser", sessionVO.getName());*/
       
        ExcelUtil excelUtil = new ExcelUtil();
        excelUtil.getPerformanceExcel(dataMap, "템플릿관리 리스트", "ech0202", request, response);
    }
    
    /**
     * 템플릿관리 질문/답변 조회
     *
     * @param model
     * @return 템플릿관리 질문/답변 조회
     * @throws Exception
     */
    @RequestMapping("/qxsepmny/ech0202/ajaxSelectQues.do")
    public View ajaxSelectQues(String quesNo, HttpServletRequest request, ModelMap model ) throws Exception {
        LOGGER.debug("/qxsepmny/ech0202/ajaxSelectQues.do - 템플릿관리 질문/답변 조회");
        LOGGER.debug("quesNo = " + quesNo);
        String result = "false";
        
        if(!EgovStringUtil.isEmpty(quesNo)){
        	EgovMap paramMap = new EgovMap();
    		paramMap.put("corpCd", EgovUserDetailsHelper.getAuthenticatedAdminCorpCd());
    		paramMap.put("quesNo", quesNo);
    		
    		Cr2030mVO cr2030mVO = ech0202DAO.ajaxSelectQues(paramMap);
    		model.addAttribute("cr2030mVO", cr2030mVO);
    		
    		List<Cr2040mVO> cr2040mList = ech0202DAO.ajaxSelectAnswList(paramMap);
    		model.addAttribute("cr2040mList", cr2040mList);
    		
    		result = "true";
        }else{
        	result = "false";
        }
        
        model.addAttribute("result", result);
    
        return jsonView;
    }
}