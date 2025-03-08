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
    <!-- FontAwesome Icons -->
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
    <style>
        body {
            background-color: #f8f9fa; /* Light grey background */
            color: #333333; /* Dark grey text color */
        }

        .sidebar {
            width: 250px;
            height: 100vh;
            position: fixed;
            background: linear-gradient(180deg, #d3d3d3, #b0b0b0); /* Light to medium grey gradient */
            padding-top: 20px;
            box-shadow: 4px 0 10px rgba(0, 0, 0, 0.1);
        }

        .sidebar a {
            display: block;
            color: #333333; /* Dark grey text */
            padding: 12px;
            text-decoration: none;
            font-weight: 500;
            transition: all 0.3s ease-in-out;
        }

        .sidebar a:hover {
            background: #bbbbbb; /* Slightly darker grey on hover */
            color: #000000; /* Black text */
            transform: scale(1.05);
        }

        .booking-table {
            margin-top: 20px;
        }
        .alert {
            margin-top: 20px;
        }
    </style>
</head>
<body>


<div class="sidebar">
    <h4 class="text-center">Admin Panel</h4>
    <a href="${pageContext.request.contextPath}/Administrator/admin_dashboard.jsp"><i class="fas fa-tachometer-alt"></i> Dashboard</a>
    <a href="${pageContext.request.contextPath}/Administrator/view_drivers.jsp"><i class="fas fa-user"></i> View Drivers</a>
    <a href="${pageContext.request.contextPath}/Administrator/add_driver.jsp"><i class="fas fa-user-plus"></i> Add Driver</a>
    <a href="${pageContext.request.contextPath}/Administrator/view_vehicles.jsp"><i class="fas fa-car"></i> View Vehicles</a>
    <a href="${pageContext.request.contextPath}/Administrator/add_vehicle.jsp"><i class="fas fa-plus"></i> Add Vehicle</a>
    <a href="${pageContext.request.contextPath}/Administrator/assign_vehicle.jsp"><i class="fas fa-random"></i> Assign Vehicles</a>
    <a href="${pageContext.request.contextPath}/Administrator/booking/manage_booking_vehicle.jsp"><i class="fas fa-calendar-check"></i> Manage Bookings</a>
    <a href="${pageContext.request.contextPath}/Administrator/booking/adminBookedRides.jsp"><i class="fas fa-ban"></i> Manage Rejections</a>
    <a href="${pageContext.request.contextPath}/Administrator/coupon/manage_coupon.jsp"><i class="fas fa-tags"></i> Manage Discounts</a>
    <a href="${pageContext.request.contextPath}/Administrator/login.jsp" class="text-danger"><i class="fas fa-sign-out-alt"></i> Logout</a>
</div>
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
            <td>
                <!-- Actions for Assign and Delete -->
                <a href="assignVehicle.jsp?vehicleId=<%= booking.getVehicleId() %>" class="btn btn-success btn-sm">Assign</a>
                <a href="deleteBooking.jsp?bookingId=<%= booking.getBookingId() %>" class="btn btn-danger btn-sm" onclick="return confirm('So you have assigned a new driver for this booking. Are you sure you want to delete this booking?');">Delete</a>
            </td>

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

    <a href="manage_booking_vehicle.jsp" class="btn btn-primary mt-3">Back to Dashboard</a>
    <a href="logout.jsp" class="btn btn-danger mt-3">Logout</a>
</div>

<!-- JavaScript -->
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>

</body>
</html>
