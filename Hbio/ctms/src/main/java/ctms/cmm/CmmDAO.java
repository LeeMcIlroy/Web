package ctms.cmm;

import java.util.List;

import org.springframework.stereotype.Repository;

import egovframework.rte.psl.dataaccess.EgovAbstractDAO;
import egovframework.rte.psl.dataaccess.util.EgovMap;
import ctms.valueObject.Ct7000mVO;
import ctms.valueObject.Sb1000mVO;
import ctms.valueObject.Ct1050mVO;
import ctms.valueObject.Rm1000mVO;
import ctms.valueObject.Rm1020mVO;
import ctms.valueObject.Rs1000mVO;
import ctms.valueObject.Rs1010mVO;

@Repository
public class CmmDAO extends EgovAbstractDAO {
	
	// 첨부파일 등록
	public void insertAttachFile(Ct7000mVO attachVO) throws Exception {
		insert("CmmDAO.insertAttachFile", attachVO);
	}

	// 첨부파일 조회
	public Ct7000mVO selectAttachOne(String fileId) throws Exception {
		return (Ct7000mVO) select("CmmDAO.selectAttachOne", fileId);
	}
	
	// 첨부파일 리스트 조회
	@SuppressWarnings("unchecked")
	public List<Ct7000mVO> selectAttachList(EgovMap map) throws Exception {
		return (List<Ct7000mVO>) list("CmmDAO.selectAttachList", map);
	}
	// 첨부파일 리스트 조회 boardNo
	@SuppressWarnings("unchecked")
	public int selectAttachListone(String boardNo) throws Exception {
		int totalRecordCount  = (int) select("CmmDAO.selectAttachListone", boardNo);
		return totalRecordCount;
	}
	// 첨부파일 리스트 조회 - file_key 검색조건 추가 
	@SuppressWarnings("unchecked")
	public List<Ct7000mVO> selectAttachListFileKey(EgovMap map) throws Exception {
		return (List<Ct7000mVO>) list("CmmDAO.selectAttachListFileKey", map);
	}
	
	// 첨부파일 조회 - file_key 검색
	public Ct7000mVO selectAttachListFileKeyOne(EgovMap map) throws Exception {
		return (Ct7000mVO) select("CmmDAO.selectAttachListFileKeyOne", map);
	}
		
	// 게시판 첨부파일 개수
	public int selectAttachListCnt(String boardSeq) throws Exception {
		int totalRecordCount  = (int) select("CmmDAO.selectAttachListCnt", boardSeq);
		return totalRecordCount;
	}
	// 첨부파일 삭제
	public void deleteAttachFile(String attachSeq) throws Exception {
		delete("CmmDAO.deleteAttachFile", attachSeq);
	}
		
	// 지사 목록 (<-회사코드) 2020.12.17 개발2
	@SuppressWarnings("unchecked")
	public List<EgovMap> selectBranchList(String corpCd) throws Exception {
		return (List<EgovMap>) list("CmmDAO.selectBranchList", corpCd);
	}
	
	// 지사 목록 (<-회사코드) 2020.12.17 개발2
	@SuppressWarnings("unchecked")
	public List<EgovMap> selectBranchListOne(EgovMap map) throws Exception {
		return (List<EgovMap>) list("CmmDAO.selectBranchListOne", map);
	}
	
	// 공통코드 목록
	@SuppressWarnings("unchecked")	
	public List<EgovMap> selectCmmCdList(String corpCd, String cdCls) throws Exception {
		EgovMap dataMap = new EgovMap();
		dataMap.put("corpCd", corpCd);
		dataMap.put("cdCls", cdCls);
		return (List<EgovMap>) list("CmmDAO.selectCmmCdList", dataMap);
	}
	
	// 사용자(구성원) 목록 (<-회사코드) 2021.01.05 개발2
	@SuppressWarnings("unchecked")
	public List<EgovMap> selectStaffList(String corpCd) throws Exception {
		return (List<EgovMap>) list("CmmDAO.selectStaffList", corpCd);
	}

	// 로그인접속 로그  2021.01.11 개발2
	public void insertLoginLog(EgovMap map) throws Exception {
		insert("CmmDAO.insertLoginLog", map);
	}
	
	// 개인정보처리 로그 등록 2021.1.12 개발2
	public void insertAdmLog(Ct1050mVO ct1050mVO) throws Exception{
		insert("CmmDAO.insertAdmLog", ct1050mVO);
	}
	
	// 연도 목록
	@SuppressWarnings("unchecked")
	public List<String> selectYearList() throws Exception{
		return (List<String>) list("CmmDAO.selectYearList");
	}

	// 연구코드/연구명칭 - 연도
	@SuppressWarnings("unchecked")
	public List<EgovMap> selectCmmYearRsCdList(EgovMap map) throws Exception {
		return (List<EgovMap>) list("CmmDAO.selectCmmYearRsCdList", map);
	}
	
	// 연구계획서/연구명칭 - 연도
	@SuppressWarnings("unchecked")
	public List<EgovMap> selectCmmYearRsCdList2(EgovMap map) throws Exception {
		return (List<EgovMap>) list("CmmDAO.selectCmmYearRsCdList2", map);
	}
	
	// 연구프로토콜 코드/명칭 찾기
	@SuppressWarnings("unchecked")
	public List<EgovMap> selectCmmRsProtocolList(EgovMap map) throws Exception {
		return (List<EgovMap>) list("CmmDAO.selectCmmRsProtocolList", map);
	}
		
	// 연구과제의 연구담당자인지 확인 
	public int selectRsControlCnt(EgovMap map) throws Exception {
		int totalRecordCount  = (int) select("CmmDAO.selectRsControlCnt", map);
		return totalRecordCount;
	}
	
	// 연구과제의 연구담당자인지 확인 - 공통연구코드 적용 
	public int selectRsControlCnt2(EgovMap map) throws Exception {
		int totalRecordCount  = (int) select("CmmDAO.selectRsControlCnt2", map);
		return totalRecordCount;
	}
	
	// 연구과제가 삭제 가능한지 확인 - 피험자가 선정된 경우 삭제 불가 
	public int selectRsDelControlCnt(EgovMap map) throws Exception {
		int totalRecordCount  = (int) select("CmmDAO.selectRsDelControlCnt", map);
		return totalRecordCount;
	}
	
	// 이메일서버 정보
	public String selectMailHost(EgovMap map) {
		String mailhost = (String) select("CmmDAO.selectMailHost", map);
		return mailhost;
	}
	
	//SMS예문 목록
	@SuppressWarnings("unchecked")
	public List<EgovMap> selectSmsSplList(EgovMap map) throws Exception {
		return (List<EgovMap>) list("CmmDAO.selectSmsSplList", map);
	}
	
	//이메일예문 목록
	@SuppressWarnings("unchecked")
	public List<EgovMap> selectMailSplList(EgovMap map) throws Exception {
		return (List<EgovMap>) list("CmmDAO.selectMailSplList", map);
	}

	// SMS 등록 Ajax
	public String insertAjaxSaveSms(EgovMap map) throws Exception {
		return (String)insert("CmmDAO.insertCmmAjaxSaveSms", map);
	}
	
	// 이메일 등록 Ajax
	public String insertAjaxSaveMail(EgovMap map) throws Exception {
		return (String)insert("CmmDAO.insertAjaxSaveMail", map);
	}	
		
	// 이메일발송 피험자 상세정보
	public Sb1000mVO selectRsjDetail2(Sb1000mVO sb1000mVO) {
		return (Sb1000mVO)select("CmmDAO.selectRsjDetail2", sb1000mVO); 
	}
	
	// 이메일발송내역 상세정보
	public Rm1000mVO selectRecmNoDetail(Rm1000mVO rm1000mVO) {
		return (Rm1000mVO)select("CmmDAO.selectRecmNoDetail", rm1000mVO); 
	}
	
	// 이메일재발송 등록
	public String insertResendMail(Rm1020mVO rm1020mVO) throws Exception {		
		 return (String)insert("CmmDAO.insertResendMail", rm1020mVO); 
	}

	//연구과제목록 조회
	@SuppressWarnings("unchecked")
	public List<EgovMap> selectCmmRsList(EgovMap map) throws Exception {
		return (List<EgovMap>) list("CmmDAO.selectCmmRsList", map);
	}
	
	// 연구과제 상세정보(RS1000M)
	public Rs1000mVO selectRsInfo(EgovMap map) {
		return (Rs1000mVO)select("CmmDAO.selectRsInfo", map); 
	}
	
	// 연구과제 상세정보(RS1010M)
	public Rs1010mVO selectRsInfoMst(EgovMap map) {
		return (Rs1010mVO)select("CmmDAO.selectRsInfoMst", map); 
	}

	//피험자 병합된 파일 조회
	@SuppressWarnings("unchecked")
	public  List<Ct7000mVO> selectMergeFile(EgovMap map) {
		return (List<Ct7000mVO>) list("CmmDAO.selectFileMerge", map);
	}
	
	//피험자 병합된 파일 조회
	@SuppressWarnings("unchecked")
	public  List<Ct7000mVO> selectMergeFileAllRsi(EgovMap map) {
		return (List<Ct7000mVO>) list("CmmDAO.selectFileMergeAllRsi", map);
	}
	
	//식별번호 리스트 
	@SuppressWarnings("unchecked")
	public  List<Ct7000mVO> selectMergeFileAllRsiList(EgovMap map) {
		return (List<Ct7000mVO>) list("CmmDAO.selectFileMergeAllRsiList", map);
	}
	
	//연구번호 피험자 병합된 파일 조회
	@SuppressWarnings("unchecked")
	public  List<Ct7000mVO> selectMergeFileRsNo(EgovMap map) {
		return (List<Ct7000mVO>) list("CmmDAO.selectFileMergeRsNo", map);
	}
	
	//연구번호 피험자 병합된 파일 조회 -> 연구종료확인서가 포함된 CRF파일 
	@SuppressWarnings("unchecked")
	public  List<Ct7000mVO> selectMergeFileRsNo2(EgovMap map) {
		return (List<Ct7000mVO>) list("CmmDAO.selectFileMergeRsNo2", map);
	}
	
	// templete type 확인 1030 연구종료서인 경우 'Y'값 return 
	public String selectTempType(EgovMap map) throws Exception {		
		 String chkTempType = (String) select("CmmDAO.selectTempType", map);
		 return chkTempType;
	}
}



