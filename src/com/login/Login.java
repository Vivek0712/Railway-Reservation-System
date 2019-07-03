package com.login;

import java.io.IOException;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.login.dao.LoginDao;
import com.login.model.LoginCredentials;

/**
 * Servlet implementation class Login
 */
@WebServlet("/verifyLogin")
public class Login extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		String username = request.getParameter("username");
		String password = request.getParameter("password");
		
		LoginDao dao = new LoginDao();
		LoginCredentials lc = dao.getLoginCredentials(username,password);
		request.setAttribute("lc", lc);
		if(!(lc.getUsername() == null || lc.getPassword() ==null)){
			HttpSession session = request.getSession();
			 session.setAttribute("username", username);
			 session.setAttribute("password", password);
		RequestDispatcher rd = request.getRequestDispatcher("homepage.jsp");
		rd.forward(request,response);
		}
		else{
			RequestDispatcher rd = request.getRequestDispatcher("index.jsp");
			rd.forward(request,response);
		  }
		}
	

	
}
