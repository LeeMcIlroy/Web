package component.web.tag;

import javax.servlet.jsp.JspException;
import javax.servlet.jsp.tagext.TagSupport;

@SuppressWarnings("serial")
public class ContentSubTag extends TagSupport{
	private String content = "";
	private int length = 0;

	public String getContent() {
		return content;
	}

	public void setContent(String content) {
		this.content = content;
	}

	public int getLength() {
		return length;  
	}

	public void setLength(int length) {
		this.length = length;
	}

	public int doStartTag() throws JspException {
		try {
			String temp = content;

			temp = removeHtmlTag(temp);
			
			if( length>0 ){
				
				// 지정 길이 보다 출력 String 길이가 짧으면 그냥 출력
				if (temp.length() <= length || temp == null) {
					pageContext.getOut().println(temp);
					return SKIP_BODY;
				}

				// 바이트 길이 만큼 출력후 뒤에 한글자를 날림
				temp = temp.substring(0, length) + "...";
			}

			// SPAN 태그로 출력
			pageContext.getOut().println(temp);
		} catch (Exception e) {
			e.printStackTrace();
			throw new JspException();
		}

		return SKIP_BODY;
	}

	private String removeHtmlTag(String paramContent) {
		String str = paramContent;
		str = str.replace("&#39;", "'").replace("&nbsp;", " ").replace("&rsquo;", "'").replace("&lsquo;", "'").replace("&rarr;", "→").replace("&#65378;", "｢").replace("&#65379;", "｣");
		str = str.replaceAll("<(/)?([a-zA-Z]*)(\\s[a-zA-Z]*=[^>]*)?(\\s)*(/)?>", "");
		return str;
	}
}
