<%@ page import="org.example.cab.Admin.dao.CouponDAO" %>
<%@ page import="org.example.cab.Admin.model.Coupon" %>
<%@ page import="java.util.List" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Coupon Management</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha1/dist/css/bootstrap.min.css" rel="stylesheet">
    <style>
        .coupon-table th, .coupon-table td {
            text-align: center;
        }
    </style>
</head>
<body>
<div class="container">
    <h2 class="mt-4">Coupon Management</h2>

    <!-- Create Coupon Form -->
    <h4>Create New Coupon</h4>
    <form action="create_coupon.jsp" method="post" class="mb-4">
        <div class="mb-3">
            <label for="code" class="form-label">Coupon Code</label>
            <input type="text" class="form-control" id="code" name="code" required>
        </div>
        <div class="mb-3">
            <label for="discount" class="form-label">Discount (%)</label>
            <input type="number" class="form-control" id="discount" name="discount" required min="1" max="100">
        </div>
        <div class="mb-3">
            <label for="expirationDate" class="form-label">Expiration Date</label>
            <input type="date" class="form-control" id="expirationDate" name="expirationDate" required>
        </div>
        <div class="mb-3">
            <label for="isActive" class="form-label">Is Active</label>
            <input type="checkbox" id="isActive" name="isActive">
        </div>
        <button type="submit" class="btn btn-primary">Create Coupon</button>
    </form>

    <!-- Coupon Table -->
    <h4>Existing Coupons</h4>
    <table class="table table-striped coupon-table">
        <thead>
        <tr>
            <th>ID</th>
            <th>Code</th>
            <th>Discount (%)</th>
            <th>Expiration Date</th>
            <th>Status</th>
            <th>Actions</th>
        </tr>
        </thead>
        <tbody>
        <%
            CouponDAO couponDAO = new CouponDAO();
            List<Coupon> coupons = couponDAO.getAllCoupons();
            for (Coupon coupon : coupons) {
        %>
        <tr>
            <td><%= coupon.getId() %></td>
            <td><%= coupon.getCode() %></td>
            <td><%= coupon.getDiscount() %></td>
            <td><%= coupon.getExpirationDate() %></td>
            <td><%= coupon.isActive() ? "Active" : "Inactive" %></td>
            <td>
                <a href="edit_coupon.jsp?id=<%= coupon.getId() %>" class="btn btn-warning btn-sm">Edit</a>
                <a href="delete_coupon.jsp?id=<%= coupon.getId() %>" class="btn btn-danger btn-sm">Delete</a>
            </td>
        </tr>
        <% } %>
        </tbody>
    </table>
</div>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha1/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
