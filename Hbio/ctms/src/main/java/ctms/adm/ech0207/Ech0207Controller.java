package ctms.adm.ech0207;
 
import java.util.ArrayList;
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
import org.springframework.web.multipart.MultipartHttpServletRequest;
import org.springframework.web.servlet.View;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import ch.qos.logback.core.net.SyslogOutputStream;
import ctms.valueObject.AdminVO;
import ctms.valueObject.Cr2050mVO;
import ctms.valueObject.Cr2060mVO;
import ctms.valueObject.Cr2100mVO;
import ctms.valueObject.Cr2110mVO;
import ctms.valueObject.Cr3100mVO;
import ctms.valueObject.Cr3110mVO;
import ctms.valueObject.Ct7000mVO;
import ctms.valueObject.Rs1000mVO;
import component.excel.ExcelUtil;
import component.file.CmmnFileMngUtil;
import component.file.FileInfoVO;
import component.web.PaginationController;
import ctms.adm.cmm.AdmCmmController;
import ctms.adm.ech0101.Ech0101Controller;
import ctms.adm.ech0101.Ech0101DAO;
import ctms.cmm.CmmDAO;
import ctms.valueObject.cmm.CmmnListVO;
import ctms.valueObject.cmm.CmmnSearchVO;
import egovframework.com.cmm.util.EgovUserDetailsHelper;
import egovframework.let.utl.fcc.service.EgovStringUtil;
import egovframework.rte.fdl.property.EgovPropertyService;
import egovframework.rte.psl.dataaccess.util.EgovMap;
import egovframework.rte.ptl.mvc.tags.ui.pagination.PaginationInfo;
 
	@Controller
	public class Ech0207Controller extends AdmCmmController{
	 
	    private static final Logger LOGGER = LoggerFactory.getLogger(Ech0207Controller.class);
	    @Autowired private Ech0207DAO ech0207dao;
	    @Autowired private CmmDAO cmmDAO;
	    @Resource private CmmnFileMngUtil fileUtil;
	    @Resource private View jsonView;
	 
	    @Resource(name = "propertiesService") protected EgovPropertyService propertyService;
	 
	    //피부자극결과 목록화면으로 리다이렉트합니다.
	    private String redirectEch0207List(RedirectAttributes reda, String message){
	        reda.addFlashAttribute("message", message);
	        return "redirect:/qxsepmny/ech0207/ech0207List.do";
	    }
	    //피부자극결과 뷰화면으로 리다이렉트합니다.

	    private String redirectEch0207View(RedirectAttributes reda, String message){
	        reda.addFlashAttribute("message", message);
	        return "redirect:/qxsepmny/ech0207/ech0207View.do";
	    }
	    /**
	     * 피부자극결과 목록
	     *
	     * @param model
	     * @return 피부자극결과 목록화면
	     * @throws Exception
	     */
	    @RequestMapping("/qxsepmny/ech0207/ech0207List.do")
	    public String admech0207List(@ModelAttribute("searchVO") CmmnSearchVO searchVO, String searchCondition5 ,HttpServletRequest request, ModelMap model ) throws Exception {
	        LOGGER.debug("/qxsepmny/ech0207/ech0207List.do - 피부자극결과 목록");
	        LOGGER.debug("searchVO = " + searchVO.toString());
	        //request.getSession().setAttribute("usrMenuNo", "101");   // 변경할것
	    
	        
			
			//세션 호출
			AdminVO adminVO = (AdminVO) request.getSession().getAttribute("adminSessionCtms");
			
			
			//엑셀다운로드 권한 설정 Y 허용  N 허용안함 
			model.addAttribute("exauth", adminVO.getExauth());
			
			//회사코드 설정
			searchVO.setCorpCd(adminVO.getCorpCd());
			
			//소속지사 설정 - 소속지사가 설정되면 해당 지사의 연구과제 목록만 표시 
			
			//검색항목 설정 시작
			
			//연도목록
			List<String> yearList = cmmDAO.selectYearList();
			model.addAttribute("yearList", yearList);
			
			
			EgovMap map = new EgovMap();
			
			map.put("searchYear", searchVO.getSearchYear());
			map.put("corpCd", EgovUserDetailsHelper.getAuthenticatedAdminCorpCd());

			List<EgovMap> yearRsCdList = cmmDAO.selectCmmYearRsCdList(map);
			
			model.addAttribute("yearRsCdList", yearRsCdList);
			

			//연구상태(공통코드) 목록 searchCondition6
			
			List<EgovMap> ct2050 = cmmDAO.selectCmmCdList(searchVO.getCorpCd(), "CT2050");
			model.addAttribute("ct2050", ct2050);
			
			//사용여부(DEL_YN) searchCondition5
			model.addAttribute("selected",searchCondition5);
			
			//-- 검색항목 설정 끝
	        
	        PaginationInfo paginationInfo = PaginationController.getPaginationInfo(searchVO);
	        CmmnListVO listVO = ech0207dao.selectAdmEch0207List(searchVO);

	        paginationInfo.setTotalRecordCount(listVO.getTotalRecordCount());
			
			model.addAttribute("resultList", listVO.getEgovList());
			model.addAttribute("paginationInfo", paginationInfo);		
			model.addAttribute("totalCount", paginationInfo.getTotalRecordCount());
			model.addAttribute("currentPageNo", paginationInfo.getCurrentPageNo());
			model.addAttribute("totalPageCount", paginationInfo.getTotalPageCount());
			
	        return "/adm/ech0207/ech0207List";
	    }
	    
	    /**
	     * 피부자극결과 상세조회
	     *
	     * @param model
	     * @return 피부자극결과 조회화면
	     * @throws Exception
	     */
	    @RequestMapping("/qxsepmny/ech0207/ech0207View.do")
	    public String admech0207View(@ModelAttribute("searchVO") CmmnSearchVO searchVO, String rsNo,HttpServletRequest request, ModelMap model, RedirectAttributes reda) throws Exception {
	        LOGGER.debug("/qxsepmny/ech0207/ech0207View.do - 피부자극결과 조회");
	        LOGGER.debug(" = " );  //변경할것
	        
	        String message ="";
	        Cr3100mVO cr3100mVO = new Cr3100mVO();
	

	        if(!EgovStringUtil.isEmpty(rsNo)){  
	        	// 해당 임상시험참여자와 자극결과테이블의 데이터가 존재하면 리스트를 보여줌
		        List<EgovMap> result = ech0207dao.selectAdmEch0207View(rsNo); 
		        List<EgovMap> resultUpdate = ech0207dao.selectAdmEch0207ViewUpdate(rsNo); 
		        List<EgovMap> resultUpdate2 = ech0207dao.selectAdmEch0207ViewUpdateCR3100M(rsNo); 

		        model.addAttribute("resultList", result);
		        model.addAttribute("resultNew", resultUpdate);
		        model.addAttribute("resultNew2", resultUpdate2);

	            // 조인된 테이블에 데이터가 맞지않으면 
		        if(result.size() ==0){
		        	
		        	List<EgovMap> resultView= ech0207dao.selectAdmEch0207ViewNoOne(rsNo);       	
		        	model.addAttribute("resultList2", resultView);
		        	//CR3110M 초기값설정
        			ech0207dao.insertAdmEch0207(rsNo);	
        			//CR3100M 초기값 설정
        			ech0207dao.insertCR3100mAdmEch0207(rsNo);	
        			
        		
		        	if(resultView.size() > 0){
		        			
		        		  if(resultView.get(0).get("mtlNo").toString().equals("0")||resultView.get(0).get("mtlNo").toString().equals(null)){
		        			  message = "시험물질이 존재하지않습니다.";
		        			  
				        	 return redirectEch0207List(reda, message);
		        		  }
		        		
		        	}
		        	 
		        }
	        }else{
	            //String message = "존재하지 않는 피부자극결과입니다.";
	           // return redirectEch0207List(reda, message);
	        }
	
	        return "/adm/ech0207/ech0207View";
	    }
	    
	    /**
	     * 피부자극결과 새로운피험자 추가기능
	     *
	     * @param model
	     * @return 피부자극결과 상세보기
	     * @throws Exception
	     */
	    @RequestMapping("/qxsepmny/ech0207/ech0207ViewUpdate.do")
	    public String admech0207ViewUpdate(@ModelAttribute("searchVO") CmmnSearchVO searchVO,HttpServletRequest request, ModelMap model, RedirectAttributes reda) throws Exception {
	        LOGGER.debug("/qxsepmny/ech0207/ech0207ViewUpdate.do - 피부자극결과 조회");
	        LOGGER.debug(" = " );  //변경할것
	        
	        AdminVO adminVO = (AdminVO) request.getSession().getAttribute("adminSessionCtms");
	        String rsjNo = request.getParameter("rsjNo");
	        String rsNo = request.getParameter("rsNo");
	        String rsiNo = request.getParameter("rsiNo");
	        String mtlDsp = request.getParameter("mtlDsp");
	        String mtlNo = request.getParameter("mtlNo");
	        String ncYn = request.getParameter("ncYn");

	        List<EgovMap> resultUpdate2 = ech0207dao.selectAdmEch0207ViewUpdateCR3100M(rsNo); 
	        for(int i =0; i<resultUpdate2.size(); i++){
	        	Cr3100mVO cr3100mVO = new Cr3100mVO();
		        cr3100mVO.setCorpCd(adminVO.getCorpCd());
		        cr3100mVO.setBrsjNo(resultUpdate2.get(i).get("rsiNo").toString());
		        cr3100mVO.setRsjNo(resultUpdate2.get(i).get("rsjNo").toString());
		        cr3100mVO.setRsNo(resultUpdate2.get(i).get("rsNo").toString());
		        cr3100mVO.setMtlNo(resultUpdate2.get(i).get("mtlNo").toString());
		        cr3100mVO.setMtlDsp(resultUpdate2.get(i).get("mtlDsp").toString());
		        cr3100mVO.setDataRegnt(adminVO.getAdminId());
		        cr3100mVO.setMrsNo(resultUpdate2.get(i).get("mrsNo").toString());
		        cr3100mVO.setNcYn(resultUpdate2.get(i).get("ncYn").toString());
		        ech0207dao.insertNewCR3100mAdmEch0207(cr3100mVO);
	        }
	        List<EgovMap> resultUpdate = ech0207dao.selectAdmEch0207ViewUpdate(rsNo); 
	        for(int i =0; i<resultUpdate.size(); i++){
	        	Cr3110mVO cr3110mVO = new Cr3110mVO();
		        cr3110mVO.setCorpCd(adminVO.getCorpCd());
		        cr3110mVO.setBrsjNo(resultUpdate.get(i).get("rsiNo").toString());
		        cr3110mVO.setRsjNo(resultUpdate.get(i).get("rsjNo").toString());
		        cr3110mVO.setRsNo(resultUpdate.get(i).get("rsNo").toString());
		        cr3110mVO.setMtlNo(resultUpdate.get(i).get("mtlNo").toString());
		        cr3110mVO.setMtlDsp(resultUpdate.get(i).get("mtlDsp").toString());
		        cr3110mVO.setDataRegnt(adminVO.getAdminId());
		        cr3110mVO.setNcYn(resultUpdate.get(i).get("ncYn").toString());
		        ech0207dao.insertNewAdmEch0207(cr3110mVO);
	        }
	      
	      
            String message = "해당 연구과제의 피험자가 추가되었습니다.";

	        return redirectEch0207View(reda, message);
	    }
	    //임시
	    @RequestMapping("/qxsepmny/ech0207/ech0207ViewUpdate2.do")
	    public View admech0207ViewUpdate2(@ModelAttribute("searchVO") CmmnSearchVO searchVO,HttpServletRequest request, ModelMap model, RedirectAttributes reda) throws Exception {
	        LOGGER.debug("/qxsepmny/ech0207/ech0207ViewUpdate.do - 피부자극결과 조회");
	        LOGGER.debug(" = " );  //변경할것
	        
	        AdminVO adminVO = (AdminVO) request.getSession().getAttribute("adminSessionCtms");
	      
	        
	        String rsjNo2 = request.getParameter("rsjNo2");
	        String rsNo2 = request.getParameter("rsNo2");
	        String rsiNo2 = request.getParameter("rsiNo2");
	        String mtlDsp2 = request.getParameter("mtlDsp2");
	        String mtlNo2 = request.getParameter("mtlNo2");
	        String mrsNo = request.getParameter("mrsNo");
	        String ncYn2 = request.getParameter("ncYn2");
        	
	       if(rsNo2 != null){
		        Cr3100mVO cr3100mVO = new Cr3100mVO();
		        cr3100mVO.setCorpCd(adminVO.getCorpCd());
		        cr3100mVO.setBrsjNo(rsiNo2);
		        cr3100mVO.setRsjNo(rsjNo2);
		        cr3100mVO.setRsNo(rsNo2);
		        cr3100mVO.setMtlNo(mtlNo2);
		        cr3100mVO.setMtlDsp(mtlDsp2);
		        cr3100mVO.setDataRegnt(adminVO.getAdminId());
		        cr3100mVO.setMrsNo(mrsNo);
		        cr3100mVO.setNcYn(ncYn2);
		        ech0207dao.insertNewCR3100mAdmEch0207(cr3100mVO);
	       }
            String message = "해당 연구과제의 피험자가 추가되었습니다.";

	        return jsonView;
	    }	 
	    /**
	     * 피부자극결과 수정&등록화면
	     *
	     * @param model
	     * @return 피부자극결과 수정&등록화면
	     * @throws Exception
	     */
	    // 피부자극결과 팝업 수정/등록화면
	    @RequestMapping("/qxsepmny/ech0207/ech0207Modify.do")
	    public String admech0207Modify(@ModelAttribute("searchVO") Cr3110mVO cr3110mVO, String rsNo ,String rsjNo,String brsjNo,String rsiNo, HttpServletRequest request, ModelMap model ) throws Exception {
	        LOGGER.debug("/qxsepmny/ech0207/ech0207Modify.do - 피부자극결과 수정&등록화면");
	        LOGGER.debug(" = " );  //변경할것

	        cr3110mVO.setRsNo(rsNo);
	        cr3110mVO.setBrsjNo(rsiNo);
	        
	        List<EgovMap> result= ech0207dao.selectAdmEch0207ViewOne(cr3110mVO); 
	        //cr3100mVO = ech0207dao.selectAdmEch0207ViewOne(rsjNo);  //변경할것
	        
	        model.addAttribute("rsiNo", rsiNo);
	        model.addAttribute("rsNo", rsNo);

	        model.addAttribute("resultList", result);
	 
	        return "/adm/ech0207/ech0207Modify";
	    }
	    
	    /**
	     * 피부자극결과 수정&등록화면
	     *
	     * @param model
	     * @return 피부자극결과 수정&등록화면
	     * @throws Exception
	     */
	    @RequestMapping("/qxsepmny/ech0207/ech0207Update.do")
	    public String admech0207Update(@ModelAttribute("cr3110mVO") Cr3110mVO cr3110mVO,String rsNo, String rsiNo,String[]rsNo7, String[]rsNos,String[] mtlDsp ,String []m30Vl1 ,String []h24Vl1,HttpServletRequest request, ModelMap model, RedirectAttributes reda) throws Exception {
	        LOGGER.debug("/qxsepmny/ech0207/ech0207Update.do - 피부자극결과 수정&등록화면");
	        LOGGER.debug("cr3100mVO = " + cr3110mVO.toString());
	        String message = "저장됨";
			AdminVO adminVO = (AdminVO) request.getSession().getAttribute("adminSessionCtms");
			cr3110mVO.setBrsjNo(rsiNo);
			cr3110mVO.setRsNo(rsNo);
			
			Cr3100mVO cr3100mVO = new Cr3100mVO();
			
			for(int i= 0; i<m30Vl1.length; i++){
				cr3110mVO.setMtlDsp(mtlDsp[i]);
				cr3110mVO.setM30Vl1(m30Vl1[i]);
				cr3110mVO.setH24Vl1(h24Vl1[i]);
				if(rsNo7[0] == null || rsNo7[0]==""){
					
					cr3100mVO.setBrsjNo(rsNo7[i+1]);
				}else{
					cr3100mVO.setBrsjNo(rsNo7[i]);

				}
				cr3100mVO.setMtlDsp(mtlDsp[i]);
				cr3100mVO.setM30Vl1(m30Vl1[i]);
				cr3100mVO.setH24Vl1(h24Vl1[i]);
				cr3100mVO.setDataRegnt(adminVO.getAdminId());				
				 
				// RS1010M RS_NO, mtlDSP -> RS1000M의 RS_NO 획득
				// NC인 경우 여러 차수가 동시에 업데이트 됨 2021.08.22 Hong
				cr3100mVO.setBrsjNo(rsiNo);
				cr3100mVO.setCorpCd(EgovUserDetailsHelper.getAuthenticatedAdminCorpCd());
				cr3100mVO.setRsNo(rsNo); // parameter 전달용 
		        LOGGER.debug("cr3100mVO = " + cr3110mVO.toString());
				ech0207dao.updateCR3100mAdmEch0207(cr3100mVO);
				
				ech0207dao.updateAdmEch0207(cr3110mVO);
			}
			

        	cr3110mVO.setDataRegnt(adminVO.getAdminId());

	        return redirectEch0207View(reda, message);
	    }
	    
	    
	    /**
	     * 피부자극결과 삭제
	     *
	     * @param model
	     * @return 피부자극결과 삭제
	     * @throws Exception
	     */
	    @RequestMapping("/qxsepmny/ech0207/ech0207Delete.do")
	    public String admech0207Delete(@ModelAttribute("cr3100mVO") Cr3100mVO cr3100mVO, String rsNo,HttpServletRequest request, ModelMap model, RedirectAttributes reda) throws Exception {
	        LOGGER.debug("/qxsepmny/ech0207/ech0207Delete.do - 피부자극결과 삭제");
	        LOGGER.debug("cr3100mVO = " + cr3100mVO.toString());
	        String message = "";
	        System.out.println(rsNo);
	        
	        if(!EgovStringUtil.isEmpty(rsNo)){  //변경할것
	            ech0207dao.deleteAdmEch0207(rsNo);  //변경할것
	            ech0207dao.deleteCR3100mAdmEch0207(rsNo);  //변경할것

	            message = "해당 피부자극결과의 삭제가 완료되었습니다.";
	        }
	 
	        return redirectEch0207List(reda, message);
	    }
	    
	    /**
	     * 피부자극결과 엑셀다운로드
	     *
	     * @param model
	     * @return 피부자극결과 엑셀다운로드
	     * @throws Exception
	     */
    @SuppressWarnings("unchecked")
    @RequestMapping("/qxsepmny/ech0207/ech0207Excel.do")
    public void ech0207Excel(@ModelAttribute("searchVO") CmmnSearchVO searchVO, HttpServletRequest request, HttpServletResponse response, RedirectAttributes reda, ModelMap model) throws Exception {
        LOGGER.debug("/qxsepmny/entran/ech0207Excel.do - 피부자극결과 엑셀 다운로드");
        LOGGER.debug("searchVO = " + searchVO.toString());
       
        EgovMap dataMap = new EgovMap();
       
        List<EgovMap> resultList = ech0207dao.selectAdmEch0207Excel(searchVO);
        dataMap.put("resultList", resultList);
       
        int num = 1;
        for (EgovMap egovMap : resultList) {
            egovMap.put("number", num);
            num++;
        }
    	AdminVO sessionVO = (AdminVO) EgovUserDetailsHelper.getAuthenticatedAdmin();
		dataMap.put("printUser", sessionVO.getName()+"("+sessionVO.getAdminId()+")");
       
        ExcelUtil excelUtil = new ExcelUtil();
        excelUtil.getPerformanceExcel(dataMap, "피부자극결과 리스트", "ech0207", request, response);
    }
	    
	//피부자극평가(설문)에서 피부자극평가자료(CR3100M, CR3110M) 자동 생성 
   	@RequestMapping("/qxsepmny/ech0207/ech0207AjaxCreateSsResult2.do")
   	public View ech0207AjaxCreateSsResult2(String cordpCd, String rsNo, Cr3100mVO cr3100mVO, Cr3110mVO cr3110mVO, HttpServletRequest request, RedirectAttributes reda, ModelMap model) throws Exception{
   		LOGGER.debug("/qxsepmny/ech0207/ech0207AjaxCreateSsResult.do - 피부자극평가(설문)에서 피부자극평가자료(CR3100M, CR3110M) 자동 생성 ");
   		String message = "";
   		
   		LOGGER.debug("rsNO= "+rsNo);
   		EgovMap map = new EgovMap();
   		map.put("corpCd", EgovUserDetailsHelper.getAuthenticatedAdminCorpCd());
   		map.put("rsNo", rsNo);
   		
   		//피부자극평가 결과 조회 연구 상세
   		List<EgovMap> ssResultList = ech0207dao.selectEch0207RsSeqSsResultList(map);
		
   		for(EgovMap crfMap  : ssResultList){   			
			EgovMap sMap = new EgovMap();
   			sMap.put("corpCd", EgovUserDetailsHelper.getAuthenticatedAdminCorpCd());
   			sMap.put("rsNo", (String)crfMap.get("rsNo"));
   			sMap.put("rsjNo", "999999");
   			sMap.put("mtlDsp", (String)crfMap.get("mtlDsp"));
   			sMap.put("brsjNo", (String)crfMap.get("brsjNo"));
   			
   			int resultChkCnt = ech0207dao.selectEch0207ResultChkCnt(sMap);
   			
   			if(resultChkCnt > 0 ) {
   				
   	   			cr3110mVO = ech0207dao.selectEch0207RsResult(sMap);	
   				//자극점수 환산 0 0.5 1 2 3 4 5 6
   	   			String vl = "0";
   	   			if(crfMap.get("answNum").equals("1")) {
   	   				vl = "0";
   	   			}else if(crfMap.get("answNum").equals("2")) {
   	   				vl = "0.5";
   	   			}else if(crfMap.get("answNum").equals("3")) {
   	   				vl = "1";
   	   			}else if(crfMap.get("answNum").equals("4")) {
   	   				vl = "2";
   	   			}else if(crfMap.get("answNum").equals("5")) {
   	   				vl = "3";
   	   			}else if(crfMap.get("answNum").equals("6")) {
   	   				vl = "4";
   	   			}else if(crfMap.get("answNum").equals("7")) {
   	   				vl = "5";
   	   			}
   	   			
   	   			if(crfMap.get("srType").equals("1")) {
   	   				cr3100mVO.setM30Vl1(vl);
   	   			}else if(crfMap.get("srType").equals("2")) {
   	   				cr3100mVO.setH24Vl1(vl);
   	   			}
   	   			
   	   			ech0207dao.updateEch0207RsSeqSsResult(cr3100mVO);   	   			
   				
   				
   			}else {
   				cr3100mVO.setCorpCd(EgovUserDetailsHelper.getAuthenticatedAdminCorpCd());
   	   			cr3100mVO.setRsNo((String)crfMap.get("rsNo"));
   	   			cr3100mVO.setRsjNo("999999");   			
   	   			cr3100mVO.setMtlDsp((String)crfMap.get("mtlDsp"));
   	   			cr3100mVO.setBrsjNo((String)crfMap.get("brsjNo"));
   	   			
   				//자극점수 환산 0 0.5 1 2 3 4 5 6
   	   			String vl = "0";
   	   			if(crfMap.get("answNum").equals("1")) {
   	   				vl = "0";
   	   			}else if(crfMap.get("answNum").equals("2")) {
   	   				vl = "0.5";
   	   			}else if(crfMap.get("answNum").equals("3")) {
   	   				vl = "1";
   	   			}else if(crfMap.get("answNum").equals("4")) {
   	   				vl = "2";
   	   			}else if(crfMap.get("answNum").equals("5")) {
   	   				vl = "3";
   	   			}else if(crfMap.get("answNum").equals("6")) {
   	   				vl = "4";
   	   			}else if(crfMap.get("answNum").equals("7")) {
   	   				vl = "5";
   	   			}
   	   			   	   			
   	   			if(crfMap.get("srType").equals("1")) {
   	   				cr3100mVO.setM30Vl1(vl);
   	   				cr3100mVO.setH24Vl1("0");
   	   			}else if(crfMap.get("srType").equals("2")) {
   	   				cr3100mVO.setH24Vl1(vl);
   	   				cr3100mVO.setM30Vl1("0");
   	   			}
   	   			
   	   			cr3100mVO.setM30Vl2("0");
   	   			cr3100mVO.setM30Vl3("0");
   	   			cr3100mVO.setH24Vl2("0");
   	   			cr3100mVO.setH24Vl3("0");
   	   			
   	   			cr3100mVO.setMtlNo(crfMap.get("mtlNo").toString());
   	   			cr3100mVO.setNcYn((String)crfMap.get("ncYn"));
   	   			cr3100mVO.setDataRegnt(EgovUserDetailsHelper.getAuthenticatedAdminId());
   	   			
   		        ech0207dao.insertEch0207RsSeqSsResult(cr3100mVO);   	   			
   			}

   		}
   		message = "피부자극평가 결과 생성이 완료되었습니다.";
   		model.addAttribute("message", message);
   		
   		return jsonView;
   		
   	}	    
	
   	//피부자극평가(설문)에서 피부자극평가자료(CR3100M, CR3110M) 자동 생성 
   	@RequestMapping("/qxsepmny/ech0207/ech0207AjaxCreateSsResult.do")
   	public View ech0207AjaxCreateSsResult(String cordpCd, String rsNo, Cr3100mVO cr3100mVO, Cr3110mVO cr3110mVO, HttpServletRequest request, RedirectAttributes reda, ModelMap model) throws Exception{
   		LOGGER.debug("/qxsepmny/ech0207/ech0207AjaxCreateSsResult.do - 피부자극평가(설문)에서 피부자극평가자료(CR3100M, CR3110M) 자동 생성 ");
   		String message = "";
   		
   		LOGGER.debug("rsNO= "+rsNo);
   		EgovMap map = new EgovMap();
   		map.put("corpCd", EgovUserDetailsHelper.getAuthenticatedAdminCorpCd());
   		map.put("rsNo", rsNo);
   		
   		//피부자극평가 결과 조회 연구
   		List<EgovMap> ssResultList = ech0207dao.selectEch0207RsSsResultList(map);
		
   		for(EgovMap crfMap  : ssResultList){   			
			EgovMap sMap = new EgovMap();
   			sMap.put("corpCd", EgovUserDetailsHelper.getAuthenticatedAdminCorpCd());
   			sMap.put("rsNo", (String)crfMap.get("rsNo"));
   			sMap.put("rsjNo", "999999");
   			sMap.put("mtlDsp", (String)crfMap.get("mtlDsp"));
   			sMap.put("brsjNo", (String)crfMap.get("brsjNo"));
   			
   			int resultChkCnt = ech0207dao.selectEch0207ResultChkCnt(sMap);
   			
   			if(resultChkCnt > 0 ) {
   				
   	   			cr3110mVO = ech0207dao.selectEch0207RsResult(sMap);	
   				//자극점수 환산 0 0.5 1 2 3 4 5 6
   	   			String vl = "0";
   	   			if(crfMap.get("answNum").equals("1")) {
   	   				vl = "0";
   	   			}else if(crfMap.get("answNum").equals("2")) {
   	   				vl = "0.5";
   	   			}else if(crfMap.get("answNum").equals("3")) {
   	   				vl = "1";
   	   			}else if(crfMap.get("answNum").equals("4")) {
   	   				vl = "2";
   	   			}else if(crfMap.get("answNum").equals("5")) {
   	   				vl = "3";
   	   			}else if(crfMap.get("answNum").equals("6")) {
   	   				vl = "4";
   	   			}else if(crfMap.get("answNum").equals("7")) {
   	   				vl = "5";
   	   			}
   	   			
   	   			if(crfMap.get("srType").equals("1")) {
   	   				cr3110mVO.setM30Vl1(vl);
   	   			}else if(crfMap.get("srType").equals("2")) {
   	   				cr3110mVO.setH24Vl1(vl);
   	   			}
   	   			
   	   			ech0207dao.updateEch0207RsSsResult(cr3110mVO);   	   			
   				
   				
   			}else {
   				cr3110mVO.setCorpCd(EgovUserDetailsHelper.getAuthenticatedAdminCorpCd());
   	   			cr3110mVO.setRsNo((String)crfMap.get("rsNo"));
   	   			cr3110mVO.setRsjNo("999999");   			
   	   			cr3110mVO.setMtlDsp((String)crfMap.get("mtlDsp"));
   	   			cr3110mVO.setBrsjNo((String)crfMap.get("brsjNo"));
   	   			
   				//자극점수 환산 0 0.5 1 2 3 4 5 6
   	   			String vl = "0";
   	   			if(crfMap.get("answNum").equals("1")) {
   	   				vl = "0";
   	   			}else if(crfMap.get("answNum").equals("2")) {
   	   				vl = "0.5";
   	   			}else if(crfMap.get("answNum").equals("3")) {
   	   				vl = "1";
   	   			}else if(crfMap.get("answNum").equals("4")) {
   	   				vl = "2";
   	   			}else if(crfMap.get("answNum").equals("5")) {
   	   				vl = "3";
   	   			}else if(crfMap.get("answNum").equals("6")) {
   	   				vl = "4";
   	   			}else if(crfMap.get("answNum").equals("7")) {
   	   				vl = "5";
   	   			}
   	   			   	   			
   	   			if(crfMap.get("srType").equals("1")) {
   	   				cr3110mVO.setM30Vl1(vl);
   	   				cr3110mVO.setH24Vl1("0");
   	   			}else if(crfMap.get("srType").equals("2")) {
   	   				cr3110mVO.setH24Vl1(vl);
   	   				cr3110mVO.setM30Vl1("0");
   	   			}
   	   			
   	   			cr3110mVO.setM30Vl2("0");
   	   			cr3110mVO.setM30Vl3("0");
   	   			cr3110mVO.setH24Vl2("0");
   	   			cr3110mVO.setH24Vl3("0");
   	   			
   	   			cr3110mVO.setMtlNo(crfMap.get("mtlNo").toString());
   	   			cr3110mVO.setNcYn((String)crfMap.get("ncYn"));
   	   			cr3110mVO.setDataRegnt(EgovUserDetailsHelper.getAuthenticatedAdminId());
   	   			
   		        ech0207dao.insertEch0207RsSsResult(cr3110mVO);   	   			
   			}

   		}

   		//피부자극평가 결과 생성 - 연구상세		
   		for(EgovMap crfMap  : ssResultList){   			
   			EgovMap sMap = new EgovMap();
   			sMap.put("corpCd", EgovUserDetailsHelper.getAuthenticatedAdminCorpCd());
   			sMap.put("rsNo", (String)crfMap.get("rsNo"));
   			sMap.put("mtlDsp", (String)crfMap.get("mtlDsp"));

   	   	   	//HNBSRC	20210119	999999	1	#10	21333-1-1	20210086	1
   	   	    //HNBSRC	20210120	999999	1	#10	21333-2-1	20210086	1
   			//피부자극평가 결과 조회 연구상세 
   	   		List<EgovMap> rsSeqResultList = ech0207dao.selectEch0207RsSeqSsResultList(sMap);
   			
   	   		for(EgovMap rsSeqCrfMap  : rsSeqResultList){
	   			EgovMap rsSeqMap = new EgovMap();
	   			rsSeqMap.put("corpCd", EgovUserDetailsHelper.getAuthenticatedAdminCorpCd());
	   			rsSeqMap.put("rsNo", (String)rsSeqCrfMap.get("rsNo"));
	   			rsSeqMap.put("rsjNo", "999999");
	   			rsSeqMap.put("mtlDsp", (String)rsSeqCrfMap.get("mtlDsp"));
	   			rsSeqMap.put("brsjNo", (String)rsSeqCrfMap.get("brsjNo"));

	   			
	   			int resultChkCnt = ech0207dao.selectEch0207RsSeqResultChkCnt(rsSeqMap);
	   			
	   			if(resultChkCnt > 0 ) {
	   				
	   	   			cr3100mVO = ech0207dao.selectEch0207RsSeqResult(rsSeqMap);	
	   				//자극점수 환산 0 0.5 1 2 3 4 5 6
	   	   			String vl = "0";
	   	   			if(crfMap.get("answNum").equals("1")) {
	   	   				vl = "0";
	   	   			}else if(crfMap.get("answNum").equals("2")) {
	   	   				vl = "0.5";
	   	   			}else if(crfMap.get("answNum").equals("3")) {
	   	   				vl = "1";
	   	   			}else if(crfMap.get("answNum").equals("4")) {
	   	   				vl = "2";
	   	   			}else if(crfMap.get("answNum").equals("5")) {
	   	   				vl = "3";
	   	   			}else if(crfMap.get("answNum").equals("6")) {
	   	   				vl = "4";
	   	   			}else if(crfMap.get("answNum").equals("7")) {
	   	   				vl = "5";
	   	   			}
	   	   			
	   	   			if(crfMap.get("srType").equals("1")) {
	   	   				cr3100mVO.setM30Vl1(vl);
	   	   			}else if(crfMap.get("srType").equals("2")) {
	   	   				cr3100mVO.setH24Vl1(vl);
	   	   			}
	   	   			
	   	   			ech0207dao.updateEch0207RsSeqSsResult(cr3100mVO);   	   			
	   				
	   			}else {
	   				cr3100mVO.setCorpCd(EgovUserDetailsHelper.getAuthenticatedAdminCorpCd());
	   	   			cr3100mVO.setRsNo((String)rsSeqCrfMap.get("rsNo"));
	   	   			cr3100mVO.setRsjNo("999999");   			
	   	   			cr3100mVO.setMtlDsp((String)rsSeqCrfMap.get("mtlDsp"));
	   	   			cr3100mVO.setBrsjNo((String)rsSeqCrfMap.get("brsjNo"));
	   	   			
	   				//자극점수 환산 0 0.5 1 2 3 4 5 6
	   	   			String vl = "0";
	   	   			if(crfMap.get("answNum").equals("1")) {
	   	   				vl = "0";
	   	   			}else if(crfMap.get("answNum").equals("2")) {
	   	   				vl = "0.5";
	   	   			}else if(crfMap.get("answNum").equals("3")) {
	   	   				vl = "1";
	   	   			}else if(crfMap.get("answNum").equals("4")) {
	   	   				vl = "2";
	   	   			}else if(crfMap.get("answNum").equals("5")) {
	   	   				vl = "3";
	   	   			}else if(crfMap.get("answNum").equals("6")) {
	   	   				vl = "4";
	   	   			}else if(crfMap.get("answNum").equals("7")) {
	   	   				vl = "5";
	   	   			}
	   	   			   	   			
	   	   			if(crfMap.get("srType").equals("1")) {
	   	   				cr3100mVO.setM30Vl1(vl);
	   	   				cr3100mVO.setH24Vl1("0");
	   	   			}else if(crfMap.get("srType").equals("2")) {
	   	   				cr3100mVO.setH24Vl1(vl);
	   	   				cr3100mVO.setM30Vl1("0");
	   	   			}
	   	   			
	   	   			cr3100mVO.setM30Vl2("0");
	   	   			cr3100mVO.setM30Vl3("0");
	   	   			cr3100mVO.setH24Vl2("0");
	   	   			cr3100mVO.setH24Vl3("0");
	   	   			
	   	   			cr3100mVO.setMtlNo(rsSeqCrfMap.get("mtlNo").toString());
	   	   			cr3100mVO.setNcYn((String)crfMap.get("ncYn"));
	   	   			cr3100mVO.setMrsNo((String)rsSeqCrfMap.get("mrsNo"));
	   	   			cr3100mVO.setDataRegnt(EgovUserDetailsHelper.getAuthenticatedAdminId());
	   	   			
	   		        ech0207dao.insertEch0207RsSeqSsResult(cr3100mVO);	   			
	   			}	
	   			
   	   		}	
   		}	
   		
   		message = "피부자극평가 결과 생성이 완료되었습니다.";
   		model.addAttribute("message", message);
   		
   		return jsonView;
   		
   	}
   	
   	//피부자극결과 엑셀다운로드
    @SuppressWarnings("unchecked")
    @RequestMapping("/qxsepmny/ech0207/ech0207ExcelResult.do")
    public void ech0207ExcelResult(@ModelAttribute("searchVO") CmmnSearchVO searchVO, HttpServletRequest request, HttpServletResponse response, RedirectAttributes reda, ModelMap model) throws Exception {
        LOGGER.debug("/qxsepmny/entran/ech0207ExcelResult.do - 피부자극결과 엑셀 다운로드");
        LOGGER.debug("searchVO = " + searchVO.toString());
       
        EgovMap dataMap = new EgovMap();
        searchVO.setCorpCd(EgovUserDetailsHelper.getAuthenticatedAdminCorpCd());
        List<EgovMap> resultList = ech0207dao.selectEch0207ExcelResult(searchVO);
        dataMap.put("resultList", resultList);
       
        int num = 1;
        for (EgovMap egovMap : resultList) {
            egovMap.put("number", num);
            num++;
        }
    	AdminVO sessionVO = (AdminVO) EgovUserDetailsHelper.getAuthenticatedAdmin();
		dataMap.put("printUser", sessionVO.getName()+"("+sessionVO.getAdminId()+")");
       
        ExcelUtil excelUtil = new ExcelUtil();
        excelUtil.getPerformanceExcel(dataMap, "피부자극평가 결과 리스트", "ech0207Result", request, response);
    }
   	
   	
	    
}    
	 
	 

