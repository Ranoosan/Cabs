package org.example.cab.Admin.dao;

import org.example.cab.Admin.model.Vehicle;
import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class VehicleDAO {
    private static final String URL = "jdbc:mysql://localhost:3306/cabs";
    private static final String USER = "root";
    private static final String PASSWORD = "";

    // Add a new vehicle
    public boolean addVehicle(Vehicle vehicle) {
        String sql = "INSERT INTO vehicle (category, vehicle_number, cc, engine_no, vehicle_photo, available, fuel_type, seat_capacity, rental_price, driver_id) VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, ?)";
        try (Connection conn = DriverManager.getConnection(URL, USER, PASSWORD);
             PreparedStatement stmt = conn.prepareStatement(sql)) {

            stmt.setString(1, vehicle.getCategory());
            stmt.setString(2, vehicle.getVehicleNumber());
            stmt.setString(3, vehicle.getCc());
            stmt.setString(4, vehicle.getEngineNo());
            stmt.setString(5, vehicle.getVehiclePhoto());
            stmt.setBoolean(6, vehicle.isAvailable());
            stmt.setString(7, vehicle.getFuelType());
            stmt.setInt(8, vehicle.getSeatCapacity());
            stmt.setDouble(9, vehicle.getRentalPrice());
            stmt.setInt(10, vehicle.getDriverId()); // Set driver ID

            return stmt.executeUpdate() > 0;
        } catch (SQLException e) {
            System.err.println("Error adding vehicle: " + e.getMessage());
            e.printStackTrace();
        }
        return false;
    }

    // Update an existing vehicle
    public boolean updateVehicle(Vehicle vehicle) {
        String sql = "UPDATE vehicle SET category=?, vehicle_number=?, cc=?, engine_no=?, vehicle_photo=?, available=?, fuel_type=?, seat_capacity=?, rental_price=?, driver_id=? WHERE id=?";
        try (Connection conn = DriverManager.getConnection(URL, USER, PASSWORD);
             PreparedStatement stmt = conn.prepareStatement(sql)) {

            stmt.setString(1, vehicle.getCategory());
            stmt.setString(2, vehicle.getVehicleNumber());
            stmt.setString(3, vehicle.getCc());
            stmt.setString(4, vehicle.getEngineNo());
            stmt.setString(5, vehicle.getVehiclePhoto());
            stmt.setBoolean(6, vehicle.isAvailable());
            stmt.setString(7, vehicle.getFuelType());
            stmt.setInt(8, vehicle.getSeatCapacity());
            stmt.setDouble(9, vehicle.getRentalPrice());
            stmt.setInt(10, vehicle.getDriverId()); // Set driver ID
            stmt.setInt(11, vehicle.getId());

            return stmt.executeUpdate() > 0;
        } catch (SQLException e) {
            System.err.println("Error updating vehicle: " + e.getMessage());
            e.printStackTrace();
        }
        return false;
    }

    // Delete a vehicle by ID
    public boolean deleteVehicle(int id) {
        String sql = "DELETE FROM vehicle WHERE id=?";
        try (Connection conn = DriverManager.getConnection(URL, USER, PASSWORD);
             PreparedStatement stmt = conn.prepareStatement(sql)) {

            stmt.setInt(1, id);
            return stmt.executeUpdate() > 0;
        } catch (SQLException e) {
            System.err.println("Error deleting vehicle: " + e.getMessage());
            e.printStackTrace();
        }
        return false;
    }

    // Get all vehicles
    public List<Vehicle> getAllVehicles() {
        List<Vehicle> vehicles = new ArrayList<>();
        String sql = "SELECT id, category, vehicle_number, cc, engine_no, vehicle_photo, available, fuel_type, seat_capacity, rental_price, driver_id FROM vehicle";

        try (Connection conn = DriverManager.getConnection(URL, USER, PASSWORD);
             PreparedStatement stmt = conn.prepareStatement(sql);
             ResultSet rs = stmt.executeQuery()) {

            while (rs.next()) {
                Vehicle vehicle = new Vehicle();
                vehicle.setId(rs.getInt("id"));
                vehicle.setCategory(rs.getString("category"));
                vehicle.setVehicleNumber(rs.getString("vehicle_number"));
                vehicle.setCc(rs.getString("cc"));
                vehicle.setEngineNo(rs.getString("engine_no"));
                vehicle.setVehiclePhoto(rs.getString("vehicle_photo"));
                vehicle.setAvailable(rs.getBoolean("available"));
                vehicle.setFuelType(rs.getString("fuel_type"));
                vehicle.setSeatCapacity(rs.getInt("seat_capacity"));
                vehicle.setRentalPrice(rs.getDouble("rental_price"));
                vehicle.setDriverId(rs.getInt("driver_id"));
                vehicles.add(vehicle);
            }
        } catch (SQLException e) {
            System.err.println("Error retrieving vehicle list: " + e.getMessage());
            e.printStackTrace();
        }
        return vehicles;
    }

    // Get vehicle photo by ID
    public String getVehiclePhotoById(int id) {
        String sql = "SELECT vehicle_photo FROM vehicle WHERE id=?";
        try (Connection conn = DriverManager.getConnection(URL, USER, PASSWORD);
             PreparedStatement stmt = conn.prepareStatement(sql)) {

            stmt.setInt(1, id);
            ResultSet rs = stmt.executeQuery();

            if (rs.next()) {
                return rs.getString("vehicle_photo");
            }
        } catch (SQLException e) {
            System.err.println("Error retrieving vehicle photo: " + e.getMessage());
            e.printStackTrace();
        }
        return null;
    }
}
