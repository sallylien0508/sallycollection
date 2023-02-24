package uuu.ksc.test;

import java.util.Scanner;
import java.util.logging.Level;
import java.util.logging.Logger;

import uuu.ksc.entity.Customer;
import uuu.ksc.exception.LoginFailedException;
import uuu.ksc.exception.VGBException;
import uuu.ksc.service.CustomerService;

public class TestCustomerService_update {

	public static void main(String[] args) {
		//1.輸入帳號密碼
		Scanner scanner = new Scanner(System.in);
		System.out.println("請輸入帳號或email:");
		String id=scanner.next();
		System.out.println("請輸入密碼:");		
		String password=scanner.next();
		
		//2.呼叫商業邏輯		
		CustomerService service = new CustomerService();
		Customer c;
		try {
			c = service.login(id, password);
			System.out.printf("登入成功, %s\n", c);

			c.setAddress("美國");
			service.update(c);
			
			System.out.printf("修改成功, %s\n", c);
		} catch (LoginFailedException e) {
			 
			Logger.getLogger("測試會員登入").log(
					Level.SEVERE, e.getMessage());
		} catch (VGBException e) {
			
			Logger.getLogger("測試會員登入").log(
					Level.SEVERE, e.getMessage(), e
			);
			//System.out.printf("登入失敗: %s", e);
		} catch(Exception ex) {
			
			Logger.getLogger("測試會員登入").log(
					Level.SEVERE, "發生非預期錯誤", ex
			);
		}
				
	}
}
