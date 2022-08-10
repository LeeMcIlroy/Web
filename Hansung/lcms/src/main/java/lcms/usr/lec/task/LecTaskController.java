package lcms.usr.lec.task;

import java.util.List;

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
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.multipart.MultipartHttpServletRequest;
import org.springframework.web.servlet.View;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import component.file.CmmnFileMngUtil;
import component.file.FileInfoVO;
import component.web.PaginationController;
import egovframework.com.cmm.util.EgovUserDetailsHelper;
import egovframework.let.utl.fcc.service.EgovStringUtil;
import egovframework.rte.psl.dataaccess.util.EgovMap;
import egovframework.rte.ptl.mvc.tags.ui.pagination.PaginationInfo;
import lcms.adm.cmm.AdmCmmController;
import lcms.valueObject.AttachVO;
import lcms.valueObject.TaskSubVO;
import lcms.valueObject.TaskVO;
import lcms.valueObject.UsrVO;
import lcms.valueObject.cmm.CmmnListVO;
import lcms.valueObject.cmm.CmmnSearchVO;

@Controller
public class LecTaskController extends AdmCmmController {
	
	private static final Logger LOGGER = LoggerFactory.getLogger(LecTaskController.class);
	
	@Autowired private LecTaskDAO lecTaskDAO;
	@Resource private CmmnFileMngUtil fileUtil;
	@Resource View jsonView;
	
	// 강사 과제 조회 화면 리다이렉트
	private String redirectView(RedirectAttributes reda, String taskSeq, String message){
		reda.addFlashAttribute("taskSeq", taskSeq);
		reda.addFlashAttribute("message", message);
		return "redirect:/usr/lec/task/lecTaskView.do";
	}

	// 강사 과제 조회 화면 리다이렉트
	private String redirectList(RedirectAttributes reda, CmmnSearchVO searchVO, String message){
		reda.addFlashAttribute("searchVO", searchVO);
		reda.addFlashAttribute("message", message);
		return "redirect:/usr/lec/task/lecTaskList.do";
	}
	
	// 강사 - 과제 목록 화면
	@RequestMapping("/usr/lec/task/lecTaskList.do")
	public String lecResultList(@ModelAttribute("searchVO") CmmnSearchVO searchVO, HttpSession session, HttpServletRequest request, ModelMap model) throws Exception {
		LOGGER.debug("/usr/lec/task/lecTaskList.do - 강사 - 과제 목록 화면");
		request.getSession().setAttribute("lecMenuNo", "201");
		
		//세션 값 가져오기
		EgovMap lecSession = (EgovMap)session.getAttribute("lecSession");
		
		searchVO.setSearchLecture(Integer.toString((int)lecSession.get("lectSeq")));
		PaginationInfo paginationInfo = PaginationController.getPaginationInfo(searchVO);
		CmmnListVO listVO = lecTaskDAO.LecTaskList(searchVO); 
		paginationInfo.setTotalRecordCount(listVO.getTotalRecordCount());
		
		model.addAttribute("resultList", listVO.getEgovList());
		model.addAttribute("paginationInfo", paginationInfo);
		model.addAttribute("totalCount", paginationInfo.getTotalRecordCount());
		model.addAttribute("currentPageNo", paginationInfo.getCurrentPageNo());
		model.addAttribute("totalPageCount", paginationInfo.getTotalPageCount());
		
		
		return "/usr/lec/task/lecTaskList";
	}
	
	// 강사 - 과제 상세 화면
	@RequestMapping("/usr/lec/task/lecTaskView.do")
	public String lecResultView(@ModelAttribute("searchVO") CmmnSearchVO searchVO, @ModelAttribute("taskSeq") String taskSeq, HttpSession session, HttpServletRequest request, ModelMap model) throws Exception {
		LOGGER.debug("/usr/lec/task/lecTaskView.do - 강사 - 과제 상세 화면");
		LOGGER.debug("taskSeq = " + taskSeq);
		request.getSession().setAttribute("lecMenuNo", "201");
		
		TaskVO taskVO = new TaskVO();
		
		if(!EgovStringUtil.isEmpty(taskSeq)){
			taskVO = lecTaskDAO.selectTaskOne(taskSeq);
			
			EgovMap map = new EgovMap();
			map.put("boardSeq", taskSeq);
			map.put("boardType", "TASK");
			
			List<AttachVO> attachList = cmmDAO.selectAttachList(map);
			model.addAttribute("attachList", attachList);
		}
		model.addAttribute("taskVO", taskVO);
		
		searchVO.setSearchType(taskSeq);
		searchVO.setSearchLecture(taskVO.getLectTbseq());
		PaginationInfo paginationInfo = PaginationController.getPaginationInfo(searchVO);
		CmmnListVO listVO = lecTaskDAO.selectPresenList(searchVO); 
		paginationInfo.setTotalRecordCount(listVO.getTotalRecordCount());
		
		model.addAttribute("resultList", listVO.getEgovList());
		model.addAttribute("paginationInfo", paginationInfo);
		model.addAttribute("totalPageCount", paginationInfo.getTotalPageCount());
		
		return "/usr/lec/task/lecTaskView";
	}

	// 강사 - 과제 제출과제 다운로드
	@RequestMapping("/usr/lec/task/lecTaskSubShow.do")
	public View lecTaskSubShow(String subSeq, HttpSession session, HttpServletRequest request, ModelMap model) throws Exception {
		LOGGER.debug("/usr/lec/task/lecTaskSubShow.do - 강사 - 과제 제출과제 다운로드");
		LOGGER.debug("subSeq = " + subSeq);
		
		if(!EgovStringUtil.isEmpty(subSeq)){
			String downDate = lecTaskDAO.selectLecTaskSubDownDate(subSeq);
			if(EgovStringUtil.isEmpty(downDate)){
				lecTaskDAO.updateLecTaskSubShow(subSeq);
			}
		}
		
		return jsonView;
	}
	
	// 강사 - 과제 등록/수정 화면
	@RequestMapping("/usr/lec/task/lecTaskModify.do")
	public String lecTaskModify(@ModelAttribute("searchVO") CmmnSearchVO searchVO, String taskSeq, HttpSession session, HttpServletRequest request, ModelMap model) throws Exception {
		LOGGER.debug("taskSeq = " + taskSeq);
		request.getSession().setAttribute("lecMenuNo", "201");
		
		TaskVO taskVO = new TaskVO();
		
		if(!EgovStringUtil.isEmpty(taskSeq)){
			taskVO = lecTaskDAO.selectTaskOne(taskSeq);
			
			EgovMap map = new EgovMap();
			map.put("boardSeq", taskSeq);
			map.put("boardType", "TASK");
			
			List<AttachVO> attachList = cmmDAO.selectAttachList(map);
			model.addAttribute("attachList", attachList);
		}
		
		model.addAttribute("taskVO", taskVO);
		
		return "/usr/lec/task/lecTaskModify";
	}

	// 강사 - 과제 등록/수정 화면 
	@RequestMapping("/usr/lec/task/lecTaskDel.do")
	public String lecTaskDel(@ModelAttribute("searchVO") CmmnSearchVO searchVO, String taskSeq, HttpSession session, HttpServletRequest request, ModelMap model, RedirectAttributes reda) throws Exception {
		LOGGER.debug("taskSeq = " + taskSeq);
		request.getSession().setAttribute("lecMenuNo", "201");
		
		String message = "";
		
		if(!EgovStringUtil.isEmpty(taskSeq)){
			int cnt = lecTaskDAO.selectTaskSubCnt(taskSeq);
			if(cnt > 0){
				message = "제출된 과제가 존재해 삭제할 수 없습니다.";
				return redirectView(reda, taskSeq, message);
			}else{
				message = "삭제가 완료되었습니다.";
				lecTaskDAO.deleteTaskSub(taskSeq);
				lecTaskDAO.deleteTask(taskSeq);
			}
		}
		
		return redirectList(reda, searchVO, message);
	}
	
	// 강사 - 과제 등록/수정
	@RequestMapping("/usr/lec/task/lecAddTask.do")
	public String lecAddTask(@ModelAttribute("taskVo") TaskVO taskVO, String[] delSeqList, MultipartHttpServletRequest request, ModelMap model, HttpSession session) throws Exception {
		LOGGER.debug("/usr/lec/task/lecAddTask.do - 강사 - 과제 등록/수정");
		request.getSession().setAttribute("lecMenuNo", "201");
		//세션 값 가져오기
		EgovMap lecSession = (EgovMap)session.getAttribute("lecSession");
		taskVO.setLectTbseq(Integer.toString((int)lecSession.get("lectSeq")));
		
		UsrVO sessionVO = (UsrVO) EgovUserDetailsHelper.getAuthenticatedUser();
		
		if(EgovStringUtil.isEmpty(taskVO.getTaskSeq())){
			taskVO.setRegId(sessionVO.getMemberCode());
			lecTaskDAO.lecAddTask(taskVO);
		}else{
			taskVO.setUpdId(sessionVO.getMemberCode());
			lecTaskDAO.lecEditTask(taskVO);
			
			if(delSeqList != null){
				for(String delSeq : delSeqList){
					AttachVO delAttach = cmmDAO.selectAttachOne(delSeq);
					fileUtil.deleteFile(delAttach.getRegFileName());
					cmmDAO.deleteAttachFile(delAttach.getAttachSeq());
				}
			}
		}
		
		List<FileInfoVO> fileInfoList = fileUtil.totUploadFiles(request, "TASK");
		if(fileInfoList != null){
			for(FileInfoVO fileInfoVO : fileInfoList){
				AttachVO attachVO = new AttachVO(fileInfoVO);
				attachVO.setBoardType("TASK");
				attachVO.setBoardSeq(taskVO.getTaskSeq());
				cmmDAO.insertAttachFile(attachVO);
			}
		}

		return "redirect:/usr/lec/task/lecTaskList.do";
	}
	
	
	
	
}
