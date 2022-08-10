package hsDesign.usr.majorBoard;

import java.util.List;

import org.springframework.stereotype.Repository;

import egovframework.rte.psl.dataaccess.EgovAbstractDAO;
import egovframework.rte.psl.dataaccess.util.EgovMap;
import hsDesign.valueObject.MajorBoardVO;
import hsDesign.valueObject.cmm.CmmnListVO;
import hsDesign.valueObject.cmm.CmmnSearchVO;

@Repository
public class MajorBoardDAO extends EgovAbstractDAO {

	// 목록
	@SuppressWarnings("unchecked")
	public CmmnListVO selectMajorBoardList(CmmnSearchVO searchVO){
		int totalRecordCount = (int) select("MajorBoardDAO.selectMajorBoardListCnt", searchVO);
		List<EgovMap> egovList = (List<EgovMap>) list("MajorBoardDAO.selectMajorBoardList", searchVO);
		
		return new CmmnListVO(totalRecordCount, egovList);
	}
	
	// 조회
	public MajorBoardVO selectMajorBoardOne(String mbSeq) {
		updateReadCntOne(mbSeq);
		return (MajorBoardVO) select("MajorBoardDAO.selectMajorBoardOne", mbSeq);
	}
	
	// 이전글 조회
	public MajorBoardVO selectMajorBoardPreOne(MajorBoardVO majorBoardVO) {
		return (MajorBoardVO) select("MajorBoardDAO.selectMajorBoardPreOne", majorBoardVO);
	}
	// 썸네일 조회
	public EgovMap selectMajorBoardThumbList(String mbSeq) {
		return (EgovMap) select("MajorBoardDAO.selectMajorBoardThumbList", mbSeq);
	}
	
	// 전공목록
	@SuppressWarnings("unchecked")
	public List<EgovMap> selectMajorList(){
		return (List<EgovMap>) list("MajorBoardDAO.selectMajorList");
	}
	
	// 게시판 구분
	@SuppressWarnings("unchecked")
	public List<EgovMap> selectBoardCodeList(String mCode){
		return (List<EgovMap>) list("MajorBoardDAO.selectBoardCodeList", mCode);
	}
	
	// 썸네일 조회
	public EgovMap selectMajorBoardThumbOne(String mbthSeq) {
		return (EgovMap) select("MajorBoardDAO.selectMajorBoardThumbOne", mbthSeq);
	}

	// 첨부파일 조회
	public EgovMap selectMajorBoardAttachFileOne(String mbthSeq) {
		return (EgovMap) select("MajorBoardDAO.selectMajorBoardAttachFileOne", mbthSeq);
	}

	// 말머리 목록
	@SuppressWarnings("unchecked")
	public List<EgovMap> selectMajorHeadList(String mmSeq){
		return (List<EgovMap>) list("MajorBoardDAO.selectMajorHeadList", mmSeq);
	}
	
	// 조회수 증가
	public void updateReadCntOne(String mbSeq) {
		update("MajorBoardDAO.updateReadCntOne", mbSeq);
	}
	
	// 메뉴이름
	public String selectMenuNameOne(String mmSeq) {
		return (String) select("MajorBoardDAO.selectMenuNameOne", mmSeq);
	}
	
	//****************************************교강사*****************************************************
	@SuppressWarnings("unchecked")
	public CmmnListVO selectTeacherList(CmmnSearchVO searchVO){
		int totalRecordCount = (int) select("MajorBoardDAO.selectTeacherListCnt", searchVO);
		List<EgovMap> egovList = (List<EgovMap>) list("MajorBoardDAO.selectTeacherList", searchVO);
		
		return new CmmnListVO(totalRecordCount, egovList);
	}

	public List<EgovMap> selectMajorMainList() {
		return  (List<EgovMap>) list("MajorBoardDAO.selectMajorMainList");
	}
	
}
