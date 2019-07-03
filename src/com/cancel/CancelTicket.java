package com.cancel;

import java.io.IOException;
import java.sql.Connection;
import java.sql.*;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

/**
 * Servlet implementation class CancelTicket
 */
@WebServlet("/cancelticket")
public class CancelTicket extends HttpServlet {
	private static final long serialVersionUID = 1L;
   
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		String cancelpnr = request.getParameter("cancelpnr");
		try {
			Class.forName("com.mysql.jdbc.Driver");
			Connection con = DriverManager.getConnection("jdbc:mysql://localhost:3306/railway","root","Root123");
			Statement st = con.createStatement();
			
			String src="";
			String des="";
			String cls="";
			int jdate=0;
			int c_num=0;
			int train_no=0;
			String sql = "select source_code,des_code,class,date_of_journey,count(pnr_no),train_no from pnr_status where pnr_no="+cancelpnr+"";
			ResultSet rs= st.executeQuery(sql);
			if(rs.next())
			{
				src = rs.getString(1);
				des = rs.getString(2);
				cls = rs.getString(3);
				jdate =rs.getInt(4);
				c_num = rs.getInt(5);
				train_no = rs.getInt(6);
			}
			
			Statement st1 = con.createStatement();
			String sql1 = "select seat_no from pnr_status where pnr_no="+cancelpnr+"";
			ResultSet rs1 =  st1.executeQuery(sql1);
			while(rs1.next()){
				
				//Update the status to CAN
				int seat = rs1.getInt(1);
				Statement st2 = con.createStatement();
				String sql2 = "update pnr_status set status='CAN' where pnr_no="+cancelpnr+" and seat_no="+seat+"";
				int up =  st2.executeUpdate(sql2);
				
				Statement st3 = con.createStatement();
				String sql3 = "select * from pnr_status where train_no="+train_no+" and date_of_journey='"+jdate+"' and source_code='"+src+"'and des_code='"+des+"' and class='"+cls+"' and status='WL'";
				int flag=0;
				ResultSet rs3 = st3.executeQuery(sql3);
				while(rs3.next())
				{
					if(flag==0)
					{
						String sql6 = "update pnr_status set seat_no ="+seat+" where train_no="+train_no+" and date_of_journey='"+jdate+"' and source_code='"+src+"'and des_code='"+des+"' and class='"+cls+"' and status='WL'";
						Statement st6 = con.createStatement();
						st6.executeUpdate(sql6);
						String sql4 = "update pnr_status set class='CNF' where train_no="+train_no+" and date_of_journey='"+jdate+"' and source_code='"+src+"'and des_code='"+des+"' and class='"+cls+"' and status='WL'";
						Statement st4 = con.createStatement();
						st4.executeUpdate(sql4);
						
						flag=1;
					}
					String sql5 = "update pnr_status set seat_no = seat_no -1 where train_no="+train_no+" and date_of_journey='"+jdate+"' and source_code='"+src+"'and des_code='"+des+"' and class='"+cls+"' and status='WL'";
					Statement st5 = con.createStatement();
					st5.executeUpdate(sql5);
					
				}
			
				
				
			}
			
						
		} 
		catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		
		
	}

}
