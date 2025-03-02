<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" import="java.sql.*" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Manage Bookings & Vehicles</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
</head>
<body>

<div class="container mt-4">
    <h2 class="text-center">Manage Bookings & Vehicles</h2>

    <!-- Booking Table -->
    <h4 class="mt-4">Bookings</h4>
    <table class="table table-bordered">
        <thead>
        <tr>
            <th>Booking ID</th>
            <th>Username</th>
            <th>Pickup Location</th>
            <th>Drop-Off Location</th>
            <th>Booking Date</th>
            <th>Status</th>
            <th>Action</th>
        </tr>
        </thead>
        <tbody>
        <%
            Connection con = null;
            PreparedStatement ps = null;
            ResultSet rs = null;
            String url = "jdbc:mysql://localhost:3306/cabs";
            String user = "root";
            String pass = "";

            try {
                Class.forName("com.mysql.cj.jdbc.Driver");
                con = DriverManager.getConnection(url, user, pass);

                if (request.getParameter("update_booking") != null) {
                    int bookingId = Integer.parseInt(request.getParameter("booking_id"));
                    String status = request.getParameter("status");
                    ps = con.prepareStatement("UPDATE bookings SET status = ? WHERE booking_id = ?");
                    ps.setString(1, status);
                    ps.setInt(2, bookingId);
                    ps.executeUpdate();
                    out.println("<script>alert('Booking status updated successfully!');</script>");
                }

                // Fetch bookings
                ps = con.prepareStatement("SELECT booking_id, username, pickup_location, drop_off_location, booking_date, status FROM bookings");
                rs = ps.executeQuery();
                while (rs.next()) {
        %>
        <tr>
            <td><%= rs.getInt("booking_id") %></td>
            <td><%= rs.getString("username") %></td>
            <td><%= rs.getString("pickup_location") %></td>
            <td><%= rs.getString("drop_off_location") %></td>
            <td><%= rs.getDate("booking_date") %></td>
            <td>
                <form method="post">
                    <input type="hidden" name="booking_id" value="<%= rs.getInt("booking_id") %>">
                    <select name="status" class="form-select">
                        <option value="Pending" <%= rs.getString("status").equals("Pending") ? "selected" : "" %>>Pending</option>
                        <option value="Cancelled" <%= rs.getString("status").equals("Cancelled") ? "selected" : "" %>>Cancelled</option>
                        <option value="Completed" <%= rs.getString("status").equals("Completed") ? "selected" : "" %>>Completed</option>
                    </select>
                    <button type="submit" name="update_booking" class="btn btn-primary btn-sm mt-2">Update</button>
                </form>
            </td>
        </tr>
        <%
                }
            } catch (Exception e) {
                e.printStackTrace();
            }
        %>
        </tbody>
    </table>

    <!-- Vehicle Table -->
    <h4 class="mt-4">Vehicles</h4>
    <table class="table table-bordered">
        <thead>
        <tr>
            <th>Vehicle ID</th>
            <th>Category</th>
            <th>Vehicle Number</th>
            <th>Fuel Type</th>
            <th>Seat Capacity</th>
            <th>Rental Price</th>
            <th>Available</th>
            <th>Action</th>
        </tr>
        </thead>
        <tbody>
        <%
            if (request.getParameter("update_vehicle") != null) {
                int vehicleId = Integer.parseInt(request.getParameter("id"));
                String available = request.getParameter("status"); // Case-sensitive fix

                // Debugging
                out.println("Vehicle ID: " + vehicleId);
                out.println("Availability: " + available);

                ps = con.prepareStatement("UPDATE vehicle SET status = ? WHERE id = ?"); // Use correct column case
                ps.setString(1, available);
                ps.setInt(2, vehicleId);
                try {
                    ps.executeUpdate();
                    out.println("<script>alert('Vehicle availability updated successfully!');</script>");
                } catch (SQLException e) {
                    out.println("<script>alert('Error updating vehicle: " + e.getMessage() + "');</script>");
                }
            }

            ps = con.prepareStatement("SELECT id, category, vehicle_number, fuel_type, seat_capacity, rental_price, status FROM vehicle");
            rs = ps.executeQuery();
            while (rs.next()) {
        %>
        <tr>
            <td><%= rs.getInt("id") %></td>
            <td><%= rs.getString("category") %></td>
            <td><%= rs.getString("vehicle_number") %></td>
            <td><%= rs.getString("fuel_type") %></td>
            <td><%= rs.getInt("seat_capacity") %></td>
            <td>$<%= rs.getDouble("rental_price") %></td>
            <td>
                <form method="post">
                    <input type="hidden" name="id" value="<%= rs.getInt("id") %>">
                    <select name="status" class="form-select">
                        <option value="Available" <%= rs.getString("status").equals("Available") ? "selected" : "" %>>Available</option>
                        <option value="Non-Available" <%= rs.getString("status").equals("Non-Available") ? "selected" : "" %>>Non-Available</option>
                    </select>
                    <button type="submit" name="update_vehicle" class="btn btn-primary btn-sm mt-2">Update</button>
                </form>
            </td>
        </tr>
        <%
            }
            if (rs != null) rs.close();
            if (ps != null) ps.close();
            if (con != null) con.close();
        %>
        </tbody>
    </table>

</div>

</body>
</html>
