package org.example.cab.customer.dao;

import org.example.cab.Admin.model.Booking;
import org.example.cab.Admin.model.Driver;

import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class BookingDAO {

    private static final String DB_URL = "jdbc:mysql://localhost:3306/cabs";
    private static final String DB_USER = "root";
    private static final String DB_PASSWORD = "";

    // Method to retrieve bookings for a specific user
    public List<Booking> getUserBookings(String username) {
        List<Booking> bookings = new ArrayList<>();
        if (username == null || username.trim().isEmpty()) {
            System.out.println("Invalid username provided.");
            return bookings;
        }

        String query = "SELECT * FROM bookings WHERE username = ? ORDER BY booking_date DESC";

        try (Connection connection = DriverManager.getConnection(DB_URL, DB_USER, DB_PASSWORD);
             PreparedStatement ps = connection.prepareStatement(query)) {

            ps.setString(1, username);
            ResultSet rs = ps.executeQuery();

            while (rs.next()) {
                Booking booking = new Booking();
                booking.setBookingId(rs.getInt("booking_id"));
                booking.setUsername(rs.getString("username"));
                booking.setDriverId(rs.getInt("driver_id"));
                booking.setVehicleId(rs.getInt("vehicle_id"));
                booking.setPickupLocation(rs.getString("pickup_location"));
                booking.setDropoffLocation(rs.getString("drop_off_location"));
                booking.setPickupDateTime(rs.getTimestamp("booking_date"));
                booking.setStatus(rs.getString("status"));
                booking.setCreatedAt(rs.getTimestamp("created_at"));
                booking.setUpdatedAt(rs.getTimestamp("updated_at"));
                booking.setSpecialRequests(rs.getString("special_needs"));
                booking.setDiscountAmount(rs.getDouble("discount_amount"));
                booking.setFinalAmount(rs.getDouble("final_amount"));

                bookings.add(booking);
            }
        } catch (SQLException e) {
            System.err.println("Error retrieving bookings for user: " + username);
            e.printStackTrace();
        }
        return bookings;
    }
    // Method to retrieve driver details based on driver_id
    public Driver getDriverDetails(int driverId) {
        Driver driver = null;
        String query = "SELECT fullName, contactNumber FROM driversss WHERE id = ?";

        try (Connection connection = DriverManager.getConnection(DB_URL, DB_USER, DB_PASSWORD);
             PreparedStatement ps = connection.prepareStatement(query)) {

            ps.setInt(1, driverId);
            ResultSet rs = ps.executeQuery();

            if (rs.next()) {
                driver = new Driver();
                driver.setFullName(rs.getString("fullName"));
                driver.setContactNumber(rs.getString("contactNumber"));
            }
        } catch (SQLException e) {
            System.err.println("Error retrieving driver details for driver ID: " + driverId);
            e.printStackTrace();
        }
        return driver;
    }
    // Method to delete a booking by bookingId
    public boolean deleteBooking(int bookingId) {
        String query = "DELETE FROM bookings WHERE booking_id = ?";

        try (Connection connection = DriverManager.getConnection(DB_URL, DB_USER, DB_PASSWORD);
             PreparedStatement ps = connection.prepareStatement(query)) {

            ps.setInt(1, bookingId);
            int rowsAffected = ps.executeUpdate();
            return rowsAffected > 0;  // Return true if at least one row was deleted
        } catch (SQLException e) {
            System.err.println("Error deleting booking with ID: " + bookingId);
            e.printStackTrace();
            return false;
        }
    }


}
