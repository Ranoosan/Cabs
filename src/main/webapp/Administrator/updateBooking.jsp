<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="java.sql.*, org.example.cab.Admin.dao.BookingDao, org.example.cab.Admin.model.Booking, org.example.cab.Admin.model.Vehicle" %>
<%@ page import="java.util.List" %>
<html lang="en">
<head>
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1.0">
  <title>Update Booking</title>
  <!-- Bootstrap CSS -->
  <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha1/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-KyZXEJdS1X0p9uIyzJ7yLOFbyO9bXvJf9t3i5gL6wuwA5r5VXZL4BwETAP/kpR1p" crossorigin="anonymous">
</head>
<body>
<div class="container">
  <h2 class="my-4">Update Booking</h2>

  <!-- Form to update booking status -->
  <form action="updateBooking.jsp" method="post" class="mb-4">
    <h3>Update Booking Status</h3>
    <div class="mb-3">
      <label for="bookingId" class="form-label">Booking ID</label>
      <input type="number" id="bookingId" name="bookingId" class="form-control" required>
    </div>

    <div class="mb-3">
      <label for="status" class="form-label">Booking Status</label>
      <select id="status" name="status" class="form-select" required>
        <option value="Pending">Pending</option>
        <option value="Confirmed">Confirmed</option>
        <option value="Completed">Completed</option>
        <option value="Cancelled">Cancelled</option>
      </select>
    </div>

    <button type="submit" class="btn btn-primary">Update Status</button>
  </form>

  <!-- Form to assign a new driver -->
  <form action="updateBooking.jsp" method="post">
    <h3>Assign New Driver</h3>
    <div class="mb-3">
      <label for="bookingId" class="form-label">Booking ID</label>
      <input type="number" id="bookingId" name="bookingId" class="form-control" required>
    </div>

    <div class="mb-3">
      <label for="driverId" class="form-label">Driver ID</label>
      <select id="driverId" name="driverId" class="form-select" required>
        <option value="">Select a Driver</option>
        <%
          // Fetch all bookings
          BookingDao bookingDao = new BookingDao();
          List<Booking> bookings = bookingDao.getAllBookings();

          // Iterate through each booking and display its details
          for (Booking booking : bookings) {
            Vehicle vehicle = bookingDao.getVehicleById(booking.getVehicleId());

            if (vehicle != null) {
              String vehicleCategory = vehicle.getCategory();

              // Fetch drivers that match the vehicle category
              List<String> availableDrivers = bookingDao.getDriversByVehicleCategory(vehicleCategory);

              out.print("<h5>Booking ID: " + booking.getBookingId() + "</h5>");
              out.print("<p>Pickup Location: " + booking.getPickupLocation() + "</p>");
              out.print("<p>Dropoff Location: " + booking.getDropoffLocation() + "</p>");
              out.print("<p>Current Driver ID: " + booking.getDriverId() + "</p>");
              out.print("<p>Status: " + booking.getStatus() + "</p>");

              out.print("<label for='newDriver'>Assign New Driver for Vehicle (" + vehicle.getVehicleNumber() + "):</label>");
              out.print("<select name='newDriver' class='form-select'>");

              // Display matching drivers
              for (String driver : availableDrivers) {
                out.print("<option value='" + driver + "'>" + driver + "</option>");
              }

              out.print("</select>");
              out.print("<br><br>");
            }
          }
        %>
      </select>
    </div>

    <button type="submit" class="btn btn-success">Assign Driver</button>
  </form>

  <%
    // Handle form submissions for both actions
    if ("POST".equalsIgnoreCase(request.getMethod())) {
      String bookingId = request.getParameter("bookingId");
      String status = request.getParameter("status");
      String newDriverId = request.getParameter("newDriver");

      // Update booking status separately
      if (status != null) {
        boolean statusUpdated = bookingDao.updateBookingStatus(Integer.parseInt(bookingId), status);
        if (statusUpdated) {
          out.print("<p class='alert alert-success'>Booking status updated successfully.</p>");
        } else {
          out.print("<p class='alert alert-danger'>Failed to update booking status.</p>");
        }
      }

      // Assign new driver separately
      if (newDriverId != null) {
        boolean driverUpdated = bookingDao.updateBookingDriver(Integer.parseInt(bookingId), Integer.parseInt(newDriverId));
        if (driverUpdated) {
          out.print("<p class='alert alert-success'>Driver assigned successfully.</p>");
        } else {
          out.print("<p class='alert alert-danger'>Failed to assign new driver.</p>");
        }
      }
    }
  %>
</div>

<!-- Bootstrap JS -->
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha1/dist/js/bootstrap.bundle.min.js" integrity="sha384-ka5k52r+FjV4oOsObLyD+Eq0T2yZYmE+v9DQz9rpo4W39U5fD8lPdzIovH5JjAi1" crossorigin="anonymous"></script>
</body>
</html>
