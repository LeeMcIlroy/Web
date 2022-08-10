package writer.usr.cnslt;

import java.util.List;

import javax.annotation.Resource;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.View;

import writer.adm.cmm.AdmCmmLogDAO;
import writer.adm.cnslt.schdul.AdmCnsltSchdulDAO;
import writer.valueObject.CnsltScheduleVO;
import writer.valueObject.cmmn.CmmnSearchVO;

@Controller
public class CnsltController2 {
	
	private static final Logger LOGGER = LoggerFactory.getLogger(CnsltController2.class);
	
	@Autowired private CnsltDAO2 cnsltDAO2;
	
	@Resource View jsonView;
	@RequestMapping("/usr/cnsltScheduleListAjax.do")
	public View admCnsltScheduleListAjax(@ModelAttribute("searchVO") CmmnSearchVO searchVO, ModelMap model) throws Exception {
		LOGGER.info("/usr/cnsltScheduleListAjax.do");
		LOGGER.debug("searchVO = "+searchVO.toString());
		
		List<CnsltScheduleVO> resultList = cnsltDAO2.selectCnsltScheduleList(searchVO);
		model.addAttribute("resultList", resultList);
		return jsonView;
	}
	
}
