package uuu.ksc.exception;

/**
 * 用login方法代表帳號密碼不正確的登入失敗
 * @author sally
 *
 */
public class LoginFailedException extends VGBException {

	public LoginFailedException() {
		super();
		// TODO Auto-generated constructor stub
	}

	public LoginFailedException(String message, Throwable cause) {
		super(message, cause);
		// TODO Auto-generated constructor stub
	}

	public LoginFailedException(String message) {
		super(message);
		// TODO Auto-generated constructor stub
	}

}
