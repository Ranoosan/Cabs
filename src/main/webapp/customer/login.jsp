<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ page import="org.example.cab.customer.controller.LoginServlet" %>
<%@ page import="org.example.cab.customer.controller.LogoutServlet" %>
<%@ page import="org.example.cab.customer.dao.UserDAO" %>
<%@ page import="org.example.cab.customer.model.User" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css">
    <title>Login</title>
    <style>
        /* Background with lighter gradient */
        body {
            background-color: #e0f0f6;
            color: #fff; /* Light text color */
            overflow: hidden;
            position: relative;
            font-family: 'Arial', sans-serif;
            height: 100vh; /* Full viewport height */
            margin: 0;
            display: flex;
            justify-content: center;
            align-items: center;


        }

        /* Bolder moving star effect */
        .stars {
            position: absolute;
            top: 0;
            left: 0;
            width: 100%;
            height: 100%;
            background: url('https://www.transparenttextures.com/patterns/stardust.png') repeat;
            animation: moveStars 40s linear infinite;
            z-index: -1;
            opacity: 0.9; /* Increased opacity for bolder stars */
            transform: scale(2); /* Make the stars bigger */
        }

        /* Keyframes for smooth star movement */
        @keyframes moveStars {
            0% {
                transform: translate(0, 0) scale(2);
            }
            100% {
                transform: translate(-1000px, -1000px) scale(2);
            }
        }

        .container {
            max-width: 800px;
            background: linear-gradient(to right, #6a9bb7, #ff8b8b); /* Lighter gradient for a softer, modern look */

            border-radius: 10px;
            padding: 30px;
            box-shadow: 0 4px 15px rgba(0, 0, 0, 0.1);
            margin-top: 50px;
            position: relative;
            z-index: 1; /* Ensure the form is on top of the stars */
        }

        .form-group label {
            font-weight: bold;
            color: #333;
        }

        .form-group input {
            border-radius: 5px;
            padding: 10px;
            border: 1px solid #ddd;
            width: 100%;
        }

        .btn-primary {
            background-color: #007BFF;
            border-color: #007BFF;
            border-radius: 5px;
            padding: 10px 20px;
            transition: background-color 0.3s ease;
        }

        .btn-primary:hover {
            background-color: #0056b3;
        }

        .alert-danger {
            font-size: 14px;
            padding: 10px;
        }

        .mt-3 a {
            color: #007BFF;
            text-decoration: none;
        }

        .mt-3 a:hover {
            text-decoration: underline;
        }
    </style>
</head>
<body>
<div class="stars"></div> <!-- Bolder stars background -->

<div class="container mt-5">
    <h2 class="text-center">Login</h2>

    <%-- Display error message if login fails --%>
    <% String errorMessage = (String) request.getAttribute("errorMessage");
        if (errorMessage != null) { %>
    <div class="alert alert-danger">
        <%= errorMessage %>
    </div>
    <% } %>

    <form action="login" method="post" class="mt-4">
        <div class="form-group">
            <label for="username">Username:</label>
            <input type="text" class="form-control" id="username" name="username" required>
        </div>

        <div class="form-group">
            <label for="password">Password:</label>
            <input type="password" class="form-control" id="password" name="password" required>
        </div>

        <button type="submit" class="btn btn-primary">Login</button>
    </form>

    <p class="mt-3">Don't have an account? <a href="register.jsp">Register here</a></p>
</div>

<script src="https://code.jquery.com/jquery-3.5.1.slim.min.js"></script>
<script src="https://cdn.jsdelivr.net/npm/@popperjs/core@2.11.6/dist/umd/popper.min.js"></script>
<script src="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/js/bootstrap.min.js"></script>
</body>
</html>
