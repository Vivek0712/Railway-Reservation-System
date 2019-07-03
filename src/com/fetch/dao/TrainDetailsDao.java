package com.fetch.dao;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.ResultSet;
import java.sql.Statement;

import com.fetch.model.Train;

public class TrainDetailsDao {

	public Train[] getDetails(String from,String to,int num) 
	{
		Train t[] = new Train[10];
try{
			
			Class.forName("com.mysql.jdbc.Driver");
			Connection con = DriverManager.getConnection("jdbc:mysql://localhost:3306/railway","root","Root123");
	
			Statement st = con.createStatement();
			Statement st1 = con.createStatement();
			Statement st2 = con.createStatement();
			Statement st3 = con.createStatement();
			Statement st4 = con.createStatement();
			Statement st5 = con.createStatement();
			
			int no;
			ResultSet rs = null;
			int i=0;
			rs = st.executeQuery("select train_route.train_no,train_route.station_code from train_route inner join running_days on train_route.train_no = running_days.train_no where (running_days.day='all' or running_days.day='"+num+"') and (station_code='"+from+"' or station_code='"+to+"')  group by train_route.train_no having train_route.station_code = '"+from+"'and count(train_route.train_no) =2");
			//rs = st.executeQuery("select train_no,station_code,station_count from train_route  where (station_code = '"+from+"' or station_code='"+to+"') group by train_no having station_code='"+from+"' and count(train_no)=2");
			while(rs.next())
			{
			 
			 	t[i] = new Train();
			 	no = rs.getInt(1);
			 	
			 	ResultSet rs1 =  st1.executeQuery("select train_name from train_details where train_no="+no);
			 	rs1.next();
			 	t[i].setTrain_no(no);
			 	t[i].setTrain_name(rs1.getString(1));
			 	
			 	t[i].setSource_station_code(from);
			 	
			 	ResultSet rs2 = st2.executeQuery("select station_name from station where station_code='"+from+"'");
			 	rs2.next();
			 	
			 	t[i].setSource_station_name(rs2.getString(1));
			 	t[i].setDest_station_code(to);
			 	
			 	ResultSet rs3 = st3.executeQuery("select station_name from station where station_code='"+to+"'");
			 	rs3.next();
			 	t[i].setDest_station_name(rs3.getString(1));
			 	
			 	ResultSet rs4 = st4.executeQuery("Select arrival_time,departure_time from train_route where train_no="+no+" and station_code='"+from+"'");
			 	rs4.next();
			 	t[i].setSource_arrival(rs4.getString(1));
			 	t[i].setSource_departure(rs4.getString(2)); 
			 	
			 	ResultSet rs5 = st5.executeQuery("Select arrival_time,departure_time from train_route where train_no="+no+" and station_code='"+to+"'");
			 	rs5.next();
			 	t[i].setDest_arrival(rs5.getString(1));
			 	t[i].setDest_departure(rs5.getString(2)); 
			 	
			 	
			 	
			 	i++;
			 
			 	
			}
		}
		
		catch(Exception e){
			e.printStackTrace();
			
		}
		

		return t;
	}

	
}
