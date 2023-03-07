package uuu.ksc.controller;

import java.io.IOException;
import java.util.ArrayList;
import java.util.List;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import uuu.ksc.entity.Product;
import uuu.ksc.entity.Size;
import uuu.ksc.entity.shoppingCart;
import uuu.ksc.exception.VGBException;
import uuu.ksc.exception.VGBInvalidDataException;
import uuu.ksc.service.ProductService;

/**
 * Servlet implementation class AddCartServlet
 */
@WebServlet("/add_cart.do")
public class AddCartServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public AddCartServlet() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		List<String> errorList =new ArrayList<>();
		HttpSession session = request.getSession();
		//已有CharsetFilter來處理中文編碼
		// 1.取得request的Form Data
		//(右邊要拿前端name=的名稱)
		String productId = request.getParameter("productId");
		String colorName = request.getParameter("color");
		String sizeName = request.getParameter("size");
		String quantity = request.getParameter("quantity");

		//2.檢查並呼叫商業邏輯
		if(productId!=null) {
			ProductService pService = new ProductService();
			try {
				Product p =pService.getProductById(productId);
				if(p!=null&& quantity!=null && quantity.matches("\\d+")) {
					Size size = null;
					if(p.hasSize() && sizeName!=null) {
						if(colorName==null) colorName="";
						size = pService.getProductSize(productId, colorName, sizeName);
						if(size==null) {
							throw new VGBInvalidDataException ("size不正確");
						}
					}
					shoppingCart cart = (shoppingCart)session.getAttribute("cart");
					if(cart ==null) {
						cart = new shoppingCart();
						session.setAttribute("cart", cart);
					}
					cart.addCartItem(p, colorName, size, Integer.parseInt(quantity));
				}
			} catch (VGBException e) {
				this.log("加入購物車失敗",e);
				errorList.add(e.getMessage());
			}
		}else {
			errorList.add("productId不得為null，quantity必為正整數");
		}
		System.err.println(errorList);
		//3.外部轉址/member/cart.jsp
		response.sendRedirect(request.getContextPath()+"/member/cart.jsp");
		return;
		
	}

}
