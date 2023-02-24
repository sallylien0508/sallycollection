package uuu.ksc.service;

import java.util.ArrayList;
import java.util.List;

import uuu.ksc.entity.Color;
import uuu.ksc.entity.Outlet;
import uuu.ksc.entity.Product;
import uuu.ksc.exception.VGBException;

import java.sql.*;
import java.time.LocalDate;

class ProductsDAO{
	
	private static final String SELECT_ALL_PRODUCTS="SELECT id, name, unit_price, stock, description, photo_url, launch_date, category, discount FROM products";
	 List<Product> selectALLProducts() throws VGBException{
		 List<Product> list =new ArrayList<>();
		 
		
		 try ( Connection connection = MySQLConnection.getConnection();//1,2取得連線
			   PreparedStatement pstmt = connection.prepareStatement(SELECT_ALL_PRODUCTS);//3. 準備指令
				 ){
			 //3.1傳入?(無)的值
			 try(			
			 ResultSet rs = pstmt.executeQuery();//4.執行指令
			 ){
				 //5. 處理rs
				 while(rs.next()) {
					 Product p;
					 int discount =rs.getInt("discount");
					 if(discount>0) {
						 p = new Outlet();
						 ((Outlet)p).setDiscount(discount);
//						 Outlet outlet = new Outlet();
//						 outlet.setDiscount(discount);
//						 p =outlet;
						 
					 }else {
						 p = new Product();
					 }
					 p.setId(rs.getInt("id"));
					 p.setName(rs.getString("name"));
					 p.setUnitPrice(rs.getDouble("unit_price"));
					 p.setStock(rs.getInt("stock"));
					 p.setDescription(rs.getString("description"));
					 p.setPhotoUrl(rs.getString("photo_url"));
					 p.setLaunchDate(LocalDate.parse(rs.getString("launch_date")));
					 p.setCategory(rs.getString("category"));
					
					 list.add(p);
					 
				 }
			 }

		} catch (SQLException e) {
			throw new VGBException("查詢全部產品失敗",e);
		}
		 
		 return list;
		}
	 private static final String select_Products_By_Keyword= SELECT_ALL_PRODUCTS+" where name LIKE ?";
	 	List<Product> selectProductsByKeyword(String keyword) throws VGBException{
	 			 List<Product> list =new ArrayList<>();
	 			 try ( Connection connection = MySQLConnection.getConnection();//1,2取得連線
	 				   PreparedStatement pstmt = connection.prepareStatement(select_Products_By_Keyword);//3. 準備指令
	 					 ){
	 				 //3.1傳入?(1個)的值
	 				 pstmt.setString(1,"%"+ keyword +"%");
	 				 try(			
	 				 ResultSet rs = pstmt.executeQuery();//4.執行指令
	 				 ){
	 					 //5. 處理rs
	 					 while(rs.next()) {
	 						 Product p;
	 						 int discount =rs.getInt("discount");
	 						 if(discount>0) {
	 							 p = new Outlet();
	 							 ((Outlet)p).setDiscount(discount);
//	 							 Outlet outlet = new Outlet();
//	 							 outlet.setDiscount(discount);
//	 							 p =outlet;
	 							 
	 						 }else {
	 							 p = new Product();
	 						 }
	 						 p.setId(rs.getInt("id"));
	 						 p.setName(rs.getString("name"));
	 						 p.setUnitPrice(rs.getDouble("unit_price"));
	 						 p.setStock(rs.getInt("stock"));
	 						 p.setDescription(rs.getString("description"));
	 						 p.setPhotoUrl(rs.getString("photo_url"));
	 						 p.setLaunchDate(LocalDate.parse(rs.getString("launch_date")));
	 						 p.setCategory(rs.getString("category"));
	 						
	 						 list.add(p);
	 						 
	 					 }
	 				 }

	 			} catch (SQLException e) {
	 				throw new VGBException("查詢全部產品失敗",e);
	 			}
	 			 
	 			 return list;
	 }
	 	

		private static final String select_Products_By_Category = SELECT_ALL_PRODUCTS 
				+ " WHERE category = ?";
		List<Product> selectProductsByCategory(String category) throws VGBException{
			List<Product> list = new ArrayList<>();		
			try (
					Connection connection = MySQLConnection.getConnection(); //1,2 取得連線 
					PreparedStatement pstmt = connection.prepareStatement(select_Products_By_Category); //3.準備指令
				){			
				//3.1 傳入?(1)的值
				pstmt.setString(1, category);
				
				try(
						ResultSet rs = pstmt.executeQuery(); //4.執行指令
				){
					//5. 處理rs
					while(rs.next()) {
						Product p;
						int discount = rs.getInt("discount");
						if(discount>0) {
							p = new Outlet();
							((Outlet)p).setDiscount(discount);						
						}else p = new Product();					
						
						p.setId(rs.getInt("id"));
						p.setName(rs.getString("name"));
						p.setUnitPrice(rs.getDouble("unit_price"));
						p.setStock(rs.getInt("stock"));
						p.setDescription(rs.getString("description"));
						p.setPhotoUrl(rs.getString("photo_url"));
						p.setLaunchDate(LocalDate.parse(rs.getString("launch_date")));
						p.setCategory(rs.getString("category"));
						
						list.add(p); //不要忘了
					}				
				}
			} catch (SQLException e) {
				throw new VGBException("[用分類查詢產品]失敗", e);
			}
			
			return list;
		}
		
		private static final String select_Product_By_Id=
				"SELECT id, name, unit_price, products.stock , description,products.photo_url, launch_date, category, discount, \n"
				+ "	product_id, color_name, product_colors.stock AS color_stock,product_colors.photo_url,  product_colors.photo_url AS color_photo,icon_url,ordinal\n"
				+ "FROM products\n"
				+ "	LEFT JOIN product_colors ON id =product_id  WHERE id = ? ORDER BY id,ordinal;";
		public Product selectProductById(String id) throws VGBException{
			Product p = null;		 
			try (
					Connection connection = MySQLConnection.getConnection(); //1,2 取得連線
					PreparedStatement pstmt = connection.prepareStatement(select_Product_By_Id); //3.準備指令
				){
				//3.1 傳入?的值
				pstmt.setString(1, id);			
				try(
					ResultSet rs = pstmt.executeQuery();//4.執行指令
				){
					//5. 處理rs
					while(rs.next()) {
						//Product p;
					if(p==null) {	
						int discount = rs.getInt("discount");
						if(discount>0) {
							p = new Outlet();
							((Outlet)p).setDiscount(discount);						
						}else p = new Product();					
						
						p.setId(rs.getInt("id"));
						p.setName(rs.getString("name"));
						p.setUnitPrice(rs.getDouble("unit_price"));
						p.setStock(rs.getInt("stock"));
						p.setDescription(rs.getString("description"));
						p.setPhotoUrl(rs.getString("photo_url"));
						p.setLaunchDate(LocalDate.parse(rs.getString("launch_date")));
						p.setCategory(rs.getString("category"));
					}
						//System.out.println(p);
						//System.out.printf("顏色 %s,%s,%s,%s\n",rs.getString("product_id"),rs.getString("product_name"),rs.getString("product_stock"),rs.getString("product_photo"));
						//list.add(p); //不要了
						String colorName = rs.getString("color_name");
						if(colorName!=null) {
							Color color =new Color();
							color.setName(colorName);
							color.setStock(rs.getInt("color_stock"));
							color.setPhotoUrl(rs.getString("color_photo"));
							color.setIconUrl(rs.getString("icon_url"));
							color.setOrdinal(rs.getInt("ordinal"));
							p.addColor(color);
						}
					}
				}			
			} catch (SQLException e) {
				throw new VGBException("[用id查詢產品]失敗",e);
			}
			return p;
		}
	}


