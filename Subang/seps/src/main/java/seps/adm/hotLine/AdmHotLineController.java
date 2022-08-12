package seps.adm.hotLine;

import java.util.List;
import java.util.Map;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

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

import seps.cmmn.CmmnDAO;
import seps.valueObject.HotLineVO;
import seps.valueObject.UserInfoVO;
import valueObject.CmmnListVO;
import valueObject.CmmnSearchVO;
import valueObject.FileVO;

import component.excel.ExcelUtil;
import component.file.CmmnFileMngUtil;
import component.util.ComStringUtil;
import component.web.PaginationController;

import egovframework.com.cmm.util.EgovUserDetailsHelper;
import egovframework.let.utl.fcc.service.EgovStringUtil;
import egovframework.rte.psl.dataaccess.util.EgovMap;
import egovframework.rte.ptl.mvc.tags.ui.pagination.PaginationInfo;

@Controller
public class AdmHotLineController {
	
	private static final Logger LOGGER = LoggerFactory.getLogger(AdmHotLineController.class);
	
	@Resource View jsonView;
	@Autowired AdmHotLineDAO dao;
	@Autowired CmmnDAO cmmnDAO;
	@Autowired private CmmnFileMngUtil cmmnFileMngUtil;
	
	// 검색조건을 가지고 목록으로 이동합니다.
	private String redirectListPage(String message, CmmnSearchVO searchVO, RedirectAttributes reda) {
		reda.addFlashAttribute("message", message);
		reda.addFlashAttribute("searchVO", searchVO);
		return "redirect:/adm/hotLine/hotLineList.do";
	}
	
	/**
	 * 비상연락망 목록 화면
	 * @param searchVO
	 * @param model
	 * @param session
	 * @param request
	 * @return
	 * @throws Exception
	 */
	@RequestMapping("/adm/hotLine/hotLineList.do")
	public String hotLineList(@ModelAttribute("searchVO") CmmnSearchVO searchVO, ModelMap model, HttpSession session, HttpServletRequest request) throws Exception {
		LOGGER.info("/adm/hotLine/hotLineList.do - 비상연락망 목록 화면");
		if(session != null) session.setAttribute("leftMeneNo", "401");
		PaginationInfo paginationInfo = PaginationController.getPaginationInfo(searchVO , 10, 10);
		
		CmmnListVO listVO = dao.selectHotLineList(searchVO);
		paginationInfo.setTotalRecordCount(listVO.getTotalRecordCount());
		model.addAttribute("paginationInfo", paginationInfo);
		model.addAttribute("resultList", listVO.getEgovList());
		
		List<EgovMap> deptList = dao.selectHotLineDeptList();
		model.addAttribute("deptList", deptList);
		
		return "/adm/hotLine/hotLineList";
	}
	
	/**
	 * 비상연락망 조회화면
	 * @param searchVO
	 * @param model
	 * @param hotLineId
	 * @param session
	 * @param request
	 * @return
	 * @throws Exception
	 */
	
	@RequestMapping("/adm/hotLine/hotLineView.do")
	public String hotLineView(@ModelAttribute("searchVO") CmmnSearchVO searchVO, ModelMap model, String hotLineId, HttpSession session, HttpServletRequest request) throws Exception {
		LOGGER.info("/adm/hotLine/hotLineView.do - 비상연락망 조회화면");
		LOGGER.debug("hotLineId > "+hotLineId);
		
		HotLineVO returnVO = dao.selectHotLineView(hotLineId);
		model.addAttribute("hotLineVO", returnVO);
		model.addAttribute("searchVO", searchVO);
		
		return "/adm/hotLine/hotLineView";
	}
	
	/**
	 *  비상연락망 등록 화면
	 * @param searchVO
	 * @param hotLineId
	 * @param model
	 * @param session
	 * @param request
	 * @return
	 * @throws Exception
	 */
	@RequestMapping("/adm/hotLine/hotLineModify.do")
	public String hotLineModify(@ModelAttribute("searchVO") CmmnSearchVO searchVO, String hotLineId, ModelMap model, HttpSession session, HttpServletRequest request) throws Exception {
		LOGGER.info("/adm/hotLine/hotLineModify.do - 비상연락망 등록&수정 화면");
		
		UserInfoVO sessionVO = (UserInfoVO) EgovUserDetailsHelper.getAuthenticatedUser();
		HotLineVO returnVO = new HotLineVO();
		if(!EgovStringUtil.isEmpty(hotLineId)){
			returnVO = dao.selectHotLineView(hotLineId);
			returnVO.setUdtNm(sessionVO.getUserNm());
		}
		returnVO.setRegNm(sessionVO.getUserNm());
		model.addAttribute("hotLineVO", returnVO);
		model.addAttribute("searchVO", searchVO);
		return "/adm/hotLine/hotLineModify";
	}
	
	
	/**
	 *  비상연락망 등록&수정 처리
	 * @param searchVO
	 * @param paramVO
	 * @param model
	 * @param session
	 * @param request
	 * @param reda
	 * @return
	 * @throws Exception
	 */
	@SuppressWarnings("unchecked")
	@RequestMapping("/adm/hotLine/hotLineSubmit.do")
	public String hotLineSubmit(@ModelAttribute("searchVO") CmmnSearchVO searchVO, HotLineVO paramVO, ModelMap model, HttpSession session, MultipartHttpServletRequest multiRequest, RedirectAttributes reda) throws Exception {
		LOGGER.info("/adm/hotLine/hotLineSubmit.do - 비상연락망 등록&수정 처리");
		LOGGER.debug("paramVO >> " +paramVO.toString());
		String message = "등록되었습니다";
		
		//첨부파일 확인
		/*첨부파일 존재할시 등록*/
		if(cmmnFileMngUtil.uploadFileRegiChk(multiRequest)){
			boolean flag = cmmnFileMngUtil.uploadFileCheck(multiRequest);
			if(!flag){
				LOGGER.debug("첨부된 파일의 용량 또는 확장자가 잘못되었습니다.");
				message = "첨부된 파일의 용량 또는 확장자가 잘못되었습니다.";
				return redirectListPage(message, searchVO, reda);
			}
			FileVO fileParamVO = new FileVO(cmmnFileMngUtil.uploadAttachedFile(multiRequest, "HOTLINE"));
			ExcelUtil eUtil = new ExcelUtil();
			Map<String, Object> resultMap = eUtil.getExcelUploadData(fileParamVO.getSaveFileNm());
			List<HotLineVO> paramList = (List<HotLineVO>) resultMap.get("paramList");
			
			if(paramList.size() > 0){
				//등록전 전체 삭제
				dao.deleteHotLineAll();
				
				for (HotLineVO hotLineVO : paramList) {
					dao.insertHotLine(hotLineVO);
				}
				if(EgovStringUtil.isEmpty(resultMap.get("errorStr").toString())){
					message = "엑셀 업로드가 완료되었습니다.";
				}else{
					message = resultMap.get("errorStr").toString();
				}
			}else{
				message = "엑셀 업로드가 실패했습니다.";
			}
			return redirectListPage(message, searchVO, reda);
		}
		
		
		paramVO.setHotLineTel(ComStringUtil.setTelFormat(paramVO.getHotLineTel1(), paramVO.getHotLineTel2(), paramVO.getHotLineTel3()));
		if(!EgovStringUtil.isEmpty(paramVO.getHotLineEmail1()) && !EgovStringUtil.isEmpty(paramVO.getHotLineEmail2())){
			paramVO.setHotLineEmail(ComStringUtil.setEmailFormat(paramVO.getHotLineEmail1(), paramVO.getHotLineEmail2()));
		}
		
		if(EgovStringUtil.isEmpty(paramVO.getHotLineId())){
			dao.insertHotLine(paramVO);
		}else{
			dao.updateHotLine(paramVO);
			message = "수정되었습니다.";
		}
		
		return redirectListPage( message, searchVO, reda);
	}
	
	/**
	 *  비상연락망 삭제 처리
	 * @param searchVO
	 * @param hotLineId
	 * @param model
	 * @param session
	 * @param request
	 * @param reda
	 * @return
	 * @throws Exception
	 */
	@RequestMapping("/adm/hotLine/hotLineDelete.do")
	public String hotLineDelete(@ModelAttribute("searchVO") CmmnSearchVO searchVO, String hotLineId, ModelMap model, HttpSession session, HttpServletRequest request, RedirectAttributes reda) throws Exception {
		LOGGER.info("/adm/hotLine/hotLineSubmit.do - 비상연락망 삭제 처리");

		dao.deleteHotLine(hotLineId);
		return redirectListPage( "삭제되었습니다", searchVO, reda);
	}

}
