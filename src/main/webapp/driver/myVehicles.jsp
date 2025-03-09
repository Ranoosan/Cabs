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
            background-color: #121212; /* Dark background */
            color: #ffffff;
            font-family: 'Poppins', sans-serif;
        }
        .vehicle-container {
            padding: 30px;
            max-width: 1200px;
            margin: auto;
            text-align: left;
        }
        .vehicle-card {
            background-color: #1e1e1e; /* Dark card background */
            border: 2px solid #28a745; /* Green border */
            border-radius: 10px;
            box-shadow: 0 4px 10px rgba(40, 167, 69, 0.5); /* Green glowing effect */
            margin-bottom: 20px;
            padding: 20px;
            transition: 0.3s ease-in-out;
        }
        .vehicle-card:hover {
            box-shadow: 0 4px 15px rgba(40, 167, 69, 0.8); /* More glowing effect on hover */
        }
        .btn-custom {
            background-color: #28a745; /* Green background */
            color: #121212; /* Dark text */
            font-weight: bold;
            border: 2px solid #121212; /* Dark border */
            transition: 0.3s;
        }
        .btn-custom:hover {
            background-color: #121212; /* Dark background on hover */
            color: #28a745; /* Green text */
            border: 2px solid #28a745; /* Green border */
        }
        .vehicle-photo {
            width: 600px;  /* Larger width */
            height: auto;   /* Maintain aspect ratio */
            border-radius: 5px;
            cursor: pointer;
            transition: transform 0.3s ease; /* Smooth zoom effect */
        }



        .vehicle-details {
            display: none; /* Initially hide the details */
            margin-top: 20px;
        }
        .navbar {
            background-color: #1e1e1e; /* Dark navbar background */
            padding: 10px;
        }
        .navbar-brand {
            font-weight: bold;
            color: #28a745 !important; /* Green text */
        }
        .nav-link {
            color: #ffffff !important;
            transition: 0.3s;
        }
        .nav-link:hover {
            color: #28a745 !important; /* Green text on hover */
        }
        .alert-warning {
            background-color: #333333; /* Dark background for alert */
            color: #28a745; /* Green text */
            border: 1px solid #28a745; /* Green border */
        }
    </style>
</head>
<body>

<%
    HttpSession sessiono = request.getSession(false);
    if (sessiono == null || sessiono.getAttribute("users") == null) {
        response.sendRedirect("login.jsp");
        return;
    }

    User driver = (User) sessiono.getAttribute("users");
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

        <p><strong>Category:</strong> <%= vehicle.getCategory() %></p>
<%--        <p><strong>Vehicle Number:</strong> <%= vehicle.getVehicleNumber() %></p>--%>
<%--        <p><strong>Engine No:</strong> <%= vehicle.getEngineNo() %></p>--%>
<%--        <p><strong>CC:</strong> <%= vehicle.getCc() %></p>--%>
<%--        <p><strong>Fuel Type:</strong> <%= vehicle.getFuelType() %></p>--%>
<%--        <p><strong>Seat Capacity:</strong> <%= vehicle.getSeatCapacity() %></p>--%>
<%--        <p><strong>Rental Price (LKR):</strong> <%= vehicle.getRentalPrice() %></p>--%>
<%--        <p><strong>Available:</strong> <%= vehicle.isAvailable() ? "Yes" : "No" %></p>--%>

        <!-- Vehicle Image -->

        <div>
            <img src="uploads/img.png" alt="Vehicle Photo" class="vehicle-photo" onclick="toggleDetails(<%= vehicle.getId() %>)">
        </div>

        <!-- Vehicle Details (Initially hidden) -->
        <div id="details-<%= vehicle.getId() %>" class="vehicle-details">
            <h5>Vehicle ID: <%= vehicle.getId() %></h5>
            <p><strong>Category:</strong> <%= vehicle.getCategory() %></p>
            <p><strong>Vehicle Number:</strong> <%= vehicle.getVehicleNumber() %></p>
            <p><strong>Engine No:</strong> <%= vehicle.getEngineNo() %></p>
            <p><strong>CC:</strong> <%= vehicle.getCc() %></p>
            <p><strong>Fuel Type:</strong> <%= vehicle.getFuelType() %></p>
            <p><strong>Seat Capacity:</strong> <%= vehicle.getSeatCapacity() %></p>
            <p><strong>Rental Price (LKR):</strong> <%= vehicle.getRentalPrice() %></p>
            <p><strong>Available:</strong> <%= vehicle.isAvailable() ? "Yes" : "No" %></p>
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

<!-- Custom JavaScript to toggle vehicle details -->
<script>
    function toggleDetails(vehicleId) {
        var details = document.getElementById('details-' + vehicleId);
        if (details.style.display === 'none' || details.style.display === '') {
            details.style.display = 'block';
        } else {
            details.style.display = 'none';
        }
    }
</script>

</body>
</html>
