<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="jakarta.servlet.http.HttpSession" %>
<%@ page import="org.example.cab.Driver.model.User" %>

<%
    HttpSession session1 = request.getSession(false);
    if (session1 == null || session1.getAttribute("admin") == null) {
        response.sendRedirect("/Administrator/login.jsp"); // Redirect to login page if session is null
    }
%>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Admin Dashboard</title>

    <!-- Bootstrap CSS -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">

    <style>
        body {
            background-color: #2C3E50; /* Dark blue background */
            color: #ECF0F1; /* Light gray text */
        }
        .container {
            margin-top: 50px;
            border: 1px solid #34495E;
            border-radius: 10px;
            padding: 20px;
            background-color: #34495E;
        }
        .btn-custom {
            background-color: #3498DB;
            color: #FFFFFF;
            font-weight: bold;
            border: none;
            transition: 0.3s;
        }
        .btn-custom:hover {
            background-color: #2980B9;
            color: #FFFFFF;
        }
        .navbar {
            background-color: #1A252F;
            padding: 15px;
            display: flex;
            justify-content: space-between;
            align-items: center;
        }
        .navbar a {
            color: #ECF0F1;
            font-weight: bold;
            margin-right: 20px;
            text-decoration: none;
        }
        .navbar a:hover {
            color: #3498DB;
        }
    </style>
</head>
<body>

<!-- Navigation Bar -->
<nav class="navbar">
    <div>
        <a href="${pageContext.request.contextPath}/Administrator/admin_dashboard.jsp">Admin Dashboard</a>
    </div>
    <div>
        <% if (session1 != null && session1.getAttribute("admin") != null) { %>
        <a href="${pageContext.request.contextPath}/Administrator/login.jsp" class="btn btn-danger btn-sm">Logout</a>
        <% } %>
    </div>
</nav>

<div class="container text-center">
    <h2>Welcome, Admin!</h2>
    <p>Manage driver accounts</p>
    <a href="${pageContext.request.contextPath}/Administrator/view_drivers.jsp" class="btn btn-custom m-2">View All Drivers</a>

    <a href="${pageContext.request.contextPath}/Administrator/add_driver.jsp" class="btn btn-custom m-2">Add New Driver</a>
</div>

<!-- Bootstrap JS -->
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>

</body>
</html>
