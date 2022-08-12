package ctms.adm.cmm;

import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;

import component.util.ComStringUtil;
import egovframework.com.cmm.util.EgovUserDetailsHelper;
import ctms.cmm.CmmDAO;

import ctms.valueObject.LogVO;
import ctms.valueObject.Ct1050mVO;

public class AdmCmmController {
	@Autowired protected CmmDAO cmmDAO;
	
	// 로그 등록
	protected void admLogInsert(String logCont, String memberCode, String mbName, HttpServletRequest request) throws Exception{
		//String acceIp = ComStringUtil.getClientIP(request);
		//String regId = EgovUserDetailsHelper.getAuthenticatedAdminId();
		//LogVO logVO = new LogVO(regId, memberCode, logCont, acceIp);
		//cmmDAO.insertAdmLog(logVO);
		
		String acceIp = ComStringUtil.getClientIP(request);
		String dataRegnt = EgovUserDetailsHelper.getAuthenticatedAdminId();
		String corpCd = EgovUserDetailsHelper.getAuthenticatedAdminCorpCd();
		String branchCd = EgovUserDetailsHelper.getAuthenticatedAdminBranchCd();
		
		Ct1050mVO ct1050mVO = new Ct1050mVO(dataRegnt, memberCode, mbName, logCont, acceIp, corpCd, branchCd);
		// 작업분류 설정
		if(mbName.equals("1010")) {
			ct1050mVO.setLogCls("1010");
		}else {
			ct1050mVO.setLogCls("1000");
		}
		cmmDAO.insertAdmLog(ct1050mVO);
	}
}
