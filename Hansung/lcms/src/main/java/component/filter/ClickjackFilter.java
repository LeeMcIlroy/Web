package component.filter;

import java.io.IOException;

import javax.servlet.Filter;
import javax.servlet.FilterChain;
import javax.servlet.FilterConfig;
import javax.servlet.ServletException;
import javax.servlet.ServletRequest;
import javax.servlet.ServletResponse;
import javax.servlet.http.HttpServletResponse;

import egovframework.let.utl.fcc.service.EgovStringUtil;

public class ClickjackFilter implements Filter {

	/**
	 * X-Frame_Options value
	 * 	DENY 			: 해당 페이지는 frame을 표시할수 없다.
	 * 	SAMEORIGIN 		: 해당 페이지와 동일한 orgin에 해당하는 frame만 표시할 수 있다.
	 * 	ALLOW-FROM uri	: 해당 페이지는 지정된 orgin에 해당하는 frame만 표시할 수 있다.
	 */
	private String mode = "DENY";
	
    /**
     * Add X-FRAME-OPTIONS response header to tell IE8 (and any other browsers who
     * decide to implement) not to display this content in a frame. For details, please
     * refer to http://blogs.msdn.com/sdl/archive/2009/02/05/clickjacking-defense-in-ie8.aspx.
     */
	@Override
	public void init(FilterConfig filterConfig) throws ServletException {
		String configMode = filterConfig.getInitParameter("mode");
		if(!EgovStringUtil.isEmpty(configMode)) mode = configMode;
	}

	@Override
	public void doFilter(ServletRequest request, ServletResponse response, FilterChain chain) throws IOException, ServletException {
		HttpServletResponse res = (HttpServletResponse) response;
		res.addHeader("X-FRAME-OPTIONS", mode);
		chain.doFilter(request, response);
	}

	@Override
	public void destroy() {
		// destroy();
	}

}
