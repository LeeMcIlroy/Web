package lcms.usr.lec.clss;

import java.util.ArrayList;
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
import egovframework.let.utl.fcc.service.EgovStringUtil;
import egovframework.rte.psl.dataaccess.util.EgovMap;
import lcms.adm.cmm.AdmCmmController;
import lcms.cmm.CmmDAO;
import lcms.valueObject.AttachVO;
import lcms.valueObject.LectureTimeTableVO;
import lcms.valueObject.LectureVO;
import lcms.valueObject.SyllaWeekVO;
import lcms.valueObject.SyllabusVO;
import lcms.valueObject.TaskVO;
import lcms.valueObject.UsrVO;
import lcms.valueObject.cmm.CmmnListVO;
import lcms.valueObject.cmm.CmmnSearchVO;

@Controller
public class LecSyllabusController extends AdmCmmController {
	
	private static final Logger LOGGER = LoggerFactory.getLogger(LecSyllabusController.class);
	
	@Autowired private LecSyllabusDAO lecSyllabusDAO;
	@Resource private CmmnFileMngUtil fileUtil;
	@Autowired private CmmDAO cmmDAO;
	@Resource View jsonView;
	
	// 강사 - 수업 - 강의계획서 조회 화면
	@RequestMapping("/usr/lec/clss/lecSyllabusView.do")
	public String lecSyllabusView(@ModelAttribute("searchVO")CmmnSearchVO searchVO, LectureVO lectureVO, String clssSeq, String syllaSeq, HttpSession session, HttpServletRequest request, ModelMap model) throws Exception{
		LOGGER.debug("/usr/lec/clss/lecSyllabusView.do - 강사 - 수업 - 강의계획서 조회 화면");
		request.getSession().setAttribute("lecMenuNo", "101");
		
		//세션에서 강의 SEQ 정보 가져오기
		EgovMap lectSession = (EgovMap)session.getAttribute("lecSession");
		
		// 강의계획서 조회
		SyllabusVO syllabusVO = lecSyllabusDAO.selectLecSyll(String.valueOf((int)lectSession.get("lectSeq")));

		if(syllabusVO != null){
			//강의계획서 업로드 파일 조회
			List<EgovMap> syllaFiles = lecSyllabusDAO.selectLecSyllaFiles(syllabusVO.getSyllaSeq());
			EgovMap map = new EgovMap();
			map.put("boardSeq", syllabusVO.getSyllaSeq());
			map.put("boardType", "SYLL");
			List<AttachVO> attachList = cmmDAO.selectAttachList(map);
			//강의계획서 주차별계획 조회
			
			List<LectureTimeTableVO> resultList = lecSyllabusDAO.selectLectTimetables(syllabusVO.getClssSeq());
			List<EgovMap> timeTableList = replaceTimeTable(resultList);
			
			model.addAttribute("timeTableList", timeTableList);
			//List<EgovMap> lecSyllaWeek = lecSyllabusDAO.selectLecSyllaWeek(syllabusVO.getSyllaSeq());
			model.addAttribute("fileList", syllaFiles);
			model.addAttribute("attachList", attachList); 
			
			//model.addAttribute("weekList", lecSyllaWeek);
		}
		
		
		
		model.addAttribute("result", syllabusVO); 
		model.addAttribute("lectSession", lectSession);
		

		return "/usr/lec/clss/lecSyllabusView";
	}

	// 강사 - 수업 - 강의계획서 작성 및 수정 화면
	@RequestMapping("/usr/lec/clss/lecSyllabusModify.do")
	public String lecSyllabusModify(@ModelAttribute("searchVO") CmmnSearchVO searchVO, String syllaSeq, HttpSession session, HttpServletRequest request, ModelMap model) throws Exception {
		LOGGER.debug("/usr/lec/clss/lecSyllabusModify.do - 강사 -수업-강의계획서 작성 및 수정 화면");
		request.getSession().setAttribute("lecMenuNo", "101");
		SyllabusVO syllabusVO = new SyllabusVO();
		
		EgovMap lectSession = (EgovMap)session.getAttribute("lecSession");
		
		SyllabusVO resultVO = lecSyllabusDAO.selectLecSyll(String.valueOf((int)lectSession.get("lectSeq")));

		if (resultVO != null){
			syllabusVO = resultVO;
		//	List<EgovMap> syllabusList = lecSyllabusDAO.selectLecSyllaWeek(resultVO.getSyllaSeq());
			List<EgovMap> mapList = lecSyllabusDAO.selectLecSyllaFiles(resultVO.getSyllaSeq());
			EgovMap map = new EgovMap();
			map.put("boardSeq", syllabusVO.getSyllaSeq());
			map.put("boardType", "SYLL");
			List<AttachVO> attachList = cmmDAO.selectAttachList(map);
			
			List<LectureTimeTableVO> resultList = lecSyllabusDAO.selectLectTimetables(syllabusVO.getClssSeq());
			List<EgovMap> timeTableList = replaceTimeTable(resultList);
			//model.addAttribute("weekList", syllabusList);
			model.addAttribute("timeTableList", timeTableList);
			model.addAttribute("fileList",mapList);
			model.addAttribute("attachList", attachList);
		 }
			
		 model.addAttribute("syllabusVO", syllabusVO);
		 model.addAttribute("lectSession", lectSession);
		
		/*if(syllabusVO.getSyllaSeq() != null){
			String clssSeq = syllabusVO.getClssSeq();
			EgovMap map = lecSyllabusDAO.selectLecSyll(clssSeq);
			model.addAttribute("lecSyllabusDAO", map);
		}*/
		return "/usr/lec/clss/lecSyllabusModify";
	}
	
	
	// 강사 - 수업 - 강의계획서 등록 수정
	@RequestMapping("/usr/lec/clss/lecAddSyll.do")
	public String lecAddSyll( @ModelAttribute("syllabusVO")SyllabusVO syllabusVO, String[] delSeqList, HttpSession session,MultipartHttpServletRequest request, ModelMap model, RedirectAttributes reda) throws Exception {
		LOGGER.debug("/usr/lec/clss/lecAddSyll.do - 강사 - 수업 - 강의계획서 등록 수정");
		request.getSession().setAttribute("lecMenuNo", "201");
		
		UsrVO sessionVO = (UsrVO) request.getSession().getAttribute("usrSession");
		String message = "";
		if(!EgovStringUtil.isEmpty(syllabusVO.getSyllaSeq())){
			lecSyllabusDAO.updatelecSyll(syllabusVO);
			/*for(SyllabusVO paramVO : syllabusVO.getSyllabusList()){
				paramVO.setUpdId(sessionVO.getMemberCode());
				if(!EgovStringUtil.isEmpty(paramVO.getSyllaweekSeq())){
				//	lecSyllabusDAO.updatelecWeek(paramVO);
				}else{
					paramVO.setSyllaSeq(syllabusVO.getSyllaSeq());
					// 1만 insert
					//lecSyllabusDAO.insertlecWeekOne(paramVO);
				}
			}*/
			
			if(delSeqList != null){
				for(String delSeq : delSeqList){
					AttachVO delAttach = cmmDAO.selectAttachOne(delSeq);
					fileUtil.deleteFile(delAttach.getRegFileName());
					cmmDAO.deleteAttachFile(delAttach.getAttachSeq());
				}
			}

			List<FileInfoVO> fileInfoList = fileUtil.uploadAttachedFiles(request, "SYLL");
			 if(fileInfoList != null){
				 for(FileInfoVO fileInfoVO : fileInfoList){
						AttachVO attachVO = new AttachVO(fileInfoVO);
						attachVO.setBoardType("SYLL");
						attachVO.setBoardSeq(syllabusVO.getSyllaSeq());
						cmmDAO.insertAttachFile(attachVO);
					}
			
			 }
			
			message = "수정이 완료 되었습니다.";
		}
		else{
			syllabusVO.setRegId(sessionVO.getMemberCode());
			lecSyllabusDAO.insertlecSyll(syllabusVO);
			/*String syllaSeq = lecSyllabusDAO.insertlecSyll(syllabusVO);
			for(SyllabusVO paramVO : syllabusVO.getSyllabusList()){
				paramVO.setSyllaSeq(syllaSeq);
			//	lecSyllabusDAO.insertlecWeek(paramVO);
			}*/
			List<FileInfoVO> fileInfoList = fileUtil.uploadAttachedFiles(request, "SYLL");
			 if(fileInfoList != null){
				 for(FileInfoVO fileInfoVO : fileInfoList){
					AttachVO attachVO = new AttachVO(fileInfoVO);
					attachVO.setBoardType("SYLL");
					attachVO.setBoardSeq(syllabusVO.getSyllaSeq());
					cmmDAO.insertAttachFile(attachVO);
				}
			 }

			message = "등록이 완료되었습니다.";
		}
		
		/*if (syllabusVO.getSyllaSeq().equals("")) {
			lecSyllabusDAO.insertlecSyll(syllabusVO);
		}
		else {
			lecSyllabusDAO.updatelecSyll(syllabusVO);
		}*/

		return redirectList(reda, message);
	}
	
	private String redirectList(RedirectAttributes reda, String message) {
		reda.addFlashAttribute("message", message);
		return "redirect:/usr/lec/clss/lecSyllabusView.do";
	}
	
	private List<EgovMap> replaceTimeTable(List<LectureTimeTableVO> paramList){
		
		List<EgovMap> resultList = new ArrayList<EgovMap>();
		
		for(int i=1; i<=6; i++){
			EgovMap time = new EgovMap();
			for(LectureTimeTableVO lttVO : paramList){
				if(Integer.parseInt(lttVO.getLectSclass()) <= i && Integer.parseInt(lttVO.getLectEclass()) >= i){
					time.put(lttVO.getLectWeek(), lttVO.getLectGrammar());
				}
			}
			resultList.add(time);
		}
		
		return resultList;
	}
	
}
