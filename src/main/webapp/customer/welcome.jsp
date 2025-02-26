<%@ page import="org.example.cab.customer.model.User" %>
<%@ page import="jakarta.servlet.http.HttpSession" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html>
<head>
    <title>Cab Service Dashboard</title>
    <style>
        body {
            font-family: Arial, sans-serif;
            margin: 0;
            padding: 0;
            background-color: #f4f4f4;
        }
        .navbar {
            background-color: #333;
            overflow: hidden;
            padding: 15px 20px;
            display: flex;
            justify-content: space-between;
            align-items: center;
        }
        .navbar h2 {
            color: white;
            margin: 0;
        }
        .navbar a {
            color: white;
            padding: 12px 20px;
            text-decoration: none;
            font-size: 16px;
        }
        .navbar a:hover {
            background-color: #575757;
            border-radius: 5px;
        }
        .container {
            text-align: center;
            padding: 20px;
        }
        .card-container {
            display: flex;
            justify-content: center;
            flex-wrap: wrap;
            margin-top: 30px;
        }
        .card {
            background: white;
            padding: 20px;
            margin: 15px;
            border-radius: 8px;
            box-shadow: 0px 4px 6px rgba(0, 0, 0, 0.1);
            width: 250px;
            text-align: center;
        }
        .card h3 {
            margin-bottom: 15px;
            color: #333;
        }
        .btn {
            display: inline-block;
            padding: 10px 15px;
            background: #007BFF;
            color: white;
            text-decoration: none;
            border-radius: 5px;
        }
        .btn:hover {
            background: #0056b3;
        }
        .logout {
            background-color: red;
        }
        .logout:hover {
            background-color: darkred;
        }
    </style>
</head>
<body>
<%
    HttpSession sessionObj = request.getSession(false);
    if (sessionObj == null || sessionObj.getAttribute("user") == null) {
        response.sendRedirect(request.getContextPath() + "/customer/login.jsp");
        return;
    }
    User user = (User) sessionObj.getAttribute("user");
%>

<div class="navbar">
    <h2>Cab Service Dashboard</h2>
    <div>
        <a href="#">Home</a>
        <a href="#">About Us</a>
        <a href="#">Book a Ride</a>
        <a href="#">Ride History</a>
        <a href="#">Profile</a>
        <a class="btn logout" href="<%= request.getContextPath() %>/customer/login.jsp">Logout</a>
    </div>
</div>

<div class="container">
    <h1>Welcome, <%= user.getUsername() %>!</h1>
    <p>Your email: <%= user.getEmail() %></p>

    <div class="card-container">
        <div class="card">
            <h3>Book a Ride</h3>
            <p>Request a ride to your destination.</p>
            <a href="index.jsp" class="btn">Book Now</a>
        </div>

        <div class="card">
            <h3>Ride History</h3>
            <p>View your previous trips and receipts.</p>
            <a href="rideHistory.jsp" class="btn">View History</a>
        </div>

        <div class="card">
            <h3>Profile</h3>
            <p>Manage your account and settings.</p>
            <a href="profile.jsp" class="btn">View Profile</a>
        </div>
    </div>
</div>

</body>
</html>
