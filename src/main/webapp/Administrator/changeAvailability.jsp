<%@ page import="org.example.cab.Admin.dao.VehicleDAO" %>
<%@ page import="org.example.cab.Admin.model.Vehicle" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>

<%
    int vehicleId = Integer.parseInt(request.getParameter("id")); // Get vehicle ID
    VehicleDAO vehicleDAO = new VehicleDAO();
    Vehicle vehicle = vehicleDAO.getVehicleById(vehicleId);
%>

<html>
<head>
    <title>Change Vehicle Availability</title>
    <style>
        body { font-family: Arial, sans-serif; }
        .container {
            width: 40%;
            margin: auto;
            padding: 20px;
            border: 1px solid #ccc;
            border-radius: 5px;
            box-shadow: 2px 2px 12px rgba(0, 0, 0, 0.1);
            text-align: center;
        }
        select {
            width: 100%;
            padding: 10px;
            margin: 10px 0;
            border: 1px solid #ccc;
            border-radius: 4px;
        }
        button {
            background-color: #28a745;
            color: white;
            padding: 10px;
            border: none;
            border-radius: 4px;
            cursor: pointer;
        }
        button:hover { background-color: #218838; }
    </style>
</head>
<body>

<div class="container">
    <h2>Change Vehicle Availability</h2>
    <form action="ChangeAvailabilityServlet" method="post">
        <input type="hidden" name="id" value="<%= vehicle.getId() %>">

        <label for="available">Available:</label>
        <select id="available" name="available">
            <option value="true" <%= vehicle.isAvailable() ? "selected" : "" %>>Yes</option>
            <option value="false" <%= !vehicle.isAvailable() ? "selected" : "" %>>No</option>
        </select>

        <button type="submit">Update Availability</button>
    </form>
</div>

</body>
</html>
