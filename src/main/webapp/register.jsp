<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Register - MyEcommerce</title>
    <!-- Bootstrap CSS -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <!-- Font Awesome for Icons -->
    <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0-beta3/css/all.min.css" rel="stylesheet">
    <!-- Custom CSS -->
    <link href="/component/style.css" rel="stylesheet">
    <%@include file="/component/common_css_js.jsp"%>
</head>
<body>
    <%@include file="/component/navbar.jsp"%>

    <!-- Registration Form -->
    <div class="container d-flex justify-content-center align-items-center vh-100">
        <div class="register-container p-4">
            <%@include file="/component/meassage.jsp"%>
            <h3 class="text-center"><i class="fas fa-user-plus"></i> Register</h3>
            <form action="RegisterServlet" method="post">

                <div class="mb-2">
                    <label for="username" class="form-label">Username</label>
                    <input type="text" class="form-control" id="username" name="username" required>
                </div>
                <div class="mb-2">
                    <label for="useremail" class="form-label">Email</label>
                    <input type="email" class="form-control" id="useremail" name="useremail" required>
                </div>
                <div class="mb-2">
                    <label for="userpassword" class="form-label">Password</label>
                    <input type="password" class="form-control" id="userpassword" name="userpassword" required>
                </div>
                <div class="mb-2">
                    <label for="userphone" class="form-label">Phone</label>
                    <input type="tel" class="form-control" id="userphone" name="userphone" required>
                </div>
                <div class="mb-2">
                    <label for="useraddress" class="form-label">Address</label>
                    <textarea class="form-control" id="useraddress" name="useraddress" rows="2" required></textarea>
                </div>

                <!-- Centered and Small Buttons -->
                <div class="d-grid gap-2">
                    <button type="submit" class="btn btn-primary btn-sm">
                        <i class="fas fa-user-plus"></i> Register
                    </button>
                    <button type="reset" class="btn btn-secondary btn-sm">
                        <i class="fas fa-undo"></i> Reset
                    </button>
                </div>
            </form>

            <!-- Login Option -->
            <div class="mt-3 text-center">
                <a href="login.jsp" class="text-decoration-none">
                    <i class="fas fa-sign-in-alt"></i> Already have an account? Login
                </a>
            </div>
        </div>
    </div>

    <!-- Bootstrap JS -->
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>