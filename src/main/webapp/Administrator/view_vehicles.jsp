<%@ page import="org.example.cab.Admin.model.Vehicle" %>
<%@ page import="java.util.List" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
  <title>View Vehicles</title>
  <style>
    table {
      width: 100%;
      border-collapse: collapse;
      margin-top: 20px;
    }
    th, td {
      border: 1px solid black;
      padding: 8px;
      text-align: center;
    }
    th {
      background-color: #f2f2f2;
    }
    img {
      max-width: 150px;
      height: auto;
      border-radius: 8px;
      border: 1px solid #ccc;
    }
    .no-data {
      text-align: center;
      color: red;
      font-weight: bold;
    }
  </style>
</head>
<body>

<h2>Vehicle List</h2>

<%
  List<Vehicle> vehicles = (List<Vehicle>) request.getAttribute("vehicles");
  if (vehicles == null || vehicles.isEmpty()) {
%>
<p class="no-data">No vehicles found.</p>
<%
} else {
%>

<table>
  <tr>
    <th>ID</th>
    <th>Category</th>
    <th>Number</th>
    <th>CC</th>
    <th>Engine No</th>
    <th>Photo</th>
    <th>Available</th>
    <th>Actions</th>
  </tr>
  <%
    for (Vehicle vehicle : vehicles) {
  %>
  <tr>
    <td><%= vehicle.getId() %></td>
    <td><%= vehicle.getCategory() %></td>
    <td><%= vehicle.getVehicleNumber() %></td>
    <td><%= vehicle.getCc() %></td>
    <td><%= vehicle.getEngineNo() %></td>
    <td>
      <% if (vehicle.getVehiclePhoto() != null && !vehicle.getVehiclePhoto().isEmpty()) { %>
      <img src="uploads/<%= vehicle.getVehiclePhoto() %>" alt="Vehicle Photo">
      <% } else { %>
      No Image
      <% } %>
    </td>
    <td><%= vehicle.isAvailable() ? "Yes" : "No" %></td>
    <td>
      <a href="edit_vehicle.jsp?id=<%= vehicle.getId() %>">Edit</a> |
      <a href="DeleteVehicle?id=<%= vehicle.getId() %>" onclick="return confirm('Are you sure you want to delete this vehicle?');">Delete</a>
    </td>
  </tr>
  <% } %>
</table>

<% } %>

</body>
</html>
