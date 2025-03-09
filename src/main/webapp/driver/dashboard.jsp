<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ page import="jakarta.servlet.http.HttpSession" %>
<%@ page import="org.example.cab.Driver.model.User" %>
<%@ page import="java.sql.*" %>
<!DOCTYPE html>
<html lang="en">
<head>
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1.0">
  <title>Driver Dashboard</title>

  <!-- Bootstrap CSS -->
  <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">

  <style>
    body {
      background-color: #222222;
      color: #ffffff;
      font-family: 'Roboto', sans-serif;
    }
    .dashboard-container {
      background: #333333;
      border-radius: 10px;
      padding: 20px;
      box-shadow: 0 0 20px rgba(255, 255, 255, 0.2);
      margin: 20px auto;
      max-width: 900px;
      text-align: left;
    }
    .status-btn {
      padding: 10px 15px;
      border-radius: 5px;
      font-size: 14px;
      border: 1px solid #4CAF50;
      background-color: #333333;
      color: white;
      cursor: pointer;
      transition: 0.3s;
    }
    .status-btn.active {
      background-color: #4CAF50;
      color: white;
    }
    .btn-save {
      background-color: #4CAF50;
      border: none;
      color: white;
      padding: 8px 16px;
      border-radius: 5px;
      cursor: pointer;
    }
    .btn-save:hover {
      background-color: #45a049;
    }
    .navbar {
      background-color: #000;
      color: white;
      padding: 15px;
    }
    .navbar-brand {
      color: #4CAF50 !important;
    }
    .nav-link {
      color: white !important;
      font-weight: bold;
    }
    .nav-link:hover {
      color: #4CAF50 !important;
    }
  </style>

</head>
<body>

<%
  HttpSession sessiono = request.getSession(false);
  if (sessiono == null || sessiono.getAttribute("users") == null) {
    response.sendRedirect("login.jsp");
    return;
  }

  User driver = (User) sessiono.getAttribute("users");
  String currentStatus = "Unknown";

  try {
    Connection conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/cabs", "root", "");
    PreparedStatement stmt = conn.prepareStatement("SELECT status FROM driversss WHERE id = ?");
    stmt.setInt(1, driver.getId());
    ResultSet rs = stmt.executeQuery();
    if (rs.next()) {
      currentStatus = rs.getString("status");
    }
    conn.close();
  } catch (SQLException e) {
    e.printStackTrace();
  }
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

<div class="dashboard-container">
  <h2 class="text-center">Welcome, <%= driver.getFullName() %>!</h2>

  <h4>Driver Details</h4>
  <p><strong>Driver ID:</strong> <%= driver.getId() %></p>
  <p><strong>Username:</strong> <%= driver.getUsername() %></p>
  <p><strong>Email:</strong> <%= driver.getEmailAddress() %></p>
  <p><strong>Contact Number:</strong> <%= driver.getContactNumber() %></p>
  <p><strong>Residential Address:</strong> <%= driver.getResidentialAddress() %></p>
  <p><strong>License Type:</strong> <%= driver.getLicenseType() %></p>
  <p><strong>Expiry Date of License:</strong> <%= driver.getExpirationDate() %></p>

  <div class="status-box">
    <span class="status-label">Status:</span>
    <button class="status-btn <%= currentStatus.equals("On Ride") ? "active" : "" %>" onclick="setStatus('On Ride')">On Ride</button>
    <button class="status-btn <%= currentStatus.equals("Free") ? "active" : "" %>" onclick="setStatus('Free')">Free</button>
    <button class="status-btn <%= currentStatus.equals("On Leave") ? "active" : "" %>" onclick="setStatus('On Leave')">On Leave</button>
  </div>
  <div class="text-center mt-3">
    <button class="btn-save" onclick="updateStatus()">Save Status</button>
  </div>
</div>

<script>
  let selectedStatus = "<%= currentStatus %>";

  function setStatus(status) {
    selectedStatus = status;
    document.querySelectorAll(".status-btn").forEach(btn => btn.classList.remove("active"));
    document.querySelectorAll(".status-btn").forEach(btn => {
      if (btn.innerText === status) {
        btn.classList.add("active");
      }
    });
  }

  function updateStatus() {
    fetch('updateStatus.jsp', {
      method: 'POST',
      headers: {'Content-Type': 'application/x-www-form-urlencoded'},
      body: 'status=' + encodeURIComponent(selectedStatus)
    })
            .then(response => response.text())
            .then(data => {
              alert("Status updated to: " + selectedStatus);
              location.reload();
            })
            .catch(error => console.error('Error:', error));
  }
</script>

</body>
</html>
