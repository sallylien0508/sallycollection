package uuu.ksc.service;

import java.util.List;

import uuu.ksc.entity.Product;
import uuu.ksc.entity.Size;
import uuu.ksc.exception.VGBException;

public class ProductService {
	private ProductsDAO dao = new ProductsDAO();
	
	public List<Product> getALLProducts() throws VGBException{
		return dao.selectALLProducts();
	}
	public List<Product> getProductsByKeywordAndCategory(String keyword, String category) throws VGBException{
		if(keyword==null || category==null) throw new IllegalArgumentException("依關鍵字+分類查詢產品時，keyword或category不得為null");		
		return dao.selectProductsByKeywordAndCategory(keyword, category);
	}
	public List<Product> getProductsByKeyword(String keyword) throws VGBException{
		if(keyword ==null)throw new IllegalArgumentException("關鍵字查詢產品時，keyword 不得為null");
		return dao.selectProductsByKeyword(keyword);
	}
	public List<Product> getProductsByCategory(String category) throws VGBException{
		if(category ==null)throw new IllegalArgumentException("依分類查詢產品時，category 不得為null");
		return dao.selectProductsByCategory(category);
	}
	public Product getProductById(String id) throws VGBException{
		if(id ==null)throw new IllegalArgumentException("查詢產品尺寸時，id 不得為null");
		return dao.selectProductById(id);
	}
	public List<Size> getProductSizeList(String productId, String colorName)throws VGBException{
		if(productId ==null)throw new IllegalArgumentException("查詢產品尺寸時，productId 不得為null");
		if(colorName ==null) colorName="";
		
		return dao.selectProductSizeList(productId,colorName);
	}
	public Size getProductSize(String productId, String colorName, String sizeName )		throws VGBException{
		if(productId==null) throw new IllegalArgumentException("查詢產品尺寸時，productId不得為null");
		if(colorName==null) colorName="";
		
		return dao.selectProductSize(productId, colorName, sizeName);
	}
	public List<Product> getHighToLow() throws VGBException{
		return dao.selectHighToLow();
	}
	public List<Product> getLowToHigh() throws VGBException{
		return dao.selectLowToHigh();
	}
}
