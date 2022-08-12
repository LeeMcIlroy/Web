package component.web;

import egovframework.rte.ptl.mvc.tags.ui.pagination.AbstractPaginationRenderer;
import javax.servlet.ServletContext;
import org.springframework.web.context.ServletContextAware;

public class CmmImgPaginationRenderer extends AbstractPaginationRenderer implements ServletContextAware {

	private ServletContext servletContext;

	public CmmImgPaginationRenderer() {
		// TODO Auto-generated constructor stub
	}
	/**
	* PaginationRenderer
	*
	* @see 개발프레임웍크 실행환경 개발팀
	*/
	public void initVariables() {
		firstPageLabel = "<a href=\"#\" onclick=\"{0}({1}); return false;\" class=\"pg_first\">처음</a>";
		previousPageLabel = "<a href=\"#\" onclick=\"{0}({1}); return false;\" class=\"pg_prev\">이전</a>";
		currentPageLabel = "<a href=\"#\" class=\"active\">{0}</a>";
		otherPageLabel = "<a href=\"#\" onclick=\"{0}({1}); return false;\">{2}</a>";
		nextPageLabel = "<a href=\"#\" onclick=\"{0}({1}); return false;\" class\"pg_next\">다음</a>";
		lastPageLabel = "<a href=\"#\" onclick=\"{0}({1}); return false;\" class=\"pg_last\">마지막</a>";
		
		/*
		<a href="#" class="pg_first">처음</a>
		<a href="#" class="pg_prev">이전</a>
		<a href="#" class="active">1</a>
		<a href="#">2</a>
		<a href="#">3</a>
		<a href="#">4</a>
		<a href="#">5</a>
		<a href="#">6</a>
		<a href="#">7</a>
		<a href="#">8</a>
		<a href="#">9</a>
		<a href="#">10</a>
		<a href="#" class="pg_next">다음</a>
		<a href="#" class="pg_last">마지막</a>
		*/
	}

	@Override
	public void setServletContext(ServletContext servletContext) {
		this.servletContext = servletContext;
		initVariables();
	}
}