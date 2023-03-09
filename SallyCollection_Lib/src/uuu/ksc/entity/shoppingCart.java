package uuu.ksc.entity;

import java.util.HashMap;
import java.util.HashSet;
import java.util.List;
import java.util.Map;
import java.util.Set;

import uuu.ksc.exception.VGBException;
import uuu.ksc.exception.VGBInvalidDataException;
import uuu.ksc.service.ProductService;

public class shoppingCart {
	private Customer member;
	private Map<CartItem, Integer> cartMap = new HashMap<>();
				//1產品(pk) ,數量
	public Customer getMember() {
		return member;
	}
	public void setMember(Customer member) {
		this.member = member;
	}
	
//用accessers方法取代集合型態屬性cartMap的getters:
//以下4個business方法是用source的delegate method 來產生
	public int size() {//幾項
		return cartMap.size();
	}
	public boolean isEmpty() {//購物車是不是空的
		return cartMap.isEmpty();
	}
	
	/**
	 * 取得指定CartItem 的購買數量
	 * @param item
	 * @return 該item 的購買數量(int)
	 */
	
	public int getQuantity(CartItem item) {
		if(item==null) throw new IllegalArgumentException("取得明細購買數量時，cartItem物件不得為null");
		Integer qty =cartMap.get(item);
		return qty!=null?qty:0;
	}

	public Double getListPrice(CartItem item) {
		if(item.getProduct() instanceof Outlet) {	
			return item.getListPrice();
			
		}else {
			return item.getUnitPrice();
		}
	}	
	
	public String getDiscountString(CartItem item) {
		if(!(item.getProduct() instanceof Outlet)) {	
			return item.getDiscountString();
			
		}else {
			return item.getDiscountString();
		}
	}		
	
	public Double getUnitPrice(CartItem item) {
		if(item.getProduct() instanceof Outlet) {	
			return item.getUnitPrice();
			
		}else {
			return item.getUnitPrice();
		}
	}	
	
	public Set<CartItem> getCartItemSet() {//取得購物明細cartItem清單，不會重複主鍵值那些，沒數量
		return new HashSet<> (cartMap.keySet());//副本
//		return cartMap.keySet();//正本，不得使用，應該要回傳副本
	}
	
	/**
	 * 取得指定CartItem 的售價*購買數量
	 * @param item
	 * @return 該item 的小計金額
	 */
//以下3個business method（自己打）
		public double getAmount(CartItem item) {//各項產品數量加起來總金額
			if(item==null) throw new IllegalArgumentException("取得明細小計金額時，cartItem物件不得為null");
			double amount = this.getUnitPrice(item)* getQuantity(item);
			return amount;
		}
		public double getTotalAmount() {//全部產品加起來總金額
			double sum =0;
			if(cartMap!=null && size()>0) {
				for(CartItem item:cartMap.keySet()) {
					sum+=getAmount(item);
					}
			}
			return sum;
		}
		
		public double getTotalQuantity() {//全部產品加起來總數量
			int sum =0;
			if(cartMap!=null && size()>0) {
				for(Integer qty:cartMap.values()) {
					sum+=(qty!=null?qty:0);
					}
			}
			return sum;
		}
		
		
		
		
//用mutatters方法取代集合型態屬性cartMap的setters:asscartItem,updateItem,removeCartItem,removeCartItem
		
	public void updateCartItem(CartItem currentItem,int quantity) throws VGBInvalidDataException {
		Integer prevQty = cartMap.get(currentItem);//檢查有沒有舊的，找出之前加入的購買數量 
		if(prevQty!=null) {//有找到之前加入的購買數量 ，才修改
			cartMap.put(currentItem,quantity);
		}	
	}
	public void removeCartItem(CartItem currentItem) throws VGBInvalidDataException {
		cartMap.remove(currentItem);
	}
	public void addCartItem(Product p,String colorName, Size size) throws VGBInvalidDataException {
		addCartItem(p,colorName,size,1);
	}
	public void addCartItem(Product p,String colorName, Size size, int quantity) throws VGBInvalidDataException {
		if(p ==null) throw new IllegalArgumentException("加入購物車時，產品不得為null");
		if(quantity<=0)throw new VGBInvalidDataException("加入購物車時，購物產品數量必須>0");
		Color color = null;
		if(p.getcolorCount()>0 &&colorName!=null) {
			color = p.findColor(colorName);
			if(color==null) {
				String msg = String.format("加入購物車時失敗，有顏色的產品(%s)，無此顏色(%s)", p.getId(),colorName);
				throw new VGBInvalidDataException(msg);
			}
		
		}else if(p.getcolorCount()>0 && colorName ==null) {
			String msg = String.format("加入購物車時失敗，有顏色的產品(%s)，必須選擇顏色(%s)", p.getId(),colorName);
			throw new VGBInvalidDataException(msg);
		}
//		else if(p.getcolorCount()==0 && colorName!=null) {
//			String msg = String.format("加入購物車時失敗，沒有顏色的產品(%s)，不能選顏色(%s)", p.getId(),colorName);
//			throw new VGBInvalidDataException(msg); 
//		}
		if(p.getcolorCount()>0 && p.hasSize() && size==null) {
			String msg = String.format("加入購物車時失敗，有顏色(%s)/Size的產品(%s)，必須選擇Size", p.getId(),colorName);
			throw new VGBInvalidDataException(msg);	
		}else if(p.getcolorCount()>0 && p.hasSize() && size==null) {
			String msg = String.format("加入購物車時失敗，無顏色/Size的產品(%s)，必須選擇Size()", p.getId());
			throw new VGBInvalidDataException(msg);	
		}
		CartItem item = new CartItem();
		item.setProduct(p);
		item.setColor(color);
		item.setSize(size);
		Integer prevQty = cartMap.get(item);
		if(prevQty!=null) {
			quantity += prevQty;
		}
		
		cartMap.put(item,quantity);
	}
	@Override
	public String toString() {
		return "購物車 [訂購人=" + member + "\n, 購物車內容: =" + cartMap + "\n,共" + size() +"項, "+","+getTotalQuantity()+"件\n 總金額"+getTotalAmount()+"元]";
	}
	
}
