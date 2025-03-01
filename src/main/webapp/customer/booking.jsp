<%@ page import="java.sql.*" %>
<%@ page import="org.example.cab.Admin.dao.BookingDao" %>
<%@ page import="org.example.cab.Admin.model.Vehicle" %>
<%@ page import="org.example.cab.Admin.model.Driver" %>
<%@ page import="org.example.cab.customer.model.User" %>
<%@ page import="org.example.cab.Admin.dao.DriverDAO" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
  <title>Vehicle Details</title>
  <link rel="stylesheet" type="text/css" href="styles.css"> <!-- Add your styles -->
  <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha1/dist/css/bootstrap.min.css" rel="stylesheet">
</head>
<body>

<%
  // Retrieve customer session
  HttpSession sessionObj = request.getSession(false);
  User user = null;

  if (sessionObj != null) {
    user = (User) sessionObj.getAttribute("user");
  }

  // Retrieve vehicle ID from request parameter
  String vehicleIdParam = request.getParameter("vehicleId");

  // Convert vehicleIdParam to integer
  int vehicleId = -1;
  try {
    vehicleId = Integer.parseInt(vehicleIdParam);
  } catch (NumberFormatException e) {
    // Handle invalid ID format (could redirect or show an error message)
    out.println("Invalid vehicle ID.");
    return;
  }

  // Fetch vehicle details using DAO
  BookingDao bookingDao = new BookingDao();
  Vehicle vehicle = bookingDao.getVehicleById(vehicleId);

  if (vehicle == null) {
    // Handle case where vehicle is not found
    out.println("Vehicle not found.");
    return;
  }

  // Fetch driver details using DAO
  DriverDAO driverDAO = new DriverDAO();
  Driver driver = driverDAO.getDriverByVehicleId(String.valueOf(vehicleId)); // Implement this method

  // Store the driver ID in the session if driver is found
  if (driver != null) {
    sessionObj.setAttribute("driverId", driver.getId()); // Assuming Driver has a getId() method
  } else {
    // Handle case where driver is not found (redirect to another page)
    response.sendRedirect(request.getContextPath() + "/customer/view_cus_vehicle.jsp");
    return;
  }
%>

<h1>Vehicle Details</h1>

<table class="table table-bordered">
  <tr>
    <th>ID</th>
    <td><%= vehicle.getId() %></td>
  </tr>
  <tr>
    <th>Category</th>
    <td><%= vehicle.getCategory() %></td>
  </tr>
  <tr>
    <th>Vehicle Number</th>
    <td><%= vehicle.getVehicleNumber() %></td>
  </tr>
  <tr>
    <th>CC</th>
    <td><%= vehicle.getCc() %></td>
  </tr>
  <tr>
    <th>Engine Number</th>
    <td><%= vehicle.getEngineNo() %></td>
  </tr>
  <tr>
    <th>Vehicle Photo</th>
    <td><img src="<%= vehicle.getVehiclePhoto() %>" alt="Vehicle Photo" width="100"></td>
  </tr>
  <tr>
    <th>Available</th>
    <td><%= vehicle.isAvailable() ? "Yes" : "No" %></td>
  </tr>
  <tr>
    <th>Fuel Type</th>
    <td><%= vehicle.getFuelType() %></td>
  </tr>
  <tr>
    <th>Seat Capacity</th>
    <td><%= vehicle.getSeatCapacity() %></td>
  </tr>
  <tr>
    <th>Rental Price</th>
    <td><%= vehicle.getRentalPrice() %></td>
  </tr>
  <tr>
    <th>Driver ID</th>
    <td><%= driver != null ? driver.getId() : "Not available" %></td>
  </tr>
  <tr>
    <th>Vehicle Model Name</th>
    <td><%= vehicle.getVehicle_model_name() %></td>
  </tr>
</table>

<!-- Booking Form -->
<h2>Booking Details</h2>
<form action="submitBooking.jsp" method="post">
  <!-- Pickup Location -->
  <div class="mb-3">
    <label for="pickupLocation" class="form-label">Pickup Location</label>
    <select id="pickupLocation" name="pickupLocation" class="form-select" required>
      <option value="" selected disabled>Select Pickup Location</option>
      <option value="Location1">Location 1</option>
      <option value="Location2">Location 2</option>
      <option value="Location3">Location 3</option>
    </select>
  </div>

  <!-- Drop-off Location -->
  <div class="mb-3">
    <label for="dropoffLocation" class="form-label">Drop-off Location</label>
    <select id="dropoffLocation" name="dropoffLocation" class="form-select" required>
      <option value="" selected disabled>Select Drop-off Location</option>
      <option value="Location1">Location 1</option>
      <option value="Location2">Location 2</option>
      <option value="Location3">Location 3</option>
    </select>
  </div>

  <!-- Pickup Date & Time -->
  <div class="mb-3">
    <label for="pickupDateTime" class="form-label">Pickup Date & Time</label>
    <input type="datetime-local" id="pickupDateTime" name="pickupDateTime" class="form-control" required>
  </div>

  <!-- Payment Method -->
  <div class="mb-3">
    <label for="paymentMethod" class="form-label">Payment Method</label>
    <select id="paymentMethod" name="paymentMethod" class="form-select" required>
      <option value="" selected disabled>Select Payment Method</option>
      <option value="Cash">Cash</option>
      <option value="Credit/Debit Card">Credit/Debit Card</option>
      <option value="Online Payment">Online Payment</option>
    </select>
  </div>

  <!-- Special Requests (Optional) -->
  <div class="mb-3">
    <label for="specialRequests" class="form-label">Special Requests (Optional)</label>
    <select id="specialRequests" name="specialRequests" class="form-select">
      <option value="" selected disabled>Select Special Request</option>
      <option value="Child Seat">Child Seat</option>
      <option value="Accessibility Needs (e.g., wheelchair)">Accessibility Needs (e.g., wheelchair)</option>
      <option value="Additional Stops">Additional Stops</option>
      <option value="None">None</option>
    </select>
  </div>

  <!-- Acknowledgment of Terms & Conditions -->
  <div class="mb-3 form-check">
    <input type="checkbox" class="form-check-input" id="termsCheck" name="termsCheck" required>
    <label class="form-check-label" for="termsCheck">I acknowledge the Booking Terms & Conditions</label>
  </div>

  <!-- Child Seat Requirement -->
  <div class="mb-3">
    <label for="childSeat" class="form-label">Child Seat Requirement</label>
    <select id="childSeat" name="childSeat" class="form-select" required>
      <option value="" selected disabled>Select Child Seat Requirement</option>
      <option value="Yes">Yes</option>
      <option value="No">No</option>
    </select>
  </div>

  <!-- Accessibility Needs -->
  <div class="mb-3">
    <label for="accessibilityNeeds" class="form-label">Accessibility Needs</label>
    <select id="accessibilityNeeds" name="accessibilityNeeds" class="form-select">
      <option value="" selected disabled>Select Accessibility Need</option>
      <option value="Wheelchair Access">Wheelchair Access</option>
      <option value="None">None</option>
    </select>
  </div>

  <!-- Submit Button -->
  <div class="mb-3">
    <button type="submit" class="btn btn-primary w-100">Submit Booking</button>
  </div>
</form>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha1/dist/js/bootstrap.bundle.min.js"></script>

</body>
</html>
