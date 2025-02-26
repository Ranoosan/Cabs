<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ page import="org.example.cab.Admin.model.Vehicle" %>
<%@ page import="java.util.List" %>
<%@ page import="org.example.cab.Admin.dao.VehicleDAO" %>
<!DOCTYPE html>
<html lang="en">
<head>
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1.0">
  <title>Vehicle Showroom</title>

  <!-- Bootstrap CSS -->
  <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">

  <style>
    body {
      background-color: #F8F9FA; /* Light background */
      color: #343A40; /* Dark text */
    }
    .vehicle-container {
      display: flex;
      flex-wrap: wrap; /* Allow cards to wrap */
      justify-content: center; /* Center the cards */
      margin: 50px 0; /* Space around the vehicle cards */
    }
    .vehicle-card {
      flex: 0 0 45%; /* Each card takes up about 45% of the width */
      margin: 20px; /* Space between cards */
      transition: transform 0.3s;
      cursor: pointer;
    }
    .vehicle-card:hover {
      transform: scale(1.05);
    }
    .vehicle-image {
      width: 100%; /* Full width for the card image */
      height: auto;
      border-radius: 5px;
    }
  </style>
</head>
<body>

<h2 class="text-center">Vehicle Showroom</h2>
<div class="vehicle-container">
  <%
    VehicleDAO vehicleDAO = new VehicleDAO();
    List<Vehicle> vehicles = vehicleDAO.getAllVehicles();

    for (Vehicle vehicle : vehicles) {
  %>
  <div class="card vehicle-card" onclick="window.location='view_driver_details.jsp?vehicleId=<%= vehicle.getId() %>'">
    <img src="<%= request.getContextPath() + "/" + vehicle.getVehiclePhoto() %>" class="card-img-top vehicle-image" alt="Vehicle Image">
    <div class="card-body">
      <h5 class="card-title">Category: <%= vehicle.getCategory() %></h5>
      <p class="card-text">
        <strong>Number:</strong> <%= vehicle.getVehicleNumber() %><br>
        <strong>CC:</strong> <%= vehicle.getCc() %><br>
        <strong>Engine No:</strong> <%= vehicle.getEngineNo() %><br>
        <strong>Available:</strong> <%= vehicle.isAvailable() ? "Yes" : "No" %>
      </p>
    </div>
  </div>
  <%
    }
  %>
</div>
<a href="${pageContext.request.contextPath}/customer/welcome.jsp" class="btn btn-primary">Back to Home</a>

<!-- Bootstrap JS -->
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>

</body>
</html>
