package hsDesign.adm.cmm;

import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;

import egovframework.com.cmm.util.EgovUserDetailsHelper;
import egovframework.let.utl.fcc.service.EgovStringUtil;
import hsDesign.valueObject.LogVO;

public class AdmCmmController {
	@Autowired protected AdmCmmDAO admCmmDAO;
	
	// 로그 등록
	protected void admLogInsert(String logId, String logJob, String jobSeq, HttpServletRequest request){
		String ip = (!EgovStringUtil.isEmpty(request.getHeader("X-FORWARDED-FOR")))? request.getHeader("X-FORWARDED-FOR") : request.getRemoteAddr();
		String id = EgovStringUtil.isEmpty(logId)? EgovUserDetailsHelper.getAuthenticatedAdminId() : logId;
		jobSeq = EgovStringUtil.isEmpty(jobSeq)? id : jobSeq;
		LogVO logVO = new LogVO(id, ip, logJob+"("+jobSeq+")");
		admCmmDAO.admLogInsert(logVO);
	}
}
