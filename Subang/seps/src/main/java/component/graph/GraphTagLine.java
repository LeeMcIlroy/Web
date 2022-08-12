package component.graph;

import java.io.IOException;
import java.util.ArrayList;
import java.util.List;

import javax.servlet.jsp.JspException;
import javax.servlet.jsp.tagext.TagSupport;

import egovframework.rte.psl.dataaccess.util.EgovMap;
import valueObject.GraphVO;

@SuppressWarnings("serial")
public class GraphTagLine extends TagSupport {

	private String id = "";
	private List<GraphVO> data = new ArrayList<>();
	private String xType = "";
	public void setId(String id) {
		this.id = id;
	}
	public void setData(List<GraphVO> data) {
		this.data = data;
	}
	public void setxType(String xType) {
		this.xType = xType;
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
			sb.append("<script type=\"text/javascript\">\n var "+id+"; \n$(function() { \n");
			sb.append(id+" = c3.generate({	\n");
			sb.append("		bindto : '#"+id+"'	\n");
			sb.append("		, color : { pattern: ['#169c70', '#cbd018', '#f65319'] }	\n");
			sb.append("		, data : {	\n");
			sb.append("			x : 'x'	\n");
			sb.append("			, xFormat : '"+setXFormat(xType)+"'	\n");
			sb.append("			, columns : [	\n");
			sb.append("					[ 'x' 	\n");
			for(GraphVO vo : data){
				sb.append(String.format(", '%s'", vo.getxCol()));
			}
			sb.append("					]	\n");
			sb.append("					, [ '전류합'  	\n");
			for(GraphVO vo : data){
				sb.append(String.format(", '%s'", vo.getxVal()));
			}
			sb.append("					]	\n");
			sb.append("			]	\n");
			sb.append("		, type : 'line'	\n");
			sb.append("		}	\n");
			sb.append("		, legend : { show : false }	\n");
			sb.append("		, axis: {	\n");
			sb.append("			x: {	\n");
			sb.append("				type: 'timeseries'	\n");
			sb.append("				, tick: {	\n");
			sb.append("					format: '"+ setTickFormat(xType) +"'	\n");
			sb.append("				}	\n");
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
	
	private String setXFormat(String xType){
		String xFormat = "";
		if("HOUR".equals(xType)){
			xFormat = "%H";
		}else if("DATE".equals(xType)){
			xFormat = "%Y-%m-%d";
		}else if("MONTH".equals(xType)){
			xFormat = "%Y-%m";
		}else if("YEAR".equals(xType)){
			xFormat = "%Y";
		}
		return xFormat;
	}
	
	private String setTickFormat(String xType){
		String tickFormat = "";
		if("HOUR".equals(xType)){
			tickFormat = "%H시";
		}else if("DATE".equals(xType)){
			tickFormat = "%d일";
		}else if("MONTH".equals(xType)){
			tickFormat = "%m월";
		}else if("YEAR".equals(xType)){
			tickFormat = "%Y년";
		}
		return tickFormat;
	}
}
