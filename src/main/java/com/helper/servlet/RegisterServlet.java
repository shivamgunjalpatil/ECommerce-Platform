package com.helper.servlet;

import java.io.IOException;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

import org.hibernate.Session;
import org.hibernate.Transaction;

import com.helper.FactoryProvider;
import com.helper.entities.User;

@WebServlet("/RegisterServlet")
public class RegisterServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;
    
    protected void doPost(HttpServletRequest request, HttpServletResponse response) 
    	    throws ServletException, IOException {
        
        // Get session
        HttpSession session = request.getSession();
        response.setContentType("text/html");

        try {
            // Retrieve parameters
            String username = request.getParameter("username");
            String userEmail = request.getParameter("useremail");
            String userPassword = request.getParameter("userpassword");
            String userPhone = request.getParameter("userphone");
            String userAddress = request.getParameter("useraddress");

            // Validate username
            if (username == null || username.trim().isEmpty()) {
                session.setAttribute("errorMessage", "Name cannot be blank!");
                response.sendRedirect("register.jsp");
                return;
            }

            // Validate email format
            if (userEmail == null || !userEmail.matches("^[A-Za-z0-9+_.-]+@[A-Za-z0-9.-]+$")) {
                session.setAttribute("errorMessage", "Invalid email format!");
                response.sendRedirect("register.jsp");
                return;
            }

            // Create User object
            User user = new User(username, userEmail, userPassword, userPhone, "default.jpg", userAddress);

            // Hibernate session and transaction
            Session hibernateSession = FactoryProvider.getSessionFactory().openSession();
            Transaction tx = hibernateSession.beginTransaction();

            // Persist the user
            hibernateSession.persist(user);

            // Commit transaction
            tx.commit();
            hibernateSession.close();

            // Retrieve auto-generated user ID
            int userId = user.getUserId();

            // Success message
            session.setAttribute("successMessage","Resistered Successfully! "+userId +"🎉");
            response.sendRedirect("register.jsp");

        } catch (Exception e) {
            e.printStackTrace();
            session.setAttribute("errorMessage", "Something went wrong! Please try again.");
            response.sendRedirect("register.jsp");
        }
    }
}
