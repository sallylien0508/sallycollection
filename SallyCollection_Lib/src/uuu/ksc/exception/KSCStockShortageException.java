package uuu.ksc.exception;

import uuu.ksc.entity.OrderItem;

public class KSCStockShortageException extends VGBException {
	private final OrderItem theOrderItem;
	
	
	public KSCStockShortageException(OrderItem theOrderItem) {
		super("庫存不足");
		this.theOrderItem =theOrderItem;
	}

	public KSCStockShortageException(OrderItem theOrderItem,String message, Throwable cause) {
		super(message, cause);
		this.theOrderItem =theOrderItem;
	}

	public KSCStockShortageException(OrderItem theOrderItem,String message) {
		super(message);
		this.theOrderItem =theOrderItem;
	}

	@Override
	public String toString() {
		return String.format("訂購項目庫存不足 [%s/%s/%s]",theOrderItem.getProduct().getId(),theOrderItem.getColorName(),theOrderItem.getSize());
	}
}
