package uuu.ksc.test;
import java.util.Scanner;

import uuu.ksc.service.MailService;

/*
 * 測試提供send mail功能的MailService.
 */

/**
 *
 * @author Administrator
 */
public class TestMailService {
    public static void main(String[] args) {    	
    	System.out.println("請輸入一個正確的email: ");    	
    	try(Scanner scanner = new Scanner(System.in);){    	
	    	String email = scanner.next();
	        MailService.sendHelloMailWithLogo(email); //
    	}
    }
}
