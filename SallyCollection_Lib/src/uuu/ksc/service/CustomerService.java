package uuu.ksc.service;

import uuu.ksc.entity.Customer;
import uuu.ksc.exception.LoginFailedException;
import uuu.ksc.exception.VGBException;

public class CustomerService {
	private CustomersDAO dao = new CustomersDAO();
	
	public Customer login(String idOrEmail, String password) throws VGBException{
		if(idOrEmail==null || idOrEmail.length()==0
				|| password==null || password.length()==0) {
			throw new IllegalArgumentException("登入時帳號密碼必須有值");
		}
		
		Customer c = dao.selectCustomerById(idOrEmail);
		
		if(c!=null && c.getPassword().equals(password)) {
			return c;
		}		
		throw new LoginFailedException("登入失敗! 帳號或密碼不正確");
	}	
	
	
	public void register(Customer c) throws VGBException{
		//throws VGBException-->如果有錯，就拋出
		if(c==null) {
			throw new IllegalArgumentException("註冊會員時客戶(Customer)物件不得為null");
		}
		dao.insert(c);
	}
	public void update(Customer c) throws VGBException{
		//throws VGBException-->如果有錯，就拋出
		if(c==null) {
			throw new IllegalArgumentException("註冊會員時客戶(Customer)物件不得為null");
		}
		dao.update(c);
	}
}
