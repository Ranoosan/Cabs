<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="jakarta.servlet.http.HttpSession" %>

<%
    HttpSession session1 = request.getSession(false);
    if (session1 == null || session1.getAttribute("admin") == null) {
        response.sendRedirect(request.getContextPath() + "/Administrator/login.jsp"); // Redirect to login if session is null
    }
%>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Admin Dashboard</title>

    <!-- Bootstrap 5 -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>

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

        .content {
            margin-left: 250px;
            padding: 20px;
        }

        .navbar {
            background: #e0e0e0; /* Soft grey navbar */
            padding: 15px;
            display: flex;
            justify-content: space-between;
            box-shadow: 0 2px 10px rgba(0, 0, 0, 0.1);
        }

        .navbar a {
            color: #333333; /* Dark grey text */
            text-decoration: none;
            font-weight: bold;
            transition: color 0.3s ease-in-out;
        }

        .navbar a:hover {
            color: #000000; /* Black on hover */
        }

        .card {
            background: #ffffff; /* White card */
            border: 1px solid #cccccc; /* Light grey border */
            color: #333333; /* Dark grey text */
            text-align: center;
            padding: 15px;
            margin: 10px 0;
            box-shadow: 4px 4px 15px rgba(0, 0, 0, 0.1);
            border-radius: 10px;
            transition: transform 0.3s ease-in-out;
        }

        .card:hover {
            transform: translateY(-5px);
            box-shadow: 6px 6px 20px rgba(0, 0, 0, 0.2);
        }

        .btn-custom {
            background: #d3d3d3; /* Light grey button */
            color: #333333; /* Dark grey text */
            font-weight: bold;
            border: none;
            padding: 10px 15px;
            border-radius: 5px;
            transition: all 0.3s ease-in-out;
        }

        .btn-custom:hover {
            background: #bbbbbb; /* Darker grey on hover */
            transform: scale(1.05);
        }

    </style>
</head>
<body>

<!-- Sidebar Navigation -->
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

<!-- Main Content -->
<div class="content">

    <!-- Top Navbar -->
    <div class="navbar">
        <h3>Admin Dashboard</h3>
        <% if (session1 != null && session1.getAttribute("admin") != null) { %>
        <a href="${pageContext.request.contextPath}/Administrator/login.jsp" class="btn btn-danger btn-sm">Logout</a>
        <% } %>
    </div>

    <!-- Dashboard Cards -->
    <div class="container mt-4">
        <div class="row">
            <div class="col-md-4">
                <div class="card">
                    <i class="fas fa-users fa-2x"></i>
                    <h5 class="mt-2">Total Drivers</h5>
                    <h3>120</h3>
                </div>
            </div>
            <div class="col-md-4">
                <div class="card">
                    <i class="fas fa-car fa-2x"></i>
                    <h5 class="mt-2">Total Vehicles</h5>
                    <h3>45</h3>
                </div>
            </div>
            <div class="col-md-4">
                <div class="card">
                    <i class="fas fa-calendar-check fa-2x"></i>
                    <h5 class="mt-2">Total Bookings</h5>
                    <h3>350</h3>
                </div>
            </div>
        </div>

        <!-- Admin Actions -->
        <div class="text-center mt-4">
            <a href="${pageContext.request.contextPath}/Administrator/view_drivers.jsp" class="btn btn-custom m-2"><i class="fas fa-eye"></i> View Drivers</a>
            <a href="${pageContext.request.contextPath}/Administrator/add_driver.jsp" class="btn btn-custom m-2"><i class="fas fa-user-plus"></i> Add Driver</a>
            <a href="${pageContext.request.contextPath}/Administrator/view_vehicles.jsp" class="btn btn-custom m-2"><i class="fas fa-car"></i> View Vehicles</a>
            <a href="${pageContext.request.contextPath}/Administrator/add_vehicle.jsp" class="btn btn-custom m-2"><i class="fas fa-plus"></i> Add Vehicle</a>
            <a href="${pageContext.request.contextPath}/Administrator/assign_vehicle.jsp" class="btn btn-custom m-2"><i class="fas fa-random"></i> Assign Vehicles</a>
            <a href="${pageContext.request.contextPath}/Administrator/booking/manage_booking_vehicle.jsp" class="btn btn-custom m-2"><i class="fas fa-calendar-check"></i> Manage Bookings</a>
            <a href="${pageContext.request.contextPath}/Administrator/booking/adminBookedRides.jsp" class="btn btn-custom m-2"><i class="fas fa-ban"></i> Manage Rejections</a>
            <a href="${pageContext.request.contextPath}/Administrator/coupon/manage_coupon.jsp" class="btn btn-custom m-2"><i class="fas fa-tags"></i> Manage Discounts</a>
        </div>

    </div>
</div>

</body>
</html>
