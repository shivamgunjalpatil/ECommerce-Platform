<%@page import="com.helper.dao.ProductDao"%>
<%@page import="com.helper.entities.Product"%>
<%@page import="com.helper.FactoryProvider"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<!DOCTYPE html>
<html>
<head>
    <title>Product Details</title>
    <%@include file="/component/common_css_js.jsp"%>
    <link rel="stylesheet" href="css/home.css">
</head>
<body>
    <%@include file="/component/navbar.jsp"%>

    <div class="main-content">
        <%
            int productId = Integer.parseInt(request.getParameter("productId"));
            ProductDao productDao = new ProductDao(FactoryProvider.getSessionFactory());
            Product product = productDao.getProductById(productId);

            if (product != null) {
        %>
        <div class="product-details">
            <img src="img/product/<%= product.getpPhoto() %>" alt="<%= product.getpName() %>">
            <h1><%= product.getpName() %></h1>
            <p class="price">$<%= product.getpPrice() %></p>
            <p class="description"><%= product.getpDesciption() %></p>
            <a href="index.jsp" class="btn-back">Back to Products</a>
        </div>
        <%
            } else {
        %>
        <p>Product not found.</p>
        <%
            }
        %>
    </div>
</body>
</html>