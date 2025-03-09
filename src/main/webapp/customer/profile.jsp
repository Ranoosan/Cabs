<%@ page import="org.example.cab.customer.model.User, java.sql.*" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%
    // Session check
    HttpSession sessionObj = request.getSession(false);
    if (sessionObj == null || sessionObj.getAttribute("user") == null) {
        response.sendRedirect("login.jsp");
        return;
    }

    User user = (User) sessionObj.getAttribute("user");

    // Database connection settings
    String jdbcURL = "jdbc:mysql://localhost:3306/cabs";
    String jdbcUser = "root";
    String jdbcPassword = "";

    // Update user details
    if (request.getMethod().equalsIgnoreCase("POST") && request.getParameter("updateProfile") != null) {
        String email = request.getParameter("email");
        String contactNumber = request.getParameter("contact_number");
        String address = request.getParameter("address");

        try (Connection conn = DriverManager.getConnection(jdbcURL, jdbcUser, jdbcPassword);
             PreparedStatement stmt = conn.prepareStatement("UPDATE users SET email = ?, contact_number = ?, address = ? WHERE username = ?")) {

            stmt.setString(1, email);
            stmt.setString(2, contactNumber);
            stmt.setString(3, address);
            stmt.setString(4, user.getUsername());

            int rowsUpdated = stmt.executeUpdate();
            if (rowsUpdated > 0) {
                user.setEmail(email);
                user.setContactNumber(contactNumber);
                user.setAddress(address);
                sessionObj.setAttribute("user", user);
                request.setAttribute("message", "Profile updated successfully!");
            }
        } catch (SQLException e) {
            e.printStackTrace();
            request.setAttribute("error", "Error updating profile.");
        }
    }

    // Change password
    if (request.getMethod().equalsIgnoreCase("POST") && request.getParameter("changePassword") != null) {
        String currentPassword = request.getParameter("current_password");
        String newPassword = request.getParameter("new_password");

        if (user.getPassword().equals(currentPassword)) {
            try (Connection conn = DriverManager.getConnection(jdbcURL, jdbcUser, jdbcPassword);
                 PreparedStatement stmt = conn.prepareStatement("UPDATE users SET password = ? WHERE username = ?")) {

                stmt.setString(1, newPassword); // Consider hashing for security
                stmt.setString(2, user.getUsername());

                int rowsUpdated = stmt.executeUpdate();
                if (rowsUpdated > 0) {
                    user.setPassword(newPassword);
                    sessionObj.setAttribute("user", user);
                    request.setAttribute("message", "Password changed successfully!");
                }
            } catch (SQLException e) {
                e.printStackTrace();
                request.setAttribute("error", "Error changing password.");
            }
        } else {
            request.setAttribute("error", "Current password is incorrect.");
        }
    }
%>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>User Profile</title>
    <!-- Bootstrap CDN -->
    <link href="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css" rel="stylesheet">
    <style>
        .container {
            max-width: 600px;
        }
        .form-group label {
            font-weight: bold;
        }
        .success {
            color: green;
        }
        .error {
            color: red;
        }

    </style>
</head>
<body>


<div class="container mt-5">
    <h2 class="text-center">User Profile</h2>

    <% if (request.getAttribute("message") != null) { %>
    <div class="alert alert-success"><%= request.getAttribute("message") %></div>
    <% } %>
    <% if (request.getAttribute("error") != null) { %>
    <div class="alert alert-danger"><%= request.getAttribute("error") %></div>
    <% } %>

    <!-- Update Profile Form -->
    <form method="post" class="mb-4">
        <div class="form-group">
            <label>Username:</label>
            <input type="text" class="form-control" value="<%= user.getUsername() %>" disabled>
        </div>
        <div class="form-group">
            <label>Email:</label>
            <input type="email" class="form-control" name="email" value="<%= user.getEmail() %>" required>
        </div>
        <div class="form-group">
            <label>Contact Number:</label>
            <input type="text" class="form-control" name="contact_number" value="<%= user.getContactNumber() %>" required>
        </div>
        <div class="form-group">
            <label>Address:</label>
            <input type="text" class="form-control" name="address" value="<%= user.getAddress() %>" required>
        </div>
        <button type="submit" name="updateProfile" class="btn btn-primary btn-block">Update Profile</button>
    </form>

    <h3 class="text-center mb-4">Change Password</h3>
    <form method="post">
        <div class="form-group">
            <label>Current Password:</label>
            <input type="password" class="form-control" name="current_password" required>
        </div>
        <div class="form-group">
            <label>New Password:</label>
            <input type="password" class="form-control" name="new_password" required>
        </div>
        <button type="submit" name="changePassword" class="btn btn-warning btn-block">Change Password</button>
    </form>
</div>

<!-- Bootstrap JS and Popper.js CDN -->
<script src="https://code.jquery.com/jquery-3.5.1.slim.min.js"></script>
<script src="https://cdn.jsdelivr.net/npm/@popperjs/core@2.5.3/dist/umd/popper.min.js"></script>
<script src="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/js/bootstrap.min.js"></script>
</body>
</html>
