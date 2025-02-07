<%@page import="com.helper.dao.ProductDao"%>
<%@page import="com.helper.dao.CategoryDao"%>
<%@page import="com.helper.entities.Product"%>
<%@page import="com.helper.entities.Category"%>
<%@page import="java.util.List"%>
<%@page import="java.util.ArrayList"%>
<%@page import="com.helper.FactoryProvider"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<!DOCTYPE html>
<html>
<head>
    <title>TechBazaar - Modern Ecommerce</title>
    <%@include file="/component/common_css_js.jsp"%>
    <link rel="stylesheet" href="css/home.css">
    <!-- Font Awesome -->
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
</head>
<body>
    <%@include file="/component/navbar.jsp"%>

    <!-- Sidebar -->
    <div class="sidebar">
        <h3>Shop by Category</h3>
        <ul>
            <li><a href="index.jsp" class="category-link">All Products</a></li>
            <%
                CategoryDao categoryDao = new CategoryDao(FactoryProvider.getSessionFactory());
                List<Category> categoryList = categoryDao.getCategories();
                for (Category category : categoryList) {
            %>
                <li>
                    <a href="index.jsp?categoryId=<%= category.getCategoryId() %>" class="category-link">
                        <i class="fas fa-tag"></i> <%= category.getCategoryTitle() %>
                    </a>
                </li>
            <%
                }
            %>
        </ul>
    </div>

    <!-- Main Content -->
    <div class="main-content">
        <h1 class="section-title">Explore Our Collection</h1>
        
        <!-- Product Grid -->
        <div class="row">
            <%
                ProductDao productDao = new ProductDao(FactoryProvider.getSessionFactory());
                List<Product> productList;
                String categoryId = request.getParameter("categoryId");
                if (categoryId == null || categoryId.trim().equals("")) {
                    productList = productDao.getAllProducts();
                } else {
                    int cid = Integer.parseInt(categoryId.trim());
                    productList = productDao.getProductsByCategoryId(cid);
                }

                List<Product> cart1 = (List<Product>) session.getAttribute("cart");
                if (cart1 == null) {
                    cart1 = new ArrayList<>();
                    session.setAttribute("cart", cart1);
                }

                for (Product product : productList) {
                    boolean inCart = cart1.stream().anyMatch(p -> p.getpId() == product.getpId());
                    double discount = product.getpDiscount();
                    double discountedPrice = product.getpPrice() * (1 - discount / 100);
            %>
            <div class="col-md-4">
                <div class="product-card">
                    <a href="productDetails.jsp?productId=<%= product.getpId() %>" class="product-image-link">
                        <img src="img/product/<%= product.getpPhoto() %>" alt="<%= product.getpName() %>">
                    </a>
                    <h5><%= product.getpName() %></h5>
                    <div class="price-section">
                        <span class="original-price">$<%= product.getpPrice() %></span>
                        <span class="discounted-price">$<%= String.format("%.2f", discountedPrice) %></span>
                    </div>
                    <p><%= product.getpDesciption().substring(0, Math.min(product.getpDesciption().length(), 50)) %>...</p>
                    <div class="button-group">
                        <% if (!inCart) { %>
                            <button class="btn-add-to-cart" onclick="addToCart(<%= product.getpId() %>)">
                                <i class="fas fa-cart-plus"></i> Add to Cart
                            </button>
                        <% } else { %>
                            <button class="btn-remove-from-cart" onclick="removeFromCart(<%= product.getpId() %>)">
                                <i class="fas fa-trash"></i> Remove
                            </button>
                        <% } %>
                        <div class="discount-display">
                            <span class="discount-percent"><%= discount %>% off</span>
                        </div>
                    </div>
                </div>
            </div>
            <%
                }
            %>
        </div>
    </div>

    <script>
        function addToCart(productId) {
            window.location.href = "AddToCartServlet?productId=" + productId;
        }

        function removeFromCart(productId) {
            if (confirm("Are you sure you want to remove this product from the cart?")) {
                window.location.href = "RemoveFromCartServlet?productId=" + productId;
            }
        }
    </script>
</body>
</html>