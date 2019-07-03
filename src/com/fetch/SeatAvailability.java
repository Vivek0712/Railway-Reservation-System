  package com.fetch;

import java.io.BufferedReader;
import java.io.IOException;
import java.sql.Connection;
import java.sql.*;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.google.gson.*;

import java.sql.Statement;
class Details {
	private int train_no;
	private int date;
	private String src;
	private String dest;
	public int getTrainno() {
		return train_no;
	}
	public void setTrainno(int train_no) {
		train_no = train_no;
	}
	public int getDate() {
		return date;
	}
	public void setDate(int date) {
		this.date = date;
	}
	public String getSrc() {
		return src;
	}
	public void setSrc(String src) {
		this.src = src;
	}
	public String getDest() {
		return dest;
	}
	public void setDest(String dest) {
		this.dest = dest;
	}
	
}

/**
 * Servlet implementation class SeatAvailability
 */
@WebServlet(asyncSupported = true, urlPatterns = { "/SeatAvailability" })
public class SeatAvailability extends HttpServlet {
	
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		try{
		
		Class.forName("com.mysql.jdbc.Driver");
		String[] seat= new String[4];;
		Connection con = DriverManager.getConnection("jdbc:mysql://localhost:3306/railway","root","Root123");
		BufferedReader reader = request.getReader();
		Gson gson = new Gson();
		Details c1 = gson.fromJson(reader, Details.class);
		
		int train_no =  c1.getTrainno();
		
		int date = c1.getDate();
	
		String src =  c1.getSrc();
		
		String dest= c1.getDest();
		Statement st = con.createStatement();
		String sql = "select count(seat_no) from pnr_status where train_no = "+train_no+" and source_code='"+src+"' and des_code='"+dest+"' and date_of_journey='"+date+"' and class='1A' and (status = 'CNF' or status = 'WL')";
		ResultSet rs = st.executeQuery(sql);
		
		if(rs.next()){
				seat[0] = new String(rs.getString(1));
				System.out.println(seat[0]);
				if(Integer.parseInt(seat[0]) >6){
					seat[0]= "W"+ (Integer.parseInt(seat[0])-6);
				}
				else
				{
					seat[0]=  ""+(6-Integer.parseInt(seat[0]));
				}
			}
		Statement st1 = con.createStatement();
		sql = "select count(seat_no) from pnr_status where train_no = "+train_no+" and source_code='"+src+"' and des_code='"+dest+"' and date_of_journey='"+date+"' and class='2A' and (status = 'CNF' or status = 'WL')";
		ResultSet rs1 = st1.executeQuery(sql);
		
		if(rs1.next()){
				seat[1] = new String(rs1.getString(1));
				System.out.println(seat[1]);
				if(Integer.parseInt(seat[1])>6){
					seat[1]= "W"+ (Integer.parseInt(seat[1])-6);
				}
				else
				{
					seat[1]=  ""+(6-Integer.parseInt(seat[1]));
				}
				
			}
		Statement st2 = con.createStatement();
		sql = "select count(seat_no) from pnr_status where train_no = "+train_no+" and source_code='"+src+"' and des_code='"+dest+"' and date_of_journey='"+date+"' and class='3A' and (status = 'CNF' or status = 'WL')";
		ResultSet rs2 = st2.executeQuery(sql);
		
		if(rs2.next()){
				seat[2] = new String(rs2.getString(1));
				if(Integer.parseInt(seat[2])>6){
					seat[2]= "W"+ (Integer.parseInt(seat[2])-6);
				}
				else
				{
					seat[2]=  ""+(6-Integer.parseInt(seat[2]));
				}
				
			}
		Statement st3 = con.createStatement();
		sql = "select count(seat_no) from pnr_status where train_no = "+train_no+" and source_code='"+src+"' and des_code='"+dest+"' and date_of_journey='"+date+"' and class='SL' and (status = 'CNF' or status = 'WL')";
		ResultSet rs3 = st3.executeQuery(sql);
		
		if(rs3.next()){
				seat[3] = new String(rs3.getString(1));
				if(Integer.parseInt(seat[3])>6){
					seat[3]= "W"+ (Integer.parseInt(seat[3])-6);
				}
				else
				{
					seat[3]=  ""+(6-Integer.parseInt(seat[3]));
				}
			}
		
			String result = new Gson().toJson(seat);
			response.getWriter().write(result);
			System.out.println(result);
		
		}
		
		
		catch(Exception e){
			System.out.println(e);
		}
	}

}