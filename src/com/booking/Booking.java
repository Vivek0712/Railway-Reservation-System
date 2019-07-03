package com.booking;

import java.io.BufferedReader;
import java.io.IOException;
import java.sql.SQLException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.booking.model.BookingModel;
import com.booking.model.PassengerModel;
import com.fetch.dao.BookingDao;
import com.google.gson.Gson;


/**
 * Servlet implementation class Booking
 */
@WebServlet("/confBooking")
public class Booking extends HttpServlet {
	
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		System.out.println("In Booking");
		
		HttpSession session = request.getSession();
		String user = (String) session.getAttribute("username");
		BufferedReader reader = request.getReader();
		Gson gson = new Gson();
		BookingModel bm = gson.fromJson(reader, BookingModel.class);
		BookingDao bdao = new BookingDao();
		try {
			bdao.allocateSeat(user,bm.getTrain_no(),bm.getNo_of_tickets(),bm.getDate(),bm.getBooked_class(),bm.getCurr_status(),bm.getPlist(),bm.getBooked_source(),bm.getBooked_dest(),bm.getJdate());
		} catch (SQLException e) {
			e.printStackTrace();
		}
		
	}

}
