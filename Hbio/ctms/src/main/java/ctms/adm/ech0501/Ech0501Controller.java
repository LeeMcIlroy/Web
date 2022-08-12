package ctms.adm.ech0501;

import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.List;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.poi.hssf.util.HSSFColor.GOLD;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.multipart.MultipartHttpServletRequest;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.ubireport.common.org.apache.xerces.impl.dv.dtd.ListDatatypeValidator;

import component.excel.ExcelUtil;
import component.file.CmmnFileMngUtil;
import component.file.FileInfoVO;
import component.web.PaginationController;
import ctms.adm.cmm.AdmCmmController;
import ctms.adm.ech0501.Ech0501Controller;
import ctms.valueObject.AdminVO;
import ctms.valueObject.Ct7000mVO;
import ctms.valueObject.Rs1000mVO;
import ctms.valueObject.Rs5000mVO;
import ctms.valueObject.Rs5020mVO;
import ctms.valueObject.cmm.CmmnListVO;
import ctms.valueObject.cmm.CmmnSearchVO;
import egovframework.com.cmm.util.EgovUserDetailsHelper;
import egovframework.let.utl.fcc.service.EgovStringUtil;
import egovframework.rte.fdl.property.EgovPropertyService;
import egovframework.rte.psl.dataaccess.util.EgovMap;
import egovframework.rte.ptl.mvc.tags.ui.pagination.PaginationInfo;
import net.sourceforge.jtds.jdbc.DateTime;

@Controller
public class Ech0501Controller extends AdmCmmController{
	
private static final Logger LOGGER = LoggerFactory.getLogger(Ech0501Controller.class);

	
	@Resource(name = "propertiesService") protected EgovPropertyService propertyService;
	@Autowired private Ech0501DAO ech0501DAO;
	@Resource private CmmnFileMngUtil fileUtil;
	@Resource private ExcelUtil excelUtil;
	
	//로그인화면으로 리다이렉트합니다.
	private String redirectLoginView(RedirectAttributes reda, String message){
		reda.addFlashAttribute("message", message);
		return "redirect:/qxsepmny/lgn/admLoginView.do";
	}
	//보고서 목록화면으로 리다이렉트합니다.
	private String redirectEch0501List(RedirectAttributes reda, String message){
		reda.addFlashAttribute("message", message);
		return "redirect:/qxsepmny/ech0501/ech0501List.do";
	}
	//보고서상세보기화면으로 리다이렉트합니다.
	private String redirectEch0501View(RedirectAttributes reda, String message){
		reda.addFlashAttribute("message", message);
		return "redirect:/qxsepmny/ech0501/ech0501View.do";
	}
	/**
	 * 관리자 코딩 화면으로 이동합니다.
	 * @param model
	 * @return 코딩 화면
	 * @throws Exception
	 */
	
	@RequestMapping("/qxsepmny/ech0501/ech0501List.do")	
	public String ech0501List(@ModelAttribute("searchVO")CmmnSearchVO searchVO ,String searchCondition1,HttpServletRequest request, ModelMap model,HttpServletResponse response) throws Exception {
		LOGGER.debug("/qxsepmny/ech0501/ech0501List.do - 보고서관리  목록화면");
		//request.getSession().setAttribute("admMenuNo", "703");

		//검색항목 설정 시작
		
		//세션 호출
		AdminVO adminVO = (AdminVO) request.getSession().getAttribute("adminSessionCtms");		
		
		//엑셀다운로드 권한 설정 Y 허용  N 허용안함 
		model.addAttribute("exauth", adminVO.getExauth());
		
		//회사코드 설정
		searchVO.setCorpCd(adminVO.getCorpCd());

		
		//시작일자 searchCondition1 종료일자 searchCondition2 기간구분 searchCondition4
		//searchWord 검색어구분 searchCondition3
		
		//연도목록
		
		List<String> yearList = cmmDAO.selectYearList();
		model.addAttribute("yearList", yearList);

		EgovMap map = new EgovMap();
		
		map.put("searchYear", searchVO.getSearchYear());
		map.put("corpCd",EgovUserDetailsHelper.getAuthenticatedAdminCorpCd());

		List<EgovMap> yearRsCdList = cmmDAO.selectCmmYearRsCdList(map);
		
		model.addAttribute("yearRsCdList", yearRsCdList);

		//연구상태(공통코드) 목록 searchCondition5
		List<EgovMap> ct2050 = cmmDAO.selectCmmCdList(searchVO.getCorpCd(), "CT2050");
		model.addAttribute("ct2050", ct2050);
		
		//-- 검색항목 설정 끝
		
		PaginationInfo paginationInfo = PaginationController.getPaginationInfo(searchVO);
		CmmnListVO listVO = ech0501DAO.selectEch0501List(searchVO); 
		paginationInfo.setTotalRecordCount(listVO.getTotalRecordCount());
		
		model.addAttribute("resultList", listVO.getEgovList());
		model.addAttribute("paginationInfo", paginationInfo);
		model.addAttribute("totalCount", paginationInfo.getTotalRecordCount());
		model.addAttribute("currentPageNo", paginationInfo.getCurrentPageNo());
		model.addAttribute("totalPageCount", paginationInfo.getTotalPageCount());
		
		return "/adm/ech0501/ech0501List";
	}
	
	// ********************************( 관리자 보고서관리 상세보기화면********************************
	// @RequestParam으로 상세페이지에서 키값 받아줌
	@RequestMapping("/qxsepmny/ech0501/ech0501View.do")
	public String ech0501View( @ModelAttribute("searchVO") CmmnSearchVO searchVO ,@RequestParam("rsNo")String rsNo ,Rs1000mVO rs1000mVo, HttpServletRequest request, ModelMap model, RedirectAttributes reda) throws Exception {
		LOGGER.debug("/qxsepmny/ech0501/ech0501View.do - 보고서관리 지사관리 상세보기화면");


			
			if(!EgovStringUtil.isEmpty(rsNo)){
				
				List<EgovMap> list = ech0501DAO.selectEch0501selectOne(rsNo);
				EgovMap map = new EgovMap();
				map.put("boardSeq", rsNo);
				map.put("boardType", "REPORT");
		
				

				List<Ct7000mVO> attachList = cmmDAO.selectAttachList(map);
				model.addAttribute("attachList", attachList);

				EgovMap attachMap = new EgovMap();
				
				for(Ct7000mVO attach : attachList){
					attachMap.put(attach.getFileKey(), attach);
				}
				//상세보기(보고서 보고일자 가져오기)
				EgovMap rs5020 = new EgovMap();
				rs5020.put("rsNo", rsNo);
				
				List<Rs5020mVO> list2 = ech0501DAO.selectEch0501selectOneModel(rs5020);
				
				EgovMap rs5020Map = new EgovMap();
				
				for(Rs5020mVO rs5020View : list2){
					rs5020Map.put(rs5020View.getRptCls(), rs5020View);
				}
				//상세보기 끝
				
				model.addAttribute("rs5020Map", rs5020Map);			
				model.addAttribute("attachMap", attachMap);
				model.addAttribute("rs1000mVO", list);
			}
			
			

			return "/adm/ech0501/ech0501View";
	}	

	// ********************************관리자 보고서관리 등록&수정 화면********************************
	@RequestMapping("/qxsepmny/ech0501/ech0501Modify.do")
	public String ech0501Modify(@ModelAttribute("rs5000mVO") Rs5000mVO rs5000mVO, String rsNo, String rptNo , String dateLockyn,HttpServletRequest request, ModelMap model ) throws Exception {
		LOGGER.debug("/qxsepmny/ech0501/ech0501Modify.do - 관리자 보고서관리 등록&수정 화면");
		LOGGER.debug("rsNo = " + rsNo);
		
		Rs1000mVO rs1000mVO = new Rs1000mVO();	
	
		
		if(!EgovStringUtil.isEmpty(rsNo)){
			
			List<EgovMap> list = ech0501DAO.selectEch0501selectOne(rsNo);
			EgovMap mapSelect = new EgovMap();
			mapSelect.put("rsNo",rs1000mVO.getRsName());

			List<Rs5020mVO> rs5020mVO = ech0501DAO.selectEch0501selectbox(mapSelect);
		
			/*	model.addAttribute("rs5020mVO", rs5020mVO);*/


			EgovMap rs5020 = new EgovMap();
			rs5020.put("rsNo", rsNo);
			
			List<Rs5020mVO> list2 = ech0501DAO.selectEch0501selectOneModel(rs5020);
			
			EgovMap rs5020Map = new EgovMap();
			
			for(Rs5020mVO rs5020View : list2){
				rs5020Map.put(rs5020View.getRptCls(), rs5020View);
			}
			model.addAttribute("rs5020Map", rs5020Map);

			
			
			EgovMap attachMapSelect = new EgovMap();
			
			for(Rs5020mVO attach : rs5020mVO){
				attachMapSelect.put(attach.getRptCls(), attach);
			}
			
			model.addAttribute("rs5020mVO", attachMapSelect);
		
			EgovMap map = new EgovMap();
			
			map.put("boardSeq",  rs5000mVO.getRsNo());
			map.put("boardType", "REPORT");
			

			List<Ct7000mVO> attachList = cmmDAO.selectAttachList(map);
			model.addAttribute("attachList", attachList);

			EgovMap attachMap = new EgovMap();
			
			for(Ct7000mVO attach : attachList){
				attachMap.put(attach.getFileKey(), attach);
			}
			
			model.addAttribute("attachMap", attachMap);
			//model.addAttribute("rs5000mVO", rs5000mVO);
			model.addAttribute("rs1000mVO", list);
		}

		
		return "/adm/ech0501/ech0501Modify";
	}

	@RequestMapping("/qxsepmny/ech0501/ech0501Update.do" )
	public String admEch0501Update(@ModelAttribute("rs1000mVO") Rs1000mVO rs1000mVO,String rsNo,String dataLockyn, String[] delFile ,String[] rptDate,String[] rptNo2, String[]rptName, String[] rptNo, @RequestParam(required = false)String ct2010, BindingResult result, MultipartHttpServletRequest request, ModelMap model, RedirectAttributes reda) throws Exception {
		LOGGER.debug("/qxsepmny/ech0501/ech0501Update.do -  연구과제 수정&등록");
		LOGGER.debug("rs5000mVO = " + rs1000mVO.toString());
		String message = "";
		List<EgovMap> list = ech0501DAO.selectEch0501selectOne(rsNo);

		Rs5020mVO rs5020mVO = new Rs5020mVO();
		//세션 호출
		AdminVO adminVO = (AdminVO) request.getSession().getAttribute("adminSessionCtms");
		
		List<FileInfoVO> fileInfoList = fileUtil.totUploadFiles(request, "REPORT");
		
		//보고서 삭제(첨부파일테이블)
		if(delFile != null){
			for(String seq : delFile){
				
				Ct7000mVO delAttach = cmmDAO.selectAttachOne(seq);
				cmmDAO.deleteAttachFile(delAttach.getAttachNo());
				fileUtil.deleteFile(delAttach.getRegFileName());
			}
			message = "수정이 완료되었습니다.";
		}
		//보고일자 수정
		if(rptNo2 != null){
			
			for(int i=0; i<rptNo2.length; i++){
				
				rs5020mVO.setCorpCd(adminVO.getCorpCd());
				rs5020mVO.setRsNo(rsNo);
				rs5020mVO.setRptNo(rptNo2[i]);
				rs5020mVO.setRptDt(rptDate[i]);
				
				ech0501DAO.updateEch0501(rs5020mVO);
			}
			
			message = "수정이 완료되었습니다.";
		}
		//보고서 삭제(보고서테이블)
		if(rptNo != null){
			for(String rptSeq : rptNo){
				ech0501DAO.deleteReportTable(rptSeq);
			}
			message = "수정이 완료되었습니다.";
		}
		//파일첨부 
		if(fileInfoList != null){
			
			int i= 0; //보고일자 배열 위치지정할 변수
			for(FileInfoVO fileInfoVO : fileInfoList){
				LOGGER.debug("----- fileKey = " + fileInfoVO.getFileKey() + " -----");
				Ct7000mVO attachVO = new Ct7000mVO(fileInfoVO);
				attachVO.setBoardType("REPORT");//폴더명
				attachVO.setBoardNo(rsNo); //연구번호 
				attachVO.setFileKey(fileInfoVO.getFileKey()); //파일명 네임값도 컬럼에넣기(삭제하거나 리스트출력시 키값사용)
				
				attachVO.setRegDate(rptDate[i]);
				rs5020mVO.setRptDt(rptDate[i]);
	
				rs5020mVO.setRsNo(rsNo);
				rs5020mVO.setCorpCd(adminVO.getCorpCd()); //회사코드
				rs5020mVO.setBranchCd(adminVO.getBranchCd()); //지사코드
				rs5020mVO.setRptCls(attachVO.getFileKey());//파일테이블에 키값
				rs5020mVO.setDataRegnt(adminVO.getAdminId()); //로그인아이디
			
				ech0501DAO.insertEch0501report(rs5020mVO);
				cmmDAO.insertAttachFile(attachVO);
				i++;
			}
			
			message = "저장되었습니다.";
		}
		
		
		
		//업데이트 후 해당항목의 상세페이지로 리다이렉션하기위해 키값 넘겨줌 
		reda.addAttribute("rsNo", rsNo);
		return redirectEch0501View(reda, message);
	}

	@RequestMapping("/qxsepmny/ech0501/ech0501Delete.do")
	public String admEch0501Delete(@ModelAttribute("rm5001mVO") Rs5000mVO rs5000mVO, String attachSeq,HttpServletRequest httpServletRequest, MultipartHttpServletRequest request, ModelMap model, RedirectAttributes reda) throws Exception{
		LOGGER.debug("/qxsepmny/ech0501/ech0501Delete.do -  연구과제 수정&등록");
		LOGGER.debug("rs5000mVO = " + rs5000mVO.toString());
		
		String message = "";
		FileInfoVO fileInfoVO = new FileInfoVO();
		
		LOGGER.debug("----- fileKey = " + fileInfoVO.getFileKey() + " -----");

		cmmDAO.deleteAttachFile(attachSeq);		
		message = "삭제처리 되었습니다.";
		
		return redirectEch0501List(reda, message);
	}
	
	@SuppressWarnings("unchecked")
	@RequestMapping("/qxsepmny/ech0501/ech0501Excel.do")
	public void ech0501Excel(@ModelAttribute("searchVO") CmmnSearchVO searchVO, HttpServletRequest request, HttpServletResponse response, RedirectAttributes reda, ModelMap model) throws Exception {
		LOGGER.debug("/qxsepmny/entran/ech0501Excel.do - 연구과제 엑셀 다운로드");
		LOGGER.debug("searchVO = " + searchVO.toString());
		EgovMap dataMap = new EgovMap();
		
		List<EgovMap> resultList = ech0501DAO.selectAdmEch0501Excel(searchVO);
		dataMap.put("resultList", resultList);
		
		int num = 1;
		for (EgovMap egovMap : resultList) {
			egovMap.put("number", num);
			num++;
		}
		
	   	AdminVO sessionVO = (AdminVO) EgovUserDetailsHelper.getAuthenticatedAdmin();
		dataMap.put("printUser", sessionVO.getName()+"("+sessionVO.getAdminId()+")");
		
		ExcelUtil excelUtil = new ExcelUtil();
		excelUtil.getPerformanceExcel(dataMap, "보고서관리", "ech0501", request, response);
	}
		
	
}
