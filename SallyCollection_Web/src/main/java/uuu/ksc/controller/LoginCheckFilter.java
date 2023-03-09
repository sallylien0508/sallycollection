package uuu.ksc.controller;

import java.io.IOException;
import javax.servlet.Filter;
import javax.servlet.FilterChain;
import javax.servlet.FilterConfig;
import javax.servlet.ServletException;
import javax.servlet.ServletRequest;
import javax.servlet.ServletResponse;
import javax.servlet.annotation.WebFilter;
import javax.servlet.http.HttpFilter;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import uuu.ksc.entity.Customer;

/**
 * Servlet Filter implementation class LoginCheckFilter
 */
@WebFilter("/member/*")
public class LoginCheckFilter extends HttpFilter implements Filter {
       
    /**
     * @see HttpFilter#HttpFilter()
     */
    public LoginCheckFilter() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see Filter#destroy()
	 */
	public void destroy() {
		// TODO Auto-generated method stub
	}

	/**
	 * @see Filter#doFilter(ServletRequest, ServletResponse, FilterChain)
	 */
	public void doFilter(HttpServletRequest request, HttpServletResponse response, FilterChain chain) throws IOException, ServletException {
		HttpSession session = request.getSession();
		Customer member = (Customer )session.getAttribute("member");
		if(member!=null) {
			chain.doFilter(request, response);
		}else {
			System.out.println(request.getRequestURI());//TODO: 登入成功要回這個網址
			response.sendRedirect(request.getContextPath() + "/login.jsp#tab1");			
		}
	}
	//TODO 登入成功後要回傳這個網址request.getRequestURI()
//	public void doFilter(HttpServletRequest request, HttpServletResponse response, FilterChain chain) throws IOException, ServletException {
//		HttpSession session = request.getSession();
//		Customer member =(Customer)session.getAttribute("member");
//		if(member!=null) {
//			chain.doFilter(request, response);
//		}else {
//		response.sendRedirect(request.getContextPath()+"/login.jsp#tab1");
//		}if(member!=null){
//			System.out.println(request.getRequestURI());
//			response.sendRedirect(request.getRequestURI());
//		}
//	}
	/**
	 * @see Filter#init(FilterConfig)
	 */
	public void init(FilterConfig fConfig) throws ServletException {
		// TODO Auto-generated method stub
	}

}
