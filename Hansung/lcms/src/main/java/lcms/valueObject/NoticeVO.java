package lcms.valueObject;

public class NoticeVO {
	private String noti_seq = ""; // No.
	private String noti_gubun = ""; // 공지구분
	private String noti_title = ""; // 제목
	private String noti_writer = ""; // 작성자
	private String noti_date = ""; // 작성일
	private String noti_hit = ""; //  (admin) 공지조회수
	private String noti_stdhit = ""; // (user)학생 조회수
	private String noti_lechit = ""; // (user)교사 조회수
	private String noti_content = ""; // 내용
	private String noti_top = ""; // 상단 고정공지

	public String getNoti_top() {
		return noti_top;
	}

	public void setNoti_top(String noti_top) {
		this.noti_top = noti_top;
	}

	public String getNoti_seq() {
		return noti_seq;
	}

	public void setNoti_seq(String noti_seq) {
		this.noti_seq = noti_seq;
	}

	public String getNoti_gubun() {
		return noti_gubun;
	}

	public void setNoti_gubun(String noti_gubun) {
		this.noti_gubun = noti_gubun;
	}

	public String getNoti_title() {
		return noti_title;
	}

	public void setNoti_title(String noti_title) {
		this.noti_title = noti_title;
	}

	public String getNoti_writer() {
		return noti_writer;
	}

	public void setNoti_writer(String noti_writer) {
		this.noti_writer = noti_writer;
	}

	public String getNoti_date() {
		return noti_date;
	}

	public void setNoti_date(String noti_date) {
		this.noti_date = noti_date;
	}

	public String getNoti_hit() {
		return noti_hit;
	}

	public void setNoti_hit(String noti_hit) {
		this.noti_hit = noti_hit;
	}

	public String getNoti_stdhit() {
		return noti_stdhit;
	}

	public void setNoti_stdhit(String noti_stdhit) {
		this.noti_stdhit = noti_stdhit;
	}

	public String getNoti_lechit() {
		return noti_lechit;
	}

	public void setNoti_lechit(String noti_lechit) {
		this.noti_lechit = noti_lechit;
	}

	public String getNoti_content() {
		return noti_content;
	}

	public void setNoti_content(String noti_content) {
		this.noti_content = noti_content;
	}

	@Override
	public String toString() {
		return "NoticeVO [noti_seq=" + noti_seq + ", noti_gubun=" + noti_gubun
				+ ", noti_title=" + noti_title + ", noti_writer=" + noti_writer
				+ ", noti_date=" + noti_date + ", noti_hit=" + noti_hit
				+ ", noti_stdhit=" + noti_stdhit + ", noti_prfhit="
				+ noti_lechit + ", noti_content=" + noti_content
				+ ", noti_top=" + noti_top + "]";
	}
}
