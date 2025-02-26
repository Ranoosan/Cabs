<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
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
      background-color: #121212; /* Dark background */
      color: #FFD700; /* Gold text */
      display: flex;
      justify-content: center;
      align-items: center;
      height: 100vh;
      font-family: 'Arial', sans-serif;
    }
    .dashboard-container {
      background-color: #1E1E1E; /* Darker grey */
      padding: 30px;
      border-radius: 10px;
      box-shadow: 0 4px 10px rgba(255, 215, 0, 0.3); /* Yellow glow effect */
      width: 100%;
      max-width: 500px;
      text-align: center;
    }
    .dashboard-container h2 {
      margin-bottom: 20px;
    }
    .btn-custom {
      background-color: #FFD700;
      color: #121212;
      font-weight: bold;
      border: none;
      transition: 0.3s;
    }
    .btn-custom:hover {
      background-color: #FFA500;
      color: black;
    }
  </style>
</head>
<body>

<div class="dashboard-container">
  <h2>Welcome, Driver!</h2>
  <p>You have successfully logged in.</p>
  <a href="login.jsp" class="btn btn-custom mt-3">Logout</a>
</div>

<!-- Bootstrap JS -->
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>

</body>
</html>
