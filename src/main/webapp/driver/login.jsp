<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1.0">
  <title>Driver Login</title>

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
    .login-container {
      background-color: #1E1E1E; /* Darker grey */
      padding: 30px;
      border-radius: 10px;
      box-shadow: 0 4px 10px rgba(255, 215, 0, 0.3); /* Yellow glow effect */
      width: 100%;
      max-width: 400px;
      text-align: center;
    }
    .login-container h2 {
      margin-bottom: 20px;
    }
    .form-control {
      background-color: #333;
      color: #FFD700;
      border: 1px solid #FFD700;
    }
    .form-control:focus {
      background-color: #222;
      color: #FFD700;
      border-color: #FFA500;
      box-shadow: 0 0 10px rgba(255, 165, 0, 0.5);
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
    .error-message {
      color: red;
      margin-top: 10px;
    }
  </style>
</head>
<body>

<div class="login-container">
  <h2>Driver Login</h2>
  <form action="login" method="post">
    <div class="mb-3">
      <label for="username" class="form-label">Username:</label>
      <input type="text" class="form-control" id="username" name="username" required>
    </div>
    <div class="mb-3">
      <label for="password" class="form-label">Password:</label>
      <input type="password" class="form-control" id="password" name="password" required>
    </div>
    <button type="submit" class="btn btn-custom w-100">Login</button>
  </form>

  <% if (request.getAttribute("errorMessage") != null) { %>
  <p class="error-message"><%= request.getAttribute("errorMessage") %></p>
  <% } %>
</div>

<!-- Bootstrap JS -->
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>

</body>
</html>
