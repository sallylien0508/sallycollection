package uuu.ksc.test;

import java.time.LocalDate;
import java.time.LocalTime;
import java.util.logging.Level;
import java.util.logging.Logger;

import uuu.ksc.entity.CartItem;
import uuu.ksc.entity.Customer;
import uuu.ksc.entity.Order;
import uuu.ksc.entity.OrderItem;
import uuu.ksc.entity.PaymentType;
import uuu.ksc.entity.Product;
import uuu.ksc.entity.ShippingType;
import uuu.ksc.entity.shoppingCart;
import uuu.ksc.entity.Size;
import uuu.ksc.exception.VGBException;
import uuu.ksc.exception.VGBInvalidDataException;
import uuu.ksc.service.CustomerService;
import uuu.ksc.service.OrderService;
import uuu.ksc.service.ProductService;

public class TestOrder {
	public static void main(String[] args) {
		CustomerService cService = new CustomerService();
		ProductService pService = new ProductService();
		try {
			Customer member = cService.login("A123123123", "12345lkj");
			shoppingCart cart = new shoppingCart();
			
			cart.setMember(member);
			
			{ //"2", "白", "M"
				String productId = "20"; //request.getParameter("productId")
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
			
			Order order = new Order();
			order.setCustomer(cart.getMember());
			order.setOrderDate(LocalDate.now());
			order.setOrderTime(LocalTime.now());
			
			PaymentType thePType = PaymentType.valueOf("HOME");
			order.setPaymentType(thePType.name());
			order.setPaymentFee(thePType.getFee());
			
			ShippingType theShippingType = ShippingType.valueOf("HOME");			
			order.setShippingType(theShippingType.name());
			order.setShippingFee(theShippingType.getFee());			
			order.setShippingAddress("台北市復興北路99號12F");
			
			order.setRecipientName("林莉");
			order.setRecipientEmail("test01@uuu.com.tw");
			order.setRecipientPhone("0987641111");
			
			order.add(cart);
			
			OrderService oService = new OrderService();
			oService.checkOut(order);
			System.out.println(order);
			

			
			
		} catch (VGBException e) {
			Logger.getLogger("建立訂單測試").log(Level.SEVERE,e.getMessage(),e);
		} 

	}
}
