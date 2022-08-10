package writer.usr.cnslt;

import java.text.SimpleDateFormat;
import java.util.Calendar;
import java.util.Date;
import java.util.List;

import javax.annotation.Resource;
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

import component.file.CmmnFileMngUtil;
import component.file.FileInfoVO;
import component.web.PaginationController;
import egovframework.rte.psl.dataaccess.util.EgovMap;
import egovframework.rte.ptl.mvc.tags.ui.pagination.PaginationInfo;
import writer.usr.cmm.CmmDAO;
import writer.valueObject.CnsltApplyVO;
import writer.valueObject.CnsltScheduleVO;
import writer.valueObject.DepartmentVO;
import writer.valueObject.cmmn.CmmnListVO;
import writer.valueObject.cmmn.CmmnSearchVO;

@Controller
public class CnsltController {
	
	private static final Logger LOGGER = LoggerFactory.getLogger(CnsltController.class);
	
	@Autowired private CnsltDAO cnsltDAO;
	@Autowired private CmmDAO cmmDAO;
	@Autowired private CmmnFileMngUtil cmmnFileMngUtil;
	
	/****************************************** 공통 ******************************************/
	// 검색조건을 가지고 각 페이지로 이동합니다.
	private String redirectCnsltPage(String message, String type, CmmnSearchVO searchVO, RedirectAttributes reda){
		reda.addFlashAttribute("message", message);
		reda.addFlashAttribute("searchVO", searchVO);
		
		if("REGI".equals(type)){
			return "redirect:/usr/cnslt/cnsltRequestRegiModify.do";
		}else if("OVER".equals(type)){
			return "redirect:/usr/cnslt/cnsltRequestOverModify.do";
		}else if("LIST".equals(type)){
			return "redirect:/usr/cnslt/cnsltRecordList.do";
		}
		return "redirect:/usr/cnsltRequestInfoView.do";
	}
	
	
	/****************************************** 상담안내 ******************************************/
	// 상담안내 소개화면
	@RequestMapping("/usr/cnsltInfoView.do")
	public String cnsltInfoView(@ModelAttribute("searchVO") CmmnSearchVO searchVO, HttpSession session) throws Exception {
		LOGGER.info("/usr/cnsltInfoView.do - 사용자 > 상담 > 상담안내 소개화면");
		// 메뉴 코드
		session.setAttribute("menuNo", "401");
		return "/usr/cnslt/cnsltInfoView";
	}
	
	/****************************************** 상담신청 ******************************************/
	// 상담신청 소개화면
	@RequestMapping("/usr/cnsltRequestInfoView.do")
	public String cnsltRequestModify(@ModelAttribute("searchVO") CmmnSearchVO searchVO, HttpSession session) throws Exception {
		LOGGER.info("/usr/cnsltRequestInfoView.do - 사용자 > 상담 > 상담신청 소개화면");
		// 메뉴 코드
		session.setAttribute("menuNo", "402");
		return "/usr/cnslt/cnsltRequestInfoView";
	}
	
	// 상담신청 화면(재학생)
	@RequestMapping("/usr/cnslt/cnsltRequestRegiModify.do")
	public String cnsltRequestRegiModify(@ModelAttribute("searchVO") CmmnSearchVO searchVO, ModelMap model) throws Exception {
		LOGGER.info("/usr/cnslt/cnsltRequestRegiModify.do - 사용자 > 상담 > 상담신청 화면(재학생)");
		List<DepartmentVO> deptList = cmmDAO.selectDeptList(searchVO);
		model.addAttribute("deptList", deptList);
		return "/usr/cnslt/cnsltRequestRegiModify";
	}
	
	// 상담신청 화면(외국인)
	@RequestMapping("/usr/cnslt/cnsltRequestOverModify.do")
	public String cnsltRequestOverModify(@ModelAttribute("searchVO") CmmnSearchVO searchVO, ModelMap model) throws Exception {
		LOGGER.info("/usr/cnslt/cnsltRequestOverModify.do - 사용자 > 상담 > 상담신청 화면(외국인)");
		List<DepartmentVO> deptList = cmmDAO.selectDeptList(searchVO);
		model.addAttribute("deptList", deptList);
		return "/usr/cnslt/cnsltRequestOverModify";
	}
	
	// 상담일자 검색
	@Resource View jsonView;
	@RequestMapping("/usr/cnslt/cnsltScheduleListAjax.do")
	public View cnsltScheduleListAjax(@RequestParam String schYmd, ModelMap model) throws Exception {
		LOGGER.info("/usr/cnslt/cnsltScheduleListAjax.do - 사용자 > 상담 > 상담신청 화면 > 일정 검색");
		LOGGER.debug("schYmd = "+schYmd);
		
		SimpleDateFormat format = new SimpleDateFormat("yyyy-MM-dd");
		String nowDate = format.format(new Date());
		Calendar cal = Calendar.getInstance();
		cal.setTime(new Date());
		cal.add(Calendar.DATE, 1);
		String addDate = format.format(cal.getTime());
		String flag = nowDate.equals(schYmd)||addDate.equals(schYmd)? "Y":"N";
		
		List<CnsltScheduleVO> scheduleListVO = cnsltDAO.selectCnsltScheduleList(schYmd, flag);
		model.addAttribute("scheduleListVO", scheduleListVO);
		return jsonView;
	}
	
	// 상담일자 체크
	@RequestMapping("/usr/cnslt/cnsltScheduleCheckAjax.do")
	public View cnsltScheduleCheckAjax(@RequestParam String schSeq, ModelMap model) throws Exception {
		LOGGER.info("/usr/cnslt/cnsltScheduleCheckAjax.do - 사용자 > 상담 > 상담신청 화면 > 일정 체크");
		LOGGER.debug("schSeq = "+schSeq);
		
		int result = cnsltDAO.selectCnsltScheduleCheck(schSeq);
		model.addAttribute("result", result);
		return jsonView;
	}
	
	// 상담신청(재학생&외국인)
	@RequestMapping("/usr/cnslt/cnsltRequestRegiUpdate.do")
	public String cnsltRequestRegiUpdate(CnsltApplyVO cnsltApplyVO, @ModelAttribute("searchVO") CmmnSearchVO searchVO, MultipartHttpServletRequest multiRequest, RedirectAttributes reda) throws Exception {
		LOGGER.info("/usr/cnslt/cnsltRequestRegiUpdate.do - 사용자 > 상담 > 상담신청 화면 > 상담신청(재학생&외국인)"); 
		LOGGER.debug("cnsltApplyVO = "+cnsltApplyVO.toString());
		
		String aplyUsrType = cnsltApplyVO.getAplyUsrType(); // 재학생&외국인 구별
		
		if(!"REGI".equals(aplyUsrType) && !"OVER".equals(aplyUsrType)){
			LOGGER.debug("지정된 타입을 선택하지 않았습니다.(aplyUsrType = "+aplyUsrType+")");
			return redirectCnsltPage("오류가 발생하였습니다. 관리자에게 문의해주세요.", "", searchVO, reda);
		}
		
		// 첨부파일 조건 검사
		boolean flag = cmmnFileMngUtil.uploadFileCheck(multiRequest);
		if(!flag){
			LOGGER.debug("파일첨부 오류");
			return redirectCnsltPage("업로드파일이 잘못되었습니다.", aplyUsrType, searchVO, reda);
		}
		
		// 휴대폰 번호 set
		cnsltApplyVO.setAplyMphone(cnsltApplyVO.getAplyMphone1()+"-"+cnsltApplyVO.getAplyMphone2()+"-"+cnsltApplyVO.getAplyMphone3());
		String rsAplySeq = "";
		if("REGI".equals(aplyUsrType)){
			// 재학생
			rsAplySeq = cnsltDAO.cnsltRequestRegiInsert(cnsltApplyVO);
		}else if("OVER".equals(aplyUsrType)){
			// 외국인
			rsAplySeq = cnsltDAO.cnsltRequestOverInsert(cnsltApplyVO);
		}
		
		// 첨부파일 등록
		List<FileInfoVO> fileInfoList = cmmnFileMngUtil.uploadAttachedFiles(multiRequest, "CONSULT");
		for(FileInfoVO fileInfoVO : fileInfoList){
			cnsltDAO.cnsltRequestUpfileInsert(fileInfoVO, rsAplySeq);
		}
		
		return redirectCnsltPage("상담신청이 완료되었습니다.", "LIST", searchVO, reda);
	}
	
	/****************************************** 마이페이지 ******************************************/
	// 목록
	@RequestMapping("/usr/cnslt/cnsltRecordList.do")
	public String cnsltRecordList(@ModelAttribute("searchVO") CmmnSearchVO searchVO, ModelMap model, HttpSession session) throws Exception {
		LOGGER.info("/usr/cnslt/cnsltRecordList.do - 사용자 > 상담 > 마이페이지");
		// 메뉴 코드
		session.setAttribute("menuNo", "403");
		
		List<EgovMap> cnsltUpfileList = cnsltDAO.selectNewCnsltUpfileList();
		model.addAttribute("cnsltUpfileList", cnsltUpfileList);
		
		PaginationInfo paginationInfo = PaginationController.getPaginationInfo(searchVO);
		CmmnListVO listVO = cnsltDAO.selectCnsltRecordList(searchVO);
		paginationInfo.setTotalRecordCount(listVO.getTotalRecordCount());
		model.addAttribute("paginationInfo", paginationInfo);
		model.addAttribute("resultList", listVO.getEgovList());
		return "/usr/cnslt/cnsltRecordList";
	}
	
	// 상담 삭제
	@RequestMapping("/usr/cnslt/cnsltDeleteOne.do")
	public String cnsltDeleteOne(@ModelAttribute("searchVO") CmmnSearchVO searchVO, ModelMap model, RedirectAttributes reda, CnsltApplyVO cnsltApplyVO)throws Exception{
		LOGGER.info("/usr/cnslt/cnsltDeleteOne.do - 사용자 > 상담 > 마이페이지 > 상담신청 삭제");
		LOGGER.debug("cnsltApplyVO - "+cnsltApplyVO.toString());
		
		if(!("1".equals(cnsltApplyVO.getAplyStatus()))){
			LOGGER.debug("상담신청을 취소할 수 없습니다.");
			return redirectCnsltPage("상담신청을 취소할 수 없습니다.", "LIST", searchVO, reda);
		}
		
		cnsltDAO.deleteCnsltInfoOne(cnsltApplyVO.getAplySeq(), cnsltApplyVO.getAplyUsrType());
/**
 		2018-05-28 celldio 수정
		// 첨부파일 삭제
		List<EgovMap> cnsltFileList = cnsltDAO.selectCnsltUpfileList(cnsltApplyVO.getAplySeq());
		if(cnsltFileList.size() != 0){
			List<String> upSeqList = new ArrayList<>();
			for(EgovMap cnsltFile : cnsltFileList){
				cmmnFileMngUtil.deleteFile(cnsltFile.get("upSaveFilePath").toString());	// 파일 삭제
				upSeqList.add(cnsltFile.get("upSeq").toString());
			}
			cnsltDAO.deleteCnsltUpfileList(upSeqList);	// 데이터 삭제
		}
*/
		return redirectCnsltPage("상담신청이 취소되었습니다.", "LIST", searchVO, reda);
	}
}
