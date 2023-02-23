package uuu.ksc.controller;

import java.io.IOException;

import javax.servlet.DispatcherType;
import javax.servlet.Filter;
import javax.servlet.FilterChain;
import javax.servlet.FilterConfig;
import javax.servlet.ServletException;
import javax.servlet.ServletRequest;
import javax.servlet.ServletResponse;
import javax.servlet.annotation.WebFilter;
import javax.servlet.http.HttpFilter;

/**
 * Servlet Filter implementation class CharsetFilter
 */
@WebFilter(urlPatterns = { "*.jsp", "*.do" },dispatcherTypes = {DispatcherType.REQUEST,DispatcherType.ERROR})
public class CharsetFilter  implements Filter {
       
    /**
     * @see HttpFilter#HttpFilter()
     */
    public CharsetFilter() {
        super();
    }

//	/**
//	 * @see Filter#destroy()
//	 */
//	public void destroy() {
//	}

	/**
	 * @see Filter#doFilter(ServletRequest, ServletResponse, FilterChain)
	 */
	public void doFilter(ServletRequest request, ServletResponse response, FilterChain chain) throws IOException, ServletException {
		request.setCharacterEncoding("UTF-8");
		request.getParameterNames();
		//鎖定request中body的編碼，讀取表單前做請求編碼
		
		response.setCharacterEncoding("UTF-8");
		response.getWriter();//鎖定response中body的編碼，

		// pass the request along the filter chain
		chain.doFilter(request, response);
		//39行交棒給原來的jsp或selevelet，用延伸檔名分這兩個
	}

//	/**
//	 * @see Filter#init(FilterConfig)
//	 */
//	public void init(FilterConfig fConfig) throws ServletException {
//	}

}
