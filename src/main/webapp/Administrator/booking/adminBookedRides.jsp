<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ page import="jakarta.servlet.http.HttpSession" %>
<%@ page import="org.example.cab.Admin.model.Booking" %>
<%@ page import="org.example.cab.Admin.dao.BookingDao" %>
<%@ page import="java.util.List" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Admin - Manage Rejected Bookings</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <style>
        .booking-table {
            margin-top: 20px;
        }
        .alert {
            margin-top: 20px;
        }
    </style>
</head>
<body>

<%
    // Fetching rejected bookings from the database
    BookingDao bookingDAO = new BookingDao();
    List<Booking> rejectedBookings = bookingDAO.getAllRejectedBookings();  // Now returns a List<Booking>
%>

<div class="container mt-5">
    <h2 class="mb-4">Admin - Manage Rejected Bookings</h2>

    <!-- Display Success/Error Message -->
    <%
        String statusMessage = request.getParameter("statusMessage");
        if (statusMessage != null) {
    %>
    <div class="alert alert-info" role="alert">
        <%= statusMessage %>
    </div>
    <% } %>

    <!-- Rejected Bookings -->
    <h3>Rejected Bookings</h3>
    <table class="table table-striped booking-table">
        <thead>
        <tr>
            <th>Booking ID</th>
            <th>Username</th>
            <th>Vehicle ID</th>
            <th>Pickup Location</th>
            <th>Drop-Off Location</th>
            <th>Booking Date</th>
            <th>Status</th>
            <th>Actions</th>  <!-- Action buttons for Edit/Delete -->
        </tr>
        </thead>
        <tbody>
        <%
            if (rejectedBookings != null && !rejectedBookings.isEmpty()) {
                // Loop through the rejected bookings and display their details
                for (Booking booking : rejectedBookings) {
                    String currentStatus = booking.getStatus();
        %>
        <tr>
            <td><%= booking.getBookingId() %></td>
            <td><%= booking.getUsername() %></td>
            <td><%= booking.getVehicleId() %></td>
            <td><%= booking.getPickupLocation() %></td>
            <td><%= booking.getDropoffLocation() %></td>
            <td><%= booking.getPickupDateTime() %></td>
            <td><%= currentStatus %></td>
            <td>
                <!-- Actions for Edit and Delete -->
                <a href="assignVehicle.jsp?vehicleId=<%= booking.getVehicleId() %>" class="btn btn-success btn-sm">Assign</a>
            </td>
        </tr>
        <%
            }
        } else {
        %>
        <tr>
            <td colspan="8" class="text-center">No rejected bookings found.</td>
        </tr>
        <% } %>
        </tbody>
    </table>

    <a href="adminDashboard.jsp" class="btn btn-primary mt-3">Back to Dashboard</a>
    <a href="logout.jsp" class="btn btn-danger mt-3">Logout</a>
</div>

<!-- JavaScript -->
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>

</body>
</html>
