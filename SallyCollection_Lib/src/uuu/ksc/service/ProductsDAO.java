package uuu.ksc.service;

import java.util.ArrayList;
import java.util.List;

import uuu.ksc.entity.Color;
import uuu.ksc.entity.Outlet;
import uuu.ksc.entity.Product;
import uuu.ksc.entity.Size;
import uuu.ksc.exception.VGBException;

import java.sql.*;
import java.time.LocalDate;

class ProductsDAO{
	
	private static final String SELECT_ALL_PRODUCTS="SELECT id, name, unit_price, stock, description, photo_url, "
			+ "	launch_date, category, discount\n"
			+ "FROM products_view ";
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
	 	

		private static final String select_Products_By_Keyword_AndCategory = SELECT_ALL_PRODUCTS 
				+ " WHERE name LIKE ? AND category = ?";
		List<Product> selectProductsByKeywordAndCategory(String keyword, String category) throws VGBException{
			List<Product> list = new ArrayList<>();		
			try (
					Connection connection = MySQLConnection.getConnection(); //1,2 取得連線 
					PreparedStatement pstmt = connection.prepareStatement(select_Products_By_Keyword_AndCategory); //3.準備指令
				){			
				//3.1 傳入?(1)的值
				pstmt.setString(1, "%" + keyword +"%");
				pstmt.setString(2, category);
				
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
				throw new VGBException("[用關鍵字查詢產品]失敗", e);
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
		
//		private static final String select_Product_By_Id=
//				"SELECT id, name, unit_price, products.stock , description,products.photo_url, launch_date, category, discount, \n"
//				+ "	product_id, color_name, product_colors.stock AS color_stock,product_colors.photo_url,  product_colors.photo_url AS color_photo,icon_url,ordinal\n"
//				+ "FROM products\n"
//				+ "	LEFT JOIN product_colors ON id =product_id  WHERE id = ? ORDER BY id,ordinal;";
		
		private static final String select_Product_By_Id=
		"SELECT id, name, products.unit_price, "
		+ "IFNULL(SUM(product_color_sizes.stock), products.stock)AS stock, description,"
		+ "	products.photo_url, launch_date, category, discount,"
		+ "    product_colors.product_id,  product_colors.color_name,  "
		+ "    IFNULL(SUM(product_color_sizes.stock),product_colors.stock) AS color_stock, "
		+ "    COUNT(product_color_sizes.size_name) AS size_count, "
		//+ "    SUM(product_color_sizes.stock) AS size_total_stock, "
		+ "    product_colors.photo_url AS color_photo, "
		+ "    icon_url,  product_colors.ordinal "
		+ "FROM products  "
		+ "	LEFT JOIN product_colors ON id=product_id  "
		+ "    LEFT JOIN product_color_sizes "
		+ "			ON products.id = product_color_sizes.product_id "
		+ "				AND (product_colors.color_name = product_color_sizes.color_name "
		+ "					OR product_colors.color_name IS NULL )     "
		+ "    WHERE id = ? "
		+ "    GROUP BY color_name "
		+ "    ORDER BY id,  product_colors.ordinal";
				
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
					
						//檢查是否有size
						p.setHasSize(rs.getInt("size_count")>0);
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

		private static final String select_Product_Size_List =
				"SELECT product_id, color_name, size_name, product_color_sizes.stock, "
				+ "	product_color_sizes.unit_price AS list_price, "
				+ "    (product_color_sizes.unit_price * (100-discount) / 100) as price, "
				+ "    ordinal "
				+ "	FROM product_color_sizes"
				+ "		JOIN products ON product_color_sizes.product_id = products.id"
				+ "    WHERE product_id=? AND color_name=?"
				+ "    ORDER BY ordinal";
		List<Size> selectProductSizeList(String productId, String colorName) 
				throws VGBException{
			List<Size> list = new ArrayList<>();
			
			
			try (
					Connection connection = MySQLConnection.getConnection();//1, 2 取得connection
					PreparedStatement pstmt = connection.prepareStatement(select_Product_Size_List); //3.準備指令
				){
				//3.1 傳入?的值
				pstmt.setString(1, productId);
				pstmt.setString(2, colorName);
				
				//4.執行指令
				try(
						ResultSet rs = pstmt.executeQuery();
				){
					//5.處理rs
					while(rs.next()) {
						Size size = new Size();
						size.setProductId(rs.getInt("product_id"));
						size.setColorName(rs.getString("color_name"));
						size.setSizeName(rs.getString("size_name"));
						size.setStock(rs.getInt("stock"));
						size.setListPrice(rs.getDouble("list_price"));
						size.setPrice(rs.getDouble("price"));
						list.add(size);
					}
				}			
			} catch (SQLException e) {			
				String msg = String.format("查詢指定產品(%s-%s)SizeList失敗", productId, colorName);
				throw new VGBException(msg, e);
			}		
			return list;
		}
		
		
		private static final String select_Product_Size =
				"SELECT product_id, color_name, size_name, product_color_sizes.stock, "
				+ "	product_color_sizes.unit_price AS list_price, "
				+ "    (product_color_sizes.unit_price * (100-discount) / 100) as price, "
				+ "    ordinal "
				+ "	FROM product_color_sizes"
				+ "		JOIN products ON product_color_sizes.product_id = products.id"
				+ "    WHERE product_id=? AND color_name=? AND size_name=?";
		 Size selectProductSize(String productId, String colorName, String sizeName) throws VGBException {
			Size size =null;
			try (
					Connection connection = MySQLConnection.getConnection();//1, 2 取得connection
					PreparedStatement pstmt = connection.prepareStatement(select_Product_Size); //3.準備指令
				){
				//3.1 傳入?的值
				pstmt.setString(1, productId);
				pstmt.setString(2, colorName);
				pstmt.setString(3, sizeName);
				
				//4.執行指令
				try(
						ResultSet rs = pstmt.executeQuery();
				){
					//5.處理rs
					while(rs.next()) {
						size = new Size();
						size.setProductId(rs.getInt("product_id"));
						size.setColorName(rs.getString("color_name"));
						size.setSizeName(rs.getString("size_name"));
						size.setStock(rs.getInt("stock"));
						size.setListPrice(rs.getDouble("list_price"));
						size.setPrice(rs.getDouble("price"));
					}
				}			
			} catch (SQLException e) {			
				String msg = String.format("查詢指定產品(%s-%s)Size失敗", productId, colorName,sizeName);
				throw new VGBException(msg, e);
			}	
			return size;
		}

			private static final String selectALLHighToLow =  "SELECT * FROM products ORDER BY unit_price * (100-discount) / 100 DESC";
				List<Product> selectALLHighToLow() throws VGBException{
					 List<Product> list =new ArrayList<>();
				try (
						Connection connection = MySQLConnection.getConnection(); //1,2 取得連線 
						PreparedStatement pstmt = connection.prepareStatement(selectALLHighToLow); //3.準備指令
					){			
					//3.1 傳入?(0)的值
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
							p.setGendercategory(rs.getString("gendercategory"));
							list.add(p); //不要忘了
						}				
					}
				} catch (SQLException e) {
					throw new VGBException("[用價格高至低查詢產品]失敗", e);
				}
				return list;
			}		 
			private static final String selectHighToLow =  "SELECT * FROM products WHERE gendercategory= ? ORDER BY unit_price * (100-discount) / 100 DESC";
				List<Product> selectHighToLow(String gendercategory) throws VGBException{
					 List<Product> list =new ArrayList<>();
				try (
						Connection connection = MySQLConnection.getConnection(); //1,2 取得連線 
						PreparedStatement pstmt = connection.prepareStatement(selectHighToLow); //3.準備指令
					){			
					//3.1 傳入?(1)的值
					 pstmt.setString(1, gendercategory);
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
							p.setGendercategory(rs.getString("gendercategory"));
							list.add(p); //不要忘了
						}				
					}
				} catch (SQLException e) {
					throw new VGBException("[用價格高至低查詢產品]失敗", e);
				}
				return list;
			}		
				private static final String selectALLLowToHigh =  "SELECT * FROM products ORDER BY unit_price * (100-discount) / 100";
				List<Product> selectALLLowToHigh() throws VGBException{
					 List<Product> list =new ArrayList<>();
				try (
						Connection connection = MySQLConnection.getConnection(); //1,2 取得連線 
						PreparedStatement pstmt = connection.prepareStatement(selectALLLowToHigh); //3.準備指令
					){			
					//3.1 傳入?(0)的值
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
							p.setGendercategory(rs.getString("gendercategory"));
							list.add(p); //不要忘了
						}				
					}
				} catch (SQLException e) {
					throw new VGBException("[用價格低質高查詢產品]失敗", e);
				}
				return list;
			}				
				private static final String selectLowToHigh =  "SELECT * FROM products WHERE gendercategory= ? ORDER BY unit_price * (100-discount) / 100";
				List<Product> selectLowToHigh(String gendercategory) throws VGBException{
					 List<Product> list =new ArrayList<>();
				try (
						Connection connection = MySQLConnection.getConnection(); //1,2 取得連線 
						PreparedStatement pstmt = connection.prepareStatement(selectLowToHigh); //3.準備指令
					){			
					//3.1 傳入?(1)的值
					 pstmt.setString(1, gendercategory);
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
							p.setGendercategory(rs.getString("gendercategory"));
							list.add(p); //不要忘了
						}				
					}
				} catch (SQLException e) {
					throw new VGBException("[用價格低質高查詢產品]失敗", e);
				}
				return list;
			}
				 private static final String selectgendercategory="SELECT * FROM ksc.products where gendercategory  LIKE ? ";
				 	List<Product> selectgendercategory(String gendercategory) throws VGBException{
				 			 List<Product> list =new ArrayList<>();
				 			 try ( Connection connection = MySQLConnection.getConnection();//1,2取得連線
				 				   PreparedStatement pstmt = connection.prepareStatement(selectgendercategory);//3. 準備指令
				 					 ){
				 				 //3.1傳入?(1個)的值
				 				 pstmt.setString(1, gendercategory);
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
//				 							 Outlet outlet = new Outlet();
//				 							 outlet.setDiscount(discount);
//				 							 p =outlet;
				 							 
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
				 						 p.setGendercategory(rs.getString("gendercategory"));
				 						 list.add(p);
				 						 
				 					 }
				 				 }

				 			} catch (SQLException e) {
				 				throw new VGBException("查詢全部產品失敗",e);
				 			}
				 			 
				 			 return list;
				 }
				 private static final String selectcategetgendercategory="SELECT * FROM ksc.products where gendercategory  LIKE ? AND category Like ? ";
				 	List<Product> selectcategetgendercategory(String gendercategory,String category) throws VGBException{
				 			 List<Product> list =new ArrayList<>();
				 			 try ( Connection connection = MySQLConnection.getConnection();//1,2取得連線
				 				   PreparedStatement pstmt = connection.prepareStatement(selectcategetgendercategory);//3. 準備指令
				 					 ){
				 				 //3.1傳入?(1個)的值
				 				 pstmt.setString(1, gendercategory);
				 				 pstmt.setString(2, category);
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
//				 							 Outlet outlet = new Outlet();
//				 							 outlet.setDiscount(discount);
//				 							 p =outlet;
				 							 
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
				 						 p.setGendercategory(rs.getString("gendercategory"));
				 						 list.add(p);
				 						 
				 					 }
				 				 }

				 			} catch (SQLException e) {
				 				throw new VGBException("查詢全部產品失敗",e);
				 			}
				 			 
				 			 return list;
				 }
	}


