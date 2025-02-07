<%@page import="com.helper.entities.Product"%>
<%@page import="java.util.List"%>
<%@page import="java.util.ArrayList"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<!DOCTYPE html>
<html>
<head>
    <title>Cart</title>
    <%@include file="/component/common_css_js.jsp"%>
    <link rel="stylesheet" href="css/home.css">
</head>
<body>
    <%@include file="/component/navbar.jsp"%>

    <div class="main-content">
        <h1>Your Cart</h1>
        <div class="row">
            <%
                // Retrieve the cart from the session
                List<Product> cart1 = (List<Product>) session.getAttribute("cart");

                // Initialize cart if it doesn't exist in the session
                if (cart1 == null) {
                    cart1 = new ArrayList<>(); // Initialize as an empty ArrayList
                    session.setAttribute("cart", cart1); // Set the cart in the session
                }

                // Check if the cart is empty
                if (cart1.isEmpty()) {
            %>
                    <p>Your cart is empty.</p>
            <%
                } else {
                    // Display each product in the cart
                    for (Product product : cart1) {
            %>
                        <div class="col-md-4">
                            <div class="product-card">
                                <img src="img/product/<%= product.getpPhoto() %>" alt="<%= product.getpName() %>">
                                <h5><%= product.getpName() %></h5>
                                <p class="price">$<%= product.getpPrice() %></p>
                                <p><%= product.getpDesciption() %></p>
                                <!-- Remove from Cart Button -->
                                <button class="btn-remove-from-cart" onclick="removeFromCart(<%= product.getpId() %>)">
                                    Remove from Cart
                                </button>
                            </div>
                        </div>
            <%
                    }
                }
            %>
        </div>
    </div>

    <script>
        function removeFromCart(productId) {
            if (confirm("Are you sure you want to remove this product from the cart?")) {
                window.location.href = "RemoveFromCartServlet?productId=" + productId;
            }
        }
    </script>
</body>
</html>