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

import uuu.ksc.entity.BloodType;
import uuu.ksc.entity.Customer;
import uuu.ksc.exception.VGBException;
import uuu.ksc.exception.VGBInvalidDataException;
import uuu.ksc.service.CustomerService;

/**
 * Servlet implementation class RegisterServlet
 */
@WebServlet("/register.do")
public class RegisterServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public RegisterServlet() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
    	List<String> errors = new ArrayList<>();
    	request.setCharacterEncoding("utf-8");
		//1.讀取request中的FormData資料,並檢查(id,email,password,name,phone,photo,birth,gender)       
        String id= request.getParameter("id");
        String email= request.getParameter("email");
        String password= request.getParameter("password");
        String name = request.getParameter("name");
        
        String phone= request.getParameter("phone");
        //String photo= request.getParameter("photo");
        String birthday= request.getParameter("birthday");
        String gender= request.getParameter("gender");
        
        //TODO: 檢查必要欄位: id,name, email, password       
        if(id==null || (id=id.trim()).length()==0) {
            errors.add("必須輸入正確的id");
        }
        if(email==null || (email=email.trim()).length()==0) {
            errors.add("必須輸入email");
        }      
        if(password==null || password.length()==0) {
            errors.add("必須輸入密碼");
        }    
        if(name==null || (name=name.trim()).length()==0) {
            errors.add("必須輸入姓名");
        }        
//        if(phone==null || (phone=phone.trim()).length()==0) {
//            errors.add("必須輸入手機");
//        }   
//        if(photo==null || (photo=photo.trim()).length()==0) {
//            errors.add("必須輸入驗證碼");
//        }
//        if(birthday==null || (birthday=birthday.trim()).length()==0) {
//            errors.add("必須輸入生日");
//        }
//        if(gender==null || (gender=gender.trim()).length()!=1) {
//            errors.add("必須輸入性別");
//        }

        //2.若無誤，呼叫商業邏輯
        if(errors.isEmpty()) {
            Customer c = new Customer();
            try {
                c.setId(id);
                c.setEmail(email);
                c.setPassword(password);
                c.setName(name);

                //c.setphoto(photo);
                c.setPhone(phone);
                c.setBirthday(birthday);
                c.setGender(gender.charAt(0));

                CustomerService service = new CustomerService();
                service.register(c);

                //3.1 顯示註冊成功畫面
            RequestDispatcher dispatcher =request.getRequestDispatcher("register_ok.jsp");
			request.setAttribute("rmember",c);
			request.setAttribute("rmsg","註冊");
			dispatcher.forward(request,response);
    			
            return;
            }catch(VGBInvalidDataException ex){
            	errors.add(ex.getMessage());//for user
            }catch(VGBException e){
              	errors.add(e.getMessage()+",請聯絡系統管理員");//for user
            	this.log(e.getMessage(),e);//for admin,developer,tester 
            }catch(Exception e) {
            	errors.add("會員註冊失敗:"+e.getMessage());
                this.log("會員註冊發生非預期錯誤"+e.getMessage(), e);
            }
            	
            }
       
               
	        //3.2 顯示註冊失敗畫面
	    	RequestDispatcher dispatcher =request.getRequestDispatcher("login.jsp");
			request.setAttribute("register_errors",errors);
			dispatcher.forward(request,response);
	
		}

}

//3.1 顯示註冊成功畫面
//  response.setContentType("text/html");
//response.setCharacterEncoding("UTF-8");
////以上兩行，若在getwriter前未設定characterEncoding，預設為iso-8859-1
//try (PrintWriter out = response.getWriter()) {
//    out.println("<!DOCTYPE html>");
//    out.println("<html>");
//    out.println("<head>");
//    out.println("<title>註冊成功</title>");
//    out.println("<meta http-equiv=\"refresh\" content=\"5; url = ./index.html\">");
//    out.println("</head>");
//    out.println("<body>");
//    out.println("<h1>註冊成功," + c.getName() + "</h1>");
//    out.println("<p>5秒後回首頁</p>");
//    out.println("</body>");
//    out.println("</html>");
//}
//3.2 顯示註冊失敗畫面
//response.setContentType("text/html");
//response.setCharacterEncoding("UTF-8");
//try (PrintWriter out = response.getWriter()) {
//    out.println("<!DOCTYPE html>");
//    out.println("<html>");
//    out.println("<head>");
//    out.println("<title>註冊失敗</title>");
//    out.println("<meta http-equiv=\"refresh\" content=\"5; url = ./index.html\">");
//    out.println("</head>");
//    out.println("<body>");
//    out.println("<h1>" + errors + "</h1>");
//    out.println("<p>5秒後回首頁</p>");
//    out.println("</body>");
//    out.println("</html>");
//}
