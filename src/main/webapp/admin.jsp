<%@page import="com.helper.FactoryProvider"%>
<%@page import="com.helper.dao.CategoryDao"%>
<%@page import="com.helper.dao.UserDao"%>
<%@page import="com.helper.dao.ProductDao"%>
<%@ page import="com.helper.entities.User"%>
<%@ page import="java.util.List" %>
<%@ page import="com.helper.entities.Category" %>
<%@ page import="com.helper.entities.Product" %>

<%
    // Session validation logic
    User user = (User) session.getAttribute("current-user");

    if (user == null) {
        session.setAttribute("errorMessage", "You are not logged in..! Please login.");
        response.sendRedirect("login.jsp");
        return;
    } else {
        if (user.getUserType().equals("normal")) {
            session.setAttribute("errorMessage", "You are not an admin! Do not access this page.");
            response.sendRedirect("login.jsp");
            return;
        }
    }

    // Get dynamic counts
    UserDao userDao = new UserDao(FactoryProvider.getSessionFactory());
    int userCount = userDao.getUserCount();
    
    CategoryDao categoryDao = new CategoryDao(FactoryProvider.getSessionFactory());
    int categoryCount = categoryDao.getCategoryCount();
    
    ProductDao productDao = new ProductDao(FactoryProvider.getSessionFactory());
    int productCount = productDao.getProductCount();

    // Fetch all users, categories, and products
    List<User> userList = userDao.getAllUsers();
    List<Category> categoryList = categoryDao.getCategories();
    List<Product> productList = productDao.getAllProducts();

    // Determine which section to display
    String section = request.getParameter("section");
%>

<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>Admin Panel</title>
<%@include file="/component/common_css_js.jsp"%>
<link href="css/admin.css" rel="stylesheet">
</head>
<body>
	<%@include file="/component/navbar.jsp"%>

	<div class="container-fluid">
	<div class="container-fluid">
	<%@include file="/component/meassage.jsp"%>
	</div>
	
		<div class="row">
			<!-- Sidebar -->
			<div class="col-md-3 sidebar">
				<h3 class="text-center mb-4" style="color: white;">Admin Panel</h3>
				<a href="admin.jsp?section=dashboard" class="<%= "dashboard".equals(section) ? "active" : "" %>">
					<i class="fas fa-tachometer-alt"></i> Dashboard
				</a>
				<a href="admin.jsp?section=users" class="<%= "users".equals(section) ? "active" : "" %>">
					<i class="fas fa-users"></i> Users
				</a>
				<a href="admin.jsp?section=categories" class="<%= "categories".equals(section) ? "active" : "" %>">
					<i class="fas fa-list"></i> Categories
				</a>
				<a href="admin.jsp?section=products" class="<%= "products".equals(section) ? "active" : "" %>">
					<i class="fas fa-box"></i> Products
				</a>
				<a href="#" data-bs-toggle="modal" data-bs-target="#addCategoryModal">
					<i class="fas fa-plus"></i> Add Category
				</a>
				<a href="#" data-bs-toggle="modal" data-bs-target="#addProductModal">
					<i class="fas fa-plus"></i> Add Product
				</a>
				<a href="login.jsp">
					<i class="fas fa-sign-out-alt"></i> Logout
				</a>
			</div>

			<!-- Main Content -->
			<div class="col-md-9">
				<div class="dashboard-header">
					<h2>Admin Dashboard</h2>
				</div>

				<% if (section == null || "dashboard".equals(section)) { %>
					<!-- Dynamic Count Cards -->
					<div class="row mt-4">
						<div class="col-md-4">
							<div class="card text-center p-4">
								<i class="fas fa-users card-icon"></i>
								<h3>Users</h3>
								<p class="display-4"><%= userCount %></p>
							</div>
						</div>
						<div class="col-md-4">
							<div class="card text-center p-4">
								<i class="fas fa-list card-icon"></i>
								<h3>Categories</h3>
								<p class="display-4"><%= categoryCount %></p>
							</div>
						</div>
						<div class="col-md-4">
							<div class="card text-center p-4">
								<i class="fas fa-box card-icon"></i>
								<h3>Products</h3>
								<p class="display-4"><%= productCount %></p>
							</div>
						</div>
					</div>

					<!-- Add Buttons -->
					<div class="row mt-4">
						<div class="col-md-6">
							<div class="card text-center p-4">
								<i class="fas fa-plus card-icon"></i>
								<h3>Add Category</h3>
								<button class="btn btn-primary btn-lg" data-bs-toggle="modal"
									data-bs-target="#addCategoryModal">Add Category</button>
							</div>
						</div>
						<div class="col-md-6">
							<div class="card text-center p-4">
								<i class="fas fa-plus card-icon"></i>
								<h3>Add Product</h3>
								<button class="btn btn-primary btn-lg" data-bs-toggle="modal"
									data-bs-target="#addProductModal">Add Product</button>
							</div>
						</div>
					</div>
				<% } else if ("users".equals(section)) { %>
					<!-- Users Table -->
					<div class="card mt-4">
						<div class="card-header">
							<h4>All Users</h4>
						</div>
						<div class="card-body">
							<table class="table table-striped">
								<thead>
									<tr>
										<th>ID</th>
										<th>Name</th>
										<th>Email</th>
										<th>Type</th>
									</tr>
								</thead>
								<tbody>
									<% for (User u : userList) { %>
										<tr>
											<td><%= u.getUserId() %></td>
											<td><%= u.getUserName() %></td>
											<td><%= u.getUserEmail() %></td>
											<td><%= u.getUserType() %></td>
										</tr>
									<% } %>
								</tbody>
							</table>
						</div>
					</div>
				<% } else if ("categories".equals(section)) { %>
					<!-- Categories Table -->
					<div class="card mt-4">
						<div class="card-header">
							<h4>All Categories</h4>
						</div>
						<div class="card-body">
							<table class="table table-striped">
								<thead>
									<tr>
										<th>ID</th>
										<th>Title</th>
										<th>Description</th>
									</tr>
								</thead>
								<tbody>
									<% for (Category cat : categoryList) { %>
										<tr>
											<td><%= cat.getCategoryId() %></td>
											<td><%= cat.getCategoryTitle() %></td>
											<td><%= cat.getCategoryDescription() %></td>
										</tr>
									<% } %>
								</tbody>
							</table>
						</div>
					</div>
				<% } else if ("products".equals(section)) { %>
					<!-- Products Table -->
					<div class="card mt-4">
						<div class="card-header">
							<h4>All Products</h4>
						</div>
						<div class="card-body">
							<table class="table table-striped">
								<thead>
									<tr>
										<th>ID</th>
										<th>Name</th>
										<th>Price</th>
										<th>Category</th>
									</tr>
								</thead>
								<tbody>
									<% for (Product p : productList) { %>
										<tr>
											<td><%= p.getpId() %></td>
											<td><%= p.getpName() %></td>
											<td>$<%= p.getpPrice() %></td>
											<td><%= p.getCategory().getCategoryTitle() %></td>
										</tr>
									<% } %>
								</tbody>
							</table>
						</div>
					</div>
				<% } %>
			</div>
		</div>
	</div>

	<!-- Modals (remain unchanged) -->
<!-- Add Product Modal -->
<div class="modal fade" id="addProductModal" tabindex="-1" aria-labelledby="addProductModalLabel" aria-hidden="true">
  <div class="modal-dialog">
    <div class="modal-content">
      <div class="modal-header">
        <h5 class="modal-title" id="addProductModalLabel">Add Product</h5>
        <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
      </div>
      <div class="modal-body">
        <form action="your_action_url_for_product" method="POST" enctype="multipart/form-data">
          <div class="mb-3">
            <label for="productName" class="form-label">Product Name</label>
            <input type="text" class="form-control" id="productName" name="pName" required>
          </div>
          <div class="mb-3">
            <label for="productPhoto" class="form-label">Product Photo</label>
            <input type="file" class="form-control" id="productPhoto" name="pPhoto" required>
          </div>
          <div class="mb-3">
            <label for="productDescription" class="form-label">Product Description</label>
            <textarea class="form-control" id="productDescription" name="pDescription" required></textarea>
          </div>
          <div class="mb-3">
            <label for="productPrice" class="form-label">Product Price</label>
            <input type="number" class="form-control" id="productPrice" name="pPrice" required>
          </div>
          <div class="mb-3">
            <label for="productDiscount" class="form-label">Product Discount</label>
            <input type="number" class="form-control" id="productDiscount" name="pDiscount" required>
          </div>
          <div class="mb-3">
            <label for="productQuantity" class="form-label">Product Quantity</label>
            <input type="number" class="form-control" id="productQuantity" name="pQuantity" required>
          </div>
          <div class="mb-3">
            <label for="categorySelect" class="form-label">Category</label>
            <select class="form-select" id="categorySelect" name="categoryId" required>
              <% for (Category cat : categoryList) { %>
                <option value="<%= cat.getCategoryId() %>"><%= cat.getCategoryTitle() %></option>
              <% } %>
            </select>
          </div>
          <button type="submit" class="btn btn-primary">Add Product</button>
        </form>
      </div>
    </div>
  </div>
</div>

	
	<!-- Add Category Modal -->
	<div class="modal fade" id="addCategoryModal" tabindex="-1"
		aria-labelledby="addCategoryModalLabel" aria-hidden="true">
		<!-- ... existing modal content ... -->
	</div>

	<!-- Add Product Modal -->
	<div class="modal fade" id="addProductModal" tabindex="-1"
		aria-labelledby="addProductModalLabel" aria-hidden="true">
		<!-- ... existing modal content ... -->
	</div>

	<script
		src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>