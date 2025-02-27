<%@ page import="org.example.cab.Admin.dao.VehicleDAO" %>
<%@ page import="org.example.cab.Admin.model.Vehicle" %>
<%@ page import="org.example.cab.Admin.dao.DriverDAO" %>
<%@ page import="org.example.cab.Admin.model.Driver" %>
<%@ page import="org.example.cab.Admin.controller.EditVehicleServlet" %>
<%@ page import="java.util.List" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>

<%
  int vehicleId = Integer.parseInt(request.getParameter("id")); // Get vehicle ID from request
  VehicleDAO vehicleDAO = new VehicleDAO();
  Vehicle vehicle = vehicleDAO.getVehicleById(vehicleId);
%>

<html>
<head>
  <title>Edit Vehicle</title>
  <style>
    body { font-family: Arial, sans-serif; }
    .container {
      width: 50%;
      margin: auto;
      padding: 20px;
      border: 1px solid #ccc;
      border-radius: 5px;
      box-shadow: 2px 2px 12px rgba(0, 0, 0, 0.1);
    }
    label { font-weight: bold; }
    input, select {
      width: 100%;
      padding: 8px;
      margin: 5px 0;
      border: 1px solid #ccc;
      border-radius: 4px;
    }
    button {
      background-color: #007bff;
      color: white;
      padding: 10px;
      border: none;
      border-radius: 4px;
      cursor: pointer;
    }
    button:hover { background-color: #0056b3; }
  </style>
</head>
<body>

<div class="container">
  <h2>Edit Vehicle Details</h2>
  <form action="EditVehicleServlet" method="post" enctype="multipart/form-data">
    <input type="hidden" name="id" value="<%= vehicle.getId() %>">

    <label for="category">Vehicle Category:</label>
    <input type="text" id="category" name="category" value="<%= vehicle.getCategory() %>" required>

    <label for="vehicle_number">Vehicle Number:</label>
    <input type="text" id="vehicle_number" name="vehicle_number" value="<%= vehicle.getVehicleNumber() %>" required>

    <label for="cc">CC:</label>
    <input type="text" id="cc" name="cc" value="<%= vehicle.getCc() %>" required>

    <label for="engine_no">Engine Number:</label>
    <input type="text" id="engine_no" name="engine_no" value="<%= vehicle.getEngineNo() %>" required>

    <label for="fuel_type">Fuel Type:</label>
    <select id="fuel_type" name="fuel_type" required>
      <option value="Petrol" <%= vehicle.getFuelType().equals("Petrol") ? "selected" : "" %>>Petrol</option>
      <option value="Diesel" <%= vehicle.getFuelType().equals("Diesel") ? "selected" : "" %>>Diesel</option>
      <option value="Electric" <%= vehicle.getFuelType().equals("Electric") ? "selected" : "" %>>Electric</option>
      <option value="Hybrid" <%= vehicle.getFuelType().equals("Hybrid") ? "selected" : "" %>>Hybrid</option>
    </select>

    <label for="seat_capacity">Seat Capacity:</label>
    <input type="number" id="seat_capacity" name="seat_capacity" value="<%= vehicle.getSeatCapacity() %>" required>

    <label for="rental_price">Rental Price (LKR):</label>
    <input type="text" id="rental_price" name="rental_price" value="<%= vehicle.getRentalPrice() %>" required>

    <label for="driver_id">Assign Driver:</label>
    <select id="driver_id" name="driver_id" required>
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

    <label for="vehicle_photo">Vehicle Photo:</label>
    <input type="file" id="vehicle_photo" name="vehicle_photo" accept="image/*">

    <button type="submit">Update Vehicle</button>
  </form>
</div>

</body>
</html>
