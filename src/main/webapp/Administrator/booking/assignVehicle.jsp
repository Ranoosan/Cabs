<%@ page import="java.util.List, org.example.cab.Admin.dao.VehicleDAO, org.example.cab.Admin.model.Vehicle, org.example.cab.Admin.dao.DriverDAO, org.example.cab.Admin.model.Driver" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>

<%
    VehicleDAO vehicleDAO = new VehicleDAO();
    DriverDAO driverDAO = new DriverDAO();

    // Handle form submission within the JSP
    String message = null;
    String status = null;

    if ("POST".equalsIgnoreCase(request.getMethod())) {
        try {
            int vehicleId = Integer.parseInt(request.getParameter("vehicleId"));
            int driverId = Integer.parseInt(request.getParameter("driverId"));

            boolean assigned = vehicleDAO.assignVehicleToDriver(vehicleId, driverId);

            if (assigned) {
                boolean updated = driverDAO.updatePendingBookings(vehicleId, driverId);
                if (updated) {
                    message = "Vehicle assigned successfully, and pending bookings updated!";
                    status = "success";
                } else {
                    message = "Vehicle assigned, but failed to update pending bookings!";
                    status = "warning";
                }
            } else {
                message = "Error assigning vehicle!";
                status = "danger";
            }
        } catch (Exception e) {
            e.printStackTrace();
            message = "Invalid data!";
            status = "danger";
        }
    }

    // Retrieve vehicles
    String vehicleIdParam = request.getParameter("vehicleId");
    List<Vehicle> vehicles;

    if (vehicleIdParam != null && !vehicleIdParam.isEmpty()) {
        int vehicleId = Integer.parseInt(vehicleIdParam);
        Vehicle vehicle = vehicleDAO.getVehicleById(vehicleId);
        vehicles = (vehicle != null) ? List.of(vehicle) : List.of();
    } else {
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
</head>
<body>

<div class="container mt-4">
    <h2 class="text-center">Assign Driver to Vehicle</h2>

    <% if (message != null) { %>
    <div class="alert alert-<%= status %> alert-dismissible fade show" role="alert">
        <%= message %>
        <button type="button" class="btn-close" data-bs-dismiss="alert" aria-label="Close"></button>
    </div>
    <% } %>

    <% if (vehicles.isEmpty()) { %>
    <p class="text-center">No vehicles available for assignment.</p>
    <% } else { %>
    <div class="row">
        <% for (Vehicle vehicle : vehicles) { %>
        <div class="col-md-6">
            <div class="card mb-3">
                <img src="<%= vehicle.getVehiclePhoto() != null ? vehicle.getVehiclePhoto() : "/uploads/default-image-path.jpg" %>" class="card-img-top" alt="Vehicle Image">
                <div class="card-body">
                    <h5 class="card-title">Model: <%= vehicle.getCategory() %></h5>
                    <p><strong>Number:</strong> <%= vehicle.getVehicleNumber() %></p>
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
            </div>
        </div>
        <% } %>
    </div>
    <% } %>
</div>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
