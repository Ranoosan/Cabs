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
    <!-- FontAwesome Icons -->
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
    <style>
        body {
            background-color: #f8f9fa; /* Light grey background */
            color: #333333; /* Dark grey text color */
        }

        .sidebar {
            width: 250px;
            height: 100vh;
            position: fixed;
            background: linear-gradient(180deg, #d3d3d3, #b0b0b0); /* Light to medium grey gradient */
            padding-top: 20px;
            box-shadow: 4px 0 10px rgba(0, 0, 0, 0.1);
        }

        .sidebar a {
            display: block;
            color: #333333; /* Dark grey text */
            padding: 12px;
            text-decoration: none;
            font-weight: 500;
            transition: all 0.3s ease-in-out;
        }

        .sidebar a:hover {
            background: #bbbbbb; /* Slightly darker grey on hover */
            color: #000000; /* Black text */
            transform: scale(1.05);
        }
        .coupon-table th, .coupon-table td {
            text-align: center;
        }
    </style>
</head>
<body>

<div class="sidebar">
    <h4 class="text-center">Admin Panel</h4>
    <a href="${pageContext.request.contextPath}/Administrator/admin_dashboard.jsp"><i class="fas fa-tachometer-alt"></i> Dashboard</a>
    <a href="${pageContext.request.contextPath}/Administrator/view_drivers.jsp"><i class="fas fa-user"></i> View Drivers</a>
    <a href="${pageContext.request.contextPath}/Administrator/add_driver.jsp"><i class="fas fa-user-plus"></i> Add Driver</a>
    <a href="${pageContext.request.contextPath}/Administrator/view_vehicles.jsp"><i class="fas fa-car"></i> View Vehicles</a>
    <a href="${pageContext.request.contextPath}/Administrator/add_vehicle.jsp"><i class="fas fa-plus"></i> Add Vehicle</a>
    <a href="${pageContext.request.contextPath}/Administrator/assign_vehicle.jsp"><i class="fas fa-random"></i> Assign Vehicles</a>
    <a href="${pageContext.request.contextPath}/Administrator/booking/manage_booking_vehicle.jsp"><i class="fas fa-calendar-check"></i> Manage Bookings</a>
    <a href="${pageContext.request.contextPath}/Administrator/booking/adminBookedRides.jsp"><i class="fas fa-ban"></i> Manage Rejections</a>
    <a href="${pageContext.request.contextPath}/Administrator/coupon/manage_coupon.jsp"><i class="fas fa-tags"></i> Manage Discounts</a>
    <a href="${pageContext.request.contextPath}/Administrator/login.jsp" class="text-danger"><i class="fas fa-sign-out-alt"></i> Logout</a>
</div>
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
