package uuu.ksc.test;

import java.util.logging.Level;
import java.util.logging.Logger;

import uuu.ksc.entity.Product;
import uuu.ksc.exception.VGBException;
import uuu.ksc.service.ProductService;

public class TestProductService_getById {

	public static void main(String[] args) {
		ProductService service = new ProductService();		
		try {			
			Product p = service.getProductById("5");
			System.out.println(p);
		} catch (VGBException e) {
			Logger.getLogger("測試[用id查詢產品]").log(
					Level.SEVERE, e.getMessage(), e);
		}
	}
}