package ctms.adm.ech0804;

import java.sql.Timestamp;
import java.text.SimpleDateFormat;
import java.util.List;
import java.util.Locale;

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

import component.excel.ExcelUtil;
import component.file.CmmnFileMngUtil;
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
import ctms.valueObject.Ct1050mVO;
import ctms.valueObject.cmm.CmmnListVO;
import ctms.valueObject.cmm.CmmnSearchVO;

@Controller
public class Ech0804Controller extends AdmCmmController{
	
	private static final Logger LOGGER = LoggerFactory.getLogger(Ech0804Controller.class);
	@Autowired private Ech0804DAO ech0804DAO;
	@Autowired private CmmDAO cmmDAO;
	@Resource private CmmnFileMngUtil fileUtil;
	@Resource private View jsonView;
	@Resource(name = "propertiesService") protected EgovPropertyService propertyService;
	
	//로그인화면으로 리다이렉트합니다.
	private String redirectLoginView(RedirectAttributes reda, String message){
		reda.addFlashAttribute("message", message);
		return "redirect:/qxsepmny/lgn/admLoginView.do";
	}
	
	// ********************************(기준정보관리) 20210415 관리자 작업로그 목록화면********************************
	@RequestMapping("/qxsepmny/ech0804/ech0804List.do")	
	public String ech0804List(HttpServletRequest request, ModelMap model, @ModelAttribute("searchVO") CmmnSearchVO searchVO) throws Exception {
		LOGGER.debug("/qxsepmny/ech0804/ech0804List.do - 운영관리 작업로그 목록화면");
		//request.getSession().setAttribute("admMenuNo", "703");
		
		//세션 호출
		AdminVO adminVO = (AdminVO) request.getSession().getAttribute("adminSessionCtms");

		//엑셀다운로드 권한 설정 Y 허용  N 허용안함 
		model.addAttribute("exauth", adminVO.getExauth());		
		
		//회사코드 설정 
		searchVO.setCorpCd(EgovUserDetailsHelper.getAuthenticatedAdminCorpCd());
		
		//검색조건 설정 
		//검색기간에 from 이번주 월요일  to 오늘일자 설정 
		if(EgovStringUtil.isEmpty(searchVO.getSearchCondition1())){
			
			String rtnStr = null;
			
			// 문자열로 변환하기 위한 패턴 설정(년도-월-일)
			String pattern = "yyyy-MM-dd";
		
			SimpleDateFormat sdfCurrent = new SimpleDateFormat(pattern, Locale.KOREA);
		    Timestamp ts = new Timestamp(System.currentTimeMillis());
		    
		    rtnStr = sdfCurrent.format(ts.getTime()+(1000*60*60*24*-7));
				
		    searchVO.setSearchCondition1(EgovStringUtil.getCurMonday());
		}
	
		if(EgovStringUtil.isEmpty(searchVO.getSearchCondition2())){
			String nowDate = EgovStringUtil.getDateMinus();			
			searchVO.setSearchCondition2(nowDate);
			
			//월요일이 현재일자보고 큰 경우 현재일자를 동일하게 설정
			if((EgovStringUtil.getCurMonday().compareTo(EgovStringUtil.getDateMinus()))>0) {
				searchVO.setSearchCondition1(searchVO.getSearchCondition2());
			}
		}
		
		
		LOGGER.debug("getSearchCondition1="+searchVO.getSearchCondition1());
		LOGGER.debug("getSearchCondition2="+searchVO.getSearchCondition2());
				
		PaginationInfo paginationInfo = PaginationController.getPaginationInfo(searchVO);
		CmmnListVO listVO = ech0804DAO.selectEch0804List(searchVO); 
		paginationInfo.setTotalRecordCount(listVO.getTotalRecordCount());
	
		model.addAttribute("resultList", listVO.getEgovList());
		model.addAttribute("paginationInfo", paginationInfo);
		
		model.addAttribute("totalCount", paginationInfo.getTotalRecordCount());
		model.addAttribute("currentPageNo", paginationInfo.getCurrentPageNo());
		model.addAttribute("totalPageCount", paginationInfo.getTotalPageCount());
		
		return "/adm/ech0804/ech0804List";
	}

	// 작업로그 리스트로 리다이렉트
	private String redirectList(RedirectAttributes reda, String message) {
		reda.addFlashAttribute("message", message);
		return "redirect:/qxsepmny/ech0804/ech0804List.do";
	}

	// 작업로그 목록 엑셀 다운로드
	@SuppressWarnings("unchecked")
	@RequestMapping("/qxsepmny/ech0804/ech0804Excel.do")
	public void ech0804Excel(@ModelAttribute("searchVO") CmmnSearchVO searchVO, HttpServletRequest request, HttpServletResponse response, ModelMap model) throws Exception {
		LOGGER.debug("/qxsepmny/ech0804/ech0804Excel.do - 작업로그 목록 엑셀 다운로드");
		LOGGER.debug("searchVO = " + searchVO.toString());
		EgovMap dataMap = new EgovMap();
		
		List<EgovMap> resultList = ech0804DAO.selectEch0804Excel(searchVO);
		dataMap.put("resultList", resultList);
		
		int num = 1;
		for (EgovMap egovMap : resultList) {
			egovMap.put("number", num);
			num++;
		}
		
		AdminVO sessionVO = (AdminVO) EgovUserDetailsHelper.getAuthenticatedAdmin();
		dataMap.put("printUser", sessionVO.getName()+"("+sessionVO.getAdminId()+")");
		
		ExcelUtil excelUtil = new ExcelUtil();
		excelUtil.getPerformanceExcel(dataMap, "작업로그 리스트", "ech0804", request, response);
	}
		
}
