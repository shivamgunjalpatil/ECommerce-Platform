<%@page import="com.helper.entities.User" %>
<%@page import="java.util.List" %>
<%@page import="com.helper.entities.Product" %>
<%
    User user1 = (User) session.getAttribute("current-user");
    List<Product> cart = (List<Product>) session.getAttribute("cart");
    int cartCount = (cart != null) ? cart.size() : 0;
%>

<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Ecommerce Navbar</title>
    <%@include file="/component/common_css_js.jsp"%>
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.15.4/css/all.min.css">
    <style>
        .navbar {
            position: fixed;
            top: 0;
            width: 100%;
            z-index: 1000;
            background-color: #343a40;
            padding: 10px 20px;
        }
        .navbar-brand {
            color: white !important;
            font-size: 1.5rem;
        }
        .navbar-brand:hover {
            color: #ffc107 !important;
        }
        .nav-link {
            color: white !important;
            margin: 0 10px;
        }
        .nav-link:hover {
            color: #ffc107 !important;
        }
        .btn-warning {
            background-color: #ffc107;
            border: none;
        }
        .btn-warning:hover {
            background-color: #e0a800;
        }
        .cart-count {
            background-color: red;
            color: white;
            border-radius: 50%;
            padding: 2px 6px;
            font-size: 12px;
            margin-left: 5px;
        }
    </style>
</head>
<body>
    <nav class="navbar navbar-expand-lg navbar-dark">
        <div class="container-fluid">
            <a class="navbar-brand" href="index.jsp">
                <i class="fas fa-shopping-cart"></i> MyEcommerce
            </a>
            <button class="navbar-toggler" type="button" data-bs-toggle="collapse" data-bs-target="#navbarNav">
                <span class="navbar-toggler-icon"></span>
            </button>
            <div class="collapse navbar-collapse" id="navbarNav">
                <ul class="navbar-nav me-auto">
                    <li class="nav-item">
                        <a class="nav-link" href="index.jsp"><i class="fas fa-home"></i> Home</a>
                    </li>
                    <li class="nav-item">
                        <a class="nav-link" href="cart.jsp">
                            <i class="fas fa-shopping-bag"></i> MyCart
                            <span class="cart-count"><%= cartCount %></span>
                        </a>
                    </li>
                </ul>
                <ul class="navbar-nav ms-auto">
                    <%
                        if (user1 == null) {
                    %>
                            <li class="nav-item">
                                <a class="nav-link" href="login.jsp"><i class="fas fa-sign-in-alt"></i> Login</a>
                            </li>
                            <li class="nav-item">
                                <a class="btn btn-warning" href="register.jsp"><i class="fas fa-user-plus"></i> Register</a>
                            </li>
                    <%
                        } else {
                    %>
                            <li class="nav-item">
                                <a class="nav-link" href="#"><i class="fas fa-user-circle"></i> <%= user1.getUserName() %></a>
                            </li>
                            <li class="nav-item">
                                <a class="btn btn-warning" href="LogoutServlet"><i class="fas fa-sign-out-alt"></i> Logout</a>
                            </li>
                    <%
                        }
                    %>
                </ul>
            </div>
        </div>
    </nav>
</body>
</html>