<%@ page import="org.example.cab.customer.model.User" %>
<%@ page import="jakarta.servlet.http.HttpSession" %>
<%@ page import="org.example.cab.Admin.model.Vehicle" %>
<%@ page import="org.example.cab.customer.model.Booker" %>
<%@ page import="java.util.List" %>
<%@ page import="org.example.cab.Admin.dao.VehicleDAO" %>

<%
  // Check if session is valid
  HttpSession sessionObj = request.getSession(false);
  if (sessionObj == null || sessionObj.getAttribute("user") == null) {
    response.sendRedirect(request.getContextPath() + "/customer/login.jsp");
    return;
  }

  // Retrieve user and booker from session
  User user = (User) sessionObj.getAttribute("user");

%>

<!DOCTYPE html>
<html lang="en">
<head>
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1.0">
  <title>Make Booking</title>

  <!-- Bootstrap CSS -->
  <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">

  <style>
    body {
      background-color: #e0f0f6; /* Lighter shade of blue similar to navbar */
      color: #333;
      font-family: 'Roboto', sans-serif;
    }

    .navbar {
      background: linear-gradient(to right, #1d72b8, #ff5f6d); /* Gradient for modern look */
      padding: 15px 20px;
    }
    .navbar a {
      color: white;
      font-size: 16px;
    }
    .navbar a:hover {
      background-color: #222;
      border-radius: 5px;
    }

    .vehicle-container {
      display: flex;
      flex-wrap: wrap;
      justify-content: center;
      margin: 50px auto;
      max-width: 1200px; /* Limit the container width */
    }

    .vehicle-card {
      flex: 0 0 45%; /* 45% width on larger screens */
      margin: 15px;
      background-color: white;
      border-radius: 8px;
      box-shadow: 0px 4px 10px rgba(0, 0, 0, 0.1);
      cursor: pointer;
      transition: transform 0.3s, box-shadow 0.3s ease;
    }

    .vehicle-card:hover {
      transform: scale(1.05);
      box-shadow: 0px 6px 15px rgba(0, 0, 0, 0.2);
    }

    .vehicle-image {
      width: 100%;
      height: auto;
      border-radius: 8px;
    }

    .card-body {
      padding: 20px;
    }

    .card-title {
      font-size: 18px;
      font-weight: bold;
      color: #333;
    }

    .card-text {
      font-size: 14px;
      color: #555;
    }

    .btn-primary {
      background-color: #007BFF;
      border: none;
      padding: 12px 20px;
      font-size: 16px;
      border-radius: 5px;
      color: white;
    }

    .btn-primary:hover {
      background-color: #0056b3;
    }

    .navbar-toggler-icon {
      background-color: white;
    }

    .navbar-nav .nav-link {
      font-size: 16px;
    }

    .navbar-nav .nav-link:hover {
      background-color: #555;
      border-radius: 5px;
    }

    /* Adjust for smaller screen sizes */
    @media (max-width: 768px) {
      .vehicle-card {
        flex: 0 0 90%; /* Take more space on smaller screens */
      }
    }
  </style>
</head>
<body>

<!-- Navbar -->
<nav class="navbar navbar-expand-lg navbar-dark bg-dark">
  <div class="container">
    <a class="navbar-brand" href="welcome.jsp">Cab Services</a>
    <button class="navbar-toggler" type="button" data-bs-toggle="collapse" data-bs-target="#navbarNav"
            aria-controls="navbarNav" aria-expanded="false" aria-label="Toggle navigation">
      <span class="navbar-toggler-icon"></span>
    </button>
    <div class="collapse navbar-collapse" id="navbarNav">
      <ul class="navbar-nav ms-auto">
        <li class="nav-item">
          <a class="nav-link" href="view_cus_vehicle.jsp">Vehicles</a>
        </li>
        <li class="nav-item">
          <a class="nav-link" href="user_bookings.jsp">My Bookings</a>
        </li>
        <li class="nav-item">
          <a class="nav-link" href="profile.jsp">Profile</a>
        </li>
        <% if (user != null) { %>
        <li class="nav-item">
          <a class="nav-link" href="#">Welcome, <%= user.getUsername() %></a>
        </li>
        <li class="nav-item">
          <a class="nav-link btn btn-danger btn-sm" href="login.jsp">Logout</a>
        </li>
        <% } else { %>
        <li class="nav-item">
          <a class="nav-link btn btn-primary btn-sm" href="login.jsp">Login</a>
        </li>
        <% } %>
      </ul>
    </div>
  </div>
</nav>

<h2 class="text-center mt-4">Vehicle Showroom</h2>
<div class="vehicle-container">
  <%
    // Fetch the list of vehicles from the database
    VehicleDAO vehicleDAO = new VehicleDAO();
    List<Vehicle> vehicles = vehicleDAO.getAllVehicles();

    // Loop through the vehicles and display each one
    for (Vehicle vehicle : vehicles) {
  %>
  <div class="card vehicle-card" onclick="window.location='<%= request.getContextPath() %>/customer/booking.jsp?vehicleId=<%= vehicle.getId() %>&customerId=<%= user.getId(user) %>'">

    <img src="<%= request.getContextPath() + "/" + vehicle.getVehiclePhoto() %>" class="card-img-top vehicle-image" alt="Vehicle Image">
    <div class="card-body">
      <h5 class="card-title">Category: <%= vehicle.getCategory() %></h5>
      <p class="card-text">
        <strong>Number:</strong> <%= vehicle.getVehicleNumber() %><br>
        <strong>CC:</strong> <%= vehicle.getCc() %><br>
        <strong>Engine No:</strong> <%= vehicle.getEngineNo() %><br>
        <strong>Available:</strong> <%= vehicle.isAvailable() ? "Yes" : "No" %>
      </p>
    </div>
  </div>
  <%
    }
  %>
</div>

<a href="${pageContext.request.contextPath}/customer/welcome.jsp" class="btn btn-primary mt-3">Back to Home</a>

<!-- Bootstrap JS -->
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>

</body>
</html>
