package uuu.ksc.entity;

public class OrderItem {
	private int orderId; //Pkey
	private Product product; //Pkey
	private Color color; //Pkey
	private String size=""; //Pkey
	private double price; //交易時價格
	private int quantity;//交易時數量
	public int getOrderId() {
		return orderId;
	}
	public void setOrderId(int orderId) {
		this.orderId = orderId;
	}
	public Product getProduct() {
		return product;
	}
	public void setProduct(Product product) {
		this.product = product;
	}
	public Color getColor() {
		return color;
	}
	public void setColor(Color color) {
		this.color = color;
	}
	public String getSize() {
		return size;
	}
	public void setSize(String size) {
		this.size = size;
	}
	public double getPrice() {
		return price;
	}
	public void setPrice(double price) {
		this.price = price;
	}
	public int getQuantity() {
		return quantity;
	}
	public void setQuantity(int quantity) {
		this.quantity = quantity;
	}
	
	//依據畫面藍為加上getters
	public String getPhotoURL() {
		if(color!=null) {
			return color.getPhotoUrl();
		}else {
			return product.getPhotoUrl();
		}
	}
	public String getProductName() {
			return product.getName();
	}
	
	public String getColorName() {
		return color!=null?color.getName():"";
	}
	public String getSizeName() {
		if(size!=null & size.length()>0) {
			String name=(color!=null?"/":"");
			name +=size;
			return name;
		}

		return "";
	}
	
	public double getAmount() {	
		return price* quantity;
	}
	@Override
	public int hashCode() {
		final int prime = 31;
		int result = 1;
		result = prime * result + ((color == null) ? 0 : color.hashCode());
		result = prime * result + orderId;
		result = prime * result + ((product == null) ? 0 : product.hashCode());
		result = prime * result + ((size == null) ? 0 : size.hashCode());
		return result;
	}
	@Override
	public boolean equals(Object obj) {
		if (this == obj)
			return true;
		if (obj == null)
			return false;
		if (getClass() != obj.getClass())
			return false;
		OrderItem other = (OrderItem) obj;
		if (color == null) {
			if (other.color != null)
				return false;
		} else if (!color.equals(other.color))
			return false;
		if (orderId != other.orderId)
			return false;
		if (product == null) {
			if (other.product != null)
				return false;
		} else if (!product.equals(other.product))
			return false;
		if (size == null) {
			if (other.size != null)
				return false;
		} else if (!size.equals(other.size))
			return false;
		return true;
	}
	@Override
	public String toString() {
		return "OrderItem ["
				+ "照片="+ getPhotoURL() 
				+ ", 產品名稱=" + getProductName() 
				+ ", 顏色/尺寸=" + getColorName() + getSizeName() 
				+ ", 數量=" + getQuantity() 
				+ ", 價格=" + getAmount() 
				+ "]";
	}
	
}
