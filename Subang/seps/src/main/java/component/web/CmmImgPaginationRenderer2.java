package component.web;

import egovframework.rte.ptl.mvc.tags.ui.pagination.AbstractPaginationRenderer;
import javax.servlet.ServletContext;
import org.springframework.web.context.ServletContextAware;

public class CmmImgPaginationRenderer2 extends AbstractPaginationRenderer implements ServletContextAware {

	private ServletContext servletContext;

	public CmmImgPaginationRenderer2() {
		// TODO Auto-generated constructor stub
	}
	/**
	* PaginationRenderer
	*
	* @see 개발프레임웍크 실행환경 개발팀
	*/
	public void initVariables() {
		firstPageLabel = "<button onclick=\"{0}({1}); return false;\" class=\"f_pre\">처음</button>";
		previousPageLabel = "<button onclick=\"{0}({1}); return false;\" class=\"pre\">이전</button>";
		currentPageLabel = "<a href=\"#\" onclick=\"{0}({1}); return false;\" class=\"active\">{0}</a>";
		otherPageLabel = "<a href=\"#\" onclick=\"{0}({1}); return false;\">{2}</a>";
		nextPageLabel = "<button onclick=\"{0}({1}); return false;\" class=\"next\">다음</button>";
		lastPageLabel = "<button onclick=\"{0}({1}); return false;\" class=\"f_next\">마지막</button>";
		
		/*
		<button class="pre">이전</button>
		<a href="#">1</a>
		<a href="#">2</a>
		<a href="#">3</a>
		<button class="next">다음</button>
		 */
	}

	@Override
	public void setServletContext(ServletContext servletContext) {
		this.servletContext = servletContext;
		initVariables();
	}
}
