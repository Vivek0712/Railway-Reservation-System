package com.fetch.dao;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.List;

import com.booking.model.*;
public class BookingDao {

	public void allocateSeat(String user, int train_no, int tickets, int date, String cls, String status, List<String> plist, String source, String dest,int jdate ) throws SQLException {
		try {
			Class.forName("com.mysql.jdbc.Driver");
			Connection con = DriverManager.getConnection("jdbc:mysql://localhost:3306/railway","root","Root123");
			
			//First generate new PNR number
			int new_pnr_no=0;
			double total_fare=0;
			int src_count=0;
			int dest_count=0;
			int total_count=0;
			double fare=0;
			Statement st = con.createStatement();
			String sql = "select max(pnr_no) from pnr_status";
			
			ResultSet rs = st.executeQuery(sql);
			if(rs.next())
			{
				new_pnr_no = Integer.parseInt(rs.getString(1))+1;
				
			}
			//Calculate Fare
			
			Statement st1 = con.createStatement();
			sql = "select station_count from train_route where station_code='"+source+"'and train_no="+train_no+"";
			
			ResultSet rs1 = st1.executeQuery(sql);
			if(rs1.next())
			{
				src_count = rs1.getInt(1);
			}
			
			Statement st2 = con.createStatement();
			sql = "select station_count from train_route where station_code='"+dest+"'and train_no="+train_no+"";
			
			ResultSet rs2 = st2.executeQuery(sql);
			if(rs2.next())
			{
				dest_count = rs2.getInt(1);
			}
			
			Statement st3 = con.createStatement();
			sql = "select count(station_count) from train_route where train_no="+train_no+"";
			
			ResultSet rs3 = st3.executeQuery(sql);
			if(rs3.next())
			{
				total_count = rs3.getInt(1);
			}
			
			Statement st4 = con.createStatement();
			sql = "select fare from seat_details where train_no="+train_no+" and class ='"+cls+"'";
			
			ResultSet rs4 = st4.executeQuery(sql);
			if(rs4.next())
			{
				fare = rs4.getInt(1);
			}
			double t = total_count;
			
			
			total_fare = ((dest_count - src_count)/ t)*fare*tickets;
			 
			System.out.println(total_fare);
			Statement st5 = con.createStatement();
			sql = "insert into booking values("+new_pnr_no+",'"+user+"',"+tickets+",'"+date+"',"+total_fare+")";
				
			int rs5 = st5.executeUpdate(sql);
			if(rs5>0)
			{
				System.out.println("Inserted Successfully");
			}
			
			//Case 1 : current status - Waiting List
			if(status.charAt(0)=='W')
			{	
				int k=0;
				int no = status.charAt(1)-48;
				System.out.println(no);
				for(int i=0;i<tickets;i++)
				{
					String pname = plist.get(k++);
					int age = Integer.parseInt(plist.get(k++));
					String gen = plist.get(k++);
					no = no+1;
					Statement st6 = con.createStatement();
					sql = "insert into pnr_status values("+new_pnr_no+","+train_no+",'"+pname+"',"+age+",'"+gen+"','"+jdate+"','"+source+"','"+dest+"','WL',"+no+",'"+cls+"')";
					int rs6 = st6.executeUpdate(sql);
					if(rs6>0)
					{
						System.out.println("Inserted Successfully");
					}
				}
			}
			//here
			//Case 2 - tickets < No of seats available
			
			if(status.charAt(0)!='W'  ){
				int num = tickets;
				int last_seat=0;
				int k =0;
				while(num>0){
					
				Statement st7 = con.createStatement();
				sql = "select coalesce(MAX(seat_no), 0) from pnr_status where train_no ="+train_no+" and date_of_journey='"+jdate+"' and source_code = '"+source+"' and des_code='"+dest+"' and (status='CNF' or status ='CAN') and class = '"+cls+"'";
				
				ResultSet rs7 = st7.executeQuery(sql);
				
				Statement st15 = con.createStatement();
				String sql1 = "select station_count from train_route where train_no ="+train_no+"  and station_code = '"+source+"'";
				
				ResultSet rs15 = st15.executeQuery(sql1);
				int scount=0;
				if(rs15.next()){
				scount = rs15.getInt(1);
					
				}
				
				if(rs7.next()){
					last_seat = rs7.getInt(1);
					
				}
				// No tickets booked in that class so far or available seats are sufficient to allocate tickets without considering cancelled tickets
				System.out.println(last_seat);
				if(last_seat==0 ||  last_seat%6!=0){
					int seat_no=last_seat+1;
					System.out.println("k="+k);
					String pname = plist.get(k++);
					int age = Integer.parseInt(plist.get(k++));
					String gen = plist.get(k++);
					Statement st8 = con.createStatement();
					sql = "insert into pnr_status values("+new_pnr_no+","+train_no+",'"+pname+"',"+age+",'"+gen+"','"+jdate+"','"+source+"','"+dest+"','CNF',"+seat_no+",'"+cls+"')";
					int rs8 = st8.executeUpdate(sql);
					num--;
				}
				//Case 3 -to allocate cancelled tickets
				else{
					Statement st9 = con.createStatement();
					sql = "select seat_no from pnr_status where train_no ="+train_no+" and date_of_journey='"+jdate+"' and source_code = '"+source+"' and des_code='"+dest+"' and status='CAN' and class = '"+cls+"'";
					ResultSet rs9 = st9.executeQuery(sql);
					while(rs9.next()){
						int seat =  rs9.getInt(1);
						System.out.println("Cancelled :"+ seat);
						String sql2 = "select seat_no from pnr_status where train_no ="+train_no+" and date_of_journey='"+jdate+"' and source_code = '"+source+"' and des_code='"+dest+"' and status='CNF' and class = '"+cls+"' and seat_no = "+seat+"";
						Statement st10 = con.createStatement();
						ResultSet rs10 = st10.executeQuery(sql2);
						System.out.println("k = "+k);
						
						if(!rs10.next()){
							System.out.println("Cancelled :"+ seat + "Allocated" );
							String pname = plist.get(k++);
							int age = Integer.parseInt(plist.get(k++));
							String gen = plist.get(k++);
							String sql11 = "insert into pnr_status values("+new_pnr_no+","+train_no+",'"+pname+"',"+age+",'"+gen+"','"+jdate+"','"+source+"','"+dest+"','CNF',"+seat+",'"+cls+"')";
							Statement st11 = con.createStatement();
							int res = st11.executeUpdate(sql11);
							if(res>0){
								System.out.println("Inserted Successfully");
							}
							
							num--;
							break;
						}
						
						
						
					}
					if(num>0){
					System.out.println("out else");
					Statement st13 = con.createStatement();
					String sql3 = "select count(seat_no) from pnr_status where  train_no ="+train_no+" and date_of_journey='"+jdate+"' and source_code = '"+source+"' and des_code='"+dest+"' and status='CNF' and class = '"+cls+"'";
					ResultSet rs13= st13.executeQuery(sql3);
					if(rs13.next())
					{    
						int total =  rs13.getInt(1);
						System.out.println("Confirmed Seats count = "+ total);
						if(total == 6){
							int remaining = num;
							for(int i =1;i<=remaining; i++){
								String pname = plist.get(k++);
								int age = Integer.parseInt(plist.get(k++));
								String gen = plist.get(k++);
								String sql4 = "insert into pnr_status values("+new_pnr_no+","+train_no+",'"+pname+"',"+age+",'"+gen+"','"+jdate+"','"+source+"','"+dest+"','WL',"+i+",'"+cls+"')";
								Statement st14 = con.createStatement();
								int res = st14.executeUpdate(sql4);
								if(res>0){
									System.out.println("Inserted Successfully");
								}
								
								
								
							}
							num=0;
						}
						
						
					}
					}
				}// end else
				
				
				
				
			} //end of while
				
				
			
			
			
		} 
			
			
			
			
		}
		
		catch (ClassNotFoundException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		
		
	}
	
	

}
