package com.helper.servlet;

import com.helper.entities.Product;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.io.IOException;
import java.util.List;

@WebServlet("/RemoveFromCartServlet")
public class RemoveFromCartServlet extends HttpServlet {
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        int productId = Integer.parseInt(request.getParameter("productId"));

        HttpSession session = request.getSession();
        List<Product> cart = (List<Product>) session.getAttribute("cart");

        // Remove the product from the cart
        if (cart != null) {
            cart.removeIf(product -> product.getpId() == productId);
            session.setAttribute("cart", cart); // Update the session
        }

        // Redirect back to the cart page
        response.sendRedirect("cart.jsp");
    }
}