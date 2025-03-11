<%@ page import="org.example.cab.customer.model.User" %>
<%@ page import="jakarta.servlet.http.HttpSession" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html>
<head>
    <title>Cab Service Dashboard</title>
    <style>
        body {
            font-family: 'Roboto', sans-serif;
            background-color: #e0f0f6; /* Lighter shade of the navbar color */
            margin: 0;
            padding: 0;
        }
        .navbar {
            position: sticky;
            top: 0;
            background: linear-gradient(to right, #1d72b8, #ff5f6d);
            padding: 15px 20px;
            display: flex;
            justify-content: space-between;
            align-items: center;
        }
        .navbar a {
            color: white;
            padding: 12px 20px;
            font-size: 16px;
            text-decoration: none;
            margin: 0 10px;
        }
        .navbar a:hover {
            background-color: #222;
            border-radius: 5px;
            transition: background-color 0.3s ease;
        }
        .card-container {
            display: flex;
            justify-content: center;
            margin-top: 30px;
            flex-wrap: wrap;
        }
        .card {
            background: white;
            padding: 25px;
            margin: 15px;
            border-radius: 10px;
            box-shadow: 0 4px 12px rgba(0, 0, 0, 0.1);
            width: 240px;
            text-align: center;
            transition: transform 0.3s ease, box-shadow 0.3s ease;
        }
        .card:hover {
            transform: scale(1.05);
            box-shadow: 0 8px 24px rgba(0, 0, 0, 0.2);
        }
        .btn {
            background: #007BFF;
            color: white;
            text-decoration: none;
            padding: 12px 20px;
            border-radius: 5px;
            font-size: 16px;
            transition: background 0.3s ease;
        }
        .btn:hover {
            background: #0056b3;
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
        <a href="welcome.jsp">Home</a>
        <a href="about.jsp">About Us</a>
<%--        <a href="#">Book a Ride</a>--%>
<%--        <a href="#">Ride History</a>--%>
<%--        <a href="profile.jsp">Profile</a>--%>
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
            <a href="welcome.jsp" class="btn">Book Now</a>
        </div>

        <div class="card">
            <h3>Ride History</h3>
            <p>View your previous trips and receipts.</p>
            <a href="view_cus_vehicle.jsp" class="btn">View vehicles</a>
        </div>

        <div class="card">
            <h3>Ride History</h3>
            <p>View your previous trips and receipts.</p>
            <a href="make_booking.jsp" class="btn">Book  vehicles</a>
        </div>

        <div class="card">
            <h3>Profile</h3>
            <p>Manage your Bookings.</p>
            <a href="user_bookings.jsp" class="btn">View Profile</a>
        </div>
    </div>
</div>

</body>
</html>
