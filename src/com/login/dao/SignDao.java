package com.login.dao;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;

public class SignDao {

	

	public boolean setSignUp(String username, String password) throws ClassNotFoundException, SQLException {
		Class.forName("com.mysql.jdbc.Driver");
		Connection con = DriverManager.getConnection("jdbc:mysql://localhost:3306/railway","root","Root123");

		Statement st = con.createStatement();
		
		ResultSet rs = st.executeQuery("select * from railway.login where email='"+username+"'");
		if(!rs.next())
		{
			String query="Insert into railway.login values('"+username+"','"+password+"')";
			st.executeUpdate(query);
		}
		
		return false;
	}

}
