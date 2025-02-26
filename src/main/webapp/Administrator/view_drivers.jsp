<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="org.example.cab.Admin.dao.DriverDAO" %>
<%@ page import="org.example.cab.Admin.model.Driver" %>
<%@ page import="java.util.List" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>View Drivers</title>

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
    </style>
</head>
<body>

<div class="container">
    <h2>List of Drivers</h2>
    <table class="table table-bordered table-striped">
        <thead>
        <tr>
            <th>ID</th>
            <th>Username</th>
            <th>Full Name</th>
            <th>Contact Number</th>
            <th>Email Address</th>
            <th>Residential Address</th>
            <th>License Number</th>
            <th>License Type</th>
            <th>Expiration Date</th>
            <th>Bank Account Number</th>
            <th>Emergency Contact Details</th>
            <th>Action</th>
        </tr>
        </thead>
        <tbody>
        <%
            DriverDAO driverDAO = new DriverDAO();
            List<Driver> drivers = driverDAO.getAllDrivers();
            for (Driver driver : drivers) {
        %>
        <tr>
            <td><%= driver.getId() %></td>
            <td><%= driver.getUsername() %></td>
            <td><%= driver.getFullName() %></td>
            <td><%= driver.getContactNumber() %></td>
            <td><%= driver.getEmailAddress() %></td>
            <td><%= driver.getResidentialAddress() %></td>
            <td><%= driver.getLicenseNumber() %></td>
            <td><%= driver.getLicenseType() %></td>
            <td><%= driver.getExpirationDate() %></td>
            <td><%= driver.getBankAccountNumber() %></td>
            <td><%= driver.getEmergencyContactDetails() %></td>
            <td>
                <form action="deleteDriver.jsp" method="post" onsubmit="return confirm('Are you sure you want to delete this driver?');">
                    <input type="hidden" name="driverId" value="<%= driver.getId() %>">
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
