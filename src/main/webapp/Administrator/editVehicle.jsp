<%@ page import="org.example.cab.Admin.dao.VehicleDAO" %>
<%@ page import="org.example.cab.Admin.model.Vehicle" %>
<%@ page import="org.example.cab.Admin.dao.DriverDAO" %>
<%@ page import="org.example.cab.Admin.model.Driver" %>
<%@ page import="java.util.List" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>

<%
  int vehicleId = Integer.parseInt(request.getParameter("id"));
  VehicleDAO vehicleDAO = new VehicleDAO();
  Vehicle vehicle = vehicleDAO.getVehicleById(vehicleId);
%>

<html>
<head>
  <title>Edit Vehicle</title>
  <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css">
  <style>
    body {
      background-color: #f8f9fa;
      color: #333333;
      font-family: Arial, sans-serif;
    }
    .container {
      max-width: 600px;
      margin: 50px auto;
      padding: 20px;
      background: #ffffff;
      border-radius: 8px;
      box-shadow: 4px 4px 15px rgba(0, 0, 0, 0.1);
    }
    .form-label {
      font-weight: bold;
    }
    .btn-custom {
      background: #d3d3d3;
      color: #333333;
      font-weight: bold;
      border: none;
      padding: 10px 15px;
      border-radius: 5px;
      transition: all 0.3s ease-in-out;
    }
    .btn-custom:hover {
      background: #bbbbbb;
      transform: scale(1.05);
    }
    .btn-back {
      background: #6c757d;
      color: white;
      font-weight: bold;
      padding: 10px 15px;
      border-radius: 5px;
      text-decoration: none;
      display: inline-block;
      margin-top: 10px;
    }
    .btn-back:hover {
      background: #5a6268;
      color: white;
    }
  </style>
</head>
<body>

<div class="container">
  <h2 class="text-center">Edit Vehicle Details</h2>
  <form action="EditVehicleServlet" method="post" enctype="multipart/form-data">
    <input type="hidden" name="id" value="<%= vehicle.getId() %>">

    <div class="mb-3">
      <label for="category" class="form-label">Vehicle Category:</label>
      <input type="text" class="form-control" id="category" name="category" value="<%= vehicle.getCategory() %>" required>
    </div>

    <div class="mb-3">
      <label for="vehicle_number" class="form-label">Vehicle Number:</label>
      <input type="text" class="form-control" id="vehicle_number" name="vehicle_number" value="<%= vehicle.getVehicleNumber() %>" required>
    </div>

    <div class="mb-3">
      <label for="cc" class="form-label">CC:</label>
      <input type="text" class="form-control" id="cc" name="cc" value="<%= vehicle.getCc() %>" required>
    </div>

    <div class="mb-3">
      <label for="engine_no" class="form-label">Engine Number:</label>
      <input type="text" class="form-control" id="engine_no" name="engine_no" value="<%= vehicle.getEngineNo() %>" required>
    </div>

    <div class="mb-3">
      <label for="fuel_type" class="form-label">Fuel Type:</label>
      <select class="form-select" id="fuel_type" name="fuel_type" required>
        <option value="Petrol" <%= vehicle.getFuelType().equals("Petrol") ? "selected" : "" %>>Petrol</option>
        <option value="Diesel" <%= vehicle.getFuelType().equals("Diesel") ? "selected" : "" %>>Diesel</option>
        <option value="Electric" <%= vehicle.getFuelType().equals("Electric") ? "selected" : "" %>>Electric</option>
        <option value="Hybrid" <%= vehicle.getFuelType().equals("Hybrid") ? "selected" : "" %>>Hybrid</option>
      </select>
    </div>

    <div class="mb-3">
      <label for="seat_capacity" class="form-label">Seat Capacity:</label>
      <input type="number" class="form-control" id="seat_capacity" name="seat_capacity" value="<%= vehicle.getSeatCapacity() %>" required>
    </div>

    <div class="mb-3">
      <label for="rental_price" class="form-label">Rental Price (LKR):</label>
      <input type="text" class="form-control" id="rental_price" name="rental_price" value="<%= vehicle.getRentalPrice() %>" required>
    </div>

    <div class="mb-3">
      <label for="driver_id" class="form-label">Assign Driver:</label>
      <select class="form-select" id="driver_id" name="driver_id" required>
        <option value="">Select Driver</option>
        <%
          DriverDAO driverDAO = new DriverDAO();
          List<Driver> drivers = driverDAO.getAllDrivers();
          for (Driver driver : drivers) {
        %>
        <option value="<%= driver.getId() %>" <%= driver.getId() == vehicle.getDriverId() ? "selected" : "" %>>
          <%= driver.getFullName() %> (ID: <%= driver.getId() %>)
        </option>
        <%
          }
        %>
      </select>
    </div>

    <div class="mb-3">
      <label for="vehicle_photo" class="form-label">Vehicle Photo:</label>
      <input type="file" class="form-control" id="vehicle_photo" name="vehicle_photo" accept="image/*">
    </div>

    <div class="text-center">
      <button type="submit" class="btn btn-custom">Update Vehicle</button>
    </div>

  </form>

  <div class="text-center mt-3">
    <a href="view_vehicles.jsp" class="btn btn-back">← Back to Dashboard</a>
  </div>

</div>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
