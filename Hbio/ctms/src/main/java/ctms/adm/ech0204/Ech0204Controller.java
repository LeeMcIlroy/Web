package ctms.adm.ech0204;
 
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

import ctms.valueObject.AdminVO;
import ctms.valueObject.Cr1000mVO;
import ctms.valueObject.Ct7000mVO;
import ctms.valueObject.Rs1000mVO;
import component.excel.ExcelUtil;
import component.file.CmmnFileMngUtil;
import component.web.PaginationController;
import ctms.adm.cmm.AdmCmmController;
import ctms.cmm.CmmDAO;
import ctms.valueObject.cmm.CmmnListVO;
import ctms.valueObject.cmm.CmmnSearchVO;
import egovframework.com.cmm.util.EgovUserDetailsHelper;
import egovframework.let.utl.fcc.service.EgovStringUtil;
import egovframework.rte.fdl.property.EgovPropertyService;
import egovframework.rte.psl.dataaccess.util.EgovMap;
import egovframework.rte.ptl.mvc.tags.ui.pagination.PaginationInfo;
 
@Controller
public class Ech0204Controller extends AdmCmmController{
 
    private static final Logger LOGGER = LoggerFactory.getLogger(Ech0204Controller.class);
    @Autowired private Ech0204DAO ech0204DAO;
	@Autowired private CmmDAO cmmDAO;
    @Resource private CmmnFileMngUtil fileUtil;
    @Resource private View jsonView;
 
    @Resource(name = "propertiesService") protected EgovPropertyService propertyService;
 
    //피부특성관리 목록화면으로 리다이렉트합니다.
    private String redirectech0204List(RedirectAttributes reda, String message){
        reda.addFlashAttribute("message", message);
        return "redirect:/qxsepmny/ech0204/ech0204List.do";
    }
    
    //피부특성관리 수정&등록화면으로 리다이렉트합니다.
    private String redirectech0204Modify(RedirectAttributes reda, CmmnSearchVO searchVO){
    	reda.addFlashAttribute("searchVO", searchVO);
    	return "redirect:/qxsepmny/ech0204/ech0204Modify.do";
    }
    
    /**
     * 피부특성관리 목록
     *
     * @param model
     * @return 피부특성관리 목록화면
     * @throws Exception
     */
    @RequestMapping("/qxsepmny/ech0204/ech0204List.do")
    public String ech0204List(@ModelAttribute("searchVO") CmmnSearchVO searchVO, HttpServletRequest request, ModelMap model ) throws Exception {
        LOGGER.debug("/qxsepmny/ech0204/ech0204List.do - 피부특성관리 목록");
        LOGGER.debug("searchVO = " + searchVO.toString());
        //request.getSession().setAttribute("usrMenuNo", "101");
        
        //세션 호출
  		AdminVO adminVO = (AdminVO) request.getSession().getAttribute("adminSessionCtms");
  		
  		//엑셀다운로드 권한 설정 Y 허용  N 허용안함 
  		model.addAttribute("exauth", adminVO.getExauth());
      		
        //회사코드 설정
      	searchVO.setCorpCd(EgovUserDetailsHelper.getAuthenticatedAdminCorpCd());
        
        //연도목록
  		List<String> yearList = cmmDAO.selectYearList();
  		model.addAttribute("yearList", yearList);
  		
  		//소속지사 설정 - 소속지사가 설정되면 해당 지사의 연구계획서 목록만 표시 
		//관리자인 경우 소속지사를 설정하지 않는다 1:관리자권한 2:일반사용자권한
		if(adminVO.getAdminType().equals("2")) { 
			searchVO.setBranchCd(adminVO.getBranchCd());
			searchVO.setSearchCondition7(adminVO.getBranchCd());
			}
		if(!EgovStringUtil.isEmpty(searchVO.getSearchCondition7())){
			searchVO.setBranchCd(searchVO.getSearchCondition7()); 
		}
  		
  		EgovMap map = new EgovMap();
		
		map.put("searchYear", searchVO.getSearchYear());
		map.put("corpCd", EgovUserDetailsHelper.getAuthenticatedAdminCorpCd());
        
  		List<EgovMap> yearRsCdList = cmmDAO.selectCmmYearRsCdList2(map);
  		model.addAttribute("yearRsCdList", yearRsCdList);
  		//연구상태(공통코드) 목록 searchCondition5
  		List<EgovMap> ct2050 = cmmDAO.selectCmmCdList(searchVO.getCorpCd(), "CT2050");
  		model.addAttribute("ct2050", ct2050);
  		  		
        List<EgovMap> stateList = cmmDAO.selectCmmCdList(searchVO.getCorpCd(), "CM1350");
        model.addAttribute("stateList", stateList);
    
        PaginationInfo paginationInfo = PaginationController.getPaginationInfo(searchVO);
        CmmnListVO listVO = ech0204DAO.selectech0204List(searchVO);
        paginationInfo.setTotalRecordCount(listVO.getTotalRecordCount());
    
        model.addAttribute("resultList", listVO.getEgovList());
        model.addAttribute("paginationInfo", paginationInfo);
        model.addAttribute("totalCount", paginationInfo.getTotalRecordCount());
    
        return "/adm/ech0204/ech0204List";
    }
    
    /**
     * 피부특성관리 조회
     *
     * @param model
     * @return 피부특성관리 조회화면
     * @throws Exception
     */
    @RequestMapping("/qxsepmny/ech0204/ech0204View.do")
    public String ech0204View(@ModelAttribute("searchVO") CmmnSearchVO searchVO, String rsNo, Rs1000mVO rs1000mVO, HttpServletRequest request, ModelMap model, RedirectAttributes reda) throws Exception {
        LOGGER.debug("/qxsepmny/ech0204/ech0204View.do - 피부특성관리 조회");
        LOGGER.debug("rsNo = " + rsNo);
       
        // Rs1000mVO resultVO = new Rs1000mVO();
    
        if(!EgovStringUtil.isEmpty(rsNo)){
        	EgovMap paramMap = new EgovMap();
        	paramMap.put("corpCd", EgovUserDetailsHelper.getAuthenticatedAdminCorpCd());
        	paramMap.put("rsNo", rsNo);
            //resultVO = ech0204DAO.selectech0204View(paramMap);
        	rs1000mVO = ech0204DAO.selectech0204View(paramMap);
            LOGGER.debug("rs1000mVO = " + rs1000mVO.toString());
            
            List<EgovMap> eCrfList = ech0204DAO.selectEch0204eCrfList(paramMap);
            model.addAttribute("eCrfList", eCrfList);
            
            if(eCrfList == null || eCrfList.size() == 0){
            	redirectech0204Modify(reda, searchVO);
            }
            
            List<EgovMap> tempList = ech0204DAO.selectEch0204TempList(paramMap);
            model.addAttribute("tempList", tempList);
            
            if(eCrfList != null && eCrfList.size() != 0) {
            	paramMap.put("tempNo", eCrfList.get(0).get("tempNo"));
            }
            
            List<EgovMap> resultList = ech0204DAO.selectEch0204MemList(paramMap);
            model.addAttribute("resultList", resultList);
            
            //피부특성 첨부파일 확인시작 - 마스터 list에서 mapKey를 만들어야 한다
    		//mapKey 영문자는 소문자로 만들어짐 
    		EgovMap paramMap1 = new EgovMap();        
            EgovMap resultMap = new EgovMap();

            for(EgovMap map1 : resultList){
            	String mapKey = (String) map1.get("corpCd")+map1.get("rsNo")+map1.get("rsiNo");
            	LOGGER.debug("mapKey="+(String) map1.get("mapKey"));
            	paramMap1.put("boardSeq", mapKey);
            	
               	paramMap1.put("boardType", "SVY");
               	paramMap1.put("fileKey", "survey_1");
               	List<Ct7000mVO> attachList = cmmDAO.selectAttachListFileKey(paramMap1);
                resultMap.put(mapKey, attachList);
                LOGGER.debug("resultMap = " + resultMap.toString());
            }
            model.addAttribute("mtList", resultMap);
    		//피부특성 첨부파일 확인 끝            
        }else{
            String message = "존재하지 않는 피부특성관리입니다.";
            return redirectech0204List(reda, message);
        }
 
        model.addAttribute("rs1000mVO", rs1000mVO);
        model.addAttribute("searchVO", searchVO);
 
        return "/adm/ech0204/ech0204View";
    }
 
    /**
     * 피부특성관리 수정&등록화면
     *
     * @param model
     * @return 피부특성관리 수정&등록화면
     * @throws Exception
     */
    @RequestMapping("/qxsepmny/ech0204/ech0204Modify.do")
    public String ech0204Modify(@ModelAttribute("searchVO") CmmnSearchVO searchVO, String rsNo, HttpServletRequest request, ModelMap model ) throws Exception {
        LOGGER.debug("/qxsepmny/ech0204/ech0204Modify.do - 피부특성관리 수정&등록화면");
        LOGGER.debug("rsNo = " + rsNo);
    	
    	List<EgovMap> typeList = cmmDAO.selectCmmCdList(EgovUserDetailsHelper.getAuthenticatedAdminCorpCd(), "CT3010");
    	model.addAttribute("typeList", typeList);
       
        Rs1000mVO resultVO = new Rs1000mVO();
    
        if(!EgovStringUtil.isEmpty(rsNo)){
        	EgovMap paramMap = new EgovMap();
        	paramMap.put("corpCd", EgovUserDetailsHelper.getAuthenticatedAdminCorpCd());
        	paramMap.put("rsNo", rsNo);
            resultVO = ech0204DAO.selectech0204View(paramMap);
            
            List<EgovMap> eCrfList = ech0204DAO.selectEch0204eCrfList(paramMap);
            model.addAttribute("eCrfList", eCrfList);
            
            List<EgovMap> tempList = ech0204DAO.selectEch0204TempList(paramMap);
            model.addAttribute("tempList", tempList);
        }
 
        model.addAttribute("rs1000mVO", resultVO);
        
        List<EgovMap> stateList = cmmDAO.selectCmmCdList(EgovUserDetailsHelper.getAuthenticatedAdminCorpCd(), "CM1350");
        model.addAttribute("stateList", stateList);
 
        return "/adm/ech0204/ech0204Modify";
    }
    
    /**
     * 피부특성관리 수정&등록
     *
     * @param model
     * @return 피부특성관리 수정&등록
     * @throws Exception
     */
    @RequestMapping("/qxsepmny/ech0204/ech0204Update.do")
    public String ech0204Update(@ModelAttribute("rs1000mVO") Rs1000mVO rs1000mVO, HttpServletRequest request, ModelMap model, RedirectAttributes reda) throws Exception {
        LOGGER.debug("/qxsepmny/ech0204/ech0204Update.do - 피부특성관리 수정&등록");
        LOGGER.debug("rs1000mVO = " + rs1000mVO.toString());
        String message = "";
        rs1000mVO.setCorpCd(EgovUserDetailsHelper.getAuthenticatedAdminCorpCd());
    
        ech0204DAO.updateech0204(rs1000mVO);

    	EgovMap paramMap = new EgovMap();
    	paramMap.put("corpCd", EgovUserDetailsHelper.getAuthenticatedAdminCorpCd());
    	paramMap.put("rsNo", rs1000mVO.getRsNo());
    	ech0204DAO.deleteech0204eCRF(paramMap);
        
        message = "저장되었습니다.";
        
        List<Cr1000mVO> cr1000mVOList = rs1000mVO.getCr1000mVOList();
        
        if(cr1000mVOList != null && cr1000mVOList.size() != 0){
            for(Cr1000mVO cr1000mVO : cr1000mVOList){
            	if(cr1000mVO != null){
            		cr1000mVO.setRsNo(rs1000mVO.getRsNo());
            		cr1000mVO.setCorpCd(EgovUserDetailsHelper.getAuthenticatedAdminCorpCd());
	            	ech0204DAO.insertech0204eCRF(cr1000mVO);
            	}
            }
        }
        
        return redirectech0204List(reda, message);
    }
    
    /**
     * 피부특성관리 엑셀다운로드
     *
     * @param model
     * @return 피부특성관리 엑셀다운로드
     * @throws Exception
     */
    @SuppressWarnings("unchecked")
    @RequestMapping("/qxsepmny/ech0204/ech0204Excel.do")
    public void ech0204Excel(@ModelAttribute("searchVO") CmmnSearchVO searchVO, HttpServletRequest request, HttpServletResponse response, RedirectAttributes reda, ModelMap model) throws Exception {
        LOGGER.debug("/qxsepmny/ech0204/ech0204Excel.do - 피부특성관리 엑셀 다운로드");
        LOGGER.debug("searchVO = " + searchVO.toString());
       
        EgovMap dataMap = new EgovMap();
       
        List<EgovMap> resultList = ech0204DAO.selectech0204Excel(searchVO);
        dataMap.put("resultList", resultList);
       
        int num = 1;
        for (EgovMap egovMap : resultList) {
            egovMap.put("number", num);
            num++;
        }
       
        /*AdminVO sessionVO = (AdminVO) EgovUserDetailsHelper.getAuthenticatedAdmin();
        dataMap.put("printUser", sessionVO.getName());*/
       
        ExcelUtil excelUtil = new ExcelUtil();
        excelUtil.getPerformanceExcel(dataMap, "피부특성관리 리스트", "ech0204", request, response);
    }
    
    /**
     * 피부특성관리 템플릿 목록조회 ajax
     *
     * @param model
     * @return 피부특성관리 템플릿 목록조회 ajax
     * @throws Exception
     */
    @RequestMapping("/qxsepmny/ech0204/ajaxSelectTempList.do")
    public View ajaxSelectTempList(String tempType, HttpServletRequest request, ModelMap model) throws Exception {
        LOGGER.debug("/qxsepmny/ech0204/ajaxSelectTempList.do - 피부특성관리 템플릿 목록조회 ajax");
        LOGGER.debug("tempType = " + tempType);
    	
    	EgovMap paramMap = new EgovMap();
    	paramMap.put("corpCd", EgovUserDetailsHelper.getAuthenticatedAdminCorpCd());
    	paramMap.put("tempType", tempType);
        
        List<EgovMap> tempList = ech0204DAO.selectEch0204TempList(paramMap);
        model.addAttribute("tempList", tempList);
 
        return jsonView;
    }
}