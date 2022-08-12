package ctms.ubi;

import org.springframework.stereotype.Repository;

import ctms.valueObject.Cr4000mVO;
import egovframework.rte.psl.dataaccess.EgovAbstractDAO;
import egovframework.rte.psl.dataaccess.util.EgovMap;

@Repository
public class UbiReportDAO extends EgovAbstractDAO {

	public int selectAgreementCnt(Cr4000mVO cr4000mVO) throws Exception {
		return (int) select("UbiReportDAO.selectAgreementCnt", cr4000mVO);
	}

	public void insertAgreement(Cr4000mVO cr4000mVO) throws Exception {
		insert("UbiReportDAO.insertAgreement", cr4000mVO);
	}

	public void updateAgreement(Cr4000mVO cr4000mVO) throws Exception {
		update("UbiReportDAO.updateAgreement", cr4000mVO);
	}

	public void insertSurveyAnsw(EgovMap answMap) throws Exception {
		insert("UbiReportDAO.insertSurveyAnsw", answMap);
	}
	
	public void updateSurveyAnsw(EgovMap answMap) throws Exception {
		update("UbiReportDAO.updateSurveyAnsw", answMap);
	}
	
	public void updateMkHist(EgovMap answMap) throws Exception {
		update("UbiReportDAO.updateMkHist", answMap);
	}
	
	public int selectMkFinCnt(EgovMap answMap) throws Exception {
		return (int) select("UbiReportDAO.selectMkFinCnt", answMap);
	}
	
	public int selectRsiCnt(EgovMap answMap) throws Exception {
		return (int) select("UbiReportDAO.selectRsiCnt", answMap);
	}
	
	public void updateAllMkFin(EgovMap answMap) throws Exception {
		update("UbiReportDAO.updateAllMkFin", answMap);
	}
	
	public int selectMkFirstCnt(EgovMap answMap) throws Exception {
		return (int) select("UbiReportDAO.selectMkFirstCnt", answMap);
	}
	
	public EgovMap selectMkCnt(EgovMap answMap) throws Exception {
		return (EgovMap) select("UbiReportDAO.selectMkCnt", answMap);
	}
	
	public void updateRsstCls(EgovMap answMap) throws Exception {
		update("UbiReportDAO.updateRsstCls", answMap);
	}
}



