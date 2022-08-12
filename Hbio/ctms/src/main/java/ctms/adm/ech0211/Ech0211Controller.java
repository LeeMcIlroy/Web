
package ctms.adm.ech0211;

import java.util.List;
 
import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.pdfbox.pdmodel.PDDocument;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.multipart.MultipartHttpServletRequest;
import org.springframework.web.servlet.View;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.ubireport.common.util.StrUtil;
import com.ubireport.viewer.report.preview.UbiViewer;

import ctms.valueObject.AdminVO;
import ctms.valueObject.Cm4000mVO;
import ctms.valueObject.Cr2050mVO;
import ctms.valueObject.Cr2060mVO;
import ctms.valueObject.Cr2100mVO;
import ctms.valueObject.Cr2110mVO;
import ctms.valueObject.Ct2000mVO;
import ctms.valueObject.Ct7000mVO;
import ctms.valueObject.Rs1000mVO;
import ctms.valueObject.Rs1010mVO;
import component.excel.ExcelUtil;
import component.file.CmmnFileMngUtil;
import component.file.FileInfoVO;

import component.web.PaginationController;
import ctms.adm.cmm.AdmCmmController;
import ctms.adm.ech0202.Ech0202DAO;
import ctms.adm.ech0210.Ech0210DAO;
import ctms.adm.ech0707.Ech0707DAO;
import ctms.cmm.CmmDAO;
import ctms.valueObject.cmm.CmmnListVO;
import ctms.valueObject.cmm.CmmnSearchVO;
import egovframework.com.cmm.util.EgovUserDetailsHelper;
import egovframework.let.utl.fcc.service.EgovStringUtil;
import egovframework.rte.fdl.property.EgovPropertyService;
import egovframework.rte.psl.dataaccess.util.EgovMap;
import egovframework.rte.ptl.mvc.tags.ui.pagination.PaginationInfo;

import component.file.CmmnFileMngUtil;
import egovframework.com.cmm.web.EgovWebUtil;
import ctms.cmm.CtmsCmmMethods;

import java.io.File;

@Controller
public class Ech0211Controller extends AdmCmmController{
 
    private static final Logger LOGGER = LoggerFactory.getLogger(Ech0211Controller.class);
    @Autowired private Ech0211DAO ech0211DAO;
    @Autowired private Ech0210DAO ech0210DAO;
    @Autowired private Ech0707DAO ech0707DAO;
    @Autowired private Ech0202DAO ech0202DAO;
	@Autowired private CmmDAO cmmDAO;
    @Resource private CmmnFileMngUtil fileUtil;
    @Resource private View jsonView;
 
    @Resource(name = "propertiesService") protected EgovPropertyService propertyService;
 
    //eCRF관리 목록화면으로 리다이렉트합니다.
    private String redirectech0211List(RedirectAttributes reda, String message){
        reda.addFlashAttribute("message", message);
        return "redirect:/qxsepmny/ech0211/ech0211List.do";
    }
    
    //eCRF관리 상세화면으로 리다이렉트합니다.
    private String redirectech0211Modify(RedirectAttributes reda, String message){
        reda.addFlashAttribute("message", message);
        return "redirect:/qxsepmny/ech0211/ech0211Modify.do";
    }
    
    /**
     * eCRF관리 목록
     *
     * @param model
     * @return eCRF관리 목록화면
     * @throws Exception
     */
    @RequestMapping("/qxsepmny/ech0211/ech0211List.do")
    public String ech0211List(@ModelAttribute("searchVO") CmmnSearchVO searchVO, HttpServletRequest request, ModelMap model ) throws Exception {
        LOGGER.debug("/qxsepmny/ech0211/ech0211List.do - eCRF관리 목록");
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
        
        List<EgovMap> stateList = cmmDAO.selectCmmCdList( EgovUserDetailsHelper.getAuthenticatedAdminCorpCd(), "CM1350");
        model.addAttribute("stateList", stateList);
    
        PaginationInfo paginationInfo = PaginationController.getPaginationInfo(searchVO);
        CmmnListVO listVO = ech0211DAO.selectech0211List(searchVO);
        paginationInfo.setTotalRecordCount(listVO.getTotalRecordCount());
    
        model.addAttribute("resultList", listVO.getEgovList());
        model.addAttribute("paginationInfo", paginationInfo);
        model.addAttribute("totalCount", paginationInfo.getTotalRecordCount());
    
        return "/adm/ech0211/ech0211List";
    }
    
    /**
     * eCRF관리 조회
     *
     * @param model
     * @return eCRF관리 조회화면
     * @throws Exception
     */
    @RequestMapping("/qxsepmny/ech0211/ech0211View.do")
    public String ech0211View(@ModelAttribute("searchVO") CmmnSearchVO searchVO, String rsNo, HttpServletRequest request, ModelMap model, RedirectAttributes reda) throws Exception {
        LOGGER.debug("/qxsepmny/ech0211/ech0211View.do - eCRF관리 조회");
        LOGGER.debug("rsNo = " + rsNo);
       
        Rs1000mVO resultVO = new Rs1000mVO();
    
        if(!EgovStringUtil.isEmpty(rsNo)){
        	EgovMap paramMap = new EgovMap();
        	paramMap.put("corpCd", EgovUserDetailsHelper.getAuthenticatedAdminCorpCd());
        	paramMap.put("rsNo", rsNo);
            resultVO = ech0211DAO.selectech0211View(paramMap);
            
        }else{
            String message = "존재하지 않는 eCRF관리입니다.";
            return redirectech0211List(reda, message);
        }
 
        model.addAttribute("rs1000mVO", resultVO);
        model.addAttribute("searchVO", searchVO);
 
        return "/adm/ech0211/ech0211View";
    }
 
    /**
     * eCRF관리 수정&등록화면
     *
     * @param model
     * @return eCRF관리 수정&등록화면
     * @throws Exception
     */
    @RequestMapping("/qxsepmny/ech0211/ech0211Modify.do")
    public String ech0211Modify(@ModelAttribute("searchVO") CmmnSearchVO searchVO, Cr2110mVO cr2110mVO, String rsNo, String corpCd, String rsiCnt, HttpServletRequest request, ModelMap model ) throws Exception {
        LOGGER.info("/qxsepmny/ech0211/ech0211Modify.do - eCRF관리 수정&등록화면");
        LOGGER.debug("corpCd = " + corpCd);
        LOGGER.debug("rsNo = " + rsNo);
    	
    	List<EgovMap> typeList = cmmDAO.selectCmmCdList(EgovUserDetailsHelper.getAuthenticatedAdminCorpCd(), "CT3020");
    	model.addAttribute("typeList", typeList);
       
        Rs1000mVO resultVO = new Rs1000mVO();
        //LOGGER.debug("getParameterMap= "+request.getParameterMap().toString());
        if(!EgovStringUtil.isEmpty(rsNo)){
        	//연구종료확인서 CRF 설정여부  check
			EgovMap map = new EgovMap();
			map.put("corpCd", EgovUserDetailsHelper.getAuthenticatedAdminCorpCd());
			map.put("rsNo", rsNo);
			int rsFinSetChkCnt = ech0211DAO.selectEch0211RsFinSetChkCnt(map);
			model.addAttribute("rsFinSetChkCnt", rsFinSetChkCnt);        	
        	
        	EgovMap paramMap = new EgovMap();
        	paramMap.put("corpCd", EgovUserDetailsHelper.getAuthenticatedAdminCorpCd());
        	paramMap.put("rsNo", rsNo);
            resultVO = ech0211DAO.selectech0211View(paramMap);
            
            List<EgovMap> eCrfList = ech0211DAO.selectEch0211eCrfList(paramMap);
            model.addAttribute("eCrfList", eCrfList);
            
            //mapKey 영문자는 소문자로 만들어짐 
    		EgovMap paramMap2 = new EgovMap();        
            EgovMap resultMap = new EgovMap();

            for(EgovMap map1 : eCrfList){
            	String mapKey = (String) map1.get("corpCd")+map1.get("tempNo");
            	LOGGER.debug("mapKey= "+mapKey);
            	paramMap2.put("boardSeq", map1.get("tempNo"));
               	paramMap2.put("boardType", "UBI4\\TMPL");
               	paramMap2.put("fileKey", "attachRpt01");
               	List<Ct7000mVO> attachList = cmmDAO.selectAttachListFileKey(paramMap2);
                resultMap.put(mapKey, attachList);
                LOGGER.debug("resultMap= "+resultMap.toString());
            }
            model.addAttribute("mtList", resultMap);
            
            List<EgovMap> tempList = ech0211DAO.selectEch0211TempList(paramMap);
            model.addAttribute("tempList", tempList);
            
            List<EgovMap> tempList2 = ech0211DAO.selectEch0211TempList2(paramMap);
            model.addAttribute("tempList2", tempList2);
        }        
        
        model.addAttribute("rs1000mVO", resultVO);
        
        List<EgovMap> stateList = cmmDAO.selectCmmCdList(EgovUserDetailsHelper.getAuthenticatedAdminCorpCd(), "CM1350");
        model.addAttribute("stateList", stateList);
        
	    //검색조건 유지 설정
	    model.addAttribute("searchVO", searchVO);
      	LOGGER.debug("searchVO View="+searchVO.toString());
 
      	model.addAttribute("rsiCnt", rsiCnt);
      	
        return "/adm/ech0211/ech0211Modify";
    }
    
    /**
     * eCRF관리 수정&등록
     *
     * @param model
     * @return eCRF관리 수정&등록
     * @throws Exception
     */
    @RequestMapping("/qxsepmny/ech0211/ech0211Update.do")
    public String ech0211Update(@ModelAttribute("cr2110mVO") Cr2110mVO cr2110mVO, Rs1000mVO rs1000mVO, Cr2100mVO cr2100mVO, CmmnSearchVO searchVO, MultipartHttpServletRequest request, ModelMap model, RedirectAttributes reda) throws Exception {
        LOGGER.info("/qxsepmny/ech0211/ech0211Update.do - eCRF관리 수정&등록");
        LOGGER.debug("rs1000mVO = " + rs1000mVO.toString());
        String message = "";
        rs1000mVO.setCorpCd(EgovUserDetailsHelper.getAuthenticatedAdminCorpCd());
    
        //eCRF상태 업데이트 RS1010M 
        ech0211DAO.updateech0211(rs1000mVO);

    	EgovMap paramMap = new EgovMap();
    	paramMap.put("corpCd", EgovUserDetailsHelper.getAuthenticatedAdminCorpCd());
    	paramMap.put("rsNo", rs1000mVO.getRsNo());
    	//RS_NO로 설정된 CRF 모두 삭제 CR2110M
    	ech0211DAO.deleteech0211eCRF(paramMap);
        
        message = "저장되었습니다.";
        
        List<Cr2110mVO> cr2110mVOList = rs1000mVO.getCr2110mVOList();
        
        if(cr2110mVOList != null && cr2110mVOList.size() != 0){
            for(Cr2110mVO cr2110mVO1 : cr2110mVOList){
            	if(cr2110mVO != null){
            		LOGGER.debug("cr2110mVOList = "+cr2110mVOList.toString());
            		LOGGER.debug("cr2110mVO = "+cr2110mVO.toString());
            		
            		if(!cr2110mVO.getTitle().equals("")) {
	            		cr2110mVO.setRsNo(rs1000mVO.getRsNo());
	            		cr2110mVO.setCorpCd(EgovUserDetailsHelper.getAuthenticatedAdminCorpCd());	            		
	            		
	            		//CRF 템플릿 등록 CR2100M 
		            	//고유번호 설정 필요함
	            		cr2100mVO.setUseYn("Y");
	            		//구성쪽수 설정
	            		cr2100mVO.setUpageCnt(cr2110mVO.getUpageCnt());
	            		cr2100mVO.setTempNm(cr2110mVO.getTitle());
	            		cr2100mVO.setRemk(cr2110mVO.getTitle());
	            		cr2100mVO.setEmpNo(EgovUserDetailsHelper.getAuthenticatedAdminEmpNo());
	            		cr2100mVO.setBranchCd(EgovUserDetailsHelper.getAuthenticatedAdminBranchCd());
	            		cr2100mVO.setStDate(EgovStringUtil.getDateMinus());
	            		cr2100mVO.setEdDate("9999-12-31");
	            		//템플릿구분 설정 - 설정안됨?????
	            		cr2100mVO.setTempType(cr2110mVO.getTempType());            		
	            		cr2100mVO.setCorpCd(EgovUserDetailsHelper.getAuthenticatedAdminCorpCd());
		    			cr2100mVO.setTempNo1("CRF");
		    			cr2100mVO.setRegDt(EgovStringUtil.getDateMinus());
		    			cr2100mVO.setDataRegnt(EgovUserDetailsHelper.getAuthenticatedAdminId());
		    			//LOGGER.debug("getTempNo1()= "+cr2100mVO.getTempNo1());
		    			
		    			//템플릿이 등록되여 있으면 업데이트 처리한다.
		    			cr2100mVO.setTempNo(cr2110mVO.getTempNo());
		    			int chkCnt = ech0211DAO.selectEch0211TempCnt(cr2100mVO);
		    			String tempNo = "";
		    			if(chkCnt < 1) {
		    				//CRF설정관리에서 생성 설정 
		    				cr2100mVO.setMkType("2");
		    				tempNo = ech0210DAO.insertEch0210(cr2100mVO);
			    			cr2100mVO.setTempNo(tempNo);
		    			}
		    			
	            		//CRF 설정 등록 CR2110M
		    			if(cr2110mVO.getTempNo().equals("템플릿명")) {
		    				cr2110mVO.setTempNo(tempNo);
		    			}
		    			//cr2110mVO.setTempNo(tempNo);
		    			cr2110mVO.setContent(cr2110mVO.getTitle());
		    			cr2110mVO.setSvStdt(EgovStringUtil.getDateMinus());
		    			cr2110mVO.setSvEndt("9999-12-31");
		    			cr2110mVO.setDataRegnt(EgovUserDetailsHelper.getAuthenticatedAdminId());
		            	ech0211DAO.insertech0211eCRF(cr2110mVO);
		            	// CT7000M 체크
        				//CRF 첨부파일 등록 - CR2100M 기준 템플릿을 먼저 생성해야 한다. 
	    		            List<FileInfoVO> fileInfoList = fileUtil.totUploadFiles(request, "UBI4\\TMPL");
	    		            if(fileInfoList != null){
	    		            
			        			for(FileInfoVO fileInfoVO : fileInfoList){
			        				int tempSeq = 0;
			        				int chktmp = cmmDAO.selectAttachListone(cr2110mVO.getTempNo());

			        				if(fileInfoVO.getFileKey().substring(9).equals(cr2110mVO.getSvSeq())){
			        					
			        					tempSeq = Integer.parseInt(cr2110mVO.getSvSeq());
			        				}else{
			        					if(cr2110mVO.getSvSeq().equals("1")){
				        					tempSeq = Integer.parseInt(cr2110mVO.getSvSeq()) + 1;

			        					}else{
			        						
			        						tempSeq = Integer.parseInt(cr2110mVO.getSvSeq()) - 1;
			        					}

			        				}

			        				if(fileInfoVO.getFileKey().equals("attachRpt"+tempSeq)) {
			        					
				        				if(chktmp == 0 && cr2100mVO.getMkType().equals("2")){
				        					Ct7000mVO attachVO = new Ct7000mVO(fileInfoVO);
				        					attachVO.setBoardType("UBI4\\TMPL");
				        					attachVO.setBoardNo(cr2110mVO.getTempNo());
				        					attachVO.setRegName(EgovUserDetailsHelper.getAuthenticatedAdminId());
				        					attachVO.setRegDate(EgovStringUtil.getDateMinus());
				        					attachVO.setFileKey("attachRpt01");
				        					cmmDAO.insertAttachFile(attachVO);
				        				}
			        				}
			        			}
	    		            }	
		        		}        	    	
            		}   	
            	}
            }

        if(cr2110mVOList != null && cr2110mVOList.size() != 0){
        	//등록된 연구과제의 CRF list 획득
        	EgovMap paramMap3 = new EgovMap();
        	paramMap3.put("corpCd", EgovUserDetailsHelper.getAuthenticatedAdminCorpCd());
        	paramMap3.put("rsNo", rs1000mVO.getRsNo());
            
            List<EgovMap> eCrfList = ech0211DAO.selectEch0211eCrfList(paramMap3);
            EgovMap paramMap4 = new EgovMap();
            int startPage = 0;
            for(EgovMap crfMap  : eCrfList){
        		//LOGGER.debug("corpCd = " + crfMap.get("corpCd"));
        		//LOGGER.debug("rsNo = " + crfMap.get("rsNo"));
        		//LOGGER.debug("tempNo = " + crfMap.get("tempNo"));
        		//LOGGER.debug("svSeq = " + crfMap.get("svSeq"));
        		
        		paramMap4.put("corpCd", EgovUserDetailsHelper.getAuthenticatedAdminCorpCd());
            	paramMap4.put("rsNo", crfMap.get("rsNo"));
            	paramMap4.put("svSeq", crfMap.get("svSeq"));
            	if(crfMap.get("svSeq").equals(1)) {
            		startPage = 1;
            		//LOGGER.debug("startPage 1 = " + startPage);
            	}else {	
	                int tusePageCnt = ech0211DAO.selectEcr0211TUsePageCnt(paramMap4);
	                startPage = tusePageCnt + 1;
	        		//LOGGER.debug("tusePageCnt = " + tusePageCnt);
	        		//LOGGER.debug("startPage 2이상 = " + startPage);
            	}
            	paramMap4.put("tempNo", crfMap.get("tempNo"));
            	paramMap4.put("spageCnt", startPage);
            	ech0211DAO.updateEch0211SpageCnt(paramMap4);
            }
	        
			//현재 CRF양식에 시작쪽수를 업데이트 한다. svSeq번호 이전까지의 구성쪽수합 + 1
	    	//svSeq번호 이전까지 구성쪽수합 + 1 산출 
	    	//int svSeqTusePageCnt = ech0211DAO.selectEcr0211SvSeqTUsePageCnt(cr2110mVO);
	    	
	    	//시작쪽수 설정을 포함하여 등록
        
        }
        
        //연구과제에 연결됭 CRF 템플릿의 구성쪽수 UPAGE_CNT의 합계를  연구계획서 RS1010M TPAGE_CNT에 Update한다.
        //구성쪽수 합계산출
        EgovMap paramMap2 = new EgovMap();
    	paramMap2.put("corpCd", EgovUserDetailsHelper.getAuthenticatedAdminCorpCd());
    	paramMap2.put("rsNo", rs1000mVO.getRsNo());
    	paramMap2.put("svSeq", 9999);
    	//CR2110M CR2100M 참조 
        int tusePageCnt = ech0211DAO.selectEcr0211TUsePageCnt(paramMap2);
        
        if(tusePageCnt >= 0) {
        	//총구성쪽수 Update CR2110M
        	//LOGGER.debug("tusePageCnt = " + tusePageCnt);
        	rs1000mVO.setTpageCnt(Integer.toString(tusePageCnt));
            ech0211DAO.updateEch0211TpageCnt(rs1000mVO);	
        }
        
        model.addAttribute("searchVO", searchVO);
        
        return redirectech0211List(reda, message);
        //return redirectech0211Modify(reda, message);
    }
    
    /**
     * eCRF관리 엑셀다운로드
     *
     * @param model
     * @return eCRF관리 엑셀다운로드
     * @throws Exception
     */
    @SuppressWarnings("unchecked")
    @RequestMapping("/qxsepmny/entran/ech0211Excel.do")
    public void ech0211Excel(@ModelAttribute("searchVO") CmmnSearchVO searchVO, HttpServletRequest request, HttpServletResponse response, RedirectAttributes reda, ModelMap model) throws Exception {
        LOGGER.debug("/qxsepmny/entran/ech0211Excel.do - eCRF관리 엑셀 다운로드");
        LOGGER.debug("searchVO = " + searchVO.toString());
       
        EgovMap dataMap = new EgovMap();
       
        List<EgovMap> resultList = ech0211DAO.selectech0211Excel(searchVO);
        dataMap.put("resultList", resultList);
       
        int num = 1;
        for (EgovMap egovMap : resultList) {
            egovMap.put("number", num);
            num++;
        }
       
        /*AdminVO sessionVO = (AdminVO) EgovUserDetailsHelper.getAuthenticatedAdmin();
        dataMap.put("printUser", sessionVO.getName());*/
       
        ExcelUtil excelUtil = new ExcelUtil();
        excelUtil.getPerformanceExcel(dataMap, "eCRF관리 리스트", "ech0211", request, response);
    }
    
    /**
     * eCRF관리 템플릿 목록조회 ajax
     *
     * @param model
     * @return eCRF관리 템플릿 목록조회 ajax
     * @throws Exception
     */
    @RequestMapping("/qxsepmny/ech0211/ajaxSelectTempList.do")
    public View ajaxSelectTempList(String tempType, HttpServletRequest request, ModelMap model) throws Exception {
        LOGGER.debug("/qxsepmny/ech0211/ajaxSelectTempList.do - eCRF관리 템플릿 목록조회 ajax");
        LOGGER.debug("tempType = " + tempType);
    	
    	EgovMap paramMap = new EgovMap();
    	paramMap.put("corpCd", EgovUserDetailsHelper.getAuthenticatedAdminCorpCd());
    	paramMap.put("tempType", tempType);
    	
    	//CRF템플릿의 명칭 조회
    	//연구상태(공통코드) 목록 searchCondition5
  		List<EgovMap> CT3020 = cmmDAO.selectCmmCdList(EgovUserDetailsHelper.getAuthenticatedAdminCorpCd(), "CT3020");
  		model.addAttribute("CT3020", CT3020);
        
        List<EgovMap> tempList = ech0211DAO.selectEch0211TempList(paramMap);
        model.addAttribute("tempList", tempList);
 
        return jsonView;
    }
    
    // 고객사 간편등록 팝업
 	@RequestMapping("/qxsepmny/ech0211/ech0211VendmgPop.do")
 	public String ech0211VendmgPop(String corpCd, Cm4000mVO cm4000mVO, HttpServletRequest request, RedirectAttributes reda, ModelMap model) throws Exception {
 		LOGGER.debug("/qxsepmny/ech0211/ech0211VendmgPop.do - 고객사 간편등록 팝업");
 		//세션 호출
 	 	//AdminVO adminVO = (AdminVO) request.getSession().getAttribute("adminSessionCtms");

 	 	// 회사코드 설정 
 		cm4000mVO.setCorpCd(EgovUserDetailsHelper.getAuthenticatedAdminCorpCd());
 		cm4000mVO.setCdCls("CT3020");
 		//등록화면으로
 		model.addAttribute("NotiPageGubun","NotiRegist");
 		model.addAttribute("cm4000mVO", cm4000mVO);
 			
 		return "/adm/ech0211/ech0211VendmgPop";
 		
 	}
    
 	// 고객사 간편등록 
 	@RequestMapping("/qxsepmny/ech0211/ech0211AjaxSaveVend.do")
 	public View ech0211AjaxSaveVend(String cdName, Cm4000mVO cm4000mVO,  HttpServletRequest request, RedirectAttributes reda, ModelMap model) throws Exception{
 		LOGGER.debug("/qxsepmny/ech0211/ech0211AjaxSaveVend.do - 고객사 간편등록");
 		String message = "";

 		cm4000mVO.setCorpCd(EgovUserDetailsHelper.getAuthenticatedAdminCorpCd());
 		cm4000mVO.setCdCls("CT3020");
 		cm4000mVO.setCd("5000");
 		cm4000mVO.setCdName(cdName);
 		cm4000mVO.setCdDesc(cdName);
 		cm4000mVO.setClsCat("3");
 		cm4000mVO.setDspSeq("0");
 		cm4000mVO.setUseYn("Y");
 		cm4000mVO.setDataRegnt(EgovUserDetailsHelper.getAuthenticatedAdminId());
 		
 		//CRF단계 등록
 		ech0707DAO.insertEch0707(cm4000mVO);
 		
 		message = "저장되었습니다.";
 		model.addAttribute("message", message);
 		
 		return jsonView;
 		
 	}
 	
 	// 연구과제 CRF 미리보기
 	@RequestMapping("/qxsepmny/ech0211/ech0211ViewCrf.do")
 	public String ech0211ViewCrf(@ModelAttribute("searchVO") CmmnSearchVO searchVO, String rsNo, HttpServletRequest request, ModelMap model ) throws Exception {
 		LOGGER.debug("/qxsepmny/ech0211/ech0211ViewCrf.do - 연구과제 CRF 미리보기");
 		LOGGER.debug("searchVO= "+searchVO);
 		//request.getSession().setAttribute("admMenuNo", "703");
 	
 		//rs1000mVO =  ech0401DAO.selectEch0401View(rs1000mVO);
 		
 		//searchVO.setCorpCd(EgovUserDetailsHelper.getAuthenticatedAdminCorpCd());
 		//searchVO.setRsNo(rs1000mVO.getRsNo());
 		
 		//EgovMap map2 = new EgovMap();
 		//map2.put("corpCd", EgovUserDetailsHelper.getAuthenticatedAdminCorpCd());
 		//map2.put("rsCd", rs1000mVO.getRsCd());
 		//map2.put("mrsNo", rs1000mVO.getRsNo());
 		//rs1010mVO = ech0101DAO.selectEch0101RsCdCheck3(map2);
 		
 		//searchVO.setRsNo(rs1010mVO.getRsNo());
 		
 		//eCRF통계로 변경해야 함 
 		//CmmnListVO listVO = ech0401DAO.selectEch0401ResList(searchVO);
 		
 		//피부특성 첨부파일 확인시작 - 마스터 list에서 mapKey를 만들어야 한다
 		//mapKey 영문자는 소문자로 만들어짐 
 		//EgovMap paramMap1 = new EgovMap();        
         //EgovMap resultMap = new EgovMap();

         //for(EgovMap map1 : listVO.getEgovList()){
         	//String mapKey = (String) map1.get("corpCd")+map1.get("rsNo")+map1.get("rsiNo");
         	//LOGGER.debug("mapKey="+(String) map1.get("mapKey"));
         	//paramMap1.put("boardSeq", mapKey);
         	
            	//paramMap1.put("boardType", "SVY");
            	//paramMap1.put("fileKey", "survey");
            	//List<Ct7000mVO> attachList = cmmDAO.selectAttachListFileKey(paramMap1);
             //resultMap.put(mapKey, attachList);
             //LOGGER.debug("resultMap = " + resultMap.toString());
         //}
         //model.addAttribute("mtList", resultMap);
 		//피부특성 첨부파일 확인 끝 
 		
 		
 		//model.addAttribute("rs1000mVO", rs1000mVO);
 		//model.addAttribute("resultList", listVO.getEgovList());
 		//model.addAttribute("pageIndex", searchVO.getPageIndex());
 		
 		Rs1000mVO resultVO = new Rs1000mVO();
        //LOGGER.debug("getParameterMap= "+request.getParameterMap().toString());
        if(!EgovStringUtil.isEmpty(rsNo)){
        	//연구종료확인서 CRF 설정여부  check
			EgovMap map = new EgovMap();
			map.put("corpCd", EgovUserDetailsHelper.getAuthenticatedAdminCorpCd());
			map.put("rsNo", rsNo);
			int rsFinSetChkCnt = ech0211DAO.selectEch0211RsFinSetChkCnt(map);
			model.addAttribute("rsFinSetChkCnt", rsFinSetChkCnt);        	
        	
        	EgovMap paramMap = new EgovMap();
        	paramMap.put("corpCd", EgovUserDetailsHelper.getAuthenticatedAdminCorpCd());
        	paramMap.put("rsNo", rsNo);
            resultVO = ech0211DAO.selectech0211View(paramMap);
            
            List<EgovMap> eCrfList = ech0211DAO.selectEch0211eCrfList(paramMap);
            model.addAttribute("eCrfList", eCrfList);
            
            //mapKey 영문자는 소문자로 만들어짐 
    		EgovMap paramMap2 = new EgovMap();        
            EgovMap resultMap = new EgovMap();
            String regFileName = "";
            for(EgovMap map1 : eCrfList){
            	String mapKey = (String) map1.get("corpCd")+map1.get("tempNo");
            	LOGGER.debug("mapKey= "+mapKey);
            	paramMap2.put("boardSeq", map1.get("tempNo"));
               	paramMap2.put("boardType", "UBI4\\TMPL");
               	paramMap2.put("fileKey", "attachRpt01");
               	List<Ct7000mVO> attachList = cmmDAO.selectAttachListFileKey(paramMap2);
               	for(Ct7000mVO attach : attachList) {
               		regFileName = attach.getRegFileName();    				
        			int pos = regFileName.lastIndexOf( "\\" );
        			attach.setRegFileName(regFileName.substring( pos + 1 ));
               	}
                resultMap.put(mapKey, attachList);
                LOGGER.debug("resultMap= "+resultMap.toString());
            }
            model.addAttribute("mtList", resultMap);
            
            List<EgovMap> tempList = ech0211DAO.selectEch0211TempList(paramMap);
            model.addAttribute("tempList", tempList);
            
            List<EgovMap> tempList2 = ech0211DAO.selectEch0211TempList2(paramMap);
            model.addAttribute("tempList2", tempList2);
            
        }
        
 		model.addAttribute("rs1000mVO", resultVO);
 		
 		 List<EgovMap> stateList = cmmDAO.selectCmmCdList(EgovUserDetailsHelper.getAuthenticatedAdminCorpCd(), "CM1350");
         model.addAttribute("stateList", stateList);
         
 	    //검색조건 유지 설정
 	    model.addAttribute("searchVO", searchVO);
       	LOGGER.debug("searchVO View="+searchVO.toString());
 										
 		return "/adm/ech0211/ech0211ViewCrf";
 	}
 	
 	// CRF 삭제
 	@RequestMapping("/qxsepmny/ech0211/ech0211AjaxDelCrf.do")
 	public View ech0211AjaxDelCrf(String corpCd, String rsNo, String[] svSeq, Cr2100mVO cr2100mVO, Rs1000mVO rs1000mVO, HttpServletRequest request, RedirectAttributes reda, ModelMap model) throws Exception{
 		LOGGER.debug("/qxsepmny/ech0211/ech0211AjaxDelCrf.do - CRF 삭제");
 		String message = "";
 		
 		EgovMap map = new EgovMap();
 		
 		map.put("corpCd", EgovUserDetailsHelper.getAuthenticatedAdminCorpCd());
 		map.put("rsNo", rsNo);
 		map.put("svSeq", svSeq);
 		
 		
 		//해당 CRF작성여부를 판단하여 이미 작성된 경우 CRF작성>재작성 기능으로 CRF를 삭제한 후 CRF설정을 해지하도록 한다. 
 		//CRF설정을 해지한후 CRF작성>작성설정 기능으로 연구대상자에 매칭된 CRF를 삭제한다.
 		int mkCrfCnt = ech0211DAO.selectEcr0211MkCrfCnt(map);
 		if(mkCrfCnt > 0) {
 			message = "해당 CRF작성 완료된 연구대상자가 존재하여 삭제할 수 없습니다. CRF작성>재작성 기능으로 작성된 CRF를 먼저 삭제한 후 CRF설정을 삭제하세요."; 			
 		}else {
 			 			 	 		
 	 		//CRF설정관리에서 등록된 템플릿인 경우 CR2100M, CT7000M, file을 동시에 삭제한다 - MK_TYPE = '2' 
 			for(int i=0; i<svSeq.length; i++) {
 				map.put("svSeq",svSeq[i]);
 				cr2100mVO = ech0211DAO.selectEch0211MkType(map);
 				
 				String tempType = ech0211DAO.selectEch0211TempType(map);
 				
 				//안정성평가인 경우 질문항목/답변항목 삭제
 	 	 		if(tempType.equals("4080")) { //안전성평가
 	 	 			//ech0202DAO.deleteech0202(cr2100mVO.getTempNo());
 	 	            
 	 	            EgovMap paramMap = new EgovMap();
	 	        	paramMap.put("corpCd", EgovUserDetailsHelper.getAuthenticatedAdminCorpCd());
	 	        	paramMap.put("tempNo", cr2100mVO.getTempNo());
 	 	 			//CR2050M 삭제 
	 	        	ech0202DAO.deleteech0202Ques(paramMap);
	 	        	
 	 	 	 		//CR2060M 삭제
	 	        	ech0202DAO.deleteech0202Answ(paramMap);
 	 	 		}
 				
 				if(cr2100mVO != null) {
 					if(cr2100mVO.getMkType().equals("2")) {//CRF설정관리에서 등록한 템플릿
 	 	 				
 	 	 				//CT7000M, file 삭제
 	 	 				EgovMap map2 = new EgovMap();
 						map2.put("boardSeq", cr2100mVO.getTempNo());
 						map2.put("boardType", "UBI4\\TMPL");
 						List<Ct7000mVO> attachList = cmmDAO.selectAttachList(map2);
 						
 						for(Ct7000mVO attachVO : attachList){
 							cmmDAO.deleteAttachFile(attachVO.getAttachNo());
 							fileUtil.deleteFile(attachVO.getRegFileName());
 						}
 						
 						//CRF템플릿 정보 삭제 CR2100M - 회사+템플릿번호 
 						cr2100mVO.setCorpCd(EgovUserDetailsHelper.getAuthenticatedAdminCorpCd());
 						ech0210DAO.deleteEch0210(cr2100mVO);
 	 	 			}

 				}
 				 	 	 		
 	 		}
 	 		
 			//선택한 모든 차수의  CRF설정정보 삭제 
 			EgovMap map2 = new EgovMap();
 			map2.put("corpCd", EgovUserDetailsHelper.getAuthenticatedAdminCorpCd());
 			map2.put("rsNo", rsNo);
 			map2.put("svSeq", svSeq);
 			
 	 		ech0211DAO.deleteEch0211AjaxDelCrf(map2);
 	 		
 			//시작페이지 설정 
 	   		//등록된 연구과제의 CRF list 획득
 	    	EgovMap paramMap3 = new EgovMap();
 	    	paramMap3.put("corpCd", EgovUserDetailsHelper.getAuthenticatedAdminCorpCd());
 	    	paramMap3.put("rsNo", rsNo);
 	        
 	        List<EgovMap> eCrfList = ech0211DAO.selectEch0211eCrfList(paramMap3);
 	        EgovMap paramMap4 = new EgovMap();
 	        int startPage = 0;
 	        for(EgovMap crfMap  : eCrfList){
 	    		paramMap4.put("corpCd", EgovUserDetailsHelper.getAuthenticatedAdminCorpCd());
 	        	paramMap4.put("rsNo", crfMap.get("rsNo"));
 	        	paramMap4.put("svSeq", crfMap.get("svSeq"));
 	        	if(crfMap.get("svSeq").equals(1)) {
 	        		startPage = 1;
 	        	}else {	
 	                int tusePageCnt = ech0211DAO.selectEcr0211TUsePageCnt(paramMap4);
 	                startPage = tusePageCnt + 1;
 	        	}
 	        	paramMap4.put("tempNo", crfMap.get("tempNo"));
 	        	paramMap4.put("spageCnt", startPage);
 	        	ech0211DAO.updateEch0211SpageCnt(paramMap4);
 	        }
 			
 	 		//연구과제에 연결됭 CRF 템플릿의 구성쪽수 UPAGE_CNT의 합계를  연구계획서 RS1010M TPAGE_CNT에 Update한다.
 	        //구성쪽수 합계산출
 	        EgovMap paramMap2 = new EgovMap();
 	    	paramMap2.put("corpCd", EgovUserDetailsHelper.getAuthenticatedAdminCorpCd());
 	    	paramMap2.put("rsNo", rsNo);
 	    	paramMap2.put("svSeq", 9999);
 	    	//CR2110M CR2100M 참조 
 	        int tusePageCnt = ech0211DAO.selectEcr0211TUsePageCnt(paramMap2);
 	        
 	        if(tusePageCnt >= 0) {
 	        	//총구성쪽수 Update RS1010M
 	        	LOGGER.debug("tusePageCnt = " + tusePageCnt);
 	        	rs1000mVO.setCorpCd(EgovUserDetailsHelper.getAuthenticatedAdminCorpCd());
 	        	rs1000mVO.setRsNo(rsNo);
 	        	rs1000mVO.setTpageCnt(Integer.toString(tusePageCnt));
 	            ech0211DAO.updateEch0211TpageCnt(rs1000mVO);	
 	        }
 	        
 	 		message = "CRF설정이 삭제되었습니다. CRF작성 중인 연구인 경우 CRF작성>작성설정을 다시 작업해주세요.";
 		}
 		 		
 		model.addAttribute("message", message);
 		
 		return jsonView;
 		
 	}
 	
 	// 연구관리 CRF상태 저장 - 대기, 작성중, 확정 - '확정'상태만 CRF 작성설정 가능 
  	@RequestMapping("/qxsepmny/ech0211/ech0211AjaxUpdateCrfState.do")
  	public View ech0211AjaxUpdateCrfState(String corpCd, String rsNo, String ecrfState, Rs1010mVO rs1010mVO, HttpServletRequest request, RedirectAttributes reda, ModelMap model) throws Exception{
  		LOGGER.debug("/qxsepmny/ech0211/ech0211AjaxUpdateCrfState.do - 연구관리 CRF상태 저장 - 대기, 작성중, 확정 - '확정'상태만 CRF 작성설정 가능");
  		String message = "";
  		
  		EgovMap map = new EgovMap();
  		map.put("corpCd", EgovUserDetailsHelper.getAuthenticatedAdminCorpCd());
  		map.put("rsNo", rsNo);
  		map.put("ecrfState", ecrfState);
  		
  		ech0211DAO.updateEch0211CrfState(map);
  		
  		String stateType = "";
  		if(ecrfState.equals("WAIT")) {
  			stateType = "대기";
  		}else if(ecrfState.equals("WRIT")) {
  			stateType = "작성중";
  		}else if(ecrfState.equals("CONF")) {
  			stateType = "확정";
  		}
  		
  		message = "CRF설정단계가 "+stateType+"(으)로 변경 되었습니다.";
  		model.addAttribute("message", message);
  		
  		return jsonView;
  		
  	}
 	
  	// 연구관리 CRF설정 등록 
   	@RequestMapping("/qxsepmny/ech0211/ech0211AjaxAddCrf.do")
   	public View ech0211AjaxAddCrf(String totalpage, Cr2110mVO cr2110mVO, Cr2100mVO cr2100mVO, Rs1000mVO rs1000mVO, MultipartHttpServletRequest request, RedirectAttributes reda, ModelMap model) throws Exception{
   		LOGGER.debug("/qxsepmny/ech0211/ech0211AjaxAddCrf.do - 연구관리 CRF설정 등록");
   		String message = "";
   		String rtCd = "";
   		
   		LOGGER.debug("cr2100mVO.toString()= "+cr2100mVO.toString());
   		LOGGER.debug("cr2110mVO.toString()= "+cr2110mVO.toString());
   		LOGGER.debug("totalpage= "+totalpage);
   		
   		//CRF작성차수 중복을 확인한다. 
   		EgovMap mapSvSeq = new EgovMap();
   		mapSvSeq.put("corpCd", EgovUserDetailsHelper.getAuthenticatedAdminCorpCd());
   		mapSvSeq.put("rsNo", cr2110mVO.getRsNo());
   		mapSvSeq.put("svSeq", cr2110mVO.getSvSeq());
   		
   		int chkSvSqeCnt = ech0211DAO.selectEch0211SvSeqCnt(mapSvSeq);
   		if(chkSvSqeCnt > 0) {
   			message = "이미 등록된 작성차수 입니다.";
   			rtCd = "D";
   			model.addAttribute("cr2110mVO", cr2110mVO);
   		}else {
    		
	   		//CRF템플릿 등록 CR2100M - TEMP_NO 설정
			cr2100mVO.setUseYn("Y");
			//구성쪽수 설정
			cr2100mVO.setUpageCnt(cr2110mVO.getUpageCnt()); 
			cr2100mVO.setTempNm(cr2110mVO.getTitle());
			cr2100mVO.setRemk(cr2110mVO.getTitle());
			cr2100mVO.setEmpNo(EgovUserDetailsHelper.getAuthenticatedAdminEmpNo());
			cr2100mVO.setBranchCd(EgovUserDetailsHelper.getAuthenticatedAdminBranchCd());
			cr2100mVO.setStDate(EgovStringUtil.getDateMinus());
			cr2100mVO.setEdDate("9999-12-31");
			cr2100mVO.setTempType(cr2110mVO.getTempType());            		
			cr2100mVO.setCorpCd(EgovUserDetailsHelper.getAuthenticatedAdminCorpCd());
			cr2100mVO.setTempNo1("CRF");
			cr2100mVO.setRegDt(EgovStringUtil.getDateMinus());
			cr2100mVO.setDataRegnt(EgovUserDetailsHelper.getAuthenticatedAdminId());
	
			cr2100mVO.setTempNo(cr2110mVO.getTempNo());
			int chkCnt = ech0211DAO.selectEch0211TempCnt(cr2100mVO);
			String tempNo = "";
			if(chkCnt < 1) { //CRF템플릿으로 등록되지 않은 경우 새로운 CR2100M에 등록한다 
				cr2100mVO.setMkType("2");
				//사용성,효능,연구대상자특성 설문인 경우 구성쪽수를 1로 설정한다 코드번호 변경불가 - 설문문항에 따른 구성쪽수 변동 고려할 것
				if(cr2110mVO.getTempType().equals("4000")) {//연구대상자특성
					cr2100mVO.setUpageCnt(totalpage);
				}else if(cr2110mVO.getTempType().equals("4010")) {//사용성설문
					cr2100mVO.setUpageCnt(totalpage);
				}else if(cr2110mVO.getTempType().equals("4020")) {//효능설문
					cr2100mVO.setUpageCnt(totalpage);
				}
				tempNo = ech0210DAO.insertEch0210(cr2100mVO);
				cr2100mVO.setTempNo(tempNo);
				cr2110mVO.setTempNo(tempNo);
				
				//첨부파일 Upload 
				List<FileInfoVO> fileInfoList = fileUtil.totUploadFiles(request, "UBI4\\TMPL");
				
				//첨부파일관리 CT7000M 등록 
				if(fileInfoList != null){        
					for(FileInfoVO fileInfoVO : fileInfoList){
						Ct7000mVO attachVO = new Ct7000mVO(fileInfoVO);
						attachVO.setBoardType("UBI4\\TMPL");
						attachVO.setBoardNo(cr2100mVO.getTempNo());
						attachVO.setRegName(EgovUserDetailsHelper.getAuthenticatedAdminId());
						attachVO.setRegDate(EgovStringUtil.getDateMinus());
						attachVO.setFileKey("attachRpt01");
						cmmDAO.insertAttachFile(attachVO);
						
						//페이지 구성쪽수 Update 처리 Start
						//param1 regFileName, param2 
						String appName = StrUtil.nvl(request.getContextPath(), "");
						if( "/".equals(appName) )
							appName = "";
						String appUrl = request.getScheme() + "://" + request.getServerName() + ":" + request.getServerPort() + appName;
						
						String UPLOAD_HOME = propertyService.getString("Globals.fileStorePath.attachedFile");
						File uFile = new File(UPLOAD_HOME, attachVO.getRegFileName());
						LOGGER.debug("uFile= "+uFile);
						
						String savePath = UPLOAD_HOME;
						
						String saveFileName = "";
						String saveFullPath = "";
						String typePath = "";
						
						saveFileName = EgovStringUtil.getTimeStamp() + "." + "pdf";
						LOGGER.debug("saveFileName= "+saveFileName);
						
						saveFullPath = savePath + saveFileName;
						
						//UI에서 호출될 때 필요한 정보 - 사용안함
						String jrf = StrUtil.nvl(request.getParameter("jrf"), "ubi_sample.jrf");
						String arg = StrUtil.nvl(request.getParameter("arg"), "user#홍길동#company#유비디시전#");

						//환경에 맞게 설정해야함
						String rootUrl = appUrl;
						String serverUrl = (appUrl + "/UbiServer");
						String fileUrl = (appUrl + "/ubi4/resource");
						String resource = "fixed";
						//String jrfDir = (appPath + "/ubi4/work/");
						String dataSource = "Tutorial";

						String exportFileType = "PDF";
						//String exportPath = appPath + "/ubi4/storage/";
						String exportFileName = jrf.substring(0, jrf.lastIndexOf(".")) + ".pdf";
						//String exportFilePath = exportPath + java.io.File.separator + exportFileName;
						
						String exportFilePath = saveFullPath;
						
						UbiViewer ubi = new UbiViewer(false, false);
						
						ubi.exectype = "TYPE6";
						//ubi.fileURL = fileUrl;
						ubi.resource = resource;
						ubi.ubiServerURL = serverUrl;
						ubi.isLocalFile = true;
						ubi.dataSource = dataSource;
						//ubi.jrfFileDir = "D:/WAS_JAVA/FactCTMS_HNB/Files/upload/attach/UBI4/TMPL/";
						ubi.jrfFileDir = UPLOAD_HOME+"/UBI4/TMPL/";
						
						String regFileName = "";
						regFileName = attachVO.getRegFileName();
						int pos = regFileName.lastIndexOf( "\\" );
						regFileName = regFileName.substring( pos + 1 );
						
						ubi.jrfFileName = regFileName;
						
						LOGGER.debug("regFileName= "+regFileName);
						
						ubi.arg = arg;				
						
						ubi.setExportParams(exportFileType, exportFilePath);
						
						boolean isSuccess = ubi.loadReport();
						//out.clearBuffer();
						
						PDDocument doc = PDDocument.load(new File(savePath, saveFileName));
						int count = doc.getNumberOfPages();
						doc.close();
						
						LOGGER.debug("pdf count="+count);	
						
						//구성페이지수를 업데이트 한다. CR2100M UPAGE_CNT 
						cr2100mVO.setUpageCnt(Integer.toString(count));
						ech0210DAO.updateEch0210UpageCnt(cr2100mVO);
						
						//생성된  pdf파일을 삭제한다.
						fileUtil.deleteFile("/"+saveFileName);
						
						//페이지 구성쪽수 Update 처리 End
					}
		        }
			}else {
				if(cr2110mVO.getTempType().equals("4000")) {//연구대상자특성
					cr2100mVO.setUpageCnt(totalpage);
					//구성페이지수를 업데이트 한다. CR2100M UPAGE_CNT 
					ech0210DAO.updateEch0210UpageCnt(cr2100mVO);

				}else if(cr2110mVO.getTempType().equals("4010")) {//사용성설문
					cr2100mVO.setUpageCnt(totalpage);
					//구성페이지수를 업데이트 한다. CR2100M UPAGE_CNT 
					ech0210DAO.updateEch0210UpageCnt(cr2100mVO);

				}else if(cr2110mVO.getTempType().equals("4020")) {//효능설문
					cr2100mVO.setUpageCnt(totalpage);
					//구성페이지수를 업데이트 한다. CR2100M UPAGE_CNT 
					ech0210DAO.updateEch0210UpageCnt(cr2100mVO);

				}
			}
	   				
	   		//CRF설정 등록 CR2110M	
			cr2110mVO.setCorpCd(EgovUserDetailsHelper.getAuthenticatedAdminCorpCd());
			cr2110mVO.setSvCnt("1");
			cr2110mVO.setSvStdt(EgovStringUtil.getDateMinus());
			cr2110mVO.setSvEndt("9999-12-31");
			cr2110mVO.setMtCls("");
			cr2110mVO.setContent(cr2110mVO.getTitle());
			cr2110mVO.setDataRegdt(EgovStringUtil.getDateMinus());
			cr2110mVO.setDataRegnt(EgovUserDetailsHelper.getAuthenticatedAdminId());		
					
	   		ech0211DAO.insertech0211eCRF(cr2110mVO);
	   	
	   		message = "등록한 CRF설정 차수정보를 저장하였습니다.";
	   		
	   		//설정된 CRF작성차수의 시작번호 재설정
	   		if(resetSpageCnt(EgovUserDetailsHelper.getAuthenticatedAdminCorpCd(), cr2110mVO.getRsNo())) {
	   			message = "등록한 CRF설정 차수정보를 저장하였습니다.";
	   		}else {
	   			message = "CRF작성차수 등록오류(시작번호 설정)가 발생하였습니다.";
	   		}
	   		
	   		//시작페이지 설정 
	   		//등록된 연구과제의 CRF list 획득
	    	//EgovMap paramMap3 = new EgovMap();
	    	//paramMap3.put("corpCd", EgovUserDetailsHelper.getAuthenticatedAdminCorpCd());
	    	//paramMap3.put("rsNo", cr2110mVO.getRsNo());
	        
	        //List<EgovMap> eCrfList = ech0211DAO.selectEch0211eCrfList(paramMap3);
	        //EgovMap paramMap4 = new EgovMap();
	        //int startPage = 0;
	        //for(EgovMap crfMap  : eCrfList){
	    		//paramMap4.put("corpCd", EgovUserDetailsHelper.getAuthenticatedAdminCorpCd());
	        	//paramMap4.put("rsNo", crfMap.get("rsNo"));
	        	//paramMap4.put("svSeq", crfMap.get("svSeq"));
	        	//if(crfMap.get("svSeq").equals(1)) {
	        		//startPage = 1;
	        	//}else {	
	                //int tusePageCnt = ech0211DAO.selectEcr0211TUsePageCnt(paramMap4);
	                //startPage = tusePageCnt + 1;
	        	//}
	        	//paramMap4.put("tempNo", crfMap.get("tempNo"));
	        	//paramMap4.put("spageCnt", startPage);
	        	//ech0211DAO.updateEch0211SpageCnt(paramMap4);
	        //}
	        
	        //연구과제에 연결됭 CRF 템플릿의 구성쪽수 UPAGE_CNT의 합계를  연구계획서 RS1010M TPAGE_CNT에 Update한다.
	        //구성쪽수 합계산출
	        EgovMap paramMap2 = new EgovMap();
	    	paramMap2.put("corpCd", EgovUserDetailsHelper.getAuthenticatedAdminCorpCd());
	    	paramMap2.put("rsNo", cr2110mVO.getRsNo());
	    	paramMap2.put("svSeq", 9999);
	    	//CR2110M CR2100M 참조 
	        int tusePageCnt = ech0211DAO.selectEcr0211TUsePageCnt(paramMap2);
	        
	        if(tusePageCnt >= 0) {
	        	//총구성쪽수 Update RS1010M
	        	LOGGER.debug("tusePageCnt = " + tusePageCnt);
	        	rs1000mVO.setCorpCd(EgovUserDetailsHelper.getAuthenticatedAdminCorpCd());
	        	rs1000mVO.setRsNo(cr2110mVO.getRsNo());
	        	rs1000mVO.setTpageCnt(Integer.toString(tusePageCnt));
	            ech0211DAO.updateEch0211TpageCnt(rs1000mVO);	
	        }
	   		        
	        rtCd = "";
   		}
        
        model.addAttribute("message", message);
        model.addAttribute("rtCd", rtCd);
        
		return jsonView;  		
   		
   	}
   	
   	// CRF작성차수 재설정 
   	@RequestMapping("/qxsepmny/ech0211/ech0211AjaxResetSvSeq.do")
   	public View ech0211AjaxResetSvSeq(String cordpCd, String rsNo, String[] svSeq, Cr2110mVO cr2110mVO, HttpServletRequest request, RedirectAttributes reda, ModelMap model) throws Exception{
   		LOGGER.debug("/qxsepmny/ech0211/ech0211AjaxResetSvSeq.do - CRF작성차수 재설정");
   		String message = "";
   		
   		EgovMap map = new EgovMap();
   		map.put("svSeq",svSeq);
   		
   		String orgSvSeqData = "";
   		int svSeqLen = svSeq.length - 1;
   		
   		EgovMap map2 = new EgovMap();
   		EgovMap resultMap = new EgovMap();
   		int j = 1;
   		for(int i=0; i<svSeqLen; i++) {
   			orgSvSeqData = svSeq[i];
   			
			map2.put("corpCd", EgovUserDetailsHelper.getAuthenticatedAdminCorpCd());
   			map2.put("rsNo", rsNo);
   			map2.put("orgSvSeqData", orgSvSeqData);
   			
   			//변경대상 CRF설정정보를 저장한다.
   			Cr2110mVO cr2110mVOList = ech0211DAO.selectEch0211CrfDetail(map2);
   			
			resultMap.put(Integer.toString(j), cr2110mVOList);
			j++;
   			
   		}
   		
   		//변경대상 CRF설정정보를 삭제한다. CR2110M
   		EgovMap paramMap = new EgovMap();
    	paramMap.put("corpCd", EgovUserDetailsHelper.getAuthenticatedAdminCorpCd());
    	paramMap.put("rsNo", rsNo);
    	//RS_NO로 설정된 CRF 모두 삭제 CR2110M
    	ech0211DAO.deleteech0211eCRF(paramMap);
   		
   		//CRF작성차수 재설정 정보 확인
   		j = 1;

   		for(int i=0; i<svSeqLen; i++) {
   			cr2110mVO = (Cr2110mVO)resultMap.get(Integer.toString(j));
   			
   			// CRF작성순번 변경
   			cr2110mVO.setSvSeq(Integer.toString(j));
   			LOGGER.debug("cr2110mVO= "+cr2110mVO.toString());

   			//CRF작성차수 재설정 insert -> CR2110M
   			ech0211DAO.insertech0211eCRF(cr2110mVO);
   			j++;
   		}
   		
   		message = "CRF작성차수를 재설정되었습니다.";
   		
   		//설정된 CRF작성차수의 시작번호 재설정
   		if(resetSpageCnt(EgovUserDetailsHelper.getAuthenticatedAdminCorpCd(), rsNo)) {
   			message = "CRF작성차수를 재설정되었습니다.";
   		}else {
   			message = "CRF작성차수 재설정오류(시작번호 설정)가 발생하였습니다.";
   		}
   		
   		//시작페이지 설정 
   		//등록된 연구과제의 CRF list 획득
    	//EgovMap paramMap3 = new EgovMap();
    	//paramMap3.put("corpCd", EgovUserDetailsHelper.getAuthenticatedAdminCorpCd());
    	//paramMap3.put("rsNo", cr2110mVO.getRsNo());
        
        //List<EgovMap> eCrfList = ech0211DAO.selectEch0211eCrfList(paramMap3);
        //EgovMap paramMap4 = new EgovMap();
        //int startPage = 0;
        //for(EgovMap crfMap  : eCrfList){
    		//paramMap4.put("corpCd", EgovUserDetailsHelper.getAuthenticatedAdminCorpCd());
        	//paramMap4.put("rsNo", crfMap.get("rsNo"));
        	//paramMap4.put("svSeq", crfMap.get("svSeq"));
        	//if(crfMap.get("svSeq").equals(1)) {
        		//startPage = 1;
        	//}else {	
                //int tusePageCnt = ech0211DAO.selectEcr0211TUsePageCnt(paramMap4);
                //startPage = tusePageCnt + 1;
        	//}
        	//paramMap4.put("tempNo", crfMap.get("tempNo"));
        	//paramMap4.put("spageCnt", startPage);
        	//ech0211DAO.updateEch0211SpageCnt(paramMap4);
        //}
   		
   		model.addAttribute("message", message);
   		
   		return jsonView;
   		
   	}
   	
   	// CRF시작 페이지 번호 설정
   	private boolean resetSpageCnt(String corpCd, String rsNo){
   		boolean flag = false;
   		//시작페이지 설정 
   		//등록된 연구과제의 CRF list 획득
    	EgovMap paramMap3 = new EgovMap();
    	paramMap3.put("corpCd", EgovUserDetailsHelper.getAuthenticatedAdminCorpCd());
    	paramMap3.put("rsNo", rsNo);
        
        List<EgovMap> eCrfList = null;
		try {
			eCrfList = ech0211DAO.selectEch0211eCrfList(paramMap3);
		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
			flag = false;
			return flag;
		}
		
        EgovMap paramMap4 = new EgovMap();
        int startPage = 0;
        for(EgovMap crfMap  : eCrfList){
    		paramMap4.put("corpCd", EgovUserDetailsHelper.getAuthenticatedAdminCorpCd());
        	paramMap4.put("rsNo", crfMap.get("rsNo"));
        	paramMap4.put("svSeq", crfMap.get("svSeq"));
        	if(crfMap.get("svSeq").equals(1)) {
        		startPage = 1;
        	}else {	
                int tusePageCnt;
				try {
					tusePageCnt = ech0211DAO.selectEcr0211TUsePageCnt(paramMap4);
					startPage = tusePageCnt + 1;
				} catch (Exception e) {
					// TODO Auto-generated catch block
					e.printStackTrace();
					flag = false;
					return flag;
				}
        	}
        	paramMap4.put("tempNo", crfMap.get("tempNo"));
        	paramMap4.put("spageCnt", startPage);
        	try {
				ech0211DAO.updateEch0211SpageCnt(paramMap4);
				flag = true;
			} catch (Exception e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
				flag = false;
				return flag;
			}
        }
   		
		return flag;
			
	}
   	
   	// 안전성평가CRF생성(피부자극) 
   	@RequestMapping("/qxsepmny/ech0211/ech0211AjaxAddCrfSkinStim.do")
   	public View ech0211AjaxAddCrfSkinStim(String cordpCd, String rsNo, String step1, String step2, Rs1000mVO rs1000mVO, Cr2100mVO cr2100mVO, Cr2110mVO cr2110mVO, Cr2050mVO cr2050mVO, Cr2060mVO cr2060mVO, HttpServletRequest request, RedirectAttributes reda, ModelMap model) throws Exception{
   		LOGGER.debug("/qxsepmny/ech0211/ech0211AjaxAddCrfSkinStim.do - 안전성평가CRF생성(피부자극)");
   		String message = "";
   		
   		LOGGER.debug("rsNO= "+rsNo);
   		LOGGER.debug("step1= "+step1); //사용CRF명칭 - 첩포 제거 30분후, 첩포 제거 24시간 후
   		EgovMap map = new EgovMap();
   		map.put("corpCd", EgovUserDetailsHelper.getAuthenticatedAdminCorpCd());
   		map.put("rsNo", rsNo);
   		
   		//연구과제에 등록된 시험물질 정보를 획득한다 RS1010M, RS1040M(MRS_NO-N.C인 경우 중복제외)
   		List<EgovMap> rsNoMtlList = ech0211DAO.selectEch0211RsNoMtlList(map);
   		   		
   		//CR2100M
   		//CRF템플릿 등록 CR2100M - TEMP_NO 설정
		cr2100mVO.setUseYn("Y");
		
		//구성쪽수 설정  - 피부자극 시험물질 갯수에 따라 변경 구성쪽수 설정함  
		//연구과제의 시험물질 갯수 확인 
		LOGGER.debug("rsNoMtlList.size()= "+rsNoMtlList.size());
		if(rsNoMtlList == null || rsNoMtlList.size() < 1) {
			message = "시험물질이 등록되여 있지 않습니다. 시험물질를 먼저 등록해주세요.";
		}else {
			
			//질문갯수로 구성쪽수 산출
			int mtlCnt = 1;
			
			if(rsNoMtlList.size() < 11) {
				mtlCnt = 1;
				
			}else {
				int setCnt = rsNoMtlList.size() - 10; 
				mtlCnt = Math.floorDiv(setCnt,10) + mtlCnt; // 몫
				if(Math.floorMod(setCnt,10) > 0) { //나머지가 0 보다 크면 페이지수 1 증가
					mtlCnt++;
				}	
			}
			
			cr2100mVO.setUpageCnt(Integer.toString(mtlCnt));
				
			//cr2100mVO.setUpageCnt("1"); //양식 조정, 시험물질수에 따라 구성쪽수를 가변적으로 설정해야 함 
			
			cr2100mVO.setTempNm("피부자극평가");
			cr2100mVO.setRemk("피부자극평가");
			cr2100mVO.setEmpNo(EgovUserDetailsHelper.getAuthenticatedAdminEmpNo());
			cr2100mVO.setBranchCd(EgovUserDetailsHelper.getAuthenticatedAdminBranchCd());
			cr2100mVO.setStDate(EgovStringUtil.getDateMinus());
			cr2100mVO.setEdDate("9999-12-31");
			cr2100mVO.setTempType("4080");            		
			cr2100mVO.setCorpCd(EgovUserDetailsHelper.getAuthenticatedAdminCorpCd());
			cr2100mVO.setTempNo1("CRF");
			cr2100mVO.setRegDt(EgovStringUtil.getDateMinus());
			cr2100mVO.setDataRegnt(EgovUserDetailsHelper.getAuthenticatedAdminId());
			cr2100mVO.setMkType("2");
			
			//평가주기 설정  1 30분후 2 24시간후 - 추가 2021.9.6 H 
			cr2100mVO.setSrType(step2);
			
			String tempNo = ech0210DAO.insertEch0210(cr2100mVO);
					
			//CRF설정 등록 CR2110M
			cr2110mVO.setCorpCd(EgovUserDetailsHelper.getAuthenticatedAdminCorpCd());
			cr2110mVO.setRsNo(rsNo);
			cr2110mVO.setTempNo(tempNo);
			cr2110mVO.setSvCnt("1");
			cr2110mVO.setSvStdt(EgovStringUtil.getDateMinus());
			cr2110mVO.setSvEndt("9999-12-31");
			cr2110mVO.setMtCls("");
			cr2110mVO.setContent(step1);
			cr2110mVO.setTitle(step1);
			cr2110mVO.setDataRegdt(EgovStringUtil.getDateMinus());
			cr2110mVO.setDataRegnt(EgovUserDetailsHelper.getAuthenticatedAdminId());		
			
			//작성차수 설정 SV_SEQ
			int nextSvSeq = 0;
			
			//CRF설정 작성차수 등록여부 확인 cnt
			int svSeqCnt = ech0211DAO.selectEch0211ChkSvSeqCnt(map);
			
			if(svSeqCnt == 0) {
				nextSvSeq = 1;
			}else {	
				nextSvSeq = ech0211DAO.selectEch0211NextSvSeq(map);
			}

			cr2110mVO.setSvSeq(Integer.toString(nextSvSeq));
			
	   		ech0211DAO.insertech0211eCRF(cr2110mVO);
			
	   		for(EgovMap crfMap  : rsNoMtlList){   			
	   			
	   			//crfMap.get("corpCd");
	   			//crfMap.get("rsNo");
	   			//crfMap.get("mtlDsp");
	   			//crfMap.get("mtlName");
	   			
		   		//질문항목 등록 - 시험물질   		
		   		cr2050mVO.setCorpCd(EgovUserDetailsHelper.getAuthenticatedAdminCorpCd());
		   		cr2050mVO.setTempNo(tempNo);
		   		cr2050mVO.setQuesNm("");
		   		cr2050mVO.setQuesType("S");
		   		cr2050mVO.setUseYn("Y");
		   		cr2050mVO.setQuesAbb((String)crfMap.get("mtlDsp")+crfMap.get("mtlName"));
		   		cr2050mVO.setQuesCon((String)crfMap.get("mtlDsp"));
		   		cr2050mVO.setDataRegnt(EgovUserDetailsHelper.getAuthenticatedAdminId());
		    	
		    	//질문항목 등록 CR2050M 
		    	String quesNo = ech0202DAO.insertech0202Ques(cr2050mVO);
		    	
		   		//CR2060M 0 0.5 1 2 3 4 5 - 7개 질문
		    	for(int i=0; i<7; i++) {
		    		cr2060mVO.setCorpCd(EgovUserDetailsHelper.getAuthenticatedAdminCorpCd());
		    		cr2060mVO.setTempNo(tempNo);
		    		cr2060mVO.setQuesNo(quesNo);
		    		cr2060mVO.setAnswSort(Integer.toString(i));
		    		if(i == 0) {
		    			cr2060mVO.setAnswCon("0");
		    		}else if(i == 1) {
		    			cr2060mVO.setAnswCon("0.5");
		    		}else if(i == 2) {
		    			cr2060mVO.setAnswCon("1");
		    		}else if(i == 3) {
		    			cr2060mVO.setAnswCon("2");
		    		}else if(i == 4) {
		    			cr2060mVO.setAnswCon("3");
		    		}else if(i == 5) {
		    			cr2060mVO.setAnswCon("4");
		    		}else if(i == 6) {
		    			cr2060mVO.setAnswCon("5");
		    		}
		    		
		    		//질문에 대한 답변항목 등록
		    		ech0202DAO.insertech0202Answ(cr2060mVO);
		    	}
	    	
	   		}
	   		
	   		//설정된 CRF작성차수의 시작번호 재설정
	   		if(resetSpageCnt(EgovUserDetailsHelper.getAuthenticatedAdminCorpCd(), rsNo)) {
	   			message = "피부자극평가 CRF양식이 자동설정되었습니다. "+"시험물질수= "+rsNoMtlList.size()+", 구성쪽수= "+mtlCnt;
	   		}else {
	   			message = "CRF작성차수 등록오류(시작번호 설정)가 발생하였습니다.";
	   		}
	   		
	   		//연구과제에 연결됭 CRF 템플릿의 구성쪽수 UPAGE_CNT의 합계를  연구계획서 RS1010M TPAGE_CNT에 Update한다.
	        //구성쪽수 합계산출
	        EgovMap paramMap2 = new EgovMap();
	    	paramMap2.put("corpCd", EgovUserDetailsHelper.getAuthenticatedAdminCorpCd());
	    	paramMap2.put("rsNo", rsNo);
	    	paramMap2.put("svSeq", 9999);
	    	//CR2110M CR2100M 참조 
	        int tusePageCnt = ech0211DAO.selectEcr0211TUsePageCnt(paramMap2);
	        
	        if(tusePageCnt >= 0) {
	        	//총구성쪽수 Update RS1010M
	        	LOGGER.debug("tusePageCnt = " + tusePageCnt);
	        	rs1000mVO.setCorpCd(EgovUserDetailsHelper.getAuthenticatedAdminCorpCd());
	        	rs1000mVO.setRsNo(cr2110mVO.getRsNo());
	        	rs1000mVO.setTpageCnt(Integer.toString(tusePageCnt));
	            ech0211DAO.updateEch0211TpageCnt(rs1000mVO);
	            message = "피부자극평가 CRF양식이 자동설정되었습니다. "+"시험물질수= "+rsNoMtlList.size()+", 구성쪽수= "+mtlCnt;
	        }
			
		}
   		
   		model.addAttribute("message", message);
   		
   		return jsonView;
   		
   	}
   
  	
}