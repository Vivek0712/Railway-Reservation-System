package com.fetch;

import java.io.IOException;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.fetch.dao.TrainDetailsDao;
import com.fetch.model.Train;
import com.google.gson.*;
/**
 * Servlet implementation class TrainDetails
 */
@SuppressWarnings("serial")
@WebServlet("/getTrainDetails")
public class TrainDetails extends HttpServlet {

    
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		response.setContentType("application/json");
		response.setCharacterEncoding("UTF-8");
		TrainDetailsDao tdao = new TrainDetailsDao();
		String from =  request.getParameter("fromstation");
		String to =  request.getParameter("tostation");
		int date = Integer.parseInt(request.getParameter("date"));
		Train[] t =  tdao.getDetails(from,to,date);
		String result = new Gson().toJson(t);
		response.getWriter().write(result);
		System.out.println(result);
	
	}

}
