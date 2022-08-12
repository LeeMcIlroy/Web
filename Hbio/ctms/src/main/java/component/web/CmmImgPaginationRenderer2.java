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
		firstPageLabel = "<a href=\"#\" onclick=\"{0}({1}); return false;\" class=\"no_active\"><img src=\"/qxsepmny/center/img/pager_dl_icon.gif\" alt=\"처음\" /></a>";
		previousPageLabel = "<a href=\"#\" onclick=\"{0}({1}); return false;\" class=\"no_active\"><img src=\"/qxsepmny/center/img/pager_dl02_icon.gif\" alt=\"이전\" /></a>";
		currentPageLabel = "<a href=\"#\" onclick=\"{0}({1}); return false;\" class=\"active\">{0}</a>";
		otherPageLabel = "<a href=\"#\" onclick=\"{0}({1}); return false;\" class=\"\">{2}</a>";
		nextPageLabel = "<a href=\"#\" class=\"no_active\" onclick=\"{0}({1}); return false;\" ><img src=\"/qxsepmny/center/img/pager_dr02_icon.gif\" alt=\"다음\" /></a>";
		lastPageLabel = "<a href=\"#\" class=\"no_active\" onclick=\"{0}({1}); return false;\" ><img src=\"/qxsepmny/center/img/pager_dr_icon.gif\" alt=\"마지막\" /></a>";
		
		/*
		<a href="#" class="pg_first"><img src="/qxsepmny/center/img/btn_first.gif" alt="처음" /></a>
		<a href="#" class="pg_prev"><img src="/qxsepmny/center/img/btn_prev.gif" alt="이전" /></a>
		<a href="#" class="num active">1</a>
		<a href="#" class="num">2</a>
		<a href="#" class="num">3</a>
		<a href="#" class="num">4</a>
		<a href="#" class="num">5</a>
		<a href="#" class="pg_next"><img src="/qxsepmny/center/img/btn_next.gif" alt="다음" /></a>
		<a href="#" class="pg_last"><img src="/qxsepmny/center/img/btn_last.gif" alt="마지막" /></a>
		 */
	}

	@Override
	public void setServletContext(ServletContext servletContext) {
		this.servletContext = servletContext;
		initVariables();
	}
}
