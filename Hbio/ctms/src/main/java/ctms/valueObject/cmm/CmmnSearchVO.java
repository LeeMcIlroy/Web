package ctms.valueObject.cmm;


public class CmmnSearchVO {

	/** 타입 */
	private String searchType = "";
	public String getSearchType() { return searchType; }
	public void setSearchType(String searchType) { this.searchType = searchType; }
	
	/** 메뉴 타입*/
	private String menuType = "";
	public String getMenuType() { return menuType; }
	public void setMenuType(String menuType) { this.menuType = menuType; }

	/** 검색 조건1 */
	private String searchCondition1 = "";
	public String getSearchCondition1() { return searchCondition1; }
	public void setSearchCondition1(String searchCondition1) { this.searchCondition1 = searchCondition1; }
	
	/** 검색 조건2 */
	private String searchCondition2 = "";
	public String getSearchCondition2() { return searchCondition2; }
	public void setSearchCondition2(String searchCondition2) { this.searchCondition2 = searchCondition2; }
	
	/** 검색 조건3 */
	private String searchCondition3 = "";
	public String getSearchCondition3() { return searchCondition3; }
	public void setSearchCondition3(String searchCondition3) { this.searchCondition3 = searchCondition3; }

	/** 검색 조건4 */
	private String searchCondition4 = "";
	public String getSearchCondition4() { return searchCondition4; }
	public void setSearchCondition4(String searchCondition4) { this.searchCondition4 = searchCondition4; }

	/** 검색 조건5 */
	private String searchCondition5 = "";
	public String getSearchCondition5() { return searchCondition5; }
	public void setSearchCondition5(String searchCondition5) { this.searchCondition5 = searchCondition5; }
	
	/** 검색 조건6 */
	private String searchCondition6 = "";
	public String getSearchCondition6() { return searchCondition6; }
	public void setSearchCondition6(String searchCondition6) { this.searchCondition6 = searchCondition6; }

	/** 검색 조건7 */
	private String searchCondition7 = "";
	public String getSearchCondition7() { return searchCondition7; }
	public void setSearchCondition7(String searchCondition7) { this.searchCondition7 = searchCondition7; }
	
	/** 검색 조건8 */
	private String searchCondition8 = "";
	public String getSearchCondition8() { return searchCondition8; }
	public void setSearchCondition8(String searchCondition8) { this.searchCondition8 = searchCondition8; }
	
	/** 검색 단어 */
	private String searchWord = "";
	public String getSearchWord() { return searchWord; }
	public void setSearchWord(String searchWord) { this.searchWord = searchWord; }

	/** 날짜 */
	private String startDate = "";
	private String endDate = "";
	public String getStartDate() { return startDate; }
	public void setStartDate(String startDate) { this.startDate = startDate; }
	public String getEndDate() { return endDate; }
	public void setEndDate(String endDate) { this.endDate = endDate; }
	
	private String searchDate = "";
	public String getSearchDate() { return searchDate; }
	public void setSearchDate(String searchDate) { this.searchDate = searchDate; }

	/** 연도 */
	private String searchYear = "";
	public String getSearchYear() { return searchYear; }
	public void setSearchYear(String searchYear) { this.searchYear = searchYear; }

	/** 메세지 */
	private String message = "";

	/** 현재페이지 */
	private int pageIndex = 1;

	/** firstIndex */
	private int firstIndex = 1;

	/** lastIndex */
	private int lastIndex = 1;

	/** recordCountPerPage */
	private int recordCountPerPage = 20;
	
	/* CTSM 운영회사 설정용도 - 2020.12.12 개발2*/
	private String ctmsCorpCd;
	
	public String getCtmsCorpCd() { 
		return ctmsCorpCd; 
	}
	public void setCtmsCorpCd(String ctmsCorpCd) { 
		this.ctmsCorpCd = ctmsCorpCd; 
	}
	
	private String corpCd;
	
	public String getCorpCd() { 
		return corpCd; 
	}
	public void setCorpCd(String corpCd) { 
		this.corpCd = corpCd; 
	}
	
	private String rsNo;
	
	public String getRsNo() { 
		return rsNo; 
	}
	public void setRsNo(String rsNo) { 
		this.rsNo = rsNo; 
	}
	
	/* 연구대상자(피험자)선정 지원여부 구분 */
	private String appYn;
	
	public String getAppYn() { 
		return appYn; 
	}
	public void setAppYn(String appYn) { 
		this.appYn = appYn; 
	}
	
	/* 연구대상자(피험자)선정 풀선별여부 구분 */
	private String poolYn;
	
	public String getPoolYn() { 
		return poolYn; 
	}
	public void setPoolYn(String poolYn) { 
		this.poolYn = poolYn; 
	}
	
	/* 연구대상자(피험자)선정 1차선정여부 구분 */
	private String firstSt;
	
	public String getFirstSt() { 
		return firstSt; 
	}
	public void setFirstSt(String firstSt) { 
		this.firstSt = firstSt; 
	}
	
	/* 연구대상자(피험자)선정 최종확정여부 구분 */
	private String cfmYn;
	
	public String getCfmYn() { 
		return cfmYn; 
	}
	public void setCfmYn(String cfmYn) { 
		this.cfmYn = cfmYn; 
	}
	
	/* 연구대상자(피험자)선정 탭구분 */
	private String setVal;
	
	public String getSetVal() { 
		return setVal; 
	}
	public void setSetVal(String setVal) { 
		this.setVal = setVal; 
	}

	/* 연구대상자 번호 */
	private String rsjNo;
	
	public String getRsjNo() { 
		return rsjNo; 
	}
	public void setRsjNo(String rsjNo) { 
		this.rsjNo = rsjNo; 
	}
	
	/* 소속지사 */
	private String branchCd;
	
	public String getBranchCd() { 
		return branchCd; 
	}
	public void setBranchCd(String branchCd) { 
		this.branchCd = branchCd; 
	}

	/* 연구대상자특성조회조건 1 - 안면여드름*/
	private String searchParam1;
	public String getSearchParam1() { 
		return searchParam1; 
	}
	public void setSearchParam1(String searchParam1) { 
		this.searchParam1 = searchParam1; 
	}
	/* 연구대상자특성조회조건 2 - 등여드름*/
	private String searchParam2;
	public String getSearchParam2() { 
		return searchParam2; 
	}
	public void setSearchParam2(String searchParam2) { 
		this.searchParam2 = searchParam2; 
	}
	/* 연구대상자특성조회조건 3 - 팔자주름*/
	private String searchParam3;
	public String getSearchParam3() { 
		return searchParam3; 
	}
	public void setSearchParam3(String searchParam3) { 
		this.searchParam3 = searchParam3; 
	}
	/* 연구대상자특성조회조건 4 - 셀룰라이트*/
	private String searchParam4;
	public String getSearchParam4() { 
		return searchParam4; 
	}
	public void setSearchParam4(String searchParam4) { 
		this.searchParam4 = searchParam4; 
	}
	/* 연구대상자특성조회조건 5 - 눈가주름*/
	private String searchParam5;
	public String getSearchParam5() { 
		return searchParam5; 
	}
	public void setSearchParam5(String searchParam5) { 
		this.searchParam5 = searchParam5; 
	}
	/* 연구대상자특성조회조건 6 - 다크서클*/
	private String searchParam6;
	public String getSearchParam6() { 
		return searchParam6; 
	}
	public void setSearchParam6(String searchParam6) { 
		this.searchParam6 = searchParam6; 
	}
	/* 연구대상자특성조회조건 7 - 광피부타입*/
	private String searchParam7;
	public String getSearchParam7() { 
		return searchParam7; 
	}
	public void setSearchParam7(String searchParam7) { 
		this.searchParam7 = searchParam7; 
	}
	/* 연구대상자특성조회조건 8 - 색소침착 */
	private String searchParam8;
	public String getSearchParam8() { 
		return searchParam8; 
	}
	public void setSearchParam8(String searchParam8) { 
		this.searchParam8 = searchParam8; 
	}
	/* 연구대상자특성조회조건 9 - 탈모 */
	private String searchParam9;
	public String getSearchParam9() { 
		return searchParam9; 
	}
	public void setSearchParam9(String searchParam9) { 
		this.searchParam9 = searchParam9; 
	}
	/* 연구대상자특성조회조건 10 - 아이백 */
	private String searchParam10;
	public String getSearchParam10() { 
		return searchParam10; 
	}
	public void setSearchParam10(String searchParam10) { 
		this.searchParam10 = searchParam10; 
	}
	/* 연구대상자특성조회조건 11 - 민감여부 */
	private String searchParam11;
	public String getSearchParam11() { 
		return searchParam11; 
	}
	public void setSearchParam11(String searchParam11) { 
		this.searchParam11 = searchParam11; 
	}
	/* 연구대상자특성조회조건 12 - 비듬 */
	private String searchParam12;
	public String getSearchParam12() { 
		return searchParam12; 
	}
	public void setSearchParam12(String searchParam12) { 
		this.searchParam12 = searchParam12; 
	}
	/* 연구대상자특성조회조건 13 - 홍조 */
	private String searchParam13;
	public String getSearchParam13() { 
		return searchParam13; 
	}
	public void setSearchParam13(String searchParam13) { 
		this.searchParam13 = searchParam13; 
	}
	
	/* (교수,학생) 상단 공지 개수  시작  >> 20200312*/
	private int topNotiListCnt ;

	public int getTopNotiListCnt() {
		return topNotiListCnt;
	}
	public void setTopNotiListCnt(int topNotiListCnt) {
		this.topNotiListCnt = topNotiListCnt;
	}
	/* (교수,학생) 상단 공지 개수   끝  >> 20200312*/
	
	public String getMessage() {
		return message;
	}

	public void setMessage(String message) {
		this.message = message;
	}

	public int getPageIndex() {
		return pageIndex;
	}

	public void setPageIndex(int pageIndex) {
		this.pageIndex = pageIndex;
	}

	public int getFirstIndex() {
		return firstIndex;
	}

	public void setFirstIndex(int firstIndex) {
		this.firstIndex = firstIndex;
	}

	public int getLastIndex() {
		return lastIndex;
	}

	public void setLastIndex(int lastIndex) {
		this.lastIndex = lastIndex;
	}

	public int getRecordCountPerPage() {
		return recordCountPerPage;
	}

	public void setRecordCountPerPage(int recordCountPerPage) {
		this.recordCountPerPage = recordCountPerPage;
	}
	
	/** 20200513 업무담당자 수업만족도(교사) double paging */
	/** 현재페이지 */
	private int pageIndex2 = 1;

	/** firstIndex */
	private int firstIndex2 = 1;

	/** lastIndex */
	private int lastIndex2 = 1;
	
	public int getPageIndex2() {
		return pageIndex2;
	}
	
	public void setPageIndex2(int pageIndex2) {
		this.pageIndex2 = pageIndex2;
	}
	
	public int getFirstIndex2() {
		return firstIndex2;
	}
	
	public void setFirstIndex2(int firstIndex2) {
		this.firstIndex2 = firstIndex2;
	}
	
	public int getLastIndex2() {
		return lastIndex2;
	}
	
	public void setLastIndex2(int lastIndex2) {
		this.lastIndex2 = lastIndex2;
	}
	
	@Override
	public String toString() {
		return "CmmnSearchVO [searchType=" + searchType + ", menuType=" + menuType + ", searchCondition1="
				+ searchCondition1 + ", searchCondition2=" + searchCondition2 + ", searchCondition3=" + searchCondition3
				+ ", searchCondition4=" + searchCondition4 + ", searchCondition5=" + searchCondition5
				+ ", searchCondition6=" + searchCondition6 + ", searchCondition7=" + searchCondition7
				+ ", searchCondition8=" + searchCondition8 + ", searchWord=" + searchWord + ", startDate=" + startDate
				+ ", endDate=" + endDate + ", searchDate=" + searchDate + ", searchYear=" + searchYear + ", message="
				+ message + ", pageIndex=" + pageIndex + ", firstIndex=" + firstIndex + ", lastIndex=" + lastIndex
				+ ", recordCountPerPage=" + recordCountPerPage + ", ctmsCorpCd=" + ctmsCorpCd + ", corpCd=" + corpCd
				+ ", rsNo=" + rsNo + ", appYn=" + appYn + ", poolYn=" + poolYn + ", firstSt=" + firstSt + ", cfmYn="
				+ cfmYn + ", setVal=" + setVal + ", topNotiListCnt=" + topNotiListCnt + ", pageIndex2=" + pageIndex2
				+ ", firstIndex2=" + firstIndex2 + ", lastIndex2=" + lastIndex2 + ", getSearchType()=" + getSearchType()
				+ ", getMenuType()=" + getMenuType() + ", getSearchCondition1()=" + getSearchCondition1()
				+ ", getSearchCondition2()=" + getSearchCondition2() + ", getSearchCondition3()="
				+ getSearchCondition3() + ", getSearchCondition4()=" + getSearchCondition4()
				+ ", getSearchCondition5()=" + getSearchCondition5() + ", getSearchCondition6()="
				+ getSearchCondition6() + ", getSearchCondition7()=" + getSearchCondition7()
				+ ", getSearchCondition8()=" + getSearchCondition8() + ", getSearchWord()=" + getSearchWord()
				+ ", getStartDate()=" + getStartDate() + ", getEndDate()=" + getEndDate() + ", getSearchDate()="
				+ getSearchDate() + ", getSearchYear()=" + getSearchYear() + ", getCtmsCorpCd()=" + getCtmsCorpCd()
				+ ", getCorpCd()=" + getCorpCd() + ", getRsNo()=" + getRsNo() + ", getAppYn()=" + getAppYn()
				+ ", getPoolYn()=" + getPoolYn() + ", getFirstSt()=" + getFirstSt() + ", getCfmYn()=" + getCfmYn()
				+ ", getSetVal()=" + getSetVal() + ", getTopNotiListCnt()=" + getTopNotiListCnt() + ", getMessage()="
				+ getMessage() + ", getPageIndex()=" + getPageIndex() + ", getFirstIndex()=" + getFirstIndex()
				+ ", getLastIndex()=" + getLastIndex() + ", getRecordCountPerPage()=" + getRecordCountPerPage()
				+ ", getPageIndex2()=" + getPageIndex2() + ", getFirstIndex2()=" + getFirstIndex2()
				+ ", getLastIndex2()=" + getLastIndex2() + ", getClass()=" + getClass() + ", hashCode()=" + hashCode()
				+ ", toString()=" + super.toString() + "]";
	}
	
	
}