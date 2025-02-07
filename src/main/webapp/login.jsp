<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Login - MyEcommerce</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <%@include file="/component/common_css_js.jsp"%>
</head>
<body class="bg-light">
    <%@include file="/component/navbar.jsp"%>

    <div class="container mt-5">
        <div class="row justify-content-center">
            <div class="col-md-6 col-lg-4">
                <div class="card shadow-sm">
                    <div class="card-body p-4">
                        <h4 class="card-title text-center mb-4">
                            <i class="fas fa-sign-in-alt"></i> User Login
                        </h4>
                        <%@include file="/component/errormsg.jsp" %>
                       <form action="LoginServlet" method="post">
                            <div class="mb-3">
                                <label for="email" class="form-label">Email address</label>
                                <input type="email" class="form-control form-control-sm" 
                                       id="email" name="email" required 
                                       placeholder="Enter your email">
                            </div>
                            
                            <div class="mb-3">
                                <label for="password" class="form-label">Password</label>
                                <input type="password" class="form-control form-control-sm" 
                                       id="password" name="password" required 
                                       placeholder="Enter your password">
                            </div>
                            
                            <div class="d-grid gap-2">
                                <button type="submit" class="btn btn-primary btn-sm">
                                    <i class="fas fa-sign-in-alt"></i> Login
                                </button>
                            </div>
                        </form>

                        <div class="mt-3 text-center">
                            <a href="register.jsp" class="text-decoration-none">
                                <i class="fas fa-user-plus"></i> Create New Account
                            </a>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>

    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>