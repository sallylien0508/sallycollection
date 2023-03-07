package uuu.ksc.test;

import uuu.ksc.entity.Customer;
import uuu.ksc.entity.Product;
import uuu.ksc.entity.Size;
import uuu.ksc.entity.shoppingCart;
import uuu.ksc.exception.VGBException;
import uuu.ksc.exception.VGBInvalidDataException;
import uuu.ksc.service.CustomerService;
import uuu.ksc.service.ProductService;

public class TestShoppingCart {
	public static void main(String[] args) {
		CustomerService cService = new CustomerService();
		ProductService pService = new ProductService();
		try {
			Customer member = cService.login("A123123123", "12345lkj");
			shoppingCart cart = new shoppingCart();
			
			cart.setMember(member);
//			{ //product Id 1
//				
//				String productId = "1"; //request.getParameter("productId")
//				String colorName = null; //request.getParameter("color")
//				String sizeName = null; //request.getParameter("sizeName")				
//				
//				Product p = pService.getProductById(productId);
//				Size size = null;
//				if(p.hasSize() && sizeName!=null) {
//					if(colorName==null) colorName="";
//					size = pService.getProductSize(productId, colorName, sizeName);
//					if(size==null) {
//						throw new VGBInvalidDataException ("size不正確");
//					}
//				}
//				
//				//System.out.println(p); //for test
//				cart.addCartItem(p, colorName, size, 1);				
//			}
			
//			{ //product Id 1
//				String productId = "1"; //request.getParameter("productId")
//				String colorName = null; //request.getParameter("color")
//				String sizeName = null; //request.getParameter("sizeName")				
//				
//				Product p = pService.getProductById(productId);
//				Size size = null;
//				if(p.hasSize() && sizeName!=null) {
//					if(colorName==null) colorName="";
//					size = pService.getProductSize(productId, colorName, sizeName);
//					if(size==null) {
//						throw new VGBInvalidDataException ("size不正確");
//					}
//				}
//				
//				//System.out.println(p); //for test
//				cart.addCartItem(p, colorName, size, 1);
//				System.out.println(cart);			
//			}
			
//			{ //product Id 11, 紅
//				String productId = "11"; //request.getParameter("productId")
//				String colorName = "紅"; //request.getParameter("color")
//				String sizeName = null; //request.getParameter("sizeName")				
//				
//				Product p = pService.getProductById(productId);
//				Size size = null;
//				if(p.hasSize() && sizeName!=null) {
//					if(colorName==null) colorName="";
//					size = pService.getProductSize(productId, colorName, sizeName);
//					if(size==null) {
//						throw new VGBInvalidDataException ("size不正確");
//					}
//				}
//				
//				//System.out.println(p); //for test
//				cart.addCartItem(p, colorName, size, 1);
//				System.out.println(cart);	
//				
//			}
			
//			{ //product Id 2, 白
//				String productId = "2"; //request.getParameter("productId")
//				String colorName = "白"; //request.getParameter("color")
//				String sizeName = "S"; //request.getParameter("sizeName")				
//				
//				Product p = pService.getProductById(productId);
//				Size size = null;
//				if(p.hasSize() && sizeName!=null) {
//					if(colorName==null) colorName="";
//					size = pService.getProductSize(productId, colorName, sizeName);
//					if(size==null) {
//						throw new VGBInvalidDataException ("size不正確");
//					}
//				}
//				
//				//System.out.println(p); //for test
//				cart.addCartItem(p, colorName, size, 1);
//				System.out.println(cart);	
//				
//			}
			
			{ //"2", "白", "M"
				String productId = "2"; //request.getParameter("productId")
				String colorName = "白色"; //request.getParameter("color")
				String sizeName = "M"; //request.getParameter("sizeName")				
				
				Product p = pService.getProductById(productId);
				Size size = null;
				if(p.hasSize() && sizeName!=null) {
					if(colorName==null) colorName="";
					size = pService.getProductSize(productId, colorName, sizeName);
					if(size==null) {
						String msg = String.format("產品size(%s-%s-%s)不正確\n", productId, colorName, sizeName);
						throw new VGBInvalidDataException (msg);
					}
				}
				
				//System.out.println(p); //for test
				cart.addCartItem(p, colorName, size, 1);
				System.out.println(cart);	
			}
			{ //"2", "白", "M"
				String productId = "2"; //request.getParameter("productId")
				String colorName = "白色"; //request.getParameter("color")
				String sizeName = "M"; //request.getParameter("sizeName")				
				
				Product p = pService.getProductById(productId);
				Size size = null;
				if(p.hasSize() && sizeName!=null) {
					if(colorName==null) colorName="";
					size = pService.getProductSize(productId, colorName, sizeName);
					if(size==null) {
						String msg = String.format("產品size(%s-%s-%s)不正確\n", productId, colorName, sizeName);
						throw new VGBInvalidDataException (msg);
					}
				}
				
				//System.out.println(p); //for test
				cart.addCartItem(p, colorName, size, 1);
				System.out.println(cart);	
			}
			
//			{ //product Id 14,'', 24
//				String productId = "14"; //request.getParameter("productId")
//				String colorName = null; //request.getParameter("color")
//				String sizeName = "24支"; //request.getParameter("sizeName")				
//				
//				Product p = pService.getProductById(productId);
//				Size size = null;
//				if(p.hasSize() && sizeName!=null) {
//					if(colorName==null) colorName="";
//					size = pService.getProductSize(productId, colorName, sizeName);
//					if(size==null) {
//						String msg = String.format("產品size(%s-%s-%s)不正確\n", productId, colorName, sizeName);
//						throw new VGBInvalidDataException (msg);
//					}
//				}
//				
//				//System.out.println(p); //for test
//				cart.addCartItem(p, colorName, size, 2);
//				System.out.println(cart);
//			}
		} catch (VGBException e) {
			System.out.println(e.getMessage());
		} 

	}
}

