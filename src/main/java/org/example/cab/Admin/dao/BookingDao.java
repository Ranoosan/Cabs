package org.example.cab.Admin.dao;

import java.sql.*;
import java.util.ArrayList;
import java.util.List;
import org.example.cab.Admin.model.Booking;
import org.example.cab.Admin.model.Vehicle;

public class BookingDao {

    private static final String URL = "jdbc:mysql://localhost:3306/cabs";
    private static final String USER = "root";
    private static final String PASSWORD = "";

    // Method to save booking
    public boolean saveBooking(Booking booking) {
        String checkPendingSql = "SELECT COUNT(*) FROM Bookings WHERE vehicle_id = ? AND status = 'Pending'";
        String insertSql = "INSERT INTO Bookings (username, vehicle_id, driver_id, pickup_location, drop_off_location, booking_date, payment_method, special_needs, status, created_at, updated_at) "
                + "VALUES (?, ?, ?, ?, ?, ?, ?, ?, 'Active', ?, ?)";

        try (Connection conn = DriverManager.getConnection(URL, USER, PASSWORD)) {
            conn.setAutoCommit(false); // Start transaction

            // Check if there is a "Pending" booking for the vehicle
            try (PreparedStatement checkPendingStmt = conn.prepareStatement(checkPendingSql)) {
                checkPendingStmt.setInt(1, booking.getVehicleId());

                ResultSet rs = checkPendingStmt.executeQuery();
                rs.next();
                int pendingBookings = rs.getInt(1);

                if (pendingBookings > 0) {
                    System.out.println("A pending booking exists for this vehicle. Cannot proceed with a new booking.");
                    return false; // Prevent new booking if there's a pending one
                }
            }

            // Insert the new booking as "Active"
            try (PreparedStatement insertStmt = conn.prepareStatement(insertSql)) {
                insertStmt.setString(1, booking.getUsername());
                insertStmt.setInt(2, booking.getVehicleId());
                insertStmt.setInt(3, booking.getDriverId());
                insertStmt.setString(4, booking.getPickupLocation());
                insertStmt.setString(5, booking.getDropoffLocation());
                insertStmt.setTimestamp(6, booking.getPickupDateTime());
                insertStmt.setString(7, booking.getPaymentMethod());
                insertStmt.setString(8, booking.getSpecialRequests());
                insertStmt.setTimestamp(9, booking.getCreatedAt());
                insertStmt.setTimestamp(10, new Timestamp(System.currentTimeMillis())); // Set updated_at

                int rowsAffected = insertStmt.executeUpdate();
                if (rowsAffected > 0) {
                    conn.commit(); // Commit transaction if everything is successful
                    return true;
                }
            }

            conn.rollback(); // Rollback in case of failure
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return false;
    }

    // Method to get a vehicle by ID
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

    // Method to get all bookings
    public List<Booking> getAllBookings() {
        List<Booking> bookings = new ArrayList<>();
        String sql = "SELECT * FROM bookings";

        try (Connection conn = DriverManager.getConnection(URL, USER, PASSWORD);
             Statement stmt = conn.createStatement();
             ResultSet rs = stmt.executeQuery(sql)) {

            while (rs.next()) {
                Booking booking = new Booking();
                booking.setBookingId(rs.getInt("booking_id"));
                booking.setUsername(rs.getString("username"));
                booking.setDriverId(rs.getInt("driver_id"));
                booking.setVehicleId(rs.getInt("vehicle_id"));
                booking.setPickupLocation(rs.getString("pickup_location"));
                booking.setDropoffLocation(rs.getString("dropoff_location"));
                booking.setPickupDateTime(rs.getTimestamp("pickup_datetime"));
                booking.setPaymentMethod(rs.getString("payment_method"));
                booking.setSpecialRequests(rs.getString("special_requests"));
                booking.setStatus(rs.getString("status"));
                booking.setCreatedAt(rs.getTimestamp("created_at"));
                booking.setUpdatedAt(rs.getTimestamp("updated_at"));
                bookings.add(booking);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }

        return bookings;
    }

    // Method to update booking status
    public boolean updateBookingStatus(int bookingId, String status) {
        String sql = "UPDATE bookings SET status = ?, updated_at = NOW() WHERE booking_id = ?";

        try (Connection conn = DriverManager.getConnection(URL, USER, PASSWORD);
             PreparedStatement stmt = conn.prepareStatement(sql)) {

            stmt.setString(1, status);
            stmt.setInt(2, bookingId);

            int rowsAffected = stmt.executeUpdate();
            return rowsAffected > 0;

        } catch (SQLException e) {
            e.printStackTrace();
        }
        return false;
    }

    // Method to get all vehicles
    public List<Vehicle> getAllVehicles() {
        List<Vehicle> vehicles = new ArrayList<>();
        String sql = "SELECT * FROM vehicle";

        try (Connection conn = DriverManager.getConnection(URL, USER, PASSWORD);
             Statement stmt = conn.createStatement();
             ResultSet rs = stmt.executeQuery(sql)) {

            while (rs.next()) {
                Vehicle vehicle = mapResultSetToVehicle(rs);
                vehicles.add(vehicle);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }

        return vehicles;
    }

    // Method to update vehicle status
    public boolean updateVehicleStatus(int vehicleId, String status) {
        String sql = "UPDATE vehicle SET status = ?, updated_at = NOW() WHERE id = ?";

        try (Connection conn = DriverManager.getConnection(URL, USER, PASSWORD);
             PreparedStatement stmt = conn.prepareStatement(sql)) {

            stmt.setString(1, status);
            stmt.setInt(2, vehicleId);

            int rowsAffected = stmt.executeUpdate();
            return rowsAffected > 0;

        } catch (SQLException e) {
            e.printStackTrace();
        }
        return false;
    }

    // Method to map ResultSet to Vehicle object
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

    // Method to get drivers by vehicle category
    public List<String> getDriversByVehicleCategory(String category) {
        List<String> drivers = new ArrayList<>();
        String sql = "SELECT d.id, d.username " +
                "FROM driversss d " +
                "JOIN booking b ON b.driver_id = d.id " + // Join booking to get the driver_id
                "JOIN vehicle v ON b.vehicle_id = v.id " + // Join vehicle to get vehicle_id
                "WHERE v.vehicleType = ?"; // Match the vehicleType with category

        try (Connection conn = DriverManager.getConnection(URL, USER, PASSWORD);
             PreparedStatement stmt = conn.prepareStatement(sql)) {

            stmt.setString(1, category); // Set the vehicle category (from the vehicle table)

            try (ResultSet rs = stmt.executeQuery()) {
                while (rs.next()) {
                    // Add the driver username to the list of available drivers
                    drivers.add(rs.getString("username"));
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }

        return drivers;
    }

    // Method to update the driver of a booking
    public boolean updateBookingDriver(int bookingId, int newDriverId) {
        String sql = "UPDATE bookings SET driver_id = ? WHERE booking_id = ?";

        try (Connection conn = DriverManager.getConnection(URL, USER, PASSWORD);
             PreparedStatement stmt = conn.prepareStatement(sql)) {

            stmt.setInt(1, newDriverId);
            stmt.setInt(2, bookingId);

            int rowsAffected = stmt.executeUpdate();
            return rowsAffected > 0;

        } catch (SQLException e) {
            e.printStackTrace();
        }
        return false;
    }
}
