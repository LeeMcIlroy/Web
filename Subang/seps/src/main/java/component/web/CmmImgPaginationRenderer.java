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
		
		//firstPageLabel = "<button onclick=\"{0}({1}); return false;\" class=\"f_pre\">처음</button>";
		firstPageLabel = "<a href=\"#\" class=\"no_active\" onclick=\"{0}({1}); return false;\"><img src=\"/assets/img/pager_dl_icon2.png\" alt=\"첫 페이지\" /></a>";
		//previousPageLabel = "<button onclick=\"{0}({1}); return false;\" class=\"pre\">이전</button>";
		previousPageLabel = "<a href=\"#\" class=\"no_active\" onclick=\"{0}({1}); return false;\"><img src=\"/assets/img/pager_dl02_icon2.png\" alt=\"이전 페이지\" /></a>";
		currentPageLabel = "<a href=\"#\" onclick=\"{0}({1}); return false;\" class=\"active\">{0}</a>";
		otherPageLabel = "<a href=\"#\" onclick=\"{0}({1}); return false;\">{2}</a>";
		//nextPageLabel = "<button onclick=\"{0}({1}); return false;\" class=\"next\">다음</button>";
		nextPageLabel = "<a href=\"#\" class=\"no_active\" onclick=\"{0}({1}); return false;\"><img src=\"/assets/img/pager_dr02_icon2.png\" alt=\"다음 페이지\" /></a>";
		//lastPageLabel = "<button onclick=\"{0}({1}); return false;\" class=\"f_next\">마지막</button>";
		lastPageLabel = "<a href=\"#\" class=\"no_active\" onclick=\"{0}({1}); return false;\"><img src=\"/assets/img/pager_dr_icon2.png\" alt=\"마지막 페이지\" /></a>";
		
		/*
		<a href="#" class="no_active"><img src="../../img/pager_dl_icon2.png" alt="첫 페이지" /></a>
		<a href="#" class="no_active"><img src="../../img/pager_dl02_icon2.png" alt="이전 페이지" /></a>

		<a href="#" class="active">1</a>
		<a href="#">2</a>
		<a href="#">3</a>
		<a href="#">4</a>
		<a href="#">5</a>

		<a href="#" class="no_active"><img src="../../img/pager_dr02_icon2.png" alt="다음 페이지" /></a>
		<a href="#" class="no_active"><img src="../../img/pager_dr_icon2.png" alt="마지막 페이지" /></a>
		 */
	}

	@Override
	public void setServletContext(ServletContext servletContext) {
		this.servletContext = servletContext;
		initVariables();
	}
}
