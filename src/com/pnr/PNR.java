package com.pnr;

import java.io.IOException;
import java.sql.Connection;
import java.sql.DriverManager;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.google.gson.Gson;

import java.sql.*;

/**
 * Servlet implementation class PNR
 */
@WebServlet("/pnrstatus")
public class PNR extends HttpServlet {
	private static final long serialVersionUID = 1L;
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		try{
			
			Class.forName("com.mysql.jdbc.Driver");
			String[] seat= new String[4];;
			Connection con = DriverManager.getConnection("jdbc:mysql://localhost:3306/railway","root","Root123");
			int pnr= Integer.parseInt(request.getParameter("pnr"));
			//String sql = " select * from pnr_status inner join station as A on( pnr_status.source_code =  A.station_code) inner join station as B on pnr_status.des_code = B.station_code inner join booking  on pnr_status.pnr_no = booking.pnr_no where booking.pnr_no ="+pnr+"";
			//String sql = "select pnr_status.pnr_no,train_no,p_name,age,gender,date_of_journey as jdate,status,seat_no,class,A.station_name as source_station_name, A.station_code as source_code,B.station_name as dest_station_name, B.station_code as dest_code,email_id,no_of_tickets,booked_date,total_cost from pnr_status inner join station as A on( pnr_status.source_code =  A.station_code) inner join station as B on pnr_status.des_code = B.station_code inner join booking  on pnr_status.pnr_no = booking.pnr_no where booking.pnr_no ="+pnr+"";
			String sql = "select pnr_status.pnr_no,pnr_status.train_no,p_name,age,gender,date_of_journey as jdate,status,seat_no,class,A.station_name as source_station_name, A.station_code as source_code,B.station_name as dest_station_name, B.station_code as dest_code,email_id,no_of_tickets,booked_date,total_cost,train_name from pnr_status inner join station as A on( pnr_status.source_code =  A.station_code) inner join station as B on pnr_status.des_code = B.station_code inner join booking  on pnr_status.pnr_no = booking.pnr_no inner join train_details on pnr_status.train_no =  train_details.train_no where pnr_status.pnr_no ="+pnr+"";
			Statement st =  con.createStatement();
			ResultSet rs =  st.executeQuery(sql);
			PNRModel[] pmodel = new PNRModel[6];
			int i=0;
			while(rs.next())
			{
				pmodel[i] = new PNRModel();
				pmodel[i].setPnr_no(rs.getInt("pnr_no"));
				pmodel[i].setTrain_no(rs.getInt("train_no"));
				pmodel[i].setTrain_name(rs.getString("train_name"));
				pmodel[i].setSource_station_code(rs.getString("source_code"));
				pmodel[i].setDest_station_code(rs.getString("dest_code"));
				pmodel[i].setSource_station_name(rs.getString("source_station_name"));
				pmodel[i].setDest_station_name(rs.getString("dest_station_name"));
				pmodel[i].setUser(rs.getString("email_id"));
				pmodel[i].setNo_of_tickets(rs.getInt("no_of_tickets"));
				pmodel[i].setBooked_date(rs.getInt("booked_date"));
				pmodel[i].setFare(rs.getDouble("total_cost"));
				pmodel[i].setJdate(rs.getInt("jdate"));
				pmodel[i].setCls(rs.getString("class"));
				pmodel[i].setPname(rs.getString("p_name"));
				pmodel[i].setAge(rs.getInt("age"));
				pmodel[i].setGen(rs.getString("gender"));
				pmodel[i].setStatus(rs.getString("status"));
				pmodel[i].setSeat(rs.getInt("seat_no"));
				i++;
			}
			
			String result = new Gson().toJson(pmodel);
			response.getWriter().write(result);
			System.out.println(result);
		}
		
		catch(Exception e){
			System.out.println(e);
		}
	}

}
