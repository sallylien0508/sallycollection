package uuu.ksc.service;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;

import uuu.ksc.exception.VGBException;

class MySQLConnection {
	private static final String driver="com.mysql.cj.jdbc.Driver";//mysql 8.0.x
	private static final String url = "jdbc:mysql://localhost:3306/ksc"; //mysql 8.0.12
	private static final String userid = "root";
	private static final String pwd = "12345678"; //安裝mysql時設定的密碼
	//TODO: 從外部設定檔讀取
	static {}
	
	static Connection getConnection() throws VGBException{		
		try {
			//1.載入JDBC Driver
			Class.forName(driver);
			
			//2.建立連線
			try {
				Connection connection=
					DriverManager.getConnection(url, userid, pwd);
				return connection;
			} catch (SQLException e) {
				throw new VGBException("建立Database連線失敗",e);
			}
		} catch (ClassNotFoundException e) {
			throw new VGBException("載入JDBC Driver失敗",e);
			
		}
	}
}
