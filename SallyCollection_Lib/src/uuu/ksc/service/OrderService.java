package uuu.ksc.service;

import uuu.ksc.entity.Order;
import uuu.ksc.exception.VGBException;

public class OrderService {
	private OrdersDAO dao = new OrdersDAO();
	public void checkOut(Order order) throws VGBException{
		dao.insert(order);
		
	}
	
}
