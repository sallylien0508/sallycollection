package uuu.ksc.controller;

import java.io.IOException;
import java.io.PrintWriter;
import java.util.ArrayList;
import java.util.List;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import uuu.ksc.entity.Customer;
import uuu.ksc.exception.VGBException;
import uuu.ksc.exception.VGBInvalidDataException;
import uuu.ksc.service.CustomerService;

/**
 * Servlet implementation class RegisterServlet
 */
@WebServlet("/member/update.do")
public class UpdateMemberServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public UpdateMemberServlet() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		List<String> errors = new ArrayList<>();
		request.setCharacterEncoding("UTF-8");
		HttpSession session = request.getSession();
		Customer member = (Customer)session.getAttribute("member");
		if(member==null) {
			response.sendRedirect("../login.jsp");
			return;
		}
		//1.讀取request中的FormData資料,並檢查
		//   (id,email,password1,password2,name,birthday,gender, captcha)
		//   (address,phone,bloodType,subscribed)
		String id = request.getParameter("id");
		String email = request.getParameter("email");
		String name = request.getParameter("name");
		String password = request.getParameter("password");//原來的密碼
		String birthday = request.getParameter("birthday");
		String gender = request.getParameter("gender");
		String phone = request.getParameter("phone");
		
		if(!member.getId().equals(id)) {
			errors.add("不得竄改帳號");
		}
		
		if(password ==null || password.length()==0 
				|| !member.getPassword().equals(password)) {
			errors.add("密碼不正確");
		}
		
		if(email==null || (email=email.trim()).length()==0) {
			errors.add("必須輸入email");
		}
		
		if(name==null || (name=name.trim()).length()==0) {
			errors.add("必須輸入name");
		}
		
		
		if(birthday==null || (birthday=birthday.trim()).length()==0) {
			errors.add("必須輸入生日");
		}
		
		if(gender==null || (gender=gender.trim()).length()!=1) {
			errors.add("必須輸入性別");
		}		
		
		
		String changePwd = request.getParameter("changePwd");
		if(changePwd!=null) {			
			String password2 = request.getParameter("password2");
			if(password==null || password.length()==0) {
				errors.add("必須輸入密碼");
			}else if(!password.equals(password2)){
				errors.add("必須輸入一致的新密碼與確認密碼");
			}
		}



		
		//2. 若無誤，呼叫商業邏輯
		if(errors.isEmpty()) {		
			Customer c;
			try {
				c = member.getClass().newInstance(); //TODO:
			} catch (IllegalAccessException|InstantiationException e) {
				c = new Customer();
			}
			
			try {
				c.setId(member.getId());
				c.setEmail(email);
				c.setName(name);
				c.setPassword(changePwd!=null?password:member.getPassword());


				c.setBirthday(birthday);
				c.setGender(gender.charAt(0));
				
				c.setPhone(phone);						
				
				CustomerService service = new CustomerService();
				service.update(c);
				
				//將session中的會員更新為新資料
				member = service.login(c.getId(), c.getPassword());
				session.setAttribute("member", member);
				
				//3.1 修改成功: 外部轉交(redirect)首頁				
				response.sendRedirect("../");
	            return;
			}catch(VGBInvalidDataException ex) {
				errors.add(ex.getMessage()); //for users
			}catch(VGBException ex) {
				errors.add(ex.getMessage() + ",請聯絡系統管理人員"); //for users
				this.log(ex.getMessage(), ex); //for admin, developer, tester
			}catch(Exception ex) {				
				errors.add("註冊失敗，系統發生錯誤"+ex+",請聯絡系統管理人員"); //for users
				this.log("註冊失敗，系統發生非預期錯誤", ex); //for admin, developer, tester
			}
			
		}		

		//3.2 失敗則內部轉交給update.jsp
		RequestDispatcher dispatcher = 
				request.getRequestDispatcher("update.jsp");
		request.setAttribute("errors", errors);
		dispatcher.forward(request, response);
        //return;
	}

}
