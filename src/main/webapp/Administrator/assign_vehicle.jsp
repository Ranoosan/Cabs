<%@ page import="java.util.List, org.example.cab.Admin.dao.VehicleDAO, org.example.cab.Admin.model.Vehicle, org.example.cab.Admin.dao.DriverDAO, org.example.cab.Admin.model.Driver" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>

<%
  VehicleDAO vehicleDAO = new VehicleDAO();
  DriverDAO driverDAO = new DriverDAO();
  List<Vehicle> vehicles = vehicleDAO.getAllVehicles();
  List<Driver> drivers = driverDAO.getAllDrivers(); // Default to all drivers

  // Handle form submission
  if ("POST".equalsIgnoreCase(request.getMethod())) {
    int vehicleId = Integer.parseInt(request.getParameter("vehicleId"));
    int driverId = Integer.parseInt(request.getParameter("driverId"));
    boolean assigned = vehicleDAO.assignVehicleToDriver(vehicleId, driverId);
    if (assigned) {
      out.println("<script>alert('Vehicle assigned successfully!'); </script>");
    } else {
      out.println("<script>alert('Error assigning vehicle.');</script>");
    }
    // Re-fetch vehicles after the assignment to get the updated driver name
    vehicles = vehicleDAO.getAllVehicles();
  }
%>

<!DOCTYPE html>
<html lang="en">
<head>
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1.0">
  <title>Assign Vehicle</title>
  <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
  <style>
    body { background-color: #F8F9FA; color: #343A40; }
    .vehicle-container { display: flex; flex-wrap: wrap; justify-content: center; margin: 50px 0; }
    .vehicle-card { flex: 0 0 30%; margin: 20px; padding: 15px; border: 1px solid #ddd; border-radius: 8px; background: #fff; box-shadow: 2px 2px 10px rgba(0,0,0,0.1); }
    .vehicle-image { width: 100%; height: auto; border-radius: 5px; }
  </style>
</head>
<body>

<h2 class="text-center mt-4">Assign Driver to Vehicles</h2>
<div class="vehicle-container">
  <% for (Vehicle vehicle : vehicles) { %>
  <div class="vehicle-card">
    <img src="<%= vehicle.getVehiclePhoto() != null ? vehicle.getVehiclePhoto() : "/uploads/default-image-path.jpg" %>" class="vehicle-image" alt="Vehicle Image">
    <h5 class="mt-2">Model: <%= vehicle.getCategory() %></h5>
    <p><strong>Number:</strong> <%= vehicle.getVehicleNumber() %><br>
      <strong>Driver:</strong> <%= vehicle.getDriverName() != null ? vehicle.getDriverName() : "" %><br>

      <%=
      vehicle.getDriverId() != 0 ?
              driverDAO.getAllDrivers().stream().filter(d -> d.getId() == vehicle.getDriverId()).findFirst().get().getFullName()
              : "Not Assigned"
      %>
    </p>
    <form method="post">
      <input type="hidden" name="vehicleId" value="<%= vehicle.getId() %>">
      <label for="driverId">Assign Driver:</label>
      <select name="driverId" class="form-select" required>
        <option value="">Select Driver</option>
        <%
          // Fetch drivers based on vehicle category
          List<Driver> filteredDrivers = driverDAO.getDriversByVehicleCategory(vehicle.getCategory());
          for (Driver driver : filteredDrivers) {
        %>
        <option value="<%= driver.getId() %>"><%= driver.getFullName() %></option>
        <% } %>
      </select>
      <button type="submit" class="btn btn-primary mt-2">Assign</button>
    </form>
  </div>
  <% } %>
</div>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>