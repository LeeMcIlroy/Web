package writer.valueObject.cmmn;

public class CmmnSearchVO {
	
	/** 학기 강의실 */
	private String searchSemester = "";
	public String getSearchSemester() { return searchSemester; }
	public void setSearchSemester(String searchSemester) { this.searchSemester = searchSemester; }
	
	/** 계열 */
	private String searchDepartment = "";
	public String getSearchDepartment() { return searchDepartment; }
	public void setSearchDepartment(String searchDepartment) { this.searchDepartment = searchDepartment; }
	
	/** 반_교수 */
	private String searchClass = "";
	public String getSearchClass() { return searchClass; }
	public void setSearchClass(String searchClass) { this.searchClass = searchClass; }

	/** 주제 */
	private String searchSubject = "";
	public String getSearchSubject() { return searchSubject; }
	public void setSearchSubject(String searchSubject) { this.searchSubject = searchSubject; }

	/** 과제 */
	private String searchHomework = "";
	public String getSearchHomework() { return searchHomework; }
	public void setSearchHomework(String searchHomework) { this.searchHomework = searchHomework; }

	/** 타입 */
	private String searchType = "";
	public String getSearchType() { return searchType; }
	public void setSearchType(String searchType) { this.searchType = searchType; }

	/** 년도 */
	private String searchYear = "";
	public String getSearchYear() { return searchYear; }
	public void setSearchYear(String searchYear) { this.searchYear = searchYear; }
	
	/** 메뉴 타입*/
	private String menuType = "";
	public String getMenuType() { return menuType; }
	public void setMenuType(String menuType) { this.menuType = menuType; }

	/** 검색 조건 */
	private String searchCondition = "";
	public String getSearchCondition() { return searchCondition; }
	public void setSearchCondition(String searchCondition) { this.searchCondition = searchCondition; }
	
	/** 검색 조건2 */
	private String searchCondition2 = "";
	public String getSearchCondition2() { return searchCondition2; }
	public void setSearchCondition2(String searchCondition2) { this.searchCondition2 = searchCondition2; }

	/** 검색 단어 */
	private String searchWord = "";
	public String getSearchWord() { return searchWord; }
	public void setSearchWord(String searchWord) { this.searchWord = searchWord; }
	
	/** 검색 단어2 */
	private String searchWord2 = "";
	public String getSearchWord2() { return searchWord2; }
	public void setSearchWord2(String searchWord2) { this.searchWord2 = searchWord2; }

	/** 날짜 */
	private String startDate = "";
	private String endDate = "";
	public String getStartDate() { return startDate; }
	public void setStartDate(String startDate) { this.startDate = startDate; }
	public String getEndDate() { return endDate; }
	public void setEndDate(String endDate) { this.endDate = endDate; }
	

	/** 메세지 */
	private String message = "";

	/** 현재페이지 */
	private int pageIndex = 1;
	
	/** 현재페이지2 */
	private int pageIndex2 = 1;
	public int getPageIndex2() { return pageIndex2; }
	public void setPageIndex2(int pageIndex2) { this.pageIndex2 = pageIndex2; }

	/** firstIndex */
	private int firstIndex = 1;

	/** lastIndex */
	private int lastIndex = 1;

	/** recordCountPerPage */
	private int recordCountPerPage = 10;

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
	@Override
	public String toString() {
		return "CmmnSearchVO [\r\nsearchSemester=" + searchSemester + "\r\n searchDepartment=" + searchDepartment
				+ "\r\n searchClass=" + searchClass + "\r\n searchSubject=" + searchSubject + "\r\n searchHomework="
				+ searchHomework + "\r\n searchType=" + searchType + "\r\n menuType=" + menuType + "\r\n searchCondition="
				+ searchCondition + "\r\n searchCondition2=" + searchCondition2 + "\r\n searchWord=" + searchWord
				+ "\r\n searchWord2=" + searchWord2 + "\r\n startDate=" + startDate + "\r\n endDate=" + endDate + "\r\n message="
				+ message + "\r\n pageIndex=" + pageIndex + "\r\n pageIndex2=" + pageIndex2 + "\r\n firstIndex=" + firstIndex
				+ "\r\n lastIndex=" + lastIndex + "\r\n recordCountPerPage=" + recordCountPerPage + "\r\n]";
	}
}