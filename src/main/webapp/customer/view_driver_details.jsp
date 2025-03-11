<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ page import="org.example.cab.Admin.dao.DriverDAO" %>
<%@ page import="org.example.cab.Admin.model.Driver" %>
<%@ page import="org.example.cab.customer.model.User" %>
<%@ page import="jakarta.servlet.http.HttpSession" %>

<%
    // Retrieve customer session
    HttpSession sessionObj = request.getSession(false);
    User user = null;

    if (sessionObj != null) {
        user = (User) sessionObj.getAttribute("user");
    }

    // Retrieve vehicle ID from request parameter
    String vehicleIdParam = request.getParameter("vehicleId");

    // Fetch driver details using DAO
    DriverDAO driverDAO = new DriverDAO();
    Driver driver = driverDAO.getDriverByVehicleId(vehicleIdParam); // Implement this method

    // Store the driver ID in the session if driver is found
    if (driver != null) {
        sessionObj.setAttribute("driverId", driver.getId()); // Assuming Driver has a getId() method
    } else {
        // Handle case where driver is not found
        response.sendRedirect(request.getContextPath() + "/customer/view_cus_vehicle.jsp");
        return;
    }
%>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Driver Details</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
</head>
<style>
    body {
        background-color: #f4f8fc; /* Light background to keep it clean */
        font-family: 'Roboto', sans-serif;
        color: #333;
    }

    .navbar {
        background: linear-gradient(to right, #1d72b8, #ff5f6d); /* Gradient background */
        padding: 15px 20px;
    }

    .navbar a {
        color: white;
        font-size: 16px;
    }

    .navbar a:hover {
        background-color: #222;
        border-radius: 5px;
    }

    .container {
        max-width: 900px;
        margin: 0 auto;
        padding: 30px 15px;
    }

    h2 {
        font-size: 24px;
        font-weight: bold;
        color: #1d72b8;
        text-align: center;
    }

    p {
        font-size: 16px;
        color: #555;
        line-height: 1.5;
    }

    .card {
        background-color: white;
        border-radius: 8px;
        box-shadow: 0px 4px 12px rgba(0, 0, 0, 0.1);
        margin-bottom: 30px;
    }

    .card p {
        font-size: 14px;
        color: #555;
    }

    .btn-primary {
        background-color: #007BFF;
        border: none;
        padding: 12px 20px;
        font-size: 16px;
        border-radius: 5px;
        color: white;
    }

    .btn-primary:hover {
        background-color: #0056b3;
    }

    .navbar-toggler-icon {
        background-color: white;
    }

    .navbar-nav .nav-link {
        font-size: 16px;
    }

    .navbar-nav .nav-link:hover {
        background-color: #555;
        border-radius: 5px;
    }

    /* Responsive design for smaller screens */
    @media (max-width: 768px) {
        .container {
            padding: 20px;
        }

        h2 {
            font-size: 20px;
        }

        .card p {
            font-size: 12px;
        }
    }
</style>

<body>

<!-- Navbar -->
<nav class="navbar navbar-expand-lg navbar-dark bg-dark">
    <div class="container">
        <a class="navbar-brand" href="welcome.jsp">Cab Services</a>
        <button class="navbar-toggler" type="button" data-bs-toggle="collapse" data-bs-target="#navbarNav"
                aria-controls="navbarNav" aria-expanded="false" aria-label="Toggle navigation">
            <span class="navbar-toggler-icon"></span>
        </button>
        <div class="collapse navbar-collapse" id="navbarNav">
            <ul class="navbar-nav ms-auto">
                <li class="nav-item">
                    <a class="nav-link" href="view_cus_vehicle.jsp">Vehicles</a>
                </li>
                <li class="nav-item">
                    <a class="nav-link" href="user_bookings.jsp">My Bookings</a>
                </li>
                <li class="nav-item">
                    <a class="nav-link" href="profile.jsp">Profile</a>
                </li>
                <% if (user != null) { %>
                <li class="nav-item">
                    <a class="nav-link" href="#">Welcome, <%= user.getUsername() %></a>
                </li>
                <li class="nav-item">
                    <a class="nav-link btn btn-danger btn-sm" href="login.jsp">Logout</a>
                </li>
                <% } else { %>
                <li class="nav-item">
                    <a class="nav-link btn btn-primary btn-sm" href="login.jsp">Login</a>
                </li>
                <% } %>
            </ul>
        </div>
    </div>
</nav>
<!-- End Navbar -->

<div class="container mt-4">
    <h2>Driver Details</h2>

    <% if (user != null) { %>
    <p><strong>Customer:</strong> <%= user.getUsername() %></p>
    <% } else { %>
    <p><strong>Customer:</strong> Not logged in</p>
    <% } %>

    <div class="card p-3 shadow-sm">
        <p><strong>Name:</strong> <%= driver.getFullName() %></p>
        <p><strong>Contact Number:</strong> <%= driver.getContactNumber() %></p>
        <p><strong>Email:</strong> <%= driver.getEmailAddress() %></p>
        <p><strong>Address :</strong> <%= driver.getResidentialAddress() %></p>
        <p><strong>License Type:</strong> <%= driver.getLicenseType() %></p>
        <p><strong>Expiry Date of the License:</strong> <%= driver.getExpirationDate() %></p>
    </div>

    <a href="view_cus_vehicle.jsp" class="btn btn-primary mt-3">Back to Vehicles</a>






</div>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
