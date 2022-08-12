package ctms.adm.ech0203;
 
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
 
import ctms.valueObject.Cr2030mVO;
import ctms.valueObject.Cr2040mVO;
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
public class Ech0203Controller extends AdmCmmController{
 
    private static final Logger LOGGER = LoggerFactory.getLogger(Ech0203Controller.class);
    @Autowired private Ech0203DAO ech0203DAO;
    @Resource private CmmnFileMngUtil fileUtil;
    @Resource private View jsonView;
 
    @Resource(name = "propertiesService") protected EgovPropertyService propertyService;
 
    //질문답변관리 목록화면으로 리다이렉트합니다.
    private String redirectech0203List(RedirectAttributes reda, String message){
        reda.addFlashAttribute("message", message);
        return "redirect:/qxsepmny/ech0203/ech0203List.do";
    }
    
    /**
     * 질문답변관리 목록
     *
     * @param model
     * @return 질문답변관리 목록화면
     * @throws Exception
     */
    @RequestMapping("/qxsepmny/ech0203/ech0203List.do")
    public String ech0203List(@ModelAttribute("searchVO") CmmnSearchVO searchVO, HttpServletRequest request, ModelMap model ) throws Exception {
        LOGGER.debug("/qxsepmny/ech0203/ech0203List.do - 질문답변관리 목록");
        LOGGER.debug("searchVO = " + searchVO.toString());
        //request.getSession().setAttribute("usrMenuNo", "101");   // 변경할것

        if(EgovStringUtil.isEmpty(searchVO.getSearchCondition2())){
        	searchVO.setSearchCondition2("Y"); //기본값 - 사용
        }        	
        	
        PaginationInfo paginationInfo = PaginationController.getPaginationInfo(searchVO);
        CmmnListVO listVO = ech0203DAO.selectech0203List(searchVO);
        paginationInfo.setTotalRecordCount(listVO.getTotalRecordCount());
    
        model.addAttribute("resultList", listVO.getEgovList());
        
        model.addAttribute("paginationInfo", paginationInfo);
		model.addAttribute("totalCount", paginationInfo.getTotalRecordCount());
		model.addAttribute("currentPageNo", paginationInfo.getCurrentPageNo());
		model.addAttribute("totalPageCount", paginationInfo.getTotalPageCount());
       
        return "/adm/ech0203/ech0203List";
    }
    
    /**
     * 질문답변관리 조회
     *
     * @param model
     * @return 질문답변관리 조회화면
     * @throws Exception
     */
    @RequestMapping("/qxsepmny/ech0203/ech0203View.do")
    public String ech0203View(@ModelAttribute("searchVO") CmmnSearchVO searchVO, String quesNo, HttpServletRequest request, ModelMap model, RedirectAttributes reda) throws Exception {
        LOGGER.debug("/qxsepmny/ech0203/ech0203View.do - 질문답변관리 조회");
        LOGGER.debug("quesNo = " + quesNo);  //변경할것
       
       Cr2030mVO resultVO = new Cr2030mVO();
    
        if(!EgovStringUtil.isEmpty(quesNo)){  //변경할것
        	EgovMap paramMap = new EgovMap();
        	paramMap.put("corpCd", EgovUserDetailsHelper.getAuthenticatedAdminCorpCd());
        	paramMap.put("quesNo", quesNo);
            resultVO = ech0203DAO.selectech0203View(paramMap);  //변경할것
            
            List<EgovMap> cr2040List = ech0203DAO.selectEch0203AnswList(paramMap);
            model.addAttribute("cr2040List", cr2040List);
        }else{
            String message = "존재하지 않는 질문답변관리입니다.";
            return redirectech0203List(reda, message);
        }
 
        model.addAttribute("cr2030mVO", resultVO);
        model.addAttribute("searchVO", searchVO);
        LOGGER.debug("searchVO View="+searchVO.toString());
 
        return "/adm/ech0203/ech0203View";
    }
 
    /**
     * 질문답변관리 수정&등록화면
     *
     * @param model
     * @return 질문답변관리 수정&등록화면
     * @throws Exception
     */
    @RequestMapping("/qxsepmny/ech0203/ech0203Modify.do")
    public String ech0203Modify(@ModelAttribute("searchVO") CmmnSearchVO searchVO, String quesNo, HttpServletRequest request, ModelMap model ) throws Exception {
        LOGGER.debug("/qxsepmny/ech0203/ech0203Modify.do - 질문답변관리 수정&등록화면");
        LOGGER.debug("quesNo = " + quesNo);
       
       Cr2030mVO resultVO = new Cr2030mVO();
    
        if(!EgovStringUtil.isEmpty(quesNo)){
        	EgovMap paramMap = new EgovMap();
        	paramMap.put("corpCd", EgovUserDetailsHelper.getAuthenticatedAdminCorpCd());
        	paramMap.put("quesNo", quesNo);
            resultVO = ech0203DAO.selectech0203View(paramMap);
            
            List<EgovMap> cr2040List = ech0203DAO.selectEch0203AnswList(paramMap);
            model.addAttribute("cr2040List", cr2040List);
        }
 
        model.addAttribute("cr2030mVO", resultVO);
 
        return "/adm/ech0203/ech0203Modify";
    }
    
    /**
     * 질문답변관리 수정&등록
     *
     * @param model
     * @return 질문답변관리 수정&등록
     * @throws Exception
     */
    @RequestMapping("/qxsepmny/ech0203/ech0203Update.do")
    public String ech0203Update(@ModelAttribute("cr2030mVO") Cr2030mVO cr2030mVO, HttpServletRequest request, ModelMap model, RedirectAttributes reda) throws Exception {
        LOGGER.debug("/qxsepmny/ech0203/ech0203Update.do - 질문답변관리 수정&등록");
        LOGGER.debug("cr2030mVO = " + cr2030mVO.toString());
        String message = "";
        String quesNo = "";
        cr2030mVO.setCorpCd("HNBSRC");
    
        if(EgovStringUtil.isEmpty(cr2030mVO.getQuesNo())){
        	quesNo = ech0203DAO.insertech0203(cr2030mVO);
            message = "등록이 완료되었습니다.";
        }else{
        	quesNo = cr2030mVO.getQuesNo();
            ech0203DAO.updateech0203(cr2030mVO);

        	EgovMap paramMap = new EgovMap();
        	paramMap.put("corpCd", EgovUserDetailsHelper.getAuthenticatedAdminCorpCd());
        	paramMap.put("quesNo", cr2030mVO.getQuesNo());
            ech0203DAO.deleteech0203Answ(paramMap);
            
            message = "수정이 완료되었습니다.";
        }
        
        List<Cr2040mVO> cr2040VOList = cr2030mVO.getCr2040mVOList();
        
        if(cr2040VOList != null && cr2040VOList.size() != 0){
            int answSort = 0;
            for(Cr2040mVO cr2040mVO : cr2040VOList){
            	cr2040mVO.setQuesNo(quesNo);
            	cr2040mVO.setCorpCd(EgovUserDetailsHelper.getAuthenticatedAdminCorpCd());
            	cr2040mVO.setAnswSort(String.valueOf(answSort));
            	ech0203DAO.insertech0203Answ(cr2040mVO);
            	answSort++;
            }
        }
        
        return redirectech0203List(reda, message);
    }
    
    
    /**
     * 질문답변관리 삭제
     *
     * @param model
     * @return 질문답변관리 삭제
     * @throws Exception
     */
    @RequestMapping("/qxsepmny/ech0203/ech0203Delete.do")
    public String ech0203Delete(@ModelAttribute("cr2030mVO") Cr2030mVO cr2030mVO, HttpServletRequest request, ModelMap model, RedirectAttributes reda) throws Exception {
        LOGGER.debug("/qxsepmny/ech0203/ech0203Delete.do - 질문답변관리 삭제");
        LOGGER.debug("cr2030mVO = " + cr2030mVO.toString());
        String message = "존재하지 않는 연구과제입니다.";
       
        if(!EgovStringUtil.isEmpty(cr2030mVO.getQuesNo())){
            //ech0203DAO.deleteech0203(cr2030mVO.getQuesNo());

        	EgovMap paramMap = new EgovMap();
        	paramMap.put("corpCd", EgovUserDetailsHelper.getAuthenticatedAdminCorpCd());
        	paramMap.put("dataRegnt", EgovUserDetailsHelper.getAuthenticatedAdminId());
        	paramMap.put("quesNo", cr2030mVO.getQuesNo());
        	
        	// 삭제 질문 CR2030M DEL_YN = 'Y' 설정
        	ech0203DAO.updateEch0203DelYnQues(paramMap);
        	// 삭제 답변항목 CR2040M DEL_YN = 'Y' 설정
        	ech0203DAO.updateEch0203DelYnAnsw(paramMap);
    
            message = "해당 질문답변관리의 삭제가 완료되었습니다.";
        }
 
        return redirectech0203List(reda, message);
    }
    
    /**
     * 질문답변관리 엑셀다운로드
     *
     * @param model
     * @return 질문답변관리 엑셀다운로드
     * @throws Exception
     */
    @SuppressWarnings("unchecked")
    @RequestMapping("/qxsepmny/entran/ech0203Excel.do")
    public void ech0203Excel(@ModelAttribute("searchVO") CmmnSearchVO searchVO, HttpServletRequest request, HttpServletResponse response, RedirectAttributes reda, ModelMap model) throws Exception {
        LOGGER.debug("/qxsepmny/entran/ech0203Excel.do - 질문답변관리 엑셀 다운로드");
        LOGGER.debug("searchVO = " + searchVO.toString());
       
        EgovMap dataMap = new EgovMap();
       
        List<EgovMap> resultList = ech0203DAO.selectech0203Excel(searchVO);
        dataMap.put("resultList", resultList);
       
        int num = 1;
        for (EgovMap egovMap : resultList) {
            egovMap.put("number", num);
            num++;
        }
       
        /*AdminVO sessionVO = (AdminVO) EgovUserDetailsHelper.getAuthenticatedAdmin();
        dataMap.put("printUser", sessionVO.getName());*/
       
        ExcelUtil excelUtil = new ExcelUtil();
        excelUtil.getPerformanceExcel(dataMap, "질문답변관리 리스트", "ech0203", request, response);
    }
}