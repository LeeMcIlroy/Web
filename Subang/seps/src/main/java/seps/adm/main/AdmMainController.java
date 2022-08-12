package seps.adm.main;

import javax.annotation.Resource;
import javax.servlet.http.HttpSession;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.View;

@Controller
public class AdmMainController {
	
	private static final Logger LOGGER = LoggerFactory.getLogger(AdmMainController.class);
	
	@Resource View jsonView;
	
	// 관리자 메인 화면
	@RequestMapping("/adm/main.do")
	public String loginView(HttpSession session) throws Exception {
		LOGGER.info("/adm/main.do - 관리자 메인 화면");
		
		return "/adm/main";
	}
	
}
