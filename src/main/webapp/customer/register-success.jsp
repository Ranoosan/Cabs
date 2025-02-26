<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="org.example.cab.customer.controller.RegisterServlet" %>
<%@ page import="org.example.cab.customer.dao.UserDAO" %>
<%@ page import="org.example.cab.customer.model.User" %>
<html>
<head>
    <title>Registration Success</title>
</head>
<body>
<h2>Registration Successful!</h2>
<p>Welcome, <%= ((User) request.getAttribute("user")).getUsername() %>!</p>
</body>
</html>
