package org.example.cab.Admin.dao;

import java.sql.*;
import org.example.cab.Admin.model.Booking;
import org.example.cab.Admin.model.Vehicle;

public class BookingDao {

    private static final String URL = "jdbc:mysql://localhost:3306/cabs";
    private static final String USER = "root";
    private static final String PASSWORD = "";

    public boolean saveBooking(Booking booking) {
        String sql = "INSERT INTO Bookings (username, vehicle_id, driver_id, pickup_location, dropoff_location, pickup_datetime, payment_method, special_requests, created_at) "
                + "VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?)";

        try (Connection conn = DriverManager.getConnection(URL, USER, PASSWORD);
             PreparedStatement stmt = conn.prepareStatement(sql)) {

            stmt.setString(1, booking.getUsername());
            stmt.setInt(2, booking.getVehicleId());
            stmt.setInt(3, booking.getDriverId());
            stmt.setString(4, booking.getPickupLocation());
            stmt.setString(5, booking.getDropoffLocation());
            stmt.setTimestamp(6, booking.getPickupDateTime());
            stmt.setString(7, booking.getPaymentMethod());
            stmt.setString(8, booking.getSpecialRequests());
            stmt.setTimestamp(9, booking.getCreatedAt());

            int rowsAffected = stmt.executeUpdate();
            return rowsAffected > 0;

        } catch (SQLException e) {
            e.printStackTrace();
            return false;
        }
    }

    public Vehicle getVehicleById(int vehicleId) {
        Vehicle vehicle = null;
        String sql = "SELECT * FROM vehicle WHERE id = ?";

        try (Connection conn = DriverManager.getConnection(URL, USER, PASSWORD);
             PreparedStatement stmt = conn.prepareStatement(sql)) {
            stmt.setInt(1, vehicleId);
            try (ResultSet rs = stmt.executeQuery()) {
                if (rs.next()) {
                    vehicle = mapResultSetToVehicle(rs);
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return vehicle;
    }

    public boolean insertBooking(String username, int vehicleId, int driverId, String pickupLocation, String dropoffLocation, Timestamp pickupDateTime, String paymentMethod, String specialRequests) {
        String sql = "INSERT INTO Bookings (username, vehicle_id, driver_id, pickup_location, dropoff_location, pickup_datetime, payment_method, special_requests, created_at) "
                + "VALUES (?, ?, ?, ?, ?, ?, ?, ?, NOW())";

        try (Connection conn = DriverManager.getConnection(URL, USER, PASSWORD);
             PreparedStatement stmt = conn.prepareStatement(sql)) {

            stmt.setString(1, username);
            stmt.setInt(2, vehicleId);
            stmt.setInt(3, driverId);
            stmt.setString(4, pickupLocation);
            stmt.setString(5, dropoffLocation);
            stmt.setTimestamp(6, pickupDateTime);
            stmt.setString(7, paymentMethod);
            stmt.setString(8, specialRequests);

            int rowsAffected = stmt.executeUpdate();
            return rowsAffected > 0;

        } catch (SQLException e) {
            e.printStackTrace();
            return false;
        }
    }


    private Vehicle mapResultSetToVehicle(ResultSet rs) throws SQLException {
        Vehicle vehicle = new Vehicle();
        vehicle.setId(rs.getInt("id"));
        vehicle.setCategory(rs.getString("category"));
        vehicle.setVehicleNumber(rs.getString("vehicle_number"));
        vehicle.setCc(String.valueOf(rs.getInt("cc")));
        vehicle.setEngineNo(rs.getString("engine_no"));
        vehicle.setVehiclePhoto(rs.getString("vehicle_photo"));
        vehicle.setAvailable(rs.getBoolean("available"));
        vehicle.setFuelType(rs.getString("fuel_type"));
        vehicle.setSeatCapacity(rs.getInt("seat_capacity"));
        vehicle.setRentalPrice(rs.getDouble("rental_price"));
        vehicle.setDriverId(rs.getInt("driver_id"));
        vehicle.setVehicle_model_name(rs.getString("vehicle_model_name"));
        return vehicle;
    }
}