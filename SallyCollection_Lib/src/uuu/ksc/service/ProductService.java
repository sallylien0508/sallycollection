package uuu.ksc.service;

import java.util.List;

import uuu.ksc.entity.Product;
import uuu.ksc.exception.VGBException;

public class ProductService {
	private ProductsDAO dao = new ProductsDAO();
	
	public List<Product> getALLProducts() throws VGBException{
		return dao.selectALLProducts();
	}
	public List<Product> getProductsByKeyword(String keyword) throws VGBException{
		return dao.selectProductsByKeyword(keyword);
	}
	public List<Product> getProductsByCategory(String category) throws VGBException{
		return dao.selectProductsByCategory(category);
	}
	public Product getProductById(String id) throws VGBException{
		return dao.selectProductById(id);
	}

}
