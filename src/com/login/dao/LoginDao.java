package com.login.dao;

import com.login.model.LoginCredentials;
import java.sql.*;
public class LoginDao 
{
	public LoginCredentials getLoginCredentials(String username,String password)
	{
		LoginCredentials lc = new LoginCredentials();
		
		try{
			
			Class.forName("com.mysql.jdbc.Driver");
			Connection con = DriverManager.getConnection("jdbc:mysql://localhost:3306/railway","root","Root123");
	
			Statement st = con.createStatement();
			
			ResultSet rs = st.executeQuery("select * from railway.login where email='"+username+"' and pass='"+password+"'");
			
			if(rs.next())
			{
			
				lc.setUsername(rs.getString("email"));
				
				lc.setPassword(rs.getString("pass"));
			}
			System.out.println(username+" "+password);
			if(!(username == lc.getUsername() && password == lc.getPassword())){
		
			}
		}
		
		catch(Exception e){
			System.out.println(e);
			
		}
		return lc;
	}
	

}
