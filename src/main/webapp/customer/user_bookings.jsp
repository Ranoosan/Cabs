<%@ page import="org.example.cab.customer.dao.BookingDAO" %>
<%@ page import="org.example.cab.Admin.model.Booking" %>
<%@ page import="org.example.cab.customer.model.Driver" %>
<%@ page import="org.example.cab.customer.model.User" %>
<%@ page import="java.util.List" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>

<%
  HttpSession sessionObj = request.getSession(false);
  if (sessionObj == null || sessionObj.getAttribute("user") == null) {
    response.sendRedirect(request.getContextPath() + "/customer/login.jsp");
    return;
  }

  User user = (User) sessionObj.getAttribute("user");
  String loggedInUser = user.getUsername();

  BookingDAO bookingDAO = new BookingDAO();

  List<Booking> bookings = bookingDAO.getUserBookings(loggedInUser);

  // Handle delete request
  String deleteBookingId = request.getParameter("deleteBookingId");
  String statusForDelete = request.getParameter("statusForDelete");
  if (deleteBookingId != null) {
    int bookingIdToDelete = Integer.parseInt(deleteBookingId);
    boolean success = false;

    if ("Completed".equals(statusForDelete)) {
      success = bookingDAO.deleteBooking(bookingIdToDelete);
      if (success) {
        out.println("<script>alert('Booking deleted successfully');</script>");
      } else {
        out.println("<script>alert('Failed to delete booking');</script>");
      }
    } else {
      out.println("<script>alert('You can only delete completed bookings. Please contact admin to delete or cancel other bookings.');</script>");
    }
    response.sendRedirect("user_bookings.jsp"); // Refresh the page after deletion
  }
%>

<html lang="en">
<head>
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1.0">
  <title>My Bookings</title>
  <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha1/dist/css/bootstrap.min.css" rel="stylesheet">
  <style>
    .rejected-row {
      background-color: #fff3cd;
      color: #856404;
    }
    .cancelled-row {
      background-color: #f8d7da;
      color: #721c24;
    }
    .accepted-row {
      background-color: #d4edda;
      color: #155724;
    }
    .completed-row {
      background-color: #e2e3e5;
      color: #6c757d;
    }
    .phone-number {
      font-size: 1rem;
      font-weight: normal;
      color: inherit;
      text-decoration: none;
    }
    .booking-id, .pickup-location, .dropoff-location, .booking-date {
      font-weight: bold;
    }
    tr:hover {
      background-color: #f1f1f1;
      cursor: pointer;
    }
    .rejected-row:hover {
      background-color: #ffeeba;
    }
    .cancelled-row:hover {
      background-color: #f5c6cb;
    }
    .accepted-row:hover {
      background-color: #c3e6cb;
    }
    .completed-row:hover {
      background-color: #d6d8db;
    }
  </style>

  <!-- Alert Script -->
  <script type="text/javascript">
    window.onload = function() {
      alert(
              "📍 Confirm Location:\n   • Contact the driver to confirm the exact location.\n\n" +
              "🔄 Change Driver:\n   • If you want to change the driver, contact the admin.\n\n" +
              "❌ Cancel Booking:\n   • To delete or cancel uncompleted bookings, please reach out to the admin."
      );
    };
  </script>

</head>
<body>
<div class="container mt-4">
  <h2>My Bookings</h2>

  <table class="table table-bordered">
    <thead>
    <tr>
      <th>Booking ID</th>
      <th>Pickup Location</th>
      <th>Drop-off Location</th>
      <th>Booking Date</th>
      <th>Status</th>
      <th>Special Needs</th>
      <th>Driver/Admin</th>
      <th>Actions</th> <!-- Add Actions column -->
    </tr>
    </thead>
    <tbody>
    <% if (bookings.isEmpty()) { %>
    <tr>
      <td colspan="8" class="text-center">No bookings found</td>
    </tr>
    <% } else {
      for (Booking booking : bookings) {
        String status = booking.getStatus();
        org.example.cab.Admin.model.Driver driver = null;
        if ("Accepted".equals(status) || "Completed".equals(status)) {
          driver = bookingDAO.getDriverDetails(booking.getDriverId());
        }
    %>
    <tr class="<%=
        "Rejected".equals(status) ? "rejected-row" :
        "Cancelled".equals(status) ? "cancelled-row" :
        "Accepted".equals(status) ? "accepted-row" :
        "Completed".equals(status) ? "completed-row" :
        "" %>">
      <td class="booking-id"><%= booking.getBookingId() %></td>
      <td class="pickup-location"><%= booking.getPickupLocation() %></td>
      <td class="dropoff-location"><%= booking.getDropoffLocation() %></td>
      <td class="booking-date"><%= booking.getPickupDateTime() %></td>
      <td><%= booking.getStatus() %></td>
      <td><%= booking.getSpecialRequests() != null ? booking.getSpecialRequests() : "N/A" %></td>
      <td>
        <% if ("Accepted".equals(status) || "Completed".equals(status)) {
          if (driver != null) { %>
        <span><%= driver.getFullName() %></span><br>
        <a href="tel:<%= driver.getContactNumber() %>" class="phone-number"><%= driver.getContactNumber() %></a>
        <% } else { %>
        <span class="text-danger">Driver not found</span>
        <% }
        } else { %>
        <span>Admin</span><br>
        <a href="tel:0652245619" class="phone-number">0652245619</a>
        <% } %>
      </td>
      <td>
        <!-- Delete Button -->
        <form  method="get" onsubmit="return confirm('Are you sure you want to delete this booking?');">
          <input type="hidden" name="deleteBookingId" value="<%= booking.getBookingId() %>">
          <input type="hidden" name="statusForDelete" value="<%= booking.getStatus() %>">
          <button type="submit" class="btn btn-danger btn-sm" <%= !"Completed".equals(booking.getStatus()) ? "disabled" : "" %>>Delete</button>
        </form>
      </td>
    </tr>
    <% } } %>
    </tbody>
  </table>
</div>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha1/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
