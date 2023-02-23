package uuu.ksc.controller;

import java.io.IOException;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

/**
 * Servlet implementation class LogoutServlet
 */
@WebServlet("/logout.do")
//http://localhost:8080/vgb
public class LogoutServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public LogoutServlet() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		HttpSession session = request.getSession(false);//取得之前已經登入過產生的session，不要建立新的
		//1.取得表單資料（無）,2.有session則登出
		if(session!=null) {
			// 登出
			session.invalidate();
		}
		//3.內部轉交接給首頁
		//但以下轉交後會看到網址是/logout.do，所以不要這樣做
//		RequestDispatcher dispatcher = request.getRequestDispatcher("/");
//		dispatcher.forward(request, response);
		
		//所以要外部轉址，外部轉址一定要session不能用request因為/loginout.do先傳給browser再到url(首頁)
		//作法二：外部轉址(response.sendRedirect(url字串))給首頁
		response.sendRedirect("./");//request.getContextPath() or ./
		
		
	}

}
