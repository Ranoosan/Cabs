<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ page import="org.example.cab.Admin.dao.DriverDAO" %>
<%@ page import="org.example.cab.Admin.model.Driver" %>
<%
    String vehicleIdParam = request.getParameter("vehicleId");
    DriverDAO driverDAO = new DriverDAO();
    Driver driver = driverDAO.getDriverByVehicleId(vehicleIdParam); // Implement this method
%>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Driver Details</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
</head>
<body>

<div class="container">
    <h2>Driver Details</h2>
    <div>
        <p><strong>Name:</strong> <%= driver.getFullName() %></p>
        <p><strong>Contact Number:</strong> <%= driver.getContactNumber() %></p>
        <p><strong>Email:</strong> <%= driver.getEmailAddress() %></p>
        <p><strong>License Number :</strong> <%= driver.getLicenseNumber() %></p>
        <p><strong>License Type:</strong> <%= driver.getLicenseType() %></p>
        <p><strong>Expiry Date of the License:</strong> <%= driver.getExpirationDate() %></p>

        <!-- Add more driver details as needed -->
    </div>
    <a href="view_cus_vehicle.jsp" class="btn btn-primary">Back to Vehicles</a>
</div>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
