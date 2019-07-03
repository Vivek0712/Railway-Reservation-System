package com.login;

import java.io.IOException;
import java.sql.SQLException;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;



import com.login.dao.SignDao;


/**
 * Servlet implementation class SignUp
 */
@WebServlet("/verifySignup")
public class SignUp extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
  
     
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		
		String username = request.getParameter("username");
		String password = request.getParameter("password");
		
		SignDao dao = new SignDao();
		boolean checkSignup = false;
		try {
			checkSignup = dao.setSignUp(username,password);
		} catch (ClassNotFoundException | SQLException e) {
			
			e.printStackTrace();
		}
		System.out.println(checkSignup);
		if(checkSignup){
		RequestDispatcher rd = request.getRequestDispatcher("login.jsp");
		rd.forward(request,response);
		}
		
		
		
	}

}
