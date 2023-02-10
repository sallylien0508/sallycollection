package uuu.ksc.exception;

public class VGBInvalidDataException extends RuntimeException {

	public VGBInvalidDataException() {
		super();
	}

	public VGBInvalidDataException(String message, Throwable cause) {
		//是像是birthdatestring，不是我們說錯的不是我們自己寫設定的條件，是不符合底層的格式
		super(message, cause);
	}

	public VGBInvalidDataException(String message) {
		super(message);
	}

}
