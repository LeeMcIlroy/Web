package writer.adm.cnslt.list;

import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Calendar;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.multipart.MultipartHttpServletRequest;
import org.springframework.web.servlet.View;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import component.excel.ExcelUtil;
import component.file.CmmnFileMngUtil;
import component.file.FileInfoVO;
import component.web.PaginationController;
import egovframework.let.utl.fcc.service.EgovStringUtil;
import egovframework.rte.psl.dataaccess.util.EgovMap;
import egovframework.rte.ptl.mvc.tags.ui.pagination.PaginationInfo;
import writer.adm.cmm.AdmCmmLogDAO;
import writer.valueObject.CnsltApplyVO;
import writer.valueObject.cmmn.CmmnListVO;
import writer.valueObject.cmmn.CmmnSearchVO;

@Controller
public class AdmCnsltListController {

	private static final Logger LOGGER = LoggerFactory.getLogger(AdmCnsltListController.class);

	@Autowired private AdmCnsltListDAO admCnsltListDAO;

	// 관리자 로그 기록
	private String logJob;
	@Autowired private AdmCmmLogDAO admCmmLogDAO;
	@Autowired private CmmnFileMngUtil cmmnFileMngUtil;

	// 목록
	@RequestMapping("/xabdmxgr/cnslt/list/admCnsltList.do")
	public String admCnsltList(@ModelAttribute("searchVO") CmmnSearchVO searchVO, ModelMap model, HttpSession session) throws Exception {
		LOGGER.info("/xabdmxgr/cnslt/list/admCnsltList.do - 관리자 > 상담 > 상담리스트 > 목록");
		LOGGER.debug("searchVO = "+searchVO.toString());
		// 메뉴 코드
		session.setAttribute("admMenuNo", "201");

		// 상담리스트
		PaginationInfo paginationInfo = PaginationController.getPaginationInfo(searchVO);
		CmmnListVO listVO = admCnsltListDAO.selectCnsltListList(searchVO);
		paginationInfo.setTotalRecordCount(listVO.getTotalRecordCount());
		model.addAttribute("paginationInfo", paginationInfo);
		model.addAttribute("resultList", listVO.getEgovList());

		return "/adm/cnslt/list/admCnsltList";
	}

	// 등록&수정화면
	@RequestMapping("/xabdmxgr/cnslt/list/admCnsltModify.do")
	public String admCnsltModify(@RequestParam String aplySeq, @ModelAttribute("searchVO") CmmnSearchVO searchVO, HttpServletRequest request, ModelMap model) throws Exception {
		LOGGER.info("/xabdmxgr/cnslt/list/admCnsltModify.do - 관리자 > 상담 > 상담리스트 > 등록&수정화면");
		LOGGER.debug("aplySeq = "+aplySeq);

		// 상담신청서
		CnsltApplyVO cnsltApplyVO = admCnsltListDAO.selectCnsltListOne(aplySeq);

		String updtYn = EgovStringUtil.isEmpty(cnsltApplyVO.getUpdtDate()) ? "N" : "Y";
		cnsltApplyVO.setUpdtYn(updtYn);
		model.addAttribute("cnsltApplyVO", cnsltApplyVO);

		// 공통 답변 조회
		CnsltApplyVO cnsltTotAnswer = admCnsltListDAO.selectCnsltListTotOne(aplySeq);
		model.addAttribute("cnsltTotAnswer", cnsltTotAnswer);

		// 재학생&외국인 답변 조회
		if ("REGI".equals(cnsltApplyVO.getAplyUsrType())) {
			// 재학생
			CnsltApplyVO cnsltRegiAnswer = admCnsltListDAO.selectCnsltListRegiOne(aplySeq);
			model.addAttribute("cnsltRegiAnswer", cnsltRegiAnswer);
		} else if ("OVER".equals(cnsltApplyVO.getAplyUsrType())) {
			// 외국인
			CnsltApplyVO cnsltOverAnswer = admCnsltListDAO.selectCnsltListOverOne(aplySeq);
			model.addAttribute("cnsltOverAnswer", cnsltOverAnswer);
		}

		// 첨부파일
		List<EgovMap> cnsltAplyUpfileList = admCnsltListDAO.selectCnsltListUpfileList(aplySeq);
		model.addAttribute("cnsltAplyUpfileList", cnsltAplyUpfileList);

		// 로그 등록
		String ip = request.getHeader("X-FORWARDED-FOR");
		if (ip == null) ip = request.getRemoteAddr();
		logJob = "관리자 > 상담 > 상담리스트 > 상담신청 조회("+aplySeq+")";
		admCmmLogDAO.insertLogOne(logJob, ip);

		return "/adm/cnslt/list/admCnsltModify";
	}

	// 등록&수정
	@RequestMapping("/xabdmxgr/cnslt/list/admCnsltUpdate.do")
	public String admCnsltUpdate(CnsltApplyVO cnsltApplyVO, String[] upFileDelChk, @ModelAttribute("searchVO") CmmnSearchVO searchVO, ModelMap model, MultipartHttpServletRequest request, RedirectAttributes reda) throws Exception {
		LOGGER.info("/xabdmxgr/cnslt/list/admCnsltUpdate.do - 관리자 > 상담 > 상담리스트 > 등록&수정");
		LOGGER.debug("cnsltApplyVO = "+cnsltApplyVO.toString());
		
		// 첨부파일 조건 검사
		boolean flag = cmmnFileMngUtil.uploadFileCheck(request);
		if(!flag){
			LOGGER.debug("파일첨부 오류");
			String message = "업로드파일이 잘못되었습니다.";
			reda.addFlashAttribute("message", message);
			reda.addFlashAttribute("searchVO", searchVO);
			return "redirect:/xabdmxgr/cnslt/list/admCnsltList.do";
		}
		
		// 첨부파일 등록
		List<FileInfoVO> fileInfoList = cmmnFileMngUtil.uploadAttachedFiles(request, "CONANSW");
		for(FileInfoVO fileInfoVO : fileInfoList){
			admCnsltListDAO.cnsltRequestUpfileInsert(fileInfoVO, cnsltApplyVO.getAplySeq());
		}

		admCnsltListDAO.cnsltListUpdate(cnsltApplyVO);
		
		if(upFileDelChk != null){
			EgovMap map = new EgovMap();
			map.put("upFileDelChk", upFileDelChk);
			
			List<EgovMap> cnsltFileList = admCnsltListDAO.selectCnsltUpfileList(map);
			for(EgovMap cnsltFile : cnsltFileList){
				cmmnFileMngUtil.deleteFile(cnsltFile.get("upSaveFilePath").toString());	// 파일 삭제
			}
			admCnsltListDAO.deleteCnsltUpfileList(map);	// 데이터 삭제
		}

		// 로그 등록
		String ip = request.getHeader("X-FORWARDED-FOR");
		if (ip == null) ip = request.getRemoteAddr();
		logJob = "관리자 > 상담 > 상담리스트 > 상담신청 수정("+cnsltApplyVO.getAplySeq()+")";
		admCmmLogDAO.insertLogOne(logJob, ip);

		String message = "N".equals(cnsltApplyVO.getUpdtYn()) ? "등록되었습니다." : "수정되었습니다.";
		reda.addFlashAttribute("message", message);
		reda.addFlashAttribute("searchVO", searchVO);
		return "redirect:/xabdmxgr/cnslt/list/admCnsltList.do";
	}
	//상담삭제
	@RequestMapping("/xabdmxgr/cnslt/list/admCnsltDelete.do")
	public String AdmcnsltDeleteOne(@ModelAttribute("searchVO") CmmnSearchVO searchVO, ModelMap model, RedirectAttributes reda, CnsltApplyVO cnsltApplyVO)throws Exception{
		LOGGER.info("/xabdmxgr/cnslt/list/admCnsltDelete.do - 사용자 > 상담 > 마이페이지 > 상담신청 삭제");
		LOGGER.debug("cnsltApplyVO - "+cnsltApplyVO.toString());
		
		
		String message = "해당 상담내역이 삭제되었습니다.";
		reda.addFlashAttribute("message", message);
		reda.addFlashAttribute("searchVO", searchVO);
		//내역 삭제
		admCnsltListDAO.CnsltListDelete(cnsltApplyVO.getAplySeq());
			
		return "redirect:/xabdmxgr/cnslt/list/admCnsltList.do";
	}
	// 상담완료 엑셀 다운로드
	@RequestMapping("/xabdmxgr/cnslt/list/cnsltCompleteExcelDown.do")
	public View cnsltCompleteExcelDown(String startDate, String endDate, HttpServletResponse response, ModelMap model) throws Exception {
		LOGGER.info("/xabdmxgr/cnslt/list/cnsltCompleteExcelDown.do - 관리자 > 상담 > 상담리스트 > 상담완료 엑셀 다운로드");
		
		CmmnSearchVO searchVO = new CmmnSearchVO();
		//searchVO.setSearchType("2");
		if(!EgovStringUtil.isEmpty(startDate)) searchVO.setStartDate(startDate);
		if(!EgovStringUtil.isEmpty(endDate)) searchVO.setEndDate(endDate);
		CmmnListVO listVO = admCnsltListDAO.selectExcelList(searchVO);
		
		model.addAttribute("resultList", listVO.getEgovList());
		// jquery.fileDownload set
		response.setHeader("Set-Cookie","fileDownload=true; path=/");
		return new ExcelUtil("consultCompleteList");
	}
	
	/**************************************** 2017-07-28 추가 ****************************************/
	// 상담 > 상담 현황
	@RequestMapping("/xabdmxgr/cnslt/list/admCnsltListStatus.do")
	public String admCnsltListStatus(@ModelAttribute("searchVO") CmmnSearchVO searchVO, ModelMap model, HttpSession session) throws Exception {
		LOGGER.info("/xabdmxgr/cnslt/list/admCnsltListStatus.do - 관리자 > 상담 > 상담현황");
		// 메뉴 코드
		session.setAttribute("admMenuNo", "203");
/*
		SimpleDateFormat format = new SimpleDateFormat("yyyy-MM-dd");
		String nowDate = format.format(new Date());
		Calendar cal = Calendar.getInstance();
		cal.setTime(new Date());
		cal.add(Calendar.DATE, 1);
		String addDate = format.format(cal.getTime());
*/
		// searchType set
		if(EgovStringUtil.isEmpty(searchVO.getSearchType())) searchVO.setSearchType("REGI");
		
		// 최초 접속시 (현재일로부터 6개월전 조회)
		if(EgovStringUtil.isEmpty(searchVO.getEndDate()) && EgovStringUtil.isEmpty(searchVO.getStartDate())){
			SimpleDateFormat format = new SimpleDateFormat("yyyy-MM-dd");
			String nowDate = format.format(new Date());
			searchVO.setEndDate(nowDate);
			
			Calendar cal = Calendar.getInstance();
			cal.setTime(new Date());
			cal.add(Calendar.MONTH, -6);
			String subDate = format.format(cal.getTime());
			searchVO.setStartDate(subDate);
		}
		
		EgovMap statusInfo = admCnsltListDAO.selectCnsltListStatusOne(searchVO);
		model.addAttribute("statusInfo", statusInfo);
/*		
		// 재학생
		searchVO.setSearchType("REGI");
		EgovMap regiStatusInfo = admCnsltListDAO.selectCnsltListStatusOne(searchVO);
		model.addAttribute("regiStatusInfo", regiStatusInfo);
		// 외국인
		searchVO.setSearchType("OVER");
		EgovMap overStatusInfo = admCnsltListDAO.selectCnsltListStatusOne(searchVO);
		model.addAttribute("overStatusInfo", overStatusInfo);
*/
		//return "/adm/cnslt/list/admCnsltListStatus";
		return "/adm/cnslt/list/admCnsltListStatus2";
	}
	
	// 상담 > 상담 현황 엑셀다운로드
	@RequestMapping("/xabdmxgr/cnslt/list/cnsltStatusExcelDown.do")
	public View cnsltStatusExcelDown(
				@RequestParam(defaultValue="REGI") String searchType
				, @RequestParam(defaultValue="") String startDate, @RequestParam(defaultValue="") String endDate
				, HttpServletResponse response, ModelMap model) throws Exception {
		LOGGER.info("/xabdmxgr/cnslt/list/cnsltStatusExcelDown.do - 상담 > 상담 현황 - 엑셀엑셀다운로드");
		
		String excelFileName = "cnsltStatusRegi";
		
		CmmnSearchVO searchVO = new CmmnSearchVO();
		//searchVO.setSearchType("2");
		if("REGI".equals(searchType)){
			searchVO.setSearchType("REGI");
			excelFileName = "cnsltStatusRegi";
		}else{
			searchVO.setSearchType("OVER");
			excelFileName = "cnsltStatusOver";
		}
		
		searchVO.setStartDate(startDate);
		searchVO.setEndDate(endDate);
		
		String period = "전체";
		if(!EgovStringUtil.isEmpty(startDate) || !EgovStringUtil.isEmpty(endDate)){
			period = startDate + " ~ " + endDate;
		}
		
		EgovMap statusInfo = admCnsltListDAO.selectCnsltListStatusOne(searchVO);
		// model.addAttribute("statusInfo", statusInfo);
		
		Map<String, Object> result = new HashMap<>();
		result.put("statusInfo", statusInfo);
		result.put("period", period);
		
		model.addAttribute("result", result);
		
		//CmmnListVO listVO = admCnsltListDAO.selectExcelList(searchVO);
		// model.addAttribute("resultList", listVO.getEgovList());
		
		// jquery.fileDownload set
		response.setHeader("Set-Cookie","fileDownload=true; path=/");
		return new ExcelUtil(excelFileName);
	}	
}
