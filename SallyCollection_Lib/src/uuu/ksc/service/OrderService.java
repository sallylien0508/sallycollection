package uuu.ksc.service;

import java.util.List;

import uuu.ksc.entity.Customer;
import uuu.ksc.entity.Order;
import uuu.ksc.exception.VGBException;

public class OrderService {
	private OrdersDAO dao = new OrdersDAO();
	
	public void checkOut(Order order) throws VGBException{
		dao.insert(order);
	}
	
	public List<Order> getOrdersHistory(Customer member)throws VGBException{
		if(member==null) throw new IllegalArgumentException("查詢歷史訂單會員不得為null");
		
		List<Order> list = dao.selectOrdersHistory(member.getId());
		return list;		
	}
	
	public Order getOrderById(Customer member, String orderId)throws VGBException{
		if(member==null) throw new IllegalArgumentException("查詢訂單會員物件不得為null");
		Order order = dao.selectOrderById(member.getId(), orderId);	
		if(order!=null) order.setCustomer(member);
		return order;		
	}
}