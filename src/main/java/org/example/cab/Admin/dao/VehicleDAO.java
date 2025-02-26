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
            stmt.setInt(10, vehicle.getDriverId());
            return stmt.executeUpdate() > 0;
        } catch (SQLException e) {
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
            stmt.setInt(10, vehicle.getDriverId());
            stmt.setInt(11, vehicle.getId());
            return stmt.executeUpdate() > 0;
        } catch (SQLException e) {
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
            e.printStackTrace();
        }
        return false;
    }

    // Get all vehicles
    public List<Vehicle> getAllVehicles() {
        List<Vehicle> vehicles = new ArrayList<>();
        String sql = "SELECT * FROM vehicle";
        try (Connection conn = DriverManager.getConnection(URL, USER, PASSWORD);
             PreparedStatement stmt = conn.prepareStatement(sql);
             ResultSet rs = stmt.executeQuery()) {
            while (rs.next()) {
                vehicles.add(mapResultSetToVehicle(rs));
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return vehicles;
    }

    // Get vehicle by ID
    public Vehicle getVehicleById(int id) {
        String sql = "SELECT * FROM vehicle WHERE id=?";
        try (Connection conn = DriverManager.getConnection(URL, USER, PASSWORD);
             PreparedStatement stmt = conn.prepareStatement(sql)) {
            stmt.setInt(1, id);
            ResultSet rs = stmt.executeQuery();
            if (rs.next()) {
                return mapResultSetToVehicle(rs);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return null;
    }

    // Get vehicles by category
    public List<Vehicle> getVehiclesByCategory(String category) {
        List<Vehicle> vehicles = new ArrayList<>();
        String sql = "SELECT * FROM vehicle WHERE category=?";
        try (Connection conn = DriverManager.getConnection(URL, USER, PASSWORD);
             PreparedStatement stmt = conn.prepareStatement(sql)) {
            stmt.setString(1, category);
            ResultSet rs = stmt.executeQuery();
            while (rs.next()) {
                vehicles.add(mapResultSetToVehicle(rs));
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return vehicles;
    }

    // Update vehicle availability
    public boolean updateVehicleAvailability(int id, boolean available) {
        String sql = "UPDATE vehicle SET available=? WHERE id=?";
        try (Connection conn = DriverManager.getConnection(URL, USER, PASSWORD);
             PreparedStatement stmt = conn.prepareStatement(sql)) {
            stmt.setBoolean(1, available);
            stmt.setInt(2, id);
            return stmt.executeUpdate() > 0;
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return false;
    }

    // Assign/change driver for a vehicle
    public boolean assignDriverToVehicle(int vehicleId, int driverId) {
        String sql = "UPDATE vehicle SET driver_id=? WHERE id=?";
        try (Connection conn = DriverManager.getConnection(URL, USER, PASSWORD);
             PreparedStatement stmt = conn.prepareStatement(sql)) {
            stmt.setInt(1, driverId);
            stmt.setInt(2, vehicleId);
            return stmt.executeUpdate() > 0;
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return false;
    }

    // Get total vehicle count
    public int getTotalVehicleCount() {
        String sql = "SELECT COUNT(*) AS total FROM vehicle";
        try (Connection conn = DriverManager.getConnection(URL, USER, PASSWORD);
             PreparedStatement stmt = conn.prepareStatement(sql);
             ResultSet rs = stmt.executeQuery()) {
            if (rs.next()) {
                return rs.getInt("total");
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return 0;
    }

    // Helper method to map ResultSet to Vehicle object
    private Vehicle mapResultSetToVehicle(ResultSet rs) throws SQLException {
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
        return vehicle;
    }
}
