package writer.adm.qestnar;

import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import component.web.PaginationController;
import egovframework.com.cmm.util.EgovUserDetailsHelper;
import egovframework.let.utl.fcc.service.EgovStringUtil;
import egovframework.rte.psl.dataaccess.util.EgovMap;
import egovframework.rte.ptl.mvc.tags.ui.pagination.PaginationInfo;
import writer.adm.cmm.AdmCmmDAO;
import writer.adm.cmm.AdmCmmLogDAO;
import writer.valueObject.AdminVO;
import writer.valueObject.ClassVO;
import writer.valueObject.DepartmentVO;
import writer.valueObject.QestnarAskVO;
import writer.valueObject.QestnarReplyVO;
import writer.valueObject.QestnarVO;
import writer.valueObject.cmmn.CmmnListVO;
import writer.valueObject.cmmn.CmmnSearchVO;

@Controller
public class AdmQestnarController {

	private static final Logger LOGGER = LoggerFactory.getLogger(AdmQestnarController.class);
	
	@Autowired private AdmQestnarDAO admQestnarDAO;
	@Autowired private AdmCmmDAO admCmmDAO;
	
	@Autowired private AdmCmmLogDAO admCmmLogDAO;
	
	// 검색조건을 가지고 목록으로 이동합니다.
	private String redirectListPage(CmmnSearchVO searchVO, RedirectAttributes reda){
		reda.addFlashAttribute("message", searchVO.getMessage());
		return "redirect:/xabdmxgr/qestnar/admQuestionaireList.do";
	}
	
	// 목록
	@RequestMapping("/xabdmxgr/qestnar/admQuestionaireList.do")
	public String admQuestionaireList(@ModelAttribute("searchVO") CmmnSearchVO searchVO, ModelMap model, HttpSession session) throws Exception {
		LOGGER.info("/xabdmxgr/qestnar/admQuestionaireList.do - 관리자 > 설문조사 > 목록");
		LOGGER.debug("searchVO = "+searchVO.toString());
		// 메뉴 코드
		session.setAttribute("admMenuNo", "70");
		
		PaginationInfo paginationInfo = PaginationController.getPaginationInfo(searchVO);
		
		CmmnListVO listVO = admQestnarDAO.selectQestnarInfoList(searchVO);
		
		paginationInfo.setTotalRecordCount(listVO.getTotalRecordCount());
		model.addAttribute("paginationInfo", paginationInfo);
		model.addAttribute("resultList", listVO.getEgovList());
		
		
		return "/adm/qestnar/admQuestionaireList";
	}
	
	// 설문등록 화면
	@RequestMapping("/xabdmxgr/qestnar/admQuestionaireModify.do")
	public String admQuestionaireModify(@ModelAttribute("searchVO") CmmnSearchVO searchVO, ModelMap model, String qstnrSeq){
		LOGGER.info("/xabdmxgr/qestnar/admQuestionaireList.do - 관리자 > 설문조사 > 설문등록 화면");
		LOGGER.debug("searchVO = "+searchVO.toString());

		
		QestnarVO qestnarVO;
		
		if(EgovStringUtil.isEmpty(qstnrSeq)){
			//등록
			qestnarVO = new QestnarVO();
			
		}else{
			//수정
			qestnarVO = admQestnarDAO.selectQestnarInfoOne(qstnrSeq);
			List<QestnarAskVO> qestnarAskVO = admQestnarDAO.selectQestnarAskOne(qstnrSeq);
			List<QestnarReplyVO> qestnarReplyVO = admQestnarDAO.selectQestnarReplyOne(qstnrSeq);
			
			model.addAttribute("qestnarAskVO",qestnarAskVO);
			model.addAttribute("qestnarReplyVO",qestnarReplyVO);
			
			model.addAttribute("askNoCnt", qestnarAskVO.size());
		}
		
		
		model.addAttribute("qestnarVO", qestnarVO);
		model.addAttribute("smtrList", admCmmDAO.selectSmtrList());
		return "/adm/qestnar/admQuestionaireModify";
	}
	
	//설문조사 등록
	@RequestMapping("/xabdmxgr/qestnar/admQuestionaireUpdate.do")
	public String admQuestionaireUpdate(ModelMap model, @ModelAttribute("searchVO") CmmnSearchVO searchVO, QestnarVO qestnarVO, RedirectAttributes reda, HttpServletRequest request)throws Exception{
		LOGGER.info("/xabdmxgr/qestnar/admQuestionaireUpdate.do - 관리자 > 설문조사 > 설문등록");
		LOGGER.debug("qestnarVO - "+qestnarVO.toString());
		LOGGER.debug("qestnarAskVO - "+qestnarVO.getAskList().toString());
		for(int i=0; i<qestnarVO.getAskList().size() ;i++){
			LOGGER.debug("qestnarReplyList - "+qestnarVO.getAskList().get(i).getRepList().toString());
		}

		if(EgovStringUtil.isEmpty(qestnarVO.getSmtrSeq())){
			searchVO.setMessage("학기 강의실이 존재하지 않습니다.");
			return redirectListPage(searchVO, reda);
		}
		
		AdminVO adminVO = (AdminVO) EgovUserDetailsHelper.getAuthenticatedAdmin();
		//qestnarVO.setRegId(adminVO.getMemName());
		qestnarVO.setRegId("writer");

		String rsQstnrSeq = "";
		
		if(EgovStringUtil.isEmpty(qestnarVO.getQstnrSeq())){
			//등록
			qestnarVO.setQstnrRespCount("0");
			rsQstnrSeq = admQestnarDAO.insertQestnarInfoOne(qestnarVO);
			
			
		}else{
			//수정
			admQestnarDAO.updateQestnarInfoOne(qestnarVO);
			
			rsQstnrSeq = qestnarVO.getQstnrSeq();
			
			admQestnarDAO.deleteQstnrAskOne(qestnarVO.getQstnrSeq());
			admQestnarDAO.deleteQstnrReplyOne(qestnarVO.getQstnrSeq());
			
		}
		
		for(int i=0; i<qestnarVO.getAskList().size(); i++){
			QestnarAskVO qestnarAskVO = qestnarVO.getAskList().get(i);
			qestnarAskVO.setQstnrSeq(rsQstnrSeq);
			
			admQestnarDAO.insertQestnarAskOne(qestnarAskVO);
			
			String rsAskSeq = qestnarAskVO.getAskNo();
			if(!"3".equals(qestnarAskVO.getAskType())){
				for(int j=0; j<qestnarAskVO.getRepList().size() ;j++){
					QestnarReplyVO qestnarReplyVO = qestnarAskVO.getRepList().get(j);
					qestnarReplyVO.setQstnrSeq(rsQstnrSeq);
					qestnarReplyVO.setAskNo(rsAskSeq);
					admQestnarDAO.insertQestnarReplyOne(qestnarReplyVO);			
				}
			}
		}

		// 로그 등록
		String ip = request.getHeader("X-FORWARDED-FOR");
		if (ip == null) ip = request.getRemoteAddr();
		admCmmLogDAO.insertLogOne("설문조사 등록&수정("+rsQstnrSeq+")", ip);

		searchVO.setMessage("등록되었습니다.");
		return redirectListPage(searchVO, reda);
	}
	
	//설문조사_답변자 목록
	@RequestMapping("/xabdmxgr/qestnar/admQuestionaireAnswererList.do")
	public String admQuestionairePsnList(@ModelAttribute("searchVO") CmmnSearchVO searchVO, ModelMap model, HttpSession session) throws Exception {
		LOGGER.info("/xabdmxgr/qestnar/admQuestionairePsnList.do - 관리자 > 설문조사 > 답변자 보기");
		LOGGER.debug("searchVO = "+searchVO.toString());
		// 메뉴 코드
		session.setAttribute("admMenuNo", "70");
		
		PaginationInfo paginationInfo = PaginationController.getPaginationInfo(searchVO);
		
		CmmnListVO listVO = admQestnarDAO.selectQestnarAnswererList(searchVO);
		
		paginationInfo.setTotalRecordCount(listVO.getTotalRecordCount());
		model.addAttribute("paginationInfo", paginationInfo);
		model.addAttribute("resultList", listVO.getEgovList());
		
		List<DepartmentVO> deptList = admCmmDAO.selectDeptList(searchVO);
		model.addAttribute("deptList", deptList);
		
		List<ClassVO> clsList = (List<ClassVO>) admQestnarDAO.selectClassList(searchVO);
		model.addAttribute("clsList", clsList);
		
		return "/adm/qestnar/admQestnarAnswererList";
	}
	
	//설문조사_삭제
	@RequestMapping("/xabdmxgr/qestnar/admQuestionaireDelete.do")
	public String admQuestionaireDelete(@ModelAttribute("searchVO") CmmnSearchVO searchVO, ModelMap model, RedirectAttributes reda, @RequestParam("qstnrSeq")String qstnrSeq){
		LOGGER.info("/xabdmxgr/qestnar/admQuestionaireDelete.do - 관리자 > 설문조사 > 삭제");
		LOGGER.debug("searchVO - "+searchVO.toString());
		
		
		admQestnarDAO.deleteQstnrInfoOne(qstnrSeq);
		admQestnarDAO.deleteQstnrAskOne(qstnrSeq);
		admQestnarDAO.deleteQstnrReplyOne(qstnrSeq);
		
		searchVO.setMessage("삭제되었습니다.");
		
		return redirectListPage(searchVO, reda);
	}
	
	//설문조사_조회
	@RequestMapping("/xabdmxgr/qestnar/admQuestionaireView.do")
	public String admQuestionaireView(@ModelAttribute("searchVO") CmmnSearchVO searchVO, ModelMap model, @RequestParam("qstnrSeq")String qstnrSeq, RedirectAttributes reda, HttpServletRequest request){
		LOGGER.info("/xabdmxgr/qestnar/admQuestionaireDelete.do - 관리자 > 설문조사 > 조회");
		LOGGER.debug("searchVO - "+searchVO.toString());
		LOGGER.debug("qstnrSeq - "+qstnrSeq);
		
		QestnarVO resultVO=admQestnarDAO.selectQestnarInfoOne(qstnrSeq);
		
		if(resultVO == null){
			searchVO.setMessage("게시글이 없습니다.");
			return redirectListPage(searchVO, reda);
		}
		
		model.addAttribute("resultVO", resultVO);
		
		List<QestnarAskVO> resultAskList = admQestnarDAO.selectQestnarAskOne(qstnrSeq);
		List<QestnarReplyVO> resultReplyList = admQestnarDAO.selectQestnarReplyOne(qstnrSeq);
		
		model.addAttribute("resultAskList", resultAskList);
		model.addAttribute("resultReplyList", resultReplyList);
		
		List<DepartmentVO> deptList = admCmmDAO.selectDeptList(searchVO);
		
		searchVO.setSearchWord(qstnrSeq);
		for(int i=0;i<deptList.size();i++){
			searchVO.setSearchDepartment(deptList.get(i).getDeptSeq());
			deptList.get(i).setQstnrCnt(admQestnarDAO.selectQestnarAnswererListCnt(searchVO)+"");
		}
		model.addAttribute("deptList", deptList);
		
		// 로그 등록
		String ip = request.getHeader("X-FORWARDED-FOR");
        if (ip == null) ip = request.getRemoteAddr();
		admCmmLogDAO.insertLogOne("설문조사 조회("+qstnrSeq+")", ip);
		
		return "adm/qestnar/admQuestionaireView";
	}
	
	/******************************************** 2017-07-25 추가 ********************************************/
	
	// 주관식 답변 목록
	@RequestMapping("/xabdmxgr/qestnar/admSubAnswerList.do")
	public String admSubAnswerList(@RequestParam String qstnrSeq,@RequestParam String askNo, ModelMap model) throws Exception {
		LOGGER.info("/xabdmxgr/qestnar/admSubAnswerList.do - 관리자 > 설문조사 > 조회 > 주관식 답변 목록");
		LOGGER.debug("qstnrSeq = {}", qstnrSeq);
		LOGGER.debug("askNo = {}", askNo);
		
		List<EgovMap> subAnswerList = admQestnarDAO.selectSubAnswerList(qstnrSeq, askNo);
		for(EgovMap vo : subAnswerList){
			vo.put("pansTxt", vo.get("pansTxt").toString().replaceAll("\r\n", "<br/>"));
		}
		model.addAttribute("subAnswerList", subAnswerList);
		return "/adm/qestnar/admQuestionaireSubAnswerList";
	}
}
