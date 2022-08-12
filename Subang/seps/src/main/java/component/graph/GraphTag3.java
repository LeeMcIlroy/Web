package component.graph;

import java.io.IOException;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.jsp.JspException;
import javax.servlet.jsp.tagext.TagSupport;

import egovframework.let.utl.fcc.service.EgovStringUtil;

@SuppressWarnings("serial")
public class GraphTag3 extends TagSupport{
	
	private String id = "";
	private List<List<String>> data = new ArrayList<>();
	private String graphType = "bar";
	private String axisXType = "";
	private String dataTitleList = "";
	private String xValue = "";
	private String selectedY2Line = "";
	
	private String avgTarget = "";
	private String avgTitle = "";
	
	public void setId(String id) {
		this.id = id;
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
	@Override
	public int doEndTag() throws JspException {
		try {
			
			pageContext.getOut().write(setGraphScript());
		} catch (IOException e) {
			e.printStackTrace();
		}
		return EVAL_PAGE;
	}
	private String setGraphScript(){
		List<String> colNameList = new ArrayList<>();
		List<String> colValList = new ArrayList<>();
		if("RANK".equals(xValue)){
			colNameList = data.get(0);
			colValList = data.get(1);
			data.remove(0);
		}
		StringBuilder sb = new StringBuilder();
		List<List<String>> resultList = new ArrayList<>();
		try {
			sb.append("<div id=\""+id+"\"></div>");
			sb.append("<script type=\"text/javascript\">\n var "+id+"; \n$(function() { \n");
			sb.append(id+" = c3.generate({	\n");
			sb.append("		bindto : '#"+id+"'	\n");
			sb.append("		, color : { pattern: ['#169c70', '#cbd018', '#f65319'] }	\n");
			sb.append("		, data : {	\n");
			if(!"RANK".equals(xValue)){
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
				
				resultList = set(dataTitleList, tmpData);
				
				
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
			}else{
				sb.append("			x : 'x', \n");
				sb.append("			columns : [	\n");
				sb.append("					['x'");
				for(int i = 0; i < colNameList.size(); i++){
					sb.append(" ,'"+colNameList.get(i)+"' " );
				}
				sb.append("					]	\n");
				sb.append("					,['data0'");
				for(int i = 0; i < colValList.size(); i++){
					sb.append(" ,'"+String.format("%.2f", Double.parseDouble(colValList.get(i)) / 1000)+"' " );
				}
				
				sb.append("					]	\n");
				sb.append("]	\n");
				sb.append("		, labels : true 	\n");
				sb.append("		, names : {	\n");
				sb.append(String.format("data0 : '%s(%s)'", "발전량", "kWh"));
				sb.append("		}	\n");
			}
			
			sb.append("		, type : 'bar'	\n");
			
			if(!EgovStringUtil.isEmpty(selectedY2Line)){
				sb.append("		, axes: {	\n");
				sb.append("			'"+selectedY2Line+"' : 'y2'	\n");
				sb.append("		}	\n");
			}
			
			sb.append("		}	\n");
			
			
			
			
			sb.append("		, axis: {	\n");
			sb.append("			x: {	\n");
			sb.append("				type: '"+axisXType+"'	\n");
			sb.append("			}	\n");
			
			if(!EgovStringUtil.isEmpty(selectedY2Line)) sb.append("			, y2 : { show: true }	\n");
			
			sb.append("		}	\n");
			sb.append("		, point: {	\n");
			sb.append("			show : false	\n");
			sb.append("		}	\n");
			sb.append("		, line : {	\n");
			sb.append("			connectNull : true	\n");
			sb.append("		}	\n");
			if("RANK".equals(xValue)){
				sb.append("		, tooltip : {	\n");
				sb.append("			show : false	\n");
				sb.append("		}	\n");
				sb.append("		, legend : { \n");
				sb.append("			 item  : { \n");
				sb.append("				onclick : function(id){return false;}\n");
				sb.append("			}	\n");
				sb.append("		}	\n");
			}
			
			if(!EgovStringUtil.isEmpty(avgTarget)){
				sb.append("		, grid : {	\n");
				sb.append("			y: {	\n");
				sb.append("				lines: [	\n");
			
				String[] arrAvgTarget = avgTarget.split(",");
				
				String[] arrAvgTitle = avgTitle.split(",");
				
				for(int i = 0; i < arrAvgTarget.length; i++){
					if(i != 0) sb.append(", ");
					
					double avg = setGraphDataAvg(resultList, arrAvgTarget[i].trim());
					sb.append("{value: '"+arrAvgTitle[i].trim()+"'");
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
		if("DAY".equals(xValue)){
			list.add("금일");
			list.add("전일");
			list.add("전년 동일");
		}else if("MONTH".equals(xValue)){
			list.add("당월");
			list.add("전월");
			list.add("전년 동월");
		}else if("YEAR".equals(xValue)){
			list.add("금년");
			list.add("전년");
		}else if("RANK".equals(xValue)){
			for(int i=1; i<=10; i++){
				list.add(i+"위");
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
		}else if("DAY".equals(type)){
			result = String.format("%.2f", n / 1000);
		}else{
			result = String.format("%.2f", n);
		}
		return result;
	}
	
	private Map<String, String> unitsSet(String type){
		Map<String, String> units = new HashMap<>();
		if("YEAR".equals(type)){
			units.put("발전량", "MWh");
			units.put("발전수익", "백만원");
		}else if("DAY".equals(type)){
			units.put("발전량", "kWh");
			units.put("발전수익", "천원");
		}else{
			units.put("발전량", "Wh");
			units.put("발전수익", "원");
		}
		return units;
	}
}
