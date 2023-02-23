package uuu.ksc.controller;

import java.io.IOException;
import java.io.PrintWriter;
import java.util.ArrayList;
import java.util.List;
import java.util.logging.Level;
import java.util.logging.Logger;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import uuu.ksc.entity.Customer;
import uuu.ksc.exception.LoginFailedException;
import uuu.ksc.exception.VGBException;
import uuu.ksc.service.CustomerService;
import javax.servlet.http.HttpSession;

/**
 * Servlet implementation class LoginServlet
 */
@WebServlet(urlPatterns="/login.do")
public class LoginServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public LoginServlet() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
    @Override
    //doPost 伺服器規定的名稱，當初new設定的
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
    	List<String> errors = new ArrayList<>();
    	HttpSession session =request.getSession();//有舊的session用舊的，沒有會新增一個
    	request.setCharacterEncoding("utf-8");//這邊欄位都沒有中文所以不用加
    	// 1.取得request 中form data(id,password,captcha)
    	String id = request.getParameter("id");
    	String password = request.getParameter("password");
    	String captcha = request.getParameter("captcha");
    	
    	//TODO: 檢查有無錯誤
    	if(id ==null || (id =id.trim()).length()==0) {
    		errors.add("必須輸入帳號或email");
    	}
    	if(password ==null || password.length()==0) {
    		errors.add("必須輸入帳號或email");
    	}
    	if(captcha ==null || (captcha=captcha.trim()).length()==0) {
    		errors.add("必須輸入帳號或email");
    	}else {
    		String oldCaptcha= (String)session.getAttribute("LoginCaptchaServlet");
    				if(!captcha.equalsIgnoreCase(oldCaptcha)){
    			errors.add("驗證碼不正確");
    		}
    	}
    	session.removeAttribute("LoginCaptchaServlet");//for 資安考量
    	//2.若檢查無誤，則建立CustomerService物件，並呼叫商業邏輯login
    	if(errors.isEmpty()) {
    	CustomerService service = new CustomerService();
    	try {
			Customer c = service.login(id,password);
			
			//3.1 登入成功：內部轉交（forward）/login_ok.jsp
			RequestDispatcher dispatcher =request.getRequestDispatcher("login_ok.jsp");
			session.setAttribute("member",c);
			request.setAttribute("msg","登入");
			dispatcher.forward(request,response);
			
            return;
    	}catch (LoginFailedException e) {	
    		//this.log(e.getMessage());
    		errors.add(e.getMessage());//for user
		}catch (VGBException e) {
			this.log(e.getMessage(),e);//for admin, tester,developer
			errors.add(e.getMessage()+":"+e+"請聯絡系統管理員");//for user
		}catch(Exception e){
			this.log("登入失敗，系統發生非預期錯誤",e);//for admin, tester,developer
			errors.add("系統發生錯誤"+":"+e+"請聯絡系統管理員");//for user
		}			
	}
    	//3.2 登入失敗：內部轉交（forward）/login.jsp
    	RequestDispatcher dispatcher =request.getRequestDispatcher("login.jsp");
		request.setAttribute("errors",errors);
		dispatcher.forward(request,response);
		

    }

}
//(舊)3.1 產生成功的html
//response.setContentType("text/html");
//response.setCharacterEncoding("UTF-8");
////以上兩行，若在getwriter前未設定characterEncoding，預設為iso-8859-1
//try (PrintWriter out = response.getWriter()) {
//    out.println("<!DOCTYPE html>");
//    out.println("<html>");
//    out.println("<head>");
//    out.println("<title>登入成功</title>");
//    out.println("<meta http-equiv=\"refresh\" content=\"5; url = ./index.html\">");
//    out.println("</head>");
//    out.println("<body>");
//    out.println("<h1>登入成功," + c.getName() + "</h1>");
//    out.println("<p>5秒後回首頁</p>");
//    out.println("</body>");
//    out.println("</html>");
//}


//3.2 登入失敗：產生失敗的html
//response.setContentType("text/html");
//response.setCharacterEncoding("UTF-8");
//try (PrintWriter out = response.getWriter()) {
//    out.println("<!DOCTYPE html>");
//    out.println("<html>");
//    out.println("<head>");
//    out.println("<title>登入失敗</title>");
//    out.println("<meta http-equiv=\"refresh\" content=\"5; url = ./index.html\">");
//    out.println("</head>");
//    out.println("<body>");
//    out.println("<h1>" + errors + "</h1>");
//    out.println("<p>5秒後回首頁</p>");
//    out.println("</body>");
//    out.println("</html>");
//}