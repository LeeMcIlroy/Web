package valueObject;

import java.text.SimpleDateFormat;
import java.util.Calendar;
import java.util.Date;

public class DateVO {
	// 기준날짜
	private Date stdDate;
	public Date getStdDate() {
		return stdDate;
	}
	public void setStdDate(Date stdDate) {
		this.stdDate = stdDate;
		SimpleDateFormat sdf = new SimpleDateFormat("yyyy MM dd HH");
		Calendar cal = Calendar.getInstance();
		cal.setTime(stdDate);
		
		// 오늘 날짜 set - start
		String strNowDate = sdf.format(stdDate);
		setnYear(strNowDate.split(" ")[0]);
		setnMonth(strNowDate.split(" ")[1]);
		setnDate(strNowDate.split(" ")[2]);
		setnHour(strNowDate.split(" ")[3]);
		// 오늘 날짜 set - end
		
		// 어제날짜 set - start
		cal.add(Calendar.DATE, -1);
		String strYesterDate = sdf.format(cal.getTime());
		setyYear(strYesterDate.split(" ")[0]);
		setyMonth(strYesterDate.split(" ")[1]);
		setyDate(strYesterDate.split(" ")[2]);
		setyHour(strYesterDate.split(" ")[3]);
		// 어제날짜 set - end
		
		// 지난달 set - start
		cal.add(Calendar.DATE, 1);	// 어제날짜 원상복귀
		cal.add(Calendar.MONTH, -1);
		String strPreMonth = sdf.format(cal.getTime());
		setPmYear(strPreMonth.split(" ")[0]);
		setPmMonth(strPreMonth.split(" ")[1]);
		setPmDate(strPreMonth.split(" ")[2]);
		// 지난달 set - end
		
		// 작년오늘 set - start
		cal.add(Calendar.MONTH, 1);	// 지난달 원상복귀
		cal.add(Calendar.YEAR, -1);
		String strPreYear = sdf.format(cal.getTime());
		setPyYear(strPreYear.split(" ")[0]);
		setPyMonth(strPreYear.split(" ")[1]);
		setPyDate(strPreYear.split(" ")[2]);
		setPyHour(strPreYear.split(" ")[3]);
		// 작년오늘 set - end
	}
	
	// 오늘 날짜
	private String nYear = "";
	private String nMonth = "";
	private String nDate = "";
	private String nHour = "";
	
	// 어제날짜
	private String yYear = "";
	private String yMonth = "";
	private String yDate = "";
	private String yHour = "";
	
	// 지난달
	private String pmYear = "";
	private String pmMonth = "";
	private String pmDate = "";
	
	// 작년오늘
	private String pyYear = "";
	private String pyMonth = "";
	private String pyDate = "";
	private String pyHour = "";
	public String getnYear() {
		return nYear;
	}
	public void setnYear(String nYear) {
		this.nYear = nYear;
	}
	public String getnMonth() {
		return nMonth;
	}
	public void setnMonth(String nMonth) {
		this.nMonth = nMonth;
	}
	public String getnDate() {
		return nDate;
	}
	public void setnDate(String nDate) {
		this.nDate = nDate;
	}
	public String getnHour() {
		return nHour;
	}
	public void setnHour(String nHour) {
		this.nHour = nHour;
	}
	public String getyYear() {
		return yYear;
	}
	public void setyYear(String yYear) {
		this.yYear = yYear;
	}
	public String getyMonth() {
		return yMonth;
	}
	public void setyMonth(String yMonth) {
		this.yMonth = yMonth;
	}
	public String getyDate() {
		return yDate;
	}
	public void setyDate(String yDate) {
		this.yDate = yDate;
	}
	public String getyHour() {
		return yHour;
	}
	public void setyHour(String yHour) {
		this.yHour = yHour;
	}
	public String getPmYear() {
		return pmYear;
	}
	public void setPmYear(String pmYear) {
		this.pmYear = pmYear;
	}
	public String getPmMonth() {
		return pmMonth;
	}
	public void setPmMonth(String pmMonth) {
		this.pmMonth = pmMonth;
	}
	public String getPmDate() {
		return pmDate;
	}
	public void setPmDate(String pmDate) {
		this.pmDate = pmDate;
	}
	public String getPyYear() {
		return pyYear;
	}
	public void setPyYear(String pyYear) {
		this.pyYear = pyYear;
	}
	public String getPyMonth() {
		return pyMonth;
	}
	public void setPyMonth(String pyMonth) {
		this.pyMonth = pyMonth;
	}
	public String getPyDate() {
		return pyDate;
	}
	public void setPyDate(String pyDate) {
		this.pyDate = pyDate;
	}
	public String getPyHour() {
		return pyHour;
	}
	public void setPyHour(String pyHour) {
		this.pyHour = pyHour;
	}
	
}
