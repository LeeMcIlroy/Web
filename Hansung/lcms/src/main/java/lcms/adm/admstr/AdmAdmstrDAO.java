package lcms.adm.admstr;

import java.util.List;

import org.springframework.stereotype.Repository;

import egovframework.rte.psl.dataaccess.EgovAbstractDAO;
import egovframework.rte.psl.dataaccess.util.EgovMap;
import lcms.valueObject.CertiVO;
import lcms.valueObject.DormVO;
import lcms.valueObject.MemberVO;
import lcms.valueObject.NoticeVO;
import lcms.valueObject.PrfSub1VO;
import lcms.valueObject.PrfSub2VO;
import lcms.valueObject.PrfSub3VO;
import lcms.valueObject.PrfSub4VO;
import lcms.valueObject.ScholarVO;
import lcms.valueObject.SemesterVO;
import lcms.valueObject.cmm.CmmnListVO;
import lcms.valueObject.cmm.CmmnSearchVO;

@Repository
public class AdmAdmstrDAO extends EgovAbstractDAO {

	/* 공지사항****************************************************************************************************************************************************** */
	@SuppressWarnings("unchecked")
	public CmmnListVO NoticeList(CmmnSearchVO searchVO) {
		int totalRecordCount = (Integer) select("AdmAdmstrDAO.NoticeListCnt", searchVO);
		List<EgovMap> resultList = (List<EgovMap>) list("AdmAdmstrDAO.NoticeList", searchVO);		
		return new CmmnListVO(totalRecordCount, resultList);
	}

	public NoticeVO selectNoticeOne(String notiVal) {
		return (NoticeVO)select("AdmAdmstrDAO.selectNoticeOne", notiVal); 
	}
	
	// 20200320 업무관리자 공지사항 조회수
	public void updateNoticeHits(String noti_seq) {
		update("AdmAdmstrDAO.updateNoticeHits", noti_seq);
		}
	
	// 20200320 업무관리자 상단공지 개수
	public int selectNotiTopCnt() {
		int selectNotiTopCnt = (int) select("AdmAdmstrDAO.selectNotiTopCnt");
		return  selectNotiTopCnt;
	}
	// 20200325 공지삭제
	public void deleteNotice(NoticeVO noticeVO) {
		delete("AdmAdmstrDAO.deleteNotice", noticeVO);
		
	}
	// 공지 등록
	public String insertNotice(NoticeVO noticeVO) throws Exception {
		 return (String)insert("AdmAdmstrDAO.insertNotice", noticeVO); 
	}
	
	// 공지 수정 
	public void updateNotice(NoticeVO noticeVO) throws Exception {
		update("AdmAdmstrDAO.updateNotice", noticeVO); 
	}	


	/*/ 공지사항****************************************************************************************************************************************************** */

	// 관리자 교사 리스트
	@SuppressWarnings("unchecked")
	public CmmnListVO selectAdmProfList(CmmnSearchVO searchVO) throws Exception {
		int totalRecordCount = (int) select("AdmAdmstrDAO.selectAdmProfListCnt", searchVO);
		List<EgovMap> egovList = (List<EgovMap>) list("AdmAdmstrDAO.selectAdmProfList", searchVO);
		return new CmmnListVO(totalRecordCount, egovList);
	}

	//학기별 교수명단 찾기
	@SuppressWarnings("unchecked")
	public List<EgovMap> admAjaxProfSearch(EgovMap map) throws Exception{
		return (List<EgovMap>) list("AdmAdmstrDAO.admAjaxProfSearch", map);
	}
	// 관리자 교사 조회
	public MemberVO selectAdmMember(String memberSeq) throws Exception {
		return (MemberVO) select("AdmAdmstrDAO.selectAdmMember", memberSeq);
	}

	// 관리자 교사 등록
	public void insertProfessor(MemberVO memberVO) throws Exception {
		insert("AdmAdmstrDAO.insertProfessor", memberVO);
	}

	// 관리자 교사 수정
	public void updateProfessor(MemberVO memberVO) throws Exception {
		update("AdmAdmstrDAO.updateProfessor", memberVO);
	}

	// 관리자 교사코드 중복확인
	public int selectAdmAjaxProfCheck(String memberCode) throws Exception {
		return (int) select("AdmAdmstrDAO.selectAdmAjaxProfCheck", memberCode);
	}

	// 관리자 교사 비밀번호 초기화
	public void updateAdmAjaxProfClearPw(MemberVO memberVO) throws Exception {
		update("AdmAdmstrDAO.updateAdmAjaxProfClearPw", memberVO);
	}
	
    // **************************** 20200306 기숙사 ****************************
	// 기숙사 리스트
	@SuppressWarnings("unchecked")
	public CmmnListVO selectAdmDormList(CmmnSearchVO searchVO) throws Exception {
		int totalRecordCount = (int) select("AdmAdmstrDAO.selectAdmDormListCnt", searchVO);
		List<EgovMap> egovList = (List<EgovMap>) list("AdmAdmstrDAO.selectAdmDormList", searchVO);
		return new CmmnListVO(totalRecordCount, egovList);
	}
	
	// 기숙사 학생 찾기
	public MemberVO selectStudents(MemberVO memberVO) {
		return (MemberVO) select("AdmAdmstrDAO.selectStudents", memberVO.getName());
	}

	// 기숙사 학생 찾기
	@SuppressWarnings("unchecked")
	public List<MemberVO> selectStudentList(MemberVO memberVO) {
		return (List<MemberVO>) list("AdmAdmstrDAO.selectStudentList", memberVO.getName());
	}
	
	//현재 거주 기숙사 찾기
	public EgovMap selectNowResiDorm(String memberCode) {
		return (EgovMap) select("AdmAdmstrDAO.selectNowResiDorm", memberCode);
	}

    //기숙사 신청 등록
	public String insertAdmDormRegist(DormVO dormVO) {
		return (String)insert("AdmAdmstrDAO.insertAdmDormRegist", dormVO);
	}
				
	// 기숙사 접수번호 
    public String selectDormRecepNum(DormVO dormVO) {
		return (String) select("AdmAdmstrDAO.selectDormRecepNum", dormVO);
	}
    
	// 기숙사 리스트 한개 조회 (상세화면)
	public DormVO selectAdmDormListOne(String dormSeq) {
		return  (DormVO) select("AdmAdmstrDAO.selectAdmDormListOne",dormSeq);
	}

	public void updateAdmDormRegist(DormVO dormVO) {
		update("AdmAdmstrDAO.updateAdmDormRegist", dormVO);
		
	}

	// 업무담당자 증명서 목록 조회
	@SuppressWarnings("unchecked")
	public CmmnListVO selectAdmCertiList(CmmnSearchVO searchVO) throws Exception {
		int totalRecordCount = (int) select("AdmAdmstrDAO.selectAdmCertiListCnt", searchVO);
		List<EgovMap> egovList = (List<EgovMap>) list("AdmAdmstrDAO.selectAdmCertiList", searchVO);
		return new CmmnListVO(totalRecordCount, egovList);
	}

	// 업무담당자 증명서 조회
	public CertiVO selectAdmCertiView(String certiSeq) throws Exception {
		return (CertiVO) select("AdmAdmstrDAO.selectAdmCertiView", certiSeq);
	}
	
	// 업무담당자 증명서 등록
	public void insertAdmCerti(CertiVO certiVO) throws Exception {
		insert("AdmAdmstrDAO.insertAdmCerti", certiVO);
	}

	// 업무담당자 증명서 수정
	public void updateAdmCerti(CertiVO certiVO) throws Exception {
		update("AdmAdmstrDAO.updateAdmCerti", certiVO);
	}

	// 업무담당자 증명서 수료정보 목록
	@SuppressWarnings("unchecked")
	public List<EgovMap> selectAdmAjaxSearchComplList(String memberCode) throws Exception {
		return (List<EgovMap>) list("AdmAdmstrDAO.selectAdmAjaxSearchComplList", memberCode);
	}

	// 업무담당자 장학/수상 목록
	@SuppressWarnings("unchecked")
	public CmmnListVO selectAdmScholarList(CmmnSearchVO searchVO) throws Exception {
		int totalRecordCount = (int) select("AdmAdmstrDAO.selectAdmScholarListCnt", searchVO);
		List<EgovMap> egovList = (List<EgovMap>) list("AdmAdmstrDAO.selectAdmScholarList", searchVO);
		return new CmmnListVO(totalRecordCount, egovList);
	}

	// 업무담당자 장학/수상조회
	public ScholarVO selectAdmScholarModify(String scholarSeq) throws Exception {
		return (ScholarVO) select("AdmAdmstrDAO.selectAdmScholarModify", scholarSeq);
	}

	// 업무담당자 장학/수상 등록
	public void insertAdmScholar(ScholarVO scholarVO) throws Exception {
		insert("AdmAdmstrDAO.insertAdmScholar", scholarVO);
	}

	// 업무담당자 장학/수상 수정
	public void updateAdmScholar(ScholarVO scholarVO) throws Exception {
		update("AdmAdmstrDAO.updateAdmScholar", scholarVO);
	}

	// 업무담당자 장학/수상 엑셀다운로드
	@SuppressWarnings("unchecked")
	public List<EgovMap> selectAdmScholarExcel(CmmnSearchVO searchVO) throws Exception {
		return (List<EgovMap>) list("AdmAdmstrDAO.selectAdmScholarExcel", searchVO);
	}

	// 업무담당자 교사 엑셀다운로드
	@SuppressWarnings("unchecked")
	public List<EgovMap> selectAdmProfExcel(CmmnSearchVO searchVO) throws Exception {
		return (List<EgovMap>) list("AdmAdmstrDAO.selectAdmProfExcel", searchVO);
	}

	// 업무담당자 교사 삭제 체크
	public int selectAdmAjaxProfDelChk(String mCode) throws Exception {
		return (int) select("AdmAdmstrDAO.selectAdmAjaxProfDelChk", mCode);
	}

	// 업무담당자 교사 삭제
	public void deleteAdmAjaxProfDel(EgovMap map) throws Exception {
		delete("AdmAdmstrDAO.deleteAdmAjaxProfDel", map);
	}

	public SemesterVO findResidenceDate(SemesterVO semesterVO) {
		return (SemesterVO) select("AdmAdmstrDAO.findResidenceDate", semesterVO);
	}

	// 업무담당자 기숙사 엑셀다운로드
	@SuppressWarnings("unchecked")
	public List<EgovMap> selectAdmDormExcel(CmmnSearchVO searchVO) throws Exception {
		return (List<EgovMap>) list("AdmAdmstrDAO.selectAdmDormExcel", searchVO);
	}

	public String selectCertiNumCnt(CertiVO certiVO) throws Exception {
		return (String) select("AdmAdmstrDAO.selectCertiNumCnt", certiVO);
	}

	public String selectAdmAjaxCertiEtc(String certiSeq) throws Exception {
		return (String) select("AdmAdmstrDAO.selectAdmAjaxCertiEtc", certiSeq);
	}

	@SuppressWarnings("unchecked")
	public List<EgovMap> selectAdmCertiExcel(CmmnSearchVO searchVO) throws Exception {
		return (List<EgovMap>) list("AdmAdmstrDAO.selectAdmCertiExcel", searchVO);
	}

	public EgovMap selectAdmPopStdShip(CertiVO certiVO) throws Exception {
		return (EgovMap) select("AdmAdmstrDAO.selectAdmPopStdShip", certiVO);
	}

	public EgovMap selectAdmPopCertification(CertiVO certiVO) throws Exception {
		return (EgovMap) select("AdmAdmstrDAO.selectAdmPopCertification", certiVO);
	}

	public EgovMap selectAdmPopGradeCard(CertiVO certiVO) throws Exception {
		return (EgovMap) select("AdmAdmstrDAO.selectAdmPopGradeCard", certiVO);
	}

	@SuppressWarnings("unchecked")
	public List<EgovMap> selectAdmPopCertiList(String certiSeq) throws Exception {
		return (List<EgovMap>) list("AdmAdmstrDAO.selectAdmPopCertiList", certiSeq);
	}

	public String insertAdmCertiList(EgovMap map) throws Exception {
		return (String) insert("AdmAdmstrDAO.insertAdmCertiList", map);
	}

	public String selectAdmScholarNum(ScholarVO scholarVO) throws Exception {
		return (String) select("AdmAdmstrDAO.selectAdmScholarNum", scholarVO);
	}

	public EgovMap selectAdmScholarPop(String scholarSeq) throws Exception {
		return (EgovMap) select("AdmAdmstrDAO.selectAdmScholarPop", scholarSeq);
	}
	
	public void updateProfImg(MemberVO memberVO) throws Exception {
		update("AdmAdmstrDAO.updateProfImg", memberVO);
	}

	//교사 탭1
	@SuppressWarnings("unchecked")
	public List<EgovMap> admAjaxProfSubTab1(String memberCode) throws Exception {
		return (List<EgovMap>) list("AdmAdmstrDAO.admAjaxProfSubTab1", memberCode);
	}
	//교사 탭2
	@SuppressWarnings("unchecked")
	public List<EgovMap> admAjaxProfSubTab2(String memberCode)  throws Exception {
		return (List<EgovMap>) list("AdmAdmstrDAO.admAjaxProfSubTab2", memberCode);
	}
	//교사 탭3
	@SuppressWarnings("unchecked")
	public List<EgovMap> admAjaxProfSubTab3(String memberCode) throws Exception {
		return (List<EgovMap>) list("AdmAdmstrDAO.admAjaxProfSubTab3", memberCode);
	}
	//교사 탭4
	@SuppressWarnings("unchecked")
	public List<EgovMap> admAjaxProfSubTab4(String memberCode) throws Exception {
		return (List<EgovMap>) list("AdmAdmstrDAO.admAjaxProfSubTab4", memberCode);
	}
	//교사 추가 1
	public void admAjaxProfSubSave1(EgovMap map) throws Exception {
		insert("AdmAdmstrDAO.admAjaxProfSubSave1", map);
	}
	//교사 추가 2
	public void admAjaxProfSubSave2(EgovMap map) throws Exception{
		insert("AdmAdmstrDAO.admAjaxProfSubSave2", map);
	}
	//교사 추가 3
	public void admAjaxProfSubSave3(EgovMap map) throws Exception{
		insert("AdmAdmstrDAO.admAjaxProfSubSave3", map);
	}
	//교사 추가 4
	public void admAjaxProfSubSave4(EgovMap map) throws Exception{
		insert("AdmAdmstrDAO.admAjaxProfSubSave4", map);
	}

	//증명서 발급용 subTab4 cnt
	public String admAjaxProfSubTab4Cnt(String memberCode) {
		return (String) select("AdmAdmstrDAO.admAjaxProfSubSave4Cnt", memberCode);
	}
	//교과목명 찾기
	@SuppressWarnings("unchecked")
	public List<EgovMap> admAjaxLectName(EgovMap map) throws Exception{
		return (List<EgovMap>) list("AdmAdmstrDAO.admAjaxLectName", map);
	}
	//개설일 찾기
	@SuppressWarnings("unchecked")
	public List<EgovMap> admAjaxProfEnterDate(EgovMap map) throws Exception{
		return (List<EgovMap>) list("AdmAdmstrDAO.admAjaxProfEnterDate", map);
	}
	//분반 찾기
	@SuppressWarnings("unchecked")
	public List<EgovMap> ajaxSearchDivi(EgovMap map) throws Exception{
		return (List<EgovMap>) list("AdmAdmstrDAO.ajaxSearchDivi", map);
	}
	//tab1 선택
	public PrfSub1VO admAjaxProfSubTab1SelectOne(String seq) {
		return (PrfSub1VO)select("AdmAdmstrDAO.admAjaxProfSubTab1SelectOne", seq); 
	}
	//tab2 선택
	public PrfSub2VO admAjaxProfSubTab2SelectOne(String seq) {
		return (PrfSub2VO)select("AdmAdmstrDAO.admAjaxProfSubTab2SelectOne", seq); 
	}
	//tab3 선택
	public PrfSub3VO admAjaxProfSubTab3SelectOne(String seq) {
		return (PrfSub3VO)select("AdmAdmstrDAO.admAjaxProfSubTab3SelectOne", seq); 
	}
	//tab4 선택
	public PrfSub4VO admAjaxProfSubTab4SelectOne(String seq) {
		return (PrfSub4VO)select("AdmAdmstrDAO.admAjaxProfSubTab4SelectOne", seq); 
	}
	//탭1 업데이트
	public void admAjaxProfSubUpdate1(EgovMap map) throws Exception  {
		insert("AdmAdmstrDAO.admAjaxProfSubUpdate1", map);
	}
	//탭2 업데이트
	public void admAjaxProfSubUpdate2(EgovMap map) throws Exception  {
		insert("AdmAdmstrDAO.admAjaxProfSubUpdate2", map);
	}
	//탭3 업데이트
	public void admAjaxProfSubUpdate3(EgovMap map) throws Exception  {
		insert("AdmAdmstrDAO.admAjaxProfSubUpdate3", map);
	}
	//탭4 업데이트
	public void admAjaxProfSubUpdate4(EgovMap map) throws Exception  {
		insert("AdmAdmstrDAO.admAjaxProfSubUpdate4", map);
	}
	//퇴직증명서 인쇄
	@SuppressWarnings("unchecked")
	public List<EgovMap> selectAdmPopRetirement(EgovMap map) throws Exception {
		return (List<EgovMap>) list("AdmAdmstrDAO.selectAdmPopRetirement", map);
	}
	//교사리스트 인쇄
	@SuppressWarnings("unchecked")
	public List<EgovMap> selectAdmPopProfList(EgovMap map) throws Exception {
		return (List<EgovMap>) list("AdmAdmstrDAO.selectAdmPopProfList", map);
	}
	//명단에 년도-학기-개설일
	@SuppressWarnings("unchecked")
	public List<EgovMap> selectAdmPopSeme(EgovMap map)  throws Exception {
		return (List<EgovMap>) list("AdmAdmstrDAO.selectAdmPopSeme", map);
	}

	//상세보기시 추가사항
	@SuppressWarnings("unchecked")
	public List<EgovMap> selectSubTabList(String memberSeq) throws Exception {
		return (List<EgovMap>) list("AdmAdmstrDAO.selectSubTabList", memberSeq);
	}

	public void updateLoginFailClear(String memberCode) throws Exception {
		update("AdmAdmstrDAO.updateLoginFailClear", memberCode);
	}

	public EgovMap selectAdmPopTuition(CertiVO certiVO) throws Exception {
		return (EgovMap) select("AdmAdmstrDAO.selectAdmPopTuition", certiVO);
	}

	@SuppressWarnings("unchecked")
	public List<EgovMap> selectAdmPopStdShipList(CertiVO certiVO) throws Exception {
		return (List<EgovMap>) list("AdmAdmstrDAO.selectAdmPopStdShipList", certiVO);
	}

	@SuppressWarnings("unchecked")
	public List<EgovMap> selectAdmPopGradeCardList(CertiVO certiVO) throws Exception {
		return (List<EgovMap>) list("AdmAdmstrDAO.selectAdmPopGradeCardList", certiVO);
	}

	public EgovMap selectAdmPopGradeCardAll(CertiVO certiVO) throws Exception {
		return (EgovMap) select("AdmAdmstrDAO.selectAdmPopGradeCardAll", certiVO);
	}
}
