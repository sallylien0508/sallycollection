package uuu.ksc.service;
import java.sql.*;
import uuu.ksc.entity.BloodType;
import uuu.ksc.entity.Customer;
import uuu.ksc.exception.LoginFailedException;
import uuu.ksc.exception.VGBException;
import uuu.ksc.exception.VGBInvalidDataException;

class CustomersDAO {
	
	private static final String SELECT_CUSTOMER_BY_ID = "SELECT id, email, password, name, birthday, gender"
			+ "	,address, phone, blood_type, subscribed FROM customers"
			+ " WHERE id=? OR email=?";
	Customer selectCustomerById(String idOrEmail) throws VGBException {
		Customer c = null;			
		try (   Connection connection = MySQLConnection.getConnection(); //1,2.取得連線
				PreparedStatement pstmt = connection.prepareStatement(SELECT_CUSTOMER_BY_ID);//3.準備指令				
			){
			//3.1 傳入?的值
			pstmt.setString(1, idOrEmail);
			pstmt.setString(2, idOrEmail);			
			try( 
				ResultSet rs = pstmt.executeQuery(); //4.執行SELECT SQL指令
			){				
				//5.處理rs
				while(rs.next()) {
					c = new Customer();
					c.setId(rs.getString("id"));
					c.setEmail(rs.getString("email"));
					c.setName(rs.getString("name"));
					c.setPassword(rs.getString("password"));
					c.setGender(rs.getString("gender").charAt(0));
					c.setBirthday(rs.getString("birthday"));					
					//先blood_type欄位的字串資料讀出來
					String bTypeString = rs.getString("blood_type");
					if(bTypeString!=null) {												
						c.setBloodType(BloodType.valueOf(bTypeString));
					}											
					c.setAddress(rs.getString("address"));
					c.setPhone(rs.getString("phone"));
					c.setSubscribed(rs.getBoolean("subscribed"));					
				}				
			}			
		} catch (SQLException e) {
			throw new VGBException("查詢客戶時執行SQL失敗", e);
		}		
		return c;
	}
	private static final String INSERT_CUSTOMER="INSERT INTO customers (id,email,password,name,birthday,gender,"
			+ "		address,phone,blood_type,subscribed) "
			+ "        VALUES (?,?,?,?,?,?, ?,?,?,?)";
	void insert(Customer c) throws VGBException {
		try(		
				Connection connection = MySQLConnection.getConnection();//1. 載入driver、2. getConnection()建立連線==>取得連線
				PreparedStatement pstmt = connection.prepareStatement(INSERT_CUSTOMER);//3. 準備指令
			){
			//3.1傳入？的值
			pstmt.setString(1,c.getId());
			pstmt.setString(2,c.getEmail());
			pstmt.setString(3,c.getPassword());
			pstmt.setString(4,c.getName());
			pstmt.setString(5,c.getBirthday().toString());
			pstmt.setString(6,String.valueOf(c.getGender()));
			
			pstmt.setString(7,c.getAddress());
			//pstmt.setString(7,"");
			pstmt.setString(8,c.getPhone());
			pstmt.setString(9,c.getBloodType()==null?null:c.getBloodType().name());
			//當c不是null就直接給null
			pstmt.setBoolean(10,c.isSubscribed());
			
			
			
//			pstmt.setString(1,c.getEmail());
//			pstmt.setString(2,c.getPassword());
//			pstmt.setString(3,c.getName());
//			pstmt.setString(4,c.getPhone());
//			pstmt.setString(5,c.getAddress());
//			pstmt.setString(6,c.getBirthday().toString());
//			pstmt.setString(7,String.valueOf(c.getGender()));
			//4. 執行insert指令
			pstmt.executeUpdate();//不會回傳rs
		}catch(SQLIntegrityConstraintViolationException e){//Duplicate Key,not null 給null值
			if(e.getMessage().indexOf("customers.PRIMARY")>0) {
				throw new VGBInvalidDataException("新增客戶失敗，帳號已經重複註冊",e);
			}else if(e.getMessage().indexOf("email_UNIQUE")>0) {
				throw new VGBInvalidDataException("新增客戶失敗，email已經重複註冊",e);
			}else {
				throw new VGBException("新增客戶失敗SQL失敗",e);
			}
			
		} catch (SQLException e) {
			throw new VGBException("新增客戶時執行SQL失敗", e);
		}
	}
	
	private static final String UPDATE_CUSTOMER="UPDATE customers "
			+ "set email=?, password=?, name=?, birthday=?, gender=?"
			+ "	,address=?, phone=?, blood_type=?, subscribed =?"
			+ "    WHERE id=?";
	void update(Customer c)throws VGBException{
		try(		
				Connection connection = MySQLConnection.getConnection();//1. 載入driver、2. getConnection()建立連線==>取得連線
				PreparedStatement pstmt = connection.prepareStatement(UPDATE_CUSTOMER);//3. 準備指令
			){
			//3.1傳入？的值
			pstmt.setString(10,c.getId());
			pstmt.setString(1,c.getEmail());
			pstmt.setString(2,c.getPassword());
			pstmt.setString(3,c.getName());
			pstmt.setString(4,c.getBirthday().toString());
			pstmt.setString(5,String.valueOf(c.getGender()));
			
			pstmt.setString(6,c.getAddress());
			//pstmt.setString(7,"");
			pstmt.setString(7,c.getPhone());
			pstmt.setString(8,c.getBloodType()==null?null:c.getBloodType().name());
			//當c不是null就直接給null
			pstmt.setBoolean(9,c.isSubscribed());
			
			
			
//			pstmt.setString(1,c.getEmail());
//			pstmt.setString(2,c.getPassword());
//			pstmt.setString(3,c.getName());
//			pstmt.setString(4,c.getPhone());
//			pstmt.setString(5,c.getAddress());
//			pstmt.setString(6,c.getBirthday().toString());
//			pstmt.setString(7,String.valueOf(c.getGender()));
			//4. 執行insert指令
			pstmt.executeUpdate();//不會回傳rs
		}catch(SQLIntegrityConstraintViolationException e){//Duplicate Key,not null 給null值
			if(e.getMessage().indexOf("customers.PRIMARY")>0) {
				throw new VGBInvalidDataException("修改客戶失敗，帳號已經重複註冊",e);
			}else if(e.getMessage().indexOf("email_UNIQUE")>0) {
				throw new VGBInvalidDataException("修改客戶失敗，email已經重複註冊",e);
			}else {
				throw new VGBException("修改客戶失敗SQL失敗",e);
			}
			
		} catch (SQLException e) {
			throw new VGBException("修改客戶時執行SQL失敗", e);
		}
	}
	
}
