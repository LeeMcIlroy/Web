package lcms.usr.std.lecRoom;

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
import org.springframework.web.multipart.MultipartHttpServletRequest;
import org.springframework.web.servlet.View;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import component.file.CmmnFileMngUtil;
import component.file.FileInfoVO;
import component.web.PaginationController;
import egovframework.let.utl.fcc.service.EgovStringUtil;
import egovframework.rte.psl.dataaccess.util.EgovMap;
import egovframework.rte.ptl.mvc.tags.ui.pagination.PaginationInfo;
import lcms.adm.cmm.AdmCmmController;
import lcms.valueObject.AttachVO;
import lcms.valueObject.TaskSubVO;
import lcms.valueObject.UsrVO;
import lcms.valueObject.cmm.CmmnListVO;
import lcms.valueObject.cmm.CmmnSearchVO;

@Controller
public class StdLecTaskController extends AdmCmmController {
	
	private static final Logger LOGGER = LoggerFactory.getLogger(StdLecTaskController.class);
	
	@Autowired private StdLecTaskDAO stdLecTaskDAO;
	@Resource private CmmnFileMngUtil fileUtil;
	@Resource View jsonView;
	
	// 관리자 신입학 목록화면 리다이렉트
	private String redirectView(RedirectAttributes reda, TaskSubVO taskSubVO){
		reda.addFlashAttribute("taskSubVO", taskSubVO);
		return "redirect:/usr/std/lecRoom/stdLecTaskView.do";
	}
	
	// 학생 - 강의실 과제 리스트
	@RequestMapping("/usr/std/lecRoom/stdLecTaskList.do")
	public String stdLecTaskList(@ModelAttribute("searchVO") CmmnSearchVO searchVO, HttpSession session, HttpServletRequest request, ModelMap model) throws Exception {
		LOGGER.debug("/usr/std/lecRoom/stdLecTaskList.do - 학생 강의실 과제 리스트");
		request.getSession().setAttribute("stdMenuNo", "103");
		
		//세션 값 가져오기
		EgovMap lecSession = (EgovMap)session.getAttribute("lecSession");
		UsrVO usrVO = ((UsrVO)session.getAttribute("usrSession")!=null)?(UsrVO)session.getAttribute("usrSession"):null;
		//searchCondition4 : 강의코드
		
		searchVO.setSearchCondition4(Integer.toString((int)lecSession.get("lectSeq")));
		searchVO.setSearchCondition3(usrVO.getMemberCode());
		PaginationInfo paginationInfo = PaginationController.getPaginationInfo(searchVO);
		CmmnListVO listVO = stdLecTaskDAO.LecTaskList(searchVO); 
		paginationInfo.setTotalRecordCount(listVO.getTotalRecordCount());
		
		model.addAttribute("resultList", listVO.getEgovList());
		model.addAttribute("paginationInfo", paginationInfo);
		model.addAttribute("totalCount", paginationInfo.getTotalRecordCount());
		model.addAttribute("currentPageNo", paginationInfo.getCurrentPageNo());
		model.addAttribute("totalPageCount", paginationInfo.getTotalPageCount());
		
		return "/usr/std/lecRoom/stdLecTaskList";
	}
	
	// 학생 - 강의실 과제 상세
	@RequestMapping("/usr/std/lecRoom/stdLecTaskView.do")
	public String stdLecTaskView(@ModelAttribute("taskSubVO") TaskSubVO taskSubVO, @ModelAttribute("searchVO") CmmnSearchVO searchVO, HttpSession session, HttpServletRequest request, ModelMap model) throws Exception {
		LOGGER.debug("/usr/std/lecRoom/stdLecTaskView.do - 학생 강의실 공지사항 상세");
		request.getSession().setAttribute("stdMenuNo", "103");
		
		//제출내역 조회 - 개인
		if(!EgovStringUtil.isEmpty(taskSubVO.getTaskSeq())){
			String taskSeq = taskSubVO.getTaskSeq();
			UsrVO usrVO = ((UsrVO)session.getAttribute("usrSession")!=null)?(UsrVO)session.getAttribute("usrSession"):null;
			String memberCode = usrVO.getMemberCode();
			taskSubVO.setMemberCode(memberCode);
			EgovMap map = stdLecTaskDAO.selectStdTaskOne(taskSubVO);
			model.addAttribute("taskSubVO", map);
			
			if(map.get("subSeq") == null){
				String subSeq = stdLecTaskDAO.insertStdTaskLookDate(taskSubVO);
				map.put("subSeq", subSeq);
			}else{
				if(EgovStringUtil.isEmpty(map.get("lookDate").toString())){
					stdLecTaskDAO.updateStdTaskLookDate(map.get("subSeq").toString());
				}
			}
			
			EgovMap attMap = new EgovMap();
			attMap.put("boardSeq", taskSeq);
			attMap.put("boardType", "TASK");
			
			List<AttachVO> attachList = cmmDAO.selectAttachList(attMap);
			model.addAttribute("attachList", attachList);
			
			//제출내역 조회 - 목록
			searchVO.setSearchCondition4(taskSeq);
			PaginationInfo paginationInfo = PaginationController.getPaginationInfo(searchVO);
			CmmnListVO listVO = stdLecTaskDAO.lecStdTaskList(searchVO); 
			paginationInfo.setTotalRecordCount(listVO.getTotalRecordCount());
			
			model.addAttribute("resultList", listVO.getEgovList());
			model.addAttribute("paginationInfo", paginationInfo);
			model.addAttribute("totalCount", paginationInfo.getTotalRecordCount());
			model.addAttribute("currentPageNo", paginationInfo.getCurrentPageNo());
			model.addAttribute("totalPageCount", paginationInfo.getTotalPageCount());
		}
		
		return "/usr/std/lecRoom/stdLecTaskView";
	}
	
	// 학생 - 강의실 과제 등록
	@RequestMapping("/usr/std/lecRoom/stdLecTaskModify.do")
	public String stdLecTaskModify(@ModelAttribute("taskSubVO") TaskSubVO taskSubVO, @ModelAttribute("searchVO") CmmnSearchVO searchVO, String delSeq, RedirectAttributes reda, HttpSession session, MultipartHttpServletRequest request, ModelMap model) throws Exception {
		LOGGER.debug("/usr/std/lecRoom/stdLecTaskModify.do - 학생 강의실 과제 등록");
		request.getSession().setAttribute("stdMenuNo", "103");
		
		UsrVO sessionVO = (UsrVO) request.getSession().getAttribute("usrSession");
		
		if(!EgovStringUtil.isEmpty(taskSubVO.getSubSeq())){
			stdLecTaskDAO.updateTaskSub(taskSubVO);
		}else{
			taskSubVO.setMemberCode(sessionVO.getMemberCode());
			String subSeq = stdLecTaskDAO.insertTaskSub(taskSubVO);
			taskSubVO.setSubSeq(subSeq);
		}
		
		FileInfoVO fileInfoVO = fileUtil.uploadAttachedFile(request, "TASB", taskSubVO.getSubSeq());
		if(fileInfoVO != null){
			AttachVO attachVO = new AttachVO(fileInfoVO);
			attachVO.setBoardType("TASB");
			attachVO.setBoardSeq(taskSubVO.getSubSeq());
			cmmDAO.insertAttachFile(attachVO);
			
			if(!EgovStringUtil.isEmpty(delSeq)){
				attachVO = cmmDAO.selectAttachOne(delSeq);
				fileUtil.deleteFile(attachVO.getRegFileName());
				cmmDAO.deleteAttachFile(attachVO.getAttachSeq());
			}
		}
		
		return redirectView(reda, taskSubVO);
	}
	
	
	
}
