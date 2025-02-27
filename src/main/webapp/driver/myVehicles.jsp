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
            background-color: #f8f9fa; /* Light background */
            color: #343a40; /* Dark text */
            font-family: 'Arial', sans-serif;
        }
        .vehicle-container {
            padding: 30px;
            max-width: 1200px;
            margin: auto;
            text-align: left;
        }
        .vehicle-card {
            background-color: #ffffff; /* White background for cards */
            border-radius: 10px;
            box-shadow: 0 4px 10px rgba(0, 0, 0, 0.1); /* Subtle shadow */
            margin-bottom: 20px; /* Space between cards */
            padding: 20px; /* Padding inside cards */
        }
        .btn-custom {
            background-color: #007bff;
            color: white;
            font-weight: bold;
            border: none;
            transition: 0.3s;
        }
        .btn-custom:hover {
            background-color: #0056b3;
            color: white;
        }
        .vehicle-photo {
            width: 100px; /* Set a standard width for vehicle photos */
            height: auto; /* Maintain aspect ratio */
            border-radius: 5px; /* Optional: round the corners of the photo */
        }
    </style>
</head>
<body>

<%
    // Check if the user is logged in by checking the session
    HttpSession sessiono = request.getSession(false); // Get session if it exists
    if (sessiono == null || sessiono.getAttribute("user") == null) {
        // If session doesn't exist or user is not logged in, redirect to login page
        response.sendRedirect("login.jsp");
        return;
    }

    // Retrieve the User object from the session
    User driver = (User) sessiono.getAttribute("user");

    // Create an instance of VehicleDAO
    VehicleDAO vehicleDAO = new VehicleDAO();
    List<Vehicle> vehicles = vehicleDAO.getVehiclesByDriverId(driver.getId()); // Fetch vehicles using DAO
%>

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
