package component.graph;

import java.io.IOException;
import java.util.ArrayList;
import java.util.List;

import javax.servlet.jsp.JspException;
import javax.servlet.jsp.tagext.BodyTagSupport;

import egovframework.let.utl.fcc.service.EgovStringUtil;
import valueObject.GraphVO;

@SuppressWarnings("serial")
public class GraphTag2 extends BodyTagSupport{

	private String id = "";
	private int width = 1000;
	private int height = 1000;
	private List<List<GraphVO>> data = new ArrayList<>();
	private String graphType = "spline";
	private String axisXType = "";
	private String axisXTickFormat = "";
	private String dataTitleList = "";
	private String xValue = "";
	private String selectedY2Line = "";

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
	public void setData(List<List<GraphVO>> data) {
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
		StringBuilder sb = new StringBuilder();
		try {
			sb.append("<div id=\""+id+"\"></div>");
			/*
			sb.append("<script type=\"text/javascript\">	\n");
			sb.append("	var "+id+" = c3.generate({	\n");
			*/
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
			
			sb.append("					[ 'x'	\n");
			List<GraphVO> tmp = data.get(0);
			for(int i = 0; i < tmp.size(); i++){
				sb.append(", '"+tmp.get(i).getxCol()+"'");
			}
			sb.append("					]	\n");
			
			List<List<String>> tmpData = new ArrayList<>();
			
			for(List<GraphVO> arr : data){
				List<String> rs = new ArrayList<>();
				for(GraphVO vo : arr){
					rs.add(vo.getxVal());
				}
				tmpData.add(rs);
			}
			
			/*
			for(List<String> result: resultList){
				sb.append("				, [	\n");
				for(int i = 0; i < result.size(); i++){
					if(i != 0) sb.append(", ");
					sb.append("'"+result.get(i)+"'");
				}
				sb.append("				]	\n");
			}
			*/
			
			for(int i = 0; i < tmpData.size(); i++){
				sb.append("				, [	\n");
				sb.append("'data"+i+"'");
				for(int x = 0; x < tmpData.get(i).size(); x++){
					sb.append(", "+tmpData.get(i).get(x).toString());
				}
				sb.append("				]	\n");
			}
			
			sb.append("			]	\n");
			
			sb.append("		, names : {	\n");
			String [] titleArr = dataTitleList.split(",");
			for(int i = 0; i < titleArr.length; i++){
				if(i != 0) sb.append(", ");
				sb.append(String.format("data%d : '%s'", i, titleArr[i].trim()));
			}
			
			sb.append("		}	\n");
			
			sb.append("		, type : '"+graphType+"'	\n");
			
			if(!EgovStringUtil.isEmpty(selectedY2Line)){
				int tmpNum = 0;
				for(int i = 0; i < titleArr.length; i++){
					if(selectedY2Line.equals(titleArr[i])) tmpNum = i;
				}
				
				sb.append("		, axes: {	\n");
				sb.append("			'"+String.format("data%d", tmpNum)+"' : 'y2'	\n");
				sb.append("		}	\n");
			}
			
			sb.append("		}	\n");
			
			if("bar".equals(graphType)){
				sb.append(", bar : { width : { ratio : 0.3 } }");
			}
			
			sb.append("		, axis: {	\n");
			sb.append("			x: {	\n");
			sb.append("				type: '"+axisXType+"'	\n");
			sb.append("				, tick: {	\n");
			sb.append("					format: '"+(EgovStringUtil.isEmpty(axisXTickFormat)? setTickFormat(xValue) : axisXTickFormat)+"'	\n");
			sb.append("				}	\n");
			sb.append("			}	\n");
			
			if(!EgovStringUtil.isEmpty(selectedY2Line)) sb.append("			, y2 : { show: true }	\n");
			
			sb.append("		}	\n");
			sb.append("		, point: {	\n");
			sb.append("			show : false	\n");
			sb.append("		}	\n");
			sb.append("		, line : {	\n");
			sb.append("			connectNull : true	\n");
			sb.append("		}	\n");
			
			
			if(!EgovStringUtil.isEmpty(avgTarget)){
				List<List<String>> resultList = set(dataTitleList, tmpData);
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
			
			sb.append("		, tooltip : {	\n");
			sb.append("			format : {	\n");
			sb.append("				value : d3.format(',')	\n");
			sb.append("			}	\n");
			sb.append("			, order : function(t1, t2) {	\n");
			sb.append("				return t1.id > t2.id;	\n");
			sb.append("			}	\n");
			sb.append("		}	\n");
			
			sb.append("	});	\n");
			sb.append("});</script>");
		
		} catch (Exception e) {
			e.printStackTrace();
			sb.setLength(0);
			sb.append("데이터가 존재하지 않습니다.");
		}
		
		return sb.toString();
	}
	
	private String setXFormat(String xValue){
		String xFormat = "";
		if("1H".equals(xValue)){
			xFormat = "%H";
		}else if("DAY".equals(xValue)){
			xFormat = "%Y-%m-%d";
		}else if("MONTH".equals(xValue)){
			xFormat = "%Y-%m";
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
			axisXTickFormat = "%y.%m.%d";
		}else if("MONTH".equals(xValue)){
			axisXTickFormat = "%Y년 %m월";
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
				for(int i = 1; i < data.size() ; i++){
					total += Double.parseDouble(data.get(i));
				}
			}
		}
		double avg = Double.parseDouble(String.format("%.2f", total/(size-1)));
		return avg;
	}
}
