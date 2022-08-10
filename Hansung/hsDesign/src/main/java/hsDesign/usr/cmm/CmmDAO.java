package hsDesign.usr.cmm;

import java.util.List;

import org.springframework.stereotype.Repository;

import egovframework.rte.psl.dataaccess.EgovAbstractDAO;
import egovframework.rte.psl.dataaccess.util.EgovMap;

@Repository
public class CmmDAO extends EgovAbstractDAO {
	
	public EgovMap selectLeftBannerList(){
		return (EgovMap) select("CmmDAO.selectLeftBannerList");
	}

	@SuppressWarnings("unchecked")
	public List<EgovMap> selectBoardCodeList(){
		return (List<EgovMap>) list("MajorBoardDAO.selectBoardCodeList");
	}
	
	// pdf 목록
	public List<EgovMap> selectPdfList(String pdfType){
		return (List<EgovMap>) list("CmmDAO.selectPdfList", pdfType);
	}
	
	// pdf 조회
	public EgovMap selectPdfOne(String pdfSeq){
		return (EgovMap) select("CmmDAO.selectPdfOne", pdfSeq);
	}
}
