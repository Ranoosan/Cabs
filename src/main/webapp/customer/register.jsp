<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="org.example.cab.customer.controller.RegisterServlet" %>
<%@ page import="org.example.cab.customer.dao.UserDAO" %>
<%@ page import="org.example.cab.customer.model.User" %>

<!DOCTYPE html>
<html lang="en">
<head>
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1.0">
  <link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css">
  <title>User Registration</title>
</head>
<body>
<div class="container mt-5">
  <h2 class="text-center">User Registration</h2>

  <%-- Show registration error if needed --%>
  <% String errorMessage = (String) request.getAttribute("errorMessage");
    if (errorMessage != null) { %>
  <div class="alert alert-danger">
    <%= errorMessage %>
  </div>
  <% } %>

  <form action="register" method="post" class="mt-4">
    <div class="form-group">
      <label for="username">Username:</label>
      <input type="text" class="form-control" id="username" name="username" required>
    </div>
    <div class="form-group">
      <label for="password">Password:</label>
      <input type="password" class="form-control" id="password" name="password" required>
    </div>
    <div class="form-group">
      <label for="email">Email:</label>
      <input type="email" class="form-control" id="email" name="email" required>
    </div>
    <div class="form-group">
      <label for="contact_number">Contact Number:</label>
      <input type="text" class="form-control" id="contact_number" name="contact_number" required>
    </div>
    <div class="form-group">
      <label for="address">Address:</label>
      <input type="text" class="form-control" id="address" name="address" required>
    </div>
    <div class="form-group">
      <label for="gender">Gender:</label>
      <select class="form-control" id="gender" name="gender" required>
        <option value="" disabled selected>Select your gender</option>
        <option value="Male">Male</option>
        <option value="Female">Female</option>
        <option value="Other">Other</option>
      </select>
    </div>
    <div class="form-group">
      <label for="nic">NIC:</label>
      <input type="text" class="form-control" id="nic" name="nic" required>
    </div>
    <div class="form-group">
      <label for="date_of_birth">Date of Birth:</label>
      <input type="date" class="form-control" id="date_of_birth" name="date_of_birth" required>
    </div>
    <button type="submit" class="btn btn-primary">Register</button>
  </form>

  <p class="mt-3">Already have an account? <a href="login.jsp">Login Here</a></p>
</div>

<script src="https://code.jquery.com/jquery-3.5.1.slim.min.js"></script>
<script src="https://cdn.jsdelivr.net/npm/@popperjs/core@2.11.6/dist/umd/popper.min.js"></script>
<script src="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/js/bootstrap.min.js"></script>
</body>
</html>
