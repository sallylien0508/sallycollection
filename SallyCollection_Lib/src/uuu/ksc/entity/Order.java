package uuu.ksc.entity;

import java.time.LocalDate;
import java.time.LocalTime;
import java.util.HashSet;
import java.util.Set;

import uuu.ksc.exception.VGBInvalidDataException;

import java.time.format.DateTimeParseException;


//
public class Order {
	private int id;//PKey,Anto-Increment
	private Customer customer;//訂購人
	private LocalDate orderDate;
	private LocalTime orderTime;
	private int status;
	
	private String paymentType;//SHOP,ATM,HOME,STORE,CARD
	private double paymentFee;
	private String paymentNote;

	
	private String shippingType;//SHOP,HOME,STORE
	private double shippingFee;
	private String shippingNote;
	private String shippingAddress;
	
	private String recipientName;
	private String recipientEmail;
	private String recipientPhone;
	
	private Set<OrderItem> orderItemSet = new HashSet<>();
	
	//accesser(s) 取代orderItemSet屬性原來的getter
	public Set<OrderItem> getOrderItemSet() {
		return new HashSet<> (orderItemSet);//回傳副本
	}
	
	public int size() {  //共X項
		return orderItemSet.size();
	}

	public boolean isEmpty() {
		return orderItemSet.isEmpty();
	}
	
	//business methods
	public int getTotalQuantity() {
		int sum =0;
		if(orderItemSet!=null && orderItemSet.size()>0) {
			for(OrderItem item:orderItemSet) {
				sum+=item.getQuantity();
			}
		}
		return sum;
	}
	private double totalAmount;
	public void setTotalAmount(double totalAmount) {
		this.totalAmount = totalAmount;
	}
	public double getTotalAmount() {
		double sum = 0;
		if(orderItemSet!=null && orderItemSet.size()>0) {
			for(OrderItem item:orderItemSet) {
				sum+= item.getPrice() * item.getQuantity();
			}			
		}else {
			sum = this.totalAmount;
		}
		return sum;
	}
	public double getTotalAmountWithFee() {
		return getTotalAmount() + paymentFee + shippingFee;
	}
	
	//mutater(s) 取代orderItemSet屬性原來的setter:add
	public void addOrderItem(OrderItem orderItem) {//for DAO類別查詢訂單時，將資料庫訂單明細對應建立為orderItem ，並加入order
		if(orderItem==null) throw new IllegalArgumentException("查詢訂單時cart物件不得為空的");
		orderItemSet.add(orderItem);
		
	}
	public void add(shoppingCart cart) {//for controller checkOutServlet 建立訂單
		if(cart==null || cart.isEmpty()) throw new IllegalArgumentException("建立訂單時cart物件不得為空的");
		for(CartItem cartItem:cart.getCartItemSet()) {
			OrderItem orderItem = new OrderItem();
			
			orderItem.setProduct(cartItem.getProduct());
			orderItem.setColor(cartItem.getColor());
			if(cartItem.getSize()!=null)
			orderItem.setSize(cartItem.getSize().getSizeName());
			
			orderItem.setPrice(cart.getUnitPrice(cartItem));
			orderItem.setQuantity(cart.getQuantity(cartItem));
			
			orderItemSet.add(orderItem);//將明細加入這個清單orderItemSet）
		}
	}

	public int getId() {
		return id;
	}
	private static final String contextPath = "ksc";
	public String getIdString() {
		return String.format("%s%06d", contextPath, id);
	}
	public void setId(int id) {
		this.id = id;
	}
	public Customer getCustomer() {
		return customer;
	}
	public void setCustomer(Customer customer) {
		this.customer = customer;
	}
	public LocalDate getOrderDate() {
		return orderDate;
	}
	public void setOrderDate(LocalDate orderDate) {
		this.orderDate = orderDate;
	}
	public void setOrderDate(String orderDateStr) {
		try {
			LocalDate orderDate = LocalDate.parse(orderDateStr);
			this.setOrderDate(orderDate);
		}catch(DateTimeParseException e) {
			throw new VGBInvalidDataException("訂單日期格是不正確:" + orderDateStr);
		}
	}
	public LocalTime getOrderTime() {
		return orderTime;
	}
	public void setOrderTime(LocalTime orderTime) {
		this.orderTime = orderTime;
	}
	public void setOrderTime(String orderTimeStr) {
		try {
			this.setOrderTime(LocalTime.parse(orderTimeStr));
		}catch(DateTimeParseException e) {
			throw new VGBInvalidDataException("訂單時間格式不正確:" + orderTimeStr);
		}
	}
	public int getStatus() {
		return status;
	}
	public void setStatus(int status) {
		this.status = status;
	}
	public String getPaymentType() {
		return paymentType;
	}
	public void setPaymentType(String paymentType) {
		this.paymentType = paymentType;
	}
	public double getPaymentFee() {
		return paymentFee;
	}
	public void setPaymentFee(double paymentFee) {
		this.paymentFee = paymentFee;
	}
	public String getPaymentNote() {
		return paymentNote;
	}
	public void setPaymentNote(String paymentNote) {
		this.paymentNote = paymentNote;
	}
	public String getShippingType() {
		return shippingType;
	}
	public void setShippingType(String shippingType) {
		this.shippingType = shippingType;
	}
	public double getShippingFee() {
		return shippingFee;
	}
	public void setShippingFee(double shippingFee) {
		this.shippingFee = shippingFee;
	}
	public String getShippingNote() {
		return shippingNote;
	}
	public void setShippingNote(String shippingNote) {
		this.shippingNote = shippingNote;
	}
	public String getShippingAddress() {
		return shippingAddress;
	}
	public void setShippingAddress(String shippingAddress) {
		this.shippingAddress = shippingAddress;
	}
	public String getRecipientName() {
		return recipientName;
	}
	public void setRecipientName(String recipientName) {
		this.recipientName = recipientName;
	}
	public String getRecipientEmail() {
		return recipientEmail;
	}
	public void setRecipientEmail(String recipientEmail) {
		this.recipientEmail = recipientEmail;
	}
	public String getRecipientPhone() {
		return recipientPhone;
	}
	public void setRecipientPhone(String recipientPhone) {
		this.recipientPhone = recipientPhone;
	}
	
	public String getShippingTypeDescription() {
		if (shippingType!=null && shippingType.length()>0) {
			try {
				return ShippingType.valueOf(shippingType).getDescription();
			}catch(Exception e) {
				return shippingType;
			}
		}else {
			return "";
		}		 
	}
	
	public String getPaymentTypeDescription() {
		if (paymentType!=null && paymentType.length()>0) {
			try {
				return PaymentType.valueOf(paymentType).getDescription();
			}catch(Exception e) {
				return paymentType;
			}
		}else {
			return "";
		}		 
	}
	@Override
	public String toString() {
		return "Order [id=" + id + ", customer=" + customer + ", orderDate=" + orderDate + ", orderTime=" + orderTime
				+ ", status=" + status + ", paymentType=" + paymentType + ", paymentFee=" + paymentFee
				+ ", paymentNote=" + paymentNote + ", shippingType=" + shippingType + ", shippingFee=" + shippingFee
				+ ", shippingNote=" + shippingNote + ", shippingAddress=" + shippingAddress + ", recipientName="
				+ recipientName + ", recipientEmail=" + recipientEmail + ", recipientPhone=" + recipientPhone
				+ ", orderItemSet=" + orderItemSet + ", size()=" + size() + ", getTotalQuantity()=" + getTotalQuantity()
				+ ", getTotalAmount()=" + getTotalAmount() + "]";
	}
	
	
}
