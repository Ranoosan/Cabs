<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ page import="jakarta.servlet.http.HttpSession" %>
<%@ page import="org.example.cab.Driver.model.User" %>
<!DOCTYPE html>
<html lang="en">
<head>
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1.0">
  <title>Driver Dashboard</title>

  <!-- Bootstrap CSS -->
  <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">

  <!-- Custom Styles -->
  <style>
    body {
      background-color: #f8f9fa; /* Light background */
      color: #343a40; /* Dark text */
      font-family: 'Arial', sans-serif;
    }
    .dashboard-container {
      background-color: #ffffff; /* White background */
      padding: 30px;
      border-radius: 10px;
      box-shadow: 0 4px 10px rgba(0, 0, 0, 0.1); /* Subtle shadow */
      max-width: 800px;
      margin: auto;
      text-align: left;
    }
    .btn-custom {
      background-color: #007bff;
      color: white;
      font-weight: bold;
      border: none;
      transition: 0.3s;
    }
    .btn-custom:hover {
      background-color: #0056b3;
      color: white;
    }
  </style>
</head>
<body>

<%
  // Check if the user is logged in by checking the session
  HttpSession sessiono = request.getSession(false); // Get session if it exists
  if (sessiono == null || sessiono.getAttribute("user") == null) {
    // If session doesn't exist or user is not logged in, redirect to login page
    response.sendRedirect("login.jsp");
    return;
  }

  // Retrieve the User object from the session
  User driver = (User) sessiono.getAttribute("user");
%>

<nav class="navbar navbar-expand-lg navbar-dark bg-dark">
  <div class="container-fluid">
    <a class="navbar-brand" href="#">Cab Services</a>
    <button class="navbar-toggler" type="button" data-bs-toggle="collapse" data-bs-target="#navbarNav" aria-controls="navbarNav" aria-expanded="false" aria-label="Toggle navigation">
      <span class="navbar-toggler-icon"></span>
    </button>
    <div class="collapse navbar-collapse" id="navbarNav">
      <ul class="navbar-nav ms-auto">
        <li class="nav-item">
          <a class="nav-link" href="dashboard.jsp">Dashboard</a>
        </li>
        <li class="nav-item">
          <a class="nav-link" href="myVehicles.jsp">My Vehicles</a>
        </li>
        <li class="nav-item">
          <a class="nav-link" href="rides.jsp">My Rides</a>
        </li>
        <li class="nav-item">
          <a class="nav-link" href="logout.jsp">Logout</a>
        </li>
      </ul>
    </div>
  </div>
</nav>

<div class="dashboard-container">
  <h2>Welcome, <%= driver.getFullName() %>!</h2>
  <p>You have successfully logged in.</p>

  <h4>Driver Details</h4>
  <p><strong>Driver ID:</strong> <%= driver.getId() %></p>
  <p><strong>Username:</strong> <%= driver.getUsername() %></p>
  <p><strong>Email:</strong> <%= driver.getEmailAddress() %></p>
  <p><strong>Contact Number:</strong> <%= driver.getContactNumber() %></p>
  <p><strong>Residential Address:</strong> <%= driver.getResidentialAddress() %></p>
  <p><strong>License Number:</strong> <%= driver.getLicenseNumber() %></p>
  <p><strong>License Type:</strong> <%= driver.getLicenseType() %></p>
  <p><strong>Expiry Date of License:</strong> <%= driver.getExpirationDate() %></p>
</div>

<!-- Bootstrap JS -->
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>

</body>
</html>
