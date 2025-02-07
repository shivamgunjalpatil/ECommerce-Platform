package com.helper.servlet;

import java.io.File;
import java.io.IOException;
import java.io.PrintWriter;

import com.helper.FactoryProvider;
import com.helper.dao.CategoryDao;
import com.helper.dao.ProductDao;
import com.helper.entities.Category;
import com.helper.entities.Product;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.MultipartConfig;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import jakarta.servlet.http.Part;

@WebServlet("/AdminServlet")
@MultipartConfig(maxFileSize = 16177215) // Allows file uploads up to 16MB
public class AdminServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String action = request.getParameter("action");
        response.setContentType("text/html");
        PrintWriter out = response.getWriter();

        if ("addCategory".equals(action)) {
            String categoryTitle = request.getParameter("categoryTitle");
            String categoryDescription = request.getParameter("categoryDescription");

            // Save Category
            Category category = new Category();
            category.setCategoryTitle(categoryTitle);
            category.setCategoryDescription(categoryDescription);

            CategoryDao categoryDao = new CategoryDao(FactoryProvider.getSessionFactory());
            int catId = categoryDao.saveCategory(category);
            HttpSession httpSession = request.getSession();
            httpSession.setAttribute("successMessage", "Category Added Successfully : " + catId);
            response.sendRedirect("admin.jsp");
            return;

        } else if ("addProduct".equals(action)) {
            // Adding a new product
            String productName = request.getParameter("productName");
            String productDescription = request.getParameter("productDescription");
            int productPrice = Integer.parseInt(request.getParameter("productPrice"));
            int productDiscount = Integer.parseInt(request.getParameter("productDiscount"));
            int productQuantity = Integer.parseInt(request.getParameter("productQuantity"));
            int categoryId = Integer.parseInt(request.getParameter("categoryId"));

            // Handle Image Upload
            Part part = request.getPart("productPhoto"); // Get uploaded file
            String fileName = part.getSubmittedFileName();

            // ✅ Store images in a permanent directory inside 'webapp/img/product'
            String uploadPath = getServletContext().getRealPath("/") + "img" + File.separator + "product";
            File uploadDir = new File(uploadPath);
            if (!uploadDir.exists()) {
                uploadDir.mkdirs(); // Create folder if missing
            }

            // Save file in webapp/img/product
            part.write(uploadPath + File.separator + fileName);

            // ✅ Verify Image is saved in the correct location
            System.out.println("Image uploaded to: " + uploadPath + File.separator + fileName);

            // Save Product
            Product product = new Product();
            product.setpName(productName);
            product.setpDesciption(productDescription);
            product.setpPrice(productPrice);
            product.setpDiscount(productDiscount);
            product.setpQuantity(productQuantity);
            product.setpPhoto(fileName); // Save filename in DB

            CategoryDao cdao = new CategoryDao(FactoryProvider.getSessionFactory());
            Category category = cdao.getCategoryById(categoryId);
            product.setCategory(category);

            ProductDao pdao = new ProductDao(FactoryProvider.getSessionFactory());
            pdao.saveProduct(product);

            HttpSession httpSession = request.getSession();
            httpSession.setAttribute("successMessage", "Product Added Successfully: " + productName);
            response.sendRedirect("admin.jsp");
            return;

        } else {
            HttpSession httpSession = request.getSession();
            httpSession.setAttribute("errorMessage", "Invalid action!");
            response.sendRedirect("admin.jsp");
        }
    }
}
