<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ page import="org.example.cab.Admin.model.Vehicle" %>
<%@ page import="java.util.List" %>
<%@ page import="org.example.cab.Admin.dao.VehicleDAO" %>
<%@ page import="org.example.cab.Admin.dao.DriverDAO" %>
<!DOCTYPE html>
<html lang="en">
<head>
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1.0">
  <title>View Vehicles</title>

  <!-- Bootstrap CSS -->
  <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">

  <style>
    body {
      background-color: #2C3E50; /* Dark blue background */
      color: #ECF0F1; /* Light gray text */
    }
    .container {
      margin-top: 50px;
      background-color: #34495E; /* Slightly lighter background for the container */
      padding: 20px;
      border-radius: 10px;
      box-shadow: 0 4px 10px rgba(255, 255, 255, 0.1);
    }
    .vehicle-image {
      max-width: 100px;
      height: auto;
      border-radius: 5px;
      border: 1px solid #ccc;
    }
  </style>
</head>
<body>

<div class="container">
  <h2>List of Vehicles</h2>
  <table class="table table-bordered table-striped">
    <thead>
    <tr>
      <th>ID</th>
      <th>Category</th>
      <th>Number</th>
      <th>CC</th>
      <th>Engine No</th>
      <th>Photo</th>
      <th>Available</th>
      <th>Action</th>
    </tr>
    </thead>
    <tbody>
    <%
      VehicleDAO vehicleDAO = new VehicleDAO();
      List<Vehicle> vehicles = vehicleDAO.getAllVehicles();

        for (Vehicle vehicle : vehicles) {
    %>
    <tr>
      <td><%= vehicle.getId() %></td>
      <td><%= vehicle.getCategory() %></td>
      <td><%= vehicle.getVehicleNumber() %></td>
      <td><%= vehicle.getCc() %></td>
      <td><%= vehicle.getEngineNo() %></td>
      <td>
        <% if (vehicle.getVehiclePhoto() != null && !vehicle.getVehiclePhoto().isEmpty()) { %>
        <img src="<%= request.getContextPath() + "/" + vehicle.getVehiclePhoto() %>" class="vehicle-image">
        <% } else { %>
        No Image
        <% } %>
      </td>
      <td><%= vehicle.isAvailable() ? "Yes" : "No" %></td>
      <td>
        <form action="deleteVehicle.jsp" method="post" onsubmit="return confirm('Are you sure you want to delete this vehicle?');">
          <input type="hidden" name="vehicleId" value="<%= vehicle.getId() %>">
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
