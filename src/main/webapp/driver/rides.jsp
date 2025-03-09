<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ page import="jakarta.servlet.http.HttpSession" %>
<%@ page import="org.example.cab.Admin.model.Booking" %>
<%@ page import="org.example.cab.Driver.model.User" %>
<%@ page import="org.example.cab.Admin.dao.BookingDao" %>
<%@ page import="java.util.List" %>
<%@ page import="java.sql.Connection" %>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>My Booked Rides</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <style>
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
</style>
</head>

<body style="background-color: #121212; color: #28a745;">

<%
    HttpSession sessiono = request.getSession(false);
    if (sessiono == null || sessiono.getAttribute("users") == null) {
        response.sendRedirect("login.jsp");
        return;
    }

    User driver = (User) sessiono.getAttribute("users");
    Connection connection = (Connection) application.getAttribute("DB_CONNECTION");
    BookingDao bookingDAO = new BookingDao();
    List<Booking> bookings = bookingDAO.getBookingsByDriverId(driver.getId());
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

<div class="container mt-5">
    <h2 class="mb-4">My Booked Rides</h2>
    <p>Welcome, <%= driver.getFullName() %>! Here are your assigned rides:</p>

    <!-- Success/Error Message Display -->
    <%
        String statusMessage = request.getParameter("statusMessage");
        if (statusMessage != null) {
    %>
    <div class="alert alert-info" role="alert">
        <%= statusMessage %>
    </div>
    <%
        }
    %>

    <table class="table table-dark table-striped">
        <thead>
        <tr>
            <th>Booking ID</th>
            <th>Username</th>
            <th>Vehicle ID</th>
            <th>Pickup Location</th>
            <th>Drop-Off Location</th>
            <th>Payment Method</th>
            <th>Special Needs</th>
            <th>Status</th>
            <th>Booking Date</th>
            <th>Actions</th>
        </tr>
        </thead>
        <tbody>
        <%
            for (Booking booking : bookings) {
                // Get user details by username
                org.example.cab.customer.model.User customer = bookingDAO.getUserByUsername(booking.getUsername());
                String currentStatus = booking.getStatus();
                boolean isAcceptedOrRejected = "Accepted".equals(currentStatus) || "Rejected".equals(currentStatus);
        %>
        <tr>
            <td><%= booking.getBookingId() %></td>
            <td><%= booking.getUsername() %></td>
            <td><%= booking.getVehicleId() %></td>
            <td><%= booking.getPickupLocation() %></td>
            <td><%= booking.getDropoffLocation() %></td>
            <td><%= booking.getPaymentMethod() %></td>
            <td><%= booking.getSpecialRequests() %></td>
            <td><%= currentStatus %></td>
            <td><%= booking.getPickupDateTime() %></td>
            <td>
                <%
                    // If booking is already accepted or rejected, disable both buttons
                    if (isAcceptedOrRejected) {
                %>
                <span class="btn btn-secondary disabled">Already Accepted/Rejected</span>
                <%
                } else {
                %>
                <a href="updateBookingStatus.jsp?bookingId=<%= booking.getBookingId() %>&status=Accepted" class="btn btn-success">Accept</a>
                <a href="updateBookingStatus.jsp?bookingId=<%= booking.getBookingId() %>&status=Rejected" class="btn btn-danger">Reject</a>
                <%
                    }
                %>
            </td>
        </tr>
        <% } %>
        </tbody>
    </table>

    <% if (bookings.isEmpty()) { %>
    <div class="alert alert-warning" role="alert">
        No booked rides found.
    </div>
    <% } %>

    <a href="driverDashboard.jsp" class="btn btn-primary mt-3">Back to Dashboard</a>
    <a href="logout.jsp" class="btn btn-danger mt-3">Logout</a>
</div>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>

</body>
</html>
