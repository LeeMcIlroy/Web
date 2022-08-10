package hsDesign.adm.majorBoard;

import hsDesign.valueObject.CmmBoardVO;
import java.util.List;

import org.springframework.stereotype.Repository;

import egovframework.rte.psl.dataaccess.EgovAbstractDAO;
import egovframework.rte.psl.dataaccess.util.EgovMap;
import hsDesign.valueObject.MajorBoardVO;
import hsDesign.valueObject.cmm.CmmnListVO;
import hsDesign.valueObject.cmm.CmmnSearchVO;

@Repository
public class AdmMajorBoardDAO extends EgovAbstractDAO {

	// 목록
	@SuppressWarnings("unchecked")
	public CmmnListVO selectMajorBoardList(CmmnSearchVO searchVO){
		int totalRecordCount = (int) select("AdmMajorBoardDAO.selectMajorBoardListCnt", searchVO);
		List<EgovMap> egovList = (List<EgovMap>) list("AdmMajorBoardDAO.selectMajorBoardList", searchVO);
		
		return new CmmnListVO(totalRecordCount, egovList);
	}
	
	// 조회
	public MajorBoardVO selectMajorBoardOne(String mbSeq) {
		return (MajorBoardVO) select("AdmMajorBoardDAO.selectMajorBoardOne", mbSeq);
	}
	public MajorBoardVO selectMajorBoardFileOne(String mbthSeq) {
		return (MajorBoardVO) select("AdmMajorBoardDAO.selectMajorBoardFileOne", mbthSeq);
	}
	
	// 썸네일 조회
	public EgovMap selectMajorBoardThumbList(String mbSeq) {
		return (EgovMap) select("AdmMajorBoardDAO.selectMajorBoardThumbList", mbSeq);
	}
	// 첨부파일 조회
	public EgovMap selectMajorBoardFileList(String mbSeq) {
			return (EgovMap) select("AdmMajorBoardDAO.selectMajorBoardFileList", mbSeq);
	}
	// 전공목록
	@SuppressWarnings("unchecked")
	public List<EgovMap> selectMajorList(){
		return (List<EgovMap>) list("AdmMajorBoardDAO.selectMajorList");
	}
	
	// 게시판 구분
	@SuppressWarnings("unchecked")
	public List<EgovMap> selectBoardCodeList(String mCode){
		return (List<EgovMap>) list("AdmMajorBoardDAO.selectBoardCodeList", mCode);
	}
	
	// 등록
	public String insertMajorBoardOne(MajorBoardVO majorBoardVO) {
		return (String) insert("AdmMajorBoardDAO.insertMajorBoardOne", majorBoardVO);
	}
	
	// 썸네일 등록
	public void insertMajorBoardThumbOne(MajorBoardVO majorBoardVO) {
		insert("AdmMajorBoardDAO.insertMajorBoardThumbOne", majorBoardVO);
	}
	
	// 썸네일 조회
	public EgovMap selectMajorBoardThumbOne(String mbthSeq) {
		return (EgovMap) select("AdmMajorBoardDAO.selectMajorBoardThumbOne", mbthSeq);
	}
	
	// 썸네일 수정
	public void updateMajorBoardThumbOne(MajorBoardVO majorBoardVO ) {
		update("AdmMajorBoardDAO.updateMajorBoardThumbOne", majorBoardVO);
	}
	
	// 썸네일 삭제
	public void deleteMajorBoardThumbOne(String mbthSeq) {
		delete("AdmMajorBoardDAO.deleteMajorBoardThumbOne", mbthSeq);
	}
	// 첨부파일 삭제
	public void deleteMajorBoardFileOne(String mbthSeq) {
		delete("AdmMajorBoardDAO.deleteMajorBoardFileOne", mbthSeq);
	}
	// 게시글 삭제
	public void deleteMajorBoardOne(String mbSeq) {
		delete("AdmMajorBoardDAO.deleteMajorBoardOne", mbSeq);
	}
	
	// 게시글 수정
	public void updateMajorBoardOne(MajorBoardVO majorBoardVO) {
		update("AdmMajorBoardDAO.updateMajorBoardOne", majorBoardVO);
	}
	
	// 말머리 목록
	@SuppressWarnings("unchecked")
	public List<EgovMap> selectMajorHeadList(String mmSeq){
		return (List<EgovMap>) list("AdmMajorBoardDAO.selectMajorHeadList", mmSeq);
	}
	
	

	public List<EgovMap> selectTest() {
		return (List<EgovMap>) list("AdmMajorBoardDAO.selectTest");
	}
	
	public List<EgovMap> selectTest2(String id) {
		return (List<EgovMap>) list("AdmMajorBoardDAO.selectTest2", id);
	}
	public EgovMap selectTest3(String id) {
		return (EgovMap) select("AdmMajorBoardDAO.selectTest3", id);
	}
	public EgovMap selectTest5(String id) {
		return (EgovMap) select("AdmMajorBoardDAO.selectTest5", id);
	}
	public EgovMap selectTest4(String id) {
		return (EgovMap) select("AdmMajorBoardDAO.selectTest4", id);
	}
	
	public List<EgovMap> selectTest6(){
		return (List<EgovMap>) list("AdmMajorBoardDAO.selectTest6");
	}
	public List<EgovMap> selectTest7(){
		return (List<EgovMap>) list("AdmMajorBoardDAO.selectTest7");
	}
	public String insertMajorBoardOne2(MajorBoardVO majorBoardVO) {
		return (String) insert("AdmMajorBoardDAO.insertMajorBoardOne2", majorBoardVO);
	}
	
	public void updateImageSize(MajorBoardVO majorBoardVO){
		update("AdmMajorBoardDAO.updateImageSize", majorBoardVO);
	}
	public void updateImageSize2(CmmBoardVO paramVO){
		update("AdmMajorBoardDAO.updateImageSize2", paramVO);
	}
}
