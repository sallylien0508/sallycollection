package uuu.ksc.entity;

import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.Set;

import uuu.ksc.exception.VGBException;
import uuu.ksc.exception.VGBInvalidDataException;
import uuu.ksc.service.ProductService;

public class shoppingCart {
	private Customer member;
	private Map<CartItem, Integer> cartMap = new HashMap<>();
				//10號產品(pk) 2個
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
	public Set<CartItem> keySet() {//取得購物明細cartItem清單，不會重複主鍵值那些，沒數量
		return cartMap.keySet();
	}
	
	/**
	 * 取得指定CartItem 的售價*購買數量
	 * @param item
	 * @return 該item 的小計金額
	 */
//以下3個business method（自己打）
		public double getAmount(CartItem item) {//各項產品數量加起來總金額
			if(item==null) throw new IllegalArgumentException("取得明細小計金額時，cartItem物件不得為null");
			double amount = item.getUnitPrice()* getQuantity(item);
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
				String msg = String.format("加入購物車時，有顏色的產品(%s)，無此顏色(%s)", p.getId(),colorName);
				throw new VGBInvalidDataException(msg);
			}
		
		}else if(p.getcolorCount()>0 && colorName ==null) {
			String msg = String.format("加入購物車時，有顏色的產品(%s)，必須選擇顏色(%s)", p.getId(),colorName);
			throw new VGBInvalidDataException(msg);
		}
//		else if(p.getcolorCount()==0 && colorName!=null) {
//			String msg = String.format("加入購物車時，沒有顏色的產品(%s)，不能選顏色(%s)", p.getId(),colorName);
//			throw new VGBInvalidDataException(msg); 
//		}
		if(p.getcolorCount()>0 && p.hasSize() && size==null) {
			String msg = String.format("加入購物車時，有顏色/Size的產品(%s)，必須選擇Size，不得為null(%s)", p.getId(),colorName,size);
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
		return "購物車 [訂購人=" + member + "\n, 購物車內容: =" + cartMap + "]";
	}
	
}
