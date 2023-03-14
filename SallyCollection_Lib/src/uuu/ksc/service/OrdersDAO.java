package uuu.ksc.service;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;

import uuu.ksc.entity.Order;
import uuu.ksc.entity.OrderItem;
import uuu.ksc.exception.KSCStockShortageException;
import uuu.ksc.exception.VGBException;

class OrdersDAO {

	
	private static final String UPDATE_products_stock="UPDATE products SET stock= stock- ? "
			+ "	WHERE stock>=? AND id=?";
	private static final String UPDATE_product_colors_stock="UPDATE product_colors SET stock= stock- ?"
			+ "	WHERE stock>=? AND product_id=? AND color_name=?";
	private static final String UPDATE_product_color_sizes_stock="UPDATE product_color_sizes SET stock= stock- ? "
			+ "	WHERE stock>=? AND product_id=? AND color_name=? AND size_name=?";
	
	private static final String INSERT_orders = "INSERT INTO orders "
			+ "	(id, customer_id, order_date, order_time,status,  "
			+ "    payment_type, payment_fee,  payment_note, "
			+ "    shipping_type, shipping_fee, shipping_address,  "
			+ "    recipient_name, recipient_email, recipient_phone) "
			+ "    VALUES(?,?,?,?,0, ?,?,'', ?,?,?, ?,?,?)";
	private static final String INSERT_order_items = "INSERT INTO order_items "
			+ "	(order_id, product_id, color_name, size_name, price, quantity) "
			+ "    VALUES(?,?,?,?, ?,?)";
	
	public void insert(Order order) throws VGBException{
		
		try(
				Connection connection = MySQLConnection.getConnection();//1,2 取得連線
				PreparedStatement pstmt01 = connection.prepareStatement(UPDATE_products_stock);
				PreparedStatement pstmt02 = connection.prepareStatement(UPDATE_product_colors_stock);
				PreparedStatement pstmt03 = connection.prepareStatement(UPDATE_product_color_sizes_stock);
				PreparedStatement pstmt1 = connection.prepareStatement(INSERT_orders, Statement.RETURN_GENERATED_KEYS); //3.準備指令1
				PreparedStatement pstmt2 = connection.prepareStatement(INSERT_order_items); //3.準備指令2
			) {
			
			connection.setAutoCommit(false); //connection.beginTran
			try {
				//庫存管理
				if(order.getOrderItemSet()!=null && order.size()>0) {
					for(OrderItem orderItem:order.getOrderItemSet()) {
						PreparedStatement pstmt;
						if(orderItem.getSize()!=null && orderItem.getSize().length()>0) {
							pstmt= pstmt03;
							pstmt.setString(4, orderItem.getColorName());
							pstmt.setString(5, orderItem.getSize());
						}else if( (orderItem.getSize()==null || orderItem.getSize().length()==0)
								 && orderItem.getColor()!=null) {
							pstmt= pstmt02;
							pstmt.setString(4, orderItem.getColorName());
						}else {
							pstmt= pstmt01;
						}
						//3.1 pstmt01, 02, 03的?值
						pstmt.setInt(1, orderItem.getQuantity());
						pstmt.setInt(2, orderItem.getQuantity());
						pstmt.setInt(3, orderItem.getProduct().getId());
//						System.out.println(orderItem);
						
						//4.執行修改庫存的指令
						int rows = pstmt.executeUpdate();
						if(rows==0) {
							throw new KSCStockShortageException(orderItem);
						}
						System.out.println("修改成功: "+orderItem);
					}
				}else{
					throw new VGBException("建立訂單必須有明細");
				}
				
				
				//3.1. 傳入pstmt1的?的值
				pstmt1.setInt(1, order.getId());
				pstmt1.setString(2, order.getCustomer().getId());
				pstmt1.setString(3, order.getOrderDate().toString());
				pstmt1.setString(4, order.getOrderTime().toString());
				
				pstmt1.setString(5, order.getPaymentType());
				pstmt1.setDouble(6, order.getPaymentFee());
				
				pstmt1.setString(7, order.getShippingType());
				pstmt1.setDouble(8, order.getShippingFee());
				pstmt1.setString(9, order.getShippingAddress());
				
				pstmt1.setString(10, order.getRecipientName());
				pstmt1.setString(11, order.getRecipientEmail());
				pstmt1.setString(12, order.getRecipientPhone());			
				
				//4.執行pstmt1
				pstmt1.executeUpdate();				
				
//				String s = null; //for test
//				System.out.println(s.length()); //for test
				
				//取得pstmt1自動給號的值
				try(ResultSet rs = pstmt1.getGeneratedKeys();){
					while(rs.next()) {
						order.setId(rs.getInt(1));
					}
				}
				
				if(order.getOrderItemSet()!=null && order.size()>0) {
					for(OrderItem orderItem:order.getOrderItemSet()) {
						//3.1. 傳入pstmt2的?的值
						pstmt2.setInt(1, order.getId());
						pstmt2.setInt(2, orderItem.getProduct().getId());
						pstmt2.setString(3, orderItem.getColorName());
						pstmt2.setString(4, orderItem.getSize());
						pstmt2.setDouble(5, orderItem.getPrice());
						pstmt2.setInt(6, orderItem.getQuantity());
						
						//4.執行pstmt2
						pstmt2.executeUpdate();					
					}				
				}	
				connection.commit();
			}catch(Exception e) {
				connection.rollback();
				throw e;
			}finally {
				connection.setAutoCommit(true);
			}
			
		} catch (SQLException e) {
			throw new VGBException("建立訂單失敗", e);
		}		
	}
}
