package lcms.usr.std.myPage;

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
import lcms.valueObject.DormVO;
import lcms.valueObject.MemberVO;
import lcms.valueObject.UsrVO;
import lcms.valueObject.cmm.CmmnListVO;
import lcms.valueObject.cmm.CmmnSearchVO;

@Controller
public class StdDormitoryController extends AdmCmmController {
	
	private static final Logger LOGGER = LoggerFactory.getLogger(StdDormitoryController.class);
	
	@Autowired private StdDormitoryDAO stdDormitoryDAO;
	@Resource View jsonView;
	@Resource private CmmnFileMngUtil fileUtil;
	
	//  STD기숙사 리스트화면으로 리다이렉트합니다.
		@SuppressWarnings("unused")
		private String redirectDormList(RedirectAttributes reda, String message) {
			reda.addFlashAttribute("message", message);
			return "redirect:/usr/std/myPage/stdDormitoryList.do";
		}
	
	
	// 학생 - 기숙사 리스트 20200313
	@RequestMapping("/usr/std/myPage/stdDormitoryList.do")
	public String stdDormitoryList(@ModelAttribute("searchVO") CmmnSearchVO searchVO, HttpSession session, HttpServletRequest request, ModelMap model) throws Exception {
		LOGGER.debug("/usr/std/myPage/stdDormitoryList.do - 학생 기숙사 리스트");
		request.getSession().setAttribute("stdMenuNo", "203");
		
		//세션값 >> 자기 자신이 신청했던 기숙사 목록이 나오게 수정할 것
		UsrVO usrVO = ((UsrVO)session.getAttribute("usrSession")!=null)?(UsrVO)session.getAttribute("usrSession"):null;
		searchVO.setSearchMemberCode(usrVO.getMemberCode());
		
		PaginationInfo paginationInfo = PaginationController.getPaginationInfo(searchVO);
			
			CmmnListVO listVO = stdDormitoryDAO.selectStdDormList(searchVO);
			
			paginationInfo.setTotalRecordCount(listVO.getTotalRecordCount());
			
			model.addAttribute("resultList", listVO.getEgovList());
			model.addAttribute("totalPageCount", paginationInfo.getTotalPageCount());
			model.addAttribute("paginationInfo", paginationInfo);
			model.addAttribute("searchVO",searchVO);
			
			List<String> yearList = cmmDAO.selectYearList();
			model.addAttribute("yearList", yearList);
			List<EgovMap> semeList = cmmDAO.selectSemeList(yearList.get(0));
			model.addAttribute("semeList", semeList);
			
		
		return "/usr/std/myPage/stdDormitoryList";
	}
	
	/*// 학생 - 기숙사 신청 화면 20200313
	@RequestMapping("/usr/std/myPage/stdDormitoryView.do")
	public String stdDormitoryView(@ModelAttribute DormVO dormVO ,CmmnSearchVO searchVO,HttpSession session, HttpServletRequest request, ModelMap model,RedirectAttributes reda) throws Exception {
		LOGGER.debug("/usr/std/myPage/stdDormitoryView.do - 학생 기숙사 신청상세");
		
		// 입력한 세션 아이디(학번)  조회
			UsrVO usrVO = (UsrVO) request.getSession().getAttribute("usrSession");
			int viewGubunCnt = stdDormitoryDAO.selectStdDormOneCnt(usrVO.getMemberCode());
			
		//학번으로 기숙사 기존에 지원했었던 내역 조회
			dormVO = stdDormitoryDAO.selectStdDormListOne(usrVO.getMemberCode());
			
			model.addAttribute("result",dormVO);
		
			//첨부파일 데이터 조회
		if(!EgovStringUtil.isEmpty(dormVO.getDormSeq())){
		
			List<AttachVO> attachList = cmmDAO.selectAttachList(dormVO.getDormSeq());
		model.addAttribute("attachList", attachList);
		} 
		return "/usr/std/myPage/stdDormitoryView";
	}

	// 학생 - 기숙사 신청 등록 20200313
	@RequestMapping("/usr/std/myPage/stdDormitoryRegist.do")
	public String stdDormitoryRegist(@ModelAttribute DormVO dormVO ,CmmnSearchVO searchVO,HttpSession session, MultipartHttpServletRequest request, ModelMap model,RedirectAttributes reda) throws Exception {
		LOGGER.debug("/usr/std/myPage/stdDormitoryView.do - 학생 기숙사 신청상세");
		
		request.getSession().setAttribute("stdMenuNo", "203");
		String message = "";
		// 입력한 세션 아이디(학번)  조회
		UsrVO usrVO = (UsrVO) request.getSession().getAttribute("usrSession");
		
		dormVO.setMemCode(usrVO.getMemberCode());
		
		// 기숙사 입사 신청
		stdDormitoryDAO.insertStdDormView(dormVO);
		
	//  ************* insert regist 등록 + 첨부 20200309*************
	
			dormVO = stdDormitoryDAO.selectStdDormListOne(dormVO.getMemCode()); 
			
			List<FileInfoVO> fileInfoList = fileUtil.totUploadFiles(request, "DORM");
			if(fileInfoList != null){
				for(FileInfoVO fileInfoVO : fileInfoList){
					AttachVO attachVO = new AttachVO(fileInfoVO);
					attachVO.setBoardType("DORM");
					attachVO.setBoardSeq(dormVO.getDormSeq());
					cmmDAO.insertAttachFile(attachVO);
				}
			}
			   
			 
			   
		return redirectDormList(reda, message);
	}
	
	//재입사할때 기존 데이터 가져오기
	@SuppressWarnings("unused")
	@RequestMapping("/usr/std/myPage/findStudents.do")
	public View findStudents(DormVO dormVO, HttpServletRequest request,ModelMap model) throws Exception {
		LOGGER.debug("/usr/std/myPage/findStudents.do - 학생 기숙사 학생정보찾기화면");
		
		String message = "";
	
		//학생 세션 조회한다.
		UsrVO usrVO = (UsrVO) request.getSession().getAttribute("usrSession");
		dormVO = stdDormitoryDAO.selectStdDormListOne(usrVO.getMemberCode());

       model.addAttribute("dormVO",dormVO);
	   
		return jsonView;
	}*/
	
	
}
