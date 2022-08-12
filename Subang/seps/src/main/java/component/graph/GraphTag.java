package component.graph;

import java.io.IOException;
import java.util.ArrayList;
import java.util.List;
import java.util.Map;

import javax.servlet.jsp.JspException;
import javax.servlet.jsp.tagext.TagSupport;

import egovframework.let.utl.fcc.service.EgovStringUtil;

@SuppressWarnings("serial")
public class GraphTag extends TagSupport {
	
	private String id = "";
	private int width = 1000;
	private int height = 1000;
	private List<List<String>> data = new ArrayList<>();
	private int colData = 0;
	private String graphType = "spline";
	private String axisXType = "";
	private String axisXTickFormat = "";
	private String dataTitleList = "";
	private String xValue = "";
	private String selectedY2Line = "";
	private String pointYn = "";

	private String avgTarget = "";
	private String avgTitle = "";
	
	public void setId(String id) {
		this.id = id;
	}
	public void setWidth(int width) {
		this.width = width;
	}
	public void setHeight(int height) {
		this.height = height;
	}
	public void setData(List<List<String>> data) {
		this.data = data;
	}
	public void setGraphType(String graphType) {
		this.graphType = graphType;
	}
	public void setAxisXType(String axisXType) {
		this.axisXType = axisXType;
	}
	public void setAxisXTickFormat(String axisXTickFormat) {
		this.axisXTickFormat = axisXTickFormat;
	}
	public void setDataTitleList(String dataTitleList) {
		this.dataTitleList = dataTitleList;
	}
	public void setxValue(String xValue) {
		this.xValue = xValue;
	}
	public void setSelectedY2Line(String selectedY2Line) {
		this.selectedY2Line = selectedY2Line;
	}
	public void setAvgTarget(String avgTarget) {
		this.avgTarget = avgTarget;
	}
	public void setAvgTitle(String avgTitle) {
		this.avgTitle = avgTitle;
	}
	public int getColData() {
		return colData;
	}
	public void setColData(int colData) {
		this.colData = colData;
	}
	public String getPointYn() {
		return pointYn;
	}
	public void setPointYn(String pointYn) {
		this.pointYn = pointYn;
	}
	@Override
	public int doEndTag() throws JspException {
		try {
			
			pageContext.getOut().write(setGraphScript());
			//pageContext.popBody().write(setGraphScript());
			//pageContext.popBody().print(setGraphScript());
			//pageContext.pushBody().print(setGraphScript());
			//pageContext.getResponse().getWriter().print(setGraphScript());
		} catch (IOException e) {
			e.printStackTrace();
		}
		return EVAL_PAGE;
	}
	private String setGraphScript(){
		StringBuilder sb = new StringBuilder();
		try {
			sb.append("<div id=\""+id+"\"></div>");
			sb.append("<script type=\"text/javascript\">\n var "+id+"; \n$(function() { \n");
			sb.append(id+" = c3.generate({	\n");
			sb.append("		bindto : '#"+id+"'	\n");
			/*
			sb.append("		, size : {	\n");
			sb.append("			width: "+width);
			sb.append("			, height: "+height);
			sb.append("		}	\n");
			*/
			sb.append("		, color : { pattern: ['#169c70', '#cbd018', '#f65319'] }	\n");
			sb.append("		, data : {	\n");
			sb.append("			x : 'x'	\n");
			sb.append("			, xFormat : '"+setXFormat(xValue)+"'	\n");
			sb.append("			, columns : [	\n");
			
			sb.append("					[	\n");
			List<String> xList = setXColumns(xValue);
			for(int i = 0; i < xList.size(); i++){
				if(i != 0) sb.append("				, ");
				sb.append("'"+xList.get(i)+"'");
			}
			sb.append("					]	\n");
			
			
			List<List<String>> tmpData = new ArrayList<>();
			
			for(List<String> tmp : data){
				List<String> a = new ArrayList<>();
				for(String s : tmp){
					a.add(s);
				}
				tmpData.add(a);
			}
			
			List<List<String>> resultList = set(dataTitleList, tmpData);
			
			//List<List<String>> resultList = set(dataTitleList, data);
/*			
			if("chart5".equals(id)){
				for(int x = 0; x < resultList.size(); x++){
				//for(List<String> result: resultList){
					sb.append("				, [	\n");
					for(int i = 0; i < xList.size(); i++){
						if(resultList.get(x).size() > i){
							if(i != 0) {
								sb.append(String.format(", %s", numberFormat(resultList.get(x).get(i), "YEAR")));
							}else{
								sb.append(String.format("'data%d'" , x));
							}
						}else{
							sb.append(", null");
						}
					}
					sb.append("				]	\n");
				}
				sb.append("			]	\n");
				sb.append("		, names : {	\n");
				sb.append("data0 : '월별 발전수익(백만원)'");
				sb.append(", data1 : '월별 상환액(백만원)'");
				sb.append("		}	\n");
			}else{
				for(List<String> result: resultList){
					sb.append("				, [	\n");
					for(int i = 0; i < xList.size(); i++){
						if(i != 0) sb.append(", ");
						if(result.size() > i){
							sb.append("'"+result.get(i)+"'");
						}else{
							sb.append("null");
						}
					}
					sb.append("				]	\n");
				}
				sb.append("			]	\n");
			}
*/
			for(List<String> result: resultList){
				sb.append("				, [	\n");
				for(int i = 0; i < xList.size(); i++){
					if(i != 0) sb.append(", ");
					if(result.size() > i){
						sb.append("'"+result.get(i)+"'");
					}else{
						sb.append("null");
					}
				}
				sb.append("				]	\n");
			}
			sb.append("			]	\n");
			
			sb.append("		, type : '"+graphType+"'	\n");
			
			if(!EgovStringUtil.isEmpty(selectedY2Line)){
				sb.append("		, axes: {	\n");
				sb.append("			'"+selectedY2Line+"' : 'y2'	\n");
				sb.append("		}	\n");
			}
			
			sb.append("		}	\n");
			sb.append("		, axis: {	\n");
			sb.append("			x: {	\n");
			sb.append("				type: '"+axisXType+"'	\n");
			sb.append("				, tick: {	\n");
			sb.append("					format: '"+(EgovStringUtil.isEmpty(axisXTickFormat)? setTickFormat(xValue) : axisXTickFormat)+"'	\n");
			sb.append("				}	\n");
			sb.append("			}	\n");
			/*
			sb.append("			, y : {	\n");
			sb.append("				tick: {	\n");
			String[] dataTitle = dataTitleList.split(",");
			String str = "";
			String str1 = "";
			String str2 = "";
			if("YEAR".equals(xValue)){
				str1 = "return (d/1000000) + 'MWh';";
				str2 = "return (d/1000000) + '백만원';";
			}else if("MONTH".equals(xValue)){
				str1 = "return (d/1000) + 'kWh';";
				str2 = "return (d/1000) + '천원';";
			}else{
				str1 = "return d + 'kWh';";
				str2 = "return d + '원';";
			}
			
			if((dataTitle[0].trim()).indexOf("발전량") >= 0){
				str = String.format("function(d) { %s } ", str1);
			}else if((dataTitle[0].trim()).indexOf("발전수익") >= 0){
				str = String.format("function(d) { %s } ", str2);
			}
			if(!EgovStringUtil.isEmpty(str)) sb.append("					format: "+str+"	\n");
			
			sb.append("				}	\n");
			sb.append("			}	\n");
			*/
			if(!EgovStringUtil.isEmpty(selectedY2Line)) sb.append("			, y2 : { show: true }	\n");
			
			sb.append("		}	\n");
			sb.append("		, point: {	\n");
			if(!EgovStringUtil.isEmpty(pointYn)){
				sb.append("			show : true	\n");
			}else{
				sb.append("			show : false	\n");
			}
			sb.append("		}	\n");
			sb.append("		, line : {	\n");
			sb.append("			connectNull : true	\n");
			sb.append("		}	\n");
			
			
			if(!EgovStringUtil.isEmpty(avgTarget)){
				sb.append("		, grid : {	\n");
				sb.append("			y: {	\n");
				sb.append("				lines: [	\n");
			
				String[] arrAvgTarget = avgTarget.split(",");
				
				String[] arrAvgTitle = avgTitle.split(",");
				
				for(int i = 0; i < arrAvgTarget.length; i++){
					if(i != 0) sb.append(", ");
					
					double avg = setGraphDataAvg(resultList, arrAvgTarget[i].trim());
					sb.append("{value: '"+avg+"'");
					sb.append(", text: '"+((arrAvgTitle.length > i && !EgovStringUtil.isEmpty(avgTitle))? arrAvgTitle[i].trim() : arrAvgTarget[i].trim())+"'");
					sb.append(", axis: '"+((selectedY2Line.equals(arrAvgTarget[i].trim()))? "y2" : "y")+"'");
					sb.append(", position: 'end', class: 'label-warn"+i+"'}	\n");
				}
			
				sb.append("				]	\n");
				sb.append("			}	\n");
				sb.append("		}	\n");
			}
			
			sb.append("	});	\n");
			sb.append("});</script>");
		
		} catch (Exception e) {
			e.printStackTrace();
			sb.setLength(0);
			sb.append("데이터가 존재하지 않습니다.");
		}
		
		return sb.toString();
	}
	
	
	private List<String> setXColumns(String xValue){
		List<String> list = new ArrayList<>();
		list.add("x");
		if("1H".equals(xValue)){
			for(int i = 0; i < 24; i++){
				String strH = String.format("0%d", i);
				list.add(strH.substring(strH.length()-2, strH.length())+":00");
			}
			/*
			list.add("01:00");list.add("02:00");list.add("03:00");list.add("04:00");
			list.add("05:00");list.add("06:00");list.add("07:00");list.add("08:00");
			list.add("09:00");list.add("10:00");list.add("11:00");list.add("12:00");
			list.add("13:00");list.add("14:00");list.add("15:00");list.add("16:00");
			list.add("17:00");list.add("18:00");list.add("19:00");list.add("20:00");
			list.add("21:00");list.add("22:00");list.add("23:00");list.add("24:00");
			*/
		}else if("DAY".equals(xValue)){
			for(int i = 1; i <= 31; i++){
				list.add(String.format("%d", i));
			}
			/*
			list.add("1");list.add("2");list.add("3");list.add("4");list.add("5");
			list.add("6");list.add("7");list.add("8");list.add("9");list.add("10");
			list.add("11");list.add("12");list.add("13");list.add("14");list.add("15");
			list.add("16");list.add("17");list.add("18");list.add("19");list.add("20");
			list.add("21");list.add("22");list.add("23");list.add("24");list.add("25");
			list.add("26");list.add("27");list.add("28");list.add("29");list.add("30");
			list.add("31");
			*/
		}else if("MONTH".equals(xValue)){
			for(int i = 1; i <= 12; i++){
				list.add(String.format("%d", i));
			}
			/*
			list.add("1");list.add("2");list.add("3");list.add("4");
			list.add("5");list.add("6");list.add("7");list.add("8");
			list.add("9");list.add("10");list.add("11");list.add("12");
			*/
		}else if("YEAR".equals(xValue)){
			for(int i = (colData-5); i<=colData; i++){
				list.add(i+"");
			}
		}
		return list;
	}
	
	private String setXFormat(String xValue){
		String xFormat = "";
		if("1H".equals(xValue)){
			xFormat = "%H:%M";
		}else if("DAY".equals(xValue)){
			xFormat = "%d";
		}else if("MONTH".equals(xValue)){
			xFormat = "%m";
		}else if("YEAR".equals(xValue)){
			xFormat = "%Y";
		}
		return xFormat;
	}
	
	private String setTickFormat(String xValue){
		String axisXTickFormat = "";
		if("1H".equals(xValue)){
			axisXTickFormat = "%H:%M";
		}else if("DAY".equals(xValue)){
			axisXTickFormat = "%d일";
		}else if("MONTH".equals(xValue)){
			axisXTickFormat = "%m월";
		}else if("YEAR".equals(xValue)){
			axisXTickFormat = "%Y년";
		}
		return axisXTickFormat;
	}
	
	private List<List<String>> set(String dataTitleList, List<List<String>> dataList) throws Exception {
		String[] arrTitle = dataTitleList.split(",");
		
		for(int i = 0; i < dataList.size(); i++){
			dataList.get(i).add(0, arrTitle[i].trim());
		}
		
		return dataList;
	}
	
	private double setGraphDataAvg(List<List<String>> dataList, String avgType){
		double total = 0;
		double size = 0;
		for(List<String> data : dataList){
			if(data.contains(avgType)){
				size = data.size();
				if(size == 1){
					return 0;
				}
				for(int i = 1; i < data.size() ; i++){
					total += Double.parseDouble(data.get(i));
				}
			}
		}
		double avg = Double.parseDouble(String.format("%.2f", total/(size-1)));
		return avg;
	}
	
	private String numberFormat(String number, String type){
		
		String result = "";
		double n = Double.parseDouble(number);
		/*
		if(n > 1000000000){
			result = String.format("%.2f", n / 1000000000);
			units.put(dataTitle, "발전량".equals(dataTitle)? "GWh":"10억");
		}else if(n > 1000000){
			result = String.format("%.2f", n / 1000000);
			units.put(dataTitle, "발전량".equals(dataTitle)? "MWh":"백만원");
		}else if(n > 1000){
			result = String.format("%.2f", n / 1000);
			units.put(dataTitle, "발전량".equals(dataTitle)? "kWh":"천원");
		}else{
			result = String.format("%.2f", n);
			units.put(dataTitle, "발전량".equals(dataTitle)? "Wh":"원");
		}
		*/
		if("YEAR".equals(type)){
			result = String.format("%.2f", n / 1000000);
		}else if("MONTH".equals(type)){
			result = String.format("%.2f", n / 1000);
		}else{
			result = String.format("%.2f", n);
		}
		return result;
	}
}
