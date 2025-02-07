package com.helper.servlet;

import com.helper.entities.Product;
import com.helper.dao.ProductDao;
import com.helper.FactoryProvider;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.io.IOException;
import java.util.ArrayList;
import java.util.List;

@WebServlet("/AddToCartServlet")
public class AddToCartServlet extends HttpServlet {
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        int productId = Integer.parseInt(request.getParameter("productId"));
        ProductDao productDao = new ProductDao(FactoryProvider.getSessionFactory());
        Product product = productDao.getProductById(productId);

        HttpSession session = request.getSession();
        List<Product> cart = (List<Product>) session.getAttribute("cart");

        // Initialize the cart if it doesn't exist
        if (cart == null) {
            cart = new ArrayList<>();
            session.setAttribute("cart", cart);
        }

        // Check if the product is already in the cart
        boolean productExists = cart.stream().anyMatch(p -> p.getpId() == productId);

        // Add the product to the cart if it doesn't already exist
        if (!productExists) {
            cart.add(product);
            session.setAttribute("cart", cart);
        }

        // Redirect to the cart page
        response.sendRedirect("cart.jsp");
    }
}