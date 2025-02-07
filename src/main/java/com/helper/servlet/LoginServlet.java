package com.helper.servlet;

import java.io.IOException;
import java.io.PrintWriter;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

import com.helper.FactoryProvider;
import com.helper.dao.UserDao;
import com.helper.entities.User;



@WebServlet("/LoginServlet")
public class LoginServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;

	
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		  
		response.setContentType("text/html");
		PrintWriter out = response.getWriter();
		//main coding
		
		HttpSession httpsession = request.getSession();
		
		
		String email =request.getParameter("email");
		String password=request.getParameter("password");
		
		//validation
		//authenticate user
		UserDao userDao = new UserDao(FactoryProvider.getSessionFactory());
		User user=userDao.getUserByEmailAndPassword(email, password);
		System.out.println(user);
		
		if(user == null)
		{
			out.println("<h1>Invalid details</h1>");
		
		httpsession.setAttribute("errorMessage", "Invalid Details !! Try Again..");
		response.sendRedirect("login.jsp");
		return;
	
		}else {

			httpsession.setAttribute("current-user", user);
			if(user.getUserType().equals("admin")) {
				//admin
				response.sendRedirect("admin.jsp");
			}else if(user.getUserType().equals("normal")) {
				//normal
				response.sendRedirect("normal.jsp");
			}else
			{
				out.println("Invalid user");
			}
		}
		
	}

}
