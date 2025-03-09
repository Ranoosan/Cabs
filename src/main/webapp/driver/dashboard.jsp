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
      background-color: #121212; /* Dark theme */
      color: #ffffff;
      font-family: 'Poppins', sans-serif;
    }
    .dashboard-container {
      background: linear-gradient(135deg, #1f1f1f, #292929);
      border: 2px solid yellow; /* Yellow Border */
      padding: 30px;
      border-radius: 15px;
      box-shadow: 0 0 15px rgba(255, 255, 0, 0.7); /* Glowing effect */
      max-width: 800px;
      margin: auto;
      text-align: left;
      transition: 0.3s ease-in-out;
    }
    .dashboard-container:hover {
      box-shadow: 0 0 20px rgba(255, 255, 0, 1);
    }
    .status-box {
      display: flex;
      align-items: center;
      gap: 15px;
      margin-top: 20px;
      justify-content: center;
    }
    .status-label {
      font-weight: bold;
      font-size: 18px;
      color: yellow;
    }
    .status-btn {
      padding: 10px 20px;
      border-radius: 5px;
      font-size: 16px;
      font-weight: bold;
      border: 2px solid yellow;
      color: black;
      cursor: pointer;
      transition: all 0.3s;
    }
    .status-btn.active {
      background-color: yellow;
      color: black;
      box-shadow: 0px 0px 10px rgba(255, 255, 0, 0.8);
    }
    .btn-save {
      background-color: #ffc107;
      color: black;
      font-weight: bold;
      border: none;
      padding: 8px 15px;
      border-radius: 5px;
      cursor: pointer;
      transition: 0.3s;
    }
    .btn-save:hover {
      background-color: #e0a800;
    }
    .navbar {
      background-color: black;
      padding: 10px;
    }
    .navbar-brand {
      font-weight: bold;
      color: yellow !important;
    }
    .nav-link {
      color: white !important;
      transition: 0.3s;
    }
    .nav-link:hover {
      color: yellow !important;
    }
  </style>
</head>
<body>

<%
  HttpSession sessiono = request.getSession(false);
  if (sessiono == null || sessiono.getAttribute("user") == null) {
    response.sendRedirect("login.jsp");
    return;
  }

  User driver = (User) sessiono.getAttribute("user");
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
