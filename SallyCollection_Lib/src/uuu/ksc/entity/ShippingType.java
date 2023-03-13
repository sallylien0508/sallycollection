package uuu.ksc.entity;

public enum ShippingType {
	SHOP(0,"門市取貨"),HOME(100,"宅配到府"),STORE(65,"超商取貨");
	
	private final double fee;
	private final String description;
	
	
	private ShippingType(double fee, String description) {
		this.fee = fee;
		this.description = description;
	}
	public double getFee() {
		return fee;
	}
	public String getDescription() {
		return description;
	}
	@Override
	public String toString() {
		return description + (fee >0?","+fee+"元":"");
	}
}
