<%@ page import="org.example.cab.Admin.model.Driver" %>
<%@ page import="java.util.List" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>Add Vehicle</title>
    <style>
        /* Add your CSS styles here */
    </style>
</head>
<body>

<h2>Add Vehicle</h2>

<form action="AddVehicleServlet" method="post" enctype="multipart/form-data">
    <label for="category">Category:</label>
    <input type="text" name="category" required><br><br>

    <label for="vehicle_number">Vehicle Number:</label>
    <input type="text" name="vehicle_number" required><br><br>

    <label for="cc">CC:</label>
    <input type="text" name="cc" required><br><br>

    <label for="engine_no">Engine No:</label>
    <input type="text" name="engine_no" required><br><br>

    <label for="vehicle_photo">Vehicle Photo:</label>
    <input type="file" name="vehicle_photo" required><br><br>

    <label for="available">Available:</label>
    <select name="available">
        <option value="true">Yes</option>
        <option value="false">No</option>
    </select><br><br>

    <label for="fuel_type">Fuel Type:</label>
    <input type="text" name="fuel_type" required><br><br>

    <label for="seat_capacity">Seat Capacity:</label>
    <input type="number" name="seat_capacity" required><br><br>

    <label for="rental_price">Rental Price:</label>
    <input type="number" name="rental_price" required step="0.01"><br><br>

    <label for="driver_id">Assign Driver:</label>
    <select name="driver_id">
        <%
            // Assuming you have a DriverDAO to fetch drivers
            DriverDAO driverDAO = new DriverDAO();
            List<Driver> drivers = driverDAO.getAllDrivers();
            for (Driver driver : drivers) {
        %>
        <option value="<%= driver.getId() %>"><%= driver.getFullName() %></option>
        <% } %>
    </select><br><br>

    <input type="submit" value="Add Vehicle">
</form>

</body>
</html>
