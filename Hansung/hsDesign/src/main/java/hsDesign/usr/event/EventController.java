package hsDesign.usr.event;

import javax.servlet.http.HttpSession;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import egovframework.let.utl.fcc.service.EgovStringUtil;
import hsDesign.usr.cmm.CmmController;
import hsDesign.valueObject.EventVO;

@Controller
public class EventController extends CmmController{
	
	private static final Logger LOGGER = LoggerFactory.getLogger(EventController.class);
	
	@Autowired private EventDAO eventDAO;
	
	/***************************************** 행사참가 신청 *****************************************/
	// 행사참가 신청 - 화면
	@RequestMapping("/usr/event/eventModify.do")
	public String eventModify(HttpSession session) throws Exception {
		LOGGER.info("/usr/event/eventModify.do - 행사 > 행사참가신청 - 화면");
		// incLeft menu
		session.setAttribute("menuNo", "50901");
		
		return "/usr/event/eventModify";
	}
	
	// 행사참가 신청 - 신청
	@RequestMapping("/usr/event/eventInsert.do")
	public String eventInsert(EventVO eventVO, RedirectAttributes reda) throws Exception {
		LOGGER.info("/usr/event/eventInsert.do - 행사 > 행사참가신청 - 신청");
		LOGGER.debug("eventVO.toString = "+eventVO.toString());
		
		if(
			EgovStringUtil.isEmpty(eventVO.getEveName()) || EgovStringUtil.isEmpty(eventVO.getEveTel1())
			|| EgovStringUtil.isEmpty(eventVO.getEveTel2()) || EgovStringUtil.isEmpty(eventVO.getEveTel3())
		){
			reda.addFlashAttribute("message", "오류발생(-1)");
			return "redirect:/usr/event/eventModify.do";
		}
		
		// 연락처 set
		eventVO.setEveTel(eventVO.getEveTel1()+"-"+eventVO.getEveTel2()+"-"+eventVO.getEveTel3());
		
		// 신청 등록
		int n = eventDAO.insertEvent(eventVO);
		
		if(n > 0){
			reda.addFlashAttribute("message", "이미 참가신청이 완료된 정보입니다.");
		}else{
			reda.addFlashAttribute("message", eventVO.getEveName()+"님 2018크리에이터페스타 참가신청이 완료되었습니다.");
		}
		
		return "redirect:/usr/event/eventModify.do";
	}
	
	/***************************************** 행사 참가비 확인 *****************************************/
	// 행사 참가비 확인
	@RequestMapping("/usr/event/eventExpo.do")
	public String eventExpo(HttpSession session) throws Exception {
		LOGGER.info("/usr/event/eventExpo.do - 행사 > 행사참가비 - 화면");
		// incLeft menu
		session.setAttribute("menuNo", "50902");
		
		return "/usr/event/eventExpo";
	}
	
	// 행사참가 신청 - 신청
	@RequestMapping("/usr/event/eventExpoChk.do")
	public String eventExpoChk(EventVO eventVO, RedirectAttributes reda) throws Exception {
		LOGGER.info("/usr/event/eventExpoChk.do - 행사 > 행사참가비 - 확인");
		LOGGER.debug("experVO.toString = "+eventVO.toString());
		
		if(
				EgovStringUtil.isEmpty(eventVO.getEveNum()) || EgovStringUtil.isEmpty(eventVO.getEveName()) || EgovStringUtil.isEmpty(eventVO.getEveTel1())
			|| EgovStringUtil.isEmpty(eventVO.getEveTel2()) || EgovStringUtil.isEmpty(eventVO.getEveTel3())
		){
			reda.addFlashAttribute("message", "오류발생(-1)");
			return "redirect:/usr/event/eventExpo.do";
		}
		
		// 연락처 set
		eventVO.setEveTel(eventVO.getEveTel1()+"-"+eventVO.getEveTel2()+"-"+eventVO.getEveTel3());
		
		// 입금여부 확인
		String Yn = eventDAO.selectEventExpoChk(eventVO);
		
		if(Yn == null){
			int n = eventDAO.selectEventOneCxlCnt(eventVO);
			if(n > 0){
				reda.addFlashAttribute("message", eventVO.getEveName()+"님 2018크리에이터페스타 참가신청 취소가 확인되었습니다.");
			}else{
				reda.addFlashAttribute("message", "일치하는 정보가 없습니다.\n참석자명과 연락처를 다시 확인해 주세요.");
			}
		}else if(Yn.equalsIgnoreCase("Y")){
			reda.addFlashAttribute("message", eventVO.getEveName()+"님 2018크리에이터페스타 참가비 납부 확인되었습니다.");
		}else{
			reda.addFlashAttribute("message", eventVO.getEveName()+"님 2018크리에이터페스타 참가비 납부가 확인되지 않았습니다.\n\"행사참가비확인은 입금 및 신청후 3일 이내 확인가능합니다\"");
		}
		
		return "redirect:/usr/event/eventExpo.do";
	}
	
	/***************************************** 행사 참가 취소 *****************************************/
	// 행사 참가 취소
	@RequestMapping("/usr/event/eventCancel.do")
	public String eventCancel(HttpSession session) throws Exception {
		LOGGER.info("/usr/event/eventCancel.do - 행사 > 행사참가 취소 - 화면");
		// incLeft menu
		session.setAttribute("menuNo", "50903");
		
		return "/usr/event/eventCancel";
	}
	
	// 행사참가 취소 - 취소
	@RequestMapping("/usr/event/eventCancelChk.do")
	public String eventCancelChk(EventVO eventVO, RedirectAttributes reda) throws Exception {
		LOGGER.info("/usr/event/eventCancelChk.do - 행사 > 행사참가 취소 - 취소");
		LOGGER.debug("experVO.toString = "+eventVO.toString());
		
		if(
			EgovStringUtil.isEmpty(eventVO.getEveNum()) || EgovStringUtil.isEmpty(eventVO.getEveName()) || EgovStringUtil.isEmpty(eventVO.getEveTel1())
			|| EgovStringUtil.isEmpty(eventVO.getEveTel2()) || EgovStringUtil.isEmpty(eventVO.getEveTel3())
		){
			reda.addFlashAttribute("message", "오류발생(-1)");
			return "redirect:/usr/event/eventCancel.do";
		}
		
		// 연락처 set
		eventVO.setEveTel(eventVO.getEveTel1()+"-"+eventVO.getEveTel2()+"-"+eventVO.getEveTel3());
		
		// 신청 취소
		int n = eventDAO.updateEventCancel(eventVO);
		
		if(n == 0){
			reda.addFlashAttribute("message", "일치하는 정보가 없습니다.\n참석자명과 연락처, 환불계좌를 다시 확인해 주세요.");
		}else{
			reda.addFlashAttribute("message", eventVO.getEveName()+"님 2018크리에이터페스타 참가 취소가 완료되었습니다.");
		}
		
		return "redirect:/usr/event/eventCancel.do";
	}
	
	
}