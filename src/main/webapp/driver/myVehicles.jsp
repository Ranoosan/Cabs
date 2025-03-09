<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ page import="jakarta.servlet.http.HttpSession" %>
<%@ page import="org.example.cab.Driver.model.User" %>
<%@ page import="org.example.cab.Driver.model.Vehicle" %>
<%@ page import="org.example.cab.Driver.dao.VehicleDAO" %>
<%@ page import="java.util.List" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>My Vehicles</title>

    <!-- Bootstrap CSS -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">

    <!-- Custom Styles -->
    <style>
        body {
            background-color: black;
            color: white;
            font-family: 'Arial', sans-serif;
        }
        .vehicle-container {
            padding: 30px;
            max-width: 1200px;
            margin: auto;
            text-align: left;
        }
        .vehicle-card {
            background-color: black;
            border: 2px solid yellow;
            border-radius: 10px;
            box-shadow: 0 4px 10px rgba(255, 255, 0, 0.5);
            margin-bottom: 20px;
            padding: 20px;
        }
        .btn-custom {
            background-color: yellow;
            color: black;
            font-weight: bold;
            border: 2px solid black;
            transition: 0.3s;
        }
        .btn-custom:hover {
            background-color: black;
            color: yellow;
            border: 2px solid yellow;
        }
        .vehicle-photo {
            width: 100px;
            height: auto;
            border-radius: 5px;
        }
        .navbar {
            background-color: black;
            padding: 10px;
        }
        .navbar-brand {
            font-weight: bold;
            color: yellow !important;
        }
        .nav-link {
            color: yellow !important;
            transition: 0.3s;
        }
        .nav-link:hover {
            color: white !important;
        }
    </style>
</head>
<body>

<%
    HttpSession sessiono = request.getSession(false);
    if (sessiono == null || sessiono.getAttribute("user") == null) {
        response.sendRedirect("login.jsp");
        return;
    }

    User driver = (User) sessiono.getAttribute("user");
    VehicleDAO vehicleDAO = new VehicleDAO();
    List<Vehicle> vehicles = vehicleDAO.getVehiclesByDriverId(driver.getId());
%>
<nav class="navbar navbar-expand-lg">
    <div class="container-fluid">
        <a class="navbar-brand" href="#">Cab Services</a>
        <button class="navbar-toggler" type="button" data-bs-toggle="collapse" data-bs-target="#navbarNav">
            <span class="navbar-toggler-icon"></span>
        </button>
        <div class="collapse navbar-collapse" id="navbarNav">
            <ul class="navbar-nav ms-auto">
                <li class="nav-item"><a class="nav-link" href="dashboard.jsp">Dashboard</a></li>
                <li class="nav-item"><a class="nav-link" href="myVehicles.jsp">My Vehicles</a></li>
                <li class="nav-item"><a class="nav-link" href="rides.jsp">My Rides</a></li>
                <li class="nav-item"><a class="nav-link" href="logout.jsp">Logout</a></li>
            </ul>
        </div>
    </div>
</nav>
<div class="vehicle-container">
    <h2>My Vehicles</h2>
    <p>Welcome, <%= driver.getFullName() %>! Here are your registered vehicles:</p>

    <% for (Vehicle vehicle : vehicles) { %>
    <div class="vehicle-card">
        <h5>Vehicle ID: <%= vehicle.getId() %></h5>
        <p><strong>Category:</strong> <%= vehicle.getCategory() %></p>
        <p><strong>Vehicle Number:</strong> <%= vehicle.getVehicleNumber() %></p>
        <p><strong>Engine No:</strong> <%= vehicle.getEngineNo() %></p>
        <p><strong>CC:</strong> <%= vehicle.getCc() %></p>
        <p><strong>Fuel Type:</strong> <%= vehicle.getFuelType() %></p>
        <p><strong>Seat Capacity:</strong> <%= vehicle.getSeatCapacity() %></p>
        <p><strong>Rental Price (LKR):</strong> <%= vehicle.getRentalPrice() %></p>
        <p><strong>Available:</strong> <%= vehicle.isAvailable() ? "Yes" : "No" %></p>
        <p><strong>Vehicle Photo:</strong></p>
        <div>
            <% if (vehicle.getVehiclePhoto() != null && !vehicle.getVehiclePhoto().isEmpty()) { %>
            <img src="<%= vehicle.getVehiclePhoto() %>" alt="Vehicle Photo" class="vehicle-photo">
            <% } else { %>
            No Photo
            <% } %>
        </div>
    </div>
    <% } %>

    <% if (vehicles.isEmpty()) { %>
    <div class="alert alert-warning" role="alert">
        No vehicles found.
    </div>
    <% } %>

    <a href="driverDashboard.jsp" class="btn btn-custom mt-3">Back to Dashboard</a>
    <a href="logout.jsp" class="btn btn-custom mt-3">Logout</a>
</div>

<!-- Bootstrap JS -->
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>

</body>
</html>
