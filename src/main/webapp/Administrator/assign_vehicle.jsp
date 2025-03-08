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
      // Update pending bookings after successful assignment
      boolean updated = driverDAO.updatePendingBookings(vehicleId, driverId);

      if (updated) {
        out.println("<script>alert('Vehicle assigned and pending bookings updated successfully!'); </script>");
      } else {
        out.println("<script>alert('Vehicle assigned, but no pending bookings were updated.'); </script>");
      }

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
  <!-- FontAwesome Icons -->
  <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
  <style>
    body {
      background-color: #f8f9fa; /* Light grey background */
      color: #000000; /* Black text */
    }

    .vehicle-container {
      display: flex;
      flex-wrap: wrap;
      gap: 20px;
      padding: 20px;
      justify-content: center;
      max-width: 100%;
      overflow-y: auto;
      max-height: 80vh;
    }

    .vehicle-card {
      flex: 0 0 calc(50% - 20px);
      padding: 15px;
      border: 1px solid #ddd;
      border-radius: 8px;
      background: #ffffff; /* White background */
      box-shadow: 2px 2px 10px rgba(0,0,0,0.1);
      text-align: center;
    }

    .vehicle-image {
      width: 100%;
      height: auto;
      border-radius: 5px;
    }

    .vehicle-container::-webkit-scrollbar {
      width: 8px;
    }

    .vehicle-container::-webkit-scrollbar-thumb {
      background: #6c757d; /* Grey scrollbar */
      border-radius: 4px;
    }

    .vehicle-container::-webkit-scrollbar-track {
      background: #e9ecef;
    }

    .back-to-dashboard {
      position: absolute;
      top: 20px;
      right: 20px;
      padding: 10px 20px;
      background-color: #6c757d; /* Grey button */
      color: #000000; /* Black text */
      font-size: 16px;
      border: none;
      border-radius: 5px;
      cursor: pointer;
      box-shadow: 0 4px 8px rgba(108, 117, 125, 0.3);
      transition: background-color 0.3s ease;
    }

    .back-to-dashboard:hover {
      background-color: #5a6268; /* Darker grey */
    }

    h2 {
      color: #000000; /* Black heading */
    }

    label {
      font-weight: bold;
      color: #000000; /* Black label text */
    }

    .form-select,
    .btn-primary {
      background-color: #6c757d; /* Grey dropdown and button */
      color: #ffffff; /* White text */
      border: none;
    }

    .btn-primary:hover {
      background-color: #5a6268; /* Darker grey */
    }

  </style>

</head>
<body>
<button class="back-to-dashboard" onclick="window.location.href='admin_dashboard.jsp'">Back to Dashboard</button>

<h2 class="text-center mt-4">Assign Driver to Vehicles</h2>
<div class="vehicle-container">
  <% for (Vehicle vehicle : vehicles) { %>
  <div class="vehicle-card">
    <img src="<%= vehicle.getVehiclePhoto() != null ? vehicle.getVehiclePhoto() : "/uploads/default-image-path.jpg" %>" class="vehicle-image" alt="/uploads/default-image-path.jpg">
    <h5 class="mt-2">Model: <%= vehicle.getCategory() %></h5>
    <p><strong>Number:</strong> <%= vehicle.getVehicleNumber() %><br>
      <strong>Driver:</strong> <%= vehicle.getDriverName() != null ? vehicle.getDriverName() : "" %><br>
      <%= vehicle.getDriverId() != 0 ?
              driverDAO.getAllDrivers().stream().filter(d -> d.getId() == vehicle.getDriverId()).findFirst().get().getFullName()
              : "Not Assigned" %>
    </p>
    <form method="post">
      <input type="hidden" name="vehicleId" value="<%= vehicle.getId() %>">
      <label for="driverId">Assign Driver:</label>
      <select name="driverId" class="form-select" required>
        <option value="">Select Driver</option>
        <%
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