<%@ page import="org.example.cab.Admin.dao.DriverDAO" %>
<%@ page import="org.example.cab.Admin.model.Driver" %>
<%@ page import="java.util.List" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>Add Vehicle</title>
    <style>
        body {
            font-family: Arial, sans-serif;
        }
        .container {
            width: 50%;
            margin: auto;
            padding: 20px;
            border: 1px solid #ccc;
            border-radius: 5px;
            box-shadow: 2px 2px 12px rgba(0, 0, 0, 0.1);
        }
        label {
            font-weight: bold;
        }
        input, select {
            width: 100%;
            padding: 8px;
            margin: 5px 0;
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
        button:hover {
            background-color: #218838;
        }
    </style>
</head>
<body>

<div class="container">
    <h2>Add New Vehicle</h2>
    <form action="AddVehicleServlet" method="post" enctype="multipart/form-data">
        <label for="category">Vehicle Category:</label>
        <select id="category" name="category" required>
            <option value="Car">Car</option>
            <option value="Van">Van</option>
            <option value="Auto">Auto</option>
            <option value="Bike">Bike</option>
        </select>

        <label for="vehicle_model_name">Vehicle Model Name:</label>
        <input type="text" id="vehicle_model_name" name="vehicle_model_name" required>

        <label for="vehicle_number">Vehicle Number:</label>
        <input type="text" id="vehicle_number" name="vehicle_number" required>

        <label for="cc">CC:</label>
        <input type="text" id="cc" name="cc" required>

        <label for="engine_no">Engine Number:</label>
        <input type="text" id="engine_no" name="engine_no" required>

        <label for="fuel_type">Fuel Type:</label>
        <select id="fuel_type" name="fuel_type" required>
            <option value="Petrol">Petrol</option>
            <option value="Diesel">Diesel</option>
            <option value="Electric">Electric</option>
            <option value="Hybrid">Hybrid</option>
        </select>

        <label for="seat_capacity">Seat Capacity:</label>
        <input type="number" id="seat_capacity" name="seat_capacity" required>

        <label for="rental_price">Rental Price (LKR):</label>
        <input type="text" id="rental_price" name="rental_price" required>

        <label for="available">Available:</label>
        <select id="available" name="available">
            <option value="true">Yes</option>
            <option value="false">No</option>
        </select>

        <label for="driver_id">Assign Driver:</label>
        <select id="driver_id" name="driver_id" required>
            <option value="">Select Driver</option>
            <%
                try {
                    DriverDAO driverDAO = new DriverDAO();
                    List<Driver> drivers = driverDAO.getAllDrivers();
                    for (Driver driver : drivers) {
            %>
            <option value="<%= driver.getId() %>"><%= driver.getFullName() %> (ID: <%= driver.getId() %>)</option>
            <%
                    }
                } catch (Exception e) {
                    out.println("<option value=''>Error fetching drivers</option>");
                }
            %>
        </select>

        <label for="vehicle_photo">Vehicle Photo:</label>
        <input type="file" id="vehicle_photo" name="vehicle_photo" accept="image/*" required>

        <button type="submit">Add Vehicle</button>
    </form>
</div>

</body>
</html>
