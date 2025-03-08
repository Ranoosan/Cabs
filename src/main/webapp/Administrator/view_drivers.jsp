<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="org.example.cab.Admin.dao.DriverDAO" %>
<%@ page import="org.example.cab.Admin.model.Driver" %>
<%@ page import="java.util.List" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>View Drivers</title>

    <!-- Bootstrap CSS -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <!-- FontAwesome Icons -->
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">

    <style>
        body {
            background-color: #f8f9fa; /* Light grey background */
            color: #333333; /* Dark grey text color */

        }
        .container {
            margin-top: 50px;
            background-color: #f8f9fa; /* Slightly lighter background for the container */
            padding: 20px;
            border-radius: 10px;
            box-shadow: 0 4px 10px rgba(255, 255, 255, 0.1);
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
    <h2>List of Drivers</h2>
    <table class="table table-bordered table-striped">
        <thead>
        <tr>
            <th>ID</th>
            <th>Username</th>
            <th>Full Name</th>
            <th>Contact Number</th>
            <th>Email Address</th>
            <th>Residential Address</th>
            <th>License Number</th>
            <th>License Type</th>
            <th>Expiration Date</th>
            <th>Bank Account Number</th>
            <th>Emergency Contact Details</th>
            <th>Action</th>
        </tr>
        </thead>
        <tbody>
        <%
            DriverDAO driverDAO = new DriverDAO();
            List<Driver> drivers = driverDAO.getAllDrivers();
            for (Driver driver : drivers) {
        %>
        <tr>
            <td><%= driver.getId() %></td>
            <td><%= driver.getUsername() %></td>
            <td><%= driver.getFullName() %></td>
            <td><%= driver.getContactNumber() %></td>
            <td><%= driver.getEmailAddress() %></td>
            <td><%= driver.getResidentialAddress() %></td>
            <td><%= driver.getvehicleType() %></td>
            <td><%= driver.getLicenseType() %></td>
            <td><%= driver.getExpirationDate() %></td>
            <td><%= driver.getBankAccountNumber() %></td>
            <td><%= driver.getEmergencyContactDetails() %></td>
            <td>
                <form action="deleteDriver.jsp" method="post" onsubmit="return confirm('Are you sure you want to delete this driver?');">
                    <input type="hidden" name="driverId" value="<%= driver.getId() %>">
                    <button type="submit" class="btn btn-danger">Delete</button>
                </form>
            </td>
        </tr>
        <%
            }
        %>
        </tbody>
    </table>
    <a href="${pageContext.request.contextPath}/Administrator/admin_dashboard.jsp" class="btn btn-primary">Back to Home</a>
</div>

<!-- Bootstrap JS -->
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>

</body>
</html>
